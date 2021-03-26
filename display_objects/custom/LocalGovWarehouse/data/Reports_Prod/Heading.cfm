<cfif isDefined("form.AFRDesiredData")>
  <cfset attributes.AFRDesiredData = form.AFRDesiredData>
<cfelseif isDefined("URL.AFRDesiredData")>
  <cfset attributes.AFRDesiredData = URL.AFRDesiredData>
</cfif>

<cfparam name="url.PrintIt" default="No">
<cfoutput>
<cfStoredProc  datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>

<cfif attributes.AFRDesiredData is "Contact Information">
</cfif>
<h1 class="pageTitle"><span>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</span></h1>
<h2 class="text-center">Currently Viewing #URL.CFY#</h2>
</cfoutput>