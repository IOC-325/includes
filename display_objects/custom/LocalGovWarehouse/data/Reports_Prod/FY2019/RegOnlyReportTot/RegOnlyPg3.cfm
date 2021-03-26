<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Application: SR# 05059 - Registration Only AFR Unit
Author: Gary Ashbaugh
Date Created: 7-7-05

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Cover Page of the Registration Only AFR

 --->
 
 
 
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
<cfset url.PageType="Summary">
<cfset url.PageName="Reporting">
<div class="jumbotron">
<cfinclude template="/Data/Reports/SummaryHeading.cfm">
<cfinclude template="/Data/Reports/AvailableSumAFR.cfm">
</div>
<h6><span class="glyphicon glyphicon-circle-arrow-right"></span> REPORTING
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2019/RegOnlyReportTot/RegOnlyPg3.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Registration Form&Page=3" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>
<table <!--- bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="100%"--->>
<tr><td colspan="3">
<font size="-1"><b>Check any state or local entity where financial reports are filed.</b></font></td></tr>
</table>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<tr><td><font size="-1"><b>STATE AGENCIES</b></font></td></tr>
<cfoutput>
<tr><td><font size="-1"><cfif UCase(GetReportingInfo.BoardofEducation) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Board of Education<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td align="left"><font size="-1"><cfif UCase(GetReportingInfo.BoardofHigherEducation) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Board of Higher Education<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td><font size="-1"><cfif UCase(GetReportingInfo.DCCA) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>DCEO<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td align="left"><font size="-1"><cfif UCase(GetReportingInfo.DepartmentofInsurance) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Department of Insurance<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td><font size="-1"><b>OTHER STATE OR LOCAL OFFICES</b></font></td></tr>
<tr><td><font size="-1"><cfif UCase(GetReportingInfo.IllinoisComptroller) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Illinois Comptroller<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td  align="left"><font size="-1"><cfif UCase(GetReportingInfo.SecretaryofState) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Secretary of State<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td><font size="-1"><cfif UCase(GetReportingInfo.GeneralAssemblyHouse) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>General Assembly - House<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td  align="left"><font size="-1"><cfif UCase(GetReportingInfo.GeneralAssemblySenate) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>General Assembly - Senate<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td><font size="-1"><cfif UCase(GetReportingInfo.CountyClerk) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>County Clerk<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td  align="left"><font size="-1"><cfif UCase(GetReportingInfo.CircuitClerk) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Circuit Clerk<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td><font size="-1"><cfif UCase(GetReportingInfo.GovernorsOffice) is "Y"><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Governor's Office<cfif url.PrintIt is "no"></a></cfif></font></td></tr>
<tr><td  align="left"><font size="-1"><cfif GetReportingInfo.Other is not ""><img src="#application.LocGovWarehouse#images/Checked.jpg" width=12 height=12 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=12 height=12 border=0 alt=""></cfif> - <cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Other<cfif url.PrintIt is "no"></a></cfif> - <cfif GetReportingInfo.Other is not ""><u>#GetReportingInfo.Other#</u><cfelse>________________</cfif></font></td></tr>
</cfoutput>
</table>
<!---
<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">3&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Registration Only Form&nbsp;</font></center></td></tr>
         </table>
		 --->
<!---</body>
</html>--->
</cflock>
