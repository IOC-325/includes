<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the UnitStats, UnitData, and Component table to show a unformatted view of the Page 3 of the AFR

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

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AuditInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_VarChar" dbvarname="@Instrument" value="Annual Report">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAuditInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAuditInfoRetMsg">
	<cfprocresult name="GetAuditInfo">
</cfstoredproc>
</cfoutput>
  
<!---<html>
<head>
	<title>AFR - Page 3</title>
</head>

<body>--->
<cfset url.PageType="Summary">
<cfset url.PageName="Population, EAV, and Employees">
<cfset SubApprop = 0>
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<h6><span class="glyphicon glyphicon-circle-arrow-right"></span> POPULATION, EAV AND EMPLOYEES
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2014/ABRReportTot/ABRSPPg3a.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=3" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>

<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<tr><td></td></tr>
<cfoutput query="GetAFRRptPg1">
<tr><td width="75%" align="left"><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>^What is the total <b>population</b> of #UnitName# #Description#?<cfif url.PrintIt is "no"></a></cfif></font></td><td width="25%" align="right"><font size="-1">#NumberFormat(Pop,"999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>What is the total <b>EAV</b> of #UnitName# #Description#?<cfif url.PrintIt is "no"></a></cfif></font></td><td width="25%" align="right"><font size="-1">#NumberFormat(EAV,"$999,999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>*How many <b>full time employees</b> are paid?<cfif url.PrintIt is "no"></a></cfif></font></td><td width="25%" align="right"><font size="-1">#NumberFormat(Full_Emp,"999,999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>*How many <b>part time employees</b> are paid?<cfif url.PrintIt is "no"></a></cfif></font></td><td width="25%" align="right"><font size="-1">#NumberFormat(Part_Emp,"999,999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>What is the <b>total salary</b> paid to all employees?<cfif url.PrintIt is "no"></a></cfif></font></td><td width="25%" align="right"><font size="-1">#NumberFormat(Salaries,"$999,999,999,999,999,999")#&nbsp;</font></td></tr>
</cfoutput>
</table>
<br>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="100%">
<tr><Td align="left"><font size="-2">^Or provide estimated population<br>*Do not include contractual employees.</font></Td></tr>
</table>
<!---
<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">3&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Abbreviated Form&nbsp;</font></center></td></tr>
         </table>--->
<!---</body>
</html>--->
</cflock>