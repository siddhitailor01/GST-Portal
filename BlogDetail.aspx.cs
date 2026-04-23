using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class BlogDetail : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["ID"] != null)
            {
                int blogID = Convert.ToInt32(Request.QueryString["ID"]);
                LoadBlogContent(blogID);
            }
            else
            {
                Response.Redirect("KnowledgeHub.aspx");
            }
        }
    }

    private void LoadBlogContent(int id)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT * FROM Blogs WHERE BlogID = @id AND IsActive = 1";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@id", id);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                litTitle.Text = row["Title"].ToString();
                litDate.Text = Convert.ToDateTime(row["CreatedDate"]).ToString("dd MMMM yyyy");
                litContent.Text = row["Content"].ToString(); // Yahan HTML Content bhi render ho jayega
                imgBlog.ImageUrl = "admin/uploads/blogs/" + row["ImagePath"].ToString();

                // SEO ke liye Page Title bhi change kar dete hain
                Page.Title = litTitle.Text + " | GST Champions";
            }
            else
            {
                Response.Redirect("KnowledgeHub.aspx");
            }
        }
    }
}