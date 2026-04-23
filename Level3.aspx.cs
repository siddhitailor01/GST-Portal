using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Level3 : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindLevelTopics();
        }
    }

    private void BindLevelTopics()
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // LevelID = 1 yani Basic topics
                string query = "SELECT TopicID, TopicName FROM QuizTopics WHERE LevelID = 3 AND IsActive = 1 ORDER BY CreatedDate ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptTopics.DataSource = dt;
                    rptTopics.DataBind();
                    phNoData.Visible = false;
                }
                else
                {
                    phNoData.Visible = true;
                }
            }
        }
        catch
        {
            phNoData.Visible = true;
        }
    }
}