using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Disclaimer : System.Web.UI.Page
{
    // Connection string aapki Web.config se aayegi
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadLegalContent();
        }
    }

    private void LoadLegalContent()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                // PageSlug ke hisaab se data fetch karne ki query
                string query = "SELECT PageSlug, PageContent FROM StaticPages WHERE PageSlug IN ('disclaimer', 'terms-conditions')";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            string slug = row["PageSlug"].ToString().ToLower();
                            string content = row["PageContent"].ToString();

                            if (slug == "disclaimer")
                            {
                                litDisclaimer.Text = content;
                            }
                            else if (slug == "terms-conditions")
                            {
                                litTerms.Text = content;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Error handling - aap isse kisi log mein bhi save kar sakte hain
            litDisclaimer.Text = "<p class='text-danger'>Content load karne mein dikkat aa rahi hai. Kripya baad mein koshish karein.</p>";
        }
    }
}