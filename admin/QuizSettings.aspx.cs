using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class admin_QuizSettings : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null) Response.Redirect("adminlogin.aspx");
        if (!IsPostBack) LoadSettings();
    }

    private void LoadSettings()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("SELECT TOP 1 * FROM QuizSettings", conn);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtTimer.Text = dr["QuizTimer"].ToString();
                txtPassing.Text = dr["PassingMarks"].ToString();
                txtCount.Text = dr["QuestionsPerQuiz"].ToString();
                ddlNegative.SelectedValue = dr["NegativeMarking"].ToString();
            }
        }
    }

    protected void btnUpdateSettings_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"UPDATE QuizSettings SET 
                             QuizTimer=@timer, PassingMarks=@pass, 
                             NegativeMarking=@neg, QuestionsPerQuiz=@count, 
                             UpdatedDate=GETDATE() WHERE SettingID=1";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@timer", txtTimer.Text);
            cmd.Parameters.AddWithValue("@pass", txtPassing.Text);
            cmd.Parameters.AddWithValue("@neg", ddlNegative.SelectedValue);
            cmd.Parameters.AddWithValue("@count", txtCount.Text);

            conn.Open();
            cmd.ExecuteNonQuery();

            // Success alert (Aap Toastr ya JavaScript alert use kar sakte hain)
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Settings updated successfully!');", true);
        }
    }
}