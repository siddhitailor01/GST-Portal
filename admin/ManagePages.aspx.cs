using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class admin_ManagePages : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null) Response.Redirect("adminlogin.aspx");
        if (!IsPostBack) LoadPageContent();
    }

    protected void ddlPages_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadPageContent();
    }

    private void LoadPageContent()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            // Pehle check karein ki slug sahi hai
            SqlCommand cmd = new SqlCommand("SELECT PageContent FROM StaticPages WHERE PageSlug = @slug", conn);
            cmd.Parameters.AddWithValue("@slug", ddlPages.SelectedValue);
            conn.Open();
            object content = cmd.ExecuteScalar();
            txtContent.Text = content != null ? content.ToString() : "";
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string contentToSave = hfContent.Value;

        // Fallback logic
        if (string.IsNullOrEmpty(contentToSave))
        {
            contentToSave = Request.Unvalidated.Form[txtContent.UniqueID];
        }

        if (string.IsNullOrEmpty(contentToSave))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Bhai, content khali nahi ho sakta!');", true);
            return;
        }

        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "UPDATE StaticPages SET PageContent = @content, LastUpdated = GETDATE() WHERE PageSlug = @slug";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@content", contentToSave);
                cmd.Parameters.AddWithValue("@slug", ddlPages.SelectedValue);

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Badhai ho! Page sync ho gaya hai.');", true);
                }
            }
        }
        catch (Exception ex)
        {
            string errorMsg = ex.Message.Replace("'", "");
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Database Error: " + errorMsg + "');", true);
        }
    }
}