<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 6-13-00
Modified By: Gary Ashbaugh
Modifications Made:  Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 8-24-01
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

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
	<title>AFR - Page 3</title>
</head>

<body>--->
<cfset url.PageType="Summary">
<cfset url.PageName="Component Units and Appropriations">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<cfset SubApprop = 0>

<!---*<table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="100%">
<tr><td>--->
<h5>
	<span class="glyphicon glyphicon-circle-arrow-right"></span>
	 COMPONENT UNITS AND APPROPRIATIONS
     <span class="pull-right">
	 <cfoutput>
	 <cfif url.PrintIt is "no">
     <a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2012/MPFReportTot/AFRMPPg3b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=3" class="btn btn-primary btn-lg">
     <span class="glyphicon glyphicon-print"></span>
     Print This Page
     </a>
     </span>
     </cfif></cfoutput>
</h5>
<!---*</td><td>&nbsp;</td><td align="right"><cfif url.PrintIt is "no"><cfoutput><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2012/MPFReportTot/AFRMPPg3b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=3"><img src="images/printer.jpg" alt="Print Page" width="20" height="20" ></a></cfoutput></cfif>
</td></tr>
<tr><td colspan="3">--->

<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<tr><td width="30%" valign="top"><font size="-1"><b>Name of Unit/Component</b><br><br><u>FUNDS SHOULD NOT BE LISTED HERE</u></font></td><td width="15%" valign="top"><font size="-1"><b>Appropriation</b></font></td><td width="15%" valign="top"><font size="-1"><b>Type of Component Unit</b></font></td><td width="15%" valign="top"><font size="-1"><b>Fiscal Year End</b></font></td><td width="20%" valign="top"><font size="-1"><b>Enterprise Fund Type or<br>Governmental Fund Type</b></font></td></tr>
<cfoutput><cfset SubApprop = #GetAFRRptPg1.Appropriations#>
<tr><td width="30%"><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#<cfif url.PrintIt is "no"></a></cfif></font></td><td width="15%" align="right"><font size="-1">#NumberFormat(GetAFRRptPg1.Appropriations,"$999,999,999,999,999,999")#</font></td><td width="15%" background="Gray"><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td><td width="15%"><font size="-1">#DateFormat(GetAuditInfo.FYEnd,"MM")#/#DateFormat(GetAuditInfo.FYEnd,"DD")#</font></td><td width="20%"><font size="-1">&nbsp;</font></td></tr>
</cfoutput>
<cfoutput query="GetComponentUnitInfo">
<cfset SubApprop = #iif(SubApprop is "",0,SubApprop)# + #iif(Amount is "",0,Amount)#>
<tr><td width="30%"><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#ComponentUnit#<cfif url.PrintIt is "no"></a></cfif></font></td><td width="15%" align="right"><font size="-1">#NumberFormat(Amount,"$999,999,999,999,999")#</font></td><td width="15%"><font size="-1"><cfif type is "B">Blended<cfelseif type is "DP">Discretely Presented<cfelse>&nbsp;</cfif></font></td><td width="15%"><font size="-1">#DateFormat(FYEnd,"MM")#/#DateFormat(FYEnd,"DD")#</font></td><td width="20%"><font size="-1">#CU_Funds#</font></td></tr>
</cfoutput>
<cfoutput>
<tr><td width="30%"><font size="-1"><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Appropriations<cfif url.PrintIt is "no"></a></cfif></b></font></td><td width="15%" align="right"><font size="-1">#NumberFormat(SubApprop,"$9,999,999,999,999,999")#</font></td><td width="15%">&nbsp;</td><td width="15%">&nbsp;</td><td width="20%"><font size="-1">&nbsp;</font></td></tr>
</cfoutput>
</table>
<p style="color:red;text-align:left">&nbsp;&nbsp;&nbsp;&nbsp;*Do not enter funds such as: Joint Bridge, Permanent Road, Town Fund, Equipment, Water & Sewer, General Assistance, etc.  These funds should be included in Step9.<br>&nbsp;&nbsp;&nbsp;&nbsp;^If the Primary Government or Component Unit does NOT budget or levy taxes, please enter the unit's TOTAL EXPENDITURES.</p>

<!---<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">3&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Multi-Purpose Form&nbsp;</font></center></td></tr>
         </table>--->
<!---</body>
</html>--->
</cflock>