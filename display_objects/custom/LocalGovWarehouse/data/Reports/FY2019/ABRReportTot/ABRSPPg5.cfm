<!---
Author: Gary Ashbaugh
Date Created: 4-9-03

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
<h6 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span> FUND LISTING & ACCOUNT GROUPS
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2019/ABRReportTot/ABRSPPg5.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Abbreviated Form&Page=5" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h6>

<div class="table-responsive">
<table class="table table-bordered">
    <tr>
        <td><b>Fund Name</b></td>
        <td><b>Expenditure</b></td>
        <td><b>Fund FundType</b></td>
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
                Special Revenue<cfelseif FundType is "OT">Other<cfelse>&nbsp;</cfif></td>
        <td>#left(FYEnd,2)#/#right(url.cfy,2)#</td></tr>
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

<b>B. Does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> have assets or liabilities that should be recorded as a part of Account Groups?</b>  See <i><a href="https://illinoiscomptroller.gov/ioc-pdf/LocalGovt/AFR2019/2019chartofaccounts.pdf" target="_New">Chart of Accounts and Definitions</a></i> and the <i><a href="https://illinoiscomptroller.gov/ioc-pdf/LocalGovt/AFR2019/2019FAQ_HowtoAll.pdf" target="_New">How to Fill Out An AFR</a></i> documents for more information about Account Groups.  This section not applicable for the Special Purpose Abbreviated Form.<br>

&nbsp;&nbsp;&nbsp;___&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<u>X</u>_&nbsp;No

<!---
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right">5&nbsp;</td></tr>
		<tr><td><center><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Abbreviated Form&nbsp;</center></td></tr>
         </table>--->
</cflock>
