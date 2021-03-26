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
</cfif>

<cfset url.PageType="Summary">
<cfset url.PageName="Indebtedness">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<h3>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2013/MPFReportTot/AFRMPPgF7.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Multi-Purpose Form&Page=F7" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h3>

<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
<tr><td><font size="-1"><b><center>Statement of Indebtedness</center></b>&nbsp;</font></td></tr>
</table><br>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box" width="100%">
		<tr><td align="center" valign="top" width="35%"><font size="-1"><b>Debt Instruments<br>for All Funds</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Outstanding<br>Beginning of Year</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Issued Current<br>Fiscal Year</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Retired Current<br>Fiscal Year</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Outstanding<br>End of Year</b>&nbsp;</font></td></tr>
		<tr><td colspan="5" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-1">Report in Whole Numbers&nbsp;</font></td></tr>
		<cfoutput>
			<tr>
			<td><font size="-1"><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>General Obligation Bonds<cfif url.PrintIt is "no"></a></cfif></b>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a400 + b400 + c400 + d400 + e400))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a406 + b406 + c406 + d406 + e406))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a412 + b412 + c412 + d412 + e412))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a418 + b418 + c418 + d418 + e418))#&nbsp;</font></td>
			</tr>
			<tr>
			<td><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Water<cfif url.PrintIt is "no"></a></cfif>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(a400)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(a406)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(a412)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(a418)#</font></td></tr>
			</tr>
			<tr>
			<td><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Electric<cfif url.PrintIt is "no"></a></cfif>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(b400)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(b406)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(b412)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(b418)#</font></td>
			</tr>
			<tr>
			<td><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Transportation<cfif url.PrintIt is "no"></a></cfif>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(c400)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(c406)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(c412)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(c418)#</font></td>
			</tr>
			<tr>
			<td><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Housing<cfif url.PrintIt is "no"></a></cfif>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(d400)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(d406)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(d412)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(d418)#</font></td>
			</tr>
			<tr>
			<td><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Other (Explain)<cfif url.PrintIt is "no"></a></cfif>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(e400)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(e406)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(e412)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(e418)#</font></td>
			</tr>
			<tr>
			<td><font size="-1"><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Revenue Bonds<cfif url.PrintIt is "no"></a></cfif></b></td>
			<td align="right"><font size="-1">#NumberFormat((a401 + b401 + c401 + d401 + e401))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a407 + b407 + c407 + d407 + e407))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a413 + b413 + c413 + d413 + e413))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a419 + b419 + c419 + d419 + e419))#&nbsp;</font></td>
			</tr>
			<tr>
			<td><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Water<cfif url.PrintIt is "no"></a></cfif></td>
			<td align="right"><font size="-1">#NumberFormat(a401)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(a407)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(a413)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(a419)#</font></td>
			</tr>
			<tr>
			<td><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Electric<cfif url.PrintIt is "no"></a></cfif></td>
			<td align="right"><font size="-1">#NumberFormat(b401)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(b407)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(b413)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(b419)#</font></td></tr>
			<tr>
			<td><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Transportation<cfif url.PrintIt is "no"></a></cfif></td>
			<td align="right"><font size="-1">#NumberFormat(c401)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(c407)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(c413)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(c419)#</font></td>
			</tr>
			<tr>
			<td><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Housing<cfif url.PrintIt is "no"></a></cfif></td>
			<td align="right"><font size="-1">#NumberFormat(d401)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(d407)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(d413)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(d419)#</font></td>
			</tr>
			<tr>
			<td><font size="-1"><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Other (Explain)<cfif url.PrintIt is "no"></a></cfif></td>
			<td align="right"><font size="-1">#NumberFormat(e401)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(e407)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(e413)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(e419)#</font></td>
			</tr>
			<tr>
			<td><font size="-1"><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Alternate Revenue Bonds<cfif url.PrintIt is "no"></a></cfif></b>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t402)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t408)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t414)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t420)#</font></td>
			</tr>
			<tr>
			<td><font size="-1"><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Contractual Commitments<cfif url.PrintIt is "no"></a></cfif></b>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t403)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t409)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t415)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t421)#</font></td>	
			</tr>
			<tr>
			<td><font size="-1"><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Other (Explain)<cfif url.PrintIt is "no"></a></cfif></b>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t404)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t410)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t416)#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(t422)#</font></td>
			</tr>
			<tr><td colspan=5>&nbsp;</td></tr>
            <tr>
			<td><font size="-1"><b><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Debt<cfif url.PrintIt is "no"></a></cfif></b>&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a400 + b400 + c400 + d400 + e400 + a401 + b401 + c401 + d401 + e401 + t402 + t403 + t404))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a406 + b406 + c406 + d406 + e406 + a407 + b407 + c407 + d407 + e407 + t408 + t409 + t410))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a412 + b412 + c412 + d412 + e412 + a413 + b413 + c413 + d413 + e413 + t414 + t415 + t416))#&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat((a418 + b418 + c418 + d418 + e418 + a419 + b419 + c419 + d419 + e419 + t420 + t421 + t422))#&nbsp;</font></td>
			</tr>
		</cfoutput>
		</table>

</cflock>
