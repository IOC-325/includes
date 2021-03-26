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
<h3 class="clearfix">
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2016/ABRReporttot/ABRSPPgF4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=F4" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>
</cfif>
</cfoutput>
</h3>
<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td align="center" valign="top"><b>Debt Instruments for All Funds</b></td>
        <td align="center" valign="top"><b>Outstanding Beginning of Year</b></td>
        <td align="center" valign="top"><b>Issued Current Fiscal Year</b></td>
        <td align="center" valign="top"><b>Retired Current Fiscal Year</b></td>
        <td align="center" valign="top"><b>Outstanding End of Year</b></td>
    </tr>
    <tr>
        <td colspan="5" valign="top" align="center">Report in Whole Numbers</td>
    </tr>
    <cfoutput>
			<tr>
			<td><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Debt<cfif url.PrintIt is "no"></a></cfif></b></td>
			<td align="right">#NumberFormat(iif(t405 is not "",NumberFormat(t405,"999999999999999"),0))#</td>
			<td align="right">#NumberFormat(iif(t411 is not "",NumberFormat(t411,"999999999999999"),0))#</td>
			<td align="right">#NumberFormat(iif(t417 is not "",NumberFormat(t417,"999999999999999"),0))#</td>
			<td align="right">#NumberFormat((iif(t405 is not "",NumberFormat(t405,"999999999999999"),0) + iif(t411 is not "",NumberFormat(t411,"999999999999999"),0) - iif(t417 is not "",NumberFormat(t417,"999999999999999"),0)))#</td>
			</tr>
		</cfoutput>
		</table>
        </div>
</cflock>
