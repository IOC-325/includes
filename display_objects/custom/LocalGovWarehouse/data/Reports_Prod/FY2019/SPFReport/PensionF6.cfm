<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->

<!---<html>
<head>
	<title>Pension Funds / Retirement Benefits</title>
</head>--->

<!--- 
Date Created: 4-3-13
Created By: Gary Ashbaugh

Description:  Allows the users to enter their pension information for the type of pensions he/she stated that he/she has on the registration side

 --->
 


<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_UnitStatInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitStatInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitStatInfoRetMsg">
	<cfprocresult name="GetUnitStatInfo">
</cfstoredproc>
</cfoutput>


<cfLock Scope="SESSION" TIMEOUT="100">
<cfset TabIndex=1>

<!---<body>--->



<!--- Get CFY --->
<cfoutput>
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
    <cfSet Fire_t500a_3 = "#DateFormat(GetPensionCategoryInfo.Fire_t500a_1,"mm/dd/yyyy")#">
    <cfSet Fire_t500b_3 = "#DateFormat(GetPensionCategoryInfo.Fire_t500b_1,"mm/dd/yyyy")#">
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

<div class="jumbotron">   
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">

<cfset url.PageType="AFR">
<cfset url.PageName="Pension Funds / Retirement Benefits">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2019/SPFReport/Pension.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=F7" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h5>

<center><font size="-1"><b>Pension Funds / Retirement Benefits</b></font></center>	
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" frame="box" width="100%">
<cfoutput>
<!--- IMRF, Police Pension, or Fire Pension --->
<tr>
<td  width="14%"><b><font size="-1">Field Description (Code)</font></b></td>
<td  colspan="3"><center><b><font size="-1">IMRF</font></b></center></td>
<td  colspan="3"><center><b><font size="-1">Police Pension</font></b></center></td>
<td  colspan="3"><center><b><font size="-1">Fire Pension</font></b></center></td>
<td  width="14%"><b><font size="-1">Field Description (Code)</font></b></td>
</tr>
<tr>
<td colspan="11"  align="center"><font size="-1">Report in Whole Numbers</font></td>
</tr>
<tr>
<td  width="14%">&nbsp;&nbsp;&nbsp;</td>
<td  width="8%"><center><font size="-1"><cfif trim(IMRF_t500_1) is not "">#ltrim(rtrim(DateFormat(IMRF_t500_1,"yyyy")))#<cfelse>Year 1</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(IMRF_t500_2) is not "">#ltrim(rtrim(DateFormat(IMRF_t500_2,"yyyy")))#<cfelse>Year 2</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(IMRF_t500_3) is not "">#ltrim(rtrim(DateFormat(IMRF_t500_3,"yyyy")))#<cfelse>Year 3</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(Police_t500_1) is not "">#ltrim(rtrim(DateFormat(Police_t500_1,"yyyy")))#<cfelse>Year 1</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(Police_t500_2) is not "">#ltrim(rtrim(DateFormat(Police_t500_2,"yyyy")))#<cfelse>Year 2</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(Police_t500_3) is not "">#ltrim(rtrim(DateFormat(Police_t500_3,"yyyy")))#<cfelse>Year 3</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(Fire_t500_1) is not "">#ltrim(rtrim(DateFormat(Fire_t500_1,"yyyy")))#<cfelse>Year 1</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(Fire_t500_2) is not "">#ltrim(rtrim(DateFormat(Fire_t500_2,"yyyy")))#<cfelse>Year 2</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(Fire_t500_3) is not "">#ltrim(rtrim(DateFormat(Fire_t500_3,"yyyy")))#<cfelse>Year 3</cfif></font></center></td>
<td  width="14%">&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Actuarial Valuation Date (VD) (500)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Actuarial Valuation Date (VD) (500)</font></p></td>
</tr> 
<tr>
<td  width="14%"><p><font size="-1">Reporting Date (RD) (500a)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500a_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500a_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500a_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500a_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500a_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500a_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500a_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500a_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500a_3,"mm/dd/yyyy")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Reporting Date (RD) (500a)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Measurement Date (MD) (500b)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500b_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500b_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500b_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500b_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500b_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500b_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500b_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500b_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500b_3,"mm/dd/yyyy")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Measurement Date (MD) (500b)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Total Pension Liability (TPL) (501)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t501_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t501_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t501_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t501_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t501_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t501_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t501_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t501_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t501_3,"L999999999999999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Total Pension Liability (TPL) (501)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Plan Fiduciary Net Position (FNP) (502)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t502_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t502_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t502_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t502_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t502_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t502_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t502_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t502_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t502_3,"L999999999999999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Plan Fiduciary Net Position (FNP) (502)</font></p></td>
</tr>
<!--- Calculated field (501-502) - User should NOT be able to change values. --->
<tr>
<td  width="14%"><p><font size="-1">Net Pension Liability (NPL) (503)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t503_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t503_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t503_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t503_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t503_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t503_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t503_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t503_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t503_3,"L999999999999999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Net Pension Liability (NPL) (503)</font></p></td>
</tr>	
<!--- Calculated field (502/501*100) - User should NOT be able to change values. --->
<tr>
<td  width="14%"><p><font size="-1">Plan Fiduciary Net Position as a Percentage of Total Pension Liability (504)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t504_1,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t504_2,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t504_3,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t504_1,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t504_2,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t504_3,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t504_1,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t504_2,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t504_3,"L9999999999999.9")))#%</font></p></td></td>
<td  width="14%"><p><font size="-1">Plan Fiduciary Net Position as a Percentage of Total Pension Liability (504)</font></p></td>
</tr>	
<tr>
<td  width="14%"><p><font size="-1">Net Pension Obligation / Net OPEB Obligation (505)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t505_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t505_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t505_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t505_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t505_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t505_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t505_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t505_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t505_3,"L999999999999999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Net Pension Obligation / Net OPEB Obligation (505)</font></p></td>
</tr>
<tr><td colspan="11">&nbsp;</td></tr>
<!--- SLEP, Other Pension, or OPEB --->
<tr>
<td  width="14%"><b><font size="-1">Field Description (Code)</font></b></td>
<td  colspan="3"><center><b><font size="-1">SLEP</font></b></center></td>
<td  colspan="3"><center><b><font size="-1">Other Pension</font></b></center></td>
<td  colspan="3"><center><b><font size="-1">OPEB (net)</font></b></center></td>
<td  width="14%"><b><font size="-1">Field Description (Code)</font></b></td>
</tr>
<tr> 
<td colspan="11"  align="center"><font size="-1">Report in Whole Numbers</font></td>
</tr>
<tr>
<td  width="14%">&nbsp;&nbsp;&nbsp;</td>
<td  width="8%"><center><font size="-1"><cfif trim(SLEP_t500_1) is not "">#ltrim(rtrim(DateFormat(SLEP_t500_1,"yyyy")))#<cfelse>Year 1</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(SLEP_t500_2) is not "">#ltrim(rtrim(DateFormat(SLEP_t500_2,"yyyy")))#<cfelse>Year 2</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(SLEP_t500_3) is not "">#ltrim(rtrim(DateFormat(SLEP_t500_3,"yyyy")))#<cfelse>Year 3</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(Other_t500_1) is not "">#ltrim(rtrim(DateFormat(Other_t500_1,"yyyy")))#<cfelse>Year 1</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(Other_t500_2) is not "">#ltrim(rtrim(DateFormat(Other_t500_2,"yyyy")))#<cfelse>Year 2</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(Other_t500_3) is not "">#ltrim(rtrim(DateFormat(Other_t500_3,"yyyy")))#<cfelse>Year 3</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(OPEB_t500_1) is not "">#ltrim(rtrim(DateFormat(OPEB_t500_1,"yyyy")))#<cfelse>Year 1</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(OPEB_t500_2) is not "">#ltrim(rtrim(DateFormat(OPEB_t500_2,"yyyy")))#<cfelse>Year 2</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(OPEB_t500_3) is not "">#ltrim(rtrim(DateFormat(OPEB_t500_3,"yyyy")))#<cfelse>Year 3</cfif></font></center></td>
<td  width="14%">&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Actuarial Valuation Date (VD) (500)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Actuarial Valuation Date (VD) (500)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Reporting Date (RD) (500a)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500a_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500a_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500a_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500a_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500a_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500a_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500a_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500a_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500a_3,"mm/dd/yyyy")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Reporting Date (RD) (500a)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Measurement Date (MD) (500b)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500b_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500b_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500b_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500b_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500b_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500b_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500b_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500b_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500b_3,"mm/dd/yyyy")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Measurement Date (MD) (500b)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Total Pension Liability (TPL) (501)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t501_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t501_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t501_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t501_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t501_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t501_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t501_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t501_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t501_3,"L999999999999999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Total Pension Liability (TPL) (501)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Plan Fiduciary Net Position (FNP) (502)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t502_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t502_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t502_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t502_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t502_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t502_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t502_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t502_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t502_3,"L999999999999999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Plan Fiduciary Net Position (FNP) (502)</font></p></td>
</tr>
<!--- Calculated field (501-502) - User should NOT be able to change values. --->
<tr>
<td  width="14%"><p><font size="-1">Net Pension Liability (NPL) (503)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t503_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t503_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t503_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t503_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t503_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t503_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t503_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t503_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t503_3,"L999999999999999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Net Pension Liability (NPL) (503)</font></p></td>
</tr>
<!--- Calculated field (501/502*100) - User should NOT be able to change values. --->
<tr>
<td  width="14%"><p><font size="-1">Plan Fiduciary Net Position as a Percentage of Total Pension Liability (504)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t504_1,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t504_2,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t504_3,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t504_1,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t504_2,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t504_3,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t504_1,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t504_2,"L9999999999999.9")))#%</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t504_3,"L9999999999999.9")))#%</font></p></td></td>
<td  width="14%"><p><font size="-1">Plan Fiduciary Net Position as a Percentage of Total Pension Liability (504)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">OPEB Obligation (505)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t505_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t505_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t505_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t505_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t505_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t505_3,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t505_1,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t505_2,"L999999999999999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t505_3,"L999999999999999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">OPEB Obligation (505)</font></p></td>
</tr>
</cfoutput>
</table>	
</cflock>
<br>
<!---<p align="right"><font size="-1">F6&nbsp;</font></p>
<br><center>
<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Special Purpose Form&nbsp;</font></center>
 <br><br>
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
        <td width="20%">#url.CFY# Special Purpose Form - F7</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
