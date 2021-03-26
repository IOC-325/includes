<!---
Date Created: 4-3-13
Created By: Gary Ashbaugh

Description:  Allows the users to enter their pension information for the type of pensions he/she stated that he/she has on the registration side

 --->
<cfLock Scope="SESSION" TIMEOUT="100">
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_UnitStatInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitStatInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitStatInfoRetMsg">
	<cfprocresult name="GetUnitStatInfo">
</cfstoredproc>

<cfStoredProc  datasource="#application.SQLSource#" Procedure="Get_PensionCategoryInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetPensionCategoryInfoRetVal1">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetPensionCategoryInfoRetMsg1">
	<cfprocresult name="GetPensionCategoryInfo">
</cfstoredproc>


<cfif GetPensionCategoryInfoRetVal1 is 0>
	<!--- Get IMRF Valuea --->
	<cfSet IMRF_t500_1 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500_1,"mm/dd/yyyy")#">
    <cfSet IMRF_t500a_1 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500a_1,"mm/dd/yyyy")#">
    <cfSet IMRF_t500b_1 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500b_1,"mm/dd/yyyy")#">
	<cfSet IMRF_t501_1 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t501_1,"L999999999999999")#">
	<cfSet IMRF_t502_1 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t502_1,"L999999999999999")#">
	<cfSet IMRF_t503_1 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t503_1,"L999999999999999")#">
	<cfSet IMRF_t504_1 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t504_1,"L999999999999.9")#">
	<cfSet IMRF_t505_1 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t505_1,"L999999999999999")#">
	<cfSet IMRF_t500_2 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500_2,"mm/dd/yyyy")#">
    <cfSet IMRF_t500a_2 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500a_2,"mm/dd/yyyy")#">
    <cfSet IMRF_t500b_2 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500b_2,"mm/dd/yyyy")#">
	<cfSet IMRF_t501_2 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t501_2,"L999999999999999")#">
	<cfSet IMRF_t502_2 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t502_2,"L999999999999999")#">
	<cfSet IMRF_t503_2 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t503_2,"L999999999999999")#">
	<cfSet IMRF_t504_2 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t504_2,"L999999999999.9")#">
	<cfSet IMRF_t505_2 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t505_2,"L999999999999999")#">
	<cfSet IMRF_t500_3 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500_3,"mm/dd/yyyy")#">
    <cfSet IMRF_t500a_3 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500a_3,"mm/dd/yyyy")#">
    <cfSet IMRF_t500b_3 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500b_3,"mm/dd/yyyy")#">
	<cfSet IMRF_t501_3 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t501_3,"L999999999999999")#">
	<cfSet IMRF_t502_3 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t502_3,"L999999999999999")#">
	<cfSet IMRF_t503_3 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t503_3,"L999999999999999")#">
	<cfSet IMRF_t504_3 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t504_3,"L999999999999.9")#">
	<cfSet IMRF_t505_3 = "#NumberFormat(GetPensionCategoryInfo.IMRF_t505_3,"L999999999999999")#">
	
	<!--- Get Police Values --->
	<cfSet Police_t500_1 = "#DateFormat(GetPensionCategoryInfo.Police_t500_1,"mm/dd/yyyy")#">
    <cfSet Police_t500a_1 = "#DateFormat(GetPensionCategoryInfo.Police_t500a_1,"mm/dd/yyyy")#">
    <cfSet Police_t500b_1 = "#DateFormat(GetPensionCategoryInfo.Police_t500b_1,"mm/dd/yyyy")#">
	<cfSet Police_t501_1 = "#NumberFormat(GetPensionCategoryInfo.Police_t501_1,"L999999999999999")#">
	<cfSet Police_t502_1 = "#NumberFormat(GetPensionCategoryInfo.Police_t502_1,"L999999999999999")#">
	<cfSet Police_t503_1 = "#NumberFormat(GetPensionCategoryInfo.Police_t503_1,"L999999999999999")#">
	<cfSet Police_t504_1 = "#NumberFormat(GetPensionCategoryInfo.Police_t504_1,"L999999999999.9")#">
	<cfSet Police_t505_1 = "#NumberFormat(GetPensionCategoryInfo.Police_t505_1,"L999999999999999")#">
	<cfSet Police_t500_2 = "#DateFormat(GetPensionCategoryInfo.Police_t500_2,"mm/dd/yyyy")#">
    <cfSet Police_t500a_2 = "#DateFormat(GetPensionCategoryInfo.Police_t500a_2,"mm/dd/yyyy")#">
    <cfSet Police_t500b_2 = "#DateFormat(GetPensionCategoryInfo.Police_t500b_2,"mm/dd/yyyy")#">
	<cfSet Police_t501_2 = "#NumberFormat(GetPensionCategoryInfo.Police_t501_2,"L999999999999999")#">
	<cfSet Police_t502_2 = "#NumberFormat(GetPensionCategoryInfo.Police_t502_2,"L999999999999999")#">
	<cfSet Police_t503_2 = "#NumberFormat(GetPensionCategoryInfo.Police_t503_2,"L999999999999999")#">
	<cfSet Police_t504_2 = "#NumberFormat(GetPensionCategoryInfo.Police_t504_2,"L999999999999.9")#">
	<cfSet Police_t505_2 = "#NumberFormat(GetPensionCategoryInfo.Police_t505_2,"L999999999999999")#">
	<cfSet Police_t500_3 = "#DateFormat(GetPensionCategoryInfo.Police_t500_3,"mm/dd/yyyy")#">
    <cfSet Police_t500a_3 = "#DateFormat(GetPensionCategoryInfo.Police_t500a_3,"mm/dd/yyyy")#">
    <cfSet Police_t500b_3 = "#DateFormat(GetPensionCategoryInfo.Police_t500b_3,"mm/dd/yyyy")#">
	<cfSet Police_t501_3 = "#NumberFormat(GetPensionCategoryInfo.Police_t501_3,"L999999999999999")#">
	<cfSet Police_t502_3 = "#NumberFormat(GetPensionCategoryInfo.Police_t502_3,"L999999999999999")#">
	<cfSet Police_t503_3 = "#NumberFormat(GetPensionCategoryInfo.Police_t503_3,"L999999999999999")#">
	<cfSet Police_t504_3 = "#NumberFormat(GetPensionCategoryInfo.Police_t504_3,"L999999999999.9")#">
	<cfSet Police_t505_3 = "#NumberFormat(GetPensionCategoryInfo.Police_t505_3,"L999999999999999")#">
	
	<!--- Get Fire Values --->
	<cfSet Fire_t500_1 = "#DateFormat(GetPensionCategoryInfo.Fire_t500_1,"mm/dd/yyyy")#">
    <cfSet Fire_t500a_1 = "#DateFormat(GetPensionCategoryInfo.Fire_t500a_1,"mm/dd/yyyy")#">
    <cfSet Fire_t500b_1 = "#DateFormat(GetPensionCategoryInfo.Fire_t500b_1,"mm/dd/yyyy")#">
	<cfSet Fire_t501_1 = "#NumberFormat(GetPensionCategoryInfo.Fire_t501_1,"L999999999999999")#">
	<cfSet Fire_t502_1 = "#NumberFormat(GetPensionCategoryInfo.Fire_t502_1,"L999999999999999")#">
	<cfSet Fire_t503_1 = "#NumberFormat(GetPensionCategoryInfo.Fire_t503_1,"L999999999999999")#">
	<cfSet Fire_t504_1 = "#NumberFormat(GetPensionCategoryInfo.Fire_t504_1,"L999999999999.9")#">
	<cfSet Fire_t505_1 = "#NumberFormat(GetPensionCategoryInfo.Fire_t505_1,"L999999999999999")#">
	<cfSet Fire_t500_2 = "#DateFormat(GetPensionCategoryInfo.Fire_t500_2,"mm/dd/yyyy")#">
    <cfSet Fire_t500a_2 = "#DateFormat(GetPensionCategoryInfo.Fire_t500a_2,"mm/dd/yyyy")#">
    <cfSet Fire_t500b_2 = "#DateFormat(GetPensionCategoryInfo.Fire_t500b_2,"mm/dd/yyyy")#">
	<cfSet Fire_t501_2 = "#NumberFormat(GetPensionCategoryInfo.Fire_t501_2,"L999999999999999")#">
	<cfSet Fire_t502_2 = "#NumberFormat(GetPensionCategoryInfo.Fire_t502_2,"L999999999999999")#">
	<cfSet Fire_t503_2 = "#NumberFormat(GetPensionCategoryInfo.Fire_t503_2,"L999999999999999")#">
	<cfSet Fire_t504_2 = "#NumberFormat(GetPensionCategoryInfo.Fire_t504_2,"L999999999999.9")#">
	<cfSet Fire_t505_2 = "#NumberFormat(GetPensionCategoryInfo.Fire_t505_2,"L999999999999999")#">
	<cfSet Fire_t500_3 = "#DateFormat(GetPensionCategoryInfo.Fire_t500_3,"mm/dd/yyyy")#">
    <cfSet Fire_t500a_3 = "#DateFormat(GetPensionCategoryInfo.Fire_t500a_3,"mm/dd/yyyy")#">
    <cfSet Fire_t500b_3 = "#DateFormat(GetPensionCategoryInfo.Fire_t500b_3,"mm/dd/yyyy")#">
	<cfSet Fire_t501_3 = "#NumberFormat(GetPensionCategoryInfo.Fire_t501_3,"L999999999999999")#">
	<cfSet Fire_t502_3 = "#NumberFormat(GetPensionCategoryInfo.Fire_t502_3,"L999999999999999")#">
	<cfSet Fire_t503_3 = "#NumberFormat(GetPensionCategoryInfo.Fire_t503_3,"L999999999999999")#">
	<cfSet Fire_t504_3 = "#NumberFormat(GetPensionCategoryInfo.Fire_t504_3,"L999999999999.9")#">
	<cfSet Fire_t505_3 = "#NumberFormat(GetPensionCategoryInfo.Fire_t505_3,"L999999999999999")#">
	
	<!--- Get SLEP Values --->
	<cfSet SLEP_t500_1 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500_1,"mm/dd/yyyy")#">
    <cfSet SLEP_t500a_1 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500a_1,"mm/dd/yyyy")#">
    <cfSet SLEP_t500b_1 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500b_1,"mm/dd/yyyy")#">
	<cfSet SLEP_t501_1 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t501_1,"L999999999999999")#">
	<cfSet SLEP_t502_1 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t502_1,"L999999999999999")#">
	<cfSet SLEP_t503_1 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t503_1,"L999999999999999")#">
	<cfSet SLEP_t504_1 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t504_1,"L999999999999.9")#">
	<cfSet SLEP_t505_1 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t505_1,"L999999999999999")#">
	<cfSet SLEP_t500_2 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500_2,"mm/dd/yyyy")#">
    <cfSet SLEP_t500a_2 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500a_2,"mm/dd/yyyy")#">
    <cfSet SLEP_t500b_2 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500b_2,"mm/dd/yyyy")#">
	<cfSet SLEP_t501_2 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t501_2,"L999999999999999")#">
	<cfSet SLEP_t502_2 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t502_2,"L999999999999999")#">
	<cfSet SLEP_t503_2 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t503_2,"L999999999999999")#">
	<cfSet SLEP_t504_2 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t504_2,"L999999999999.9")#">
	<cfSet SLEP_t505_2 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t505_2,"L999999999999999")#">
	<cfSet SLEP_t500_3 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500_3,"mm/dd/yyyy")#">
    <cfSet SLEP_t500a_3 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500a_3,"mm/dd/yyyy")#">
    <cfSet SLEP_t500b_3 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500b_3,"mm/dd/yyyy")#">
	<cfSet SLEP_t501_3 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t501_3,"L999999999999999")#">
	<cfSet SLEP_t502_3 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t502_3,"L999999999999999")#">
	<cfSet SLEP_t503_3 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t503_3,"L999999999999999")#">
	<cfSet SLEP_t504_3 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t504_3,"L999999999999.9")#">
	<cfSet SLEP_t505_3 = "#NumberFormat(GetPensionCategoryInfo.SLEP_t505_3,"L999999999999999")#">
	
	<!--- Get SLEP Values --->
	<cfSet Other_t500_1 = "#DateFormat(GetPensionCategoryInfo.Other_t500_1,"mm/dd/yyyy")#">
    <cfSet Other_t500a_1 = "#DateFormat(GetPensionCategoryInfo.Other_t500a_1,"mm/dd/yyyy")#">
    <cfSet Other_t500b_1 = "#DateFormat(GetPensionCategoryInfo.Other_t500b_1,"mm/dd/yyyy")#">
	<cfSet Other_t501_1 = "#NumberFormat(GetPensionCategoryInfo.Other_t501_1,"L999999999999999")#">
	<cfSet Other_t502_1 = "#NumberFormat(GetPensionCategoryInfo.Other_t502_1,"L999999999999999")#">
	<cfSet Other_t503_1 = "#NumberFormat(GetPensionCategoryInfo.Other_t503_1,"L999999999999999")#">
	<cfSet Other_t504_1 = "#NumberFormat(GetPensionCategoryInfo.Other_t504_1,"L999999999999.9")#">
	<cfSet Other_t505_1 = "#NumberFormat(GetPensionCategoryInfo.Other_t505_1,"L999999999999999")#">
	<cfSet Other_t500_2 = "#DateFormat(GetPensionCategoryInfo.Other_t500_2,"mm/dd/yyyy")#">
    <cfSet Other_t500a_2 = "#DateFormat(GetPensionCategoryInfo.Other_t500a_2,"mm/dd/yyyy")#">
    <cfSet Other_t500b_2 = "#DateFormat(GetPensionCategoryInfo.Other_t500b_2,"mm/dd/yyyy")#">
	<cfSet Other_t501_2 = "#NumberFormat(GetPensionCategoryInfo.Other_t501_2,"L999999999999999")#">
	<cfSet Other_t502_2 = "#NumberFormat(GetPensionCategoryInfo.Other_t502_2,"L999999999999999")#">
	<cfSet Other_t503_2 = "#NumberFormat(GetPensionCategoryInfo.Other_t503_2,"L999999999999999")#">
	<cfSet Other_t504_2 = "#NumberFormat(GetPensionCategoryInfo.Other_t504_2,"L999999999999.9")#">
	<cfSet Other_t505_2 = "#NumberFormat(GetPensionCategoryInfo.Other_t505_2,"L999999999999999")#">
	<cfSet Other_t500_3 = "#DateFormat(GetPensionCategoryInfo.Other_t500_3,"mm/dd/yyyy")#">
    <cfSet Other_t500a_3 = "#DateFormat(GetPensionCategoryInfo.Other_t500a_3,"mm/dd/yyyy")#">
    <cfSet Other_t500b_3 = "#DateFormat(GetPensionCategoryInfo.Other_t500b_3,"mm/dd/yyyy")#">
	<cfSet Other_t501_3 = "#NumberFormat(GetPensionCategoryInfo.Other_t501_3,"L999999999999999")#">
	<cfSet Other_t502_3 = "#NumberFormat(GetPensionCategoryInfo.Other_t502_3,"L999999999999999")#">
	<cfSet Other_t503_3 = "#NumberFormat(GetPensionCategoryInfo.Other_t503_3,"L999999999999999")#">
	<cfSet Other_t504_3 = "#NumberFormat(GetPensionCategoryInfo.Other_t504_3,"L999999999999.9")#">
	<cfSet Other_t505_3 = "#NumberFormat(GetPensionCategoryInfo.Other_t505_3,"L999999999999999")#">
	
	<!--- Get OPEB Values --->
	<cfSet OPEB_t500_1 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500_1,"mm/dd/yyyy")#">
    <cfSet OPEB_t500a_1 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500a_1,"mm/dd/yyyy")#">
    <cfSet OPEB_t500b_1 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500b_1,"mm/dd/yyyy")#">
	<cfSet OPEB_t501_1 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t501_1,"L999999999999999")#">
	<cfSet OPEB_t502_1 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t502_1,"L999999999999999")#">
	<cfSet OPEB_t503_1 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t503_1,"L999999999999999")#">
	<cfSet OPEB_t504_1 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t504_1,"L999999999999.9")#">
	<cfSet OPEB_t505_1 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t505_1,"L999999999999999")#">
	<cfSet OPEB_t500_2 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500_2,"mm/dd/yyyy")#">
    <cfSet OPEB_t500a_2 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500a_2,"mm/dd/yyyy")#">
    <cfSet OPEB_t500b_2 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500b_2,"mm/dd/yyyy")#">
	<cfSet OPEB_t501_2 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t501_2,"L999999999999999")#">
	<cfSet OPEB_t502_2 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t502_2,"L999999999999999")#">
	<cfSet OPEB_t503_2 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t503_2,"L999999999999999")#">
	<cfSet OPEB_t504_2 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t504_2,"L999999999999.9")#">
	<cfSet OPEB_t505_2 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t505_2,"L999999999999999")#">
	<cfSet OPEB_t500_3 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500_3,"mm/dd/yyyy")#">
    <cfSet OPEB_t500a_3 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500a_3,"mm/dd/yyyy")#">
    <cfSet OPEB_t500b_3 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500b_3,"mm/dd/yyyy")#">
	<cfSet OPEB_t501_3 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t501_3,"L999999999999999")#">
	<cfSet OPEB_t502_3 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t502_3,"L999999999999999")#">
	<cfSet OPEB_t503_3 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t503_3,"L999999999999999")#">
	<cfSet OPEB_t504_3 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t504_3,"L999999999999.9")#">
	<cfSet OPEB_t505_3 = "#NumberFormat(GetPensionCategoryInfo.OPEB_t505_3,"L999999999999999")#">
	
<CFELSE>
	<!--- Set initial IMRF values to blank --->
	<cfset IMRF_t500_1 = "">
    <cfset IMRF_t500a_1 = "">
    <cfset IMRF_t500b_1 = "">
	<cfset IMRF_t501_1 = "0">
	<cfset IMRF_t502_1 = "0">
	<cfset IMRF_t503_1 = "0">
	<cfset IMRF_t504_1 = "0">
	<cfset IMRF_t505_1 = "0">
	<cfset IMRF_t500_2 = "">
    <cfset IMRF_t500a_2 = "">
    <cfset IMRF_t500b_2 = "">
	<cfset IMRF_t501_2 = "0">
	<cfset IMRF_t502_2 = "0">
	<cfset IMRF_t503_2 = "0">
	<cfset IMRF_t504_2 = "0">
	<cfset IMRF_t505_2 = "0">
	<cfset IMRF_t500_3 = "">
    <cfset IMRF_t500a_3 = "">
    <cfset IMRF_t500b_3 = "">
	<cfset IMRF_t501_3 = "0">
	<cfset IMRF_t502_3 = "0">
	<cfset IMRF_t503_3 = "0">
	<cfset IMRF_t504_3 = "0">
	<cfset IMRF_t505_3 = "0">
	
	<!--- Set initial Police values to blank --->
	<cfset Police_t500_1 = "">
    <cfset Police_t500a_1 = "">
    <cfset Police_t500b_1 = "">
	<cfset Police_t501_1 = "0">
	<cfset Police_t502_1 = "0">
	<cfset Police_t503_1 = "0">
	<cfset Police_t504_1 = "0">
	<cfset Police_t505_1 = "0">
	<cfset Police_t500_2 = "">
    <cfset Police_t500a_2 = "">
    <cfset Police_t500b_2 = "">
	<cfset Police_t501_2 = "0">
	<cfset Police_t502_2 = "0">
	<cfset Police_t503_2 = "0">
	<cfset Police_t504_2 = "0">
	<cfset Police_t505_2 = "0">
	<cfset Police_t500_3 = "">
    <cfset Police_t500a_3 = "">
    <cfset Police_t500b_3 = "">
	<cfset Police_t501_3 = "0">
	<cfset Police_t502_3 = "0">
	<cfset Police_t503_3 = "0">
	<cfset Police_t504_3 = "0">
	<cfset Police_t505_3 = "0">
	
	<!--- Set initial Fire values to blank --->
	<cfset Fire_t500_1 = "">
    <cfset Fire_t500a_1 = "">
    <cfset Fire_t500b_1 = "">
	<cfset Fire_t501_1 = "0">
	<cfset Fire_t502_1 = "0">
	<cfset Fire_t503_1 = "0">
	<cfset Fire_t504_1 = "0">
	<cfset Fire_t505_1 = "0">
	<cfset Fire_t500_2 = "">
    <cfset Fire_t500a_2 = "">
    <cfset Fire_t500b_2 = "">
	<cfset Fire_t501_2 = "0">
	<cfset Fire_t502_2 = "0">
	<cfset Fire_t503_2 = "0">
	<cfset Fire_t504_2 = "0">
	<cfset Fire_t505_2 = "0">
	<cfset Fire_t500_3 = "">
    <cfset Fire_t500a_3 = "">
    <cfset Fire_t500b_3 = "">
	<cfset Fire_t501_3 = "0">
	<cfset Fire_t502_3 = "0">
	<cfset Fire_t503_3 = "0">
	<cfset Fire_t504_3 = "0">
	<cfset Fire_t505_3 = "0">
	
	<!--- Set initial SLEP values to blank --->
	<cfset SLEP_t500_1 = "">
    <cfset SLEP_t500a_1 = "">
    <cfset SLEP_t500b_1 = "">
	<cfset SLEP_t501_1 = "0">
	<cfset SLEP_t502_1 = "0">
	<cfset SLEP_t503_1 = "0">
	<cfset SLEP_t504_1 = "0">
	<cfset SLEP_t505_1 = "0">
	<cfset SLEP_t500_2 = "">
    <cfset SLEP_t500a_2 = "">
    <cfset SLEP_t500b_2 = "">
	<cfset SLEP_t501_2 = "0">
	<cfset SLEP_t502_2 = "0">
	<cfset SLEP_t503_2 = "0">
	<cfset SLEP_t504_2 = "0">
	<cfset SLEP_t505_2 = "0">
	<cfset SLEP_t500_3 = "">
    <cfset SLEP_t500a_3 = "">
    <cfset SLEP_t500b_3 = "">
	<cfset SLEP_t501_3 = "0">
	<cfset SLEP_t502_3 = "0">
	<cfset SLEP_t503_3 = "0">
	<cfset SLEP_t504_3 = "0">
	<cfset SLEP_t505_3 = "0">
	
	<!--- Set initial Other values to blank --->
	<cfset Other_t500_1 = "">
    <cfset Other_t500a_1 = "">
    <cfset Other_t500b_1 = "">
	<cfset Other_t501_1 = "0">
	<cfset Other_t502_1 = "0">
	<cfset Other_t503_1 = "0">
	<cfset Other_t504_1 = "0">
	<cfset Other_t505_1 = "0">
	<cfset Other_t500_2 = "">
    <cfset Other_t500a_2 = "">
    <cfset Other_t500b_2 = "">
	<cfset Other_t501_2 = "0">
	<cfset Other_t502_2 = "0">
	<cfset Other_t503_2 = "0">
	<cfset Other_t504_2 = "0">
	<cfset Other_t505_2 = "0">
	<cfset Other_t500_3 = "">
    <cfset Other_t500a_3 = "">
    <cfset Other_t500b_3 = "">
	<cfset Other_t501_3 = "0">
	<cfset Other_t502_3 = "0">
	<cfset Other_t503_3 = "0">
	<cfset Other_t504_3 = "0">
	<cfset Other_t505_3 = "0">
	
	 <!--- Set initial OPEB values to blank --->
	<cfset OPEB_t500_1 = "">
    <cfset OPEB_t500a_1 = "">
    <cfset OPEB_t500b_1 = "">
	<cfset OPEB_t501_1 = "0">
	<cfset OPEB_t502_1 = "0">
	<cfset OPEB_t503_1 = "0">
	<cfset OPEB_t504_1 = "0">
	<cfset OPEB_t505_1 = "0">
	<cfset OPEB_t500_2 = "">
    <cfset OPEB_t500a_2 = "">
    <cfset OPEB_t500b_2 = "">
	<cfset OPEB_t501_2 = "0">
	<cfset OPEB_t502_2 = "0">
	<cfset OPEB_t503_2 = "0">
	<cfset OPEB_t504_2 = "0">
	<cfset OPEB_t505_2 = "0">
	<cfset OPEB_t500_3 = "">
    <cfset OPEB_t500a_3 = "">
    <cfset OPEB_t500b_3 = "">
	<cfset OPEB_t501_3 = "0">
	<cfset OPEB_t502_3 = "0">
	<cfset OPEB_t503_3 = "0">
	<cfset OPEB_t504_3 = "0">
	<cfset OPEB_t505_3 = "0">
</cfif>
</cfoutput>
</cfLock>

<cfset TabIndex=1>
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<!---
<cfset url.PageType="Summary">
<cfset url.PageName="Pension">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">--->
</div>
<h3 class="clearfix">
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2018/MPFReportTOt/PensionF6.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=F9&MENU=No" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>
</cfif>
</cfoutput>
</h3>

<div class="text-center"> <b>Pension Funds / Retirement Benefits</b></div><br />

<!--- Get CFY --->
<cfoutput>
<cfinclude template="PensionIMRF.cfm">

<cfinclude template="PensionPolice.cfm">

<cfinclude template="PensionFire.cfm">

<cfinclude template="PensionSLEP.cfm">

<cfinclude template="PensionOther.cfm">

<cfinclude template="PensionOPEB.cfm">

</cfoutput>
<!---<br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
		<tr><td align="right"><font size="-1">F8&nbsp;</font></td></tr>
		<tr><td><center><font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
			FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
			Multi-Purpose Form&nbsp;</font></center></td></tr>

         </table>--->

