<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the UnitStats, UnitData, and FundsUsed table to show a unformatted view of the Page 5 of the AFR

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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_FundsUsed">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFundsUsedRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFundsUsedRetMsg">
	<cfprocresult name="GetFundsUsed">
</cfstoredproc>
</cfoutput>
  
<!---<html>
<head>
	<title>AFR - Page 5</title>
</head>

<body>--->
<cfset url.PageType="Summary">
<cfset url.PageName="Fund Listing and Account Groups">
<div class="jumbotron">
<cfinclude template="/Data/Reports/SummaryHeading.cfm">
<cfinclude template="/Data/Reports/AvailableSumAFR.cfm">
</div>
<h6><span class="glyphicon glyphicon-circle-arrow-right"></span> FUND LISTING & ACCOUNT GROUPS
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2017/ABRReportTot/ABRSPPg5.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=5" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>

<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<tr><td width="40%"><font size="-1"><b>Fund Name</b></font></td><td width="20%"><font size="-1"><b>Expenditure</b></font></td><td width="20%"><font size="-1"><b>Fund FundType</b></font></td><td width="20%"><font size="-1"><b>FY End</b></font></td></tr>
<cfset TotExp=0><cfoutput query="GetFundsUsed"><cfset TotExp = #iif(TotExp is "",0,TotExp)# + #iif(Expenditures is "",0,Expenditures)#>
<tr><td width="40%"><font size="-1"><cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#Instrument#<cfif url.PrintIt is "no"></a></cfif></font></td><td width="20%" align="right"><font size="-1">#NumberFormat(Expenditures,"$999,999,999,999,999")#</font></td><td width="20%"><font size="-1"><cfif FundType is "GN">General<cfelseif FundType is "SR">Special Revenue<cfelseif FundType is "OT">Other<cfelse>&nbsp;</cfif></font></td><td width="20%"><font size="-1">#DateFormat(FYEnd,"MM")#/#DateFormat(FYEnd,"YY")#</font></td></tr>
</cfoutput>
<tr><td width="40%"><font size="-1"><b><cfoutput><cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Expenditures<cfif url.PrintIt is "no"></a></cfif></cfoutput></b></font></td><td width="20%" align="right"><font size="-1"><cfoutput>#NumberFormat(TotExp,"$9,999,999,999,999,999")#</cfoutput></font></td><td width="20%">&nbsp;</td><td width="20%">&nbsp;</td></tr>
</table>
<br>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="100%">
<tr><Td>
<font size="-1"><b>B. Does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> have assets or liabilities that should be recorded as a part of Account Groups?</b>  See <i><a href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2017/2017chartofaccounts.pdf" target="_New">Chart of Accounts and Definitions</a></i> and the <i><a href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2017/2017FAQ_HowtoAll.pdf" target="_New">How to Fill Out An AFR</a></i> documents for more information about Account Groups.  This section not applicable for the Special Purpose Abbreviated Form.</font><br>
</Td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;___&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<u>X</u>_&nbsp;No</td></tr>
</table>
<!---<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">5&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Abbreviated Form&nbsp;</font></center></td></tr>
         </table>--->
<!---</body>
</html>--->
</cflock>
