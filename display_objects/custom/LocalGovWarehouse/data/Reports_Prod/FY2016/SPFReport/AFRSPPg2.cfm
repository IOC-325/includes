<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
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
 
<!---<html>
<head>
	<title>AFR - Page 2</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Fiscal Year End">
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span><font size="-1" color="black"> STEP 2:  VERIFY FISCAL YEAR END</font>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/SPFReport/AFRSPPg2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=2" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>
<table class="table-bordered" <!---bgcolor="white" cellspacing="0" cellpadding="2" border="1" bordercolor="black" width="25%"--->>
<tr><td>
<font size="-1"><cfoutput>FY END DATE:&nbsp;&nbsp;#DateFormat(GetAFRRptPg1.FYEnd,"MM/DD/YYYY")#</cfoutput></font><br>
</td></tr>
</table>
<br>
<font size="-1">If the fiscal year end date, listed above, is incorrect, cross out the incorrect date and provide the correct date.  Official documentation of this change must be sent to the Chicago office before the fiscal year end date is officially changed.</font><br>
<br>
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span><font size="-1" color="black"> STEP 3:  GASB 34, ACCOUNTING SYSTEM, AND DEBT</font>
</h5>
<br>
<font size="-1"><b>A. Has your government imlemented GASB 34 in <cfoutput>#url.CFY#</cfoutput> reporting or in previous reporting years?</b></font>&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.GASB34Flag) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ Yes</font>&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.GASB34Flag) is "N"><u><font size="-1">X</font></u><cfelse>_</cfif>_ No</font><br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-1">If yes:</font>
	<ul><li><font size="-1">Governments who have implemented GASB 34 and are using "other basis of accounting" (OCBOA) such as "Cash Basis" and "Modified Cash Basis" as their accounting system will now be able to select these types as their accounting system.</font></li><br>
	<li><font size="-1">Please fill out the Alternative Assets & Liabilities page, located on page F1(b)</font></li>
</ul>
<font size="-1"><b>B. Which type of accounting system does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> use:</font></b><br>
<br>
<table <!---bgcolor="white" cellspacing="0" cellpadding="2" border="0" width="100%"--->>
<cfoutput query="GetAFRRptPg1">
<tr><td width="50%" align="left">_<cfif AccountingMethod is "Cash"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Cash - with no assets (Cash Basis)</font></td><td width="50%" align="left">_<cfif AccountingMethod is "Modified Accrual"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Modified Accrual</font></td></tr>
<tr><td width="50%" align="left">_<cfif AccountingMethod is "Cash With Assets"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Cash - with assets (Modified Cash Basis)</font></td><td width="50%" align="left">_<cfif AccountingMethod is "Combination"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Combination - explain</font></td></tr>
</cfoutput>
</table>
<br>
<cfoutput query="GetAFRRptPg1">
<font size="-1"><b>C. Does the government have <u>Bonded</u> debt this reporting fiscal year?</font></b> _<cfif UCase(BondedDebt) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Yes</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(BondedDebt) is "N"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">No</font><br>
<br>
<font size="-1"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If "Yes", indicate the type(s) of debt <u>and</u> complete the Statement of Indebtedness page, located on page F7.</b></font><br>
<br>
<table <!---bgcolor="white" cellspacing="0" cellpadding="2" border="0" width="100%"--->>
<tr><td width="34%" align="left">_<cfif UCase(GoBonds) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">G.O. Bonds</font></td><td width="33%" align="left">_<cfif UCase(RevenueBonds) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Revenue Bonds</font></td><td width="33%" align="left">_<cfif UCase(AlternateRevenueBonds) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Alternate Revenue Bonds</font></td></tr>
</table>
</cfoutput>
<br>
<cfoutput query="GetAFRRptPg1">
<font size="-1"><b>D. Does the government have debt, other than bonded debt this reporting fiscal year?</font></b> _<cfif UCase(Debt) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Yes</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(Debt) is "N"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">No</font><br>
<br>
<font size="-1"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If "Yes", indicate the type(s) of debt <u>and</u> complete the Statement of Indebtedness page, located on page F7.</b></font><br>
<br>
<table <!---bgcolor="white" cellspacing="0" cellpadding="2" border="0" width="100%"--->>
<tr><td width="34%" align="left">_<cfif UCase(ContractualCommitments) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Contractual Commitments</font></td><td width="66%" align="left">_<cfif UCase(Other) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Other (Explan)&nbsp;<u>#OtherExplan#</u></font></td></tr>
</table>
</cfoutput>
<br>
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
	
<font size="-1"><b>E. Does <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> own or operate a public utility company?&nbsp;</b></font>_<cfif UCase(GetAFRRptPg1.Utilities) is "Y"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">Yes</font>&nbsp;&nbsp;&nbsp;&nbsp;_<cfif UCase(GetAFRRptPg1.Utilities) is "N"><u><font size="-1">X</font></u><cfelse>_</cfif>_ <font size="-1">No</font><br>
<br>
&nbsp;&nbsp;&nbsp;<font size="-1"><b>If Yes, indicate the type of public utility and enter the expenditures in Code 271.</b></font>
<br><br>
_<cfif ucase(UtilityWaterSewer) is "WaterSewer"><u>X</u><cfelse><u>_</u></cfif>_&nbsp;water/sewer&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;_<cfif ucase(UtilityElectricGasTransit) is "ElectricGasTransit"><u>X</u><cfelse><u>_</u></cfif>_&nbsp;electric/gas/transit&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;_<cfif ucase(Utility911) is "911"><u>X</u><cfelse><u>_</u></cfif>_&nbsp;911 telephone/telecommunications&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;_<cfif ucase(UtilityOther) is "Other"><u>X</u><cfelse><u>_</u></cfif>_&nbsp;other&nbsp;&nbsp;&nbsp;<cfif trim(UtilityOtherExplan) is not""><u>#UtilityOtherExplan#</u></cfif>
</cfoutput>
<br>
<!---<br>
<center><font size="-1">2<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
Special Purpose Form</font></center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "SP">
    	<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
	<cfif url.PrintIt is "No">
    	<cfoutput>
        <div align="center">
        <table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="90%">
        <tr><Td width="30%">&nbsp;</Td>
        <td width="5%">&nbsp;</td>
        <td width="30%"><center>#url.AFRDesiredData#</center></td>
        <td width="5%">&nbsp;</td>
        <td width="20%">#url.CFY# Special Purpose Form - 2</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
