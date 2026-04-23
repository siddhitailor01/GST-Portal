using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class admin_ContactQueries : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null) Response.Redirect("adminlogin.aspx");
        if (!IsPostBack) LoadQueries();
    }

    private void LoadQueries()
    {
        string searchText = txtSearch.Text.Trim();
        string filterType = ddlFilterType.SelectedValue;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            // Extra Logic: Multi-condition filtering
            string query = "SELECT * FROM ContactMessages WHERE 1=1";

            if (filterType != "All") query += " AND InquiryType = @type";
            if (!string.IsNullOrEmpty(searchText)) query += " AND (FullName LIKE @search OR Subject LIKE @search)";

            query += " ORDER BY CreatedDate DESC";

            SqlCommand cmd = new SqlCommand(query, conn);
            if (filterType != "All") cmd.Parameters.AddWithValue("@type", filterType);
            if (!string.IsNullOrEmpty(searchText)) cmd.Parameters.AddWithValue("@search", "%" + searchText + "%");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvQueries.DataSource = dt;
            gvQueries.DataBind();

            litTotal.Text = dt.Rows.Count.ToString();

            // Logic: Calculate Unread Count
            DataView dv = new DataView(dt);
            dv.RowFilter = "IsRead = 0";
            litUnreadCount.Text = dv.Count.ToString();
        }
    }

    // Filter Logic Triggers
    protected void txtSearch_TextChanged(object sender, EventArgs e) { LoadQueries(); }
    protected void ddlFilterType_SelectedIndexChanged(object sender, EventArgs e) { LoadQueries(); }
    protected void btnRefresh_Click(object sender, EventArgs e) { txtSearch.Text = ""; ddlFilterType.SelectedIndex = 0; LoadQueries(); }

    protected void gvQueries_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ViewMessage") ShowMessage(Convert.ToInt32(e.CommandArgument));
        else if (e.CommandName == "DeleteMessage") DeleteMessage(Convert.ToInt32(e.CommandArgument));
    }

    private void ShowMessage(int id)
    {
        ViewState["CurrentMessageID"] = id;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM ContactMessages WHERE MessageID = @id", conn);
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                litModalName.Text = dr["FullName"].ToString();
                litModalEmail.Text = dr["Email"].ToString();
                litModalSubject.Text = dr["Subject"].ToString();
                litModalBody.Text = dr["MessageBody"].ToString().Replace("\n", "<br/>");
                pnlModal.Visible = true;
            }
        }
    }

    protected void btnMarkRead_Click(object sender, EventArgs e)
    {
        if (ViewState["CurrentMessageID"] != null)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("UPDATE ContactMessages SET IsRead = 1 WHERE MessageID = @id", conn);
                cmd.Parameters.AddWithValue("@id", ViewState["CurrentMessageID"]);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            pnlModal.Visible = false;
            LoadQueries();
        }
    }

    private void DeleteMessage(int id)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM ContactMessages WHERE MessageID = @id", conn);
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        LoadQueries();
    }

    protected void btnClose_Click(object sender, EventArgs e) { pnlModal.Visible = false; }

    protected void gvQueries_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            bool isRead = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "IsRead"));
            if (!isRead) e.Row.CssClass = "unread-row";
        }
    }
}