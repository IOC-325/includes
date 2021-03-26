<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">
<!---
	Created Date: 10-14-14
	Created By: Gary Ashbaugh
	
	Description: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

--->

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">

<cfif not isdefined("Session.VendTIN")>
	<cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>
<cfinclude template="TmpVendorapplicationSettings.cfm">
</cfLock>

<SCRIPT LANGUAGE = "JavaScript">
<!--

	function doDateCheck(from, to) {
	if (Date.parse(from.value) > Date.parse(to.value)) 
		{
			alert("The start date must occur before the end date.");
		return false;
		}
	}
	  
	function ChangeMostRecent() {
		if (document.Deduction.MostRecent[0].checked == true) {
			document.Deduction.StartDate.disabled = true;
			document.Deduction.EndDate.disabled = true;
		}
		else { 
			document.Deduction.StartDate.disabled = false;
			document.Deduction.EndDate.disabled = false;
			}
	}
 //-->
</script>

<CFSET Area = "DeductionForm">

<!---<BODY BGCOLOR="#FFFFFF">--->

<cfoutput>
<cfStoredProc  datasource="Deductions" Procedure="Get_LastIssueDate">
    <cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@Comp_Code" value="#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Actual_Code" value="#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLastIssueDateRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLastIssueDateRetMsg">
    <cfprocresult name="GetLastIssueDate">
</cfstoredproc>

<cfStoredProc  datasource="Deductions" Procedure="Get_LastWorkDate">
    <cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@Comp_Code" value="#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Actual_Code" value="#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Issue_Date" value="#DateFormat(GetLastIssueDate.Issue_Date,"mm/dd/yyyy")#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLastWorkDateRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLastWorkDateRetMsg">
    <cfprocresult name="GetLastWorkDate">
</cfstoredproc>

<cfStoredProc  datasource="Deductions" Procedure="Get_OldestIssueDate">
    <cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@Comp_Code" value="#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Actual_Code" value="#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetOldestIssueDateRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetOldestIssueDateRetMsg">
    <cfprocresult name="GetOldestIssueDate">
</cfstoredproc>

</cfoutput>

<CFINCLUDE TEMPLATE="VendHeader.cfm">


<!---<p id="instructions2"><b><font color="Red">Routine maintenance is going to be performed on this site on Tuesday, September 25 at 1:00 PM.  The application will not be available during this time.  Thank You for your patience!</font></b></p>--->

<!---<cfif trim(GetLastIssueDate.Issue_Date) is not "" and DateFormat(GetLastIssueDate.Issue_Date,"mm/dd/yyyy") LE DateFormat(DateAdd("d",1,now()),"mm/dd/yyyy")>--->
	<p id="instructions2"><cfoutput><b>Deductions listed is defaulted to "Most Recent" Gererated Date associated with #DateFormat(GetLastIssueDate.Issue_Date,"mm/dd/yyyy")# and is available after 9:00 AM.  However, you can select the  Anticipated Direct Deposit Dates between #DateFormat(dateadd("d",-30,GetLastIssueDate.Issue_Date),"mm/dd/yyyy")# and #DateFormat(GetLastIssueDate.Issue_Date,"mm/dd/yyyy")#.  This is the largest amount of data that most people can download.  You can override this setting by change the date range in the "Date Range" field.  <cfif GetOldestIssueDateRetVal is "0">The oldest Beginning Date you can select for #left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)##mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)# is #DateFormat(GetOldestIssueDate.Issue_Date,"mm/dd/yyyy")#.</cfif></b></cfoutput></p>
 
<!---<cfelseif trim(GetLastIssueDate.Issue_Date) is  "">
	<p id="instructions2"><cfoutput><b>Deductions is defaulted to "Most Recent" Generated Date associated with #DateFormat(now(),"mm/dd/yyyy")# and is available after 9:00 AM.  However, you can select Anticipated Direct Deposit Dates between #DateFormat(DateAdd("d",-30,now()),"mm/dd/yyyy")# and #DateFormat(DateAdd("d",1,now()),"mm/dd/yyyy")#.  This is the largest amount of data that most people can download.  You can override this setting by change the date range in the "Date Range" field.</b></cfoutput></p>
</cfif>--->

<!--- Calls VendWarrList from VendorEnhanced --->
<cfFORM METHOD="post" role="form" class="form-horizontal" ACTION="/vendors/enhanced-vendor-remittance/deduction-list/?Mode=Summ&ValUser=True" NAME="Deduction">

<cfoutput>
<!---<cfif trim(GetLastIssueDate.Issue_Date) is not "" and DateFormat(GetLastIssueDate.Issue_Date,"mm/dd/yyyy") LE DateFormat(DateAdd("d",1,now()),"mm/dd/yyyy")>
	<input type="hidden" name="MostRecentDate" value="#DateFormat(GetLastWorkDate.Work_Date,"mm/dd/yyyy")#">
    <input type="hidden" name="LastRecentDate" value="#DateFormat(GetLastIssueDate.Issue_Date,"mm/dd/yyyy")#">

<cfelseif trim(GetLastIssueDate.Issue_Date) is "">
	<input type="hidden" name="MostRecentDate" value="#DateFormat(now(),"mm/dd/yyyy")#">
    <input type="hidden" name="LastRecentDate" value="#DateFormat(dateadd("d",-1,now()),"mm/dd/yyyy")#">
</cfif>

--->


<cfif isdefined("GetLastWorkDate.Work_Date")>
	<input type="hidden" name="MostRecentDate" value="#DateFormat(GetLastWorkDate.Work_Date,"mm/dd/yyyy")#">
    <input type="hidden" name="LastRecentDate" value="#DateFormat(GetLastIssueDate.Issue_Date,"mm/dd/yyyy")#">
<cfelse>
	<input type="hidden" name="MostRecentDate" value="#DateFormat(now(),"mm/dd/yyyy")#">
    <input type="hidden" name="LastRecentDate" value="#DateFormat(dateadd("d",1,now()),"mm/dd/yyyy")#">
</cfif>

</cfoutput>
	
<div class="text-center marginb20">
    <button name="FindDeductions" id="FindDeductions" VALUE="Find Deductions" class="btn btn-primary" onclick="return doDateCheck(this.form.StartDate, this.form.EndDate);" tabindex="21"> Find Deductions</button>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
	<p id="Instructions2">Either select "Most Recent" or select "Date Range" and supply the Beginning and Ending dates.</p>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
	<div id="Heading"><p class="bold">Issue Date Range</p></div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="MostRecentY" id="MostRecentYlbl" class="control-label">Most Recent</label>
	</div>
	<div class="col-sm-5">
        <INPUT TYPE="radio" id="MostRecentY" class="Input-control" NAME="MostRecent" VALUE="Y" CHECKED onclick="ChangeMostRecent()">
	</div>
</div>
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3" id="Heading">Or</div>
</div>
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="MostRecentN" id="MostRecentNlbl" class="control-label">Date Range</label>
    </div>
	<div class="col-sm-5">
            <input type="radio" id="MostRecentN" class="Input-control" name="MostRecent" value="N" onclick="ChangeMostRecent()">
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="StartDate" id="StartDatelbl" class="control-label">Beginning Date</label>
    </div>
	<div class="col-sm-5">
		<cfoutput>
        <cfif trim(GetLastIssueDate.Issue_Date) is not "">
            <cfinput type="datefield" id="StartDate" class="form-control" NAME = "StartDate" VALIDATE="date" message="Enter a valid Beginning Date" value="#DateFormat(dateadd("d",-30,GetLastIssueDate.Issue_Date),"mm/dd/yyyy")#" disabled>
        <cfelse>
            <cfinput type="datefield" id="StartDate" class="form-control" NAME = "StartDate" VALIDATE="date" message="Enter a valid Beginngin Date" value="#DateFormat(dateadd("d",-30,now()),"mm/dd/yyyy")#" disabled>
        </cfif>
        </cfoutput>
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
    <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="EndDate" id="EndDatelbl" class="control-label">Ending Date</label>
    </div>
	<div class="col-sm-5">
		<cfoutput>
        <!---<cfif trim(GetLastIssueDate.Issue_Date) is not "" and DateFormat(GetLastIssueDate.Issue_Date,"mm/dd/yyyy") LE DateFormat(DateAdd("D",1,now()),"mm/dd/yyyy")>--->
            <cfINPUT type="datefield" id="EndDate" class="form-control" NAME = "EndDate" VALIDATE="date" message="Enter a valid Ending Date" value="#DateFormat(GetLastIssueDate.Issue_Date,"mm/dd/yyyy")#" disabled>
        <!---<cfelse>
            <cfINPUT type="datefield"  id="EndDate" class="form-control" NAME = "EndDate" VALIDATE="date" message="Enter a valid Ending Date" value="#DateFormat(dateadd("d",1,now()),"mm/dd/yyyy")#" disabled>
        </cfif>--->
        </cfoutput>
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
	<div id="Heading"><p class="bold">Sort Criteria</p></div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="SortBy" id="SortBylbl" class="control-label">Select a sort field</label>
	</div>
	<div class="col-sm-5">
        <select name="SortBy" class="form-control" id="SortBy">
            <CFOUTPUT>
            <OPTION value="Id">SSN</OPTION>
            <OPTION value="Employee_Name">Name</OPTION>
            <OPTION value="PP_Beginning_Date">PP Beginning Date</OPTION>
            <OPTION value="PP_Ending_Date">PP Ending Date</OPTION>
            <OPTION value="Work_Date">Generated Date</OPTION>
            <OPTION value="Issue_Date" selected>Anticipated Direct Deposit Date</OPTION>
            <OPTION value="Deduction_Amount">Deduction Amount</OPTION>
            <OPTION value="Pay_Code">Payroll Code</OPTION>
            </CFOUTPUT>
        </SELECT>
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
    <div class="col-sm-offset-5 col-sm-5">
        <INPUT TYPE="radio" id="SortAsc" NAME="AscDesc" VALUE="Asc" tabindex="10"><label for="SortAsc" id="SortAsclbl" class="control-label">&nbsp;Ascending</label>
        <INPUT TYPE="radio" id="SortDesc" NAME="AscDesc" VALUE="Desc" CHECKED tabindex="11" class="marginl15"><label for="SortDesc" id="SortDesclbl" class="control-label">&nbsp;Descending</label>
    </div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="Max" id="Maxlbl" class="control-label">Number of Records returned at a time</label>
	</div>
	<div class="col-sm-5">
        <select name="Max" id="Max">
            <CFOUTPUT>
                    <OPTION value="10">10</OPTION>
                    <OPTION value="20" SELECTED>20</OPTION>
                    <OPTION value="30">30</OPTION>
                    <OPTION value="40">40</OPTION>
                    <OPTION value="50">50</OPTION>
            </CFOUTPUT>
        </SELECT>
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="text-center">
    <button name="FindDeductions" id="FindDeductions2" VALUE="Find Deductions" class="btn btn-primary" onclick="return doDateCheck(this.form.StartDate, this.form.EndDate);" tabindex="21"> Find Deductions</button>
</div>
<!--- Use the Sort Criteria to control the order in which your warrants are displayed. --->
</cfFORM>
<!---</div>--->
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    

<script>
	$('#FindDeductions').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here after you have all of your filter elements supplied to view your Vendor's Deductions."
	});
	$('#FindDeductions2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here after you have all of your filter elements supplied to view your Vendor's Deductions."
	});
	$('#MostRecentY').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Click here if you want the most recent deductions."
        });
	$('#MostRecentN').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here if you want deductions for a specific date range.  Make sure you enter the Starting Deduction Issue Date and Ending Deduction Issue Date below."
	});
	$('#StartDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the starting issue date for your Deduction selection criteria."
	});
	$('#EndDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the ending issue date for your Deduction selection criteria."
	});
	$('#SortBy').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the field you want the list sorted by."
	});
	$('#SortAsc').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select this option if you want the list sorted in Ascending order."
	});
	$('#SortDesc').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select this option if you want the list sorted in Descending order."
	});
	$('#Max').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the number of deductions per page to view at one time."
	});
</script>
<!---
</BODY>
</HTML>
--->