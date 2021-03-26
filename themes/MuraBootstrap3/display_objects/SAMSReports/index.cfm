<!--- 
 SR#20004 
 date:  01/23/2020 
 Author: Ganga Thota
 Description: New Fiscal year field added to report / Start and end date fields removed. 
  ---> 

<cfscript>
    param name = 'message' default={};
</cfscript>

<cfparam name="variables.ReportNo" default="-">
<cfparam name="variables.FY" default="">
<cfparam name="variables.month" default="">
<cfparam name="variables.Agency_No" default="">
<cfparam name="variables.startDate" default="">
<cfparam name="variables.endDate" default="">


<cfinvoke component="model.beans.ReportsNew"
        method="getListAgencies" FY="20#trim(application.PopularQueryFY)#"
        returnVariable="getListAgencies">
</cfinvoke>

<cfif IsDefined("URL.ReportNo")>
    <cfset variables.ReportNo = URL.ReportNo>
    <cfelseif IsDefined("form.ReportNo")>
    <cfset variables.ReportNo = form.ReportNo>
</cfif>
<cfif IsDefined("URL.FY")>
    <cfset variables.FY = URL.FY>
    <cfelseif IsDefined("form.FY")>
    <cfset variables.FY = form.FY>
</cfif>
<cfif IsDefined("URL.month")>
    <cfset variables.month = URL.month>
    <cfelseif IsDefined("form.month")>
    <cfset variables.month = form.month>
</cfif>
<cfif IsDefined("URL.Agency_No")>
    <cfset variables.Agency_No = URL.Agency_No>
    <cfelseif IsDefined("form.Agency_No")>
    <cfset variables.Agency_No = form.Agency_No>
</cfif>

<cfif IsDefined("URL.startDate")>
    <cfset variables.startDate = URL.startDate>
    <cfelseif IsDefined("form.startDate")>
    <cfset variables.startDate = form.startDate>
</cfif>
<cfif IsDefined("URL.endDate")>
    <cfset variables.endDate = URL.endDate>
    <cfelseif IsDefined("form.endDate")>
    <cfset variables.endDate = form.endDate>
</cfif>

<cfoutput>
    <div class="muracontacts-wrapper">
<!--- Body --->
    <div class="muracontacts-body">
    <cfif isDefined("url.mcaction")>
        <cfinclude template="inc/#LCase(m.event('mcaction'))#.cfm"/>
    <cfelse>
     
    <p class="text-center"><b class="text-danger">* </b>Select the Agency Number, Report Name, Fiscal Year and  Month to get a list of the available PDF files. </p>

        <form action="" id="samsMonthlyReports" method="post" name="GetSelectionInfo">

         <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label"><cfif variables.ReportNo EQ "SB05"> FUND Number <cfelse>Agency Number</cfif></div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
                <select class="select2" id="Agency_No" name="Agency_No">
                    <option value="" selected>Agency Number</option>
                    <cfloop query="getListAgencies">
                            <option <cfif variables.Agency_No EQ getListAgencies.AGENCY> selected </cfif>
                            value="#getListAgencies.AGENCY#">#getListAgencies.AGENCY# - #getListAgencies.NAME#</option> 
                    </cfloop>                    
                </select>
            </div>
         </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label">Report Name</div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
                <select id="ReportNo" class="select2" name="ReportNo">
                    <option value="" selected>Report Name</option>
                    <option <cfif variables.ReportNo EQ "SW23"> selected </cfif> value="SW23" >SW23 Notification of Warrants Cancelled for Redeposit</option>
                    <option <cfif variables.ReportNo EQ "SW24"> selected </cfif> value="SW24" >SW24 Notification of Warrants Replaced</option>
                </select>
            </div>
        </div>

         <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label">Fiscal Year</div>
            </div>
             
            <div class="col-xs-12 col-sm-7 col-md-5" data-toggle="tooltip" data-placement="top" >    <!--- SR# 20004 added fiscal year filter   --->
            <select id="FY" class="select2" name="FY">
                <option value="" selected>Fiscal Year</option>
                <option value="#application.cfy#" <cfif variables.FY EQ application.cfy> selected </cfif>>20#application.cfy#</option>
                <option value="#application.pfy#" <cfif variables.FY EQ application.pfy> selected </cfif>>20#application.pfy#</option>
                <option value="#application.ppfy#" <cfif variables.FY EQ application.ppfy> selected </cfif>>20#application.ppfy#</option>           
            </select>
            </div>
        </div> 

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label">Month</div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5" data-toggle="tooltip" data-placement="top" >
                <select class="select2" id="month" name="month" >
                    <option value="" selected>Month</option>
                    <option <cfif variables.month EQ "01"> selected </cfif> value='01'>January</option>
                    <option <cfif variables.month EQ "02"> selected </cfif> value='02'>February</option>
                    <option <cfif variables.month EQ "03"> selected </cfif> value='03'>March</option>
                    <option <cfif variables.month EQ "04"> selected </cfif> value='04'>April</option>
                    <option <cfif variables.month EQ "05"> selected </cfif> value='05'>May</option>
                    <option <cfif variables.month EQ "06"> selected </cfif> value='06'>June</option>
                    <option <cfif variables.month EQ "07"> selected </cfif> value='07'>July</option>
                    <option <cfif variables.month EQ "08"> selected </cfif> value='08'>August</option>
                    <option <cfif variables.month EQ "09"> selected </cfif> value='09'>September</option>
                    <option <cfif variables.month EQ "10"> selected </cfif> value='10'>October</option>
                    <option <cfif variables.month EQ "11"> selected </cfif> value='11'>November</option>
                    <option <cfif variables.month EQ "12"> selected </cfif> value='12'>December</option>                  
                </select>
            </div>
        </div>
  <!---
        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label">Start Date</div>
            </div>
            <div class="col-xs-12 col-sm-7 col-md-5">
                <div id="datetimepicker2" class="input-append" data-toggle="tooltip" data-placement="top" title="You can search by month “OR” Start/End date." >
                    <label class="date">
                        <input name="startDate" type="text" data-date-autoclose="true" class="form-control datepicker"  <cfif variables.startDate NEQ ""> value="#variables.startDate#"</cfif>  id="startDate" placeholder="mm/dd/yyyy">
                    </label>
                </div>
            </div>                        

        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label">End Date</div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
                <div id="datetimepicker2" class="input-append" data-toggle="tooltip" data-placement="top" title="You can search by month “OR” Start/End date." >
                    <label class="date">
                        <input name="endDate" type="text" data-date-autoclose="true" class="form-control datepicker" <cfif variables.endDate NEQ ""> value="#variables.endDate#"</cfif> id="endDate" placeholder="mm/dd/yyyy">
                    </label>
                </div>
            </div>                        

        
       </div>         
--->   <!--- SR#20004   remove startdate and end date range option   --->
     <div id="messageHolder" class="hide"></div>

    <div class="text-center margintopbottom">
            <input class="btn btn-primary" type="submit" value="Search" name="Search" id="submitBtn">
            <input type="hidden" id="hdnValue" name="hdnValue" value="0">
    </div>       
    <p class="text-center"> Please note that reports (SW23 & SW24) are available as of the following dates: 11/1/2018 </p>

 </form>
    
        <cfif IsDefined("form.agency_no") && IsDefined("form.reportno") && IsDefined("form.hdnValue") && form.hdnValue IS 1>
            <cfif isDefined("form.month")><cfelse><cfparam name="form.month" default=""></cfif> 

                <div class="mariginBottom">    
                    <!--- <p> Below is the list of available Files </p> --->
                    <div class="row">
                    <div class="col-xs-12 col-sm-8 col-sm-offset-2 text-center">
                    <table class="table table-striped table-hover table-2018">
                        <tbody>
                        <tr>
                            <th style="text-align: center;"> Click on the desired hyperlink below</th>
                        </tr>

                        <cfset varHasFile = 0>
                        <!---- This directory path only for UAT  ---->
                        <cfif cgi.server_name CONTAINS 'uat'>  
                            <cfdirectory action="list" name="files" directory="\WEB\Main2018\Office\AgencyReportsDev"> 
                        
                         <cfelse> 
                        <!---- This directory path only for PROD    ---->  
                         <cfftp
                            action="listDir"
                            name="files"
                            directory="#application.AgencyReportsFTPFolder#"
                            server="10.20.30.40"
                            username="#application.AgencyReportsUserId#"
                            password="#application.AgencyReportsUserPassword#">        
                        </cfif>                
                        <cfloop query="files">
                            <tr>
                                <cfset myFileArrayList = ListToArray(name,'_')>
                                <cfset myFYArrayList = ListToArray(myFileArrayList[2],'-')>    
                                <cfset myMonth = myFYArrayList[1]>
                                <cfset myDay = myFYArrayList[2]>
                                <cfset myYear = myFYArrayList[3]>
                     
                   <!--- #form.month#_#variables.FY#<br/>  ---> 
                                <cfif form.month NEQ ""> 
                                <!--- SR# 20004 added for dislay pdf files according fiscal year time frame like 2019 ( start July 2018 to June 2019)  --->
                                    <cfif form.month GT 6>
                                    <cfset variables.FY = #form.FY# - 1>
                                    <cfelse>
                                    <cfset variables.FY = #form.FY# >
                                    </cfif>  

                                    <cfif form.agency_no EQ Replace(UCase(myFileArrayList[3]),".PDF","") && form.reportno EQ myFileArrayList[1] && myMonth EQ form.month && myYear EQ variables.FY> <!--- && myYear EQ form.FY --->
                                        <cfset varHasFile = 1>
                                       <td>
                                       <cfif cgi.server_name CONTAINS 'uat'>  <!---- remove UAT file url in Production --->
                                           <a class="text-center" target="_blank" style="padding: 12px;" href="https://2018-uat.illinoiscomptroller.gov/office/AgencyReportsDev/#name#">#name#</a>
                                        <cfelse>   
                                           <a class="text-center" target="_blank" style="padding: 12px;" href="#application.AgencyReportsFTPServerURL#/#application.AgencyReportsFTPFolder#/#name#">#name#</a>  
                                        </cfif>
                                        </td>  
                                    </cfif>
                                <cfelse>
                                    <cfset varStartDate = ListToArray(form.startDate,'/')>
                                    <cfset varSEndDate = ListToArray(form.endDate,'/')>
                                    <cfset varStartDateMonth =  varStartDate[1]>
                                    <cfset varStartDateDay =  varStartDate[2]>
                                    <cfset varEndDateMonth =  varSEndDate[1]>
                                    <cfset varEndDateDay =  varSEndDate[2]>
                                    <cfset varStartDateYear =  mid(varStartDate[3],3,4)>
                                    <cfset varEndDateYear =  mid(varSEndDate[3],3,4)>
    
                                    <cfif form.agency_no EQ Replace(UCase(myFileArrayList[3]),".PDF","") && form.reportno EQ myFileArrayList[1] 
                                    && (myMonth GTE varStartDateMonth && myYear GTE varStartDateYear) && ( myMonth LTE varEndDateMonth && myYear LTE varEndDateYear)
                                    && (myDay GTE varStartDateDay && myDay LTE varEndDateDay)>                                    
                                        <cfset varHasFile = 1>
                                        <td>
                                            <a  class="text-center" target="_blank" style="padding: 12px;" href="#application.AgencyReportsFTPServerURL#/#application.AgencyReportsFTPFolder#/#name#">#name#</a> 
                                        </td>
                                    </cfif>                            
                                </cfif>
                            </tr>
                        </cfloop>
                        </tbody>
                    </table>
                    <cfif varHasFile EQ "0">
                       <div id="messageHolder" class="alert alert-danger"> No records Found.</div>
                    </cfif>
                    </div>
                    </div>
                </div>                    
        </cfif>

    </cfif>

</div>
</div>

<!--- @End .muracontacts-wrapper --->
</cfoutput>

<script type="text/javascript">


    $(document).ready(function () {  
        /*
        $('[data-toggle="tooltip"]').tooltip();
        $(".select2").select2();
        $('#startDate').datepicker();
        $('#endDate').datepicker();  
        $('#startDate').on('changeDate', function() {
           $('#endDate').datepicker("setStartDate", $('#startDate').val());
           if($('#startDate').val() == ""){
                $("#month").prop("disabled", false);
                $('#startDate').val("");
                $('#endDate').val("");
                $(".datepicker").prop('disabled', 'disabled');
           }
           else {
                    //Disable Month
                    $("#month").prop('disabled', 'disabled');
                    $("#FY").prop('disabled', 'disabled');
                    //Enable Datepicker
                    $(".datepicker").prop("disabled", false);            

           }
        });   
        $('#endDate').on('changeDate', function() {
           if($('#endDate').val() == ""){
                $("#month").prop("disabled", false);
                $('#startDate').val("");
                $('#endDate').val("");                
                $(".datepicker").prop('disabled', 'disabled');
           }
           else {
                     //Disable Month
                    $("#month").prop('disabled', 'disabled');
                    $("#FY").prop('disabled', 'disabled');
                    //Enable Datepicker
                    $(".datepicker").prop("disabled", false);           
           }
        });                    

        $("#month").change(function () {
                var selVal = this.value;
                if(selVal == ""){
                    //Disable Month
                    $("#month").prop('disabled', 'disabled');
                    $("#FY").prop('disabled', 'disabled');
                    //Enable Datepicker
                    $(".datepicker").prop("disabled", false);
                }
                else{
                    $("#month").prop("disabled", false);
                    $("#FY").prop('disabled', false);
                    $(".datepicker").prop('disabled', 'disabled');
                }
        });  */

   /*     $("#submitBtn").click(function(event){

                if($("#Agency_No").val() == ""){
                    $("#messageHolder").attr("class","alert alert-danger").html("Please Select Agency Number.");
                    return false;
                }
                else if($("#ReportNo").val() == ""){
                    $("#messageHolder").attr("class","alert alert-danger").html("Please Select Report.");
                    return false;
                }
                 <!--- SR# 20004 added fiscal year filter   --->
                 else if($("#FY").val() == "" && $("#startDate").val() == "" && $("#endDate").val() == ""){
                     $("#messageHolder").attr("class","alert alert-danger").html("Please Select Fiscal Year.");
                     return false;
                 }
                else if($("#month").val() == "" && $("#startDate").val() == "" && $("#endDate").val() == ""){
                    $("#messageHolder").attr("class","alert alert-danger").html("Please Select Month / (Start-date and End-date).");
                    return false;
                } 
                else if($("#startDate").val() != "" && $("#endDate").val() == "" && $("#month").val() == ""){
                    $("#messageHolder").attr("class","alert alert-danger").html("Please Start-date and End-date.");
                    return false;
                }  
                else if($("#startDate").val() == "" && $("#endDate").val() != "" && $("#month").val() == ""){
                    $("#messageHolder").attr("class","alert alert-danger").html("Please Start-date and End-date.");
                    return false;
                }  
                else if($("#FY").val() == "" && $("#month").val() != "") {
                    $("#messageHolder").attr("class","alert alert-danger").html("Please Select Fiscal Year.");
                    return false;
                }                 
                else{
                    $("#messageHolder").attr("class","hide").html("");
                    $("#hdnValue").val("1");
                    $(this).closest('form').submit();
                }    */
         $("#submitBtn").click(function(event){

                if($("#Agency_No").val() == ""){
                    $("#messageHolder").attr("class","alert alert-danger").html("Please Select Agency Number.");
                    return false;
                }
                else if($("#ReportNo").val() == ""){
                    $("#messageHolder").attr("class","alert alert-danger").html("Please Select Report.");
                    return false;
                }
                 <!--- SR# 20004 added fiscal year filter   --->
                 else if($("#FY").val() == ""){
                     $("#messageHolder").attr("class","alert alert-danger").html("Please Select Fiscal Year.");
                     return false;
                 }
                else if($("#month").val() == ""){
                    $("#messageHolder").attr("class","alert alert-danger").html("Please Select Month.");
                    return false;
                }                 
                /*else if($("#FY").val() == "" && $("#month").val() != "") {
                    $("#messageHolder").attr("class","alert alert-danger").html("Please Select Fiscal Year.");
                    return false;
                }    */             
                else{
                    $("#messageHolder").attr("class","hide").html("");
                    $("#hdnValue").val("1");
                    $(this).closest('form').submit();
                }                                                                              
        });        
    });
   
</script>


<cfinclude template="/customtags/GoogleAnalyticsObject.cfm">



