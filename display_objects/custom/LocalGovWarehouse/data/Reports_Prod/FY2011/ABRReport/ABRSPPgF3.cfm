<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the FundBalance table to show a unformatted view of the Page F4 of the AFR

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
 
<!--- pulls off fields for Fund Balance --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_FundBalanceCategoryInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFundBalanceCategoryInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFundBalanceCategoryInfoRetMsg">
	<cfprocresult name="GetFundBalanceCategoryInfo">
</cfstoredproc>
</cfoutput>

<!--- Calculate CYE Fund Balance --->
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotFundBal301Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalGN" variable="TotFundBal301GN">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalSR" variable="TotFundBal301SR">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalCP" variable="TotFundBal301CP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDS" variable="TotFundBal301DS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalEP" variable="TotFundBal301EP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalTS" variable="TotFundBal301TS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalFD" variable="TotFundBal301FD">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDP" variable="TotFundBal301DP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalOT" variable="TotFundBal301OT">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotFundBal301RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotFundBal301RptRetMsg">
	<cfprocresult name="GetTotFundBal301Rpt">
</cfstoredproc>
</cfoutput>
 
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_TotFundBal306Rpt">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalGN" variable="TotFundBal306GN">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalSR" variable="TotFundBal306SR">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalCP" variable="TotFundBal306CP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDS" variable="TotFundBal306DS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalEP" variable="TotFundBal306EP">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalTS" variable="TotFundBal306TS">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalFD" variable="TotFundBal306FD">
		<cfprocparam type="Out"  cfsqltype="CF_SQL_Money" dbvarname="@TotFundBalDP" variable="TotFundBal306DP">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTotFundBal306RptRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTotFundBal306RptRetMsg">
	<cfprocresult name="GetTotFundBal306Rpt">
</cfstoredproc>
</cfoutput> 
	
<!---<html>
<head>
	<title>AFR</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Fund Balance">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h3>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2011/ABRReport/ABRSPPgF3.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=F3" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h3>

<center><font size="-1"><b>Fund Balances and Other Financing Sources (Uses)</b>&nbsp;</font></center>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
		<tr><td <!--- bgcolor="silver" ---> align="center" valign="top" width="5%"><font size="-1"><b>Code</b>&nbsp;</font></td><td width="30%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b>&nbsp;</font></td><td align="center" valign="top" width="20%"><font size="-1"><b>General</b>&nbsp;</font></td><td align="center" valign="top" width="20%"><font size="-1"><b>Special<br>Revenue</b>&nbsp;</font></td><td align="center" valign="top" width="20%"><font size="-1"><b>Other<br>Funds</b>&nbsp;</font></td></tr>
		<cfoutput query="GetFundBalanceCategoryInfo">
		<Cfset Category1=Left(Id, 4)>
		<cfif #Category1# is "307t">	
			<cfset FndBal301GN = Iif(TotFundBal301GN is "",0,NumberFormat(TotFundBal301GN,"999999999999999"))>
			<cfset FndBal301SR = Iif(TotFundBal301SR is "",0,NumberFormat(TotFundBal301SR,"999999999999999"))>
			<cfset FndBal301OT = Iif(TotFundBal301OT is "",0,NumberFormat(TotFundBal301OT,"999999999999999"))>
			<cfset FndBal307GN = Iif(GN is "",0,NumberFormat(GN,"999999999999999"))>
			<cfset FndBal307SR = Iif(SR is "",0,NumberFormat(SR,"999999999999999"))>
			<cfset FndBal307OT = Iif(OT is "",0,NumberFormat(OT,"999999999999999"))>
			<tr><td Colspan=10><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers&nbsp;</font></td></tr>
			<tr>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>301t</b>&nbsp;</font></td><td><font size="-1"><b>Excess of receipts/revenues over (under) expenditures/expenses (240t-270t)</b></font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301GN is not "",NumberFormat(TotFundBal301GN,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301SR is not "",NumberFormat(TotFundBal301SR,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301OT is not "",NumberFormat(TotFundBal301OT,"9999999999999999"),0))#</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b>&nbsp;</font></td><td><font size="-1">#Description#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#</font></td><td align="right"><font size="-1">#NumberFormat(SR)#</font></td><td align="right"><font size="-1">#NumberFormat(OT)#</font></td>
			</tr>
		<cfelseif #Category1# is "308t">
			<cfset FndBal308GN = Iif(GN is "",0,NumberFormat(GN,"999999999999999"))>
			<cfset FndBal308SR = Iif(SR is "",0,NumberFormat(SR,"999999999999999"))>
			<cfset FndBal308OT = Iif(OT is "",0,NumberFormat(OT,"999999999999999"))>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b></font></td><td><font size="-1">#Description#&nbsp;&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(GN)#</font></td><td align="right"><font size="-1">#NumberFormat(SR)#</font></td><td align="right"><font size="-1">#NumberFormat(OT)#</font></td>
			</tr>
			<tr><td colspan=10>&nbsp;</td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>310t</b></font></td><td><font size="-1"><b>Current Year Ending Fund Balance (301 + 307 + 308)</b>&nbsp;&nbsp;</font></td>
			<cfset FndBalGN = iif(FndBal301GN is not "",NumberFormat(FndBal301GN,"999999999999999"),0) + NumberFormat(FndBal307GN,"999999999999999") + NumberFormat(FndBal308GN,"999999999999999")>
			<cfset FndBalSR = iif(FndBal301SR is not "",NumberFormat(FndBal301SR,"999999999999999"),0) + NumberFormat(FndBal307SR,"999999999999999") + NumberFormat(FndBal308SR,"999999999999999")>
			<cfset FndBalOT = iif(FndBal301OT is not "",NumberFormat(FndBal301OT,"999999999999999"),0) + NumberFormat(FndBal307OT,"999999999999999") + NumberFormat(FndBal308OT,"999999999999999")>
			<td align="right"><font size="-1">#NumberFormat(FndBalGN)#</font></td><td align="right"><font size="-1">#NumberFormat(FndBalSR)#</font></td><td align="right"><font size="-1">#NumberFormat(FndBalOT)#</font></td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
		<br>
        <!---<p align="right"><font size="-1">F3&nbsp;</font></right>
		<br><center>
<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Abbreviated Form&nbsp;</font></center>
--->
<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "Abbrev">
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
        <td width="20%">#url.CFY# Abbreviated Form - F3</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
