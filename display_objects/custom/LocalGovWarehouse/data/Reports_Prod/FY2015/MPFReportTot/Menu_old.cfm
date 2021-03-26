<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Report Menu</title>
</head>

<cfLock Scope="SESSION" TIMEOUT="100">
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_UnitStatInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.Code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitStatInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitStatInfoRetMsg">
	<cfprocresult name="GetUnitStatInfo">
</cfstoredproc>
			
<cfif GetUnitStatInfoRetVal eq 2>
	<CFLOCATION URL="Errormsg3.cfm?ErrorMsg=#GetUnitStatInfoRetMsg#&UrlReturn=/AFR/Login/loginTimeout.cfm">
</cfif>
</cfoutput>
</cflock>

<body>
<table bgcolor="#F1FBAC" cellspacing="0" cellpadding="2" border="1" frame="box" rules="none" align="center" width="90%">
<tr>
<td>Choose from the following :   <cfoutput>||| <a href="AFRMPCoverPg.cfm?Code=#url.Code#&CFY=#url.CFY#">Cover Page</a> ||| <a href="AFRMPPg1.cfm?Code=#url.Code#&CFY=#url.CFY#">Step 1</a> ||| <a href="AFRMPPg2.cfm?Code=#url.Code#&CFY=#url.CFY#">Steps 2 - 3</a> ||| <a href="AFRMPPg3.cfm?Code=#url.Code#&CFY=#url.CFY#">Steps 4 - 6</a> ||| <a href="AFRMPPg4.cfm?Code=#url.Code#&CFY=#url.CFY#">Step 7</a> |||  <a href="AFRMPPg5.cfm?Code=#url.Code#&CFY=#url.CFY#">Step 8</a> ||| <a href="AFRMPPg5.cfm?Code=#url.Code#&CFY=#url.CFY#">Steps 9-10</a> 
||| <cfif UCase(GetUnitStatInfo.GASB34Flag) is "Y"><a href="AFRMPPgF1b.cfm?Code=#url.Code#&CFY=#url.CFY#">Assets, Liability, and Net Assets<Cfelse><a href="AFRMPPgF1.cfm?Code=#url.Code#&CFY=#url.CFY#">Assets, Liability, and  Equity</cfif></a> ||| <a href="AFRMPPgF2.cfm?Code=#url.Code#&CFY=#url.CFY#">Revenues (201t - 225g)</a> ||| <a href="AFRMPPgF3.cfm?Code=#url.Code#&CFY=#url.CFY#">Revenues (225h - 240t)</a> ||| <a href="AFRMPPgF4.cfm?Code=#url.Code#&CFY=#url.CFY#">Expenditures (251t - 275a)</a> ||| <a href="AFRMPPgF5.cfm?Code=#url.Code#&CFY=#url.CFY#">Expenditures (275b - 270t)</a> ||| <a href="AFRMPPgF6.cfm?Code=#url.Code#&CFY=#url.CFY#">Fund Balance</a>  ||| <a href="AFRMPPgF7.cfm?Code=#url.Code#&CFY=#url.CFY#">Indebtedness</a> ||| <a href="PensionF6.cfm?Code=#url.Code#&CFY=#url.CFY#">Pension Funds / Retirement Benefits</a> ||| <a href="AFRMPPgF8.cfm?Code=#url.Code#&CFY=#url.CFY#">Capital Outlay</a> ||| <a href="AFRMPPgF9.cfm?Code=#url.Code#&CFY=#url.CFY#">Audit Requirement and CPA Validation Checks</a> ||| <a href="">Return to Local Government Web Site</a> ||| <a href="">Return to Local Government Portal</a> |||</cfoutput></td>
</tr>
</table>
<!---</body>
</html>--->