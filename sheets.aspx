﻿<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="sheets.aspx.cs" Inherits="sheets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

        });

        $(document).on('pageinit', function () {
            getAcademicYear();
        });

        function closeClassList() {
            $("#facultyschedules").show();
            $("#closelist").hide();
            $("#studentslists").hide();
        }



        function getStudents(selSched) {
            var sched = selSched;
            $("#facultyschedules").hide();
            $("#closelist").show();
            $("#studentslists").show();
            clearTable(studentslists);
            getGrades(selSched);
        }

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

        function exportXSL() {
            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('#lst').html()));
            e.preventDefault();
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
                          $("#facultyschedules").append("<tr><td>" + sh.subjectcode + "</td> <td>" + sh.subjecttitle + "</td> <td>" + sh.section + "</td> <td class='text-center'> <button type='button' class='btn btn-success' onClick=getStudents(" + sh.scheduleID + ") ><i class='fa fa-folder-open'></i> Open</button></td> </tr>");
                      });
                      console.log(msg);
                  },

                  error: function (msg) {
                      $("#facultyschedules").append("<tr> <td>error</td> <td>error</td> <td>error</td> <td>error</td> <td>error</td></tr>");
                      console.log(msg);
                  }
              });
          }

          function getGrades(selSched) {
              $.ajax({
                  type: "GET",
                  contentType: "application/json; charset=utf-8",
                  url: "Grades.asmx/getAllGrades?scheduleID='" + selSched + "'",
                  data: "{}",
                  dataType: "json",
                  success: function (msg) {
                      var list = msg.d;
                      $.each(list, function (index, li) {
                          $("#studentslists").append("<tr><td>" + li.studentno + "</td> <td>" + li.studentname + "</td> <td>" + li.midterm + "</td> <td>" + li.final + "</td> <td> " + li.reexam + "</td> <td> " + li.finalremarks + "</td> </tr>");
                          $('#<%= dateposted.ClientID %>').text(li.dateposted);
                      });
                      console.log(msg);
                  },

                  error: function (msg) {
                      $("#facultyschedules").append("<tr> <td>error</td> <td>error</td> <td>error</td> <td>error</td> <td>error</td></tr>");
                      console.log(msg);
                  }
              });
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
            <h1>Students' Lists</h1>
            <ol class="breadcrumb">
                <li><a href="index.html"><i class="fa fa-dashboard"></i>Dashboard</a></li>
                <li class="active"><i class="fa fa-edit"></i>Grade Sheets</li>

            </ol>
            <div class="alert alert-info alert-dismissable">
              
                <div class="row">
                    <div class="col-lg-12">
                          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        Select a class schedule to view your grade sheets
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4">

                        <strong>Subject:
                            <asp:Label ID="selSubject" runat="server" Text=""></asp:Label></strong>
                    </div>
                    <div class="col-lg-4">
                        <strong># Students:
                            <asp:Label ID="subjStudents" runat="server" Text=""></asp:Label></strong>
                    </div>
                       <div class="col-lg-4">

                        <strong>Date Posted:
                            <asp:Label ID="dateposted" runat="server" Text=""></asp:Label></strong>
    </div>
    </div>
    </div>
    </div><!-- /.row -->

    <div class="row">
        <div class="col-lg-6">
            <div class="btn-group">
                <input type='hidden' id="uid" name="uid" runat='server' />
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                    Select Academic Year <span class="caret"></span>
                </button>
                <ul id="dropdown-menu" class="dropdown-menu" role="menu" data-role="listview" data-inset="true" data-filter="true">
                </ul>

                <div class="btn-group">
                    <button type="button" class="btn btn-primary"><i class="fa fa-print"></i>Print</button>
                    <button type="button" class="btn btn-primary" onclick="exportXSL()"><i class="fa fa-download"></i>Export</button>
                    <button id="closelist" type="button" class="btn btn-warning" onclick="closeClassList()"><i class="fa fa-times"></i>Close Grade Sheet</button>
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
                <div id="sch">
                    <table id="facultyschedules" class="table table-bordered table-hover table-striped tablesorter">
                        <thead>
                            <tr>
                                <th>Subject Code <i class="fa fa-sort"></i></th>
                                <th>Subject Title <i class="fa fa-sort"></i></th>
                                <th>Section <i class="fa fa-sort"></i></th>
                                <th></th>

                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div id="lst">
                    <table id="studentslists" class="table table-bordered table-hover table-striped tablesorter">
                        <thead>
                            <tr>
                                <th>Student Number <i class="fa fa-sort"></i></th>
                                <th>Name <i class="fa fa-sort"></i></th>
                                <th>Midterm <i class="fa fa-sort"></i></th>
                                <th>Final </th>
                                <th>Re-Exam</th>
                                <th>Remarks</th>

                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>




        </div>

    </div>



    <script type="text/javascript">
        ChangeToClass("sheets");
        $("#closelist").hide();
        $("#studentslists").hide();
        getAcademicYear();


    </script>
</asp:Content>

