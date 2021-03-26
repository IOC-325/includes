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
<cfset url.PageType="AFR">
<cfset url.PageName="Fund Listing and Account Groups">
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span> <font size="-1" color="black">STEP 8:  FUND LISTING & ACCOUNT GROUPS</font>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/SPFReport/AFRSPPg5.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=5" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>
<table <!---bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="100%"--->>
<tr><td colspan="3">
<font size="-1"><b>A. List all funds and how much was spent in FY 2016 for each fund.  Also, indicate the Fund Type (Fund Types are at the top of each column beginning on page F1).</b>&nbsp;&nbsp;  If any fund names appear below, that data is based on forms submitted last year.&nbsp;&nbsp;  Please make all necessary corrections.&nbsp;&nbsp;If you have more fund names than the rows provided below, please indicate them on an attachment.</font>
</td></tr>
</table>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<tr><td width="40%"><font size="-1"><b>Fund Name</b></font></td><td width="20%"><font size="-1"><b>Expenditure</b></font></td><td width="20%"><font size="-1"><b>Fund FundType</b></font></td><td width="20%"><font size="-1"><b>FY End</b></font></td></tr>
<cfset TotExp=0><cfoutput query="GetFundsUsed"><cfset TotExp = #iif(TotExp is "",0,TotExp)# + #iif(Expenditures is "",0,Expenditures)#>
<tr><td width="40%"><font size="-1">#Instrument#</font></td><td width="20%" align="right"><font size="-1">#NumberFormat(Expenditures,"$999,999,999,999,999")#</font></td><td width="20%"><font size="-1"><cfif FundType is "GN">General<cfelseif FundType is "SR">Special Revenue<cfelseif FundType is "CP">Capital Projects<cfelseif FundType is "DS">Debt Service<cfelseif FundType is "EP">Enterprise<cfelseif FundType is "TS">Internal Service<cfelseif FundType is "FD">Fiduciary<cfelseif FundType is "AG">Account Groups<cfelseif FundType is "DP">Discretely Presented Component Units<cfelse>&nbsp;</cfif></font></td><td width="20%"><font size="-1"><!---#DateFormat(FYEnd,"MM")#/#DateFormat(FYEnd,"DD")#--->#FYEnd#</font></td></tr>
</cfoutput>
<tr><td width="40%"><font size="-1"><b>Total Expenditures</b></font></td><td width="20%" align="right"><font size="-1"><cfoutput>#NumberFormat(TotExp,"$9,999,999,999,999,999")#</cfoutput></font></td><td width="20%">&nbsp;</td><td width="20%">&nbsp;</td></tr>
</table>
<br>
<font size="-1"><b>B. Does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> have assets or liabilities that should be recorded as a part of Account Groups?</b>  See <i><a href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2016/2016chartofaccounts.pdf" target="_New">Chart of Accounts and Definitions</a></i> and the <i><a href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2016/2016FAQ_HowtoAll.pdf" target="_New">How to Fill Out An AFR</a></i> documents for more information about Account Groups.</font><br>
<br>
&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.AccountGroups) is "Y"><u>X</u><cfelse>_</cfif>_&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.AccountGroups) is "N"><u>X</u><cfelse>_</cfif>_&nbsp;No
<br>
<!---<br><br>
<center><font size="-1">5<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
Special Purpose Form</font></center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "SP">
    	<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
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
        <td width="20%">#url.CFY# Special Purpose Form - 5</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
