using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq; // Important for Stats logic
using System.Web.UI.WebControls;

public partial class admin_ManageQuestions : System.Web.UI.Page
{
    private readonly string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null) { Response.Redirect("adminlogin.aspx"); return; }
        if (!IsPostBack) { ResetForm(); BindGrid(); }
    }

    protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e) { BindTopicsByLevel(); }

    private void BindTopicsByLevel()
    {
        ddlTopic.Items.Clear();
        ddlTopic.Items.Add(new ListItem("-- Select Topic --", "0"));
        if (ddlLevel.SelectedValue == "0") return;

        using (SqlConnection conn = new SqlConnection(connStr))
        using (SqlCommand cmd = new SqlCommand("SELECT TopicID, TopicName FROM QuizTopics WHERE LevelID = @LevelID AND IsActive = 1 ORDER BY TopicName", conn))
        {
            cmd.Parameters.Add("@LevelID", SqlDbType.Int).Value = Convert.ToInt32(ddlLevel.SelectedValue);
            conn.Open();
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read()) { ddlTopic.Items.Add(new ListItem(dr["TopicName"].ToString(), dr["TopicID"].ToString())); }
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlLevel.SelectedValue == "0" || ddlTopic.SelectedValue == "0" || string.IsNullOrWhiteSpace(txtQuestion.Text)) { ShowMsg("Please fill all required fields.", false); return; }

        using (SqlConnection conn = new SqlConnection(connStr))
        using (SqlCommand cmd = new SqlCommand(@"INSERT INTO Questions (TopicID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Explanation, IsActive) VALUES (@TopicID, @QuestionText, @A, @B, @C, @D, @Correct, @Explanation, 1)", conn))
        {
            cmd.Parameters.AddWithValue("@TopicID", ddlTopic.SelectedValue);
            cmd.Parameters.AddWithValue("@QuestionText", txtQuestion.Text.Trim());
            cmd.Parameters.AddWithValue("@A", txtOptA.Text.Trim());
            cmd.Parameters.AddWithValue("@B", txtOptB.Text.Trim());
            cmd.Parameters.AddWithValue("@C", txtOptC.Text.Trim());
            cmd.Parameters.AddWithValue("@D", txtOptD.Text.Trim());
            cmd.Parameters.AddWithValue("@Correct", ddlCorrect.SelectedValue);
            cmd.Parameters.AddWithValue("@Explanation", string.IsNullOrWhiteSpace(txtExplanation.Text) ? (object)DBNull.Value : txtExplanation.Text.Trim());
            conn.Open(); cmd.ExecuteNonQuery();
        }
        ShowMsg("✅ Saved successfully.", true); ResetForm(keepLevel: true); BindGrid();
    }

    protected void btnReset_Click(object sender, EventArgs e) { ResetForm(); ShowMsg("", true); }

    private void ResetForm(bool keepLevel = false)
    {
        txtQuestion.Text = txtOptA.Text = txtOptB.Text = txtOptC.Text = txtOptD.Text = txtExplanation.Text = "";
        if (!keepLevel) { ddlLevel.SelectedValue = "0"; ddlTopic.Items.Clear(); ddlTopic.Items.Add(new ListItem("-- Select Topic --", "0")); }
    }


    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        BindGrid(txtSearch.Text.Trim());
    }

    private void BindGrid(string searchTerm = "")
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"SELECT Q.*, T.TopicName, T.LevelID 
                         FROM Questions Q 
                         INNER JOIN QuizTopics T ON Q.TopicID = T.TopicID";

            // Search filter condition
            if (!string.IsNullOrEmpty(searchTerm))
            {
                query += " WHERE Q.QuestionText LIKE @search OR T.TopicName LIKE @search";
            }

            query += " ORDER BY Q.QuestionID DESC";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (!string.IsNullOrEmpty(searchTerm))
                {
                    cmd.Parameters.AddWithValue("@search", "%" + searchTerm + "%");
                }

                DataTable dt = new DataTable();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd)) { da.Fill(dt); }

                gvQuestions.DataSource = dt;
                gvQuestions.DataBind();

                // Stats update logic (Same as before)
                int active = dt.AsEnumerable().Count(r => Convert.ToBoolean(r["IsActive"]));
                int inactive = dt.AsEnumerable().Count(r => !Convert.ToBoolean(r["IsActive"]));
                litActiveCount.Text = active.ToString();
                litInactiveCount.Text = inactive.ToString();

                // Modal Logic filter
                DataView dv = new DataView(dt);
                dv.RowFilter = "IsActive = False";
                gvInactive.DataSource = dv;
                gvInactive.DataBind();
            }
        }
    }
    protected void btnShowInactive_Click(object sender, EventArgs e) { pnlInactiveModal.Visible = true; }
    protected void btnCloseModal_Click(object sender, EventArgs e) { pnlInactiveModal.Visible = false; }
    protected void btnQuickActivate_Click(object sender, EventArgs e) { UpdateStatus(Convert.ToInt32(((LinkButton)sender).CommandArgument)); }

    protected void gvQuestions_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandArgument == null || string.IsNullOrEmpty(e.CommandArgument.ToString())) return;
        int qid = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "VIEW_DETAILS")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT Q.*, T.TopicName FROM Questions Q INNER JOIN QuizTopics T ON Q.TopicID = T.TopicID WHERE Q.QuestionID = @id", conn);
                cmd.Parameters.AddWithValue("@id", qid);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litDetQuestion.Text = dr["QuestionText"].ToString();
                    litDetA.Text = dr["OptionA"].ToString();
                    litDetB.Text = dr["OptionB"].ToString();
                    litDetC.Text = dr["OptionC"].ToString();
                    litDetD.Text = dr["OptionD"].ToString();
                    litDetCorrect.Text = dr["CorrectOption"].ToString();
                    litDetExp.Text = !string.IsNullOrEmpty(dr["Explanation"].ToString()) ? dr["Explanation"].ToString() : "No additional explanation provided.";

                    pnlDetailsModal.Visible = true; // Premium Detail Modal ON
                }
            }
        }
        else if (e.CommandName == "TOGGLE")
        {
            UpdateStatus(qid);
        }
    }

    // Modal Band Karne ka Logic
    protected void btnCloseDetails_Click(object sender, EventArgs e)
    {
        pnlDetailsModal.Visible = false;
    }

    private void UpdateStatus(int id)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("UPDATE Questions SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE QuestionID = @ID", conn);
            cmd.Parameters.AddWithValue("@ID", id); conn.Open(); cmd.ExecuteNonQuery();
        }
        BindGrid();
    }

    protected void gvQuestions_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvQuestions.DataKeys[e.RowIndex].Value);
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM Questions WHERE QuestionID = @ID", conn);
            cmd.Parameters.AddWithValue("@ID", id); conn.Open(); cmd.ExecuteNonQuery();
        }
        BindGrid();
    }



    private void ShowMsg(string message, bool isSuccess)
    {
        if (string.IsNullOrWhiteSpace(message)) { lblMsg.Text = ""; return; }
        string css = isSuccess ? "alert-success text-success" : "alert-danger text-danger";
        lblMsg.Text = string.Format("<div class='alert {0} p-3 mb-4 fw-bold small'>{1}</div>", css, message);
    }
}