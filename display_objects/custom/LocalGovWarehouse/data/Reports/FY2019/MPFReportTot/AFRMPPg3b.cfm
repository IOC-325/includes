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
  
<cfset url.PageType="Summary">
<cfset url.PageName="Component Units and Appropriations">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<cfset SubApprop = 0>

<h5 class="clearfix">
	<span class="glyphicon glyphicon-circle-arrow-right"></span>
	 COMPONENT UNITS AND APPROPRIATIONS
     <span class="pull-right">
	 <cfoutput>
	 <cfif url.PrintIt is "no">
     <a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2019/MPFReportTot/AFRMPPg3b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=3" class="btn btn-primary nomargin">
     <span class="glyphicon glyphicon-print"></span>
     Print This Page
     </a>
     </span>
     </cfif></cfoutput>
</h5>

    <div class="table-responsive">
    <table class="table table-bordered">
        <tr>
            <td valign="top"><b>Name of Unit/Component*</b><br><u>FUNDS SHOULD NOT BE LISTED HERE</u></td>
            <td valign="top"><b>Appropriation^</b></td>
            <td valign="top"><b>Type of Component Unit</b></td>
            <td valign="top"><b>Fiscal Year End</b></td>
            <td valign="top"><b>Enterprise Fund Type or Governmental Fund Type</b></td>
        </tr>
    <cfoutput>
        <cfset SubApprop = #GetAFRRptPg1.Appropriations#>
            <tr>
            <td><cfif url.PrintIt is "no">
            <a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No"
                target="_New"></cfif>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#<cfif url.PrintIt is "no"></a></cfif>
            </td>
            <td align="right">#NumberFormat(GetAFRRptPg1.Appropriations, "$999,999,999,999,999,999")#</td>
            <td>&nbsp;</td>
        <td>#DateFormat(GetAuditInfo.FYEnd, "MM")#/#DateFormat(GetAuditInfo.FYEnd, "DD")#</td>
            <td>&nbsp;</td></tr>
    </cfoutput>
    <cfoutput query="GetComponentUnitInfo">
        <cfset SubApprop = #iif(SubApprop is "", 0, SubApprop)# + #iif(Amount is "", 0, Amount)#>
            <tr>
            <td><cfif url.PrintIt is "no">
            <a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No"
                target="_New"></cfif>#ComponentUnit#<cfif url.PrintIt is "no"></a></cfif></td>
        <td align="right">#NumberFormat(Amount, "$999,999,999,999,999")#</td>
        <td><cfif type is "B">Blended<cfelseif type is "DP">Discretely Presented<cfelse>&nbsp;</cfif></td>
        <td>#FYEnd#</td>
        <td>#CU_Funds#</td></tr>
    </cfoutput>
    <cfoutput>
            <tr>
            <td><b><cfif url.PrintIt is "no">
            <a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No"
                target="_New"></cfif>Total Appropriations<cfif url.PrintIt is "no"></a></cfif></b></td>
        <td align="right">#NumberFormat(SubApprop, "$9,999,999,999,999,999")#</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td></tr>
    </cfoutput>
    </table>
    </div>
<div class="text-danger margintop">*Do not enter funds such as: Joint Bridge, Permanent Road, Town Fund, Equipment, Water & Sewer, General Assistance, etc.  These funds should be included in Step9.<br>
    ^If the Primary Government or Component Unit does NOT budget or levy taxes, please enter the unit's TOTAL EXPENDITURES.</div>

<!---
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">3&nbsp;</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Multi-Purpose Form&nbsp;</center></td></tr>
         </table>--->
</cflock>