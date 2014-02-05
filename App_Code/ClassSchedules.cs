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
/// Summary description for ClassSchedules
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class ClassSchedules : System.Web.Services.WebService {

    public class academicyear {
       public string name;
    }

    public class schedule {
        public string subjectcode;
        public string subjecttitle;
        public string room;
        public string sched;
        public string section;
        public int scheduleID;
    }

    public class classlist{
        public string studentno;
        public string studentname;
        public string gender;
        public string age;
        public string yearlevel;
    }

    static List<academicyear> acadyear = new List<academicyear> { };

    static List<schedule> scheds = new List<schedule> { };

    static List<classlist> lists = new List<classlist> { };


    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [WebMethod]

    public List<classlist> getStudentLists(int scheduleID)
    {
        string query = "SELECT R.StudentNo, S.LastName + ', ' + S.FirstName + ' ' + S.MiddleInitial AS [StudentName], Gender,(DATEDIFF(mm, S.DateOfBirth, GETDATE())/12) AS [Age], YearLevel FROM ES_RegistrationDetails RD LEFT JOIN ES_Registrations R ON R.RegID = RD.RegID LEFT JOIN ES_Students S ON S.StudentNo = (SELECT StudentNo FROM ES_Registrations WHERE RegID = RD.RegID)LEFT JOIN ES_YearLevel YL ON YL.YearLevelID = S.YearLevelID WHERE (RD.ScheduleID = @scheduleID) AND (R.ValidationDate IS NOT NULL) AND (RD.RegTagID <> '3')ORDER BY S.LastName";
        SqlCommand cmd = new SqlCommand(query);
        cmd.Parameters.AddWithValue("@scheduleID", scheduleID);

        DataSet ds = GetData(cmd);
        DataTable dt = ds.Tables[0];
        lists.Clear();
        foreach (DataRow item in ds.Tables[0].Rows)
        {
            classlist ls = new classlist();
            ls.studentno = item[0].ToString();
            ls.studentname = item[1].ToString();
            ls.gender = item[2].ToString();
            ls.age = item[3].ToString();
            ls.yearlevel = item[4].ToString();
           
            lists.Add(ls);

        }
        return lists;
    }

    


    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [WebMethod]

    public List<academicyear> getAllAcademicYear(string facultyID)
    {

        string query = "select distinct dbo.fn_AcademicYearTerm(C.TermID) from es_classschedules C left join es_ayterm A on C.termid=A.termid where facultyid=@facultyID and hidden=0 order by 1 desc ";
        SqlCommand cmd = new SqlCommand(query);
        cmd.Parameters.AddWithValue("@facultyID", facultyID);
        DataSet ds = GetData(cmd);
        DataTable dt = ds.Tables[0];
        acadyear.Clear();
        foreach (DataRow item in ds.Tables[0].Rows)
        {
            academicyear acad = new academicyear();
            acad.name = item[0].ToString();
            acadyear.Add(acad);
        }

        return acadyear;
    }

    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [WebMethod]

    public List<schedule> getAllFacultySchedule(string term, string facultyID)
    {
        string query = "exec web_getFacultySched @term,@FacultyID";
        SqlCommand cmd = new SqlCommand(query);
        cmd.Parameters.AddWithValue("@term", term);
        cmd.Parameters.AddWithValue("@facultyID", facultyID);
        DataSet ds = GetData(cmd);
        DataTable dt = ds.Tables[0];
        scheds.Clear();
        foreach (DataRow item in ds.Tables[0].Rows)
        {
            schedule sh = new schedule();
            sh.subjectcode = item[1].ToString();
            sh.subjecttitle = item[2].ToString();
            sh.room = item[12].ToString();
            sh.sched = item[7].ToString();
            sh.section = item[19].ToString();
            sh.scheduleID = Convert.ToInt32(item[0].ToString());
            scheds.Add(sh);

        }
        return scheds;
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
