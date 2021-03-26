<!---
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Page 4 of the AFR

 --->
<!--- Pull of the unit's name --->
<CFLOCK SCOPE="Session" timeout="100">
<cfoutput>
<cfStoredProc  datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>
</cfoutput>
  
<cfset url.PageType="Summary">
<cfset url.PageName="Payments to Other Governments">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<h6 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span> PAYMENTS MADE TO OTHER GOVERNMENTS
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2019/ABRReportTot/ABRSPPg4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=4" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>
<div><b>Indicate any payments <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> made to other governments for services or programs (include programs performed on a reimbursement, cost-sharing basis or federal payroll taxes).</b></div><br>

<table class="table table-bordered">
<cfoutput query="GetAFRRptPg1">
<tr><td align="left"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Intergovernmental agreements - indicate how much was paid<cfif url.PrintIt is "no"></a></cfif></td><td align="right">#NumberFormat(AmtState,"$9,999,999,999,999,999")#</td></tr>
<tr><td align="left"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Federal government payroll taxes<cfif url.PrintIt is "no"></a></cfif></td><td align="right">#NumberFormat(AmtFederal,"$9,999,999,999,999,999")#</td></tr>
<tr><td align="left"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>All other intergovernmental payments<cfif url.PrintIt is "no"></a></cfif></td><td align="right">#NumberFormat(AmtLocal,"$9,999,999,999,999,999")#</td></tr>
</cfoutput>
</table>

<!---
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">4</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Abbreviated Form</center></td></tr>
         </table>--->
</cflock>
