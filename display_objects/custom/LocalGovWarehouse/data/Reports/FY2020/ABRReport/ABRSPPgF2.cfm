<!---
Author: Gary Ashbaugh
Date Created: 4-9-03

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
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpCategoryAbbrPgF2Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpCategoryAbbrPgF2RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpCategoryAbbrPgF2RptRetMsg">
	<cfprocresult name="GetExpCategoryAbbrPgF2Rpt">
</cfstoredproc>
</cfoutput>

<!--- Added per SR13016 --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ExpAbbrPerctRpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExpPerctRptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExpPerctRptRetMsg">
	<cfprocresult name="GetExpPerctRpt">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotExpenditure">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotExpenditureRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotExpenditureRetMsg">
	<cfprocresult name="GetTotExpenditure">
</cfstoredproc>
</cfoutput> 
 
<cfset url.PageType="AFR">
<cfset url.PageName="Expenditures">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<!--- Added per SR13016 --->
<h3 class="clearfix"><a href="#PercAmt">View Percentages for Expenditures</a>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2020/ABRReport/ABRSPPgF2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=F2" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>
</cfif>
</cfoutput>
</h3>

<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td colspan="5" align="center"><b>Disbursements, Expenditures and Expenses</b></td>
    </tr>
    <tr>
        <td align="center" valign="top"><b>Code</b></td>
        <td align="center" valign="top"><b>Enter all Amounts in Whole Numbers</b></td>
        <td align="center" valign="top"><b>General</b></td>
        <td align="center" valign="top"><b>Special Revenue</b></td>
        <td align="center" valign="top"><b>Other Funds</b></td>
    </tr>
		<cfoutput query="GetExpCategoryAbbrPgF2Rpt">
		<Cfset Category1=Left(DispID, 4)>
		<cfif #Category1# is "251t">
			<tr><td colspan="5" align="center">Report in Whole Numbers</td></tr>
			<tr><td><b>#DispID#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(OT)#</td>
			</tr>
		<cfelseif #Category1# is "260t">
			<tr><td><b>#DispId#</b></td><td>#DispDescription#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(OT)#</td>
			</tr>
			<tr><td><b>270t</b></td><td><b>Total Expenditures/Expense</b></td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpGN is not "",NumberFormat(GetTotExpenditure.TotExpGN,"999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpSR is not "",NumberFormat(GetTotExpenditure.TotExpSR,"999999999999999"),0))#</td>
			<td align="right">#Numberformat(IIF (GetTotExpenditure.TotExpOT is not "",NumberFormat(GetTotExpenditure.TotExpOT,"999999999999999"),0))#</td>
			</tr>
		<cfelse>
			<tr><td><b>#DispID#</b></td><td>#DispDescription#</td>
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
        <tr><th bgcolor="silver">Expenditures</th><th bgcolor="silver">Percentages</th></tr>
        <cfoutput query="GetExpPerctRpt">
		<tr><td align="left">#DispDescription#</td><td align="right">#NumberFormat(TotPerctSpent,"999.99")#%</td></tr>
		</cfoutput>
    </table>
    </div>
    </div>
    </div>
        <!---<p align="right">F2</right>
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
        <td>#url.CFY# Abbreviated Form - F2</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
