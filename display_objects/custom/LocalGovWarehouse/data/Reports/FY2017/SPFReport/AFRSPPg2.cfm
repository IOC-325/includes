<!---
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 6-13-00
Modified By: Gary Ashbaugh
Modifications Made:  Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 8-24-01
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

Date Modified: 5-4-05
Modified By: Gary Ashbaugh
Modifications Made: Changed GASB34 question

Date Modified: 5-18-11
Modified By: Gary Ashbaugh
Modifications Made: Added the new Untility Type section

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
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2017/SPFReport/AFRSPPg2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=2" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>

<cfoutput>FY END DATE:&nbsp;&nbsp;#DateFormat(GetAFRRptPg1.FYEnd,"MM/DD/YYYY")#</cfoutput>
<br>
If the fiscal year end date, listed above, is incorrect, cross out the incorrect date and provide the correct date.  Official documentation of this change must be sent to the Chicago office before the fiscal year end date is officially changed.<br>
<br>
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 3:  GASB 34, ACCOUNTING SYSTEM, AND DEBT
</h5>
<br />
<b>P1. Has your government commenced dissolution proceedings?</b>&nbsp;&nbsp;&nbsp;&nbsp;<u>&nbsp;</u><cfif UCase(GetAFRRptPg1.DissolutionProceeding) is "Y"><u>X</u><cfelse><u>&nbsp;</u></cfif><u>&nbsp;</u> Yes&nbsp;&nbsp;&nbsp;&nbsp;<u>&nbsp;</u><cfif UCase(GetAFRRptPg1.DissolutionProceeding) is "N"><u>X</u><cfelse><u>&nbsp;</u></cfif><u>&nbsp;</u> No&nbsp;&nbsp;&nbsp;&nbsp;
<b>Dissolution Filing Date:</b> <cfif trim(GetAFRRptPg1.DissolutionPrelimDate) is not ""> <u><cfoutput>#DateFormat(GetAFRRptPg1.DissolutionPrelimDate,"mm/dd/yyyy")#</cfoutput></u><cfelse><u>          </u></cfif><br>
<br>
<b>A. Has your government implemented GASB 34 in <cfoutput>#url.CFY#</cfoutput> reporting or in previous reporting years?</b>&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.GASB34Flag) is "Y"><u>X</u><cfelse>_</cfif>_ Yes&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.GASB34Flag) is "N"><u>X</u><cfelse>_</cfif>_ No<br>
<br>
<b>B. Which type of accounting system does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> use:</b><br>

 <table class="table table-bordered">
<cfoutput query="GetAFRRptPg1">
<tr><td align="left">_<cfif AccountingMethod is "Cash"><u>X</u><cfelse>_</cfif>_ Cash - with no assets (Cash Basis)</td><td align="left">_<cfif AccountingMethod is "Modified Accrual"><u>X</u><cfelse>_</cfif>_ Modified Accrual</td></tr>
<tr><td align="left">_<cfif AccountingMethod is "Cash With Assets"><u>X</u><cfelse>_</cfif>_ Cash - with assets (Modified Cash Basis)</td><td align="left">_<cfif AccountingMethod is "Combination"><u>X</u><cfelse>_</cfif>_ Combination - explain</td></tr>
</cfoutput>
</table>

<cfoutput query="GetAFRRptPg1">
<b>C. Does the government have <u>Bonded</u> debt this reporting fiscal year?</b> _<cfif UCase(BondedDebt) is "Y"><u>X</u><cfelse>_</cfif>_ Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(BondedDebt) is "N"><u>X</u><cfelse>_</cfif>_ No<br>
<br>
<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If "Yes", indicate the type(s) of debt <u>and</u> complete the Statement of Indebtedness page, located on page F7.</b><br>

<table class="table table-bordered">
<tr><td align="left">_<cfif UCase(GoBonds) is "Y"><u>X</u><cfelse>_</cfif>_ G.O. Bonds</td><td align="left">_<cfif UCase(RevenueBonds) is "Y"><u>X</u><cfelse>_</cfif>_ Revenue Bonds</td><td align="left">_<cfif UCase(AlternateRevenueBonds) is "Y"><u>X</u><cfelse>_</cfif>_ Alternate Revenue Bonds</td></tr>
</table>
</cfoutput>

<cfoutput query="GetAFRRptPg1">
<b>D. Does the government have debt, other than bonded debt this reporting fiscal year?</b> _<cfif UCase(Debt) is "Y"><u>X</u><cfelse>_</cfif>_ Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(Debt) is "N"><u>X</u><cfelse>_</cfif>_ No<br>
<br>
<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If "Yes", indicate the type(s) of debt <u>and</u> complete the Statement of Indebtedness page, located on page F7.</b><br>
<br>
<table class="table table-bordered">
<tr><td align="left">_<cfif UCase(ContractualCommitments) is "Y"><u>X</u><cfelse>_</cfif>_ Contractual Commitments</td><td align="left">_<cfif UCase(Other) is "Y"><u>X</u><cfelse>_</cfif>_ Other (Explan)&nbsp;<u>#OtherExplan#</u></td></tr>
</table>
</cfoutput>

<cfoutput query="GetAFRRptPg1">
	<cfif GetAFRRptPg1.PublicUtilityType contains "WatSewer">
		<cfset UtilityWaterSewer = "WaterSewer">
	<cfelse>
		<cfset UtilityWaterSewer = "">
	</cfif>
	<cfif GetAFRRptPg1.PublicUtilityType contains "ElecGasTran">
		<cfset UtilityElectricGasTransit = "ElectricGasTransit">
	<cfelse>
		<cfset UtilityElectricGasTransit = "">
	</cfif>
	<cfif GetAFRRptPg1.PublicUtilityType contains "911">
		<cfset Utility911 = "911">
	<cfelse>
		<cfset Utility911 = "">
	</cfif>
	<cfif GetAFRRptPg1.PublicUtilityType contains "Othr">
		<cfset UtilityOther = "Other">
	<cfelse>
		<cfset UtilityOther = "">
	</cfif>
	<cfset UtilityOtherExplan="#GetAFRRptPg1.PublicUtilityTypeExplan#">
	
<b>E. Does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> own or operate a public utility company?&nbsp;</b>_<cfif UCase(GetAFRRptPg1.Utilities) is "Y"><u>X</u><cfelse>_</cfif>_ Yes&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.Utilities) is "N"><u>X</u><cfelse>_</cfif>_ No<br>
<br>
&nbsp;&nbsp;&nbsp;<b>If Yes, indicate the type of public utility and enter the expenditures in Code 271.</b>
<br><br>
_<cfif ucase(UtilityWaterSewer) is "WaterSewer"><u>X</u><cfelse><u>_</u></cfif>_&nbsp;water/sewer&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;_<cfif ucase(UtilityElectricGasTransit) is "ElectricGasTransit"><u>X</u><cfelse><u>_</u></cfif>_&nbsp;electric/gas/transit&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;_<cfif ucase(Utility911) is "911"><u>X</u><cfelse><u>_</u></cfif>_&nbsp;911 telephone/telecommunications&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;_<cfif ucase(UtilityOther) is "Other"><u>X</u><cfelse><u>_</u></cfif>_&nbsp;other&nbsp;&nbsp;&nbsp;<cfif trim(UtilityOtherExplan) is not""><u>#UtilityOtherExplan#</u></cfif>
</cfoutput>

<!---<br>
<center>2<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
Special Purpose Form</center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "SP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
	<cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Special Purpose Form - 2</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
