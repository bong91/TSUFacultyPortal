<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="schedules.aspx.cs" Inherits="schedules" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">


        $(document).on('pageinit', function () {

            getAcademicYear();
        });

        function clearTable(table) {

            var firstRow = table.rows[0];
            var tBody = table.tBodies[0].cloneNode(false);
            tBody.appendChild(firstRow);
            table.replaceChild(tBody, table.tBodies[0]);
        }

        function displaySchedules(selSched) {
            var acad = selSched.replace(/_/g, ' ');
            $('#<%= selSchedule.ClientID %>').text(acad);

            clearTable(facultyschedules);
            getSchedules(acad);
        }

        function getSchedules(selSched) {

            $.ajax({

                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: "ClassSchedules.asmx/getAllFacultySchedule?term='" + selSched + "'&facultyID='" + document.getElementById('<%= uid.ClientID%>').value + "'",

                data: "{}",
                dataType: "json",
                success: function (msg) {
                    var sched = msg.d;

                    $.each(sched, function (index, sh) {
                        $("#facultyschedules").append("<tr><td>" + sh.subjectcode + "</td> <td>" + sh.subjecttitle + "</td> <td>" + sh.section + "</td> <td>" + sh.room + "</td> <td>" + sh.sched + " </td> </tr>");
                    });

                    console.log(msg);
                },

                error: function (msg) {
                    $("#facultyschedules").append("<tr> <td>error</td> <td>error</td> <td>error</td> <td>error</td> <td>error</td></tr>");

                    console.log(msg);


                }
            });

            // $("#facultyschedules").append("</tbody>");

        }

        function getAcademicYear() {

            $.ajax({

                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: "ClassSchedules.asmx/getAllAcademicYear?facultyID='" + document.getElementById('<%= uid.ClientID%>').value + "'",
                //url: "ClassSchedules.asmx/getAllAcademicYear",
                data: "{}",
                dataType: "json",
                success: function (msg) {

                    var acadyear = msg.d;
                    $("#dropdown-menu").removeData();

                    $.each(acadyear, function (index, acad) {
                        var acadS = acad.name.replace(/ /g, "_");
                        $("#dropdown-menu").append("<li><a href='#' onClick=displaySchedules('" + acadS + "')>" + acad.name + "</a></li>");
                    });

                    console.log(msg);
                },

                error: function (msg) {
                    $("#dropdown-menu").append("<li> error<li>");

                    console.log(msg);


                }
            });
        }




    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div class="row">
        <div class="col-lg-12">
            <h1>Class Schedules <%--<small>Sort Your Data</small>--%></h1>
            <ol class="breadcrumb">
                <li><a href="index.html"><i class="fa fa-dashboard"></i>Dashboard</a></li>
                <li class="active"><i class="fa fa-bar-chart-o"></i>Class Schedules</li>
            </ol>
            <input type='hidden' id="uid" name="uid" runat='server' />
            <div class="alert alert-info alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                View, print or export your class schedules.
            </div>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-6">
            <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                    Select Academic Year <span class="caret"></span>
                </button>
                <ul id="dropdown-menu" class="dropdown-menu" role="menu" data-role="listview" data-inset="true" data-filter="true">
                </ul>

                <div class="btn-group">
                    <button type="button" class="btn btn-primary"><i class="fa fa-print"></i>Print</button>
                    <button type="button" class="btn btn-primary"><i class="fa fa-download"></i>Export</button>
                </div>
            </div>
        </div>
        <div class="col-lg-6 text-right">
            <strong>Selected Academic Year:
                <asp:Label ID="selSchedule" runat="server" Text=""></asp:Label></strong>
        </div>

    </div>

    <div class="row padup10">
        <div class="col-lg-12">

            <div class="table-responsive">
                <table id="facultyschedules" class="table table-bordered table-hover table-striped tablesorter">
                    <thead>
                        <tr>
                            <th>Subject Code <i class="fa fa-sort"></i></th>
                            <th>Subject Title <i class="fa fa-sort"></i></th>
                            <th>Section <i class="fa fa-sort"></i></th>
                            <th>Room <i class="fa fa-sort"></i></th>
                            <th>Schedule <i class="fa fa-sort"></i></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>


        </div>

    </div>
    <script type="text/javascript">
        ChangeToClass("schedules");

        getAcademicYear();
    </script>
</asp:Content>
