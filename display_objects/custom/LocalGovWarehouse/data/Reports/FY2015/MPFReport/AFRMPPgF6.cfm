<!---
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 3-13-00
Date Modified: 4-19-00
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

LOGIC: Pulls off data from the FundBalance table to show a unformatted view of the Page F4 of the AFR

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
 
<!--- pulls off fields for Fund Balance --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_FundBalanceCategoryInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFundBalanceCategoryInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFundBalanceCategoryInfoRetMsg">
	<cfprocresult name="GetFundBalanceCategoryInfo">
</cfstoredproc>
</cfoutput>

<!--- Calculate CYE Fund Balance --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotFundBal301Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalGN" variable="TotFundBal301GN">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalSR" variable="TotFundBal301SR">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalCP" variable="TotFundBal301CP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDS" variable="TotFundBal301DS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalEP" variable="TotFundBal301EP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalTS" variable="TotFundBal301TS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalFD" variable="TotFundBal301FD">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDP" variable="TotFundBal301DP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalOT" variable="TotFundBal301OT">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotFundBal301RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotFundBal301RptRetMsg">
	<cfprocresult name="GetTotFundBal301Rpt">
</cfstoredproc>
</cfoutput>
 
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotFundBal306Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalGN" variable="TotFundBal306GN">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalSR" variable="TotFundBal306SR">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalCP" variable="TotFundBal306CP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDS" variable="TotFundBal306DS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalEP" variable="TotFundBal306EP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalTS" variable="TotFundBal306TS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalFD" variable="TotFundBal306FD">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDP" variable="TotFundBal306DP">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotFundBal306RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotFundBal306RptRetMsg">
	<cfprocresult name="GetTotFundBal306Rpt">
</cfstoredproc>
</cfoutput>

<cfset url.PageType="AFR">
<cfset url.PageName="Fund Balance">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5 class="clearfix">
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2015/MPFReport/AFRMPPgF6.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F6" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>

<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td colspan="10" align="center"><b>Fund Balances and Other Financing Sources (Uses)</b></td>
    </tr>
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
        <td align="center" valign="top"><b>Discretely Presented Component Units</b></td>
    </tr>
		<cfoutput query="GetFundBalanceCategoryInfo">
		<Cfset Category1=Left(Id, 4)>
		<cfif #Category1# is "302t">	
			<tr><td colspan="10" align="center">Report in Whole Numbers</td></tr>
			<tr>
			<td><b>301t</b></td><td><b>Excess of receipts/revenues over (under) expenditures/expenses (240t-270t)</b></td>
			<td align="right">#Numberformat(iif(TotFundBal301GN is not "",NumberFormat(TotFundBal301GN,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(TotFundBal301SR is not "",NumberFormat(TotFundBal301SR,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(TotFundBal301CP is not "",NumberFormat(TotFundBal301CP,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(TotFundBal301DS is not "",NumberFormat(TotFundBal301DS,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(TotFundBal301EP is not "",NumberFormat(TotFundBal301EP,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(TotFundBal301TS is not "",NumberFormat(TotFundBal301TS,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(TotFundBal301FD is not "",NumberFormat(TotFundBal301FD,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(TotFundBal301DP is not "",NumberFormat(TotFundBal301DP,"9999999999999999"),0))#</td>
			</tr>
			<tr><td><b>#ID#</b></td><td>#Description#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "308t">
			<cfset FndBal308GN = Iif(GN is "",0,NumberFormat(GN,"9999999999999999"))>
			<cfset FndBal308SR = Iif(SR is "",0,NumberFormat(SR,"9999999999999999"))>
			<cfset FndBal308CP = Iif(CP is "",0,NumberFormat(CP,"9999999999999999"))>
			<cfset FndBal308DS = Iif(DS is "",0,NumberFormat(DS,"9999999999999999"))>
			<cfset FndBal308EP = Iif(EP is "",0,NumberFormat(EP,"9999999999999999"))>
			<cfset FndBal308TS = Iif(TS is "",0,NumberFormat(TS,"9999999999999999"))>
			<cfset FndBal308FD = Iif(FD is "",0,NumberFormat(FD,"9999999999999999"))>
			<cfset FndBal308DP = Iif(DP is "",0,NumberFormat(DP,"9999999999999999"))>
			<tr><td><b>#ID#</b></td><td>#Description#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
			<tr><td><b>310t</b></td><td><b>Current Year Ending Fund Balance (306 + 307 + 308)</b></td>
			<cfset FndBalGN = iif(FndBal306GN is not "",NumberFormat(FndBal306GN,"9999999999999999"),0) + NumberFormat(FndBal307GN,"9999999999999999") + NumberFormat(FndBal308GN,"9999999999999999")>
			<cfset FndBalSR = iif(FndBal306SR is not "",NumberFormat(FndBal306SR,"9999999999999999"),0) + NumberFormat(FndBal307SR,"9999999999999999") + NumberFormat(FndBal308SR,"9999999999999999")>
			<cfset FndBalCP = iif(FndBal306CP is not "",NumberFormat(FndBal306CP,"9999999999999999"),0) + NumberFormat(FndBal307CP,"9999999999999999") + NumberFormat(FndBal308CP,"9999999999999999")>
			<cfset FndBalDS = iif(FndBal306DS is not "",NumberFormat(FndBal306DS,"9999999999999999"),0) + NumberFormat(FndBal307DS,"9999999999999999") + NumberFormat(FndBal308DS,"9999999999999999")>
			<cfset FndBalEP = iif(FndBal306EP is not "",NumberFormat(FndBal306EP,"9999999999999999"),0) + NumberFormat(FndBal307EP,"9999999999999999") + NumberFormat(FndBal308EP,"9999999999999999")>
			<cfset FndBalTS = iif(FndBal306TS is not "",NumberFormat(FndBal306TS,"9999999999999999"),0) + NumberFormat(FndBal307TS,"9999999999999999") + NumberFormat(FndBal308TS,"9999999999999999")>
			<cfset FndBalFD = iif(FndBal306FD is not "",NumberFormat(FndBal306FD,"9999999999999999"),0) + NumberFormat(FndBal307FD,"9999999999999999") + NumberFormat(FndBal308FD,"9999999999999999")>
			<cfset FndBalDP = iif(FndBal306DP is not "",NumberFormat(FndBal306DP,"9999999999999999"),0) + NumberFormat(FndBal307DP,"9999999999999999") + NumberFormat(FndBal308DP,"9999999999999999")>
			<td align="right">#NumberFormat(FndBalGN)#</td><td align="right">#NumberFormat(FndBalSR)#</td><td align="right">#NumberFormat(FndBalCP)#</td><td align="right">#NumberFormat(FndBalDS)#</td><td align="right">#NumberFormat(FndBalEP)#</td><td align="right">#NumberFormat(FndBalTS)#</td><td align="right">#NumberFormat(FndBalFD)#</td><td align="right">#NumberFormat(FndBalDP)#</td>
			</tr>
		<cfelseif #Category1# is "307t">
			<cfset FndBal307GN = Iif(GN is "",0,NumberFormat(GN,"9999999999999999"))>
			<cfset FndBal307SR = Iif(SR is "",0,NumberFormat(SR,"9999999999999999"))>
			<cfset FndBal307CP = Iif(CP is "",0,NumberFormat(CP,"9999999999999999"))>
			<cfset FndBal307DS = Iif(DS is "",0,NumberFormat(DS,"9999999999999999"))>
			<cfset FndBal307EP = Iif(EP is "",0,NumberFormat(EP,"9999999999999999"))>
			<cfset FndBal307TS = Iif(TS is "",0,NumberFormat(TS,"9999999999999999"))>
			<cfset FndBal307FD = Iif(FD is "",0,NumberFormat(FD,"9999999999999999"))>
			<cfset FndBal307DP = Iif(DP is "",0,NumberFormat(DP,"9999999999999999"))>
			<tr><td><b>#ID#</b></td><td>#Description#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		<cfelseif #Category1# is "305t">
			<tr><td><b>#ID#</b></td><td>#Description#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
			<cfset FndBal306GN = #NumberFormat(TotFundBal306GN,"9999999999999999")#>
			<cfset FndBal306SR = #NumberFormat(TotFundBal306SR,"9999999999999999")#>
			<cfset FndBal306CP = #NumberFormat(TotFundBal306CP,"9999999999999999")#>
			<cfset FndBal306DS = #NumberFormat(TotFundBal306DS,"9999999999999999")#>
			<cfset FndBal306EP = #NumberFormat(TotFundBal306EP,"9999999999999999")#>
			<cfset FndBal306TS = #NumberFormat(TotFundBal306TS,"9999999999999999")#>
			<cfset FndBal306FD = #NumberFormat(TotFundBal306FD,"9999999999999999")#>
			<cfset FndBal306DP = #NumberFormat(TotFundBal306DP,"9999999999999999")#>
			<tr>
			<td><b>306t</b></td><td><b>Net increase(decrease) in fund balance (301t + 302t - 303t + 304t + 305t)</b></td>
			<td align="right">#Numberformat(iif(FndBal306GN is not "",NumberFormat(FndBal306GN,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(FndBal306SR is not "",NumberFormat(FndBal306SR,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(FndBal306CP is not "",NumberFormat(FndBal306CP,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(FndBal306DS is not "",NumberFormat(FndBal306DS,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(FndBal306EP is not "",NumberFormat(FndBal306EP,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(FndBal306TS is not "",NumberFormat(FndBal306TS,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(FndBal306FD is not "",NumberFormat(FndBal306FD,"9999999999999999"),0))#</td>
			<td align="right">#Numberformat(iif(FndBal306DP is not "",NumberFormat(FndBal306DP,"9999999999999999"),0))#</td>
			</tr>
		<cfelse>
			<tr><td><b>#ID#</b></td><td>#Description#</td>
			<td align="right">#NumberFormat(GN)#</td><td align="right">#NumberFormat(SR)#</td><td align="right">#NumberFormat(CP)#</td><td align="right">#NumberFormat(DS)#</td><td align="right">#NumberFormat(EP)#</td><td align="right">#NumberFormat(TS)#</td><td align="right">#NumberFormat(FD)#</td><td align="right">#NumberFormat(DP)#</td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
		</div>
        <!---<p align="right">F6</right>
		 <center>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput> 
FY <cfoutput>#url.CFY#</cfoutput> AFR 
Multi-Purpose Form</center>  --->
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
        <td>#url.CFY# Multi-Purpose Form - F6</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
