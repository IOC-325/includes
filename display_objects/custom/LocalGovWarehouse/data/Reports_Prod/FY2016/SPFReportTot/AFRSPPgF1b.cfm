f 
 
 <!--- 
Date Created: 5-12-04
Created By: Gary Ashbaugh

Description:  This page will display the GASB34 Asset, Liabilities, and Net Assets information.

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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AssetCategoryGASB34WH">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAssetCategoryGASB34RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAssetCategoryGASB34RptRetMsg">
	<cfprocresult name="GetAssetCategoryGASB34WH">
</cfstoredproc>
</cfoutput> 

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AssetGASB34PerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAssetGASB34PerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAssetGASB34PerctRptRptRetMsg">
	<cfprocresult name="GetAssetGASB34PerctRpt">
</cfstoredproc>
</cfoutput> 

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_LiabilitiesGASB34PerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLiabilitiesGASB34PerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLiabilitiesGASB34PerctRptRptRetMsg">
	<cfprocresult name="GetLiabilitiesGASB34PerctRpt">
</cfstoredproc>
</cfoutput> 

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_NetAssetsGASB34PerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetNetAssetGASB34PerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetNetAssetGASB34PerctRptRptRetMsg">
	<cfprocresult name="GetNetAssetGASB34PerctRpt">
</cfstoredproc>
</cfoutput> 

 <!--- Calculate total Assets --->
 <!---
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotAssetGASB34">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotAssetGASB34RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotAssetGASB34RetMsg">
	<cfprocresult name="GetTotAssetGASB34">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotLiabGASB34">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotLiabGASB34RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotLiabGASB34RetMsg">
	<cfprocresult name="GetTotLiabGASB34">
</cfstoredproc>
</cfoutput>

 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotNetAsstGASB34">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotNetAsstGASB34RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotNetAsstGASB34RetMsg">
	<cfprocresult name="GetTotNetAsstGASB34">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotLiabNetAsstGASB34">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotLiabNetAsstGASB34RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotLiabNetAsstGASB34RetMsg">
	<cfprocresult name="GetTotLiabNetAsstGASB34">
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

<!---<div class="row-fluid">
       
<div class="span2"></div>
<div class="span8">--->

<!--- Added per SR13016 --->
<h6><a href="#PercAmt">View Percentages for Assets/Liabilities/Net Position</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/SPFReportTot/AFRSPPgF1b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Special Purpose Form&Page=F1b" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box" width="100%">
        <cfset TotAssetGASB34=0>
        <cfset TotLiabGASB34=0>
        <cfset TotNetAsstGASB34=0>
        <cfset TotLiabNetAsstGASB34=0>
		<cfoutput query="GetAssetCategoryGASB34WH">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "101t"><cfset TotAssetGASB34 = TotAssetGASB34 +#TotAmount#>
			<tr><td colspan="6"><center><b>ASSETS</b></center></td></tr>
			<tr><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b></font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b></font></td><td align="center" valign="top"><font size="-1"><b>Totals (Across All Funds)</b></font></td></tr>
			<tr><td Colspan=6><font size="-1">CURRENT ASSETS</font></td></tr>
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="65%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "102t" or #Category1# is "115t" or #Category1# is "109t" or #Category1# is "112t">
			<cfset TotAssetGASB34 = TotAssetGASB34 +#TotAmount#>
            <tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "116t"><cfset TotAssetGASB34 = TotAssetGASB34 +#TotAmount#>
			<tr><td Colspan="6"><font size="-1">NON-CURRENT ASSETS</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "117t"><cfset TotAssetGASB34 = TotAssetGASB34 +#TotAmount#>
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" ---> width="10%" valign="top"><font size="-1"><b>120t</b></font></td><td width="30%" valign="top"><font size="-1"><b><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>TOTAL ASSETS<cfif url.PrintIt is "No"></a></cfif></b></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAssetGASB34)#&nbsp;</font></td>
			</tr>
        <cfelseif #Category1# is "150t">
            <tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
		<cfelseif #Category1# is "122t"><cfset TotLiabGASB34 = TotLiabGASB34 +#TotAmount#>
			<tr><td colspan="6"><center><b>LIABILITIES</b></center></td></tr>
			<tr><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b></font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b></font></td><td align="center" valign="top"><font size="-1"><b>Totals (Across All Funds)</b></font></td></tr>
			<tr><td Colspan="6"><font size="-1">CURRENT LIABILITIES</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
        <cfelseif #Category1# is "132t"><cfset TotLiabGASB34 = TotLiabGASB34 + #TotAmount#>
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
        <cfelseif #Category1# is "128t"><cfset TotLiabGASB34 = TotLiabGASB34 + #TotAmount#>
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "129t"><cfset TotLiabGASB34 = TotLiabGASB34 +#TotAmount#>
			<tr><td Colspan="6"><font size="-1">NON-CURRENT/LONG-TERM LIABILITIES</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
        <cfelseif #Category1# is "130t"><cfset TotLiabGASB34 = TotLiabGASB34 + #TotAmount#>
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "131t" and GetAFRRptPg1.AccountingMethod is not "Cash"><cfset TotLiabGASB34 = TotLiabGASB34 + #TotAmount#>
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" ---> width="10%" valign="top"><font size="-1"><b>135t</b></font></td><td width="30%" valign="top"><font size="-1"><b><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>TOTAL LIABILITIES<cfif url.PrintIt is "No"></a></cfif></b></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotLiabGASB34)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "135t"><cfset TotLiabGASB34 = TotLiabGASB34 +#TotAmount#>
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>131t</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "no"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Other Non-Current/Long Term Liabilities<cfif url.PrintIt is "no"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" ---> width="10%" valign="top"><font size="-1"><b>135t</b></font></td><td width="30%" valign="top"><font size="-1"><b><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>TOTAL LIABILITIES<cfif url.PrintIt is "No"></a></cfif></b></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotLiabGASB34)#&nbsp;</font></td>
			</tr>
        <cfelseif #Category1# is "155t">
            <tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
		<cfelseif #Category1# is "143t"><cfset TotNetAsstGASB34=TotNetAsstGASB34 +#TotAmount#>
			<tr><td colspan="6"><center><b>NET POSITION</b></center></td></tr>
			<tr><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b></font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b></font></td><td align="center" valign="top"><font size="-1"><b>Totals (Across All Funds)</b></font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif>&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
        <cfelseif #Category1# is "148t"><cfset TotNetAsstGASB34=TotNetAsstGASB34 +#TotAmount#>
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "149t"><cfset TotNetAsstGASB34=TotNetAsstGASB34 +#TotAmount#>
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1"><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotAmount)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" ---> width="10%" valign="top"><font size="-1"><b>146t</b></font></td><td width="30%" valign="top"><font size="-1"><b><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>TOTAL NET POSITION<cfif url.PrintIt is "No"></a></cfif></b></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotNetAsstGASB34)#&nbsp;</font></td>
			</tr>
			<tr><cfset TotLiabNetAsstGASB34=#iif(TotLiabGASB34 is "",0,TotLiabGASB34)# + #iif(TotNetAsstGASB34 is "",0,TotNetAsstGASB34)#><td <!--- bgcolor="silver" ---> width="10%" valign="top"><font size="-1"><b>147t</b></font></td><td width="30%" valign="top"><font size="-1"><b><cfif url.PrintIt is "No"><a href="/ProcessSearchResults.cfm?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>TOTAL LIABILITIES & NET POSITION<cfif url.PrintIt is "No"></a></cfif></b></font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(TotLiabNetAsstGASB34)#&nbsp;</font></td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
        
      <!---   </div>
		<div class="span2">&nbsp;</div>

</div>---> <!--- ending fluid row --->

        <!--- Added per SR13016 --->
         <a name="PercAmt"><br><br></a>
         
 <!---        <div class="row-fluid">

        <div class="span4">&nbsp;</div>
        <div class="span4">--->
        
        <table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box" >
        <tr><td <!--- bgcolor="silver" ---> width="75%">Assets</td><td <!--- bgcolor="silver" --->>Percentages</td></tr>
        <cfoutput query="GetAssetGASB34PerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        <tr><td <!--- bgcolor="silver" --->>Liabilities</td><td <!--- bgcolor="silver" --->>Percentages</td></tr>
        <cfoutput query="GetLiabilitiesGASB34PerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        <tr><td <!--- bgcolor="silver" --->>Net Position</td><td <!--- bgcolor="silver" --->>Percentages</td></tr>
        <cfoutput query="GetNetAssetGASB34PerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        </table>
        
     <!---     </div>
        <div class="span4">&nbsp;</div>
   </div>--->
   
<!---		<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">F1b&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Special Purpose Form&nbsp;</font></center></td></tr>
         </table>--->
<!---</body>
</html>--->
</cflock>
