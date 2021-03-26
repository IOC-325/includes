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

Modification Date: 11-7-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site

Description:  Allows the users to set a filter to limit the contract information displayed
--->

<CFHeader name="Cache-control" value="public">

<cfinclude template="TmpVendorapplicationSettings.cfm">
<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
<cfif not isdefined("Session.VendTIN")>
	<!--- Calls Index from VendorEnhanced --->
    <!--- Development & Production --->
	<cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">

</cfif>
</cfLock>
<cfinclude template="agencyquery.cfm">
<!---<CFQUERY NAME="AgcyList" DATASOURCE=#application.whDSN# CACHEDWITHIN="#CreateTimeSpan(1,0,0,0)#">
	SELECT * FROM #application.whOwner#AGENCY_#application.CFY#
</CFQUERY>--->
<CFQUERY NAME="POTypeList" DATASOURCE="DB2PRD" CACHEDWITHIN="#CreateTimeSpan(1,0,0,0)#">
	SELECT * FROM WH.DESC_PO_TYPE
</CFQUERY>


<CFSET Area = "Contracts">
<CFINCLUDE TEMPLATE="VendHeader.cfm">

<!--- Calls VendContList from VendorEnhanced --->
<p id="instructions2">Use the Selection Criteria fields in the control panel to enter values which will limit your contract search 	and make it more efficient.</p>
<!---
<div name="FormWrapper" id="FormWrapper" class="col-sm-12">--->
<form role="form" class="form-horizontal" METHOD="POST" ACTION="/vendors/enhanced-vendor-remittance/vendor-contract-list/?Mode=Summ&ValUser=True">
<div class="text-center marginb20">
    <button name="FindContracts" id="FindContracts" VALUE="Find Contracts" class="btn btn-primary" tabindex="10">Find Contracts</button>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
	<div id="Heading"><p class="bold">Selection Criteria</p></div>

<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="FY" id="FYlbl" class="control-label">Select a fiscal year</label>
	</div>
	<div class="col-sm-5">
        <select name="FY" required class="form-control" id="FY" tabindex="1">
            <CFOUTPUT>
            <OPTION SELECTED VALUE="#application.CFY#">#application.CFY#</OPTION>
            <OPTION VALUE="#Application.PFY#">#Application.PFY#</OPTION>
            <OPTION VALUE="#application.ppfy#">#application.ppfy#</OPTION>
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
        <select name="Agency" class="form-control" id="Agency" tabindex="2">
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
    	<label for="ContAgy" id="ContAgylbl" class="control-label">Enter a contract number</label>
    </div>
<!---    <div class="col-sm-2">
        <input type="text" id="ContAgy" class="form-control" name="ContAgy"  tabindex="3">
    </div>--->
    <div class="col-sm-5">
        <input type="text" id="ContSel" class="form-control" name="ContSel" tabindex="4">
    </div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="POType" id="POTypelbl" class="control-label">Select a contract type</label>
	</div>
	<div class="col-sm-5">
        <select name="POType" id="POType" class="form-control" tabindex="5">
            <OPTION SELECTED>All</OPTION>
            <CFOUTPUT QUERY="POTypeList">
                <OPTION VALUE=#TYPE_OF_ORDER#>#TYPE_OF_ORDER# - #DESCRIPTION#</OPTION>
            </CFOUTPUT>
        </SELECT>
	</div>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="margintop30">
	<p id="instructions2">Use the Sort Criteria to control the order in which your contracts are displayed.</p>
</div>
<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
	<div id="Heading"><p class="bold">Sort Criteria</p></div>

<!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
<div class="form-group">
	<div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
    	<label for="SortBy" id="SortBylbl" class="control-label">Select a sort field</label>
	</div>
	<div class="col-sm-5">
        <select name="SortBy" class="form-control" id="SortBy" tabindex="6">
            <CFOUTPUT>
            <OPTION value="Contract Number">Contract Number</OPTION>
            <OPTION value="Total Contract Amount">Total Contract Amount</OPTION>
            <OPTION value="Obligated Amount">Obligated Amount</OPTION>
            <OPTION value="Expended Amount">Expended Amount</OPTION>
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
        <select name="max" id="Max" tabindex="12">
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
    <button name="FindContracts" id="FindContracts2" VALUE="Find Contracts" class="btn btn-primary" tabindex="9">Find Contracts</button>
</div>
</form>
<!---</div>--->

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    

<script>
	$('#FindContracts').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here after you have all of your filter elements supplied to view your Vendor's Contracts."
	});
	$('#FindContracts2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here after you have all of your filter elements supplied to view your Vendor's Contracts."
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
	$('#POType').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the Contract Type."
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
</script>
