using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class LessonDetail : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["TopicID"] != null)
            {
                int topicID = Convert.ToInt32(Request.QueryString["TopicID"]);
                LoadLesson(topicID);
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }
    }

    private void LoadLesson(int tid)
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // JOIN query: Lessons table se content aur QuizTopics table se LevelID
                string query = @"SELECT L.LessonTitle, L.LessonContent, L.CreatedDate, T.LevelID 
                             FROM Lessons L 
                             INNER JOIN QuizTopics T ON L.TopicID = T.TopicID 
                             WHERE L.TopicID = @tid";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@tid", tid);

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litTitle.Text = dr["LessonTitle"].ToString();
                    litContent.Text = dr["LessonContent"].ToString();
                    litDate.Text = Convert.ToDateTime(dr["CreatedDate"]).ToString("dd MMM yyyy");

                    // Dynamic Level Logic
                    string levelId = dr["LevelID"].ToString();
                    switch (levelId)
                    {
                        case "1":
                            litLevel.Text = "Beginner";
                            break;
                        case "2":
                            litLevel.Text = "Intermediate";
                            break;
                        case "3":
                            litLevel.Text = "Expert";
                            break;
                        default:
                            litLevel.Text = "General";
                            break;
                    }

                    Page.Title = dr["LessonTitle"].ToString() + " | GST Champions";
                }
                else
                {
                    litTitle.Text = "Lesson Coming Soon!";
                    litContent.Text = "<p class='text-center py-5'>Content unavailable.</p>";
                    litLevel.Text = "N/A";
                }
            }
        }
        catch (Exception ex)
        {
            litTitle.Text = "Error Loading Content";
        }
    }
}