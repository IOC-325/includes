<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 3-13-00
Date Modified: 4-19-00
Modifications Made:  Changed to reflect new AFR
Modified By: Gary Ashbaugh
Date Modified: 6-1-00
Modified By: Gary Ashbaugh
Modifications Made: Added Unit Name and Code to the top of form
Date Modified: 8-27-01
Modified By: Gary Ashbaugh
Modifications Made: Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

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
	
<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="Summary">
<cfset url.PageName="Fund Balance">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h6>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2014/SPFReportTot/AFRSPPgF4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Special Purpose Form&Page=F4" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>

<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
<tr><td><font size="-1"><b><center>Fund Balances and Other Financing Sources (Uses)</center></b>&nbsp;</font></td></tr>
</table><br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box" width="100%">
		<tr><td <!--- bgcolor="silver" ---> align="center" valign="top" width="10%"><font size="-1"><b>Code</b>&nbsp;</font></td><td width="65%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Totals (Across All Funds)</b>&nbsp;</font></td></tr>
		<cfoutput query="GetFundBalanceCategoryWH">
		<Cfset Category1=Left(Id, 4)>
		<cfif #Category1# is "302t">	
        	<cfset FndBal301Amount = #iif(TotFundBal301GN is "",0,TotFundBal301GN)# + #iif(TotFundBal301SR is "",0,TotFundBal301SR)# + #iif(TotFundBal301CP is "",0,TotFundBal301CP)# + #iif(TotFundBal301DS is "",0,TotFundBal301DS)# + #iif(TotFundBal301EP is "",0,TotFundBal301EP)# + #iif(TotFundBal301TS is "",0,TotFundBal301TS)# + #iif(TotFundBal301FD is "",0,TotFundBal301FD)# + #iif(TotFundBal301DP is "",0,TotFundBal301DP)#>
			<tr><td Colspan=10><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers&nbsp;</font></td></tr>
			<tr>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>301t</b>&nbsp;</font></td><td><font size="-1"><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Excess of receipts/revenues over (under) expenditures/expenses (240t-270t)<cfif url.PrintIt is "No"></a></cfif></b></font></td>
			<td align="right"><font size="-1">#Numberformat(iif(FndBal301Amount is not "",NumberFormat(FndBal301Amount,"9999999999999999"),0))#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#Description#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "308t">
			<cfset FndBal308Amount = Iif(TotAmount is "",0,NumberFormat(TotAmount,"9999999999999999"))>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b></font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#Description#<cfif url.PrintIt is "No"></a></cfif>&nbsp;&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
			<tr><td colspan=10>&nbsp;</td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>310t</b></font></td><td><font size="-1"><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Current Year Ending Fund Balance (306 + 307 + 308)<cfif url.PrintIt is "No"></a></cfif></b>&nbsp;&nbsp;</font></td>
			<cfset FndBalAmount = iif(FndBal306Amount is not "",NumberFormat(FndBal306Amount,"9999999999999999"),0) + NumberFormat(FndBal307Amount,"9999999999999999") + NumberFormat(FndBal308Amount,"9999999999999999")>
			<td align="right"><font size="-1">#NumberFormat(FndBalAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "307t">
			<cfset FndBal307Amount = Iif(TotAmount is "",0,NumberFormat(TotAmount,"9999999999999999"))>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b></font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#Description#<cfif url.PrintIt is "No"></a></cfif>&nbsp;&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "305t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b></font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#Description#<cfif url.PrintIt is "No"></a></cfif>&nbsp;&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
			<cfset FndBal306Amount = #TotFundBal306GN# + #TotFundBal306SR# + #TotFundBal306CP# + #TotFundBal306DS# + #TotFundBal306EP# + #TotFundBal306TS# + #TotFundBal306FD# + #TotFundBal306DP#>
			<tr>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>306t</b>&nbsp;</font></td><td><font size="-1"><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Net increase (decrease) in fund balance (301t + 302t - 303t + 304t + 305t)<cfif url.PrintIt is "No"></a></cfif></b></font></td>
			<td align="right"><font size="-1">#Numberformat(iif(FndBal306Amount is not "",NumberFormat(FndBal306Amount,"9999999999999999"),0))#&nbsp;</font></td>
			</tr>
		<cfelse>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#Description#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
<!---		<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">F4&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Special Purpose Form&nbsp;</font></center></td></tr>
         </table>--->
<!---</body>
</html>--->
</cflock>
