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

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Page 4 of the AFR

 --->
 


 
<!--- Pull of the unit's name --->
<CFLOCK SCOPE="Session" timeout="100">
<cfoutput>
<cfStoredProc  datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>
</cfoutput>
  
<!---<html>
<head>
	<title>AFR - Page 4</title>
</head>

<body>--->
<cfset url.PageType="Summary">
<cfset url.PageName="Payments to Other Governments">
<div class="jumbotron">
<cfinclude template="/Data/Reports/SummaryHeading.cfm">
<cfinclude template="/Data/Reports/AvailableSumAFR.cfm">
</div>
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span> PAYMENTS MADE TO OTHER GOVERNMENTS
     <span class="pull-right">
	 <cfoutput>
	 <cfif url.PrintIt is "no">
     <a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2019/MPFReportTot/AFRMPPg4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=4" class="btn btn-primary btn-lg">
     <span class="glyphicon glyphicon-print"></span>
     Print This Page
     </a>
     </span>
     </cfif></cfoutput>
</h5>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="100%">
<tr><td colspan="3">
<font size="-1"><b>Indicate any payments <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> made to other governments for services or programs (include programs performed on a reimbursement, cost-sharing basis or federal payroll taxes).</font></b><br>
</td></tr>
</table>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<cfoutput query="GetAFRRptPg1">
<tr><td width="75%" align="left"><font size="-1"><cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Intergovernmental agreements - indicate how much was paid<cfif url.PrintIt is "no"></a></cfif></font></td><td width="25%" align="right"><font size="-1">#NumberFormat(AmtState,"$9,999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1"><cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Federal government payroll taxes<cfif url.PrintIt is "no"></a></cfif></font></td><td width="25%" align="right"><font size="-1">#NumberFormat(AmtFederal,"$9,999,999,999,999,999")#</font>&nbsp;</td></tr>
<tr><td width="75%" align="left"><font size="-1"><cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>All other intergovernmental payments<cfif url.PrintIt is "no"></a></cfif></font></td><td width="25%" align="right"><font size="-1">#NumberFormat(AmtLocal,"$9,999,999,999,999,999")#</font>&nbsp;</td></tr>
</cfoutput>
</table>
<!---<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">4&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Multi-Purpose Form&nbsp;</font></center></td></tr>
         </table>--->
<!---</body>
</html>--->
</cflock>