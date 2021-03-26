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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevCategoryMPPgF2WH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevCategoryMPPgF2RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevCategoryMPPgF2RptRetMsg">
	<cfprocresult name="GetRevCategoryMPPgF2WH">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevCategoryMPPgF3WH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevCategoryMPPgF3RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevCategoryMPPgF3RptRetMsg">
	<cfprocresult name="GetRevCategoryMPPgF3WH">
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

<cfoutput><Cfset TotalRevenue=0>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotRevenue">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotRevenueRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotRevenueRptRetMsg">
	<cfprocresult name="GetTotRevenue">
</cfstoredproc>
<cfset TotalRevenue = iif(GetTotRevenue.TotRevGN is "",0,GetTotRevenue.TotRevGN) + iif(GetTotRevenue.TotRevSR is "",0,GetTotRevenue.TotRevSR) + iif(GetTotRevenue.TotRevCP is "",0,GetTotRevenue.TotRevCP) + iif(GetTotRevenue.TotRevDS is "",0,GetTotRevenue.TotRevDS) + iif(GetTotRevenue.TotRevEP is "",0,GetTotRevenue.TotRevEP) + iif(GetTotRevenue.TotRevTS is "",0,GetTotRevenue.TotRevTS) + iif(GetTotRevenue.TotRevFD is "",0,GetTotRevenue.TotRevFD) + iif(GetTotRevenue.TotRevDP is "",0,GetTotRevenue.TotRevDP)>
			
</cfoutput>
 
<cfset url.PageType="Summary">
<cfset url.PageName="Revenues">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h4 class="clearfix"><a href="#PercAmt">View Percentages for Revenues</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2018/MPFReportTot/AFRMPPgF2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=F2" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h4>

<div class="table-responsive">
<table class="table table-bordered">
    <tr><td colspan="3" align="center"><b>Revenues and Receipts</b></td></tr>
    <tr>
        <td valign="top" align="center"><b>Code</b></td>
        <td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td>
        <td align="center" valign="top"><b>Totals (Across All Funds)</b></td>
    </tr>
		
		<cfoutput query="GetRevCategoryMPPgF2WH">
		<Cfset Category1=Left(RevenueID, 4)>
		<cfif #Category1# is "201t">
			
			<tr><td><b>Local Taxes</b></td>
                <td colspan="2">Report in Whole Numbers</td></tr>
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "202t">
			
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "203t">
			
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "203a" or #Category1# is "203b" or #Category1# is "203c" or #Category1# is "203d">
			
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "211t">
        	
			<tr><td Colspan="3"><b>Intergovernmental Receipts & Grants</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "212t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "213t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "214t" or #Category1# is "205t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "215t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "215a" or #Category1# is "215b" or #Category1# is "215c" or #Category1# is "215d" or #Category1# is "215e" or #Category1# is "215f" or #Category1# is "215g" or #Category1# is "215h" or #Category1# is "215i" or #Category1# is "215j">
        	
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "225t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "225a" or #Category1# is "225b" or #Category1# is "225c" or #Category1# is "225d" or #Category1# is "225e" or #Category1# is "225f" or #Category1# is "225g" or #Category1# is "225h" or #Category1# is "225i" or #Category1# is "225j">
        	
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "226t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "231t">
        	
			<tr><td Colspan="3"><b>Other Sources</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "233t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "234t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "234a" or #Category1# is "234b" or #Category1# is "234c" or #Category1# is "234d" or #Category1# is "234e" or #Category1# is "234f" or #Category1# is "234g" or #Category1# is "234h" or #Category1# is "234i" or #Category1# is "234j" or #Category1# is "234k">
        	
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "237t" or #Category1# is "235t" or #Category1# is "236t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "240t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#Numberformat(IIF (TotalRevenue is not "",NumberFormat(TotalRevenue,"999999999999999"),0))#</td>
			</tr>
		<cfelse>
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		</cfif>
		</cfoutput>
        <cfoutput query="GetRevCategoryMPPgF3WH">
		<Cfset Category1=Left(RevenueID, 4)>
		<cfif #Category1# is "201t">
        	
			<tr><td Colspan="3"><b>Local Taxes</b>Report in Whole Numbers</td></tr>
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "202t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "203t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "203a" or #Category1# is "203b" or #Category1# is "203c">
        	
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "211t">
        	
			<tr><td Colspan="3"><b>Intergovernmental Receipts</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "212t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "213t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "214t" or #Category1# is "205t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "215t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "215a" or #Category1# is "215b" or #Category1# is "215c" or #Category1# is "215d" or #Category1# is "215e" or #Category1# is "215f" or #Category1# is "215g" or #Category1# is "215h" or #Category1# is "215i" or #Category1# is "215j">
        	
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "225t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "225a" or #Category1# is "225b" or #Category1# is "225c" or #Category1# is "225d" or #Category1# is "225e" or #Category1# is "225f" or #Category1# is "225g" or #Category1# is "225h" or #Category1# is "225i" or #Category1# is "225j">
        	
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "226t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "231t">
        	
			<tr><td Colspan="3"><b>Other Sources</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "233t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "234t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "234a" or #Category1# is "234b" or #Category1# is "234c" or #Category1# is "234d" or #Category1# is "234e" or #Category1# is "234f" or #Category1# is "234g" or #Category1# is "234h" or #Category1# is "234i" or #Category1# is "234j" or #Category1# is "234k">
        	
			<tr><td><b>#RevenueID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "235t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "236t">
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
			<tr><td><b>240t</b></td><td><b><cfif url.PrintIt is "No"><a href="/Data/Reports/FY2018/MPFReport/AFRMPPGF2.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Receipts and Revenue<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#Numberformat(IIF (TotalRevenue is not "",NumberFormat(TotalRevenue,"999999999999999"),0))#</td>
			</tr>
		<cfelse>
        	
			<tr><td><b>#RevenueID#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#RevenueDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
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
		<tr><td align="right">F2 and F3</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Multi-Purpose Form</center></td></tr>
         </table>--->

</cflock>
