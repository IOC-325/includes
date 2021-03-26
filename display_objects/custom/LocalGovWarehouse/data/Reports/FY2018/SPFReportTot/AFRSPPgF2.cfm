<!---
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 3-13-00
Date Modified: 4-18-00
Modifications Made:  Changed to reflect new AFR
Modified By: Gary Ashbaugh
Date Modified: 6-1-00
Modified By: Gary Ashbaugh
Modifications Made: Added Unit Name and Code to the top of form
Date Modified: 4-3-01
Modified By: Gary Ashbaugh
Modifications Made:  Changed Selection criteria to include Url.CFY criteria instead of just CFY
Date Modified: 8-27-01
Modified By: Gary Ashbaugh
Modifications Made: Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

LOGIC: Pulls off data from the Revenues table to show a unformatted view of the Page F2 of the AFR

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
 
 <!--- pulls off fields for Revenues --->
 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevCategorySPPgF2WH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevCategorySPPgF2RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevCategorySPPgF2RptRetMsg">
	<cfprocresult name="GetRevCategorySPPgF2WH">
</cfstoredproc>
</cfoutput>

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevMPPerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevPerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevPerctRptRetMsg">
	<cfprocresult name="GetRevPerctRpt">
</cfstoredproc>
</cfoutput>

<!---
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotRevenue">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotRevenueRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotRevenueRptRetMsg">
	<cfprocresult name="GetTotRevenue">
</cfstoredproc>
</cfoutput> 
--->
 
<cfset url.PageType="Summary">
<cfset url.PageName="Revenues">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h4 class="clearfix"><a href="#PercAmt">View Percentages for Revenues</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2018/SPFReportTot/AFRSPPgF2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Special Purpose Form&Page=F2" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h4>

    <div class="table-responsive">
    <table class="table table-bordered">
        <tr><td colspan="3" align="center"><b>Revenues and Receipts</b></td></tr>
    <tr>
      <td align="center" valign="top"><b>Code</b></td>
    <td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b>
    </td>
    <td align="center" valign="top"><b>Totals (Across All Funds)</b></td></tr>
		<Cfset TotalRevenue=0>
		<cfoutput query="GetRevCategorySPPgF2WH">
		<Cfset Category1=Left(RevenueID, 4)>
		<cfif #Category1# is "201t">
        	<Cfset TotalRevenue=TotalRevenue+#TotAmount#>
			<tr><td><b>Local Taxes</b></td>
                <td colspan="2">Report in Whole Numbers</td></tr>
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "203t">
        	<Cfset TotalRevenue=TotalRevenue+#TotAmount#>
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "212t">
        	<Cfset TotalRevenue=TotalRevenue+#TotAmount#>
			<tr><td Colspan="3"><b>Intergovernmental Receipts & State or Federal Grants</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "213t">
        	<Cfset TotalRevenue=TotalRevenue+#TotAmount#>
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "231t">
        	<Cfset TotalRevenue=TotalRevenue+#TotAmount#>
			<tr><td Colspan="3"><b>Other Sources</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "236t">
        	<Cfset TotalRevenue=TotalRevenue+#TotAmount#>
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
			<tr><td><b>240t</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Receipts and Revenue<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#Numberformat(IIF (TotalRevenue is not "",NumberFormat(TotalRevenue,"999999999999999"),0))#</td>
			</tr>
		<cfelse>
        	<Cfset TotalRevenue=TotalRevenue+#TotAmount#>
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
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
        <tr><th bgcolor="silver">Revenues</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetRevPerctRpt">
		<tr><td align="left">#RevenueDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
    </table>
    </div>
    </div>
    </div>
<!---	
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">F2</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Special Purpose Form</center></td></tr>
         </table>--->
</cflock>
