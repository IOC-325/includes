<!---
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the Expenditures table to show a unformatted view of the Page F3 of the AFR

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
 
<!--- pulls off fields for Expenditures --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpCategoryAbbrPgF2WH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpCategoryAbbrPgF2RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpCategoryAbbrPgF2RptRetMsg">
	<cfprocresult name="GetExpCategoryAbbrPgF2WH">
</cfstoredproc>
</cfoutput>

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpAbbrPerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpPerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpPerctRptRetMsg">
	<cfprocresult name="GetExpPerctRpt">
</cfstoredproc>
</cfoutput>

<!---
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotExpenditure">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotExpenditureRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotExpenditureRetMsg">
	<cfprocresult name="GetTotExpenditure">
</cfstoredproc>
</cfoutput> 
--->
 
<cfset url.PageType="Summary">
<cfset url.PageName="Expenditures">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h4 class="clearfix"><a href="#PercAmt">View Percentages for Expenditures</a>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2018/ABRReportTot/ABRSPPgF2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=F2" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>
</cfif>
</cfoutput>
</h4>

<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td colspan="3" align="center"><b>Disbursements, Expenditures and Expenses</b></td>
    </tr>
		<tr><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td><td align="center" valign="top"><b>Totals (Across All Funds)</b></td></tr>
		<Cfset TotalExpenditure=0>
		<cfoutput query="GetExpCategoryAbbrPgF2WH">
		<Cfset Category1=Left(DispID, 4)>
		<cfif #Category1# is "251t"><Cfset TotalExpenditure=TotalExpenditure+#TotAmount#>
			<tr><td Colspan="3" align="center">Report in Whole Numbers</td></tr>
			<tr><td><b>#DispID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "260t"><Cfset TotalExpenditure=TotalExpenditure+#TotAmount#>
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
			<tr><td><b>270t</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Expenditures/Expense<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#Numberformat(IIF (TotalExpenditure is not "",NumberFormat(TotalExpenditure,"999999999999999"),0))#</td>
			</tr>
		<cfelse><Cfset TotalExpenditure=TotalExpenditure+#TotAmount#>
			<tr><td><b>#DispID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
    </div>

         <!--- Added per SR13016 --->
    <a name="PercAmt"></a>
    <div class="row margintop30">
    <div class="col-xs-12 col-sm-8 col-md-6">
    <div class="table-responsive">
    <table class="table table-bordered">
        <tr><th bgcolor="silver">Expenditures</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetExpPerctRpt">
		<tr><td align="left">#DispDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
    </table>
    </div>
    </div>
    </div>
<!---        <table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">F2</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Abbreviated Form</center></td></tr>
         </table>--->


</cflock>
