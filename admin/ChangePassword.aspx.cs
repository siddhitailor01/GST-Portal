using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class admin_ChangePassword : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["GSTConn"].ConnectionString;

    protected void btnUpdatePass_Click(object sender, EventArgs e)
    {
        if (txtNewPass.Text != txtConfirmPass.Text)
        {
            Response.Write("<script>alert('New Passwords do not match!');</script>");
            return;
        }

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            // Pehle check karein purana password sahi hai ya nahi
            string checkQuery = "SELECT COUNT(*) FROM Admins WHERE AdminID=@id AND Password=@old";
            SqlCommand cmdCheck = new SqlCommand(checkQuery, conn);
            cmdCheck.Parameters.AddWithValue("@id", Session["AdminID"]);
            cmdCheck.Parameters.AddWithValue("@old", txtOldPass.Text.Trim());

            conn.Open();
            int count = (int)cmdCheck.ExecuteScalar();

            if (count > 0)
            {
                // Sahi hai, ab update karein
                string updateQuery = "UPDATE Admins SET Password=@new WHERE AdminID=@id";
                SqlCommand cmdUpdate = new SqlCommand(updateQuery, conn);
                cmdUpdate.Parameters.AddWithValue("@new", txtNewPass.Text.Trim());
                cmdUpdate.Parameters.AddWithValue("@id", Session["AdminID"]);
                cmdUpdate.ExecuteNonQuery();

                Response.Write("<script>alert('Password updated successfully!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Incorrect old password!');</script>");
            }
        }
    }
}