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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevCategorySPPgF2Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevCategorySPPgF2RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevCategorySPPgF2RptRetMsg">
	<cfprocresult name="GetRevCategorySPPgF2Rpt">
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

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotRevenue">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotRevenueRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotRevenueRptRetMsg">
	<cfprocresult name="GetTotRevenue">
</cfstoredproc>
</cfoutput> 
 
<cfset url.PageType="AFR">
<cfset url.PageName="Revenues">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h3 class="clearfix"><a href="#PercAmt">View Percentages for Revenues</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2013/SPFReport/AFRSPPgF2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=F2" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td colspan="10" align="center"><b>Revenues and Receipts</b></td>
    </tr>
		<tr><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td><td align="center" valign="top"><b>General</b></td><td align="center" valign="top"><b>Special Revenue</b></td><td align="center" valign="top"><b>Capital Project</b></td><td align="center" valign="top"><b>Debt Service</b></td><td align="center" valign="top"><b>Enterprise</b></td><td align="center" valign="top"><b>Internal Service</b></td><td align="center" valign="top"><b>Fiduciary</b></td><td align="center" valign="top"><b>Discretely Presented Component Units</b></td></tr>
		<cfoutput query="GetRevCategorySPPgF2Rpt">
		<Cfset Category1=Left(RevenueID, 4)>
		<cfif #Category1# is "201t">
			<tr><td colspan="2"><b>Local Taxes</b></td>
                <td colspan="8">Report in Whole Numbers</td></tr>
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "203t">
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right" bgcolor="gray"></td><td align="right" bgcolor="gray"></td><td align="right" bgcolor="gray"></td><td align="right" bgcolor="gray"></td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "212t">
			<tr><td colspan="10"><b>Intergovernmental Receipts & State or Federal Grants</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "213t">
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right" bgcolor="gray"></td><td align="right" bgcolor="gray"></td><td align="right" bgcolor="gray"></td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "231t">
			<tr><td colspan="10"><b>Other Sources</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "236t">
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
			<tr><td><b>240t</b></td><td><b>Total Receipts and Revenue</b></td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevGN is not "",NumberFormat(GetTotRevenue.TotRevGN,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevSR is not "",NumberFormat(GetTotRevenue.TotRevSR,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevCP is not "",NumberFormat(GetTotRevenue.TotRevCP,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevDS is not "",NumberFormat(GetTotRevenue.TotRevDS,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevEP is not "",NumberFormat(GetTotRevenue.TotRevEP,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevTS is not "",NumberFormat(GetTotRevenue.TotRevTS,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevFD is not "",NumberFormat(GetTotRevenue.TotRevFD,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevDP is not "",NumberFormat(GetTotRevenue.TotRevDP,"9999999999999999"),0))#</td>
			</tr>
		<cfelse>
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
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
        <!---<p align="right">F2</right>
		 <center>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput> 
FY <cfoutput>#url.Cfy#</cfoutput> AFR 
Special Purpose Form</center>  --->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "SP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm">  --->
	</cfif>
    <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Special Purpose Form - F2</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
