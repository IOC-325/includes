<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">


<!---
	Modified Date: 4-27-12
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Enhanced Vendor Remittance Site per SR11108 based on the regular site but requiring a UserID/Password

	Modified Date: 10-14-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

Description:  Allows the users to set a filter to limit the warrant information displayed
--->

<CFHeader name="Cache-control" value="public">

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
<cfif not isdefined("Session.VendTIN")>
	<!--- Calls Index from VendorEnhanced --->
	<cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>
<cfset Session.MyTRANSACTION_NUMBER=arraynew(1)>
<cfinclude template="TmpVendorapplicationSettings.cfm">
</cfLock>

<cfoutput>
<cfif (dateformat(now(),"mm") ge "01") and  (dateformat(now(),"mm") lt "07")>
	<cfset TmpDt = "20" & "#dateformat(now(),"YY")#">
<cfelse>
	<cfset TmpDt2 = DateAdd("YYYY",1,now())>
	<cfset TmpDt = "20" & "#dateformat(TmpDt2,"YY")#">
</cfif>

<CFQUERY NAME="GetDtRange"  DATASOURCE="VendorDB2"  cachedwithin="#CreateTimeSpan(0,12,0,0)#" >

 	SELECT 	DISTINCT #application.whOwner#IOC_WARR_HDR.RECORD_DATE
 	FROM 	#application.whOwner#IOC_WARR_HDR
	WHERE	<CFLOCK SCOPE="Session" timeout="120"  type="readonly">#application.whOwner#IOC_WARR_HDR.VENDOR_TIN =  <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"> </CFLOCK>
        and #application.whOwner#ioc_WARR_HDR.Fiscal_Year = <cfqueryparam cfsqltype="cf_sql_smallint" value="#TmpDt#">
    order by Record_Date desc
	fetch first 1 rows only
</CFQUERY>
</cfoutput>

<SCRIPT LANGUAGE = "JavaScript">
<!--

// function to load the calendar window.
function ShowCalendar(FormName, FieldName)
{
	window.open("CFDateSelectPopupWindow.cfm?FormName=" + FormName + "&FieldName=" + FieldName, "CalendarWindow", "width=200,height=220");
}

function doDateCheck(from, to) {
if (Date.parse(from.value) > Date.parse(to.value))
	{
		alert("The start date must occur before the end date.");
	return false;
	}
}
-->
</SCRIPT>
<cfinclude template="agencyquery.cfm">


<CFSET Area = "Warrants">

<CFINCLUDE TEMPLATE="VendHeader.cfm">
<p id="instructions2">Use the Selection Criteria fields in the control panel to enter values which will limit your warrant search and make it more efficient.</p>

<cfif trim(GetDtRange.Record_Date) is not "">
<p id="instructions2"><cfoutput><b>By default, this query will search for payments issued in the last 30 days of the selected fiscal year in order to avert potential connection issues.  You can override this setting by changing the date range in the "Date Range" field.</b></cfoutput></p>
<!---
	<p id="instructions2"><cfoutput><b>Warrants listed have Record Dates between #DateFormat(dateadd("d",-30,GetDtRange.Record_Date),"mm/dd/yyyy")# and #DateFormat(now(),"mm/dd/yyyy")#.  This is the largest amount of data that most people can download.  However, you can override this setting by change the date range in the "Date Range" field.</b></cfoutput></p>
--->
</cfif>
<!--- Calls VendWarrList from VendorEnhanced --->
<!---<div name="FormWrapper" id="FormWrapper" class="col-sm-12">--->
<cfFORM role="form" class="form-horizontal" METHOD="post" ACTION="/vendors/enhanced-vendor-remittance/vendor-warrant-list/?Mode=Summ&ValUser=True" NAME="DateForm">
<div class="text-center">
    <button name="FindWarrants" id="FindWarrants" VALUE="Find Warrants" class="btn btn-primary" onclick="return doDateCheck(this.form.StartDate, this.form.EndDate);" tabindex="14">Find Warrants</button>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<p class="text-danger margintop"><b><cfoutput>To view payment/contract information from FY 20#application.pfy#, be sure to select it from the "fiscal year" drop down.</cfoutput></b></p>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
	<p class="bold" id="Heading">Selection Criteria</p>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="FY" id="FYlbl" class="control-label">Select a fiscal year</label>
	</div>
	<div class="col-sm-5">
        <select name="FY" id="FY" required class="form-control" tabindex="1">
            <CFOUTPUT>
            <cfset TmpBegCFY=#application.CFY#-1>
            <cfset TmpBegPFY=#application.PFY#-1>
            <cfset TmpBegPPFY=#application.PPFY#-1>
            <OPTION SELECTED VALUE="#application.CFY#">FY 20#application.CFY# (07/01/#TmpBegCFY# to 06/30/#application.CFY#)</OPTION>
            <OPTION VALUE="#Application.PFY#">FY 20#application.PFY# (07/01/#TmpBegPFY# to 06/30/#Application.PFY#)</OPTION>
            <OPTION VALUE="#application.ppfy#">FY 20#application.PPFY# (07/01/#TmpBegPPFY# to 06/30/#application.ppfy#)</OPTION>
            </CFOUTPUT>
        </select>
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="Agency" id="Agencylbl" class="control-label">Select an agency</label>
	</div>
	<div class="col-sm-5">
        <select name="Agency" id="Agency" class="form-control" tabindex="2">
            <OPTION SELECTED>All</OPTION>
            <CFOUTPUT QUERY="AgcyList">
            	<cfif Agency is not "ACC" and Agency is not "IPS" and Agency lt "700">
                <OPTION VALUE=#Agency#>#Agency# - #Name#</OPTION>
                </cfif>
            </CFOUTPUT>
        </SELECT>
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="ContAgy" id="ContAgylbl" class="control-label">Enter a contract number (optional)</label>
    </div>
   <!--- <div class="col-sm-2">
            <input type="text" id="ContAgy" class="form-control" name="ContAgcySel" tabindex="3">
    </div>--->
    <div class="col-sm-5">
            <input type="text" id="ContSel" class="form-control" name="ContSel"  tabindex="4">
    </div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="InvSel" id="InvSellbl" class="control-label">Enter an invoice number (optional)</label>
    </div>
    <div class="col-sm-5">
            <input type="text" id="InvSel" class="form-control" name="InvSel"  tabindex="5">
    </div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="WarrantStatus" id="WarrantStatuslbl" class="control-label">Select a warrant status</label>
    </div>
    <div class="col-sm-5">
        <SELECT NAME="Status" id="WarrantStatus" class="form-control"  tabindex="6">
            <CFOUTPUT>
                <OPTION SELECTED>All</OPTION>
                <OPTION value="A">A - Requested Agency Stop</OPTION>
                <OPTION value="B">B - Requested Payee Stop</OPTION>
                <OPTION value="D">D - Confirmed Agency Stop</OPTION>
                <OPTION value="E">E - Escheated</OPTION>
                <OPTION value="F">F - Confirmed Payee Stop</OPTION>
                <OPTION value="G">G - Escheatable</OPTION>
                <OPTION value="H">H - Held</OPTION>
                <OPTION value="I">I - Voided and Replaced (Offset)</OPTION>
                <OPTION value="J">J - Undeliverable</OPTION>
                <OPTION value="K">K - Requested Payee Rescind Stop</OPTION>
                <OPTION value="O">O - Issued and Outstanding</OPTION>
                <OPTION VALUE="P">P - Paid</OPTION>
                <OPTION VALUE="Q">Q - Canceled for Redeposit</OPTION>
                <OPTION value="T">T - Canceled for Redeposit (Undel)</OPTION>
                <OPTION value="V">V - Voided and Replaced (Lost)</OPTION>
                <OPTION value="W">W - Request Agency Rescind Stop</OPTION>
            </CFOUTPUT>
        </SELECT>
    </div>
</div>

	<p class="bold margintop" id="Heading">Date Range</p>

<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="StartDate" id="StartDatelbl" class="control-label">Beginning Date</label>
    </div>
	<div class="col-sm-5">
		<cfoutput>
        <cfif trim(GetDtRange.Record_Date) is not "">
            <cfinput type="datefield" id="StartDate" class="form-control" NAME = "StartDate" VALIDATE="date" message="Enter a valid Beginning Date" value="#DateFormat(dateadd("d",-30,GetDtRange.Record_Date),"mm/dd/yyyy")#"  tabindex="7">
        <cfelse>
            <cfinput type="datefield" id="StartDate" class="form-control" NAME = "StartDate" VALIDATE="date" message="Enter a valid Beginngin Date" value="#DateFormat(dateadd("d",-30,now()),"mm/dd/yyyy")#"  tabindex="7">
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
       <cfINPUT type="datefield"  id="EndDate" class="form-control" NAME = "EndDate" VALIDATE="date" message="Enter a valid Ending Date" value="#DateFormat(now(),"mm/dd/yyyy")#"  tabindex="8">

        </cfoutput>
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>	--->

	<p class="bold margintop">Sort Criteria</p>

<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="SortBy" id="SortBylbl" class="control-label">Select a sort field</label>
	</div>
	<div class="col-sm-5">
        <select name="SortBy" class="form-control" id="SortBy" tabindex="9">
            <CFOUTPUT>
            <OPTION value="Warrant Number">Warrant Number</OPTION>
            <OPTION value="Total Warrant Amount">Total Warrant Amount</OPTION>
            <OPTION value="Status">Status</OPTION>
            <OPTION value="Record Date" selected="selected">Issue Date</OPTION>
            <OPTION value="Paid Date">Paid Date</OPTION>
            </CFOUTPUT>
        </SELECT>
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-5 col-sm-5">
        <INPUT TYPE="radio" id="SortAsc" NAME="AscDesc" VALUE="Asc" tabindex="10"><label for="SortAsc" id="SortAsclbl" class="control-label">&nbsp;Ascending</label>
        <INPUT TYPE="radio" id="SortDesc" class="marginl15"  NAME="AscDesc" VALUE="Desc" CHECKED tabindex="11"><label for="SortDesc" id="SortDesclbl" class="control-label">&nbsp;Descending</label>
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="Max" id="Maxlbl" class="control-label">Number of Records returned at a time</label>
	</div>
	<div class="col-sm-5">
        <select name="Max" id="Max" class="form-control" tabindex="12">
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
    <button name="FindWarrants" id="FindWarrants2" VALUE="Find Warrants" class="btn btn-primary" onclick="return doDateCheck(this.form.StartDate, this.form.EndDate);" tabindex="13">Find Warrants</button>
</div>

<!--- Use the Sort Criteria to control the order in which your warrants are displayed. --->
</cfFORM>
<!---</div>--->
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>


<script>
	$('#FindWarrants').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here after you have all of your filter elements supplied to view your Vendor's Warrants."
	});
	$('#FindWarrants2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here after you have all of your filter elements supplied to view your Vendor's Warrants."
	});
	$('#FY').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Select the Fiscal Year for the contract you are look to view."
        });
	$('#Agency').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the Agency which the encumbered."
	});
	$('#ContAgy').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter the Contract Agency."
	});
	$('#ContSel').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter the Contract Number."
	});
	$('#InvSel').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the Invoice Number."
	});
	$('#WarrantStatus').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the Warrant Status."
	});
	$('#StartDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the starting issue date for your Payment selection criteria."
	});
	$('#EndDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the ending issue date for your Payment selection criteria."
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
<!---</BODY>
</HTML>--->