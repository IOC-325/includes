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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpCategoryMPPgF4WH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpCategoryMPPgF4RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpCategoryMPPgF4RptRetMsg">
	<cfprocresult name="GetExpCategoryMPPgF4WH">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpCategoryMPPgF5WH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpCategoryMPPgF5RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpCategoryMPPgF5RptRetMsg">
	<cfprocresult name="GetExpCategoryMPPgF5WH">
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

<cfoutput><Cfset TotalExpenditure=0>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotExpenditure">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotExpenditureRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotExpenditureRetMsg">
	<cfprocresult name="GetTotExpenditure">
</cfstoredproc>
<cfset TotalExpenditure = iif(GetTotExpenditure.TotExpGN is "",0,GetTotExpenditure.TotExpGN) + iif(GetTotExpenditure.TotExpSR is "",0,GetTotExpenditure.TotExpSR) + iif(GetTotExpenditure.TotExpCP is "",0,GetTotExpenditure.TotExpCP) + iif(GetTotExpenditure.TotExpDS is "",0,GetTotExpenditure.TotExpDS) + iif(GetTotExpenditure.TotExpEP is "",0,GetTotExpenditure.TotExpEP) + iif(GetTotExpenditure.TotExpTS is "",0,GetTotExpenditure.TotExpTS) + iif(GetTotExpenditure.TotExpFD is "",0,GetTotExpenditure.TotExpFD) + iif(GetTotExpenditure.TotExpDP is "",0,GetTotExpenditure.TotExpDP)>

</cfoutput>
 
<cfset url.PageType="Summary">
<cfset url.PageName="Expenditures">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h4 class="clearfix"><a href="#PercAmt">View Percentages for Expenditures</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2017/MPFReportTot/AFRMPPgF4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=F4" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h4>

<div class="table-responsive">
		<table class="table table-bordered">
    <tr><td colspan="3" align="center"><b>Disbursements, Expenditures and Expenses</b></td></tr>
		<tr><td valign="top" align="center"><b>Code</b></td><td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td><td align="center" valign="top"><b>Totals (Across All Funds)</b></td></tr>
		
		<cfoutput query="GetExpCategoryMPPgF4WH">
		<Cfset Category1=Left(DispID, 4)>
		<cfif #Category1# is "251t">
        	
			<tr><td colspan="3" align="center">Report in Whole Numbers</td></tr>
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "251a" or #Category1# is "251b" or #Category1# is "251c" or #Category1# is "251d">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "252t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "252a" or #Category1# is "252b" or #Category1# is "252c" or #Category1# is "252d">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "253t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "254t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "255t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "255a" or #Category1# is "255b" or #Category1# is "255c" or #Category1# is "255d" or #Category1# is "255e">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "256t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "256a" or #Category1# is "256b" or #Category1# is "256c" or #Category1# is "256d" or #Category1# is "256e">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "257t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "257a" or #Category1# is "257b" or #Category1# is "257c">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "258t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "275t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "275a" or #Category1# is "275b" or #Category1# is "275c">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "259t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "259a" or #Category1# is "259b">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "271t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "271a" or #Category1# is "271b" or #Category1# is "271c" or #Category1# is "271d">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "272t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "260t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "270t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#Numberformat(IIF (TotalExpenditure is not "",NumberFormat(TotalExpenditure,"999999999999999"),0))#</td>
			</tr>
		<cfelse>
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		</cfif>
		</cfoutput>
        <cfoutput query="GetExpCategoryMPPgF5WH">
		<Cfset Category1=Left(DispID, 4)>
		<cfif #Category1# is "251t">
        	
			<tr><td colspan="3" align="center">Report in Whole Numbers</td></tr>
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "251a" or #Category1# is "251b" or #Category1# is "251c" or #Category1# is "251d">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "252t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "252a" or #Category1# is "252b" or #Category1# is "252c" or #Category1# is "252d">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "253t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "254t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "255t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "255a" or #Category1# is "255b" or #Category1# is "255c" or #Category1# is "255d" or #Category1# is "255e">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "256t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "256a" or #Category1# is "256b" or #Category1# is "256c" or #Category1# is "256d" or #Category1# is "256e">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "257t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "257a" or #Category1# is "257b" or #Category1# is "257c">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "258t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "275t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "275a" or #Category1# is "275b" or #Category1# is "275c">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "259t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "259a" or #Category1# is "259b">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "271t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right" bgcolor="gray">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "271a" or #Category1# is "271b" or #Category1# is "271c" or #Category1# is "271d">
        	
			<tr><td><b>#DispId#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "272t">
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "260t">
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
			<tr><td><b>270t</b></td><td><b><cfif url.PrintIt is "No"><a href="/Data/Reports/FY2017/MPFReport/AFRMPPGF4.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Expenditures/Expense<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#Numberformat(IIF (TotalExpenditure is not "",NumberFormat(TotalExpenditure,"999999999999999"),0))#</td>
			</tr>
		<cfelse>
        	
			<tr><td><b>#DispId#</b></td><td><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#DispDescription#<cfif url.PrintIt is "No"></a></cfif></b></td>
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
<!---
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">F4 and F5</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Multi-Purpose Form</center></td></tr>
         </table>--->
</cflock>
