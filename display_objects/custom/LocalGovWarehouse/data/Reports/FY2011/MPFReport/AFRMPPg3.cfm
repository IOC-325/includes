<!---
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 6-13-00
Modified By: Gary Ashbaugh
Modifications Made:  Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 8-24-01
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

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

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ComponentUnitInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetComponentUnitInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetComponentUnitInfoRetMsg">
	<cfprocresult name="GetComponentUnitInfo">
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
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2011/MPFReport/AFRMPPg3.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=3" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
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

    <h5><span class="glyphicon glyphicon-circle-arrow-right"></span> STEPS 5 AND 6: COMPONENT UNITS AND APPROPRIATIONS
    </h5>
    <b>Provide the appropriation for the primary government listed in the first row of the table below.</b><br>

    In the remaining rows, provide the names of all component units along with their appropriation.  Indicate if the component units are blended or discretely presented, its fiscal year end date and if the component unit was funded with governmental fund types or enterprise fund types.  If the component units are already indicated, that data is based on forms submitted last year.  If you have more component units than the rows provided below, please indicate them on an attachment.
    <br>

    If you need assistance with the terms indicated below, refer to the <i><a
            href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2011/2011chartofaccounts.pdf" target="_New">Chart of
        Accounts and Definitions</a></i> and the <i><a
            href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2011/2011FAQ_HowtoAll.pdf" target="_New">How to Fill
        Out An AFR</a></i> documents.<br>
    <BR>
    <div class="table-responsive">
    <table class="table table-bordered">
        <tr>
            <td valign="top"><b>Name of Unit/Component</b><br><u>FUNDS SHOULD NOT BE LISTED HERE</u></td>
            <td valign="top"><b>Appropriation</b></td>
            <td valign="top"><b>Type of Component Unit</b></td>
            <td valign="top"><b>Fiscal Year End</b></td>
            <td valign="top"><b>Enterprise Fund Type or Governmental Fund Type</b></td>
        </tr>
    <cfoutput>
        <cfset SubApprop = #GetAFRRptPg1.Appropriations#>
            <tr>
            <td>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</td>
        <td align="right">#NumberFormat(GetAFRRptPg1.Appropriations, "$999,999,999,999,999,999")#</td>
            <td></td>
        <td>#DateFormat(GetAuditInfo.FYEnd, "MM")#/#DateFormat(GetAuditInfo.FYEnd, "DD")#</td>
            <td></td></tr>
    </cfoutput>
    <cfoutput query="GetComponentUnitInfo">
        <cfset SubApprop = #iif(SubApprop is "", 0, SubApprop)# + #iif(Amount is "", 0, Amount)#>
            <tr>
            <td>#ComponentUnit#</td>
        <td align="right">#NumberFormat(Amount, "$999,999,999,999,999")#</td>
        <td><cfif type is "B">Blended<cfelseif type is "DP">Discretely Presented<cfelse></cfif></td>
        <td>#DateFormat(FYEnd, "MM")#/#DateFormat(FYEnd, "DD")#</td>
        <td>#CU_Funds#</td></tr>
    </cfoutput>
    <cfoutput>
            <tr>
                <td><b>Total Appropriations</b></td>
            <td align="right">#NumberFormat(SubApprop, "$9,999,999,999,999,999")#</td>
            <td></td>
            <td></td>
            <td></td></tr>
    </cfoutput>
    </table>
    </div>
<div class="text-danger margintop">*Do not enter funds such as: Joint Bridge, Permanent Road, Town Fund, Equipment, Water & Sewer, General Assistance, etc.  These funds should be included in Step9.<br>^If the Primary Government or Component Unit does NOT budget or levy taxes, please enter the unit's TOTAL EXPENDITURES.</div>
<!---
<center>3<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Multi-Purpose Form</center><br><br>
--->
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
        <td>#url.CFY# Multi-Purpose Form - 3</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>