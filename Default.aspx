<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Page Specific CSS -->
    <link rel="stylesheet" href="http://cdn.oesmith.co.uk/morris-0.4.3.min.css"/>
   <%--<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.3.0/jquery.mobile-1.3.0.min.js"></script>--%>
    
   <script type="text/javascript">

       $(document).on('pageinit', function () {
           dashboardInfo();

       });

       function dashboardInfo() {
           
           $.ajax({
               type: "GET",
               contentType: "application/json; charset=utf-8",
               url: "dashboard.asmx/getDashboardInfo?facultyID='" + document.getElementById('<%= uid.ClientID%>').value + "'",
               data: {},
               dataType: "json",
               success: function (msg) {
                   var dash = msg.d;
                
                   $('#<%= lblScheds.ClientID %>').text(dash.totalschedules);
                   $('#<%= lblSheets.ClientID %>').text(dash.totalunposted);
                   $('#<%= lblList.ClientID %>').text(dash.totalstudents);
                   $('#<%= lblName.ClientID %>').text(dash.facultyName);
               }

               
           });
       }
        </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="row">
          <div class="col-lg-12">
            <h1>Dashboard <small>Hello <asp:Label ID="lblName" runat="server" Text="loading"></asp:Label></small></h1>
            <input type='hidden' id="uid" name="uid" runat='server'/>
            <ol class="breadcrumb">
              <li class="active"><i class="fa fa-dashboard"></i> Dashboard</li>
            </ol>
            <div class="alert alert-success alert-dismissable">
              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
              Welcome to TSU Faculty Portal your one stop shop for managing your grades sheets, student lists and class schedules. 
            </div>
          </div>
        </div><!-- /.row -->

    <div class="row">
          <div class="col-lg-3">
            <div class="panel panel-info">
              <div class="panel-heading">
                <div class="row">
                  <div class="col-xs-6">
                    <i class="fa fa-comments fa-5x"></i>
                  </div>
                  <div class="col-xs-6 text-right">
                    <p class="announcement-heading">
                        <asp:Label ID="lblMsgs" runat="server" Text="0"></asp:Label></p>
                    <p class="announcement-text">New Message/s!</p>
                  </div>
                </div>
              </div>
              <a href="#">
                <div class="panel-footer announcement-bottom">
                  <div class="row">
                    <div class="col-xs-6">
                      New Message/s
                    </div>
                    <div class="col-xs-6 text-right">
                      <i class="fa fa-arrow-circle-right"></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
          </div>
         <div class="col-lg-3">
            <div class="panel panel-warning">
              <div class="panel-heading">
                <div class="row">
                  <div class="col-xs-6">
                    <i class="fa fa-calendar fa-5x"></i>
                  </div>
                  <div class="col-xs-6 text-right">
                    <p class="announcement-heading">
                        <asp:Label ID="lblScheds" runat="server" Text="0"></asp:Label></p>
                    <p class="announcement-text">Class Schedules</p>
                  </div>
                </div>
              </div>
              <a href="#">
                <div class="panel-footer announcement-bottom">
                  <div class="row">
                    <div class="col-xs-6">
                      View Schedules
                    </div>
                    <div class="col-xs-6 text-right">
                      <i class="fa fa-arrow-circle-right"></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="panel panel-danger">
              <div class="panel-heading">
                <div class="row">
                  <div class="col-xs-6">
                    <i class="fa fa-unlock-alt fa-5x"></i>
                  </div>
                  <div class="col-xs-6 text-right">
                    <p class="announcement-heading">
                        <asp:Label ID="lblSheets" runat="server" Text="0"></asp:Label></p>
                    <p class="announcement-text">Unposted Grade Sheets</p>
                  </div>
                </div>
              </div>
              <a href="#">
                <div class="panel-footer announcement-bottom">
                  <div class="row">
                    <div class="col-xs-6">
                      Post Grade Sheets
                    </div>
                    <div class="col-xs-6 text-right">
                      <i class="fa fa-arrow-circle-right"></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="panel panel-success">
              <div class="panel-heading">
                <div class="row">
                  <div class="col-xs-6">
                    <i class="fa fa-users fa-5x"></i>
                  </div>
                  <div class="col-xs-6 text-right">
                    <p class="announcement-heading">
                        <asp:Label ID="lblList" runat="server" Text="0"></asp:Label></p>
                    <p class="announcement-text">New Students!</p>
                  </div>
                </div>
              </div>
              <a href="#">
                <div class="panel-footer announcement-bottom">
                  <div class="row">
                    <div class="col-xs-6">
                      View Students' Lists
                    </div>
                    <div class="col-xs-6 text-right">
                      <i class="fa fa-arrow-circle-right"></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
          </div>
        </div><!-- /.row -->




       <script type="text/javascript">
           ChangeToClass("dashboard");
           dashboardInfo();
       </script>
</asp:Content>


