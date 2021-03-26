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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AssetCategoryWH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAssetCategoryRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAssetCategoryRptRetMsg">
	<cfprocresult name="GetAssetCategoryWH">
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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_LiabilityCategoryWH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLiabilityCategoryRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLiabilityCategoryRptRetMsg">
	<cfprocresult name="GetLiabilityCategoryWH">
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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_EquityCategoryWH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetEquityCategoryRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetEquityCategoryRptRetMsg">
	<cfprocresult name="GetEquityCategoryWH">
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
 <!---
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotAsset">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotAssetRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotAssetRetMsg">
	<cfprocresult name="GetTotAsset">
</cfstoredproc>
</cfoutput>
 

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotLiabilities">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotLiabilitiesRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotLiabilitiesRetMsg">
	<cfprocresult name="GetTotLiabilities">
</cfstoredproc>
</cfoutput>
 

 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotEquity">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotEquityRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotEquityRetMsg">
	<cfprocresult name="GetTotEquity">
</cfstoredproc>
</cfoutput>
 

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotLiabEquity">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotLiabEquityRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotLiabEquityRetMsg">
	<cfprocresult name="GetTotLiabEquity">
</cfstoredproc>
</cfoutput>
 --->
<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="Summary">
<cfset url.PageName="Assets">
<div class="jumbotron">
<cfinclude template="/Data/Reports/SummaryHeading.cfm">
<cfinclude template="/Data/Reports/AvailableSumAFR.cfm">
</div>

<!--- Added per SR13016 --->
<h6><a href="#PercAmt">View Percentages for Assets/Liabilities/Equity</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/MPFReportTot/AFRMPPgF1.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=F1" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>

		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box" width="100%">
		<tr><td colspan="11" align="center"><font size="-1"><b>Statement of Financial Position</b></font></td></tr>
		<tr><td colspan="11" align="center"><font size="-1"><b>All Funds and Discretely Presented Component Units</b></font></td></tr>
		<tr><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b></font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b></font></td><td align="center" valign="top"><font size="-1"><b>Totals (Across All Funds)</b></font></td></tr>
        <cfset TotAssets = 0>
        <cfset TotLiabilities = 0>
        <cfset TotEquity = 0>
        <cfset TotLiabEquity = 0>
		<cfoutput query="GetAssetCategoryWH">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "101t"> <cfset TotAssets = TotAssets +#TotAmount#>
			<tr><td Colspan=11><center><font size="-1"><b>Assets</b></font></td></tr>
			<tr><td <!--- bgcolor="silver" --->  width="10%"><font size="-1"><b>#AssetID#</b></font></td><td  width="65%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "102t"><cfset TotAssets = TotAssets +#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b></font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "115t"><cfset TotAssets = TotAssets +#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "109t"><cfset TotAssets = TotAssets +#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "111t"><cfset TotAssets = TotAssets +#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "112t"><cfset TotAssets = TotAssets +#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "113t"><cfset TotAssets = TotAssets +#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "114t"><cfset TotAssets = TotAssets +#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>120t</b>&nbsp;</font></td><td><font size="-1"><b><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_new"></cfif>Total Assets<cfif url.PrintIt is "No"></a></cfif></b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAssets)#&nbsp;</font></td>
			</tr>
		</cfif>
</cfoutput>
<cfoutput query="GetLiabilityCategoryWH">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "122t"><cfset TotLiabilities = TotLiabilities +#TotAmount#>
			<tr><td Colspan=11><center><font size="-1"><b>Liabilities</b></font></center></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "121t"><cfset TotLiabilities = TotLiabilities +#TotAmount#>
			<!--- Do not show this field but use it in the totals --->
		<cfelseif #Category1# is "132t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
			<cfelseif #Category1# is "133t"><cfset TotLiabilities = TotLiabilities +#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "134t"><cfset TotLiabilities = TotLiabilities +#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "128t"><cfset TotLiabilities = TotLiabilities +#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>135t</b>&nbsp;</font></td><td><font size="-1"><b><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_new"></cfif>Total Liabilities<cfif url.PrintIt is "No"></a></cfif></b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotLiabilities)#&nbsp;</font></td>
			</tr>
	</cfif>
	</cfoutput>
	<cfoutput query="GetEquityCategoryWH">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "136t"><Cfset TotEquity=TotEquity+#TotAmount#>
			<tr><td Colspan=11><center><font size="-1"><b>Equity</b></font></center></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "137t"><Cfset TotEquity=TotEquity+#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "138t"><Cfset TotEquity=TotEquity+#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "139t"><Cfset TotEquity=TotEquity+#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "140t"><Cfset TotEquity=TotEquity+#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "141t"><Cfset TotEquity=TotEquity+#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>142t</b>&nbsp;</font></td><td><font size="-1"><b><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_new"></cfif>Total Equity<cfif url.PrintIt is "No"></a></cfif></b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotEquity)#&nbsp;</font></td>
			</tr>
			<tr><td colspan=11>&nbsp;</td></tr> <cfset TotLiabEquity = iif(TotLiabilities is "",0,TotLiabilities) + iif(TotEquity is "",0,TotEquity)>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>145t</b>&nbsp;</font></td><td><font size="-1"><b><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_new"></cfif>Total Liabilities and Equity<cfif url.PrintIt is "No"></a></cfif></b>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotLiabEquity)#&nbsp;</font></td>
			</tr>
		<cfelse><Cfset TotEquity=TotEquity+#TotAmount#>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
         <!--- Added per SR13016 --->
         <a name="PercAmt"><br><br></a>
        <table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
        <tr><td <!--- bgcolor="silver" --->>Assets</td><td <!--- bgcolor="silver" --->>Percentages</td></tr>
        <cfoutput query="GetAssetCategoryPerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
         <tr><td <!--- bgcolor="silver" --->>Liabilities</td><td <!--- bgcolor="silver" --->>Percentages</td></tr>
        <cfoutput query="GetLiabilityCategoryPerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
         <tr><td <!--- bgcolor="silver" --->>Equity</td><td <!--- bgcolor="silver" --->>Percentages</td></tr>
        <cfoutput query="GetEquityCategoryPerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        </table>        
<!---        <br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">F1a&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Multi-Purpose Form&nbsp;</font></center></td></tr>
         </table>--->
<!---</body>
</html>--->
</cflock>
