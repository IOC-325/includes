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
  
<cfset url.PageType="AFR">
<cfset url.PageName="Population, EAV, and Employees">
<cfset SubApprop = 0>
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>

<h5 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 4:  POPULATION, EAV AND EMPLOYEES
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2013/ABRReport/ABRSPPg3.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=3" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>

<div class="table-responsive">
<table class="table table-bordered">
    <cfoutput query="GetAFRRptPg1">
        <tr>
        <td>^What is the total <b>population</b> of #UnitName# #Description#?</td>
    <td align="right">#NumberFormat(Pop, "999,999,999,999,999")#</td></tr>
    <tr>
    <td>What is the total <b>EAV</b> of #UnitName# #Description#?</td>
    <td align="right">#NumberFormat(EAV, "$999,999,999,999,999,999")#</td></tr>
    <tr>
        <td>*How many <b>full time employees</b> are paid?</td>
    <td align="right">#NumberFormat(Full_Emp, "999,999,999,999,999,999")#</td></tr>
    <tr>
        <td>*How many <b>part time employees</b> are paid?</td>
    <td align="right">#NumberFormat(Part_Emp, "999,999,999,999,999,999")#</td></tr>
    <tr>
        <td>What is the <b>total salary</b> paid to all employees?</td>
    <td align="right">#NumberFormat(Salaries, "$999,999,999,999,999,999")#</td></tr>
    </cfoutput>
    </table>
    </div>
    <div class="text-danger margintop marginb30">^Or provide estimated population<br>*Do not include contractual
        employees.
    </div>
    <h5>
        <span class="glyphicon glyphicon-circle-arrow-right"></span> STEPS 5 AND 6: APPROPRIATIONS
    </h5>
    <b>Provide the appropriation for the primary government listed in the first row of the table below.</b><br>

    If you need assistance with the terms indicated below, refer to the <i><a
            href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2013/2013chartofaccounts.pdf" target="_New">Chart of
        Accounts and Definitions</a></i> and the <i><a
            href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2013/2013FAQ_HowtoAll.pdf" target="_New">How to Fill
        Out An AFR</a></i> documents.<br>
    <BR>
    <div class="text-center">FUNDS SHOULD NOT BE LISTED HERE</div>
    <br>
    <div class="table-responsive">
    <table class="table table-bordered">
    <cfoutput>
            <tr>
                <td><b>Total Appropriations</b></td>
            <td align="right">#NumberFormat(GetAFRRptPg1.Appropriations, "$999,999,999,999,999,999")#</td></tr>
    </cfoutput>
    </table>
    </div>
<!---
<center>3<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Abbreviated Form</center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "Abbrev">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
     <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Abbreviated Form - 3</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>

</cflock>