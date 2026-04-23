using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class index : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStats();
            LoadLatestBlogs();
            BindFAQs();
        }
    }


    private void BindFAQs()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            // Top 6 FAQs fetch kar rahe hain jo active hain
            string query = "SELECT TOP 6 FaqID, Question, Answer,Category FROM FAQs WHERE IsActive = 1 ORDER BY CreatedDate DESC";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptFAQs.DataSource = dt;
            rptFAQs.DataBind();
        }
    }

    private void LoadStats()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            // Topic Count
            SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM QuizTopics WHERE IsActive = 1", conn);
            litTopicCount.Text = cmd1.ExecuteScalar().ToString();

            // Question Count
            SqlCommand cmd2 = new SqlCommand("SELECT COUNT(*) FROM Questions WHERE IsActive = 1", conn);
            litQuestionCount.Text = cmd2.ExecuteScalar().ToString();
        }
    }

    private void LoadLatestBlogs()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            // Sirf top 3 latest blogs uthayenge
            string query = "SELECT TOP 3 * FROM Blogs WHERE IsActive = 1 ORDER BY CreatedDate DESC";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptLatestBlogs.DataSource = dt;
            rptLatestBlogs.DataBind();
        }
    }
}