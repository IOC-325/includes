<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Report Menu</title>
</head>
<cfLock Scope="SESSION" TIMEOUT="100">
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_UnitStatInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
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
<td>Choose from the following :   <cfoutput>||| <a href="AFRSPCoverPg.cfm?Code=#url.Code#&CFY=#url.CFY#">Cover Page</a> ||| <a href="AFRSPPg2.cfm?Code=#url.Code#&CFY=#url.CFY#">Steps 2 - 3</a> ||| <a href="AFRSPPg3.cfm?Code=#url.Code#&CFY=#url.CFY#">Steps 4 - 6</a> ||| <a href="AFRSPPg4.cfm?Code=#url.Code#&CFY=#url.CFY#">Step 7</a> |||  <a href="AFRSPPg5.cfm?Code=#url.Code#&CFY=#url.CFY#">Step 8</a> ||| <a href="AFRSPPg5.cfm?Code=#url.Code#&CFY=#url.CFY#">Steps 9-10</a> 
||| <cfif UCase(GetUnitStatInfo.GASB34Flag) is "Y"><a href="AFRSPPgF1b.cfm?Code=#url.Code#&CFY=#url.CFY#">Assets, Liability, and Net Assets<Cfelse><a href="AFRSPPgF1.cfm?Code=#url.Code#&CFY=#url.CFY#">Assets, Liability, and  Equity</cfif></a> ||| <a href="AFRSPPgF2.cfm?Code=#url.Code#&CFY=#url.CFY#">Revenues (201t - 240t)</a> ||| <a href="AFRSPPgF3.cfm?Code=#url.Code#&CFY=#url.CFY#">Expenditures (251t - 270t)</a> ||| <a href="AFRSPPgF4.cfm?Code=#url.Code#&CFY=#url.CFY#">Fund Balance</a>  ||| <a href="AFRSPPgF5.cfm?Code=#url.Code#&CFY=#url.CFY#">Indebtedness</a> ||| <a href="PensionF6.cfm?Code=#url.Code#&CFY=#url.CFY#">Pension Funds / Retirement Benefits</a> ||| <a href="AFRSPPgF6.cfm?Code=#url.Code#&CFY=#url.CFY#">Capital Outlay</a> ||| <a href="AFRSPPgF7.cfm?Code=#url.Code#&CFY=#url.CFY#">Audit Requirement and CPA Validation Checks</a> ||| <a href="">Return to Local Government Web Site</a> ||| <a href="">Return to Local Government Portal</a> |||</cfoutput></td>
</tr>
</table>
<!---</body>
</html>--->