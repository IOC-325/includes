<cfparam name="GETLASTUPDT" default="">

<!--- Get Last Date of Transactions  --->

<cfinvoke component = "/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
			method = "GetLastUpdt"
			srce="LedgerDB2"
			returnVariable = "GetLastUpdt">

<!--- <cfif isdefined("GETLASTUPDT")>	 --->

	<!--- Get Current Backlogs --->
	<cfinvoke component = "/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
			method = "GetBacklogs"
		  	LastUpdt = "#DateFormat(GetLastUpdt,"mm/dd/yyyy")#"
			srce="LedgerDB2"
			returnVariable = "GetBacklogs">

<!--- </cfif> --->
<cfoutput><a href="https://illinoiscomptroller.gov" title="Comptroller's Home Page">
<img src="#$.siteConfig('themeAssetPath')#/images/footer-logo.png" alt="Illinois Comptroller" class="home-logo" /></a>
</cfoutput>

<cftry>
	<!--- Add $2.2 Billion, which is the estmate of monies held at agencies  --->
		<!--- This will change from 2610000000 to 2476000000 on 1/20/18 at 8:00 AM --->
      <cfset variables.EstimateOfAmountAtAgencies = "2476000000">
			<cfset variables.TotalBacklog =	GetBacklogs.SumOfEnd_OF_DAY_BALANCE + variables.EstimateOfAmountAtAgencies>

	<cfoutput>
		<div class="amount">#DollarFormat(variables.TotalBacklog)#</div>
		<div class="text">estimated General funds payables backlog</div>
<!---		<div class="estimate visible-sm visible-xs">Includes estimated $4.5 billion worth of bills being held at state agencies.</div>--->
		<!--- Changing from getLastUpdt to Now() as per Chris Maley, User story 1195 --->
		<div class="date">as of #DateFormat(Now(),"m/d/yyyy")#</div>
		<a class="btn btn-default" href="/fiscal-condition/##general-funds ">more daily transactions</a>
		<!--- <p class="hidden-xs">The Ledger is your portal to state financial records, as well as official reports and analyses.</p> 
		<a class="down scroll hidden-xs" href="##believe"></a>--->
	</cfoutput>
<cfcatch type="any">

	<cfdump var="#cfcatch#">
	<cfabort>
	<span style="color:Gray;">Sorry, we could not process your request. </span><cfabort>
</cfcatch>
</cftry>
