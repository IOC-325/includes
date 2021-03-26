<!---
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the FundBalance table to show a unformatted view of the Page F4 of the AFR

 --->

<!--- Pull of the unit's name --->
<CFLOCK SCOPE="Session" timeout="100">
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>
</cfoutput>
 
<!--- pulls off fields for Fund Balance --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_FundBalanceCategoryWH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFundBalanceCategoryInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFundBalanceCategoryInfoRetMsg">
	<cfprocresult name="GetFundBalanceCategoryWH">
</cfstoredproc>
</cfoutput>

<!--- Calculate CYE Fund Balance --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotFundBal301Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalGN" variable="TotFundBal301GN">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalSR" variable="TotFundBal301SR">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalCP" variable="TotFundBal301CP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDS" variable="TotFundBal301DS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalEP" variable="TotFundBal301EP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalTS" variable="TotFundBal301TS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalFD" variable="TotFundBal301FD">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDP" variable="TotFundBal301DP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalOT" variable="TotFundBal301OT">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotFundBal301RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotFundBal301RptRetMsg">
	<cfprocresult name="GetTotFundBal301Rpt">
</cfstoredproc>
</cfoutput>
 
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotFundBal306Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalGN" variable="TotFundBal306GN">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalSR" variable="TotFundBal306SR">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalCP" variable="TotFundBal306CP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDS" variable="TotFundBal306DS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalEP" variable="TotFundBal306EP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalTS" variable="TotFundBal306TS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalFD" variable="TotFundBal306FD">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDP" variable="TotFundBal306DP">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotFundBal306RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotFundBal306RptRetMsg">
	<cfprocresult name="GetTotFundBal306Rpt">
</cfstoredproc>
</cfoutput> 
	
<cfset url.PageType="Summary">
<cfset url.PageName="Fund Balance">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>

<h6 class="clearfix">
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2020/ABRReportTot/ABRSPPgF3.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=F3" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>
</cfif>
</cfoutput>
</h6>

<div class="table-responsive">
<table class="table table-bordered">
    <tr><td colspan="3" align="center"><b>Fund Balances and Other Financing Sources (Uses)</b></td></tr>
		<tr><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td><td align="center" valign="top"><b>Totals (Across All Funds)</b></td></tr>
		<cfoutput query="GetFundBalanceCategoryWH">
		<Cfset Category1=Left(Id, 4)>
		<cfif #Category1# is "307t">	
        	<cfset FndBal301Amount = Iif(TotFundBal301GN is "",0,NumberFormat(TotFundBal301GN,"999999999999999")) + Iif(TotFundBal301SR is "",0,NumberFormat(TotFundBal301SR,"999999999999999")) +  Iif(TotFundBal301OT is "",0,NumberFormat(TotFundBal301OT,"999999999999999"))>
			<cfset FndBal307Amount = Iif(TotAmount is "",0, NumberFormat(TotAmount,"999999999999999"))>
			<tr><td Colspan="3" align="center">Report in Whole Numbers</td></tr>
			<tr>
			<td><b>301t</b></td><td><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Excess of receipts/revenues over (under) expenditures/expenses (240t-270t)<cfif url.PrintIt is "no"></a></cfif></b></td>
			<td align="right">#NumberFormat(FndBal301Amount,"9999999999999999")#</td>
			</tr>
			<tr><td><b>#ID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#Description#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "308t">
			<cfset FndBal308Amount = Iif(TotAmount is "",0,NumberFormat(TotAmount,"999999999999999"))>
			<tr><td><b>#ID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#Description#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
			<tr><td><b>310t</b></td><td><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Current Year Ending Fund Balance (301 + 307 + 308)<cfif url.PrintIt is "no"></a></cfif></b></td>
			<cfset FndBalAmount = iif(FndBal301Amount is not "",NumberFormat(FndBal301Amount,"999999999999999"),0) + NumberFormat(FndBal307Amount,"999999999999999") + NumberFormat(FndBal308Amount,"999999999999999")>
			<td align="right">#NumberFormat(FndBalAmount)#</td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
    </div>
<!---		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">F3</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Abbreviated Form</center></td></tr>
         </table>--->
</cflock>
