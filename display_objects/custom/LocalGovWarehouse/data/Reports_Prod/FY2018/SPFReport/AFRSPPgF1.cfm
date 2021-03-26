<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
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
 
<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Assets">
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<div class="row-fluid">
       
<div class="span2"></div>
<div class="span8">

<h3><a href="#PercAmt">View Percentages for Assets/Liabilities/Equity</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2017/SPFReport/AFRSPPgF1.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=F1a" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
		<tr><td colspan="11" align="center" valign="top"><font size="-1"><b>Statement of Financial Position</b>&nbsp;</font></td></tr>
		<tr><td colspan="11" align="center" valign="top"><font size="-1"><b>All Funds and Discretely Presented Component Units</b>&nbsp;</font></td></tr>
		<tr><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>General</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Special<br>Revenue</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Capital<br>Project</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Debt<br>Service</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Enterprise</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Internal<br>Service</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Fiduciary</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Account<br>Group</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Discretely<br>Presented<br>Component<br>Units</b>&nbsp;</font></td></tr>
		<cfoutput query="GetAssetCategoryRpt">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "101t">
			<tr><td Colspan=11><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Assets</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers&nbsp;</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "102t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "115t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "109t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "111t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(AG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "112t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "113t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(AG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "114t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(AG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>120t</b>&nbsp;</font></td><td><font size="-1"><b>Total Assets</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GetTotAsset.TotAsstGN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotAsset.TotAsstSR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotAsset.TotAsstCP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotAsset.TotAsstDS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotAsset.TotAsstEP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotAsset.TotAsstTS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotAsset.TotAsstFD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotAsset.TotAsstAG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotAsset.TotAsstDP)#&nbsp;</font></td>
			</tr>
		</cfif>
	</cfoutput>
	<cfoutput query="GetLiabilityCategoryRpt">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "122t">
			<tr><td Colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-1"><b>Liabilities</b>&nbsp;</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "121t">
			<!--- Do not show this field but use it in the totals --->
		<cfelseif #Category1# is "132t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
			<cfelseif #Category1# is "133t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(AG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "134t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(AG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "128t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(AG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>135t</b>&nbsp;</font></td><td><font size="-1"><b>Total Liabilities</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GetTotLiabilities.TotLiabGN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabilities.TotLiabSR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabilities.TotLiabCP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabilities.TotLiabDS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabilities.TotLiabEP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabilities.TotLiabTS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabilities.TotLiabFD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabilities.TotLiabAG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabilities.TotLiabDP)#&nbsp;</font></td>
			</tr>
		</cfif>
	</cfoutput>
	<cfoutput query="GetEquityCategoryRpt">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "136t">
			<tr><td Colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-1"><b>Equity</b>&nbsp;</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "137t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "138t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "139t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "140t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "141t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right" bgcolor="gray">&nbsp;</td><td align="right"><font size="-1">#NumberFormat(AG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>142t</b>&nbsp;</font></td><td><font size="-1"><b>Total Equity</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GetTotEquity.TotEquityGN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotEquity.TotEquitySR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotEquity.TotEquityCP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotEquity.TotEquityDS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotEquity.TotEquityEP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotEquity.TotEquityTS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotEquity.TotEquityFD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotEquity.TotEquityAG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotEquity.TotEquityDP)#&nbsp;</font></td>
			</tr>
			<tr><td colspan=11>&nbsp;</td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>145t</b>&nbsp;</font></td><td><font size="-1"><b>Total Liabilities and Equity</b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GetTotLiabEquity.TotEqLiabGN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabEquity.TotEqLiabSR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabEquity.TotEqLiabCP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabEquity.TotEqLiabDS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabEquity.TotEqLiabEP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabEquity.TotEqLiabTS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabEquity.TotEqLiabFD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabEquity.TotEqLiabAG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(GetTotLiabEquity.TotEqLiabDP)#&nbsp;</font></td>
			</tr>
		<cfelse>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(AG)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
        
        
        </div>
		<div class="span2">&nbsp;</div>

</div> <!--- ending fluid row --->

        <!--- Added per SR13016 --->
         <a name="PercAmt"><br><br></a>
         <div class="row-fluid">

        <div class="span4">&nbsp;</div>
        <div class="span4">
        <table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
        <tr><td  bgcolor="silver" >Assets</td><td  bgcolor="silver" >Percentages</td></tr>
        <cfoutput query="GetAssetCategoryPerctRpt">
		<tr><td align="left" ><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
         <tr><td  bgcolor="silver" >Liabilities</td><td  bgcolor="silver" >Percentages</td></tr>
        <cfoutput query="GetLiabilityCategoryPerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
         <tr><td  bgcolor="silver" >Equity</td><td  bgcolor="silver" >Percentages</td></tr>
        <cfoutput query="GetEquityCategoryPerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        </table>
           </div>
        <div class="span4">&nbsp;</div>
   </div>
		<br>
        <!---<p align="right"><font size="-1">F1a&nbsp;</font></right>
		<br><center>
<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
Special Purpose Form&nbsp;</font></center><br><br>--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "SP">
    	<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
    <cfif url.PrintIt is "No">
    	<cfoutput>
        <div align="center">
        <table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="90%">
        <tr><Td width="30%">&nbsp;</Td>
        <td width="5%">&nbsp;</td>
        <td width="30%"><center>#url.AFRDesiredData#</center></td>
        <td width="5%">&nbsp;</td>
        <td width="20%">#url.CFY# Special Purpose Form - F1a</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>