<!--- 
Created By: Gary Ashbaugh
Date Created: 11-29-11

Description:  The program will give the user the list of Daily Transactions: General Funds, Bond Ratings, Backlogs, and Voucher Backlogs.
---> 

	
<!---<link rel="stylesheet" type="text/css" href="/ledger/includes/themes/submersion/css/site.css">--->
<cfparam name="GETLASTUPDT" default="">
	
<!--- Get Last Date of Transactions  --->

<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions" 
			method = "GetLastUpdt" 
			srce="LedgerDB2" 
			returnVariable = "GetLastUpdt">
			
<!--- DB2 Version --->
<!---
<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions" 
			method = "GetLastUpdt" 
			srce="DB2PRD" 
			returnVariable = "GetLastUpdt">
--->
		 	
<!--- Get General Funds Daily Cash Transactions ---> 
<cfif isdefined("GETLASTUPDT")>
	<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions" 
			method = "GetDailyCashBalance" 
		  	LastUpdt = "#DateFormat(GetLastUpdt,"mm/dd/yyyy")#"
			srce="LedgerDB2" 
			returnVariable = "GetDailyCashBalance">
			
	<!--- DB2 Version --->
	<!---
	<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions" 
			method = "GetDailyCashBalance" 
		  	LastUpdt = "#DateFormat(GetLastUpdt,"mm/dd/yyyy")#"
			srce="DB2PRD" 
			returnVariable = "GetDailyCashBalance">
	--->
			
	<!--- Get Current Bond Ratings --->
	<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions" 
			method = "GetBondRating" 
			srce="General" 
			returnVariable = "GetBondRating">
			
			
	<!--- Get Current Backlogs --->
	<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions" 
			method = "GetBacklogs" 
		  	LastUpdt = "#DateFormat(GetLastUpdt,"mm/dd/yyyy")#"
			srce="LedgerDB2" 
			returnVariable = "GetBacklogs">
			
	<!--- DB2 Version --->
	<!---
	<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions" 
			method = "GetBacklogs" 
		  	LastUpdt = "#DateFormat(GetLastUpdt,"mm/dd/yyyy")#"
			srce="DB2PRD" 
			returnVariable = "GetBacklogs">
	--->
</cfif>
		
<!--- Get Current Voucerh Backlogs --->
<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions" 
			method = "GetVoucherBacklogs" 
			srce="LedgerDB2" 
			returnVariable = "GetVoucherBacklogs">
		
<!--- DB2 Version --->
<!---
<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions" 
			method = "GetVoucherBacklogs" 
			srce="DB2PRD" 
			returnVariable = "GetVoucherBacklogs">
--->

<cftry>
	<cfoutput>
		<div class="right-box">
		  <img src="#$.siteConfig('themeAssetPath')#/images/back.png" class="img-responsive" alt="">

		  <p class="text-center">As of #DateFormat(GetLastUpdt,"m/dd/yyyy")#</p>
		  <p class="small-caps">General Funds Payables:<br>$#NumberFormat(GetBacklogs.SumOfEND_OF_DAY_BALANCE,"999,999,999,999,999.99")#</p>
		  <p class="small-caps">Number of Vouchers Backlogged: <br>#NumberFormat(GetVoucherBacklogs.TotVoucherBacklog,"999,999,999,999,999")#</p>
		  <p>Includes vouchers and transfers to other state funds.</p>
		</div>

		<cfif GetDailyCashBalance.recordcount>
			<cfset EndDailyAmount = GetDailyCashBalance.SumOfBEGIN_DAILY_AMT + GetDailyCashBalance.SumOfRECEIPT_AMT + GetDailyCashBalance.SumOfTRANS_IN_AMT + GetDailyCashBalance.SumOfTRANS_OUT_AMT + GetDailyCashBalance.NET_WARRANTS>

			<div class="right-box">
			  <img src="#$.siteConfig('themeAssetPath')#/images/trans.png" class="img-responsive" alt="">
			  <p class="text-center">As of #DateFormat(GetLastUpdt,"m/dd/yyyy")#</p>
			  <p class="small-caps">Begin Daily Amount:<br><strong>$#NumberFormat(GetDailyCashBalance.SumOfBEGIN_DAILY_AMT,"999,999,999,999,999.99")#</strong></p>
			  <p class="small-caps">Receipt Amount:<br><strong>$#NumberFormat(GetDailyCashBalance.SumOfRECEIPT_AMT,"999,999,999,999,999.99")#</strong></p>
			  <p class="small-caps">Transfers In:<br><strong>$#NumberFormat(GetDailyCashBalance.SumOfTRANS_IN_AMT,"999,999,999,999,999.99")#</strong></p>
			  <p class="small-caps">Transfers Out:<br><strong>$#NumberFormat(GetDailyCashBalance.SumOfTRANS_OUT_AMT,"999,999,999,999,999.99")#</strong></p>
			  <p class="small-caps">Net Warrants Issued:<br><strong>$#NumberFormat(GetDailyCashBalance.NET_WARRANTS,"999,999,999,999,999.99")#</strong></p>
			  <p class="small-caps">End Daily Amount:<br><strong>$#NumberFormat(EndDailyAmount,"999,999,999,999,999.99")#</strong></p>
			  <p>The General Funds include the General Revenue Fund and three education funds and is the state's largest and most important fund group.  For information on daily transactions in Illinois other active funds, please click <a href="https://www.wh1.ioc.state.il.us/?LINKSERVID=3A1AEDED-E0C7-3CE9-04B0FDB419895BBD">here</a> .</p>
			</div>
		</cfif>

	    <div class="right-box">
	      <img src="#$.siteConfig('themeAssetPath')#/images/rating.png" class="img-responsive" alt="">
	      <div class="row">
	        <div class="col-xs-4">
	          <p>MOODY'S</p>
	        </div>
	        <div class="col-xs-8">
	          <p>#GetBondRating.Moodys#</p>
	        </div>
	      </div>
	      <div class="row">
	        <div class="col-xs-4">
	          <p>S&amp;P</p>
	        </div>
	        <div class="col-xs-8">
	          <p>#GetBondRating.SandP#</p>
	        </div>
	      </div>
	      <div class="row">
	        <div class="col-xs-4">
	          <p>Fitch</p>
	        </div>
	        <div class="col-xs-8">
	          <p>#GetBondRating.Fitch#</p>
	        </div>
	      </div>
	      <p>These ratings reflect the views of the rating agencies and an explanation of the significance of such ratings may be obtained only from the respective rating agencies.</p>
	    </div>
	</cfoutput>
<cfcatch type="any">
<cfdump var="#cfcatch#">
<cfabort>
	<span style="color:Gray;">Sorry, we could not process your request.  The most likely reason is because the Daily Financial Transactions Database is currently being updated!  Please try again later.</span><cfabort>
</cfcatch>
</cftry>

