using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
//using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.IO;
//using Newtonsoft.Json;
using System.Data;
using System.Text;

/// <summary>
/// Summary description for ClassSchedules
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class ClassSchedules : System.Web.Services.WebService {

    public ClassSchedules () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }
    
}
