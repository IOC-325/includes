<!---
Created By: Gary Ashbaugh
Date Created: 11-29-11

Description:  The program will give the user the list of Backlogs.
--->

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

<cftry>
	<!--- Add $ Billion, which is the estmate of monies held at agencies  --->
    <cfquery datasource="IOCReference" name="q1">
	SELECT BackLogAmount
    FROM BackLog
    </cfquery>
    <CFSET variables.BackLogNumber = VAL(q1.BackLogAmount)>
    <cfset variables.EstimateOfAmountAtAgencies = variables.BackLogNumber>
    <cfset variables.TotalBacklog = GetBacklogs.SumOfEnd_OF_DAY_BALANCE + variables.EstimateOfAmountAtAgencies>

	<cfoutput>
		<div class="home-ledger-box">
			<div class="col-xs-7">
		    <span class="ledger-title">THE LEDGER</span>
		  </div>
		  <div class="col-xs-5 ledger-backlog-div" style="text-align:center;">
		    <span class="ledger-backlog-text">
				<!--- Changing from getLastUpdt to Now() as per Chris Maley, User story 12344 --->
				<!--- User Story 1220 --->
		    	Estimated Bill Backlog <br>as of 8:00 AM #DateFormat(Now(),"m/dd/yy")#
		    </span>
		  </div>
		  <div class="col-xs-12">
		    <p class="backlog"><span class="ledger-backlog">$#NumberFormat(variables.TotalBacklog,"999,999,999,999,999")#</span></p>
		    <p class="text-center ledger-desc"><span class="ledger-backlog-desc">The Ledger houses state financial records and all reports</span></p>
		    <p class="text-center">
		      <a href="http://ledger.illinoiscomptroller.gov" class="btn btn-danger"><b>Learn More &raquo;</b></a>
		    </p>
		  </div>
		 </div>
		
	</cfoutput>
<cfcatch type="any">

	<cfdump var="#cfcatch#">
	<cfabort>
	<span style="color:Gray;">Sorry, we could not process your request. </span><cfabort>
</cfcatch>
</cftry>
