 

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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AssetCategoryGASB34Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAssetCategoryGASB34RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAssetCategoryGASB34RptRetMsg">
	<cfprocresult name="GetAssetCategoryGASB34Rpt">
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
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotAssetGASB34">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotAssetGASB34RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotAssetGASB34RetMsg">
	<cfprocresult name="GetTotAssetGASB34">
</cfstoredproc>
</cfoutput>
 
  <!--- Calculate total Liabilities --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotLiabGASB34">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotLiabGASB34RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotLiabGASB34RetMsg">
	<cfprocresult name="GetTotLiabGASB34">
</cfstoredproc>
</cfoutput>
 
   <!--- Calculate total Equity --->
 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotNetAsstGASB34">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotNetAsstGASB34RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotNetAsstGASB34RetMsg">
	<cfprocresult name="GetTotNetAsstGASB34">
</cfstoredproc>
</cfoutput>
 
    <!--- Calculate total Liability & net Assets --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotLiabNetAsstGASB34">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotLiabNetAsstGASB34RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotLiabNetAsstGASB34RetMsg">
	<cfprocresult name="GetTotLiabNetAsstGASB34">
</cfstoredproc>
</cfoutput>
 
<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Assets">

<!--- Adding the "jumbotron" class around these two included pages --->
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>

<div class="row-fluid">
       
        <div class="span2"></div>
        <div class="span8">



<!--- Added per SR13016 --->
<!---*<table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="100%">--->
<!---*<table class="table">
<Tr>
	<td<!---* width="90%"--->><img src="/images/tri.gif"><a href="#PercAmt">View Percentages for Assets/Liabilities/Net Assets</a></td>
    <td>&nbsp;</td>
    <td align="right"><cfif url.PrintIt is "no"><cfoutput><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2019/MPFReport/AFRMPPgF1b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F1b"><img src="images/printer.jpg" alt="Print Page" width="20" height="20" ></a></cfoutput></cfif>
	</td>
</tr>
</table>--->

<h3><a href="#PercAmt">View Percentages for Assets/Liabilities/Net Position</a> 
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2019/MPFReport/AFRMPPgF1b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F1b" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h3>

		<table  bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
		<cfoutput query="GetAssetCategoryGASB34Rpt">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "101t">
			<tr><td colspan="6"><center><b>ASSETS</b></center></td></tr>
			<tr><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b></font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b></font></td><td align="center" valign="top"><font size="-1"><b>Governmental Actvity</b></font></td><td align="center" valign="top"><font size="-1"><b>Business-Like Activity</b></font></td><td align="center" valign="top"><font size="-1"><b>Fiduciary</b></font></td><td align="center" valign="top"><font size="-1"><b>Discretely<br>Presented<br>Component<br>Units</b></font></td></tr>
			<tr><td Colspan=6><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CURRENT ASSETS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b></font></td><td><font size="-1">#AssetDescription#</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GA)#</font></td><td align="right"><font size="-1">#NumberFormat(BA)#</font></td><td align="right"><font size="-1">#NumberFormat(FD)#</font></td><td align="right"><font size="-1">#NumberFormat(DP)#</font></td>
			</tr>
		<cfelseif #Category1# is "102t" or #Category1# is "115t" or #Category1# is "109t" or #Category1# is "112t" or #Category1# is "132t" or #Category1# is "128t" or #Category1# is "130t" or #Category1# is "148t">
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1">#AssetDescription#</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "116t">
			<tr><td Colspan="6"><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NON-CURRENT ASSETS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "117t">
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1">#AssetDescription#</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" ---> width="10%" valign="top"><font size="-1"><b>120t</b></font></td><td width="30%" valign="top"><font size="-1"><b>TOTAL ASSETS</b></font>&nbsp;&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotAssetGASB34.TotAsstGA is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotAssetGASB34.TotAsstGA,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GEtTotAssetGASB34.TotAsstBA is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotAssetGASB34.TotAsstBA,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GEtTotAssetGASB34.TotAsstFD is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotAssetGASB34.TotAsstFD,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotAssetGASB34.TotAsstDP is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotAssetGASB34.TotAsstDP,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			</tr>
        <cfelseif #Category1# is "150t">
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1">#AssetDescription#</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "122t">
			<tr><td colspan="6"><center><b>LIABILITIES</b></center></td></tr>
			<tr><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b></font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b></font></td><td align="center" valign="top"><font size="-1"><b>Governmental Actvity</b></font></td><td align="center" valign="top"><font size="-1"><b>Business-Like Activity</b></font></td><td align="center" valign="top"><font size="-1"><b>Fiduciary</b></font></td><td align="center" valign="top"><font size="-1"><b>Discretely<br>Presented<br>Component<br>Units</b></font></td></tr>
			<tr><td Colspan="6"><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CURRENT LIABILITIES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "129t">
			<tr><td Colspan="6"><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NON-CURRENT/LONG-TERM LIABILITIES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers</font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "131t" and GetAFRRptPg1.AccountingMethod is not "Cash">
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1">#AssetDescription#</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" ---> width="10%" valign="top"><font size="-1"><b>135t</b></font></td><td width="30%" valign="top"><font size="-1"><b>TOTAL LIABILITIES</b></font>&nbsp;&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotLiabGASB34.TotLiabGA is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotLiabGASB34.TotLiabGA,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotLiabGASB34.TotLiabBA is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotLiabGASB34.TotLiabBA,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotLiabGASB34.TotLiabFD is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotLiabGASB34.TotLiabFD,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotLiabGASB34.TotLiabDP is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotLiabGASB34.TotLiabDP,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			</tr>
		<cfelseif #Category1# is "135t">
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>131t</b></font></td><td width="30%"><font size="-1">Other Non-Current/Long Term Liabilities</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(0)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(0)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(0)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(0)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" ---> width="10%" valign="top"><font size="-1"><b>135t</b></font></td><td width="30%" valign="top"><font size="-1"><b>TOTAL LIABILITIES</b></font>&nbsp;&nbsp;</td>
			<td align="right" width="15%" valign="top"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%" valign="top"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%" valign="top"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%" valign="top"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
        <cfelseif #Category1# is "155t">
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1">#AssetDescription#</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "143t">
			<tr><td colspan="6"><center><b>NET POSITION</b></center></td></tr>
			<tr><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b></font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b></font></td><td align="center" valign="top"><font size="-1"><b>Governmental Actvity</b></font></td><td align="center" valign="top"><font size="-1"><b>Business-Like Activity</b></font></td><td align="center" valign="top"><font size="-1"><b>Fiduciary</b></font></td><td align="center" valign="top"><font size="-1"><b>Discretely<br>Presented<br>Component<br>Units</b></font></td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#AssetID#</b>&nbsp;</font></td><td><font size="-1">#AssetDescription#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "149t">
			<tr><td <!--- bgcolor="silver" ---> width="10%"><font size="-1"><b>#AssetID#</b></font></td><td width="30%"><font size="-1">#AssetDescription#</font>&nbsp;&nbsp;</td>
			<td align="right" width="15%"><font size="-1">#NumberFormat(GA)#&nbsp;</font></td><td align="right"  width="15%"><font size="-1">#NumberFormat(BA)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right" width="15%"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" ---> width="10%" valign="top"><font size="-1"><b>146t</b></font></td><td width="30%" valign="top"><font size="-1"><b>TOTAL NET POSITION</b></font>&nbsp;&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotNetAsstGASB34.TotNetAsstGA is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GEtTotNetAsstGASB34.TotNetAsstGA,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotNetAsstGASB34.TotNetAsstBA is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotNetAsstGASB34.TotNetAsstBA,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotNetAsstGASB34.TotNetAsstFD is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotNetAsstGASB34.TotNetAsstFD,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotNetAsstGASB34.TotNetAsstDP is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GEtTotNetAsstGASB34.TotNetAsstDP,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			</tr>
			<tr><td <!--- bgcolor="silver" ---> width="10%" valign="top"><font size="-1"><b>147t</b></font></td><td width="30%" valign="top"><font size="-1"><b>TOTAL LIABILITIES & NET POSITION</b></font>&nbsp;&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotLiabNetAsstGASB34.TotLiabNetAsstGA is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotLiabNetAsstGASB34.TotLiabNetAsstGA,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotLiabNetAsstGASB34.TotLiabNetAsstBA is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotLiabNetAsstGASB34.TotLiabNetAsstBA,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotLiabNetAsstGASB34.TotLiabNetAsstFD is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GEtTotLiabNetAsstGASB34.TotLiabNetAsstFD,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
			<td align="right" width="15%" valign="top"><p><cfif GetTotLiabNetAsstGASB34.TotLiabNetAsstDP is ""><font size="-1">0</font><cfelse><font size="-1">#NumberFormat(GetTotLiabNetAsstGASB34.TotLiabNetAsstDP,"99,999,999,999,999")#</font></cfif></p>&nbsp;</td>
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
        <table <!---*class="table"---> bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
        <!--- the THs below used to be td <!--- bgcolor="silver" --->--->
        <tr><th bgcolor="silver" >Assets</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetAssetGASB34PerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        <tr><th bgcolor="silver">Liabilities</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetLiabilitiesGASB34PerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        <tr><th bgcolor="silver">Net Position</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetNetAssetGASB34PerctRpt">
		<tr><td align="left"><font size="-1">#AssetDescription#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TotPerctSpent,"999.99")#%&nbsp;</font></td></tr>
		</cfoutput>
        </table>
		
       </div>
        <div class="span4">&nbsp;</div>
   </div>
        
        <br>
        
        <!---<p align="right"><font size="-1">F1b&nbsp;</font></right>
		<br><center>
<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Multi-Purpose Form&nbsp;</font></center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "MPGASB34">
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
        <td width="20%">#url.CFY# Multi-Purpose Form - F1b</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>


