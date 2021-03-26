<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

<!---
	Modified Date: 11-18-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

	Description:  Allows the users to set a filter to limit the contract information displayed
--->


<CFHeader name="Cache-control" value="public">
<cfparam name="url.SortOrder" default="Number">

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">

<cfinclude template="TmpVendorapplicationSettings.cfm">


<cfoutput>



<CFQUERY NAME="AgcyList" DATASOURCE="DB2PRD" cachedwithin="#CreateTimeSpan(0,6,0,0)#">
SELECT * FROM 
WH.AGENCY_#application.CFY#
WHERE AGENCY IN( 'IPS' , 'ACC') or ((agency = '799') OR (agency = '899') OR(AGENCY < '699')) 
<cfif url.SortOrder is "Name">Order By Name<cfelse>ORDER BY Agency</cfif>
</CFQUERY>

<!--- <cfcatch type="database">
	 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
	</cfcatch>
</cftry> --->

<!--- <cftry> --->
<CFQUERY NAME="POTypeList" DATASOURCE="DB2PRD" CACHEDWITHIN="#CreateTimeSpan(0,6,0,0)#">
	SELECT * FROM wh.DESC_PO_TYPE
</CFQUERY>
<!--- <cfcatch type="database">
	 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
	</cfcatch>
</cftry> --->
</cfoutput>

<cfif not isdefined("session.TheVendTin")>
    <cflocation url="/vendors?TimedOut=True" addtoken="No">
</cfif>

<cfif isDefined("session.TheVendTin")>
 <cfset vendTIN = Decrypt(session.TheVendTin,"ITBG111")>
</cfif>

<CFSET Area = "Contracts">
<CFINCLUDE TEMPLATE="VendHeader.cfm">
<!---<div class="col-sm-12"><h2><center>Contract Form</center></h2></div>--->
<p id="instructions2">Use the Selection Criteria fields in the control panel to enter values which will limit your contract search 	and make it more efficient.</p>


<FORM METHOD="POST" role="form" class="form-horizontal" ACTION="/vendors/vendor-payments-new/vendor-contract-list/?Mode=ContForm&ValUser=True">
<CFOUTPUT>
<INPUT TYPE="hidden" name="SVendTIN" VALUE="#SVendTIN#">
<input type="hidden" name="VendTinName" value="#VendTinName#">
<input type="hidden" name="Mode" value="ContForm">
</CFOUTPUT>
<div class="text-center marginb20">
    <button name="FindContracts" id="FindContracts" VALUE="Find Contracts" class="btn btn-primary" tabindex="10">Find Contracts</button>
</div>

<div id="Heading"><p class="bold">Selection Criteria</p></div>

<div class="form-group">
    <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
        <label for="FY" id="FYlbl" class="control-label">Select a fiscal year</label>
    </div>
    <div class="col-sm-5">
        <select name="FY" id="FY" required class="form-control" tabindex="1">
            <CFOUTPUT>
            <OPTION SELECTED VALUE="#application.CFY#">#application.CFY#</OPTION>
            <OPTION VALUE="#Application.PFY#">#Application.PFY#</OPTION>
            <OPTION VALUE="#application.ppfy#">#application.ppfy#</OPTION>
            </CFOUTPUT>
        </select>
	</div>
</div>
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="Agency" id="Agencylbl" class="control-label">Select an agency</label>
	</div>
	<div class="col-sm-5">
        <select name="Agency" id="Agency" class="form-control"  tabindex="2">
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
            <a href="/vendors/vendor-payments-new/vendor-contract-form/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN, 'ITBG111'))#&Mode=#UrlEncodedFormat(Mode)#&VendTINName=#UrlEncodedFormat(VendTINName)#&SortOrder=Number">
            SORT BY</a><cfelse>
            <a href="/vendors/vendor-payments-new/vendor-contract-form/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN, 'ITBG111'))#&Mode=#UrlEncodedFormat(Mode)#&VendTINName=#UrlEncodedFormat(VendTINName)#&SortOrder=Name">
            SORT BY</a></cfif></td>
    <td class="SortHeader2 text-center"><cfif url.SortOrder is "Name">
            <a href="/vendors/vendor-payments-new/vendor-contract-form/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN, 'ITBG111'))#&Mode=#UrlEncodedFormat(Mode)#&VendTINName=#UrlEncodedFormat(VendTINName)#&SortOrder=Number">
            NUMBER</a><cfelse>
            <a href="/vendors/vendor-payments-new/vendor-contract-form/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN, 'ITBG111'))#&Mode=#UrlEncodedFormat(Mode)#&VendTINName=#UrlEncodedFormat(VendTINName)#&SortOrder=Name">
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
	<div class="col-sm-offset-2 col-sm-4">
    	<label for="ContAgy" id="ContAgylbl" class="control-label">Enter a contract agency and number: </label>
    </div>
    <div class="col-sm-2">
        <input type="text" id="ContAgy" name="ContAgy" class="form-control"  tabindex="3">
    </div>
    <div class="col-sm-2">
        <input type="text" id="ContSel" name="ContSel" class="form-control"  tabindex="4">
    </div>
</div>
--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="ContAgy" id="ContAgylbl" class="control-label">Enter a contract number</label>
    </div>
    <div class="col-sm-5">
        <input type="text" id="ContSel" name="ContSel" class="form-control"  tabindex="4" maxlength="11">
    </div>
</div>

<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="POType" id="POTypelbl" class="control-label">Select a contract type</label>
	</div>
	<div class="col-sm-5">
        <select name="POType" id="POType" class="form-control"  tabindex="5">
            <OPTION SELECTED>All</OPTION>
            <CFOUTPUT QUERY="POTypeList">
                <OPTION VALUE=#TYPE_OF_ORDER#>#TYPE_OF_ORDER# - #DESCRIPTION#</OPTION>
            </CFOUTPUT>
        </SELECT>
	</div>
</div>

	<p id="instructions2" class="margintop30">Use the Sort Criteria to control the order in which your contracts are displayed.</p>

<div id="Heading">
	<p class="bold">Sort Criteria</p>
</div>

<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="SortBy" id="SortBylbl" class="control-label">Select a sort field</label>
	</div>
	<div class="col-sm-5">
        <select name="SortBy" id="SortBy" class="form-control"  tabindex="6">
            <CFOUTPUT>
            <OPTION value="Contract Number">Contract Number</OPTION>
            <OPTION value="Total Contract Amount">Total Contract Amount</OPTION>
            <OPTION value="Obligated Amount">Obligated Amount</OPTION>
            <OPTION value="Expended Amount">Expended Amount</OPTION>
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
    	<label for="Max" id="Maxlbl" class="control-label">Number of Records returned at a time</label>
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
    <button name="FindContracts" id="FindContracts2" VALUE="Find Contracts" class="btn btn-primary" tabindex="9"> Find Contracts</button>
</div>

</FORM>
<!---</div>--->

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <!---<script src="/comptroller/jquery/jquery.js"></script>--->
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>

<script>
	$('#FindContracts').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to view information about contracts issued to this vendor."
	});
	$('#FindContracts2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to view information about contracts issued to this vendor."
	});
	$('#FY').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Select the State of Illinois fiscal year in which the contract was issued. Fiscal years begin July 1 and end June 30."
        });
	$('#Agency').tooltip({
		'show': false,
			'placement': 'top',
			'title': "OPTIONAL: Select the state agency that issued the contract."
	});
	$('#ContSel').tooltip({
		'show': false,
			'placement': 'top',
			'title': "OPTIONAL: Select the contract type."
	});
	$('#POType').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the Contract Type."
	});
	$('#SortBy').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the data field that should determine how the results are listed."
	});
	$('#SortAsc').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select this option if you want the results listed with the lowest value first (1-10; Z-A)"
	});
	$('#SortDesc').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select this option if you want the results listed with the highest value first (10-1; A-Z)"
	});
	$('#Max').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the number of deductions per page to view at one time."
	});
</script>

