using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Net.Mail; // Naya namespace email ke liye

public partial class Contact : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            if (Request.QueryString["Subject"] != null)
            {
                txtSubject.Text = Request.QueryString["Subject"].ToString();
                if (ddlInquiryType.Items.FindByValue("Topic Doubt") != null)
                {
                    ddlInquiryType.SelectedValue = "Topic Doubt";
                    ddlInquiryType.Enabled = false;
                }
                txtMessage.Focus();
            }
        }
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string name = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string subject = txtSubject.Text.Trim();
        string message = txtMessage.Text.Trim();
        string selectedType = ddlInquiryType.SelectedValue;

        if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(email) && !string.IsNullOrEmpty(message))
        {
            try
            {
                // 1. Database mein save karein
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = "INSERT INTO ContactMessages (FullName, Email, Subject, MessageBody, InquiryType) VALUES (@name, @email, @sub, @msg, @type)";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@sub", subject);
                        cmd.Parameters.AddWithValue("@msg", message);
                        cmd.Parameters.AddWithValue("@type", selectedType);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // 2. Email bhejne ka logic
                SendInquiryEmail(name, email, subject, message, selectedType);

                // Fields clear karein
                txtName.Text = ""; txtEmail.Text = ""; txtSubject.Text = ""; txtMessage.Text = "";
                ddlInquiryType.Enabled = true;
                ddlInquiryType.SelectedIndex = 0;

                string script = "alert('Message bhej diya gaya hai aur email bhi send ho gaya!'); window.location.href='Contact.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "alertRedirect", script, true);
            }
            catch (Exception ex)
            {
                // Detail error log ke liye ex.Message use kar sakte hain
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: " + ex.Message + "');", true);
            }
        }
    }

    private void SendInquiryEmail(string name, string userEmail, string sub, string msg, string type)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("techspmpl@gmail.com", "GST Champions Web Portal");
            mail.To.Add("blsonicontact@gmail.com"); 
            mail.Subject = "New GST Inquiry: " + sub;

            mail.Body = "<b>Inquiry Type:</b> " + type + "<br/>" +
                        "<b>From:</b> " + name + " (" + userEmail + ")<br/><br/>" +
                        "<b>Message:</b><br/>" + msg;
            mail.IsBodyHtml = true;

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.EnableSsl = true;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtp.UseDefaultCredentials = false;

            smtp.Credentials = new NetworkCredential("techspmpl@gmail.com", "vjgwcfxttkjcslkg");

            smtp.Send(mail);
        }
        catch (Exception)
        {
            // Email fail hone par main process na ruke
        }
    }
}