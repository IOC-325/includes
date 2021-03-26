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
Modifications Made:  Changed Selection criteria to include url.CFY criteria instead of just CFY
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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevCategoryMPPgF2Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevCategoryMPPgF2RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevCategoryMPPgF2RptRetMsg">
	<cfprocresult name="GetRevCategoryMPPgF2Rpt">
</cfstoredproc>
</cfoutput>

 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevCategoryMPPgF3Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevCategoryMPPgF3RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevCategoryMPPgF3RptRetMsg">
	<cfprocresult name="GetRevCategoryMPPgF3Rpt">
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
 
<cfset url.PageType="AFR">
<cfset url.PageName="Revenues">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h3 class="clearfix"><a href="#PercAmt">View Percentages for Revenues</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2019/MPFReport/AFRMPPgF2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F2-F3" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td colspan="10" align="center"><b>Revenues and Receipts</b></td>
    </tr>
		<tr><td valign="top" align="center"><b>Code</b></td><td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td><td align="center" valign="top"><b>General</b></td><td align="center" valign="top"><b>Special Revenue</b></td><td align="center" valign="top"><b>Capital Project</b></td><td align="center" valign="top"><b>Debt Service</b></td><td align="center" valign="top"><b>Enterprise</b></td><td align="center" valign="top"><b>Internal Service</b></td><td align="center" valign="top"><b>Fiduciary</b></td><td align="center" valign="top"><b>Discretely Presented Component Units</b></td></tr>
		<cfoutput query="GetRevCategoryMPPgF2Rpt">
		<Cfset Category1=Left(RevenueID, 4)>
		<cfif #Category1# is "201t">
			<tr><td colspan="2"><b>Local Taxes</b></td>
                <td colspan="8">Report in Whole Numbers</td></tr>
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "202t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "203t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "203a" or #Category1# is "203b" or #Category1# is "203c" or #Category1# is "203d">
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "211t">
			<tr><td Colspan="10"><b>Intergovernmental Receipts & Grants</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "212t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "213t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "214t" or #Category1# is "205t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "215t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "215a" or #Category1# is "215b" or #Category1# is "215c" or #Category1# is "215d" or #Category1# is "215e" or #Category1# is "215f" or #Category1# is "215g" or #Category1# is "215h" or #Category1# is "215i" or #Category1# is "215j">
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "225t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "225a" or #Category1# is "225b" or #Category1# is "225c" or #Category1# is "225d" or #Category1# is "225e" or #Category1# is "225f" or #Category1# is "225g">
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "226t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelse>
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		</cfif>
		</cfoutput>
        <cfoutput query="GetRevCategoryMPPgF3Rpt">
		<Cfset Category1=Left(RevenueID, 4)>
		
		<cfif #Category1# is "225h" or #Category1# is "225i" or #Category1# is "225j">
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "226t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "231t">
			<tr><td Colspan="10"><b>Other Sources</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "233t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "234t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "234a" or #Category1# is "234b" or #Category1# is "234c" or #Category1# is "234d" or #Category1# is "234e" or #Category1# is "234f" or #Category1# is "234g" or #Category1# is "234h" or #Category1# is "234i" or #Category1# is "234j" or #Category1# is "234k">
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "235t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "236t">
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
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
			<tr><td><b>#RevenueID#</b></td><td><b>#RevenueDescription#</b></td>
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
        
        <!---<p align="right">F2 and F3</right>
		 <center>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput> 
FY <cfoutput>#url.CFY#</cfoutput> AFR 
Multi-Purpose Form</center>
   --->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "MP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm">  --->
	</cfif>
     <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Multi-Purpose Form - F2-F3</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
