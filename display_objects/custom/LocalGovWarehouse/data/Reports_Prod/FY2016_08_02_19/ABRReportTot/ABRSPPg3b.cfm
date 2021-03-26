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
  
<cfset url.PageType="Summary">
<cfset url.PageName="Component Units and Appropriations">
<cfset SubApprop = 0>
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<h5 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span>   APPROPRIATIONS
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2016/ABRReportTot/ABRSPPg3b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=3" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
    Print This Page</a></span></cfif></cfoutput>
</h5>

<div class="table-responsive">
<table class="table table-bordered">
    <cfoutput>
            <tr>
            <td><b><cfif url.PrintIt is "no">
            <a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No"
                target="_New"></cfif>Total Appropriations<cfif url.PrintIt is "no"></a></cfif></b></td>
            <td align="right"><!---#NumberFormat(SubApprop,"$9,999,999,999,999,999")#--->#NumberFormat(GetAFRRptPg1.Appropriations, "$999,999,999,999,999,999")#
        </td></tr>
    </cfoutput>
    </table>
</div>
<!---
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">3&nbsp;</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Abbreviated Form&nbsp;</center></td></tr>
         </table>--->
</cflock>