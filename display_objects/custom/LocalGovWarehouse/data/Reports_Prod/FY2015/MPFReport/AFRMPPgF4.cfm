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
Date Modified: 8-27-01
Modified By: Gary Ashbaugh
Modifications Made: Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpCategoryMPPgF4Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpCategoryMPPgF4RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpCategoryMPPgF4RptRetMsg">
	<cfprocresult name="GetExpCategoryMPPgF4Rpt">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpCategoryMPPgF5Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpCategoryMPPgF5RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpCategoryMPPgF5RptRetMsg">
	<cfprocresult name="GetExpCategoryMPPgF5Rpt">
</cfstoredproc>
</cfoutput>

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpMPPerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpPerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpPerctRptRetMsg">
	<cfprocresult name="GetExpPerctRpt">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotExpenditure">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotExpenditureRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotExpenditureRetMsg">
	<cfprocresult name="GetTotExpenditure">
</cfstoredproc>
</cfoutput>
 
<cfset url.PageType="AFR">
<cfset url.PageName="Expenditures">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h3 class="clearfix"><a href="#PercAmt">View Percentages for Expenditures</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2015/MPFReport/AFRMPPgF4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F4-F5" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td colspan="10" align="center"><b>Disbursements, Expenditures and Expenses</b></td>
    </tr>
    <tr>
        <td valign="top" align="center"><b>Code</b></td>
        <td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td>
        <td align="center" valign="top"><b>General</b></td>
        <td align="center" valign="top"><b>Special Revenue</b></td>
        <td align="center" valign="top"><b>Capital Project</b></td>
        <td align="center" valign="top"><b>Debt Service</b></td>
        <td align="center" valign="top"><b>Enterprise</b></td>
        <td align="center" valign="top"><b>Internal Service</b></td>
        <td align="center" valign="top"><b>Fiduciary</b></td>
        <td align="center" valign="top"><b>Discretely Presented Component Units</b></td>
    </tr>
		<cfoutput query="GetExpCategoryMPPgF4Rpt">
		<Cfset Category1=Left(DispID, 4)>
		<cfif #Category1# is "251t">
			<tr><td Colspan="10" align="center">Report in Whole Numbers</td></tr>
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "251a" or #Category1# is "251b" or #Category1# is "251c" or #Category1# is "251d">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "252t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "252a" or #Category1# is "252b" or #Category1# is "252c" or #Category1# is "252d">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "253t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "254t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "255t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "255a" or #Category1# is "255b" or #Category1# is "255c" or #Category1# is "255d" or #Category1# is "255e">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "256t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "256a" or #Category1# is "256b" or #Category1# is "256c" or #Category1# is "256d" or #Category1# is "256e">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "257t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "257a" or #Category1# is "257b" or #Category1# is "257c">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "258t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "275t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "275a" or #Category1# is "275b" or #Category1# is "275c">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "259t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "259a" or #Category1# is "259b">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "271t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "271a" or #Category1# is "271b" or #Category1# is "271c" or #Category1# is "271d">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "272t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "260t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "270t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelse>
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		</cfif>
		</cfoutput>
        <cfoutput query="GetExpCategoryMPPgF5Rpt">
		<Cfset Category1=Left(DispID, 4)>
		<cfif #Category1# is "251t">
			<tr><td Colspan="10" align="center">Report in Whole Numbers</td></tr>
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "251a" or #Category1# is "251b" or #Category1# is "251c" or #Category1# is "251d">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "252t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "252a" or #Category1# is "252b" or #Category1# is "252c" or #Category1# is "252d">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "253t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "254t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "255t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "255a" or #Category1# is "255b" or #Category1# is "255c" or #Category1# is "255d" or #Category1# is "255e">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "256t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "256a" or #Category1# is "256b" or #Category1# is "256c" or #Category1# is "256d" or #Category1# is "256e">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "257t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "257a" or #Category1# is "257b" or #Category1# is "257c">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "258t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "275t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "275a" or #Category1# is "275b" or #Category1# is "275c">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "259t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "259a" or #Category1# is "259b">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "271t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(GN)#</td><td align="right" bgcolor="gray">#NumberFormat(SR)#</td><td align="right" bgcolor="gray">#NumberFormat(CP)#</td><td align="right" bgcolor="gray">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(EP)#</td><td align="right" bgcolor="gray">#NumberFormat(TS)#</td><td align="right" bgcolor="gray">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "271a" or #Category1# is "271b" or #Category1# is "271c" or #Category1# is "271d">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "272t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "260t">
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
			<tr><td><b>270t</b></td><td><b>Total Expenditures/Expense</b></td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpGN is not "",NumberFormat(GetTotExpenditure.TotExpGN,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpSR is not "",NumberFormat(GetTotExpenditure.TotExpSR,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpCP is not "",NumberFormat(GetTotExpenditure.TotExpCP,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpDS is not "",NumberFormat(GetTotExpenditure.TotExpDS,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpEP is not "",NumberFormat(GetTotExpenditure.TotExpEP,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpTS is not "",NumberFormat(GetTotExpenditure.TotExpTS,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpFD is not "",NumberFormat(GetTotExpenditure.TotExpFD,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpDP is not "",NumberFormat(GetTotExpenditure.TotExpDP,"9999999999999999"),0))#</td>
			</tr>
		<cfelse>
			<tr><td><b>#DispId#</b></td><td><b>#DispDescription#</b></td>
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
             <tr><th bgcolor="silver">Expenditures</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetExpPerctRpt">
		<tr><td align="left">#DispDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
    </table>
    </div>
    </div>
    </div>
        
        <!---<p align="right">F4</right>
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
        <td>#url.CFY# Multi-Purpose Form - F4-F5</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
