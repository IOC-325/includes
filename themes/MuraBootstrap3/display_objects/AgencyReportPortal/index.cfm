<cfscript>
    param name = 'message' default={};
</cfscript>
<!--- <cfparam name="variables.ReportNo" default="A613">
<cfparam name="variables.FY" default="2018">
<cfparam name="variables.Accounting_Period" default="February">
<cfparam name="variables.Agency_No" default="000"> --->

<cfparam name="variables.ReportNo" default="-">
<cfparam name="variables.FY" default="">
<cfparam name="variables.Accounting_Period" default="">
<cfparam name="variables.Agency_No" default="">

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
<cfif IsDefined("URL.Accounting_Period")>
    <cfset variables.Accounting_Period = URL.Accounting_Period>
    <cfelseif IsDefined("form.Accounting_Period")>
    <cfset variables.Accounting_Period = form.Accounting_Period>
</cfif>
<cfif IsDefined("URL.Agency_No")>
    <cfset variables.Agency_No = URL.Agency_No>
    <cfelseif IsDefined("form.Agency_No")>
    <cfset variables.Agency_No = form.Agency_No>
</cfif>
<cfinvoke component="model.beans.ReportsNew"
        method="getListReports"
        returnVariable="GetListReports">
</cfinvoke>


<cfinvoke component="model.beans.ReportsNew"
        method="getListFY" ReportNo="#trim(variables.ReportNo)#"
        returnVariable="getListFY">
</cfinvoke>


<cfinvoke component="model.beans.ReportsNew"
        method="getListMonths" ReportNo="#trim(variables.ReportNo)#" FY="#trim(variables.FY)#"
        returnVariable="getListMonths">
</cfinvoke>
<cfinvoke component="model.beans.ReportsNew"
        method="getListAgencies" ReportNo="#trim(variables.ReportNo)#" FY="#trim(variables.FY)#" Accounting_Period="#trim(variables.Accounting_Period)#"
        returnVariable="getListAgencies">
</cfinvoke>

<cfinvoke component="model.beans.ReportsNew"
        method="Get_ListAvailReports" ReportNo="#trim(variables.ReportNo)#" FY="#trim(variables.FY)#"
        Accounting_Period="#trim(variables.Accounting_Period)#" AgencyNo="#trim(variables.Agency_No)#"
        returnvariable="GetListAvailReports">
</cfinvoke>

<cfoutput>
    <div class="muracontacts-wrapper">
<!--- Messaging --->
    <cfif !StructIsEmpty(message)>
            <div class="muracontacts-alert alert alert-#message.type# alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        <p>#message.text#</p>
        </div>
    </cfif>

<!--- Body --->
    <div class="muracontacts-body">
<!--- <cftry> --->
<!--- <cfinclude template="inc/#LCase(m.event('mcaction'))#.cfm" /> --->

    <cfif isDefined("url.mcaction")>
        <cfinclude template="inc/#LCase(m.event('mcaction'))#.cfm"/>
    <cfelse>
    <p class="text-center">Select the report, fiscal year, month, and agency number to get a list of the
                available PDF files. For additional instructions, click <a
                        href="http://illinoiscomptroller.gov/ioc-pdf/SAMSMonthlyRpt/Instructions.pdf">here</a>.</p>

        <form action="" id="samsMonthlyReports" method="post" name="GetSelectionInfo">
        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label">Report Name</div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
                <select id="ReportNo" class="select2" name="ReportNo" onchange="SetReport();">
                    <option value="" selected>Report Name</option>
                <cfloop query="GetListReports">
                        <option <cfif variables.ReportNo EQ ListToArray(ReportNo, "-")[1].trim()> selected </cfif>
                        value="#ListToArray(ReportNo, "-")[1]#">#GetListReports.ReportNo#</option>
                </cfloop>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label">Fiscal Year</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select id="FY" class="select2" name="FY" onchange="SetFY();">
            <option value="" selected>Fiscal Year</option>
        <cfloop query="getListFY">
                <option <cfif variables.FY EQ getListFY.FY.trim()>
                selected </cfif> value="#getListFY.FY#">#getListFY.FY#</option>
        </cfloop>
        </select>
        </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label">Month</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select class="select2" id="Accounting_Period" name="Accounting_Period" onchange="SetAccountingPeriod();">
            <option value="" selected>Month</option>
        <cfloop query="getListMonths">
                <option <cfif variables.Accounting_Period EQ getListMonths.Accounting_Period.trim() AND variables.Accounting_Period NEQ "">
                selected </cfif> value="#getListMonths.Accounting_Period#">#getListMonths.Accounting_Period#</option>
        </cfloop>
        </select>
        </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label"><cfif variables.ReportNo EQ "SB05"> FUND Number <cfelse>Agency Number</cfif></div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select class="select2" id="Agency_No" name="Agency_No" onchange="SetAgency();">
            <option value=""><cfif variables.ReportNo EQ "SB05"> FUND Number <cfelse>Agency Number</cfif></option>
        <cfloop query="getListAgencies">
                <option <cfif variables.Agency_No EQ ListToArray(Agency_No, "-")[1].trim() AND variables.Agency_No NEQ "">
                selected </cfif> value="#ListToArray(Agency_No, "-")[1].trim()#">#getListAgencies.Agency_No#</option>
        </cfloop>
        </select>
        </div>

<!--- <div class="col-md-2"><button class="btn-search" type="submit">search</button></div> --->
        </div>
        </form>

        <cfif GetListAvailReports.RecordCount GT 0>
                <div class="row">
                <div class="col-xs-12 col-sm-8 col-sm-offset-2 text-center">
                <table class="table table-striped table-hover table-2018">
                <tbody>
                <tr>
                    <th style="text-align: center;"> Click on the desired hyperlink below</th>
                </tr>

                <cfloop query="GetListAvailReports">
                    <tr>
                    <cfif Revoked is "N" and DateFormat(DisplayDtTo, "mm/dd/yyyy") Ge DateFormat(Now(), "mm/dd/yyyy")>
                        <cfset TmpFileName = #trim(mid(ReportNo, 1, 5))# & "_" & #FY# & "_" & #DateFormat(GeneratedDt, "mm-dd-yy")#>
                        <cfif trim(Fund_num) is not "0000">
                            <cfset TmpFileName = TmpFileName & "_" & #mid(Fund_Num, 1, 4)#>
                            <cfelseif mid(AgencyNo, 1, 3) is not "000">
                            <cfset TmpFileName = TmpFileName & "_" & #mid(AgencyNo, 1, 3)#></cfif>
                        <cfset ErrorMsgCnt = 0>
                        <cfparam NAME="variables.myCount" DEFAULT="1">
                        <cftry>
                            <td>
                                    <a class="text-center"
                                       style="padding: 12px;" href="https://files.illinoiscomptroller.gov/SAMSMonthlyRpt/#TmpFileName#.pdf">

                            #trim(ReportNo)#
                                for #DateFormat(GeneratedDt, "mmmm")#of
                            FY #FY# <cfif (DateFormat(GeneratedDt, "mm") is "07") and(DateFormat(GeneratedDt, "YYYY") is FY)>
                                , Lapse Period 1,
                            <cfelseif (DateFormat(GeneratedDt, "mm") is "08") and(DateFormat(GeneratedDt, "YYYY") is FY)>
                                , Lapse Period 2,
                            <cfelseif (DateFormat(GeneratedDt, "mm") is "09") and(DateFormat(GeneratedDt, "YYYY") is FY)>
                                , Lapse Period 3,
                            <cfelseif (DateFormat(GeneratedDt, "mm") is "10") and(DateFormat(GeneratedDt, "YYYY") is FY)>
                                , Lapse Period 4,
                            <cfelseif (DateFormat(GeneratedDt, "mm") is "11") and(DateFormat(GeneratedDt, "YYYY") is FY)>
                                , Lapse Period 5,
                            <cfelseif (DateFormat(GeneratedDt, "mm") is "12") and(DateFormat(GeneratedDt, "YYYY") is FY)>
                                , Lapse Period 6,
                            <cfelseif (DateFormat(GeneratedDt, "mm") is "01") and (DateFormat(GeneratedDt, "YYYY") is FY + 1)>
                                , Lapse Period 7, </cfif>
                                for <cfif AgencyNo is "000" and Fund_Num is "0000" and trim(ReportNo) is not "SB05">
                                All Agencies
                            <cfelseif AgencyNo is "000" and Fund_Num is "0000" and trim(ReportNo) is "SB05">All Funds
                            <cfelseif AgencyNo is "000" and Fund_Num is not "0000">Fund No #Fund_Num#
                        <cfelse>Agency No #AgencyNo#</cfif>
                            </a>
                            <cfcatch type="any">
                                    <div class="alert alert-danger" role="alert">There is currently a problem with
                                        accessing the FTP server. We appreciate your patience as we rectify the matter.
                                    </div>
                            </cfcatch>
                        </cftry>
                        </td>
                    </cfif>
                    </tr>
                </cfloop>
                </tbody>
                </table>
                </div>
                </div>
        </cfif>

<!---<cfcatch>
  <!--- In case one of the include files has an error --->
  <cfdump var="#cfcatch#">
 </cfcatch>
</cftry> --->
    </cfif>
    </div>
</div>


<!--- @End .muracontacts-wrapper --->
</cfoutput>

<script type="text/javascript">
    $(document).ready(function () {

        $(".select2").select2();
    });

    function loadInfo() {
        self.location.href = "/agencies/sams/sams-monthly-report/?ReportNo=&FY=&Accounting_Period=&Agency_No=&loadInfo=";
        return true;

    }

    function SetReport() {
        if (document.GetSelectionInfo.ReportNo.value == 'SB05') {
            self.location.href = "/agencies/sams/sams-monthly-report/?ReportNo=" + document.GetSelectionInfo.ReportNo.value + "&FY=&Accounting_Period=&Agency_No=&loadInfo=&AgencyTitle=FundNo";
            return true;
        }
        else {
                       
            self.location.href = "/agencies/sams/sams-monthly-report/?ReportNo=" + document.GetSelectionInfo.ReportNo.value + "&FY=&Accounting_Period=&Agency_No=&loadInfo=&AgencyTitle=AgencyNo";
            return true;
        }

    }

    function SetFY() {
        if (document.GetSelectionInfo.ReportNo.value == 'SB05') {
            self.location.href = "/agencies/sams/sams-monthly-report/?ReportNo=" + document.GetSelectionInfo.ReportNo.value + "&FY=" + document.GetSelectionInfo.FY.value + "&Accounting_Period=&Agency_No=&loadInfo=&AgencyTitle=FundNo";
            return true;
        }
        else {
            self.location.href = "/agencies/sams/sams-monthly-report/?ReportNo=" + document.GetSelectionInfo.ReportNo.value + "&FY=" + document.GetSelectionInfo.FY.value + "&Accounting_Period=&Agency_No=&loadInfo=&AgencyTitle=AgencyNo";
            return true;
        }

    }

    function SetAccountingPeriod() {
        if (document.GetSelectionInfo.ReportNo.value == 'SB05') {
            self.location.href = "/agencies/sams/sams-monthly-report/?ReportNo=" + document.GetSelectionInfo.ReportNo.value + "&FY=" + document.GetSelectionInfo.FY.value + "&Accounting_Period=" + document.GetSelectionInfo.Accounting_Period.value + "&Agency_No=&loadInfo=&AgencyTitle=FundNo";
            return true;
        }
        else {
            self.location.href = "/agencies/sams/sams-monthly-report/?ReportNo=" + document.GetSelectionInfo.ReportNo.value + "&FY=" + document.GetSelectionInfo.FY.value + "&Accounting_Period=" + document.GetSelectionInfo.Accounting_Period.value + "&Agency_No=&loadInfo=&AgencyTitle=AgencyNo";
            return true;
        }

    }

    function SetAgency() {
        if (document.GetSelectionInfo.ReportNo.value == 'SB05') {
            self.location.href = "/agencies/sams/sams-monthly-report/?ReportNo=" + document.GetSelectionInfo.ReportNo.value + "&FY=" + document.GetSelectionInfo.FY.value + "&Accounting_Period=" + document.GetSelectionInfo.Accounting_Period.value + "&Agency_No=" + document.GetSelectionInfo.Agency_No.value + "&loadInfo=Yes&AgencyTitle=FundNo";
            return true;
        }
        else {
            self.location.href = "/agencies/sams/sams-monthly-report/?ReportNo=" + document.GetSelectionInfo.ReportNo.value + "&FY=" + document.GetSelectionInfo.FY.value + "&Accounting_Period=" + document.GetSelectionInfo.Accounting_Period.value + "&Agency_No=" + document.GetSelectionInfo.Agency_No.value + "&loadInfo=Yes&AgencyTitle=AgencyNo";
            return true;
        }

    }

    function Instructions() {

        window.open("/ioc-pdf/SAMSMonthlyRpt/Instructions.pdf", "Instructions", "scrollbars=1", "width=800", "height-800");
    }
</script>

<cfinclude template="/customtags/GoogleAnalyticsObject.cfm">



