<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
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

LOGIC: Pulls off data from the Indebtedness table to show a unformatted view of the Page F5 of the AFR

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
 
 <!--- pulls off fields for Indebtedness --->
 <cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_IndebtednessInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetIndebtednessInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetIndebtednessInfoRetMsg">
	<cfprocresult name="GetIndebtednessInfo">
</cfstoredproc>
</cfoutput>

<cfif GetIndebtednessInfoRetVal is 0>
	<cfoutput>
	<cfset a400 = #iif(GetIndebtednessInfo.a400 is not "",NumberFormat(GetIndebtednessInfo.a400,"9999999999999999"),0)#>
	<cfset b400 = #iif(GetIndebtednessInfo.b400 is not "",NumberFormat(GetIndebtednessInfo.b400,"9999999999999999"),0)#>
	<cfset c400 = #iif(GetIndebtednessInfo.c400 is not "",NumberFormat(GetIndebtednessInfo.c400,"9999999999999999"),0)#>
	<cfset d400 = #iif(GetIndebtednessInfo.d400 is not "",NumberFormat(GetIndebtednessInfo.d400,"9999999999999999"),0)#>
	<cfset e400 = #iif(GetIndebtednessInfo.e400 is not "",NumberFormat(GetIndebtednessInfo.e400,"9999999999999999"),0)#>
	<cfset a401 = #iif(GetIndebtednessInfo.a401 is not "",NumberFormat(GetIndebtednessInfo.a401,"9999999999999999"),0)#>
	<cfset b401 = #iif(GetIndebtednessInfo.b401 is not "",NumberFormat(GetIndebtednessInfo.b401,"9999999999999999"),0)#>
	<cfset c401 = #iif(GetIndebtednessInfo.c401 is not "",NumberFormat(GetIndebtednessInfo.c401,"9999999999999999"),0)#>
	<cfset d401 = #iif(GetIndebtednessInfo.d401 is not "",NumberFormat(GetIndebtednessInfo.d401,"9999999999999999"),0)#>
	<cfset e401 = #iif(GetIndebtednessInfo.e401 is not "",NumberFormat(GetIndebtednessInfo.e401,"9999999999999999"),0)#>
	<cfset t402 = #iif(GetIndebtednessInfo.t402 is not "",NumberFormat(GetIndebtednessInfo.t402,"9999999999999999"),0)#>
	<cfset t403 = #iif(GetIndebtednessInfo.t403 is not "",NumberFormat(GetIndebtednessInfo.t403,"9999999999999999"),0)#>
	<cfset t404 = #iif(GetIndebtednessInfo.t404 is not "",NumberFormat(GetIndebtednessInfo.t404,"9999999999999999"),0)#>
	<cfset a406 = #iif(GetIndebtednessInfo.a406 is not "",NumberFormat(GetIndebtednessInfo.a406,"9999999999999999"),0)#>
	<cfset b406 = #iif(GetIndebtednessInfo.b406 is not "",NumberFormat(GetIndebtednessInfo.b406,"9999999999999999"),0)#>
	<cfset c406 = #iif(GetIndebtednessInfo.c406 is not "",NumberFormat(GetIndebtednessInfo.c406,"9999999999999999"),0)#>
	<cfset d406 = #iif(GetIndebtednessInfo.d406 is not "",NumberFormat(GetIndebtednessInfo.d406,"9999999999999999"),0)#>
	<cfset e406 = #iif(GetIndebtednessInfo.e406 is not "",NumberFormat(GetIndebtednessInfo.e406,"9999999999999999"),0)#>
	<cfset a407 = #iif(GetIndebtednessInfo.a407 is not "",NumberFormat(GetIndebtednessInfo.a407,"9999999999999999"),0)#>
	<cfset b407 = #iif(GetIndebtednessInfo.b407 is not "",NumberFormat(GetIndebtednessInfo.b407,"9999999999999999"),0)#>
	<cfset c407 = #iif(GetIndebtednessInfo.c407 is not "",NumberFormat(GetIndebtednessInfo.c407,"9999999999999999"),0)#>
	<cfset d407 = #iif(GetIndebtednessInfo.d407 is not "",NumberFormat(GetIndebtednessInfo.d407,"9999999999999999"),0)#>
	<cfset e407 = #iif(GetIndebtednessInfo.e407 is not "",NumberFormat(GetIndebtednessInfo.e407,"9999999999999999"),0)#>
	<cfset t408 = #iif(GetIndebtednessInfo.t408 is not "",NumberFormat(GetIndebtednessInfo.t408,"9999999999999999"),0)#>
	<cfset t409 = #iif(GetIndebtednessInfo.t409 is not "",NumberFormat(GetIndebtednessInfo.t409,"9999999999999999"),0)#>
	<cfset t410 = #iif(GetIndebtednessInfo.t410 is not "",NumberFormat(GetIndebtednessInfo.t410,"9999999999999999"),0)#>
	<cfset a412 = #iif(GetIndebtednessInfo.a412 is not "",NumberFormat(GetIndebtednessInfo.a412,"9999999999999999"),0)#>
	<cfset b412 = #iif(GetIndebtednessInfo.b412 is not "",NumberFormat(GetIndebtednessInfo.b412,"9999999999999999"),0)#>
	<cfset c412 = #iif(GetIndebtednessInfo.c412 is not "",NumberFormat(GetIndebtednessInfo.c412,"9999999999999999"),0)#>
	<cfset d412 = #iif(GetIndebtednessInfo.d412 is not "",NumberFormat(GetIndebtednessInfo.d412,"9999999999999999"),0)#>
	<cfset e412 = #iif(GetIndebtednessInfo.e412 is not "",NumberFormat(GetIndebtednessInfo.e412,"9999999999999999"),0)#>
	<cfset a413 = #iif(GetIndebtednessInfo.a413 is not "",NumberFormat(GetIndebtednessInfo.a413,"9999999999999999"),0)#>
	<cfset b413 = #iif(GetIndebtednessInfo.b413 is not "",NumberFormat(GetIndebtednessInfo.b413,"9999999999999999"),0)#>
	<cfset c413 = #iif(GetIndebtednessInfo.c413 is not "",NumberFormat(GetIndebtednessInfo.c413,"9999999999999999"),0)#>
	<cfset d413 = #iif(GetIndebtednessInfo.d413 is not "",NumberFormat(GetIndebtednessInfo.d413,"9999999999999999"),0)#>
	<cfset e413 = #iif(GetIndebtednessInfo.e413 is not "",NumberFormat(GetIndebtednessInfo.e413,"9999999999999999"),0)#>
	<cfset t414 = #iif(GetIndebtednessInfo.t414 is not "",NumberFormat(GetIndebtednessInfo.t414,"9999999999999999"),0)#>
	<cfset t415 = #iif(GetIndebtednessInfo.t415 is not "",NumberFormat(GetIndebtednessInfo.t415,"9999999999999999"),0)#>
	<cfset t416 = #iif(GetIndebtednessInfo.t416 is not "",NumberFormat(GetIndebtednessInfo.t416,"9999999999999999"),0)#>
	<cfset a418 = #LSParseNumber("#a400#")# + #LSParseNumber("#a406#")# - #LSParseNumber("#a412#")#>
	<cfset b418 = #LSParseNumber("#b400#")# + #LSParseNumber("#b406#")# - #LSParseNumber("#b412#")#>
	<cfset c418 = #LSParseNumber("#c400#")# + #LSParseNumber("#c406#")# - #LSParseNumber("#c412#")#>
	<cfset d418 = #LSParseNumber("#d400#")# + #LSParseNumber("#d406#")# - #LSParseNumber("#d412#")#>
	<cfset e418 = #LSParseNumber("#e400#")# + #LSParseNumber("#e406#")# - #LSParseNumber("#e412#")#>
	<cfset a419 = #LSParseNumber("#a401#")# + #LSParseNumber("#a407#")# - #LSParseNumber("#a413#")#>
	<cfset b419 = #LSParseNumber("#b401#")# + #LSParseNumber("#b407#")# - #LSParseNumber("#b413#")#>
	<cfset c419 = #LSParseNumber("#c401#")# + #LSParseNumber("#c407#")# - #LSParseNumber("#c413#")#>
	<cfset d419 = #LSParseNumber("#d401#")# + #LSParseNumber("#d407#")# - #LSParseNumber("#d413#")#>
	<cfset e419 = #LSParseNumber("#e401#")# + #LSParseNumber("#e407#")# - #LSParseNumber("#e413#")#>
	<cfset t420 = #LSParseNumber("#t402#")# + #LSParseNumber("#t408#")# - #LSParseNumber("#t414#")#>
	<cfset t421 = #LSParseNumber("#t403#")# + #LSParseNumber("#t409#")# - #LSParseNumber("#t415#")#>
	<cfset t422 = #LSParseNumber("#t404#")# + #LSParseNumber("#t410#")# - #LSParseNumber("#t416#")#>
    
     <cfset a424 = #iif(GetIndebtednessInfo.a424 is not "",NumberFormat(GetIndebtednessInfo.a424,"9999999999999999"),0)#>
	<cfset b424 = #iif(GetIndebtednessInfo.b424 is not "",NumberFormat(GetIndebtednessInfo.b424,"9999999999999999"),0)#>
	<cfset c424 = #iif(GetIndebtednessInfo.c424 is not "",NumberFormat(GetIndebtednessInfo.c424,"9999999999999999"),0)#>
	<cfset d424 = #iif(GetIndebtednessInfo.d424 is not "",NumberFormat(GetIndebtednessInfo.d424,"9999999999999999"),0)#>
	<cfset e424 = #iif(GetIndebtednessInfo.e424 is not "",NumberFormat(GetIndebtednessInfo.e424,"9999999999999999"),0)#>
    <cfset a425 = #iif(GetIndebtednessInfo.a425 is not "",NumberFormat(GetIndebtednessInfo.a425,"9999999999999999"),0)#>
	<cfset b425 = #iif(GetIndebtednessInfo.b425 is not "",NumberFormat(GetIndebtednessInfo.b425,"9999999999999999"),0)#>
	<cfset c425 = #iif(GetIndebtednessInfo.c425 is not "",NumberFormat(GetIndebtednessInfo.c425,"9999999999999999"),0)#>
	<cfset d425 = #iif(GetIndebtednessInfo.d425 is not "",NumberFormat(GetIndebtednessInfo.d425,"9999999999999999"),0)#>
	<cfset e425 = #iif(GetIndebtednessInfo.e425 is not "",NumberFormat(GetIndebtednessInfo.e425,"9999999999999999"),0)#>
    <cfset t426 = #iif(GetIndebtednessInfo.t426 is not "",NumberFormat(GetIndebtednessInfo.t426,"9999999999999999"),0)#>
	<cfset t427 = #iif(GetIndebtednessInfo.t427 is not "",NumberFormat(GetIndebtednessInfo.t427,"9999999999999999"),0)#>
	<cfset t428 = #iif(GetIndebtednessInfo.t428 is not "",NumberFormat(GetIndebtednessInfo.t428,"9999999999999999"),0)#>
    
    <cfset a430 = #GetIndebtednessInfo.a430#>
	<cfset b430 = #GetIndebtednessInfo.b430#>
	<cfset c430 = #GetIndebtednessInfo.c430#>
	<cfset d430 = #GetIndebtednessInfo.d430#>
	<cfset e430 = #GetIndebtednessInfo.e430#>
    <cfset a431 = #GetIndebtednessInfo.a431#>
	<cfset b431 = #GetIndebtednessInfo.b431#>
	<cfset c431 = #GetIndebtednessInfo.c431#>
	<cfset d431 = #GetIndebtednessInfo.d431#>
	<cfset e431 = #GetIndebtednessInfo.e431#>
    <cfset t432 = #GetIndebtednessInfo.t432#>
	<cfset t433 = #GetIndebtednessInfo.t433#>
	<cfset t434 = #GetIndebtednessInfo.t434#>
    
    <cfset a436 = #iif(GetIndebtednessInfo.a436 is not "",NumberFormat(GetIndebtednessInfo.a436,"9999999999999.99"),0.00)#>
	<cfset b436 = #iif(GetIndebtednessInfo.b436 is not "",NumberFormat(GetIndebtednessInfo.b436,"9999999999999.99"),0.00)#>
	<cfset c436 = #iif(GetIndebtednessInfo.c436 is not "",NumberFormat(GetIndebtednessInfo.c436,"9999999999999.99"),0.00)#>
	<cfset d436 = #iif(GetIndebtednessInfo.d436 is not "",NumberFormat(GetIndebtednessInfo.d436,"9999999999999.99"),0.00)#>
	<cfset e436 = #iif(GetIndebtednessInfo.e436 is not "",NumberFormat(GetIndebtednessInfo.e436,"9999999999999.99"),0.00)#>
    <cfset a437 = #iif(GetIndebtednessInfo.a437 is not "",NumberFormat(GetIndebtednessInfo.a437,"9999999999999.99"),0.00)#>
	<cfset b437 = #iif(GetIndebtednessInfo.b437 is not "",NumberFormat(GetIndebtednessInfo.b437,"9999999999999.99"),0.00)#>
	<cfset c437 = #iif(GetIndebtednessInfo.c437 is not "",NumberFormat(GetIndebtednessInfo.c437,"9999999999999.99"),0.00)#>
	<cfset d437 = #iif(GetIndebtednessInfo.d437 is not "",NumberFormat(GetIndebtednessInfo.d437,"9999999999999.99"),0.00)#>
	<cfset e437 = #iif(GetIndebtednessInfo.e437 is not "",NumberFormat(GetIndebtednessInfo.e437,"9999999999999.99"),0.00)#>
    <cfset t438 = #iif(GetIndebtednessInfo.t438 is not "",NumberFormat(GetIndebtednessInfo.t438,"9999999999999.99"),0.00)#>
	<cfset t439 = #iif(GetIndebtednessInfo.t439 is not "",NumberFormat(GetIndebtednessInfo.t439,"9999999999999.99"),0.00)#>
	<cfset t440 = #iif(GetIndebtednessInfo.t440 is not "",NumberFormat(GetIndebtednessInfo.t440,"9999999999999.99"),0.00)#>
    
    <cfset a442 = #iif(GetIndebtednessInfo.a442 is not "",NumberFormat(GetIndebtednessInfo.a442,"9999999999999.99"),0.00)#>
	<cfset b442 = #iif(GetIndebtednessInfo.b442 is not "",NumberFormat(GetIndebtednessInfo.b442,"9999999999999.99"),0.00)#>
	<cfset c442 = #iif(GetIndebtednessInfo.c442 is not "",NumberFormat(GetIndebtednessInfo.c442,"9999999999999.99"),0.00)#>
	<cfset d442 = #iif(GetIndebtednessInfo.d442 is not "",NumberFormat(GetIndebtednessInfo.d442,"9999999999999.99"),0.00)#>
	<cfset e442 = #iif(GetIndebtednessInfo.e442 is not "",NumberFormat(GetIndebtednessInfo.e442,"9999999999999.99"),0.00)#>
    <cfset a443 = #iif(GetIndebtednessInfo.a443 is not "",NumberFormat(GetIndebtednessInfo.a443,"9999999999999.99"),0.00)#>
	<cfset b443 = #iif(GetIndebtednessInfo.b443 is not "",NumberFormat(GetIndebtednessInfo.b443,"9999999999999.99"),0.00)#>
	<cfset c443 = #iif(GetIndebtednessInfo.c443 is not "",NumberFormat(GetIndebtednessInfo.c443,"9999999999999.99"),0.00)#>
	<cfset d443 = #iif(GetIndebtednessInfo.d443 is not "",NumberFormat(GetIndebtednessInfo.d443,"9999999999999.99"),0.00)#>
	<cfset e443 = #iif(GetIndebtednessInfo.e443 is not "",NumberFormat(GetIndebtednessInfo.e443,"9999999999999.99"),0.00)#>
    <cfset t444 = #iif(GetIndebtednessInfo.t444 is not "",NumberFormat(GetIndebtednessInfo.t444,"9999999999999.99"),0.00)#>
	<cfset t445 = #iif(GetIndebtednessInfo.t445 is not "",NumberFormat(GetIndebtednessInfo.t445,"9999999999999.99"),0.00)#>
	<cfset t446 = #iif(GetIndebtednessInfo.t446 is not "",NumberFormat(GetIndebtednessInfo.t446,"9999999999999.99"),0.00)#>
	
	</cfoutput>
<cfelse>
	<cfset a400 = 0>
	<cfset b400 = 0>
	<cfset c400 = 0>
	<cfset d400 = 0>
	<cfset e400 = 0>
	<cfset a401 = 0>
	<cfset b401 = 0>
	<cfset c401 = 0>
	<cfset d401 = 0>
	<cfset e401 = 0>
	<cfset t402 = 0>
	<cfset t403 = 0>
	<cfset t404 = 0>
	<cfset a406 = 0>
	<cfset b406 = 0>
	<cfset c406 = 0>
	<cfset d406 = 0>
	<cfset e406 = 0>
	<cfset a407 = 0>
	<cfset b407 = 0>
	<cfset c407 = 0>
	<cfset d407 = 0>
	<cfset e407 = 0>
	<cfset t408 = 0>
	<cfset t409 = 0>
	<cfset t410 = 0>
	<cfset a412 = 0>
	<cfset b412 = 0>
	<cfset c412 = 0>
	<cfset d412 = 0>
	<cfset e412 = 0>
	<cfset a413 = 0>
	<cfset b413 = 0>
	<cfset c413 = 0>
	<cfset d413 = 0>
	<cfset e413 = 0>
	<cfset t414 = 0>
	<cfset t415 = 0>
	<cfset t416 = 0>
	<cfset a418 = 0>
	<cfset b418 = 0>
	<cfset c418 = 0>
	<cfset d418 = 0>
	<cfset e418 = 0>
	<cfset a419 = 0>
	<cfset b419 = 0>
	<cfset c419 = 0>
	<cfset d419 = 0>
	<cfset e419 = 0>
	<cfset t420 = 0>
	<cfset t421 = 0>
	<cfset t422 = 0>
    
    <cfset a424 = 0>
	<cfset b424 = 0>
	<cfset c424 = 0>
	<cfset d424 = 0>
	<cfset e424 = 0>
    <cfset a425 = 0>
	<cfset b425 = 0>
	<cfset c425 = 0>
	<cfset d425 = 0>
	<cfset e425 = 0>
    <cfset t426 = 0>
	<cfset t427 = 0>
	<cfset t428 = 0>
    
    <cfset a430 = "">
	<cfset b430 = "">
	<cfset c430 = "">
	<cfset d430 = "">
	<cfset e430 = "">
    <cfset a431 = "">
	<cfset b431 = "">
	<cfset c431 = "">
	<cfset d431 = "">
	<cfset e431 = "">
    <cfset t432 = "">
	<cfset t433 = "">
	<cfset t434 = "">
    
    <cfset a436 = 0.00>
	<cfset b436 = 0.00>
	<cfset c436 = 0.00>
	<cfset d436 = 0.00>
	<cfset e436 = 0.00>
    <cfset a437 = 0.00>
	<cfset b437 = 0.00>
	<cfset c437 = 0.00>
	<cfset d437 = 0.00>
	<cfset e437 = 0.00>
    <cfset t438 = 0.00>
	<cfset t439 = 0.00>
	<cfset t440 = 0.00>
    
    <cfset a442 = 0.00>
	<cfset b442 = 0.00>
	<cfset c442 = 0.00>
	<cfset d442 = 0.00>
	<cfset e442 = 0.00>
    <cfset a443 = 0.00>
	<cfset b443 = 0.00>
	<cfset c443 = 0.00>
	<cfset d443 = 0.00>
	<cfset e443 = 0.00>
    <cfset t444 = 0.00>
	<cfset t445 = 0.00>
	<cfset t446 = 0.00>
</cfif>
 
<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Indebtedness">
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2017/SPFReport/AFRSPPgF5.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=F5" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h5>

<center><font size="-1"><b>Statement of Indebtedness (Governmental and Propriety)</b>&nbsp;</font></center>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
		<tr><td align="center" valign="top"><font size="-1"><b>Debt Instruments for All Funds</b>&nbsp;</font></td><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Outstanding<br>Beginning of Year</b>&nbsp;</font></td><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Issued Current<br>Fiscal Year</b>&nbsp;</font></td><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Retired Current<br>Fiscal Year</b>&nbsp;</font></td><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Outstanding<br>End of Year</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Original<br>Issue<br>Amount</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Final<br>Maturity<br>Date</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Interest<br>Rate<br>Ranges - <br>Lowest</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Interest<br>Rate<br>Ranges - <br>Highest</b>&nbsp;</font></td></tr>
		<tr><td colspan="13" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-1">Report in Whole Numbers&nbsp;</font></td></tr>		
		<cfoutput>
			<tr>
			<td><font size="-1"><b>General Obligation Bonds</b>&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>400</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a400 + b400 + c400 + d400 + e400))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>406</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a406 + b406 + c406 + d406 + e406))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>412</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a412 + b412 + c412 + d412 + e412))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>418</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a418 + b418 + c418 + d418 + e418))#&nbsp;</font></td>
            <td align="right"><font size="-1"><cfif a424 is not "">#NumberFormat(a424,"9999999999999999")#<cfelseif b424 is not "">#NumberFormat(b424,"9999999999999999")#<cfelseif c424 is not "">#NumberFormat(c424,"9999999999999999")#<cfelseif d424 is not "">#NumberFormat(d424,"9999999999999999")#<cfelseif e424 is not "">#NumberFormat(e424,"9999999999999999")#</cfif></font>&nbsp;</td>
            <td align="right"><font size="-1"><cfif a430 is not "">#DateFormat(a430,"MM/DD/YYYY")#<cfelseif b430 is not "">#DateFormat(b430,"MM/DD/YYYY")#<cfelseif c430 is not "">#DateFormat(c430,"MM/DD/YYYY")#<cfelseif d430 is not "">#DateFormat(d430,"MM/DD/YYYY")#<cfelseif e430 is not "">#DateFormat(e430,"MM/DD/YYYY")#</cfif></font>&nbsp;</td>
            <td align="right"><font size="-1"><cfif a436 is not "">#NumberFormat(a436,"9999999999999.99")#<cfelseif b436 is not "">#NumberFormat(b436,"9999999999999.99")#<cfelseif c436 is not "">#NumberFormat(c436,"9999999999999.99")#<cfelseif d436 is not "">#NumberFormat(d436,"9999999999999.99")#<cfelseif e436 is not "">#NumberFormat(e436,"9999999999999.99")#</cfif></font>&nbsp;</td>
            <td align="right"><font size="-1"><cfif a442 is not "">#NumberFormat(a442,"9999999999999.99")#<cfelseif b442 is not "">#NumberFormat(b442,"9999999999999.99")#<cfelseif c442 is not "">#NumberFormat(c442,"9999999999999.99")#<cfelseif d442 is not "">#NumberFormat(d442,"9999999999999.99")#<cfelseif e442 is not "">#NumberFormat(e442,"9999999999999.99")#</cfif></font>&nbsp;</td>
			</tr>
			<tr>
			<td><font size="-1"><b>Revenue Bonds</b>&nbsp;&nbsp;</p></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>401</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a401 + b401 + c401 + d401 + e401))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>407</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a407 + b407 + c407 + d407 + e407))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>413</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a413 + b413 + c413 + d413 + e413))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>419</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a419 + b419 + c419 + d419 + e419))#&nbsp;</font></td>
            <td align="right"><font size="-1"><cfif a425 is not "">#NumberFormat(a425,"9999999999999999")#<cfelseif b425 is not "">#NumberFormat(b425,"9999999999999999")#<cfelseif c425 is not "">#NumberFormat(c425,"9999999999999999")#<cfelseif d425 is not "">#NumberFormat(d425,"9999999999999999")#<cfelseif e425 is not "">#NumberFormat(e425,"9999999999999999")#</cfif></font>&nbsp;</td>
            <td align="right"><font size="-1"><cfif a431 is not "">#DateFormat(a431,"MM/DD/YYYY")#<cfelseif b431 is not "">#DateFormat(b431,"MM/DD/YYYY")#<cfelseif c431 is not "">#DateFormat(c431,"MM/DD/YYYY")#<cfelseif d431 is not "">#DateFormat(d431,"MM/DD/YYYY")#<cfelseif e431 is not "">#DateFormat(e431,"MM/DD/YYYY")#</cfif></font>&nbsp;</td>
            <td align="right"><font size="-1"><cfif a437 is not "">#NumberFormat(a437,"9999999999999.99")#<cfelseif b437 is not "">#NumberFormat(b437,"9999999999999.99")#<cfelseif c437 is not "">#NumberFormat(c437,"9999999999999.99")#<cfelseif d437 is not "">#NumberFormat(d437,"9999999999999.99")#<cfelseif e437 is not "">#NumberFormat(e437,"9999999999999.99")#</cfif></font>&nbsp;</td>
            <td align="right"><font size="-1"><cfif a443 is not "">#NumberFormat(a443,"9999999999999.99")#<cfelseif b443 is not "">#NumberFormat(b443,"9999999999999.99")#<cfelseif c443 is not "">#NumberFormat(c443,"9999999999999.99")#<cfelseif d443 is not "">#NumberFormat(d443,"9999999999999.99")#<cfelseif e443 is not "">#NumberFormat(e443,"9999999999999.99")#</cfif></font>&nbsp;</td>
			</tr>
			<tr>
			<td><font size="-1"><b>Alternate Revenue Bonds</b>&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>402</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(t402)#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>408</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(t408)#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>414</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(t414)#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>420</b></font></td><td align="right"><font size="-1">#NumberFormat(t420)#</font></td>
            <td align="right"><font size="-1">#NumberFormat(t426,"9999999999999999")#</font>&nbsp;</td>
            <td align="right"><font size="-1">#DateFormat(t432,"MM/DD/YYYY")#</font>&nbsp;</td>
            <td align="right"><font size="-1">#NumberFormat(t438,"9999999999999.99")#</font>&nbsp;</td>
            <td align="right"><font size="-1">#NumberFormat(t444,"9999999999999.99")#</font>&nbsp;</td>
			
			</tr>
			<tr>
			<td><font size="-1"><b>Contractual Commitments</b>&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>403</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(t403)#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>409</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(t409)#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>415</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(t415)#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>421</b></font></td><td align="right"><font size="-1">#NumberFormat(t421)#</font></td>	
            <td align="right"><font size="-1">#NumberFormat(t427,"9999999999999999")#</font>&nbsp;</td>
            <td align="right"><font size="-1">#DateFormat(t433,"MM/DD/YYYY")#</font>&nbsp;</td>
            <td align="right"><font size="-1">#NumberFormat(t439,"9999999999999.99")#</font>&nbsp;</td>
            <td align="right"><font size="-1">#NumberFormat(t445,"9999999999999.99")#</font>&nbsp;</td>
			</tr>
			<tr>
			<td><font size="-1"><b>Other (Explain)</b>&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>404</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(t404)#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>410</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(t410)#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>416</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(t416)#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>422</b></font></td><td align="right"><font size="-1">#NumberFormat(t422)#</font></td>
            <td align="right"><font size="-1">#NumberFormat(t428,"9999999999999999")#</font>&nbsp;</td>
            <td align="right"><font size="-1">#DateFormat(t434,"MM/DD/YYYY")#</font>&nbsp;</td>
            <td align="right"><font size="-1">#NumberFormat(t440,"9999999999999.99")#</font>&nbsp;</td>
            <td align="right"><font size="-1">#NumberFormat(t446,"9999999999999.99")#</font>&nbsp;</td>
			</tr>
			<tr><td colspan=13>&nbsp;</td></tr>
			<td><font size="-1"><b>Total Debt</b>&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>405</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a400 + b400 + c400 + d400 + e400 + a401 + b401 + c401 + d401 + e401 + t402 + t403 + t404))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>411</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a406 + b406 + c406 + d406 + e406 + a407 + b407 + c407 + d407 + e407 + t408 + t409 + t410))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>417</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a412 + b412 + c412 + d412 + e412 + a413 + b413 + c413 + d413 + e413 + t414 + t415 + t416))#&nbsp;</font></td>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>423</b>&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat((a418 + b418 + c418 + d418 + e418 + a419 + b419 + c419 + d419 + e419 + t420 + t421 + t422))#&nbsp;</font></td>
            <td <!--- bgcolor="silver" --->>&nbsp;</td>
            <td <!--- bgcolor="silver" --->>&nbsp;</td>
            <td <!--- bgcolor="silver" --->>&nbsp;</td>
            <td <!--- bgcolor="silver" --->>&nbsp;</td>
			</tr>
		</cfoutput>
		</table>
        
        <br>

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
        <td width="20%">#url.CFY# Special Purpose Form - F5</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
