<!---
Application: SR# 05059 - Registration Only AFR Unit
Author: Gary Ashbaugh
Date Created: 7-7-05

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Cover Page of the Registration Only AFR

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
	<cfprocparam type="In"  cfsqltype="CF_SQL_VarChar" dbvarname="@Instrument" value="Registration">
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
  
<cfset SubApprop = 0>
<cfset url.PageType="Summary">
<cfset url.PageName="Component Units and Appropriations">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<h5 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span> COMPONENT UNITS AND APPROPRIATIONS
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2016/RegOnlyReportTot/RegOnlyPg2c.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Registration Form&Page=2" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>

<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td valign="top"><b>Name of Unit/Component*</b><br><u>FUNDS SHOULD NOT BE LISTED HERE</u></td>
        <td valign="top"><b>Appropriation^</b></td>
        <td valign="top"><b>Fiscal Year End</b></td>
    </tr>
    <cfoutput>
        <cfset SubApprop = #GetAFRRptPg1.Appropriations#>
            <tr>
            <td><cfif url.PrintIt is "no">
            <a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No"
                target="_New"></cfif>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#<cfif url.PrintIt is "no"></a></cfif>
            </td>
            <td align="right">#NumberFormat(GetAFRRptPg1.Appropriations, "$999,999,999,999,999,999")#</td>
        <td>#DateFormat(GetAuditInfo.FYEnd, "MM")#/#DateFormat(GetAuditInfo.FYEnd, "DD")#</td></tr>
    </cfoutput>
    <cfoutput query="GetComponentUnitInfo">
        <cfset SubApprop = #iif(SubApprop is "", 0, SubApprop)# + #iif(Amount is "", 0, Amount)#>
            <tr>
            <td><cfif url.PrintIt is "no">
            <a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No"
                target="_New"></cfif>#ComponentUnit#<cfif url.PrintIt is "no"></a></cfif></td>
        <td align="right">#NumberFormat(Amount, "$999,999,999,999,999")#</td>
        <td>#DateFormat(FYEnd, "MM")#/#DateFormat(FYEnd, "DD")#</td></tr>
    </cfoutput>
    <cfoutput>
            <tr>
                <td><b>Total Appropriations</b></td>
            <td align="right">#NumberFormat(SubApprop, "$9,999,999,999,999,999")#</td>
            <td>&nbsp;</td></tr>
    </cfoutput>
    </table>
    </div>
    <div class="text-danger margintop marginb30">*Do not enter funds such as: Joint Bridge, Permanent Road, Town Fund,
        Equipment, Water & Sewer, General Assistance, etc.<br>^If the Primary Government or
        Component Unit does NOT budget or levy taxes, please enter the unit's TOTAL EXPENDITURES.
    </div>
    <div class="table-responsive">
    <table class="table table-bordered">
    <tr>
        <td>Primary Government Unit Name:</td>
    <td>
    <cfoutput>#GetAFRRptPg1.PrimaryUnit#</cfoutput></td>
</tr>
<tr>
    <cfoutput>
        <td colspan="2"><CFIF ltrim(rtrim(GetAFRRptPg1.ComponentFile)) is "Separate">
        <img src="#application.LocGovWarehouse#/images/Checked.jpg" width="12" height="12" border="0" alt="">&nbsp;
        <cfelse><img src="#application.LocGovWarehouse#/images/UnChecked.jpg" width="12" height="12" border="0" alt="">
            &nbsp;</cfif>Component unit files financial information separately from the primary government</td>
    </cfoutput></tr>
<tr>
    <cfoutput>
        <td colspan="2"><CFIF ltrim(rtrim(GetAFRRptPg1.ComponentFile)) is "Combined">
        <img src="#application.LocGovWarehouse#/images/Checked.jpg" width="12" height="12" border="0" alt="">&nbsp;
        <cfelse><img src="#application.LocGovWarehouse#/images/UnChecked.jpg" width="12" height="12" border="0" alt="">
            &nbsp;</cfif>Component unit files financial information along with the primary government</td>
    </cfoutput></tr>
</table>
</div>
    
<!---

		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">2&nbsp;</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Registration Only Form&nbsp;</center></td></tr>
         </table>
		 --->

</cflock>