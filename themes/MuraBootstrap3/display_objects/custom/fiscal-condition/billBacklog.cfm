<cfparam name="GETLASTUPDT" default="">

<!--- Get Last Date of Transactions  --->
<!--- SR 17070 Work Item 1016 --->

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

<cfinvoke component = "/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetVoucherBacklogs"
   srce="LedgerDB2"
   returnVariable = "GetVoucherBacklogs">

<cftry>   <!--- This will change from 2610000000 to 2476000000 on 1/20/18 at 8:00 AM --->
   <cfset variables.EstimateOfAmountAtAgencies = "2476000000">
   <cfset variables.InBillions = Left(variables.EstimateOfAmountAtAgencies,2)>
   <cfset variables.InBillionsDecimal = left(variables.InBillions,1) & "." & Right(variables.InBillions,1)>
   
   <!--- BUG WITH ROUNDING; NEED TO FIX Varibles.InBillonsDecimal; for now, hard coding it --->
   
   <cfset variables.InBillionsDecimal = "2.5">
   
   <cfset variables.TotalBacklog = GetBacklogs.SumOfEnd_OF_DAY_BALANCE + variables.EstimateOfAmountAtAgencies>
  <cfoutput>
   <div class="h2" style="text-align:left; margin-bottom:10px;">Bill Backlog</div>
   <!--- Per User Story 1220 --->
   <div class="h3" style="text-align:left;">As of 8:00 AM #DateFormat(Now(),"m/d/yyyy")#</div>   
   <div class="estimate" style="font-size:">The backlog includes what is currently at the Comptroller's Office and the estimated $#variables.InBillionsDecimal# billion with state agencies.</div>
	<!--- Changing from getLastUpdt to Now() as per Chris Maley, User story 1195 --->	  
   <div class="amount" style="font-size:26px;">#DollarFormat(variables.TotalBacklog)#</div>
   <div class="text" style="font-size:28px;">estimated General funds payables backlog</div>
   <hr>
   <div class="amount" style="font-size:26px;">#NumberFormat(GetVoucherBacklogs.TotVoucherBacklog,"999,999,999")#</div>
   <div class="text" style="font-size:28px;">vouchers backlogged</div>
   <div class="estimate">Includes vouchers and transfers to other state funds.</div>
   <div align="center"><img src="http://ledger.illinoiscomptroller.gov/ledger/includes/themes/TheLedger/display_objects/custom/fiscal-condition/billbacklogChart.png" class="img-responsive"/></div>
  </cfoutput>
<cfcatch type="any">
 <cfdump var="#cfcatch#">
 <cfabort>
 <span style="color:Gray;">Sorry, we could not process your request. </span><cfabort>
</cfcatch>
</cftry>
