<!---
Date Modified: 6-12-12
Modified By: Gary Ashbaugh
Modifications Made: Removed Export to History Feature
--->
<cflock SCOPE="SESSION" TYPE="EXCLUSIVE" TIMEOUT="100">
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_UnitInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.Code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_SMALLINT" dbvarname="@C4" null="yes">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitInfoRetMsg">
	<cfprocresult name="GetUnitInfo">
</cfstoredproc>
</cfoutput>

<cfset TmpUnitName = trim(GetUnitInfo.UnitName) & " " & trim(GetUnitInfo.Description)>

<cfif GetUnitInfo.Title is not "">
	<cfset TmpGovOfficial = trim(GetUnitInfo.FirstName) & ' ' & trim(GetUnitInfo.LastName) & ', ' & trim(GetUnitInfo.Title)>
<cfelse>
	<cfset TmpGovOfficial = trim(GetUnitInfo.FirstName) & ' ' & trim(GetUnitInfo.LastName)>
</cfif>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_UnitStatInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitStatInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitInfoRetMsg">
	<cfprocresult name="GetUnitStatInfo">
</cfstoredproc>
</cfoutput>

<cfset url.PageType="Summary">
<cfset url.PageName="Component Units and Appropriations">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>

<h6 class="clearfix">
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2020/VFrmTot/Appropriations.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Verification Form&Page=1" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>

<table class="table table-bordered">
<tr>
<td>
    <cfoutput><cfif url.PrintIt is "No">
        <a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No"
            target="_New"></cfif>Appropriated^ or Budgeted<cfif url.PrintIt is "No"></a></cfif></cfoutput></td>
<td align="right">
    <cfoutput>#NumberFormat(GetUnitStatInfo.TotalAppropriations, "$99,999")#</cfoutput></td>
</tr>
</table>

     <div class="text-danger margintop">^If the Primary Government does NOT budget or levy taxes, please enter the unit's TOTAL EXPENDITURES.</div>

</cflock>
