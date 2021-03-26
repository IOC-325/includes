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

<cfset url.PageType="AFR">
<cfset url.PageName="Indebtedness">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>

<h5 class="clearfix">
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2019/ABRReport/ABRSPPgF4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=F4" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h5>

<div class="table-responsive">
<table class="table table-bordered">
    <tr><td colspan="13" align="center"><b>Statement of Indebtedness</b></td></tr>
    <tr>
        <td align="center" valign="top"><b>Debt Instruments for All Funds</b></td>
        <td align="center" valign="top"><b>Code</b></td>
        <td align="center" valign="top"><b>Outstanding Beginning of Year</b></td>
        <td align="center" valign="top"><b>Code</b></td>
        <td align="center" valign="top"><b>Issued Current Fiscal Year</b></td>
        <td align="center" valign="top"><b>Code</b></td>
        <td align="center" valign="top"><b>Retired Current Fiscal Year</b></td>
        <td align="center" valign="top"><b>Code</b></td>
        <td align="center" valign="top"><b>Outstanding End of Year</b></td>
        <td align="center" valign="top"><b>Original Issue Amount</b></td>
        <td align="center" valign="top"><b>Final Maturity Date</b></td>
        <td align="center" valign="top"><b>Interest Rate Ranges -  Lowest</b></td>
        <td align="center" valign="top"><b>Interest Rate Ranges -  Highest</b></td>
    </tr>
		<tr><td colspan="13" valign="top" align="center">Report in Whole Numbers</td></tr>
		<cfoutput>
			<tr>
			<td><b>Total Debt</b></td>
			<td><b>405</b></td><td align="right">#NumberFormat(iif(t405 is not "",NumberFormat(t405,"999999999999999"),0))#</td>
			<td><b>411</b></td><td align="right">#NumberFormat(iif(t411 is not "",NumberFormat(t411,"999999999999999"),0))#</td>
			<td><b>417</b></td><td align="right">#NumberFormat(iif(t417 is not "",NumberFormat(t417,"999999999999999"),0))#</td>
			<td><b>423</b></td><td align="right">#NumberFormat((iif(t405 is not "",NumberFormat(t405,"999999999999999"),0) + iif(t411 is not "",NumberFormat(t411,"999999999999999"),0) - iif(t417 is not "",NumberFormat(t417,"999999999999999"),0)))#</td>
            <td align="right">#iif(t429 is not "",NumberFormat(t429,"999999999999999"),NumberFormat(0,"999999999999999"))#</td>
            <td align="right">#DateFormat(t435,"MM/DD/YYYY")#</td>
            <td align="right">#iif(t441 is not "",NumberFormat(t441,"999999999999.99"),NumberFormat(0.00,"999999999999.99"))#</td>
            <td align="right">#iif(t447 is not "",NumberFormat(t447,"999999999999.99"),NumberFormat(0.00,"999999999999.99"))#</td>
			</tr>
		</cfoutput>
		</table>
   </div>
    <!---
    <p align="right">F4</right>
	 <center>
	<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput> 
	FY <cfoutput>#url.Cfy#</cfoutput> AFR 
	Abbreviated Form</center>   
	--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "Abbrev">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm">  --->
	</cfif>
     <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Abbreviated Form - F4</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
