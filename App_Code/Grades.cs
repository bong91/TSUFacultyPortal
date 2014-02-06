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
/// Summary description for Grades
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.  
[System.Web.Script.Services.ScriptService]
public class Grades : System.Web.Services.WebService {

    public class studentgrade {
        public string studentno;
        public string studentname;
        public string midterm;
        public string final;
        public string reexam;
        public string finalremarks;
        public string dateposted;

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    static List<studentgrade> gradelist = new List<studentgrade> { };   


    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [WebMethod]

    public List<studentgrade> getAllGrades(string scheduleID)
    {

        string query = "select Students.StudentNo,Students.StudentName,isNULL(Grades.Midterm,'')Midterm,isNULL(Grades.Final,'')Final,isNULL(Grades.Reexam,'')ReExam, isNULL(dbo.fn_GradeRemarks(1,Grades.Midterm,Grades.Final,Grades.ReExam,dbo.fn_ProgramClassCode(ProgID)),''),[dbo].[fn_ClassSchedulePostingDate](Grades.ScheduleID)DatePosted from (SELECT R.StudentNo, dbo.fn_StudentName(R.StudentNo) AS [StudentName] FROM ES_RegistrationDetails RD inner JOIN ES_Registrations R ON R.RegID = RD.RegID  WHERE (RD.ScheduleID = @scheduleID) AND (R.ValidationDate IS NOT NULL))[students] left join (select * from es_grades where scheduleid = @scheduleID) [grades] on [students].studentno = [grades].studentno";
        SqlCommand cmd = new SqlCommand(query);
        cmd.Parameters.AddWithValue("@scheduleID", scheduleID);
        DataSet ds = GetData(cmd);
        DataTable dt = ds.Tables[0];
        gradelist.Clear();
        foreach (DataRow item in ds.Tables[0].Rows)
        {
            studentgrade grd = new studentgrade();
            grd.studentno = item[0].ToString();
            grd.studentname = item[1].ToString();
            grd.midterm = item[2].ToString();
            grd.final = item[3].ToString();
            grd.reexam = item[4].ToString();
            grd.finalremarks = item[5].ToString();
            grd.dateposted = item[6].ToString();
            gradelist.Add(grd);
        }

        return gradelist;
    }

    
    private static DataSet GetData(SqlCommand cmd)
    {
        // string connString = "Data Source=GHOST-PC\\STC;Initial Catalog=ELQ;Persist Security Info=True;User ID=sa;Password=seif@ghost";
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
