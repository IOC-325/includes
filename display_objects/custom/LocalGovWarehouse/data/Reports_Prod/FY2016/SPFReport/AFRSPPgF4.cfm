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
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h3>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2016/SPFReport/AFRSPPgF4.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=F4" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<center><font size="-1"><b>Fund Balances and Other Financing Sources (Uses)</b>&nbsp;</font></center>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
		<tr><td <!--- bgcolor="silver" ---> align="center" valign="top"><font size="-1"><b>Code</b>&nbsp;</font></td><td width="10%" align="center" valign="top"><font size="-1"><b>Enter all Amounts in<br>Whole Numbers</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>General</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Special<br>Revenue</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Capital<br>Project</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Debt<br>Service</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Enterprise</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Internal<br>Service</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Fiduciary</b>&nbsp;</font></td><td align="center" valign="top"><font size="-1"><b>Discretely<br>Presented<br>Component<br>Units</b>&nbsp;</font></td></tr>
		<cfoutput query="GetFundBalanceCategoryInfo">
		<Cfset Category1=Left(Id, 4)>
		<cfif #Category1# is "302t">	
			<tr><td Colspan=10><font size="-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Report in Whole Numbers&nbsp;</font></td></tr>
			<tr>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>301t</b>&nbsp;</font></td><td><font size="-1"><b>Excess of receipts/revenues over (under) expenditures/expenses (240t-270t)</b></font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301GN is not "",NumberFormat(TotFundBal301GN,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301SR is not "",NumberFormat(TotFundBal301SR,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301CP is not "",NumberFormat(TotFundBal301CP,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301DS is not "",NumberFormat(TotFundBal301DS,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301EP is not "",NumberFormat(TotFundBal301EP,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301TS is not "",NumberFormat(TotFundBal301TS,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301FD is not "",NumberFormat(TotFundBal301FD,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(TotFundBal301DP is not "",NumberFormat(TotFundBal301DP,"9999999999999999"),0))#</font></td>
			</tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b>&nbsp;</font></td><td><font size="-1">#Description#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		<cfelseif #Category1# is "308t">
			<cfset FndBal308GN = Iif(GN is "",0,NumberFormat(GN,"9999999999999999"))>
			<cfset FndBal308SR = Iif(SR is "",0,NumberFormat(SR,"9999999999999999"))>
			<cfset FndBal308CP = Iif(CP is "",0,NumberFormat(CP,"9999999999999999"))>
			<cfset FndBal308DS = Iif(DS is "",0,NumberFormat(DS,"9999999999999999"))>
			<cfset FndBal308EP = Iif(EP is "",0,NumberFormat(EP,"9999999999999999"))>
			<cfset FndBal308TS = Iif(TS is "",0,NumberFormat(TS,"9999999999999999"))>
			<cfset FndBal308FD = Iif(FD is "",0,NumberFormat(FD,"9999999999999999"))>
			<cfset FndBal308DP = Iif(DP is "",0,NumberFormat(DP,"9999999999999999"))>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b></font></td><td><font size="-1">#Description#&nbsp;&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(GN)#</font></td><td align="right"><font size="-1">#NumberFormat(SR)#</font></td><td align="right"><font size="-1">#NumberFormat(CP)#</font></td><td align="right"><font size="-1">#NumberFormat(DS)#</font></td><td align="right"><font size="-1">#NumberFormat(EP)#</font></td><td align="right"><font size="-1">#NumberFormat(TS)#</font></td><td align="right"><font size="-1">#NumberFormat(FD)#</font></td><td align="right"><font size="-1">#NumberFormat(DP)#</font></td>
			</tr>
			<tr><td colspan=10>&nbsp;</td></tr>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>310t</b></font></td><td><font size="-1"><b>Current Year Ending Fund Balance (306 + 307 + 308)</b>&nbsp;&nbsp;</font></td>
			<cfset FndBalGN = iif(FndBal306GN is not "",NumberFormat(FndBal306GN,"9999999999999999"),0) + NumberFormat(FndBal307GN,"9999999999999999") + NumberFormat(FndBal308GN,"9999999999999999")>
			<cfset FndBalSR = iif(FndBal306SR is not "",NumberFormat(FndBal306SR,"9999999999999999"),0) + NumberFormat(FndBal307SR,"9999999999999999") + NumberFormat(FndBal308SR,"9999999999999999")>
			<cfset FndBalCP = iif(FndBal306CP is not "",NumberFormat(FndBal306CP,"9999999999999999"),0) + NumberFormat(FndBal307CP,"9999999999999999") + NumberFormat(FndBal308CP,"9999999999999999")>
			<cfset FndBalDS = iif(FndBal306DS is not "",NumberFormat(FndBal306DS,"9999999999999999"),0) + NumberFormat(FndBal307DS,"9999999999999999") + NumberFormat(FndBal308DS,"9999999999999999")>
			<cfset FndBalEP = iif(FndBal306DP is not "",NumberFormat(FndBal306EP,"9999999999999999"),0) + NumberFormat(FndBal307EP,"9999999999999999") + NumberFormat(FndBal308EP,"9999999999999999")>
			<cfset FndBalTS = iif(FndBal306TS is not "",NumberFormat(FndBal306TS,"9999999999999999"),0) + NumberFormat(FndBal307TS,"9999999999999999") + NumberFormat(FndBal308TS,"9999999999999999")>
			<cfset FndBalFD = iif(FndBal306FD is not "",NumberFormat(FndBal306FD,"9999999999999999"),0) + NumberFormat(FndBal307FD,"9999999999999999") + NumberFormat(FndBal308FD,"9999999999999999")>
			<cfset FndBalDP = iif(FndBal306DP is not "",NumberFormat(FndBal306DP,"9999999999999999"),0) + NumberFormat(FndBal307DP,"9999999999999999") + NumberFormat(FndBal308DP,"9999999999999999")>
			<td align="right"><font size="-1">#NumberFormat(FndBalGN)#</font></td><td align="right"><font size="-1">#NumberFormat(FndBalSR)#</font></td><td align="right"><font size="-1">#NumberFormat(FndBalCP)#</font></td><td align="right"><font size="-1">#NumberFormat(FndBalDS)#</font></td><td align="right"><font size="-1">#NumberFormat(FndBalEP)#</font></td><td align="right"><font size="-1">#NumberFormat(FndBalTS)#</font></td><td align="right"><font size="-1">#NumberFormat(FndBalFD)#</font></td><td align="right"><font size="-1">#NumberFormat(FndBalDP)#</font></td>
			</tr>
		<cfelseif #Category1# is "307t">
			<cfset FndBal307GN = Iif(GN is "",0,NumberFormat(GN,"9999999999999999"))>
			<cfset FndBal307SR = Iif(SR is "",0,NumberFormat(SR,"9999999999999999"))>
			<cfset FndBal307CP = Iif(CP is "",0,NumberFormat(CP,"9999999999999999"))>
			<cfset FndBal307DS = Iif(DS is "",0,NumberFormat(DS,"9999999999999999"))>
			<cfset FndBal307EP = Iif(EP is "",0,NumberFormat(EP,"9999999999999999"))>
			<cfset FndBal307TS = Iif(TS is "",0,NumberFormat(TS,"9999999999999999"))>
			<cfset FndBal307FD = Iif(FD is "",0,NumberFormat(FD,"9999999999999999"))>
			<cfset FndBal307DP = Iif(DP is "",0,NumberFormat(DP,"9999999999999999"))>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b></font></td><td><font size="-1">#Description#&nbsp;&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(GN)#</font></td><td align="right"><font size="-1">#NumberFormat(SR)#</font></td><td align="right"><font size="-1">#NumberFormat(CP)#</font></td><td align="right"><font size="-1">#NumberFormat(DS)#</font></td><td align="right"><font size="-1">#NumberFormat(EP)#</font></td><td align="right"><font size="-1">#NumberFormat(TS)#</font></td><td align="right"><font size="-1">#NumberFormat(FD)#</font></td><td align="right"><font size="-1">#NumberFormat(DP)#</font></td>
			</tr>
		<cfelseif #Category1# is "305t">
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b></font></td><td><font size="-1">#Description#&nbsp;&nbsp;</font></td>
			<td align="right"><font size="-1">#NumberFormat(GN)#</font></td><td align="right"><font size="-1">#NumberFormat(SR)#</font></td><td align="right"><font size="-1">#NumberFormat(CP)#</font></td><td align="right"><font size="-1">#NumberFormat(DS)#</font></td><td align="right"><font size="-1">#NumberFormat(EP)#</font></td><td align="right"><font size="-1">#NumberFormat(TS)#</font></td><td align="right"><font size="-1">#NumberFormat(FD)#</font></td><td align="right"><font size="-1">#NumberFormat(DP)#</font></td>
			</tr>
			<cfset FndBal306GN = #NumberFormat(TotFundBal306GN,"9999999999999999")#>
			<cfset FndBal306SR = #NumberFormat(TotFundBal306SR,"9999999999999999")#>
			<cfset FndBal306CP = #NumberFormat(TotFundBal306CP,"9999999999999999")#>
			<cfset FndBal306DS = #NumberFormat(TotFundBal306DS,"9999999999999999")#>
			<cfset FndBal306EP = #NumberFormat(TotFundBal306EP,"9999999999999999")#>
			<cfset FndBal306TS = #NumberFormat(TotFundBal306TS,"9999999999999999")#>
			<cfset FndBal306FD = #NumberFormat(TotFundBal306FD,"9999999999999999")#>
			<cfset FndBal306DP = #NumberFormat(TotFundBal306DP,"9999999999999999")#>
			<tr>
			<td <!--- bgcolor="silver" --->><font size="-1"><b>306t</b>&nbsp;</font></td><td><font size="-1"><b>Net increase(decrease) in fund balance (301t + 302t - 303t + 304t + 305t)</b></font></td>
			<td align="right"><font size="-1">#Numberformat(iif(FndBal306GN is not "",NumberFormat(FndBal306GN,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(FndBal306SR is not "",NumberFormat(FndBal306SR,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(FndBal306CP is not "",NumberFormat(FndBal306CP,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(FndBal306DS is not "",NumberFormat(FndBal306DS,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(FndBal306EP is not "",NumberFormat(FndBal306EP,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(FndBal306TS is not "",NumberFormat(FndBal306TS,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(FndBal306FD is not "",NumberFormat(FndBal306FD,"9999999999999999"),0))#</font></td>
			<td align="right"><font size="-1">#Numberformat(iif(FndBal306DP is not "",NumberFormat(FndBal306DP,"9999999999999999"),0))#</font></td>
			</tr>
		<cfelse>
			<tr><td <!--- bgcolor="silver" --->><font size="-1"><b>#ID#</b>&nbsp;</font></td><td><font size="-1">#Description#&nbsp;</font>&nbsp;&nbsp;</td>
			<td align="right"><font size="-1">#NumberFormat(GN)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(SR)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(CP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(EP)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(TS)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(FD)#&nbsp;</font></td><td align="right"><font size="-1">#NumberFormat(DP)#&nbsp;</font></td>
			</tr>
		</cfif>
		</cfoutput>
		</table>
		<br>
        <!---<p align="right"><font size="-1">F4&nbsp;</font></right>
		<br><center>
<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
Special Purpose Form&nbsp;</font></center><br><br>--->
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
        <td width="20%">#url.CFY# Special Purpose Form - F4</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
