<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 6-13-00
Modified By: Gary Ashbaugh
Modifications Made:  Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 8-27-01
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

LOGIC: Pulls off data from the UnitStats, GovernmentalEntities, and Reporting table to show a unformatted view of the Page 6 of the AFR

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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_Entities">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetEntitiesRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetEntitiesRetMsg">
	<cfprocresult name="GetEntities">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ReportingInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetReportingInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetReportingInfoRetMsg">
	<cfprocresult name="GetReportingInfo">
</cfstoredproc>
</cfoutput>
  
<!---<html>
<head>
	<title>AFR - Page 5</title>
</head>

<body>--->
<cfset url.PageType="Summary">
<cfset url.PageName="Reporting">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<h6><span class="glyphicon glyphicon-circle-arrow-right"></span> REPORTING
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2013/MPFReportTot/AFRMPPg6b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=6" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="100%">
<tr><Td>
<font size="-1"><b>Check any state or local entity where financial reports are filed.</b></font>
</Td></tr>
</table><br>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<tr><td ><font size="-1"><b>STATE AGENCIES</b></font></td></tr>
<cfoutput>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.BoardofEducation) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Board of Education<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td width="50%" align="left"><font size="-1"><cfif UCase(GetReportingInfo.BoardofHigherEducation) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Board of Higher Education<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.DCCA) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>DCEO<cfif url.PrintIt is "no"></cfif></font></td></tr>
<tr><td width="50%" align="left"><font size="-1"><cfif UCase(GetReportingInfo.DepartmentofInsurance) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Department of Insurance<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><Td>&nbsp;</Td></tr>
<tr><td ><font size="-1"><b>OTHER STATE OR LOCAL OFFICES</b></font></td></tr>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.IllinoisComptroller) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Illinois Comptroller<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td width="50%" align="left"><font size="-1"><cfif UCase(GetReportingInfo.SecretaryofState) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Secretary of State<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.GeneralAssemblyHouse) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>General Assembly - House<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td width="50%" align="left"><font size="-1"><cfif UCase(GetReportingInfo.GeneralAssemblySenate) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>General Assembly - Senate<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.CountyClerk) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>County Clerk<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<Tr><td width="50%" align="left"><font size="-1"><cfif UCase(GetReportingInfo.CircuitClerk) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Circuit Clerk<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.GovernorsOffice) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Governor's Office<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td width="50%" align="left"><font size="-1"><cfif GetReportingInfo.Other is not ""><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Other<cfif url.PrintIt is "no"></a></cfif> - <cfif GetReportingInfo.Other is not ""><u>#GetReportingInfo.Other#</u><cfelse>________________</cfif></font></td></tr>
</cfoutput>
</table>
<!---<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">6&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Multi-Purpose Form&nbsp;</font></center></td></tr>
         </table>--->
<!---</body>
</html>--->
</cflock>
