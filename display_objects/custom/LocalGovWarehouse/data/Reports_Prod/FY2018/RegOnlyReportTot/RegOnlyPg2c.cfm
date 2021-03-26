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
<cfset url.PageName="Component Units and Appropriations">
<div class="jumbotron">
<cfinclude template="/Data/Reports/SummaryHeading.cfm">
<cfinclude template="/Data/Reports/AvailableSumAFR.cfm">
</div>
<h6><span class="glyphicon glyphicon-circle-arrow-right"></span> COMPONENT UNITS AND APPROPRIATIONS
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2017/RegOnlyReportTot/RegOnlyPg2c.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Registration Form&Page=2" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>

<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<tr><td width="30%" valign="top"><font size="-1"><b>Name of Unit/Component*</b><br><br><u>FUNDS SHOULD NOT BE LISTED HERE</u></font><font color="red">*</font></td><td width="15%" valign="top"><font size="-1"><b>Appropriation^</font><font color="Red">^</b></font></td><td width="15%" valign="top"><font size="-1"><b>Fiscal Year End</b></font></td></tr>
<cfoutput><cfset SubApprop = #GetAFRRptPg1.Appropriations#>
<tr><td width="30%"><font size="-1"><cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#<cfif url.PrintIt is "no"></a></cfif></font></td><td width="15%" align="right"><font size="-1">#NumberFormat(GetAFRRptPg1.Appropriations,"$999,999,999,999,999,999")#</font></td><td width="15%"><font size="-1">#DateFormat(GetAuditInfo.FYEnd,"MM")#/#DateFormat(GetAuditInfo.FYEnd,"DD")#</font></td></tr>
</cfoutput>
<cfoutput query="GetComponentUnitInfo">
<cfset SubApprop = #iif(SubApprop is "",0,SubApprop)# + #iif(Amount is "",0,Amount)#>
<tr><td width="30%"><font size="-1"><cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#ComponentUnit#<cfif url.PrintIt is "no"></a></cfif></font></td><td width="15%" align="right"><font size="-1">#NumberFormat(Amount,"$999,999,999,999,999")#</font></td><td width="15%"><font size="-1"><!---<!---#DateFormat(FYEnd,"MM")#/#DateFormat(FYEnd,"DD")#--->#FYEnd#--->#FYEnd#</font></td></tr>
</cfoutput>
<cfoutput>
<tr><td width="30%"><font size="-1"><b>Total Appropriations</b></font></td><td width="15%" align="right"><font size="-1">#NumberFormat(SubApprop,"$9,999,999,999,999,999")#</font></td><td width="15%">&nbsp;</td></tr>
</cfoutput>
</table>
<table <!---bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="100%"--->>
<tr><td align="left">
<font size="-2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;*Do not enter funds such as: Joint Bridge, Permanent Road, Town Fund, Equipment, Water & Sewer, General Assistance, etc.<br>&nbsp;&nbsp;&nbsp;&nbsp;^If the Primary Government or Component Unit does NOT budget or levy taxes, please enter the unit's TOTAL EXPENDITURES.</font>
</td></tr>
<br>
<table  <!---bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="white" width="100%"--->>
<tr><td colspan="2" width="30%"><font size="-1">Primary Government Unit Name:</font></td><td width="70%" colspan="2"><cfoutput><font size="-1">#GetAFRRptPg1.PrimaryUnit#</font></cfoutput></td>
</tr>
<tr><cfoutput>
<td width="10%">&nbsp;</td><td colspan="3"><CFIF ltrim(rtrim(GetAFRRptPg1.ComponentFile)) is "Separate"><img src="#application.LocGovWarehouse#/images/Checked.jpg" width=12 height=12 border=0 alt="">&nbsp;<cfelse><img src="#application.LocGovWarehouse#/images/UnChecked.jpg" width=12 height=12 border=0 alt="">&nbsp;</cfif><font size="-1">Component unit files financial information separately from the primary government</font></td>
</cfoutput></tr>
<tr><td colspan="4">&nbsp;</td></tr>
<tr><cfoutput>
<td width="10%">&nbsp;</td><td colspan="3"><CFIF ltrim(rtrim(GetAFRRptPg1.ComponentFile)) is "Combined"><img src="#application.LocGovWarehouse#/images/Checked.jpg" width=12 height=12 border=0 alt="">&nbsp;<cfelse><img src="#application.LocGovWarehouse#/images/UnChecked.jpg" width=12 height=12 border=0 alt="">&nbsp;</cfif><font size="-1">Component unit files financial information along with the primary government</font></td>
</cfoutput></tr>
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