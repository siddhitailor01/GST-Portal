using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class admin_ManageLessons : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Security Check
        if (Session["AdminID"] == null) Response.Redirect("adminlogin.aspx");

        if (!IsPostBack)
        {
            BindTopics(1); // Default Level 1 load hoga
            BindGrid();
        }
    }

    protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selectedLevel = Convert.ToInt32(ddlLevel.SelectedValue);
        BindTopics(selectedLevel);
    }

    private void BindTopics(int levelID)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT TopicID, TopicName FROM QuizTopics WHERE LevelID = @lvl AND IsActive = 1";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@lvl", levelID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlTopic.DataSource = dt;
            ddlTopic.DataTextField = "TopicName";
            ddlTopic.DataValueField = "TopicID";
            ddlTopic.DataBind();

            ddlTopic.Items.Insert(0, new ListItem("-- Select Category --", "0"));
        }
    }

    private void BindGrid()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"SELECT L.*, T.TopicName 
                         FROM Lessons L 
                         INNER JOIN QuizTopics T ON L.TopicID = T.TopicID 
                         ORDER BY L.LevelNo DESC, L.LessonID DESC";

            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvLessons.DataSource = dt;
            gvLessons.DataBind();

            // FIX: Count logic yahan se chalega
            if (litCount != null)
            {
                litCount.Text = dt.Rows.Count.ToString();
            }
        }
    }

    protected void btnSaveLesson_Click(object sender, EventArgs e)
    {
        if (ddlTopic.SelectedValue == "0" || string.IsNullOrWhiteSpace(txtTitle.Text) || string.IsNullOrWhiteSpace(txtContent.Text))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Bhai, saari details bharna zaroori hai!');", true);
            return;
        }

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "";
            if (string.IsNullOrEmpty(hfLessonID.Value))
            {
                query = "INSERT INTO Lessons (TopicID, LevelNo, LessonTitle, LessonContent, CreatedDate) VALUES (@tid, @lvl, @title, @content, GETDATE())";
            }
            else
            {
                query = "UPDATE Lessons SET TopicID=@tid, LevelNo=@lvl, LessonTitle=@title, LessonContent=@content WHERE LessonID=@id";
            }

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@tid", ddlTopic.SelectedValue);
            cmd.Parameters.AddWithValue("@lvl", ddlLevel.SelectedValue);
            cmd.Parameters.AddWithValue("@title", txtTitle.Text.Trim());
            cmd.Parameters.AddWithValue("@content", txtContent.Text); // CKEditor raw HTML support

            if (!string.IsNullOrEmpty(hfLessonID.Value))
            {
                cmd.Parameters.AddWithValue("@id", hfLessonID.Value);
            }

            conn.Open();
            cmd.ExecuteNonQuery();

            string status = string.IsNullOrEmpty(hfLessonID.Value) ? "Publish" : "Update";
            ResetForm();
            BindGrid();

            string alertScript = "alert('Lesson " + status + " ho gaya hai, Champion!');";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", alertScript, true);
        }
    }

    protected void gvLessons_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditLesson")
        {
            int lessonID = Convert.ToInt32(e.CommandArgument);
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Lessons WHERE LessonID = @id", conn);
                cmd.Parameters.AddWithValue("@id", lessonID);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    hfLessonID.Value = dr["LessonID"].ToString();
                    ddlLevel.SelectedValue = dr["LevelNo"].ToString();
                    
                    BindTopics(Convert.ToInt32(dr["LevelNo"]));
                    ddlTopic.SelectedValue = dr["TopicID"].ToString();

                    txtTitle.Text = dr["LessonTitle"].ToString();
                    txtContent.Text = dr["LessonContent"].ToString();

                    btnSaveLesson.Text = "Update Lesson Content";
                    // Focus shifting to top for easy editing
                    txtTitle.Focus();
                }
            }
        }
    }

    protected void gvLessons_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvLessons.DataKeys[e.RowIndex].Value);
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM Lessons WHERE LessonID=@id", conn);
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        BindGrid();
    }

    private void ResetForm()
    {
        hfLessonID.Value = "";
        txtTitle.Text = "";
        txtContent.Text = "";
        ddlTopic.SelectedIndex = 0;
        ddlLevel.SelectedIndex = 0;
        btnSaveLesson.Text = "Commit to Database";
    }
}