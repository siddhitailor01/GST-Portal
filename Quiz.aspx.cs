using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Linq;

public partial class Quiz : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    private DataTable QuizData { get { return (DataTable)ViewState["QuizData"]; } set { ViewState["QuizData"] = value; } }
    private int CurrentIdx { get { return (int)ViewState["CurrentIdx"]; } set { ViewState["CurrentIdx"] = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CurrentIdx = 0;
            LoadQuiz();
        }
    }

    private void LoadQuiz()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "";
            int topicID = 0;
            bool isTopicQuiz = false;

            if (Request.QueryString["TopicID"] != null && int.TryParse(Request.QueryString["TopicID"], out topicID))
            {
                query = "SELECT TOP 100 * FROM Questions WHERE TopicID = @tid AND IsActive = 1 ORDER BY NEWID()";
                isTopicQuiz = true;
            }
            else
            {
                query = "SELECT TOP 100 * FROM Questions WHERE IsActive = 1 ORDER BY NEWID()";
                litTopicHeading.Text = "GST Champion Mock Test";
            }

            SqlCommand cmd = new SqlCommand(query, conn);
            if (isTopicQuiz) cmd.Parameters.AddWithValue("@tid", topicID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                dt.Columns.Add("UserAnswer", typeof(string));
                QuizData = dt;

                int totalQuestionsFetched = dt.Rows.Count;
                int calculatedTimeSeconds = totalQuestionsFetched * 36;
                if (calculatedTimeSeconds > 3600) calculatedTimeSeconds = 3600;
                if (calculatedTimeSeconds < 120) calculatedTimeSeconds = 120;

                hfRemainingTime.Value = calculatedTimeSeconds.ToString();

                if (isTopicQuiz) litTopicHeading.Text = "Practice: Topic Assessment";

                pnlMainQuizArea.Visible = true;
                pnlQuizHeader.Visible = true;
                pnlNoQuestions.Visible = false;
                ShowQuestion();
                BindNav();
            }
            else
            {
                pnlMainQuizArea.Visible = false;
                pnlQuizHeader.Visible = false;
                pnlNoQuestions.Visible = true;
                litTopicHeading.Text = "Content Under Development";
            }
        }
    }

    private void ShowQuestion()
    {
        pnlError.Visible = false;
        if (QuizData == null || QuizData.Rows.Count == 0) return;

        DataRow row = QuizData.Rows[CurrentIdx];
        litQuestionText.Text = row["QuestionText"].ToString();
        hfCorrectAnswer.Value = row["CorrectOption"].ToString().Trim();

        lblCurrentQ.Text = (CurrentIdx + 1).ToString();
        lblTotalQ.Text = QuizData.Rows.Count.ToString();

        double progress = ((double)CurrentIdx / QuizData.Rows.Count) * 100;
        progressBar.Style["width"] = progress.ToString("0") + "%";

        rblOptions.Items.Clear();
        rblOptions.Items.Add(new ListItem(row["OptionA"].ToString(), "A"));
        rblOptions.Items.Add(new ListItem(row["OptionB"].ToString(), "B"));
        rblOptions.Items.Add(new ListItem(row["OptionC"].ToString(), "C"));
        rblOptions.Items.Add(new ListItem(row["OptionD"].ToString(), "D"));

        if (row["UserAnswer"] != DBNull.Value && !string.IsNullOrEmpty(row["UserAnswer"].ToString()))
        {
            rblOptions.SelectedValue = row["UserAnswer"].ToString();
        }

        btnPrev.Visible = (CurrentIdx > 0);

        // Agar aakhri question hai toh Next hide karke Submit show karenge
        bool isLast = (CurrentIdx == QuizData.Rows.Count - 1);
        btnNext.Visible = !isLast;
        CheckAllAttempted();
        UpdateAnsweredCount(); // Count update logic call
    }

    private void UpdateAnsweredCount()
    {
        if (QuizData != null)
        {
            // Kitne questions attempt kiye uska real-time count
            int answered = QuizData.AsEnumerable().Count(r => r["UserAnswer"] != DBNull.Value && !string.IsNullOrEmpty(r["UserAnswer"].ToString()));

            // Layout labels ko update karna
            lblAnsweredCount.Text = answered.ToString();
            lblTotalCountNav.Text = QuizData.Rows.Count.ToString();
        }
    }

    private void CheckAllAttempted()
    {
        bool allAnswered = QuizData.AsEnumerable().All(r => r["UserAnswer"] != DBNull.Value && !string.IsNullOrEmpty(r["UserAnswer"].ToString()));
        btnSubmit.Visible = allAnswered;
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        SaveCurrentAnswer();
        if (CurrentIdx < QuizData.Rows.Count - 1)
        {
            CurrentIdx++;
            ShowQuestion();
            BindNav();
        }
    }

    protected void btnPrev_Click(object sender, EventArgs e)
    {
        SaveCurrentAnswer();
        if (CurrentIdx > 0)
        {
            CurrentIdx--;
            ShowQuestion();
            BindNav();
        }
    }

    private void SaveCurrentAnswer()
    {
        if (rblOptions.SelectedIndex != -1)
        {
            QuizData.Rows[CurrentIdx]["UserAnswer"] = rblOptions.SelectedValue;
        }
    }

    protected void JumpToQuestion(object sender, EventArgs e)
    {
        SaveCurrentAnswer();
        LinkButton btn = (LinkButton)sender;
        CurrentIdx = int.Parse(btn.CommandArgument);
        ShowQuestion();
        BindNav();
    }

    private void BindNav()
    {
        rptNav.DataSource = QuizData;
        rptNav.DataBind();
    }

    protected string GetNavClass(int index)
    {
        // 1. Agar wahi question screen par hai toh Blue
        if (index == CurrentIdx) return "btn btn-primary nav-active-focus";

        // 2. Agar answer de diya hai toh Green
        var ans = QuizData.Rows[index]["UserAnswer"];
        if (ans != DBNull.Value && !string.IsNullOrEmpty(ans.ToString()))
            return "btn btn-success";

        // 3. Default state
        return "btn btn-outline-secondary";
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SaveCurrentAnswer();
        FinalizeQuiz();
    }

    private void FinalizeQuiz()
    {
        int finalScore = 0;
        foreach (DataRow row in QuizData.Rows)
        {
            if (row["UserAnswer"] != DBNull.Value &&
                row["UserAnswer"].ToString().Trim() == row["CorrectOption"].ToString().Trim())
            {
                finalScore++;
            }
        }

        Session["LastScore"] = finalScore;
        Session["TotalQuestions"] = QuizData.Rows.Count;
        Session["DetailedResults"] = QuizData;
        Response.Redirect("QuizResult.aspx");
    }

    protected void TimerTimeout_Handle(object sender, EventArgs e)
    {
        SaveCurrentAnswer();
        FinalizeQuiz();
    }
}