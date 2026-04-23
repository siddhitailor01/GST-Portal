using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class About : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadAllInfo();
        }
    }

    private void LoadAllInfo()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            // Humne IN clause use kiya hai taaki ek hi baar mein data aa jaye
            string query = "SELECT PageSlug, PageContent FROM StaticPages WHERE PageSlug IN ('about-us', 'mission-vision')";
            SqlCommand cmd = new SqlCommand(query, conn);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    string slug = row["PageSlug"].ToString();
                    string content = row["PageContent"].ToString();

                    if (slug == "about-us")
                    {
                        litAbout.Text = content;
                    }
                    else if (slug == "mission-vision")
                    {
                        // Agar Mission aur Vision ek hi row mein hain, toh wo yahan dikhenge
                        // Aap chahein toh inhe split kar sakte hain ya alag slug rakh sakte hain
                        litMission.Text = content;
                    }
                }
            }
            else
            {
                // Fallback content agar database khali ho
                litAbout.Text = "GST Champions is a premier learning platform based in Bhilwara.";
                litMission.Text = "To simplify GST for everyone.";
            }
        }
    }
}