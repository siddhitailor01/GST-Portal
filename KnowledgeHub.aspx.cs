using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class KnowledgeHub : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Blogs WHERE IsActive = 1 ORDER BY CreatedDate DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptBlogs.DataSource = dt;
                rptBlogs.DataBind();
            }
        }
    }


}