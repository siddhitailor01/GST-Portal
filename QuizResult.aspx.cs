using System;
using System.Data;
using System.Web.UI;

public partial class QuizResult : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["LastScore"] != null && Session["DetailedResults"] != null)
            {
                int score = (int)Session["LastScore"];
                int total = (int)Session["TotalQuestions"];
                DataTable dt = (DataTable)Session["DetailedResults"];

                double percentage = ((double)score / total) * 100;
                litPercentage.Text = percentage.ToString("0"); // Insight widget ke liye

                // --- 1. SETTING THE RING AND BADGE ---
                divCircle.Style["--percentage"] = percentage.ToString("0");
                lblScore.Text = score.ToString();
                lblTotalQ.Text = total.ToString();
                lblCorrectCount.Text = score.ToString();
                lblWrongCount.Text = (total - score).ToString();

                // --- 2. UNIQUE TITLES ---
                if (percentage >= 90) { lblTitle.Text = "GST CHAMPION"; lblStatus.Text = "Outstanding! You are a GST Maestro."; }
                else if (percentage >= 70) { lblTitle.Text = "TAX CONSULTANT"; lblStatus.Text = "Great Job! Expert level accuracy."; }
                else if (percentage >= 50) { lblTitle.Text = "GST ROOKIE"; lblStatus.Text = "Good effort! Keep learning."; }
                else { lblTitle.Text = "GST LEARNER"; lblStatus.Text = "TAX REBATE NEEDED"; } // Roast status

                // --- 3. ROAST LOGIC (YAHAN CHANGES HAIN) ---
                string roastMessage = "";
                if (percentage <= 30)
                    roastMessage = "Aapko GST ke buniyadi siddhanto (Basics) par thoda aur dhyan dene ki avashyakta hai. Kripya foundation modules ko fir se padhein."; 
                else if (percentage <= 60)
                    roastMessage = "Achha prayas hai! Lekin behtar samajh ke liye aapko aur abhyas (practice) ki zaroorat hai. Jaari rakhein.";
                else if (percentage <= 90)
                    roastMessage = "Behtareen pradarshan! Aap taxation ki gehri samajh rakhte hain. Aap jald hi expert ban sakte hain.";
                else
                    roastMessage = "Hardik abhinandan! Aapne GST Champion ki upadhi prapt ki hai. Aapka gyan aur accuracy prashansaniya hai.";

                //litRoast.Text = roastMessage;        // Sidebar mein dikhega
                litRoastInsight.Text = roastMessage; // Main Widget mein dikhega

                // --- 4. FILTER MISTAKES ---
                DataView dv = dt.DefaultView;
                dv.RowFilter = "UserAnswer <> CorrectOption OR UserAnswer IS NULL";

                if (dv.Count > 0)
                {
                    rptDetails.DataSource = dv;
                    rptDetails.DataBind();
                    litReviewTitle.Text = "Concept Review (Based on your mistakes)";
                }
                else
                {
                    litReviewTitle.Text = "Perfect! Zero Mistakes.";
                    rptDetails.Visible = false;
                }

                // WhatsApp Sharing with Roast
                string shareMsg = string.Format("Maine GST Champions par {0}/{1} score kiya hai. Mere jaisa 'Champion' ban sakte ho toh aao, varna rehne do! www.gstchampions.in", score, total);
                hlWhatsApp.NavigateUrl = "https://api.whatsapp.com/send?text=" + Server.UrlEncode(shareMsg);
            }
            else { Response.Redirect("index.aspx"); }
        }
    }

    protected string GetOptionText(object code, object dataItem)
    {
        if (code == null || string.IsNullOrEmpty(code.ToString())) return "Not Answered";
        DataRowView row = (DataRowView)dataItem;
        string c = code.ToString().Trim();
        if (c == "A") return row["OptionA"].ToString();
        if (c == "B") return row["OptionB"].ToString();
        if (c == "C") return row["OptionC"].ToString();
        if (c == "D") return row["OptionD"].ToString();
        return "";
    }
}