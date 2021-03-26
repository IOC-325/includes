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
	</cfoutput>
<cfelse>
	<cfset t405 = 0>
	<cfset t411 = 0>
	<cfset t417 = 0>
</cfif>

<cfset url.PageType="Summary">
<cfset url.PageName="Indebtedness">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<h3>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2015/ABRReporttot/ABRSPPgF4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=F4" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h3>

		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box" width="100%">
		<tr><td align="center" valign="top" width="35%"><font size="-1"><b>Debt Instruments<br>for All Funds</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Outstanding<br>Beginning of Year</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Issued Current<br>Fiscal Year</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Retired Current<br>Fiscal Year</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Outstanding<br>End of Year</b>&nbsp;</font></td></tr>
		<tr><td colspan="9" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-1">Report in Whole Numbers&nbsp;</font></td></tr>		
		<cfoutput>
			<tr>
			<td><font size="-1"><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Debt<cfif url.PrintIt is "no"></a></cfif></b>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(iif(t405 is not "",NumberFormat(t405,"999999999999999"),0))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(iif(t411 is not "",NumberFormat(t411,"999999999999999"),0))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(iif(t417 is not "",NumberFormat(t417,"999999999999999"),0))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((iif(t405 is not "",NumberFormat(t405,"999999999999999"),0) + iif(t411 is not "",NumberFormat(t411,"999999999999999"),0) - iif(t417 is not "",NumberFormat(t417,"999999999999999"),0)))#&nbsp;</font></td>
			</tr>
		</cfoutput>
		</table>
</cflock>
