<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

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
  
<!---<html>
<head>
	<title>AFR - Page 3</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Population, EAV, and Employees">
<cfset SubApprop = 0>
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>

<h5><span class="glyphicon glyphicon-circle-arrow-right"></span><font size="-1" color="black"> STEP 4:  POPULATION, EAV AND EMPLOYEES</FONT>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/ABRReport/ABRSPPg3.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=3" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>

<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="100%">
<cfoutput query="GetAFRRptPg1">
<tr><td width="75%" align="left"><font size="-1">^What is the total <b>population</b> of #UnitName# #Description#?</font></td><td width="25%" align="right"><font size="-1">#NumberFormat(Pop,"999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1">What is the total <b>EAV</b> of #UnitName# #Description#?</font></td><td width="25%" align="right"><font size="-1">#NumberFormat(EAV,"$999,999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1">*How many <b>full time employees</b> are paid?</font></td><td width="25%" align="right"><font size="-1">#NumberFormat(Full_Emp,"999,999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1">*How many <b>part time employees</b> are paid?</font></td><td width="25%" align="right"><font size="-1">#NumberFormat(Part_Emp,"999,999,999,999,999,999")#&nbsp;</font></td></tr>
<tr><td width="75%" align="left"><font size="-1">What is the <b>total salary</b> paid to all employees?</font></td><td width="25%" align="right"><font size="-1">#NumberFormat(Salaries,"$999,999,999,999,999,999")#&nbsp;</font></td></tr>
</cfoutput>
</table>
<font size="-2">^Or provide estimated population<br>*Do not include contractual employees.</font><br>
<br>
<h5>
<span class="glyphicon glyphicon-circle-arrow-right"></span><font size="-1" color="black"> STEPS 5 AND 6:  <!---COMPONENT UNITS AND --->APPROPRIATIONS</FONT><BR>
</h5><br>
<b><font size="-1">Provide the appropriation for the primary government listed in the first row of the table below.</font></b><br>
<br>
<font size="-1">If you need assistance with the terms indicated below, refer to the <i><a href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2016/2016chartofaccounts.pdf" target="_New">Chart of Accounts and Definitions</a></i> and the <i><a href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2016/2016FAQ_HowtoAll.pdf" target="_New">How to Fill Out An AFR</a></i> documents.</font><br>
<BR>
<center>FUNDS SHOULD NOT BE LISTED HERE</center>
<br>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="70%">
<cfoutput>
<tr><td width="20%"><font size="-1"><b>Total Appropriations</b></font></td><td width="50%" align="right"><font size="-1"><!---#NumberFormat(SubApprop,"$9,999,999,999,999,999")#--->#NumberFormat(GetAFRRptPg1.Appropriations,"$999,999,999,999,999,999")#</font></td></tr>
</cfoutput>
</table>

<br>
<!---
<center><font size="-1">3<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Abbreviated Form</font></center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "Abbrev">
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
        <td width="20%">#url.CFY# Abbreviated Form - 3</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>