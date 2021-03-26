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
	<cfSet IMRF_t501_1 = "#GetPensionCategoryInfo.IMRF_t501_1#">
	<cfSet IMRF_t502_1 = "#GetPensionCategoryInfo.IMRF_t502_1#">
	<cfSet IMRF_t503_1 = "#GetPensionCategoryInfo.IMRF_t503_1#">
	<cfSet IMRF_t504_1 = "#GetPensionCategoryInfo.IMRF_t504_1#">
	<cfSet IMRF_t505_1 = "#GetPensionCategoryInfo.IMRF_t505_1#">
	<cfSet IMRF_t500_2 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500_2,"mm/dd/yyyy")#">
	<cfSet IMRF_t501_2 = "#GetPensionCategoryInfo.IMRF_t501_2#">
	<cfSet IMRF_t502_2 = "#GetPensionCategoryInfo.IMRF_t502_2#">
	<cfSet IMRF_t503_2 = "#GetPensionCategoryInfo.IMRF_t503_2#">
	<cfSet IMRF_t504_2 = "#GetPensionCategoryInfo.IMRF_t504_2#">
	<cfSet IMRF_t505_2 = "#GetPensionCategoryInfo.IMRF_t505_2#">
	<cfSet IMRF_t500_3 = "#DateFormat(GetPensionCategoryInfo.IMRF_t500_3,"mm/dd/yyyy")#">
	<cfSet IMRF_t501_3 = "#GetPensionCategoryInfo.IMRF_t501_3#">
	<cfSet IMRF_t502_3 = "#GetPensionCategoryInfo.IMRF_t502_3#">
	<cfSet IMRF_t503_3 = "#GetPensionCategoryInfo.IMRF_t503_3#">
	<cfSet IMRF_t504_3 = "#GetPensionCategoryInfo.IMRF_t504_3#">
	<cfSet IMRF_t505_3 = "#GetPensionCategoryInfo.IMRF_t505_3#">
	
	<!--- Get Police Values --->
	 <cfSet Police_t500_1 = "#DateFormat(GetPensionCategoryInfo.Police_t500_1,"mm/dd/yyyy")#">
	<cfSet Police_t501_1 = "#GetPensionCategoryInfo.Police_t501_1#">
	<cfSet Police_t502_1 = "#GetPensionCategoryInfo.Police_t502_1#">
	<cfSet Police_t503_1 = "#GetPensionCategoryInfo.Police_t503_1#">
	<cfSet Police_t504_1 = "#GetPensionCategoryInfo.Police_t504_1#">
	<cfSet Police_t505_1 = "#GetPensionCategoryInfo.Police_t505_1#">
	<cfSet Police_t500_2 = "#DateFormat(GetPensionCategoryInfo.Police_t500_2,"mm/dd/yyyy")#">
	<cfSet Police_t501_2 = "#GetPensionCategoryInfo.Police_t501_2#">
	<cfSet Police_t502_2 = "#GetPensionCategoryInfo.Police_t502_2#">
	<cfSet Police_t503_2 = "#GetPensionCategoryInfo.Police_t503_2#">
	<cfSet Police_t504_2 = "#GetPensionCategoryInfo.Police_t504_2#">
	<cfSet Police_t505_2 = "#GetPensionCategoryInfo.Police_t505_2#">
	<cfSet Police_t500_3 = "#DateFormat(GetPensionCategoryInfo.Police_t500_3,"mm/dd/yyyy")#">
	<cfSet Police_t501_3 = "#GetPensionCategoryInfo.Police_t501_3#">
	<cfSet Police_t502_3 = "#GetPensionCategoryInfo.Police_t502_3#">
	<cfSet Police_t503_3 = "#GetPensionCategoryInfo.Police_t503_3#">
	<cfSet Police_t504_3 = "#GetPensionCategoryInfo.Police_t504_3#">
	<cfSet Police_t505_3 = "#GetPensionCategoryInfo.Police_t505_3#">
	
	<!--- Get Fire Values --->
	<cfSet Fire_t500_1 = "#DateFormat(GetPensionCategoryInfo.Fire_t500_1,"mm/dd/yyyy")#">
	<cfSet Fire_t501_1 = "#GetPensionCategoryInfo.Fire_t501_1#">
	<cfSet Fire_t502_1 = "#GetPensionCategoryInfo.Fire_t502_1#">
	<cfSet Fire_t503_1 = "#GetPensionCategoryInfo.Fire_t503_1#">
	<cfSet Fire_t504_1 = "#GetPensionCategoryInfo.Fire_t504_1#">
	<cfSet Fire_t505_1 = "#GetPensionCategoryInfo.Fire_t505_1#">
	<cfSet Fire_t500_2 = "#DateFormat(GetPensionCategoryInfo.Fire_t500_2,"mm/dd/yyyy")#">
	<cfSet Fire_t501_2 = "#GetPensionCategoryInfo.Fire_t501_2#">
	<cfSet Fire_t502_2 = "#GetPensionCategoryInfo.Fire_t502_2#">
	<cfSet Fire_t503_2 = "#GetPensionCategoryInfo.Fire_t503_2#">
	<cfSet Fire_t504_2 = "#GetPensionCategoryInfo.Fire_t504_2#">
	<cfSet Fire_t505_2 = "#GetPensionCategoryInfo.Fire_t505_2#">
	<cfSet Fire_t500_3 = "#DateFormat(GetPensionCategoryInfo.Fire_t500_3,"mm/dd/yyyy")#">
	<cfSet Fire_t501_3 = "#GetPensionCategoryInfo.Fire_t501_3#">
	<cfSet Fire_t502_3 = "#GetPensionCategoryInfo.Fire_t502_3#">
	<cfSet Fire_t503_3 = "#GetPensionCategoryInfo.Fire_t503_3#">
	<cfSet Fire_t504_3 = "#GetPensionCategoryInfo.Fire_t504_3#">
	<cfSet Fire_t505_3 = "#GetPensionCategoryInfo.Fire_t505_3#">
	
	<!--- Get SLEP Values --->
	<cfSet SLEP_t500_1 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500_1,"mm/dd/yyyy")#">
	<cfSet SLEP_t501_1 = "#GetPensionCategoryInfo.SLEP_t501_1#">
	<cfSet SLEP_t502_1 = "#GetPensionCategoryInfo.SLEP_t502_1#">
	<cfSet SLEP_t503_1 = "#GetPensionCategoryInfo.SLEP_t503_1#">
	<cfSet SLEP_t504_1 = "#GetPensionCategoryInfo.SLEP_t504_1#">
	<cfSet SLEP_t505_1 = "#GetPensionCategoryInfo.SLEP_t505_1#">
	<cfSet SLEP_t500_2 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500_2,"mm/dd/yyyy")#">
	<cfSet SLEP_t501_2 = "#GetPensionCategoryInfo.SLEP_t501_2#">
	<cfSet SLEP_t502_2 = "#GetPensionCategoryInfo.SLEP_t502_2#">
	<cfSet SLEP_t503_2 = "#GetPensionCategoryInfo.SLEP_t503_2#">
	<cfSet SLEP_t504_2 = "#GetPensionCategoryInfo.SLEP_t504_2#">
	<cfSet SLEP_t505_2 = "#GetPensionCategoryInfo.SLEP_t505_2#">
	<cfSet SLEP_t500_3 = "#DateFormat(GetPensionCategoryInfo.SLEP_t500_3,"mm/dd/yyyy")#">
	<cfSet SLEP_t501_3 = "#GetPensionCategoryInfo.SLEP_t501_3#">
	<cfSet SLEP_t502_3 = "#GetPensionCategoryInfo.SLEP_t502_3#">
	<cfSet SLEP_t503_3 = "#GetPensionCategoryInfo.SLEP_t503_3#">
	<cfSet SLEP_t504_3 = "#GetPensionCategoryInfo.SLEP_t504_3#">
	<cfSet SLEP_t505_3 = "#GetPensionCategoryInfo.SLEP_t505_3#">
	
	<!--- Get SLEP Values --->
	<cfSet Other_t500_1 = "#DateFormat(GetPensionCategoryInfo.Other_t500_1,"mm/dd/yyyy")#">
	<cfSet Other_t501_1 = "#GetPensionCategoryInfo.Other_t501_1#">
	<cfSet Other_t502_1 = "#GetPensionCategoryInfo.Other_t502_1#">
	<cfSet Other_t503_1 = "#GetPensionCategoryInfo.Other_t503_1#">
	<cfSet Other_t504_1 = "#GetPensionCategoryInfo.Other_t504_1#">
	<cfSet Other_t505_1 = "#GetPensionCategoryInfo.Other_t505_1#">
	<cfSet Other_t500_2 = "#DateFormat(GetPensionCategoryInfo.Other_t500_2,"mm/dd/yyyy")#">
	<cfSet Other_t501_2 = "#GetPensionCategoryInfo.Other_t501_2#">
	<cfSet Other_t502_2 = "#GetPensionCategoryInfo.Other_t502_2#">
	<cfSet Other_t503_2 = "#GetPensionCategoryInfo.Other_t503_2#">
	<cfSet Other_t504_2 = "#GetPensionCategoryInfo.Other_t504_2#">
	<cfSet Other_t505_2 = "#GetPensionCategoryInfo.Other_t505_2#">
	<cfSet Other_t500_3 = "#DateFormat(GetPensionCategoryInfo.Other_t500_3,"mm/dd/yyyy")#">
	<cfSet Other_t501_3 = "#GetPensionCategoryInfo.Other_t501_3#">
	<cfSet Other_t502_3 = "#GetPensionCategoryInfo.Other_t502_3#">
	<cfSet Other_t503_3 = "#GetPensionCategoryInfo.Other_t503_3#">
	<cfSet Other_t504_3 = "#GetPensionCategoryInfo.Other_t504_3#">
	<cfSet Other_t505_3 = "#GetPensionCategoryInfo.Other_t505_3#">
	
	<!--- Get OPEB Values --->
	<cfSet OPEB_t500_1 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500_1,"mm/dd/yyyy")#">
	<cfSet OPEB_t501_1 = "#GetPensionCategoryInfo.OPEB_t501_1#">
	<cfSet OPEB_t502_1 = "#GetPensionCategoryInfo.OPEB_t502_1#">
	<cfSet OPEB_t503_1 = "#GetPensionCategoryInfo.OPEB_t503_1#">
	<cfSet OPEB_t504_1 = "#GetPensionCategoryInfo.OPEB_t504_1#">
	<cfSet OPEB_t505_1 = "#GetPensionCategoryInfo.OPEB_t505_1#">
	<cfSet OPEB_t500_2 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500_2,"mm/dd/yyyy")#">
	<cfSet OPEB_t501_2 = "#GetPensionCategoryInfo.OPEB_t501_2#">
	<cfSet OPEB_t502_2 = "#GetPensionCategoryInfo.OPEB_t502_2#">
	<cfSet OPEB_t503_2 = "#GetPensionCategoryInfo.OPEB_t503_2#">
	<cfSet OPEB_t504_2 = "#GetPensionCategoryInfo.OPEB_t504_2#">
	<cfSet OPEB_t505_2 = "#GetPensionCategoryInfo.OPEB_t505_2#">
	<cfSet OPEB_t500_3 = "#DateFormat(GetPensionCategoryInfo.OPEB_t500_3,"mm/dd/yyyy")#">
	<cfSet OPEB_t501_3 = "#GetPensionCategoryInfo.OPEB_t501_3#">
	<cfSet OPEB_t502_3 = "#GetPensionCategoryInfo.OPEB_t502_3#">
	<cfSet OPEB_t503_3 = "#GetPensionCategoryInfo.OPEB_t503_3#">
	<cfSet OPEB_t504_3 = "#GetPensionCategoryInfo.OPEB_t504_3#">
	<cfSet OPEB_t505_3 = "#GetPensionCategoryInfo.OPEB_t505_3#">
	
<CFELSE>
	<!--- Set initial IMRF values to blank --->
	<cfset IMRF_t500_1 = "">
	<cfset IMRF_t501_1 = "0">
	<cfset IMRF_t502_1 = "0">
	<cfset IMRF_t503_1 = "0">
	<cfset IMRF_t504_1 = "0">
	<cfset IMRF_t505_1 = "0">
	<cfset IMRF_t500_2 = "">
	<cfset IMRF_t501_2 = "0">
	<cfset IMRF_t502_2 = "0">
	<cfset IMRF_t503_2 = "0">
	<cfset IMRF_t504_2 = "0">
	<cfset IMRF_t505_2 = "0">
	<cfset IMRF_t500_3 = "">
	<cfset IMRF_t501_3 = "0">
	<cfset IMRF_t502_3 = "0">
	<cfset IMRF_t503_3 = "0">
	<cfset IMRF_t504_3 = "0">
	<cfset IMRF_t505_3 = "0">
	
	<!--- Set initial Police values to blank --->
	<cfset Police_t500_1 = "">
	<cfset Police_t501_1 = "0">
	<cfset Police_t502_1 = "0">
	<cfset Police_t503_1 = "0">
	<cfset Police_t504_1 = "0">
	<cfset Police_t505_1 = "0">
	<cfset Police_t500_2 = "">
	<cfset Police_t501_2 = "0">
	<cfset Police_t502_2 = "0">
	<cfset Police_t503_2 = "0">
	<cfset Police_t504_2 = "0">
	<cfset Police_t505_2 = "0">
	<cfset Police_t500_3 = "">
	<cfset Police_t501_3 = "0">
	<cfset Police_t502_3 = "0">
	<cfset Police_t503_3 = "0">
	<cfset Police_t504_3 = "0">
	<cfset Police_t505_3 = "0">
	
	<!--- Set initial Fire values to blank --->
	<cfset Fire_t500_1 = "">
	<cfset Fire_t501_1 = "0">
	<cfset Fire_t502_1 = "0">
	<cfset Fire_t503_1 = "0">
	<cfset Fire_t504_1 = "0">
	<cfset Fire_t505_1 = "0">
	<cfset Fire_t500_2 = "">
	<cfset Fire_t501_2 = "0">
	<cfset Fire_t502_2 = "0">
	<cfset Fire_t503_2 = "0">
	<cfset Fire_t504_2 = "0">
	<cfset Fire_t505_2 = "0">
	<cfset Fire_t500_3 = "">
	<cfset Fire_t501_3 = "0">
	<cfset Fire_t502_3 = "0">
	<cfset Fire_t503_3 = "0">
	<cfset Fire_t504_3 = "0">
	<cfset Fire_t505_3 = "0">
	
	<!--- Set initial SLEP values to blank --->
	<cfset SLEP_t500_1 = "">
	<cfset SLEP_t501_1 = "0">
	<cfset SLEP_t502_1 = "0">
	<cfset SLEP_t503_1 = "0">
	<cfset SLEP_t504_1 = "0">
	<cfset SLEP_t505_1 = "0">
	<cfset SLEP_t500_2 = "">
	<cfset SLEP_t501_2 = "0">
	<cfset SLEP_t502_2 = "0">
	<cfset SLEP_t503_2 = "0">
	<cfset SLEP_t504_2 = "0">
	<cfset SLEP_t505_2 = "0">
	<cfset SLEP_t500_3 = "">
	<cfset SLEP_t501_3 = "0">
	<cfset SLEP_t502_3 = "0">
	<cfset SLEP_t503_3 = "0">
	<cfset SLEP_t504_3 = "0">
	<cfset SLEP_t505_3 = "0">
	
	<!--- Set initial Other values to blank --->
	<cfset Other_t500_1 = "">
	<cfset Other_t501_1 = "0">
	<cfset Other_t502_1 = "0">
	<cfset Other_t503_1 = "0">
	<cfset Other_t504_1 = "0">
	<cfset Other_t505_1 = "0">
	<cfset Other_t500_2 = "">
	<cfset Other_t501_2 = "0">
	<cfset Other_t502_2 = "0">
	<cfset Other_t503_2 = "0">
	<cfset Other_t504_2 = "0">
	<cfset Other_t505_2 = "0">
	<cfset Other_t500_3 = "">
	<cfset Other_t501_3 = "0">
	<cfset Other_t502_3 = "0">
	<cfset Other_t503_3 = "0">
	<cfset Other_t504_3 = "0">
	<cfset Other_t505_3 = "0">
	
	 <!--- Set initial OPEB values to blank --->
	<cfset OPEB_t500_1 = "">
	<cfset OPEB_t501_1 = "0">
	<cfset OPEB_t502_1 = "0">
	<cfset OPEB_t503_1 = "0">
	<cfset OPEB_t504_1 = "0">
	<cfset OPEB_t505_1 = "0">
	<cfset OPEB_t500_2 = "">
	<cfset OPEB_t501_2 = "0">
	<cfset OPEB_t502_2 = "0">
	<cfset OPEB_t503_2 = "0">
	<cfset OPEB_t504_2 = "0">
	<cfset OPEB_t505_2 = "0">
	<cfset OPEB_t500_3 = "">
	<cfset OPEB_t501_3 = "0">
	<cfset OPEB_t502_3 = "0">
	<cfset OPEB_t503_3 = "0">
	<cfset OPEB_t504_3 = "0">
	<cfset OPEB_t505_3 = "0">
</cfif>
</cfoutput>   

<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">

<cfset url.PageType="AFR">
<cfset url.PageName="Pension">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2014/SPFReport/Pension.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=F7" class="btn btn-primary btn-lg">
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
<td  width="14%"><p><font size="-1">Actuarial Valuation Date (500)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Police_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(Fire_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Actuarial Valuation Date (500)</font></p></td>
</tr> 
<tr>
<td  width="14%"><p><font size="-1">Total Pension Liability / Actuarial Accrued Liability (501)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t501_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t501_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t501_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t501_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t501_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t501_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t501_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t501_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t501_3,"L999,999,999,999,999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Total Pension Liability / Actuarial Accrued Liability (501)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Total Funded Pension / Actuarial Value of Assets (502)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t502_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t502_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t502_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t502_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t502_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t502_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t502_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t502_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t502_3,"L999,999,999,999,999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Total Funded Pension / Actuarial Value of Assets (502)</font></p></td>
</tr>
<!--- Calculated field (501-502) - User should NOT be able to change values. --->
<tr>
<td  width="14%"><p><font size="-1">Total Unfunded Pension Liability (503)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t503_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t503_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t503_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t503_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t503_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t503_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t503_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t503_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t503_3,"L999,999,999,999,999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Total Unfunded Pension Liability (503)</font></p></td>
</tr>	
<!--- Calculated field (502/501*100) - User should NOT be able to change values. --->
<tr>
<td  width="14%"><p><font size="-1">Funded Ratio (504)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t504_1,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t504_2,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t504_3,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t504_1,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t504_2,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t504_3,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t504_1,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t504_2,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t504_3,"L9,999,999,999,999.9")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Funded Ratio (504)</font></p></td>
</tr>	
<tr>
<td  width="14%"><p><font size="-1">Net Pension Obligation / Net OPEB Obligation (505)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t505_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t505_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t505_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t505_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t505_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Police_t505_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t505_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t505_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Fire_t505_3,"L999,999,999,999,999")))#</font></p></td></td>
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
<td  width="14%"><p><font size="-1">Actuarial Valuation Date (500)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(SLEP_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(Other_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(dateFormat(OPEB_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Actuarial Valuation Date (500)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Total Pension Liability / Actuarial Accrued Liability (501)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t501_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t501_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t501_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t501_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t501_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t501_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t501_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t501_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t501_3,"L999,999,999,999,999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Total Pension Liability / Actuarial Accrued Liability (501)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Total Funded Pension / Actuarial Value of Assets (502)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t502_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t502_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t502_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t502_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t502_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t502_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t502_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t502_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t502_3,"L999,999,999,999,999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Total Funded Pension / Actuarial Value of Assets (502)</font></p></td>
</tr>
<!--- Calculated field (501-502) - User should NOT be able to change values. --->
<tr>
<td  width="14%"><p><font size="-1">Total Unfunded Pension Liability (503)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t503_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t503_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t503_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t503_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t503_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t503_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t503_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t503_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t503_3,"L999,999,999,999,999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Total Unfunded Pension Liability (503)</font></p></td>
</tr>
<!--- Calculated field (501/502*100) - User should NOT be able to change values. --->
<tr>
<td  width="14%"><p><font size="-1">Funded Ratio (504)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t504_1,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t504_2,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t504_3,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t504_1,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t504_2,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t504_3,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t504_1,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t504_2,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t504_3,"L9,999,999,999,999.9")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Funded Ratio (504)</font></p></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1">Net Pension Obligation / Net OPEB Obligation (505)</font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t505_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t505_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(SLEP_t505_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t505_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t505_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(Other_t505_3,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t505_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t505_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(OPEB_t505_3,"L999,999,999,999,999")))#</font></p></td></td>
<td  width="14%"><p><font size="-1">Net Pension Obligation / Net OPEB Obligation (505)</font></p></td>
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
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
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
