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

LOGIC: Pulls off data from the Assets table to show a unformatted view of the Page F1 of the AFR

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

<!--- pulls off fields for Assets --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AssetCategoryRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAssetCategoryRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAssetCategoryRptRetMsg">
	<cfprocresult name="GetAssetCategoryRpt">
</cfstoredproc>
</cfoutput> 

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AssetCategoryPerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAssetCategoryPerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAssetCategoryPerctRptRetMsg">
	<cfprocresult name="GetAssetCategoryPerctRpt">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_LiabilityCategoryRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLiabilityCategoryRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLiabilityCategoryRptRetMsg">
	<cfprocresult name="GetLiabilityCategoryRpt">
</cfstoredproc>
</cfoutput> 

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_LiabilityCategoryPerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLiabilityCategoryPerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLiabilityCategoryPerctRptRetMsg">
	<cfprocresult name="GetLiabilityCategoryPerctRpt">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_EquityCategoryRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetEquityCategoryRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetEquityCategoryRptRetMsg">
	<cfprocresult name="GetEquityCategoryRpt">
</cfstoredproc>
</cfoutput> 

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_EquityCategoryPerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetEquityCategoryPerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetEquityCategoryPerctRptRetMsg">
	<cfprocresult name="GetEquityCategoryPerctRpt">
</cfstoredproc>
</cfoutput> 

 <!--- Calculate total Assets --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotAsset">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotAssetRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotAssetRetMsg">
	<cfprocresult name="GetTotAsset">
</cfstoredproc>
</cfoutput>
 
  <!--- Calculate total Liabilities --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotLiabilities">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotLiabilitiesRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotLiabilitiesRetMsg">
	<cfprocresult name="GetTotLiabilities">
</cfstoredproc>
</cfoutput>
 
   <!--- Calculate total Equity --->
 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotEquity">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotEquityRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotEquityRetMsg">
	<cfprocresult name="GetTotEquity">
</cfstoredproc>
</cfoutput>
 
    <!--- Calculate total Liability & Equity --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotLiabEquity">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotLiabEquityRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotLiabEquityRetMsg">
	<cfprocresult name="GetTotLiabEquity">
</cfstoredproc>
</cfoutput>
 
<cfset url.PageType="AFR">
<cfset url.PageName="Assets">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h3 class="clearfix"><a href="#PercAmt">View Percentages for Assets/Liabilities/Equity</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2017/MPFReport/AFRMPPgF1.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F1a" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<div class="table-responsive-new">
<table class="table table-bordered">
		<tr><td colspan="11" align="center"><b>Statement of Financial Position</b></td></tr>
		<tr><td colspan="11" align="center"><b>All Funds and Discretely Presented Component Units</b></td></tr>
    <tr>
        <td align="center" valign="top"><b>Code</b></td>
        <td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td>
        <td align="center" valign="top"><b>General</b></td>
        <td align="center" valign="top"><b>Special Revenue</b></td>
        <td align="center" valign="top"><b>Capital Project</b></td>
        <td align="center" valign="top"><b>Debt Service</b></td>
        <td align="center" valign="top"><b>Enterprise</b></td>
        <td align="center" valign="top"><b>Internal Service</b></td>
        <td align="center" valign="top"><b>Fiduciary</b></td>
        <td align="center" valign="top"><b>Account Group</b></td>
        <td align="center" valign="top"><b>Discretely Presented Component Units</b></td>
    </tr>
		<cfoutput query="GetAssetCategoryRpt">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "101t">
                <tr><td colspan="2"><b>Assets</b></td>
                    <td colspan="9">Report in Whole Numbers</td></tr>
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "102t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "115t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "109t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "111t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(AG)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "112t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "113t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(AG)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "114t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(AG)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
			<tr><td><b>120t</b></td><td><b>Total Assets</b></td>
			<td align="right">#NumberFormat(GetTotAsset.TotAsstGN)#</td><td align="right">#NumberFormat(GetTotAsset.TotAsstSR)#</td><td align="right">#NumberFormat(GetTotAsset.TotAsstCP)#</td><td align="right">#NumberFormat(GetTotAsset.TotAsstDS)#</td><td align="right">#NumberFormat(GetTotAsset.TotAsstEP)#</td><td align="right">#NumberFormat(GetTotAsset.TotAsstTS)#</td><td align="right">#NumberFormat(GetTotAsset.TotAsstFD)#</td><td align="right">#NumberFormat(GetTotAsset.TotAsstAG)#</td><td align="right">#NumberFormat(GetTotAsset.TotAsstDP)#</td>
			</tr>
		</cfif>
</cfoutput>
<cfoutput query="GetLiabilityCategoryRpt">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "122t">
			<tr><td colspan="11"><b>Liabilities</b></td></tr>
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "121t">
			<!--- Do not show this field but use it in the totals --->
		<cfelseif #Category1# is "132t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
			<cfelseif #Category1# is "133t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(AG)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "134t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(AG)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "128t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(AG)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
			<tr><td><b>135t</b></td><td><b>Total Liabilities</b></td>
			<td align="right">#NumberFormat(GetTotLiabilities.TotLiabGN)#</td><td align="right">#NumberFormat(GetTotLiabilities.TotLiabSR)#</td><td align="right">#NumberFormat(GetTotLiabilities.TotLiabCP)#</td><td align="right">#NumberFormat(GetTotLiabilities.TotLiabDS)#</td><td align="right">#NumberFormat(GetTotLiabilities.TotLiabEP)#</td><td align="right">#NumberFormat(GetTotLiabilities.TotLiabTS)#</td><td align="right">#NumberFormat(GetTotLiabilities.TotLiabFD)#</td><td align="right">#NumberFormat(GetTotLiabilities.TotLiabAG)#</td><td align="right">#NumberFormat(GetTotLiabilities.TotLiabDP)#</td>
			</tr>
	</cfif>
	</cfoutput>
	<cfoutput query="GetEquityCategoryRpt">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "136t">
			<tr><td colspan="11"><b>Equity</b></td></tr>
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "137t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "138t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "139t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "140t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "141t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right" bgcolor="gray">#NumberFormat(0)#</td><td align="right">#NumberFormat(AG)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
			<tr><td><b>142t</b></td><td><b>Total Equity</b></td>
			<td align="right">#NumberFormat(GetTotEquity.TotEquityGN)#</td><td align="right">#NumberFormat(GetTotEquity.TotEquitySR)#</td><td align="right">#NumberFormat(GetTotEquity.TotEquityCP)#</td><td align="right">#NumberFormat(GetTotEquity.TotEquityDS)#</td><td align="right">#NumberFormat(GetTotEquity.TotEquityEP)#</td><td align="right">#NumberFormat(GetTotEquity.TotEquityTS)#</td><td align="right">#NumberFormat(GetTotEquity.TotEquityFD)#</td><td align="right">#NumberFormat(GetTotEquity.TotEquityAG)#</td><td align="right">#NumberFormat(GetTotEquity.TotEquityDP)#</td>
			</tr>
			<tr><td colspan="11">&nbsp;</td></tr>
			<tr><td><b>145t</b></td><td><b>Total Liabilities and Equity</b></td>
			<td align="right">#NumberFormat(GetTotLiabEquity.TotEqLiabGN)#</td><td align="right">#NumberFormat(GetTotLiabEquity.TotEqLiabSR)#</td><td align="right">#NumberFormat(GetTotLiabEquity.TotEqLiabCP)#</td><td align="right">#NumberFormat(GetTotLiabEquity.TotEqLiabDS)#</td><td align="right">#NumberFormat(GetTotLiabEquity.TotEqLiabEP)#</td><td align="right">#NumberFormat(GetTotLiabEquity.TotEqLiabTS)#</td><td align="right">#NumberFormat(GetTotLiabEquity.TotEqLiabFD)#</td><td align="right">#NumberFormat(GetTotLiabEquity.TotEqLiabAG)#</td><td align="right">#NumberFormat(GetTotLiabEquity.TotEqLiabDP)#</td>
			</tr>
		<cfelse>
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(AG)#</td><td align="right">#NumberFormat(DP)#</td>
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
        <tr><th bgcolor="silver">Assets</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetAssetCategoryPerctRpt">
		<tr><td align="left">#AssetDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
         <tr><th bgcolor="silver">Liabilities</th><th  bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetLiabilityCategoryPerctRpt">
		<tr><td align="left">#AssetDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
         <tr><th bgcolor="silver">Equity</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetEquityCategoryPerctRpt">
		<tr><td align="left">#AssetDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
    </table>
    </div>
    </div>
    </div>
        <!---
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
        <td>#url.CFY# Multi-Purpose Form - F1a</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
