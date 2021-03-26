<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

<!--- WH012 - 10/14/97

	WH00178
	Developer: ASP
	Date Completed: 7/11/00


	Modified Date: 11-21-00
	Modified By: Gary Ashbaugh
	Modifications Made: Add redirect when VendTIN is not defined

	 Modified Date: Wednesday, May 21, 2003 1:53:05 PM
			Modified By: Andrew Peterson
			Modifications Made: The form was posting to either .38 or .39 depending on a randomizer (randRange.cfm) but I switched this so that all queries would go to .38 since .39 has a problem with crashing
			Also added cfelse statement to move all queries to .38 because .39 is still crashing.

	Modification Date : 10.15.08
	SR : 				08103
	Modification  :		Download Function

	Modified Date: 11-18-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

	Description:  Allows the users to set a filter to limit the warrant information displayed

--->

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

<CFHeader name="Cache-control" value="public">
<cfparam name="url.SortOrder" default="Number">

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">
<cfif isdefined("URL.SVendTIN")>
 <CFSET SVendTin = URL.SVendTin>
<cfelseif isdefined("form.SVendTIN")>
 <CFSET SVendTin = form.SVendTin>
<!--- Code change by RK for SR 17070 starts here --->
<cfelseif isDefined("session.TheVendTin")>
 <cfSet SVendTin= session.TheVendTin>
<!--- Code change by RK for SR 17070 ends here --->
<cfelse>
 <cflocation url="/vendors?TimedOut=True" addtoken="No">
</cfif>

<cfif not isdefined("SVendTIN")>
	<!---<CFLOCATION URL="/QuickTake/Vend/">--->
    <cflocation url="/vendors?TimedOut=True" addtoken="No">
</cfif>

<cftry>
	<CFQUERY NAME="AgcyList" DATASOURCE="DB2PRD">
	SELECT * FROM wh.AGENCY_#application.CFY#
    WHERE AGENCY not IN ( <cfqueryparam cfsqltype="cf_sql_varchar" value="IPS" /> ,
    					 <cfqueryparam cfsqltype="cf_sql_varchar" value="ACC" />) or
                         ((agency = <cfqueryparam cfsqltype="cf_sql_varchar" value="799" />) or
                         ( agency = <cfqueryparam cfsqltype="cf_sql_varchar" value="899" />) OR
                         (AGENCY < <cfqueryparam cfsqltype="cf_sql_varchar" value="699" />))
    <cfif url.SortOrder is "Name">Order By Name<cfelse>ORDER BY Agency</cfif>
	</CFQUERY>
<cfcatch type="database">
	 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
	</cfcatch>
</cftry>

<CFSET Area = "Warrants">

<CFINCLUDE TEMPLATE="VendHeader.cfm">
<!---<div class="col-sm-12"><h2><center>Warrant Form</center></h2></div>--->
	<p id="instructions2">Use the Selection Criteria fields in the control panel to enter values which will limit your warrant search and make it more efficient.</p>

<cfinclude template="randRange.cfm">

<cfFORM role="form" class="form-horizontal" METHOD="post" ACTION="/vendors/vendor-payments-new/vendor-warrant-list/" NAME="DateForm">

<cfINPUT TYPE="hidden" name="SVendTIN" VALUE="#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#">
<cfinput type="hidden" name="VendTINName" value="#VendTINName#">
<cfinput type="hidden" name="Mode" value="#Mode#">
<div class="text-center">
    <button name="FindWarrants" id="FindWarrants" VALUE="Find Warrants" class="btn btn-primary" onclick="return doDateCheck(this.form.StartDate, this.form.EndDate);" tabindex="14"> Find Warrants</button>
</div>
<p class="bold margintop" id="Heading">Selection Criteria</p>

<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="FY" id="FYlbl" class="control-label">Select a fiscal year</label>
	</div>
<!--- User Story 1683 --->
    <cfset application.pppfy = (application.ppfy - 1)>
	<div class="col-sm-5">
        <select  required name="FY" id="FY" class="form-control"  tabindex="1">
            <CFOUTPUT>
            <OPTION SELECTED VALUE="#application.CFY#">20#application.CFY# (July 1, 20#application.pfy# to June 30, 20#application.cfy#)</OPTION>
            <OPTION VALUE="#Application.PFY#">20#Application.PFY# (7/1/20#application.ppfy# to 6/30/20#application.pfy#)</OPTION>
            <OPTION VALUE="#application.ppfy#">20#application.ppfy#  (7/1/20#application.pppfy# to 6/30/20#application.ppfy#)</OPTION>
            </CFOUTPUT>
        </select>
	</div>
</div>
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
        <div class="col-sm-offset-5 col-sm-3">
    <cfoutput>
        <table class="table table-bordered">
        <tr>
        <td class="SortHeader1 text-center"><cfif url.SortOrder is "Name">
            <a href="/vendors/vendor-payments-new/vendor-warrant-form/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN, 'ITBG111'))#&Mode=#UrlEncodedFormat(Mode)#&VendTINName=#UrlEncodedFormat(VendTINName)#&SortOrder=Number">
            SORT BY</a><cfelse>
            <a href="/vendors/vendor-payments-new/vendor-warrant-form/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN, 'ITBG111'))#&Mode=#UrlEncodedFormat(Mode)#&VendTINName=#UrlEncodedFormat(VendTINName)#&SortOrder=Name">
            SORT BY</a></cfif></td>
    <td class="SortHeader2 text-center"><cfif url.SortOrder is "Name">
            <a href="/vendors/vendor-payments-new/vendor-warrant-form/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN, 'ITBG111'))#&Mode=#UrlEncodedFormat(Mode)#&VendTINName=#UrlEncodedFormat(VendTINName)#&SortOrder=Number">
            NUMBER</a><cfelse>
            <a href="/vendors/vendor-payments-new/vendor-warrant-form/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN, 'ITBG111'))#&Mode=#UrlEncodedFormat(Mode)#&VendTINName=#UrlEncodedFormat(VendTINName)#&SortOrder=Name">
            NAME</a></cfif></td></tr>
    </table>
    </cfoutput>
    </div>
    <div class="form-group">
    <div class="col-sm-offset-1 col-sm-9 col-md-offset-2 col-md-8" id="SortFooter">The "Select an agency" list is currently sorted in
    <cfif url.SortOrder is "Number">Agency Number
        <cfelse>Agency Name</cfif> order.  Click on "Sort By" to sort it by
    <cfif url.SortOrder is "Number">Agency Name.
        <cfelse>Agency Number.</cfif></div>
</div>
<!---
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-5">
    	<label for="ContAgy" id="ContAgylbl" class="control-label">Enter a contract agency <i>and</i> number (optional): </label>
    </div>
    <div class="col-sm-2">
        <input type="text" id="ContAgy" name="ContAgcySel" class="form-control" tabindex="3">
    </div>
    <div class="col-sm-2">
        <input type="text" id="ContSel" name="ContSel" class="form-control" tabindex="4">
    </div>
    <div class="col-sm-2">&nbsp;</div>
</div>
--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="ContAgy" id="ContAgylbl" class="control-label">Enter a contract number (optional)</label>
    </div>
    <div class="col-sm-5">
        <input type="text" id="ContSel" name="ContSel" class="form-control" tabindex="4">
    </div>
</div>
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="InvSel" id="InvSellbl" class="control-label">Enter an invoice number (optional)</label>
    </div>
    <div class="col-sm-5">
    	<input type="text" id="InvSel" name="InvSel" class="form-control" tabindex="5">
    </div>
</div>

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

	<p class="bold margintop30" id="Heading">Date Range (Optional)</p>

<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="StartDate" id="StartDatelbl" class="control-label">Beginning Date</label>
    </div>
	<div class="col-sm-5">
		<cfoutput>
        <cfinput type="datefield" id="StartDate" NAME = "StartDate" class="form-control" VALIDATE="date" message="Enter a valid Beginngin Date"  tabindex="7">
        </cfoutput>
	</div>
</div>
<div class="form-group">
    <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="EndDate" id="EndDatelbl" class="control-label">Ending Date</label>
    </div>
	<div class="col-sm-5">
		<cfoutput>
        <cfINPUT type="datefield"  id="EndDate" NAME = "EndDate" class="form-control" VALIDATE="date" message="Enter a valid Ending Date"  tabindex="8">
        </cfoutput>
	</div>
</div>

	<p class="bold margintop30" id="Heading">Sort Criteria</p>

<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="SortBy" id="SortBylbl" class="control-label">Select a sort field</label>
	</div>
	<div class="col-sm-5">
        <select name="SortBy" id="SortBy" class="form-control" tabindex="9">
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

<div class="form-group">
	<div class="col-sm-offset-5 col-sm-5">
    	<INPUT TYPE="radio" id="SortAsc" class="control-label" NAME="AscDesc" VALUE="Asc" tabindex="10"> Ascending
    	<INPUT TYPE="radio" id="SortDesc" class="control-label marginl15" NAME="AscDesc" VALUE="Desc" CHECKED tabindex="11"> Descending
	</div>
</div>
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="Max" id="Maxlbl" class="control-label">Number of Records returned at a time: </label>
	</div>
	<div class="col-sm-5">
        <select name="Max" id="Max" class="control-label"  tabindex="12">
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
<div class="text-center">
    <button name="FindWarrants" id="FindWarrants2" VALUE="Find Warrants" class="btn btn-primary" onclick="return doDateCheck(this.form.StartDate, this.form.EndDate);" tabindex="13"> Find Warrants</button>
</div>

<!--- Use the Sort Criteria to control the order in which your warrants are displayed. --->

<!---</div>--->
</cfFORM>
<!---</div>--->

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!---<script src="/comptroller/jquery/jquery.js"></script>--->
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>

<script>
	$('#FindWarrants').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Search the vendor's payments with the applied filters."
	});
	$('#FindWarrants2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Search the vendor's payments with the applied filters."
	});
	$('#FY').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the State of Illinois fiscal year in which the payment was issued. Fiscal years begin July 1 and end June 30."
	});
	$('#Agency').tooltip({
		'show': false,
			'placement': 'top',
			'title': "OPTIONAL: Select the state agency that vouchered the payment."
	});
	$('#ContSel').tooltip({
		'show': false,
			'placement': 'top',
			'title': "OPTIONAL: Provide the contract's unique 11-digit identifier (if applicable)."
	});
	$('#InvSel').tooltip({
		'show': false,
			'placement': 'top',
			'title': "OPTIONAL: Provide the invoice's unique identifier."
	});
	$('#WarrantStatus').tooltip({
		'show': false,
			'placement': 'top',
			'title': "OPTIONAL: Select the payment’s current status."
	});
	$('#StartDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "OPTIONAL: Employ this feature to search for payments by the day they were issued by the Office of the Comptroller. Select the first calendar day you want to search within."
	});
	$('#EndDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "OPTIONAL: Employ this feature to search for payments by the day they were issued by the Office of the Comptroller. Select the last calendar day you want to search within."
	});
	$('#SortBy').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the data field that should determine how the results are listed."
	});
	$('#SortAsc').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select this option if you want the results listed with the lowest value first (1-10; Z-A)."
	});
	$('#SortDesc').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select this option if you want the results listed with the highest value first (10-1; A-Z)."
	});
	$('#Max').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the number of deductions per page to view at one time."
	});
</script>
