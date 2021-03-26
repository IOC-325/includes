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

<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetVoucherBacklogs"
   srce="LedgerDB2"
   returnVariable = "GetVoucherBacklogs">

<cftry>
   <cfset variables.EstimateOfAmountAtAgencies = "4900000000">
   <cfset variables.TotalBacklog =
   GetBacklogs.SumOfEnd_OF_DAY_BALANCE +
   variables.EstimateOfAmountAtAgencies>
  <cfoutput>
   <div class="h2">Bill Backlog #DateFormat(GetLastUpdt,"m/d/yyyy")#</div>
   <div class="amount">#DollarFormat(variables.TotalBacklog)#</div>
   <div class="text">General funds payables backlog</div>
   <div class="estimate">The backlog includes what is currently at the Comptroller's Office and the estimated $4.9 billion with state agencies.</div>
   <div class="amount">#NumberFormat(GetVoucherBacklogs.TotVoucherBacklog,"999,999,999")#</div>
   <div class="text">vouchers backlogged</div>
   <div class="estimate">Includes vouchers and transfers to other state funds.</div>
   <div align="center"><img src="/ledger/includes/themes/TheLedger/display_objects/custom/fiscal-condition/billbacklogChart.png" class="img-responsive"/></div>
  </cfoutput>
<cfcatch type="any">
 <cfdump var="#cfcatch#">
 <cfabort>
 <span style="color:Gray;">Sorry, we could not process your request. </span><cfabort>
</cfcatch>
</cftry>
