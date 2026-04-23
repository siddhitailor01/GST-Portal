using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class admin_ManageRates : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null) Response.Redirect("adminlogin.aspx");
        if (!IsPostBack) BindGrid();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid(txtSearch.Text.Trim());
    }

    private void BindGrid(string search = "")
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT RateID, HSNCode, Description, TaxRate, Category FROM GSTRates";
            if (!string.IsNullOrEmpty(search))
                query += " WHERE HSNCode LIKE @search OR Description LIKE @search";
            query += " ORDER BY CreatedDate DESC";

            SqlCommand cmd = new SqlCommand(query, conn);
            if (!string.IsNullOrEmpty(search)) cmd.Parameters.AddWithValue("@search", "%" + search + "%");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvRates.DataSource = dt;
            gvRates.DataBind();
        }
    }

    protected void gvRates_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && gvRates.EditIndex == e.Row.RowIndex)
        {
            DataRowView row = (DataRowView)e.Row.DataItem;

            // 1. Tax Dropdown Bind & Set
            DropDownList ddlTax = (DropDownList)e.Row.FindControl("ddlEditTax");
            if (ddlTax != null)
            {
                ddlTax.Items.Add(new ListItem("0", "0"));
                ddlTax.Items.Add(new ListItem("5", "5"));
                ddlTax.Items.Add(new ListItem("12", "12"));
                ddlTax.Items.Add(new ListItem("18", "18"));
                ddlTax.Items.Add(new ListItem("28", "28"));

                string taxVal = Convert.ToInt32(row["TaxRate"]).ToString();
                if (ddlTax.Items.FindByValue(taxVal) != null) ddlTax.SelectedValue = taxVal;
            }

            // 2. Category Dropdown Safe Setting
            DropDownList ddlCat = (DropDownList)e.Row.FindControl("ddlEditCategory");
            if (ddlCat != null)
            {
                string catVal = row["Category"].ToString().Trim();
                // Check if value exists in list before setting
                if (ddlCat.Items.FindByValue(catVal) != null)
                    ddlCat.SelectedValue = catVal;
                else
                    ddlCat.SelectedIndex = 0; // Default set karein agar mismatch ho
            }
        }
    }

    protected void gvRates_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvRates.EditIndex = e.NewEditIndex;
        BindGrid(txtSearch.Text);
    }

    protected void gvRates_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvRates.EditIndex = -1;
        BindGrid(txtSearch.Text);
    }

    protected void gvRates_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int rateID = Convert.ToInt32(gvRates.DataKeys[e.RowIndex].Value);
        string hsn = ((TextBox)gvRates.Rows[e.RowIndex].FindControl("txtEditHSN")).Text;
        string desc = ((TextBox)gvRates.Rows[e.RowIndex].FindControl("txtEditDesc")).Text;
        string rate = ((DropDownList)gvRates.Rows[e.RowIndex].FindControl("ddlEditTax")).SelectedValue;
        string cat = ((DropDownList)gvRates.Rows[e.RowIndex].FindControl("ddlEditCategory")).SelectedValue;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "UPDATE GSTRates SET HSNCode=@hsn, Description=@desc, TaxRate=@rate, Category=@cat WHERE RateID=@id";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@hsn", hsn.Trim());
            cmd.Parameters.AddWithValue("@desc", desc.Trim());
            cmd.Parameters.AddWithValue("@rate", rate);
            cmd.Parameters.AddWithValue("@cat", cat);
            cmd.Parameters.AddWithValue("@id", rateID);
            conn.Open();
            cmd.ExecuteNonQuery();
            gvRates.EditIndex = -1;
            BindGrid(txtSearch.Text);
        }
    }

    protected void btnSaveRate_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO GSTRates (HSNCode, Description, TaxRate, Category) VALUES (@hsn, @desc, @rate, @cat)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@hsn", txtHSN.Text.Trim());
            cmd.Parameters.AddWithValue("@desc", txtDesc.Text.Trim());
            cmd.Parameters.AddWithValue("@rate", ddlTax.SelectedValue);
            cmd.Parameters.AddWithValue("@cat", ddlCategory.SelectedValue);
            conn.Open();
            cmd.ExecuteNonQuery();
            txtHSN.Text = txtDesc.Text = "";
            BindGrid();
        }
    }

    protected void gvRates_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvRates.DataKeys[e.RowIndex].Value);
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM GSTRates WHERE RateID=@id", conn);
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
            BindGrid();
        }
    }
}