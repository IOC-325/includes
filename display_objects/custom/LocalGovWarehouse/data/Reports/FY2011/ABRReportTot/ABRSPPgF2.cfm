<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the Expenditures table to show a unformatted view of the Page F3 of the AFR

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
 
<!--- pulls off fields for Expenditures --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpCategoryAbbrPgF2WH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpCategoryAbbrPgF2RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpCategoryAbbrPgF2RptRetMsg">
	<cfprocresult name="GetExpCategoryAbbrPgF2WH">
</cfstoredproc>
</cfoutput>

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpAbbrPerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpPerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpPerctRptRetMsg">
	<cfprocresult name="GetExpPerctRpt">
</cfstoredproc>
</cfoutput>

<!---
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotExpenditure">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotExpenditureRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotExpenditureRetMsg">
	<cfprocresult name="GetTotExpenditure">
</cfstoredproc>
</cfoutput> 
--->
 
<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="Summary">
<cfset url.PageName="Expenditures">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h6><a href="#PercAmt">View Percentages for Expenditures</a> 
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2011/ABRReportTot/ABRSPPgF2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=F2" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h6>

<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
<tr><td><font size="-1"><b><center>Disbursements, Expenditures and Expenses</center></b>&nbsp;</font></td></tr>
</table>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box" width="100%">
		<tr><td <!--- bgcolor="silver" ---> align="center" valign="top" width="5%"><font size="-1"><b>Code</b>&nbsp;</font></td><td width="30%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b>&nbsp;</font></td><td align="center" valign="top" width="20%"><font size="-1"><b>Totals (Across All Funds)</b>&nbsp;</font></td></tr>
		<Cfset TotalExpenditure=0>
		<cfoutput query="GetExpCategoryAbbrPgF2WH">
		<Cfset Category1=Left(DispID, 4)>
		<cfif #Category1# is "251t"><Cfset TotalExpenditure=TotalExpenditure+#TotAmount#>
			<tr><td Colspan=10><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers&nbsp;</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#</font></td>
			</tr>
		<cfelseif #Category1# is "260t"><Cfset TotalExpenditure=TotalExpenditure+#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>270t</b></td><td><font size="-1"><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Expenditures/Expense<cfif url.PrintIt is "No"></a></cfif></b></font></td>
			<td align="right"><font size="-1">#Numberformat(IIF (TotalExpenditure is not "",NumberFormat(TotalExpenditure,"999999999999999"),0))#&nbsp;</font></td>
			</tr>
		<cfelse><Cfset TotalExpenditure=TotalExpenditure+#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#DispID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
         <!--- Added per SR13016 --->
         <a name="PercAmt"><br><br></a>
        <table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
        <tr><td <!--- bgcolor="silver" --->>Expenditures</td><td <!--- bgcolor="silver" --->>Percentages</td></tr>
        <cfoutput query="GetExpPerctRpt">
		<tr><td align="left"><font size="-1">#DispDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        </table><br>
<!---        <table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">F2&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Abbreviated Form&nbsp;</font></center></td></tr>
         </table>--->

<!---</body>
</html>--->
</cflock>
