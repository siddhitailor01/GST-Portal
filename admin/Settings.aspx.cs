using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class admin_Settings : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadSEOSettings();
        }
    }

    private void LoadSEOSettings()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            // Logic: Pehli row se SEO details uthao
            string query = "SELECT TOP 1 * FROM SEOSettings";
            SqlCommand cmd = new SqlCommand(query, conn);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtTitle.Text = dr["MetaTitle"].ToString();
                txtDesc.Text = dr["MetaDescription"].ToString();
                txtKeywords.Text = dr["MetaKeywords"].ToString();
                txtAuthor.Text = dr["Author"].ToString();
                txtAnalytics.Text = dr["AnalyticsID"].ToString();
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Logic: Agar data hai toh update karein, nahi toh delete karke insert (Best practice for settings)
                string sql = @"UPDATE SEOSettings SET 
                              MetaTitle=@title, 
                              MetaDescription=@desc, 
                              MetaKeywords=@key, 
                              Author=@auth, 
                              AnalyticsID=@ana,
                              LastUpdated=GETDATE()";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@title", txtTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@desc", txtDesc.Text.Trim());
                    cmd.Parameters.AddWithValue("@key", txtKeywords.Text.Trim());
                    cmd.Parameters.AddWithValue("@auth", txtAuthor.Text.Trim());
                    cmd.Parameters.AddWithValue("@ana", txtAnalytics.Text.Trim());

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            // Success Message with Bhilwara touch
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('SEO Settings successfully update ho gayi hain, Champion!');", true);
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: Data save nahi ho paya.');", true);
        }
    }
}