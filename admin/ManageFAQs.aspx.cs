using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class admin_ManageFAQs : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null) Response.Redirect("adminlogin.aspx");
        if (!IsPostBack) BindGrid();
    }

    // Helper for Premium UI Badges
    protected string GetCategoryClass(string category)
    {
        switch (category)
        {
            case "Penalties & Legal": return "cat-legal";
            case "Returns & Filing": return "cat-returns";
            default: return "cat-general";
        }
    }

    private void BindGrid(string search = "")
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string sql = "SELECT * FROM FAQs WHERE Question LIKE '%' + @search + '%' OR Answer LIKE '%' + @search + '%' ORDER BY CreatedDate DESC";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@search", search);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvFAQs.DataSource = dt;
            gvFAQs.DataBind();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e) { BindGrid(txtSearch.Text.Trim()); }

    protected void btnSaveFAQ_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtQuestion.Text) || string.IsNullOrWhiteSpace(txtAnswer.Text)) return;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string sql = "INSERT INTO FAQs (Category, Question, Answer, CreatedDate, IsActive) VALUES (@cat, @q, @a, GETDATE(), 1)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@cat", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@q", txtQuestion.Text.Trim());
            cmd.Parameters.AddWithValue("@a", txtAnswer.Text.Trim());

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        txtQuestion.Text = txtAnswer.Text = "";
        BindGrid();
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Solution Live ho gaya hai, Champion!');", true);
    }

    // Grid Event Fixes (Secure Parameters)
    protected void gvFAQs_RowEditing(object sender, GridViewEditEventArgs e) { gvFAQs.EditIndex = e.NewEditIndex; BindGrid(txtSearch.Text); }
    protected void gvFAQs_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) { gvFAQs.EditIndex = -1; BindGrid(txtSearch.Text); }

    protected void gvFAQs_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int id = Convert.ToInt32(gvFAQs.DataKeys[e.RowIndex].Value);
        string q = ((TextBox)gvFAQs.Rows[e.RowIndex].FindControl("txtEditQ")).Text;
        string a = ((TextBox)gvFAQs.Rows[e.RowIndex].FindControl("txtEditA")).Text;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string sql = "UPDATE FAQs SET Question=@q, Answer=@a WHERE FAQID=@id";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@q", q.Trim());
            cmd.Parameters.AddWithValue("@a", a.Trim());
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        gvFAQs.EditIndex = -1;
        BindGrid(txtSearch.Text);
    }

    protected void gvFAQs_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvFAQs.DataKeys[e.RowIndex].Value);
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM FAQs WHERE FAQID=@id", conn);
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        BindGrid();
    }
}