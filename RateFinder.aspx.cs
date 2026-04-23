using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class RateFinder : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindRates(""); // Initial load
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindRates(txtSearch.Text.Trim());
    }

    private void BindRates(string searchTerm)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            // Base Query
            string query = "SELECT * FROM GSTRates WHERE IsActive = 1";

            // Agar searchTerm khali nahi hai, tabhi filter lagao
            if (!string.IsNullOrEmpty(searchTerm))
            {
                decimal taxRate;
                bool isNumeric = decimal.TryParse(searchTerm, out taxRate);

                if (isNumeric)
                {
                    query += " AND TaxRate = @exactRate";
                }
                else
                {
                    query += " AND (HSNCode LIKE @search OR Description LIKE @search OR Category LIKE @search)";
                }
            }

            query += " ORDER BY TaxRate ASC";

            SqlCommand cmd = new SqlCommand(query, conn);

            if (!string.IsNullOrEmpty(searchTerm))
            {
                decimal taxRate;
                if (decimal.TryParse(searchTerm, out taxRate))
                {
                    cmd.Parameters.AddWithValue("@exactRate", taxRate);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@search", "%" + searchTerm + "%");
                }
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            // Display results
            rptRates.DataSource = dt;
            rptRates.DataBind();
            rptRates.Visible = dt.Rows.Count > 0;
            phNoResults.Visible = dt.Rows.Count == 0;
        }
    }
}