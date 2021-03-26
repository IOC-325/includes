<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Error</title>
</head>

<body>
<cfparam name="url.PrintIt" default="No">
<cfoutput>
<cfStoredProc  datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#application.LocGovWarehouseCFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>


<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="55%">
<tr><td><b>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</b></td></tr>
</table>
</cfoutput>
<br><br>
</body>
</html>
