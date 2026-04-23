using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.IO;

public partial class admin_ManageBlogs : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null) Response.Redirect("adminlogin.aspx");
        if (!IsPostBack) BindGrid();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid(txtSearch.Text.Trim());
    }

    private void BindGrid(string search = "")
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            // SMART LOGIC: Search term match hone par unhe priority dein
            string query = @"SELECT * FROM Blogs 
                             WHERE (@search = '' OR Title LIKE '%' + @search + '%')
                             ORDER BY (CASE WHEN Title LIKE @search + '%' THEN 0 ELSE 1 END), CreatedDate DESC";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@search", search);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvBlogs.DataSource = dt;
            gvBlogs.DataBind();

            litTotal.Text = dt.Rows.Count.ToString();
        }
    }

    protected void btnSaveBlog_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtTitle.Text)) return;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            // SCOPE_IDENTITY use karke turant ID fetch karein image naming ke liye
            string query = @"INSERT INTO Blogs (Title, ShortDesc, Content, ImagePath, CreatedDate) 
                             VALUES (@title, @sd, @content, '', GETDATE()); 
                             SELECT SCOPE_IDENTITY();";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@title", txtTitle.Text.Trim());
            cmd.Parameters.AddWithValue("@sd", txtShortDesc.Text.Trim());
            cmd.Parameters.AddWithValue("@content", txtContent.Text.Trim());

            conn.Open();
            string newID = cmd.ExecuteScalar().ToString();

            if (fuImage.HasFile)
            {
                // Unique Naming: BlogID.jpg format for consistency
                string fileName = newID + ".jpg";
                string folderPath = Server.MapPath("~/admin/uploads/blogs/");
                if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);

                fuImage.SaveAs(Path.Combine(folderPath, fileName));

                SqlCommand updateCmd = new SqlCommand("UPDATE Blogs SET ImagePath=@img WHERE BlogID=@id", conn);
                updateCmd.Parameters.AddWithValue("@img", fileName);
                updateCmd.Parameters.AddWithValue("@id", newID);
                updateCmd.ExecuteNonQuery();
            }

            // Clean form logic
            txtTitle.Text = txtShortDesc.Text = txtContent.Text = "";
            BindGrid();
        }
    }

    // --- Grid Events Fixes ---
    protected void gvBlogs_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvBlogs.EditIndex = e.NewEditIndex;
        BindGrid(txtSearch.Text);
    }

    protected void gvBlogs_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvBlogs.EditIndex = -1;
        BindGrid(txtSearch.Text);
    }

    protected void gvBlogs_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int id = Convert.ToInt32(gvBlogs.DataKeys[e.RowIndex].Value);
        string title = ((TextBox)gvBlogs.Rows[e.RowIndex].FindControl("txtEditTitle")).Text;
        string sd = ((TextBox)gvBlogs.Rows[e.RowIndex].FindControl("txtEditShort")).Text;
        string content = ((TextBox)gvBlogs.Rows[e.RowIndex].FindControl("txtEditContent")).Text;
        FileUpload fuEdit = (FileUpload)gvBlogs.Rows[e.RowIndex].FindControl("fuEditImage");

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // 1. Image Update Logic (Secure Parameters)
            if (fuEdit.HasFile)
            {
                string fileName = id.ToString() + ".jpg";
                string folderPath = Server.MapPath("~/admin/uploads/blogs/");
                fuEdit.SaveAs(Path.Combine(folderPath, fileName));

                string imgSql = "UPDATE Blogs SET ImagePath=@img WHERE BlogID=@id";
                using (SqlCommand imgCmd = new SqlCommand(imgSql, conn))
                {
                    imgCmd.Parameters.AddWithValue("@img", fileName);
                    imgCmd.Parameters.AddWithValue("@id", id);
                    imgCmd.ExecuteNonQuery();
                }
            }

            // 2. Text Content Update Logic (Secure Parameters)
            string sql = "UPDATE Blogs SET Title=@t, ShortDesc=@s, Content=@c WHERE BlogID=@id";
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@t", title.Trim());
                cmd.Parameters.AddWithValue("@s", sd.Trim());
                cmd.Parameters.AddWithValue("@c", content.Trim());
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }

            gvBlogs.EditIndex = -1;
            BindGrid(txtSearch.Text); // Refresh Grid
        }
    }


    protected void gvBlogs_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvBlogs.DataKeys[e.RowIndex].Value);
        // Best Practice: Delete physical file to save server space
        string imgPath = Server.MapPath("~/admin/uploads/blogs/" + id + ".jpg");
        if (File.Exists(imgPath)) File.Delete(imgPath);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM Blogs WHERE BlogID=@id", conn);
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
            BindGrid();
        }
    }
}