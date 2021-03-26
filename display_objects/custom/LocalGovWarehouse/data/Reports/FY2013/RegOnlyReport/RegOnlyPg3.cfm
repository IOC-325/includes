<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Application: SR# 05059 - Registration Only AFR Unit
Author: Gary Ashbaugh
Date Created: 7-7-05

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Cover Page of the Registration Only AFR

 --->
 


<CFLOCK SCOPE="Session" timeout="100">
<!--- Find out if unit has already submitted their AFR --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Check_IfFinished">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckIfFinishedRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckIfFinishedRetMsg">
	<cfprocresult name="CheckIfFinished">
</cfstoredproc>
</cfoutput>
 
<!--- Pull of the unit's name --->

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
	<title>AFR - Page 3</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Reporting">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span> <font size="-1" color="black">STEP 6:  REPORTING</font>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2013/RegOnlyReport/RegOnlyPg3.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Registration Form&Page=3" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>
<table <!---bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="100%"--->>
<Tr>
<td colspan="3"><font size="-1"><b>Check any state or local entity where financial reports are filed.</b></font>
</td></tr>
</table>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<tr><td colspan="2"><font size="-1"><b>STATE AGENCIES</b></font></td></tr>
<cfoutput>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.BoardofEducation) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - Board of Education</font></td><td width="50%" align="left"><font size="-1"><cfif UCase(GetReportingInfo.BoardofHigherEducation) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - Board of Higher Education</font></td></tr>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.DCCA) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - DCEO</font></td><td width="50%" align="left"><font size="-1"><cfif UCase(GetReportingInfo.DepartmentofInsurance) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - Department of Insurance</font></td></tr>
<tr><td colspan="2"><font size="-1"><b>OTHER STATE OR LOCAL OFFICES</b></font></td></tr>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.IllinoisComptroller) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - Illinois Comptroller</font></td><td width="50%" align="left"><font size="-1"><cfif UCase(GetReportingInfo.SecretaryofState) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - Secretary of State</font></td></tr>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.GeneralAssemblyHouse) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - General Assembly - House</font></td><td width="50%" align="left"><font size="-1"><cfif UCase(GetReportingInfo.GeneralAssemblySenate) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - General Assembly - Senate</font></td></tr>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.CountyClerk) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - County Clerk</font></td><td width="50%" align="left"><font size="-1"><cfif UCase(GetReportingInfo.CircuitClerk) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - Circuit Clerk</font></td></tr>
<tr><td width="50%"><font size="-1"><cfif UCase(GetReportingInfo.GovernorsOffice) is "Y"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - Governor's Office</font></td><td width="50%" align="left"><font size="-1"><cfif GetReportingInfo.Other is not ""><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - Other - <cfif GetReportingInfo.Other is not ""><u>#GetReportingInfo.Other#</u><cfelse>________________</cfif></font></td></tr>
</cfoutput>
</table>
<br>
<!---
<center><font size="-1">3<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput><br>
Registration Form</font></center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "RegOnly">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
    <cfif url.PrintIt is "No">
    	<cfoutput>
        <div align="center">
        <table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="90%">
        <tr><Td width="30%">&nbsp;</Td>
        <td width="5%">&nbsp;</td>
        <td width="30%"><center>#url.AFRDesiredData#</center></td>
        <td width="5%">&nbsp;</td>
        <td width="20%">#url.CFY# Registration Form - 3</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
