<!--- </cfif> --->
<cfoutput>
	<a href="https://illinoiscomptroller.gov" title="Illinois Comptroller's Office">
<img src="#$.siteConfig('themeAssetPath')#/images/footer-logo.png" alt="Illinois Comptroller" class="home-logo" />
		</a>
</cfoutput>

<!---<script src="/ledger/includes/themes/TheLedger/js/highcharts.js"></script>--->
<style type="text/css">.panel-body {
background:#F9F9F9;}
    </style>

				<!--- Website Offline? Make mention here. --->
				<!--- <p>Please note that the website will be offline for a short time due to routine maintenance over the weekend. We apologize for the inconvenience and appreciate your patience!</p> --->

	<!--- Add the estmate of monies held at agencies  --->

<cfinclude template="/ledger/includes/themes/TheLedger/display_objects/custom/fiscal-condition/BVREditable.cfm">
	

<cfoutput>			
<!--- Show a modified version of the Bill Backlog --->
<cfparam name="GETLASTUPDT" default="">
<!--- Get Last Date of Transactions  --->
<cfinvoke component = "/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
			method = "GetLastUpdt"
			srce="LedgerDB2"
			returnVariable = "GetLastUpdt">
	
<!--- Get Current Backlogs --->
<cfinvoke component = "/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
		method = "GetBacklogs"
		LastUpdt = "#DateFormat(GetLastUpdt,"mm/dd/yyyy")#"
		srce="LedgerDB2"
		returnVariable = "GetBacklogs">	

<cftry>
	<!--- Add the estmate of monies held at agencies - This will change from 2610000000 to 2476000000 on 1/20/18 at 8:00 AM --->
    <cfset variables.EstimateOfAmountAtAgencies = "2476000000">
	<cfset variables.TotalBacklog =	GetBacklogs.SumOfEnd_OF_DAY_BALANCE + variables.EstimateOfAmountAtAgencies>

	<cfoutput>
		<div class="amount">#DollarFormat(variables.TotalBacklog)#</div>
		<div class="text">Estimated General Funds Payables and State Agency Backlog</div>
		<!--- Changing from getLastUpdt to Now() as per Chris Maley, User story 1195 --->
		<div class="date">as of 8:00 AM #DateFormat(Now(),"m/d/yyyy")#</div>
		<a class="btn btn-default" style="margin-bottom: 0;" href="/fiscal-condition/##general-funds ">more daily transactions</a>
	</cfoutput>
<cfcatch type="any">

	<cfdump var="#cfcatch#">
	<cfabort>
	<span style="color:Gray;">Sorry, we could not process your request. </span><cfabort>
</cfcatch>
</cftry>
	
  </cfoutput>
