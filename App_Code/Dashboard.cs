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
using System.Configuration;

/// <summary>
/// Summary description for Dashboard
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Dashboard : System.Web.Services.WebService {

    public class DashboardInfo {
        public int totalschedules;
        public int totalunposted;
        public int totalstudents;
        public string facultyName;
    }

    //static List<DashboardInfo> dashboard = new List<DashboardInfo> { };

    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //[WebMethod]
    //public List<DashboardInfo> getDashboardInfo()
    //{

    //    string query = "select (select top 1 dbo.fn_FacultyName(FacultyID) from es_classschedules where facultyid='00077')FacultyName ,(select count(scheduleID) from es_classschedules where facultyID='00077' and TermID in (select termid from es_ayterm where getdate() between StartOfAY and EndOfAY)) TotalSchedules, (select count(scheduleID) from es_classschedules where facultyID='00077' and dateposted is NULL and TermID in (select termid from es_ayterm where getdate() between StartOfAY and EndOfAY)) TotalUnposted, (select sum(dbo.fn_totalStudentPerSchedule(ScheduleID,TermID)) from es_classschedules where facultyID='00077'  and TermID in (select termid from es_ayterm where getdate() between StartOfAY and EndOfAY) group by facultyID) TotalStudents";
    //    SqlCommand cmd = new SqlCommand(query);
    //    DataSet ds = GetData(cmd);
    //    DataTable dt = ds.Tables[0];
    //    foreach (DataRow item in ds.Tables[0].Rows)
    //    {
    //        DashboardInfo dash = new DashboardInfo();
    //        dash.facultyName = item[0].ToString();
    //        dash.totalschedules = Convert.ToInt32(item[1].ToString());
    //        dash.totalunposted = Convert.ToInt32(item[2].ToString());
    //        dash.totalstudents = Convert.ToInt32(item[3].ToString());
    //        dashboard.Add(dash);
    //    }

    //    return dashboard;
    //}

    static DashboardInfo dashboard = new DashboardInfo { };

    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod]

    public DashboardInfo getDashboardInfo()
    {

        string query = "select (select top 1 dbo.fn_FacultyName(FacultyID) from es_classschedules where facultyid='00077')FacultyName ,(select count(scheduleID) from es_classschedules where facultyID='00077' and TermID in (select termid from es_ayterm where getdate() between StartOfAY and EndOfAY)) TotalSchedules, (select count(scheduleID) from es_classschedules where facultyID='00077' and dateposted is NULL and TermID in (select termid from es_ayterm where getdate() between StartOfAY and EndOfAY)) TotalUnposted, (select sum(dbo.fn_totalStudentPerSchedule(ScheduleID,TermID)) from es_classschedules where facultyID='00077'  and TermID in (select termid from es_ayterm where getdate() between StartOfAY and EndOfAY) group by facultyID) TotalStudents";
        SqlCommand cmd = new SqlCommand(query);
        DataSet ds = GetData(cmd);
        DataTable dt = ds.Tables[0];
        foreach (DataRow item in ds.Tables[0].Rows)
        {
            DashboardInfo dash = new DashboardInfo();
            dash.facultyName = item[0].ToString();
            dash.totalschedules = Convert.ToInt32(item[1].ToString());
            dash.totalunposted = Convert.ToInt32(item[2].ToString());
            dash.totalstudents = Convert.ToInt32(item[3].ToString());
            dashboard = dash;
        }

        return dashboard;
    }

    private static DataSet GetData(SqlCommand cmd)
    {
        //string connString = "Data Source=GHOST-PC\\STC;Initial Catalog=ELQ;Persist Security Info=True;User ID=sa;Password=seif@ghost";
        string str = ConfigurationManager.ConnectionStrings["prismsconn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(str))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;
                sda.SelectCommand = cmd;
                using (DataSet ds = new DataSet())
                {
                    sda.Fill(ds);
                    return ds;
                }
            }
        }
    }

    
}
