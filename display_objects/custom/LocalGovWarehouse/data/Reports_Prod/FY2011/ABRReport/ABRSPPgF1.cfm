<!---
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the Revenues table to show a unformatted view of the Page F1 of the AFR

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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevCategoryAbbrPgF1Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevCategoryAbbrPgF1RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevCategoryAbbrPgF1RptRetMsg">
	<cfprocresult name="GetRevCategoryAbbrPgF1Rpt">
</cfstoredproc>
</cfoutput>

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_RevAbbrPgF1PercRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetRevAbbrPgF1PercRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetRevAbbrPgF1PercRptRetMsg">
	<cfprocresult name="GetRevAbbrPgF1PercRpt">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotRevenue">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotRevenueRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotRevenueRptRetMsg">
	<cfprocresult name="GetTotRevenue">
</cfstoredproc>
</cfoutput> 

<cfset url.PageType="AFR">
<cfset url.PageName="Revenues">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<!--- Added per SR13016 --->

<h3 class="clearfix"><a href="#PercAmt">View Percentages for Revenues</a>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2011/ABRReport/ABRSPPgF1.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=F1" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>
</cfif>
</cfoutput>
</h3>

<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td colspan="5" align="center"><b>Revenues and Receipts</b></td>
    </tr>
		<tr><td align="center" valign="top"><b>Code</b></td>
<td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td>
<td align="center" valign="top"><b>General</b></td>
<td align="center" valign="top"><b>Special Revenue</b></td>
<td align="center" valign="top"><b>Other Funds</b></td>
</tr>
		<cfoutput query="GetRevCategoryAbbrPgF1Rpt">
		<Cfset Category1=Left(RevenueID, 4)>
		<cfif #Category1# is "201t">
			<tr><td colspan="2"><b>Local Taxes</b></td>
                <td colspan="3">Report in Whole Numbers</td></tr>
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(OT)#</td>
			</tr>
		<cfelseif #Category1# is "214t">
			<tr><td colspan="5"><b>Intergovernmental Receipts & State or Federal Grants</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(OT)#</td>
			</tr>
		<cfelseif #Category1# is "234t">
			<tr><td colspan="5"><b>Other Sources</b></td></tr>
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(OT)#</td>
			</tr>
		<cfelseif #Category1# is "236t">
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(OT)#</td>
			</tr>
			<tr><td><b>240t</b></td><td><b>Total Receipts and Revenue</b></td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevGN is not "",NumberFormat(GetTotRevenue.TotRevGN,"999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevSR is not "",NumberFormat(GetTotRevenue.TotRevSR,"999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotRevenue.TotRevOT is not "",NumberFormat(GetTotRevenue.TotRevOT,"999999999999999"),0))#</td>
			</tr>
		<cfelse>
			<tr><td><b>#RevenueID#</b></td><td>#RevenueDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(OT)#</td>
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
        <cfoutput query="GetRevAbbrPgF1PercRpt">
		<tr><td align="left">#RevenueDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
    </table>
    </div>
    </div>
    </div>

        <!---<p align="right">F1</right>
		<br><center>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Abbreviated Form</center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "Abbrev">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
     <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Abbreviated Form - F1</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
