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
  
<cfset url.PageType="AFR">
<cfset url.PageName="Fund Listing and Account Groups">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 8:  FUND LISTING & ACCOUNT GROUPS
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2015/ABRReport/ABRSPPg5.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=5" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>

<div><b>A. List all funds and how much was spent in FY 2015 for each fund.  Also, indicate the Fund Type (Fund Types are at the top of each column beginning on page F1).</b>  If any fund names appear below, that data is based on forms submitted last year. Please make all necessary corrections. If you have more fund names than the rows provided below, please indicate them on an attachment.</div><br>
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
            <td>#Instrument#</td>
        <td align="right">#NumberFormat(Expenditures, "$999,999,999,999,999")#</td>
        <td><cfif FundType is "GN">
                General<cfelseif FundType is "SR">
                Special Revenue<cfelseif FundType is "OT">Other<cfelse>&nbsp;</cfif></td>
        <td>#DateFormat(FYEnd, "MM")#/#DateFormat(FYEnd, "YY")#</td></tr>
    </cfoutput>
    <tr>
        <td><b>Total Expenditures</b></td>
    <td align="right">
    <cfoutput>#NumberFormat(TotExp, "$9,999,999,999,999,999")#</cfoutput></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td></tr>
</table>
</div>

<b>B. Does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> have assets or liabilities that should be recorded as a part of Account Groups?</b>  See <i><a href="https://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2015/2015chartofaccounts.pdf" target="_New">Chart of Accounts and Definitions</a></i> and the <i><a href="https://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2015/2015FAQ_HowtoAll.pdf" target="_New">How to Fill Out An AFR</a></i> documents for more information about Account Groups.  This section not applicable for the Special Purpose Abbreviated Form.<br>

___&nbsp;Yes&nbsp;&nbsp;&nbsp;&nbsp;_<u>X</u>_&nbsp;No

<!---<br>
<center>5<br>
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
        <td>#url.CFY# Abbreviated Form - 5</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
