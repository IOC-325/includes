<!---
Author: Gary Ashbaugh
Date Created: 5-28-2019

LOGIC: Pulls off a list of Error(s) still needing to be resolved

 --->

 <!--- Pull of the unit's name --->
<CFLOCK SCOPE="Session" timeout="100">
<cfoutput>
<cfStoredProc Datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>

<cfinclude template="../CheckErrors.cfm">

<cfStoredProc Datasource="#application.SQLSource#" Procedure="Get_ListErrors">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetListErrorsRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListErrorsRetMsg">
	<cfprocresult name="GetListErrors">
</cfstoredproc>
</cfoutput>
 
<cfset url.PageType="AFR">
<cfset url.PageName="List of Errors">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<!---<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">--->
</div>
<h3 class="clearfix">
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2019/MPFReport/ErrorList.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F13" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>
</cfif>
</cfoutput>
</h3>
<cfset TmpErrorHeader=" ">
<cfset ShowHeader = " ">
		<h3 class="text-center">List of Error(s) still needing to be resolved</h3>
        <div class="table-responsive">
        <table class="table table-bordered">
        <cfif GetListErrors.recordcount>
			<cfoutput query="GetListErrors">
                <cfif trim(GetListErrors.ShowStopper) is "Y">
                    <cfif trim(TmpErrorHeader) is "">
                        <cfset TmpErrorHeader = "Critical">
                        <cfset ShowHeader = "Yes">
                    <cfelseif trim(TmpErrorHeader) is "Non-Critical">
                        <cfset TmpErrorHeader = "Critical">
                        <cfset ShowHeader = "Yes">
                    <cfelse>
                        <cfset ShowHeader = "No">
                    </cfif>
                <cfelse>
                    <cfif trim(TmpErrorHeader) is "">
                        <cfset TmpErrorHeader = "Non-Critical">
                        <cfset ShowHeader = "Yes">
                    <cfelseif trim(TmpErrorHeader) is "Critical">
                        <cfset TmpErrorHeader = "Non-Critical">
                        <cfset ShowHeader = "Yes">
                    <cfelse>
                        <cfset ShowHeader = "No">
                    </cfif>
                 </cfif>
                 <cfif ShowHeader is "Yes">
                 <tr><td><h4 class="bold">#TmpErrorHeader#</h4></td></tr>
                 </cfif>
                <tr><td>#Heading#</td></tr>
            </cfoutput>
        <cfelse>
        	<tr><td><h4 class="bold">Critical</h4></td></tr>
         	<tr><td><h4 class="bold">Non-Critical</h4></td></tr>
        </cfif>
		</table>
    </div>
        <cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "MP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
     <cfif url.PrintIt is "No">
        <cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Multi-Purpose Form - F13</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
