<!---
Application: SR# 05059 - Registration Only AFR Unit
Author: Gary Ashbaugh
Date Created: 7-7-05

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Cover Page of the Registration Only AFR

 --->
<CFLOCK SCOPE="Session" timeout="100">
<!--- Find out if unit has already submitted their AFR --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Check_IfFinished">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckIfFinishedRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckIfFinishedRetMsg">
	<cfprocresult name="CheckIfFinished">
</cfstoredproc>
</cfoutput>
 
<!--- Pull of the unit's name --->

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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ReportingInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetReportingInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetReportingInfoRetMsg">
	<cfprocresult name="GetReportingInfo">
</cfstoredproc>
</cfoutput>
  
<cfset url.PageType="AFR">
<cfset url.PageName="Reporting">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 6:  REPORTING
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2017/RegOnlyReport/RegOnlyPg3.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Registration Form&Page=3" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>
<b>Check any state or local entity where financial reports are filed.</b>
<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td colspan="2"><b>STATE AGENCIES</b></td>
    </tr>
    <cfoutput>
        <tr>
        <td>
        <cfif UCase(GetReportingInfo.BoardofEducation) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif>- Board of Education</td>
    <td align="left">
        <cfif UCase(GetReportingInfo.BoardofHigherEducation) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif> - Board of Higher Education</td></tr>
    <tr>
    <td>
        <cfif UCase(GetReportingInfo.DCCA) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif>- DCEO</td>
    <td align="left">
        <cfif UCase(GetReportingInfo.DepartmentofInsurance) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif> - Department of Insurance</td></tr>
        <tr>
            <td colspan="2"><b>OTHER STATE OR LOCAL OFFICES</b></td>
        </tr>
    <tr>
    <td>
        <cfif UCase(GetReportingInfo.IllinoisComptroller) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif>- Illinois Comptroller</td>
    <td align="left">
        <cfif UCase(GetReportingInfo.SecretaryofState) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif> - Secretary of State</td></tr>
    <tr>
    <td>
        <cfif UCase(GetReportingInfo.GeneralAssemblyHouse) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif>- General Assembly - House</td>
    <td align="left">
        <cfif UCase(GetReportingInfo.GeneralAssemblySenate) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif> - General Assembly - Senate</td></tr>
    <tr>
    <td>
        <cfif UCase(GetReportingInfo.CountyClerk) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif>- County Clerk</td>
    <td align="left">
        <cfif UCase(GetReportingInfo.CircuitClerk) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif> - Circuit Clerk</td></tr>
    <tr>
    <td>
        <cfif UCase(GetReportingInfo.GovernorsOffice) is "Y">
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                    width="12" height="12" border="0" alt=""><cfelse>
                <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                    width="12" height="12" border="0" alt=""></cfif>- Governor's Office</td>
    <td align="left"><cfif GetReportingInfo.Other is not "">
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                width="12" height="12" border="0" alt=""><cfelse>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                width="12" height="12" border="0" alt=""></cfif> - Other - <cfif GetReportingInfo.Other is not "">
            <u>#GetReportingInfo.Other#</u><cfelse>________________</cfif></td></tr>
    </cfoutput>
    </table>
    </div>
<!---
<center>3<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput><br>
Registration Form</center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "RegOnly">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
    <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Registration Form - 3</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
