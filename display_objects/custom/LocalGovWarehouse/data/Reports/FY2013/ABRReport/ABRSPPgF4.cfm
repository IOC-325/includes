<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the Indebtedness table to show a unformatted view of the Page F4 of the AFR

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
 
 <!--- pulls off fields for Indebtedness --->
 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_IndebtednessInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetIndebtednessInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetIndebtednessInfoRetMsg">
	<cfprocresult name="GetIndebtednessInfo">
</cfstoredproc>
</cfoutput>

<cfif GetIndebtednessInfoRetVal is 0>
	<cfoutput>
	<cfset t405 = #iif(GetIndebtednessInfo.t405 is not "",NumberFormat(GetIndebtednessInfo.t405,"999999999999999"),0)#>
	<cfset t411 = #iif(GetIndebtednessInfo.t411 is not "",NumberFormat(GetIndebtednessInfo.t411,"999999999999999"),0)#>
	<cfset t417 = #iif(GetIndebtednessInfo.t417 is not "",NumberFormat(GetIndebtednessInfo.t417,"999999999999999"),0)#>
    <cfset t429 = #iif(GetIndebtednessInfo.t429 is not "",NumberFormat(GetIndebtednessInfo.t429,"999999999999999"),0)#>
    <cfset t435 = #GetIndebtednessInfo.t435#>
    <cfset t441 = #iif(GetIndebtednessInfo.t441 is not "",NumberFormat(GetIndebtednessInfo.t441,"999999999999.99"),0.00)#>
    <cfset t447 = #iif(GetIndebtednessInfo.t447 is not "",NumberFormat(GetIndebtednessInfo.t447,"999999999999.99"),0.00)#>
	</cfoutput>
<cfelse>
	<cfset t405 = 0>
	<cfset t411 = 0>
	<cfset t417 = 0>
    <cfset t429 = 0>
    <cfset t435 = " ">
    <cfset t441 = 0.00>
    <cfset t447 = 0.00>
</cfif>

<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Indebtedness">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>

<h5>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2013/ABRReport/ABRSPPgF4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=F4" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h5>

<center><font size="-1"><b>Statement of Indebtedness</b>&nbsp;</font></center>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
		<tr><td align="center" valign="top"><font size="-1"><b>Debt Instruments for All Funds</b>&nbsp;</font></td><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Outstanding<br>Beginning of Year</b>&nbsp;</font></td><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Issued Current<br>Fiscal Year</b>&nbsp;</font></td><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Retired Current<br>Fiscal Year</b>&nbsp;</font></td><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Outstanding<br>End of Year</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Original<br>Issue<br>Amount</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Final<br>Maturity<br>Date</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Interest<br>Rate<br>Ranges - <br>Lowest</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Interest<br>Rate<br>Ranges - <br>Highest</b>&nbsp;</font></td></tr>
		<tr><td colspan="13" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-1">Report in Whole Numbers&nbsp;</font></td></tr>		
		<cfoutput>
			<tr>
			<td><font size="-1"><b>Total Debt</b>&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>405</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(iif(t405 is not "",NumberFormat(t405,"999999999999999"),0))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>411</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(iif(t411 is not "",NumberFormat(t411,"999999999999999"),0))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>417</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(iif(t417 is not "",NumberFormat(t417,"999999999999999"),0))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>423</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((iif(t405 is not "",NumberFormat(t405,"999999999999999"),0) + iif(t411 is not "",NumberFormat(t411,"999999999999999"),0) - iif(t417 is not "",NumberFormat(t417,"999999999999999"),0)))#&nbsp;</font></td>
            <td align="right"><font size="-1">#iif(t429 is not "",NumberFormat(t429,"999999999999999"),NumberFormat(0,"999999999999999"))#&nbsp;</font></td>
            <td align="right"><font size="-1">#DateFormat(t435,"MM/DD/YYYY")#&nbsp;</font></td>
            <td align="right"><font size="-1">#iif(t441 is not "",NumberFormat(t441,"999999999999.99"),NumberFormat(0.00,"999999999999.99"))#&nbsp;</font></td>
            <td align="right"><font size="-1">#iif(t447 is not "",NumberFormat(t447,"999999999999.99"),NumberFormat(0.00,"999999999999.99"))#&nbsp;</font></td>
			
			</tr>
		</cfoutput>
		</table>
    <br>
    <!---
    <p align="right"><font size="-1">F4&nbsp;</font></right>
	<br><center>
	<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
	FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
	Abbreviated Form&nbsp;</font></center> <br><br>
	--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "Abbrev">
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
        <td width="20%">#url.CFY# Abbreviated Form - F4</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
