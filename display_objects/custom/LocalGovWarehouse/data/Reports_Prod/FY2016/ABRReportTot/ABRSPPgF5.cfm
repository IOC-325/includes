<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the CapitalOutlay table to show a unformatted view of the Page F6 of the AFR

 --->
 

 
<!--- Pull of the unit's name --->
<CFLOCK SCOPE="Session" timeout="100">
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Check_IfFinished">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckIfFinishedRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckIfFinishedRetMsg">
	<cfprocresult name="CheckIfFinished">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Check_ResubmitAuth">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckResubmitAuthRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckResubmitAuthRetMsg">
	<cfprocresult name="CheckResubmitAuth">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>
</cfoutput>
 
 <!--- pulls off fields for Capital Outlay for update form --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_CapitalOutlayCategoryInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCapitalOutlayCategoryInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCapitalOutlayCategoryInfoRetMsg">
	<cfprocresult name="GetCapitalOutlayCategoryInfo">
</cfstoredproc>
</cfoutput>
 
<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="Summary">
<cfset url.PageName="Capital Outlay"> 
<div class="jumbotron">
<cfinclude template="/Data/Reports/SummaryHeading.cfm">
<cfinclude template="/Data/Reports/AvailableSumAFR.cfm">
</div>

<h6>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/ABRReportTot/ABRSPPgF5.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=F6" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h6>

		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box" width="100%">
		<tr><td colspan="4" align="center"><font size="-1">Capital Outlay</b>&nbsp;</font></td></tr>
		<tr><td width="10%">&nbsp;</td><td width="50%">&nbsp;</td><td colspan="2" align="center" valign="top"><font size="-1">These are not funds&nbsp;</font></td></tr>
		<tr><td width="10%" <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td width="65%" align="center" valign="top"><font size="-1"><b>Function</b>&nbsp;</font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Construction</b>&nbsp;</font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Land, Structures, and Equipment</b>&nbsp;</font></td></tr>
		<cfoutput query="GetCapitalOutlayCategoryInfo">
			<tr><td <!--- bgcolor="silver" ---> width="10%" align="center"><font size="-1"><b>#DispId#</b>&nbsp;</font></td><td width="65%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" width="10%"><font size="-1">#NumberFormat(CO)#&nbsp;</font></td><td align="right" width="10%"><font size="-1">#NumberFormat(LS)#&nbsp;</font></td>
			</tr>
		</cfoutput>
		</table>
		<font size="-2">*This page should only be filled out if you have spent funds for capital projects or development&nbsp;</font><br>
		<font size="-2">*The Capital Outlay page is requested by the U.S. Census Bureau and is considered optional by the State Comptroller.&nbsp;</font><br>
		<font size="-2">*If you complete this page you WILL NOT have to complete the Survey of Government Finances from the U.S. Census Bureau.&nbsp;</font><br>
		<font size="-2">*If you do NOT complete this page the U.S. Census Bureau will contact you for further information.&nbsp;</font><br>
<!---<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">F5&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Abbreviated Form&nbsp;</font></center></td></tr>
         </table>--->
</html>
</cflock>
