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
 
<cfset url.PageType="Summary">
<cfset url.PageName="Assets">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h4 class="clearfix"><a href="#PercAmt">View Percentages for Assets/Liabilities/Net Position</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2020/MPFReportTot/AFRMPPgF1b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=F1b" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h4>
<div class="table-responsive">
<table class="table table-bordered">
        <cfset TotAssetGASB34=0>
        <cfset TotLiabGASB34=0>
        <cfset TotNetAsstGASB34=0>
        <cfset TotLiabNetAsstGASB34=0>
		<cfoutput query="GetAssetCategoryGASB34WH">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "101t"><cfset TotAssetGASB34 = TotAssetGASB34 +#TotAmount#>
			<tr><td colspan="6"><center><b>ASSETS</b></center></td></tr>
			<tr><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td><td align="center" valign="top"><b>Totals (Across All Funds)</b></td></tr>
			<tr><td colspan="6">CURRENT ASSETS</td></tr>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "102t" or #Category1# is "115t" or #Category1# is "109t" or #Category1# is "112t">
			<cfset TotAssetGASB34 = TotAssetGASB34 +#TotAmount#>
            <tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "116t"><cfset TotAssetGASB34 = TotAssetGASB34 +#TotAmount#>
			<tr><td Colspan="6">NON-CURRENT ASSETS</td></tr>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "117t"><cfset TotAssetGASB34 = TotAssetGASB34 +#TotAmount#>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
			<tr><td valign="top"><b>120t</b></td><td valign="top"><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>TOTAL ASSETS<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotAssetGASB34)#</td>
			</tr>
        <cfelseif #Category1# is "150t">
            <tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "122t"><cfset TotLiabGASB34 = TotLiabGASB34 +#TotAmount#>
			<tr><td colspan="6"><center><b>LIABILITIES</b></center></td></tr>
			<tr><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td><td align="center" valign="top"><b>Totals (Across All Funds)</b></td></tr>
			<tr><td Colspan="6">CURRENT LIABILITIES</td></tr>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
        <cfelseif #Category1# is "132t"><cfset TotLiabGASB34 = TotLiabGASB34 + #TotAmount#>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
        <cfelseif #Category1# is "128t"><cfset TotLiabGASB34 = TotLiabGASB34 + #TotAmount#>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "129t"><cfset TotLiabGASB34 = TotLiabGASB34 +#TotAmount#>
			<tr><td Colspan="6">NON-CURRENT/LONG-TERM LIABILITIES</td></tr>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
        <cfelseif #Category1# is "130t"><cfset TotLiabGASB34 = TotLiabGASB34 + #TotAmount#>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "131t" and GetAFRRptPg1.AccountingMethod is not "Cash"><cfset TotLiabGASB34 = TotLiabGASB34 + #TotAmount#>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
			<tr><td valign="top"><b>135t</b></td><td valign="top"><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>TOTAL LIABILITIES<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotLiabGASB34)#</td>
			</tr>
		<cfelseif #Category1# is "135t"><cfset TotLiabGASB34 = TotLiabGASB34 +#TotAmount#>
			<tr><td><b>131t</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Other Non-Current/Long Term Liabilities<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
			<tr><td valign="top"><b>135t</b></td><td valign="top"><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>TOTAL LIABILITIES<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotLiabGASB34)#</td>
			</tr>
        <cfelseif #Category1# is "155t">
            <tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
		<cfelseif #Category1# is "143t"><cfset TotNetAsstGASB34=TotNetAsstGASB34 +#TotAmount#>
			<tr><td colspan="6"><center><b>NET POSITION</b></center></td></tr>
			<tr><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td><td align="center" valign="top"><b>Totals (Across All Funds)</b></td></tr>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
        <cfelseif #Category1# is "148t"><cfset TotNetAsstGASB34=TotNetAsstGASB34 +#TotAmount#>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
		<cfelseif #Category1# is "149t"><cfset TotNetAsstGASB34=TotNetAsstGASB34 +#TotAmount#>
			<tr><td><b>#AssetID#</b></td><td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>#AssetDescription#<cfif url.PrintIt is "No"></a></cfif></td>
			<td align="right">#NumberFormat(TotAmount)#</td>
			</tr>
			<tr><td valign="top"><b>146t</b></td><td valign="top"><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>TOTAL NET POSITION<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotNetAsstGASB34)#</td>
			</tr>
			<tr><cfset TotLiabNetAsstGASB34=#iif(TotLiabGASB34 is "",0,TotLiabGASB34)# + #iif(TotNetAsstGASB34 is "",0,TotNetAsstGASB34)#><td valign="top"><b>147t</b></td><td valign="top"><b><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>TOTAL LIABILITIES & NET POSITION<cfif url.PrintIt is "No"></a></cfif></b></td>
			<td align="right">#NumberFormat(TotLiabNetAsstGASB34)#</td>
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
        <cfoutput query="GetAssetGASB34PerctRpt">
		<tr><td align="left">#AssetDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
        <tr><th bgcolor="silver">Liabilities</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetLiabilitiesGASB34PerctRpt">
		<tr><td align="left">#AssetDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
        <tr><th bgcolor="silver">Net Position</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetNetAssetGASB34PerctRpt">
		<tr><td align="left">#AssetDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
     </table>
     </div>
     </div>
     </div>
<!---		 
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">F1b</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput> 
			FY <cfoutput>#url.Cfy#</cfoutput> AFR 
			Multi-Purpose Form</center></td></tr>
         </table>--->
</cflock>
