<!---
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 6-13-00
Modified By: Gary Ashbaugh
Modifications Made:  Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 8-27-01
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

LOGIC: Pulls off data from the UnitStats, UnitData, and FundsUsed table to show a unformatted view of the Page 5 of the AFR

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

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_FundsUsed">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFundsUsedRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFundsUsedRetMsg">
	<cfprocresult name="GetFundsUsed">
</cfstoredproc>
</cfoutput>

<cfset url.PageType="Summary">
<cfset url.PageName="Fund Listing and Account Groups">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<h5 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span> FUND LISTING & ACCOUNT GROUPS
     <span class="pull-right">
	 <cfoutput>
	 <cfif url.PrintIt is "no">
     <a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2012/MPFReportTot/AFRMPPg5.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=5" class="btn btn-primary nomargin">
     <span class="glyphicon glyphicon-print"></span>
     Print This Page
     </a>
     </span>
     </cfif></cfoutput>
</h5>
<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td><b>Fund Name</b></td>
        <td><b>Expenditure</b></td>
        <td><b>Fund Type</b></td>
        <td><b>FY End</b></td>
    </tr>
    <cfset TotExp = 0>
    <cfoutput query="GetFundsUsed">
        <cfset TotExp = #iif(TotExp is "", 0, TotExp)# + #iif(Expenditures is "", 0, Expenditures)#>
            <tr>
            <td><cfif url.PrintIt is "no">
            <a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No"
                target="_New"></cfif>#Instrument#<cfif url.PrintIt is "no"></a></cfif></td>
        <td align="right">#NumberFormat(Expenditures, "$999,999,999,999,999")#</td>
        <td><cfif FundType is "GN">
                General<cfelseif FundType is "SR">
                Special Revenue<cfelseif FundType is "CP">
                Capital Projects<cfelseif FundType is "DS">
                Debt Service<cfelseif FundType is "EP">
                Enterprise<cfelseif FundType is "TS">
                Internal Service<cfelseif FundType is "FD">
                Fiduciary<cfelseif FundType is "AG">
                Account Groups<cfelseif FundType is "DP">Discretely Presented Component Units<cfelse>&nbsp;</cfif></td>
        <td>#DateFormat(FYEnd, "MM")#/#DateFormat(FYEnd, "DD")#</td></tr>
    </cfoutput>
    <tr>
    <td><b>
    <cfoutput><cfif url.PrintIt is "no">
        <a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No"
            target="_New"></cfif>Total Expenditures<cfif url.PrintIt is "no"></a></cfif></cfoutput></b></td>
<td align="right">
    <cfoutput>#NumberFormat(TotExp, "$9,999,999,999,999,999")#</cfoutput></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td></tr>
</table>
</div>

<b>B. Does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> have assets or liabilities that should be recorded as a part of Account Groups?</b>  See <i><a href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2012/2012chartofaccounts.pdf" target="_New">Chart of Accounts and Definitions</a></i> and the <i><a href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2012/2012FAQ_HowtoAll.pdf" target="_New">How to Fill Out An AFR</a></i> documents for more information about Account Groups.<br>
&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.AccountGroups) is "Y"><u>X</u><cfelse>_</cfif>_&nbsp;<cfoutput><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New">Yes</a></cfoutput>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.AccountGroups) is "N"><u>X</u><cfelse>_</cfif>_&nbsp;<cfoutput><a href="/Data/Reports/FY2012/MPFReport/AFRMPPG5.cfm?Code=#url.Code#&CFY=#url.CFY#&Menu=No">No</a></cfoutput>

<!---
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">5&nbsp;</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Multi-Purpose Form&nbsp;</center></td></tr>
         </table>--->

</cflock>
