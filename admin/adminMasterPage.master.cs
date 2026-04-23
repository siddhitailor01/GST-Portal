using System;
using System.Web;
using System.Web.Security;

public partial class admin_adminMasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null && !Request.Url.AbsolutePath.EndsWith("adminlogin.aspx"))
        {
            Response.Redirect("adminlogin.aspx");
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();

        Session.Clear();
        Session.Abandon();

        HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, "");
        cookie.Expires = DateTime.Now.AddYears(-1);
        Response.Cookies.Add(cookie);

        Response.Redirect("adminlogin.aspx");
    }
}