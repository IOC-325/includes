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
 
<cfset url.PageType="AFR">
<cfset url.PageName="Assets">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>

<!--- Added per SR13016 --->
<h3 class="clearfix"><a href="#PercAmt">View Percentages for Assets/Liabilities/Net Assets</a>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2011/SPFReport/AFRSPPgF1b.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=F1b" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<div class="table-responsive">
<table class="table table-bordered">
		<cfoutput query="GetAssetCategoryGASB34Rpt">
		<Cfset Category1=Left(AssetID, 4)>
		<cfif #Category1# is "101t">
			<tr><td colspan="6"><center><b>ASSETS</b></center></td></tr>
			<tr><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td><td align="center" valign="top"> <b>Governmental Actvity</b></td><td align="center" valign="top"><b>Business-Like Activity</b></td><td align="center" valign="top"><b>Fiduciary</b></td><td align="center" valign="top"><b>Discretely Presented Component Units</b></td></tr>
			<tr><td colspan="2">CURRENT ASSETS</td>
                <td colspan="4">Report in Whole Numbers</td></tr>
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GA)#</td><td align="right">#NumberFormat(BA)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)# </td>
			</tr>
		<cfelseif #Category1# is "102t" or #Category1# is "115t" or #Category1# is "109t" or #Category1# is "112t" or #Category1# is "132t" or #Category1# is "128t" or #Category1# is "130t" or #Category1# is "148t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GA)#</td><td align="right">#NumberFormat(BA)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "116t">
			<tr><td colspan="2">NON-CURRENT ASSETS</td>
                <td colspan="4">Report in Whole Numbers</td></tr>
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GA)#</td><td align="right">#NumberFormat(BA)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "117t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GA)#</td><td align="right">#NumberFormat(BA)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
			<tr><td valign="top"><b>120t</b></td><td valign="top"><b>TOTAL ASSETS</b></td>
			<td align="right" valign="top"><p><cfif GetTotAssetGASB34.TotAsstGA is "">0<cfelse>#NumberFormat(GetTotAssetGASB34.TotAsstGA,"99,999,999,999,999")#</cfif></p> </td>
			<td align="right" valign="top"><p><cfif GEtTotAssetGASB34.TotAsstBA is "">0<cfelse>#NumberFormat(GetTotAssetGASB34.TotAsstBA,"99,999,999,999,999")#</cfif></p> </td>
			<td align="right" valign="top"><p><cfif GEtTotAssetGASB34.TotAsstFD is "">0<cfelse>#NumberFormat(GetTotAssetGASB34.TotAsstFD,"99,999,999,999,999")#</cfif></p> </td>
			<td align="right" valign="top"><p><cfif GetTotAssetGASB34.TotAsstDP is "">0<cfelse>#NumberFormat(GetTotAssetGASB34.TotAsstDP,"99,999,999,999,999")#</cfif></p> </td>
			</tr>
		<cfelseif #Category1# is "122t">
			<tr><td colspan="6"><center><b>LIABILITIES</b></center></td></tr>
			<tr><td align="center" valign="top"><b>Code</b></td><td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b> </td><td align="center" valign="top"><b>Governmental Actvity</b></td><td align="center" valign="top"><b>Business-Like Activity</b></td><td align="center" valign="top"><b>Fiduciary</b></td><td align="center" valign="top"><b>Discretely Presented Component Units</b></td></tr>
			<tr><td Colspan="2">CURRENT LIABILITIES</td>
                <td colspan="4">Report in Whole Numbers</td></tr>
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GA)#</td><td align="right">#NumberFormat(BA)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "129t">
			<tr><td Colspan="2">NON-CURRENT/LONG-TERM LIABILITIES</td>
                <td colspan="4">Report in Whole Numbers</td></tr>
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GA)#</td><td align="right">#NumberFormat(BA)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#  </td>
			</tr>
		<cfelseif #Category1# is "131t" and GetAFRRptPg1.AccountingMethod is not "Cash">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GA)#</td><td align="right">#NumberFormat(BA)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#  </td>
			</tr>
			<tr><td valign="top"><b>135t</b></td><td valign="top"><b>TOTAL LIABILITIES</b></td>
			<td align="right" valign="top"><p><cfif GetTotLiabGASB34.TotLiabGA is ""> 0 <cfelse> #NumberFormat(GetTotLiabGASB34.TotLiabGA,"99,999,999,999,999")# </cfif></p> </td>
			<td align="right" valign="top"><p><cfif GetTotLiabGASB34.TotLiabBA is ""> 0 <cfelse> #NumberFormat(GetTotLiabGASB34.TotLiabBA,"99,999,999,999,999")# </cfif></p> </td>
			<td align="right" valign="top"><p><cfif GetTotLiabGASB34.TotLiabFD is ""> 0 <cfelse> #NumberFormat(GetTotLiabGASB34.TotLiabFD,"99,999,999,999,999")# </cfif></p> </td>
			<td align="right" valign="top"><p><cfif GetTotLiabGASB34.TotLiabDP is ""> 0 <cfelse> #NumberFormat(GetTotLiabGASB34.TotLiabDP,"99,999,999,999,999")# </cfif></p> </td>
			</tr>
		<cfelseif #Category1# is "135t">
			<tr><td><b>131t</b></td><td>Other Non-Current/Long Term Liabilities</td>
			<td align="right">#NumberFormat(0)#</td><td align="right">#NumberFormat(0)#</td><td align="right" >#NumberFormat(0)#</td><td align="right">#NumberFormat(0)#  </td>
			</tr>
			<tr><td valign="top"><b>135t</b></td><td valign="top"><b>TOTAL LIABILITIES</b></td>
			<td align="right" valign="top">#NumberFormat(GA)#</td><td align="right" valign="top">#NumberFormat(BA)#</td><td align="right" valign="top">#NumberFormat(FD)#  </td><td align="right"  valign="top">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "143t">
			<tr><td colspan="6"><center><b>NET ASSETS</b></center></td></tr>
			<tr><td  align="center" valign="top"><b>Code</b></td><td align="center" valign="top"> <b>Enter all Amounts in Whole Numbers</b></td><td align="center" valign="top"> <b>Governmental Actvity</b></td><td align="center" valign="top"> <b>Business-Like Activity</b> </td><td align="center" valign="top"> <b>Fiduciary</b> </td><td align="center" valign="top"><b>Discretely Presented Component Units</b> </td></tr>
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right" > #NumberFormat(GA)#</td><td align="right">#NumberFormat(BA)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "149t">
			<tr><td><b>#AssetID#</b></td><td>#AssetDescription#</td>
			<td align="right">#NumberFormat(GA)# </td><td align="right">#NumberFormat(BA)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
			<tr><td valign="top"><b>146t</b></td><td valign="top"><b>TOTAL NET ASSETS</b> </td>
			<td align="right" valign="top"><p><cfif GetTotNetAsstGASB34.TotNetAsstGA is ""> 0 <cfelse> #NumberFormat(GEtTotNetAsstGASB34.TotNetAsstGA,"99,999,999,999,999")# </cfif></p> </td>
			<td align="right" valign="top"><p><cfif GetTotNetAsstGASB34.TotNetAsstBA is ""> 0 <cfelse> #NumberFormat(GetTotNetAsstGASB34.TotNetAsstBA,"99,999,999,999,999")# </cfif></p> </td>
			<td align="right" valign="top"><p><cfif GetTotNetAsstGASB34.TotNetAsstFD is ""> 0 <cfelse> #NumberFormat(GetTotNetAsstGASB34.TotNetAsstFD,"99,999,999,999,999")# </cfif></p> </td>
			<td align="right" valign="top"><p><cfif GetTotNetAsstGASB34.TotNetAsstDP is ""> 0 <cfelse> #NumberFormat(GEtTotNetAsstGASB34.TotNetAsstDP,"99,999,999,999,999")# </cfif></p> </td>
			</tr>
			<tr><td  valign="top"> <b>147t</b> </td><td > <b>TOTAL LIABILITIES & NET ASSETS</b>   </td>
			<td align="right"  valign="top"><p><cfif GetTotLiabNetAsstGASB34.TotLiabNetAsstGA is ""> 0 <cfelse> #NumberFormat(GetTotLiabNetAsstGASB34.TotLiabNetAsstGA,"99,999,999,999,999")# </cfif></p> </td>
			<td align="right"  valign="top"><p><cfif GetTotLiabNetAsstGASB34.TotLiabNetAsstBA is ""> 0 <cfelse> #NumberFormat(GetTotLiabNetAsstGASB34.TotLiabNetAsstBA,"99,999,999,999,999")# </cfif></p> </td>
			<td align="right"  valign="top"><p><cfif GetTotLiabNetAsstGASB34.TotLiabNetAsstFD is ""> 0 <cfelse> #NumberFormat(GEtTotLiabNetAsstGASB34.TotLiabNetAsstFD,"99,999,999,999,999")# </cfif></p> </td>
			<td align="right"  valign="top"><p><cfif GetTotLiabNetAsstGASB34.TotLiabNetAsstDP is ""> 0 <cfelse> #NumberFormat(GetTotLiabNetAsstGASB34.TotLiabNetAsstDP,"99,999,999,999,999")# </cfif></p> </td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
        </div>

        <!--- Added per SR13016 --->
         <a name="PercAmt"> </a>
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
        <tr><th bgcolor="silver">Net Assets</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetNetAssetGASB34PerctRpt">
		<tr><td align="left">#AssetDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
     </table>
     </div>
     </div>
     </div>
		 
        <!---<p align="right"> F1b  </right>
		 <center>
 <cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput> 
FY <cfoutput>#url.Cfy#</cfoutput> AFR 
Multi-Purpose Form  </center>  --->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "SP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm">  --->
	</cfif>
	<cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Special Purpose Form - F1b</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
