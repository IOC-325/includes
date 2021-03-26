<!--- 
Created By: Gary Ashbaugh
Date Created: 11-29-11

Description:  The program will give the user the list of Daily Transactions: General Funds, Bond Ratings, Backlogs, and Voucher Backlogs.
---> 

	
<!---<link rel="stylesheet" type="text/css" href="/ledger/includes/themes/submersion/css/site.css">--->
<cfparam name="GETLASTUPDT" default="">

<cfoutput>
	
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
	
</cfoutput>

<cftry>
<!---
<table style="margin-top:0px;" align="left" bgcolor="#B8C4CC"  border="0" cellpadding="0" cellspacing="0" width="170" bordercolor="#000000" bordercolorlight="#000000">
<cfif GetDailyCashBalance.recordcount><tr class="myDailyStatsTitlerow"><td>
<!---<u><b>General Funds Daily Cash Transactions</b></u><br>--->
<span style="text-align: center;"><img alt="" src="/ledger/assets/Image/General_Funds_Daily_Cash_Transactions_160.png" /></span>
<p style="text-align:center; margin:0;"><cfoutput>As of #DateFormat(GetLastUpdt,"m/dd/yyyy")#</cfoutput>&nbsp; &nbsp; &nbsp;</p></td></tr></cfif>
<cfoutput>
<tr class="myDailyStatsrow"><td>Begin Daily Amount:<br>$#NumberFormat(GetDailyCashBalance.SumOfBEGIN_DAILY_AMT,"999,999,999,999,999.99")#</td></tr>
<tr class="myDailyStatsrow"><td>Receipt Amount:<br>$#NumberFormat(GetDailyCashBalance.SumOfRECEIPT_AMT,"999,999,999,999,999.99")#</td></tr>
<tr class="myDailyStatsrow"><td>Transfers In:<br>$#NumberFormat(GetDailyCashBalance.SumOfTRANS_IN_AMT,"999,999,999,999,999.99")#</td></tr>
<tr class="myDailyStatsrow"><td>Transfers Out:<br>$#NumberFormat(GetDailyCashBalance.SumOfTRANS_OUT_AMT,"999,999,999,999,999.99")#</td></tr>
<tr  class="myDailyStatsrow"><td>Net Warrants Issued:<br>$#NumberFormat(GetDailyCashBalance.NET_WARRANTS,"999,999,999,999,999.99")#</td></tr>
<tr  class="myDailyStatsrow"><cfset EndDailyAmount = GetDailyCashBalance.SumOfBEGIN_DAILY_AMT + GetDailyCashBalance.SumOfRECEIPT_AMT + GetDailyCashBalance.SumOfTRANS_IN_AMT + GetDailyCashBalance.SumOfTRANS_OUT_AMT + GetDailyCashBalance.NET_WARRANTS><td>End Daily Amount:<br>$#NumberFormat(EndDailyAmount,"999,999,999,999,999.99")#</td></tr>
</cfoutput>
<tr class="myDailyStatsTitlerow"><td>The General Funds include the General Revenue Fund and three education funds and is the state's largest and most important fund group.  For information on daily transactions in Illinois other active funds, please click <a href="https://www.wh1.ioc.state.il.us/?LINKSERVID=3A1AEDED-E0C7-3CE9-04B0FDB419895BBD">here</a>.</td></tr>
</table>
--->

<div style="width:190px;height:230px;-webkit-border-radius: 0px 0px 0px 20px;-moz-border-radius: 0px 0px 0px 20px;border-radius: 0px 0px 0px 20px;background-color: #F7F7F8;-webkit-box-shadow: #B8C4CC 5px 5px 5px;-moz-box-shadow: #B8C4CC 5px 5px 5px; box-shadow: #B8C4CC 5px 5px 5px; border:1px solid silver; margin-bottom:15px;">
<img alt="" src="/ledger/assets/Image/box_title_left_blue.png" width="190" /></span>
<p style="text-align:center; margin:5px 0 0 20px;"><cfoutput>As of #DateFormat(GetLastUpdt,"m/dd/yyyy")#</cfoutput>&nbsp; &nbsp; &nbsp;</p>
<cfoutput>
<p style="Padding-left:10px; font-variant:small-caps;">General Funds Payables:<br>$#NumberFormat(GetBacklogs.SumOfEND_OF_DAY_BALANCE,"999,999,999,999,999.99")#</p>

<!--- Comment out until issue is found --->

<p style="Padding-left:10px; font-variant:small-caps;">Number of Vouchers Backlogged:<br>#NumberFormat(GetVoucherBacklogs.TotVoucherBacklog,"999,999,999,999,999")#</p>
<!---<cfdump var="#GetVoucherBacklogs.TotVoucherBacklog#">--->
</cfoutput>
<p style="Padding-left:10px;">Includes vouchers and transfers to other state funds.</p>

</div>


<cfif GetDailyCashBalance.recordcount>
<div style="width:190px;height:530px;-webkit-border-radius: 0px 0px 0px 20px;-moz-border-radius: 0px 0px 0px 20px;border-radius: 0px 0px 0px 20px;background-color: #F7F7F8;-webkit-box-shadow: #B8C4CC 5px 5px 5px;-moz-box-shadow: #B8C4CC 5px 5px 5px; box-shadow: #B8C4CC 5px 5px 5px; border:1px solid silver; margin-bottom:15px;">
<img alt="" src="/ledger/assets/Image/General_Funds_Daily_Cash_Transactions_190.png" />
<!---<h3 style="text-align: center; padding:5px;">General Funds Daily Cash Transactions</h3>--->
<p style="text-align:center; margin:5px 0 0 10px;"><cfoutput>As of #DateFormat(GetLastUpdt,"m/dd/yyyy")#</cfoutput>&nbsp; &nbsp; &nbsp;</p>
<!---<cfinclude template="GetPackageInfo.cfm">--->
</cfif>
<cfoutput>
<p style="margin:5px; font-variant:small-caps;">Begin Daily Amount:<br><strong>$#NumberFormat(GetDailyCashBalance.SumOfBEGIN_DAILY_AMT,"999,999,999,999,999.99")#</strong></p>
<p style="margin:5px; font-variant:small-caps;">Receipt Amount:<br><strong>$#NumberFormat(GetDailyCashBalance.SumOfRECEIPT_AMT,"999,999,999,999,999.99")#</strong></p>
<p style="margin:5px; font-variant:small-caps;">Transfers In:<br><strong>$#NumberFormat(GetDailyCashBalance.SumOfTRANS_IN_AMT,"999,999,999,999,999.99")#</strong></p>
<p style="margin:5px; font-variant:small-caps;">Transfers Out:<br><strong>$#NumberFormat(GetDailyCashBalance.SumOfTRANS_OUT_AMT,"999,999,999,999,999.99")#</strong></p>
<p style="margin:5px; font-variant:small-caps;">Net Warrants Issued:<br><strong>$#NumberFormat(GetDailyCashBalance.NET_WARRANTS,"999,999,999,999,999.99")#</strong></p>
<p style="margin:5px; font-variant:small-caps;"><cfset EndDailyAmount = GetDailyCashBalance.SumOfBEGIN_DAILY_AMT + GetDailyCashBalance.SumOfRECEIPT_AMT + GetDailyCashBalance.SumOfTRANS_IN_AMT + GetDailyCashBalance.SumOfTRANS_OUT_AMT + GetDailyCashBalance.NET_WARRANTS>End Daily Amount:<br><strong>$#NumberFormat(EndDailyAmount,"999,999,999,999,999.99")#</strong></p>
</cfoutput><br />
<p style="margin:5px;">The General Funds include the General Revenue Fund and three education funds and is the state's largest and most important fund group.  For information on daily transactions in Illinois other active funds, please click <a href="https://www.wh1.ioc.state.il.us/?LINKSERVID=3A1AEDED-E0C7-3CE9-04B0FDB419895BBD">here</a>.</p>
</div>



<!---<table align="Center" bgcolor="#B8C4CC" border="1" style="border-style: double;" width="170" bordercolor="black" bordercolorlight="#000000" cellpadding="0" cellspacing="0">
<tr  class="myDailyStatsTitlerow"><td colspan="2"><span style="text-align: center;"><img alt="" src="/ledger/assets/Image/G_O_Bond_Rating_150.png" /></span><!---<center><b><u>G.O. Bond Rating</u></b></center>---></td></tr>
<cfoutput>
<tr class="myDailyStatsrow"><td>Moody's</td><td>#GetBondRating.Moodys#</td></tr>
<tr class="myDailyStatsrow"><td>S&P</td><td>#GetBondRating.SandP#</td></tr>
<tr class="myDailyStatsrow"><td>Fitch</td><td>#GetBondRating.Fitch#</td></tr>
<tr class="myDailyStatsrow"><td colspan="2"><center>(as of #DateFormat(GetBondRating.Updt_Date,"mmm yyyy")#)</center></td></tr>
</cfoutput>
<!---</table>
<table border="0" cellpadding="0" cellspacing="0"  width="190" bordercolor="#000000" bordercolorlight="#000000">--->
<tr  class="myDailyStatsTitlerow"><td colspan="2">These ratings reflect the views of the rating agencies and an explanation of the significance of such ratings may be obtained only from the respective rating agencies.</td></tr>
</table>--->

<div style="width:190px;height:300px;-webkit-border-radius: 0px 0px 0px 20px;-moz-border-radius: 0px 0px 0px 20px;border-radius: 0px 0px 0px 20px;background-color: #F7F7F8;-webkit-box-shadow: #B8C4CC 5px 5px 5px;-moz-box-shadow: #B8C4CC 5px 5px 5px; box-shadow: #B8C4CC 5px 5px 5px; border:1px solid silver; margin-bottom:15px;">
<span style="text-align: center;"><img alt="" src="/ledger/assets/Image/G_O_Bond_Rating_190.png" width="190" /></span>
<table align="center">
<cfoutput>
<tr class="myDailyStatsrow"><td style="font-variant:small-caps;">Moody's</td><td>#GetBondRating.Moodys#</td></tr>
<tr class="myDailyStatsrow"><td>S & P</td><td>#GetBondRating.SandP#</td></tr>
<tr class="myDailyStatsrow"><td>Fitch</td><td>#GetBondRating.Fitch#</td></tr>

</table>
<!---<p align="center">(as of #DateFormat(GetBondRating.Updt_Date,"mmm yyyy")#)</p>--->
<!---<table><tr><td><p style="margin:5px; font-variant:small-caps;">Moody's</p></td><td>#GetBondRating.Moodys#</td></tr></table>
<p style="margin:5px; font-variant:small-caps;">S&P&nbsp;: &nbsp;&nbsp;&nbsp;#GetBondRating.SandP#</p>
<p style="margin:5px; font-variant:small-caps;">Fitch&nbsp;: &nbsp;&nbsp;&nbsp;#GetBondRating.Fitch#</p>
<p style="margin:5px;"><center>(as of #DateFormat(GetBondRating.Updt_Date,"mmm yyyy")#)</center></p>--->
</cfoutput>
<!---</table>
<table border="0" cellpadding="0" cellspacing="0"  width="190" bordercolor="#000000" bordercolorlight="#000000">--->
<p style="margin:5px;">These ratings reflect the views of the rating agencies and an explanation of the significance of such ratings may be obtained only from the respective rating agencies.</p>
</div>




<!---<table align="left" border="0" bgcolor="#B8C4CC" cellpadding="0" cellspacing="0"  width="170" bordercolor="#000000" bordercolorlight="#000000">
<tr  class="myDailyStatsTitlerow"><td><span style="text-align: center;"><img alt="" src="/ledger/assets/Image/Backlogs_160.png" /></span><!---<b><u>Backlogs</u></b>---></td></tr>
<cfoutput>
<tr class="myDailyStatsrow"><td>General Funds Payables:<br>$#NumberFormat(GetBacklogs.SumOfEND_OF_DAY_BALANCE,"999,999,999,999,999.99")#</td></tr>
<tr class="myDailyStatsrow"><td>Number of Vouchers Backlogged:<br>#NumberFormat(GetVoucherBacklogs.TotVoucherBacklog,"999,999,999,999,999")#</td></tr>
</cfoutput>
<tr class="myDailyStatsTitlerow"><td>Includes vouchers and transfers to other state funds.</td></tr>
</table>
<hr />--->



<cfcatch type="any">
	<span style="color:Gray;">Sorry, we could not process your request.  The most likely reason is because the Daily Financial Transactions Database is currently being updated!  Please try again later.</span><cfabort>
</cfcatch>
</cftry>

