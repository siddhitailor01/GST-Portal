using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class admin_Dashboard : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null) Response.Redirect("adminlogin.aspx");

        if (!IsPostBack)
        {
            LoadStats();
            LoadRecentQueries();
        }
    }

    private void LoadStats()
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Optimised Multi-count query
                string query = @"
                    SELECT 
                        (SELECT COUNT(*) FROM Questions) as QCount,
                        (SELECT COUNT(*) FROM Blogs) as BlogCount,
                        (SELECT COUNT(*) FROM GSTRates) as RateCount,
                        (SELECT COUNT(*) FROM ContactMessages) as QueryCount";

                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litTotalQuestions.Text = dr["QCount"].ToString();
                    litTotalBlogs.Text = dr["BlogCount"].ToString();
                    litTotalRates.Text = dr["RateCount"].ToString();
                    litPendingQueries.Text = dr["QueryCount"].ToString();
                }
            }
        }
        catch
        {
            litTotalQuestions.Text = "0"; litTotalBlogs.Text = "0";
            litTotalRates.Text = "0"; litPendingQueries.Text = "0";
        }
    }

    private void LoadRecentQueries()
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT TOP 5 FullName, InquiryType, CreatedDate FROM ContactMessages ORDER BY CreatedDate DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptRecentRequests.DataSource = dt;
                    rptRecentRequests.DataBind();
                    phEmpty.Visible = false;
                }
                else { phEmpty.Visible = true; }
            }
        }
        catch { phEmpty.Visible = true; }
    }
}