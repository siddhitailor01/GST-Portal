using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class admin_ManageTopics : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) { BindGrid(); }
    }

    private void BindGrid()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM QuizTopics ORDER BY LevelID, TopicName", conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvTopics.DataSource = dt;
            gvTopics.DataBind();
        }
    }

    protected void btnAddTopic_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtTopicName.Text)) return;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO QuizTopics (LevelID, TopicName) VALUES (@lvl, @name)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@lvl", ddlLevel.SelectedValue);
            cmd.Parameters.AddWithValue("@name", txtTopicName.Text.Trim());
            conn.Open();
            cmd.ExecuteNonQuery();
            txtTopicName.Text = "";
            BindGrid();
        }
    }

    protected void gvTopics_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvTopics.EditIndex = e.NewEditIndex;
        BindGrid();
    }

    protected void gvTopics_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvTopics.EditIndex = -1;
        BindGrid();
    }

    protected void gvTopics_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int id = Convert.ToInt32(gvTopics.DataKeys[e.RowIndex].Value);
        string name = ((TextBox)gvTopics.Rows[e.RowIndex].FindControl("txtEditTopicName")).Text;
        string lvl = ((DropDownList)gvTopics.Rows[e.RowIndex].FindControl("ddlEditLevel")).SelectedValue;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("UPDATE QuizTopics SET LevelID=@lvl, TopicName=@name WHERE TopicID=@id", conn);
            cmd.Parameters.AddWithValue("@lvl", lvl);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
            gvTopics.EditIndex = -1;
            BindGrid();
        }
    }

    protected void gvTopics_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvTopics.DataKeys[e.RowIndex].Value);
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM QuizTopics WHERE TopicID=@id", conn);
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
            BindGrid();
        }
    }
}