﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class lists : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            uid.Value = Membership.GetUser().UserName.ToString();
        }
        catch (Exception)
        {
            Response.Redirect("login.aspx");
            throw;
        }
    }
}