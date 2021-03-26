<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Page 2 of the AFR

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
 
<cfset url.PageType="AFR">
<cfset url.PageName="Fiscal Year End">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>

<h5 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 2:  VERIFY FISCAL YEAR END
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2019/ABRReport/ABRSPPg2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=2" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>

<cfoutput>FY END DATE:&nbsp;&nbsp;#DateFormat(GetAFRRptPg1.FYEnd,"MM/DD/YYYY")#</cfoutput>
<br>
If the fiscal year end date, listed above, is incorrect, cross out the incorrect date and provide the correct date.  Official documentation of this change must be sent to the Chicago office before the fiscal year end date is officially changed.<br>
<br>
<h5>
<span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 3:  ACCOUNTING SYSTEM AND DEBT
</h5>
<br />
<b>P1. Has your government commenced dissolution proceedings?</b>&nbsp;&nbsp;&nbsp;&nbsp;<u>&nbsp;</u><cfif UCase(GetAFRRptPg1.DissolutionProceeding) is "Y"><u>X</u><cfelse><u>&nbsp;</u></cfif><u>&nbsp;</u> Yes&nbsp;&nbsp;&nbsp;&nbsp;<u>&nbsp;</u><cfif UCase(GetAFRRptPg1.DissolutionProceeding) is "N"><u>X</u><cfelse><u>&nbsp;</u></cfif><u>&nbsp;</u> No&nbsp;&nbsp;&nbsp;&nbsp;
<b>Dissolution Filing Date:</b> <cfif trim(GetAFRRptPg1.DissolutionPrelimDate) is not ""> <u><cfoutput>#DateFormat(GetAFRRptPg1.DissolutionPrelimDate,"mm/dd/yyyy")#</cfoutput></u><cfelse><u>          </u></cfif><br>
<br>
<b>A. Which type of accounting system does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> use:</b><br>
<table class="table table-bordered">
<cfoutput query="GetAFRRptPg1">
<tr><td>_<cfif AccountingMethod is "Cash"><u>X</u><cfelse>_</cfif>_ Cash - with no assets (Cash Basis)</td><td>_<cfif AccountingMethod is "Modified Accrual"><u>X</u><cfelse>_</cfif>_ Modified Accrual/Accrual</td></tr>
<tr><td>_<cfif AccountingMethod is "Cash With Assets"><u>X</u><cfelse>_</cfif>_ Cash - with assets (Modified Cash Basis)</td><td>_<cfif AccountingMethod is "Combination"><u>X</u><cfelse>_</cfif>_ Combination (explain)</td></tr>
</cfoutput>
</table>

<cfoutput query="GetAFRRptPg1">
<b>B. Does the government have <u>Bonded</u> debt this reporting fiscal year?</b> _<cfif UCase(BondedDebt) is "Y"><u>X</u><cfelse>_</cfif>_ Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(BondedDebt) is "N"><u>X</u><cfelse>_</cfif>_ No<br>
<br>
<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If "Yes", indicate the type(s) of debt <u>and</u> complete the Statement of Indebtedness page, located on page F7.</b><br>
<table class="table table-bordered">
<tr><td>_<cfif UCase(GoBonds) is "Y"><u>X</u><cfelse>_</cfif>_ G.O. Bonds</td><td>_<cfif UCase(RevenueBonds) is "Y"><u>X</u><cfelse>_</cfif>_ Revenue Bonds</td><td>_<cfif UCase(AlternateRevenueBonds) is "Y"><u>X</u><cfelse>_</cfif>_ Alternate Revenue Bonds</td></tr>
</table>
</cfoutput>

<cfoutput query="GetAFRRptPg1">
<b>C. Does the government have debt, other than bonded debt this reporting fiscal year?</b> _<cfif UCase(Debt) is "Y"><u>X</u><cfelse>_</cfif>_ Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(Debt) is "N"><u>X</u><cfelse>_</cfif>_ No<br>
<br>
<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If "Yes", indicate the type(s) of debt <u>and</u> complete the Statement of Indebtedness page, located on page F7.</b><br>
<table class="table table-bordered">
<tr><td>_<cfif UCase(ContractualCommitments) is "Y"><u>X</u><cfelse>_</cfif>_ Contractual Commitments</td><td>_<cfif UCase(Other) is "Y"><u>X</u><cfelse>_</cfif>_ Other (Explain)&nbsp;<u>#OtherExplan#</u></td></tr>
</table>
</cfoutput>
<br>
<!---
<center>2<br>
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
        <td>#url.CFY# Abbreviated Form - 2</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
