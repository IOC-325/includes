<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Application: SR# 05059 - Registration Only AFR Unit
Author: Gary Ashbaugh
Date Created: 7-7-05

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Cover Page of the Registration Only AFR

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
	<cfprocparam type="In"  cfsqltype="CF_SQL_VarChar" dbvarname="@Instrument" value="Registration">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAuditInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAuditInfoRetMsg">
	<cfprocresult name="GetAuditInfo">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ComponentUnitInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetComponentUnitInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetComponentUnitInfoRetMsg">
	<cfprocresult name="GetComponentUnitInfo">
</cfstoredproc>
</cfoutput>
  
<!---<html>
<head>
	<title>AFR - Page 2</title>
</head>

<body>--->
<cfset SubApprop = 0>
<cfset url.PageType="Summary">
<cfset url.PageName="Population, EAV, and Employees">
<div class="jumbotron">
<cfinclude template="/Data/Reports/SummaryHeading.cfm">
<cfinclude template="/Data/Reports/AvailableSumAFR.cfm">
</div>
<h6><span class="glyphicon glyphicon-circle-arrow-right"></span> POPULATION SERVED OR SCHOOL ENROLLMENT AND EAV
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/RegOnlyReportTot/RegOnlyPg2b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Registration Form&Page=2" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<cfoutput query="GetAFRRptPg1">
<tr><td width="75%" align="left"><font size="-1"><cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>^What is the total <b>population served or school enrollment</b> of #UnitName# #Description#?<cfif url.PrintIt is "no"></a></cfif></font></td><td width="25%" align="right"><font size="-1">#NumberFormat(Pop,"999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1"><cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>What is the total <b>EAV</b> of #UnitName# #Description#?<cfif url.PrintIt is "no"></a></cfif></font></td><td width="25%" align="right"><font size="-1">#NumberFormat(EAV,"$999,999,999,999,999,999")#&nbsp;</font></td></tr>
</cfoutput>
</table>
<table <!---bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="45%"--->>
<tr><td align="left">
<font size="-2">^Or provide estimated population</font>
</td></tr>
</table>
<!---
<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">2&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Registration Only Form&nbsp;</font></center></td></tr>
         </table>
		 --->
<!---</body>
</html>--->
</cflock>