<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<cfoutput>
<cfStoredProc datasource="Vendor" Procedure="Get_ErrorMsg">
    <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@ErrorNo" value="#url.ErrorNo#">
    <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Section" value="#url.Section#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetErrorNoRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetErrorNoRetMsg">
    <cfprocresult name="GetErrorNo">
</cfstoredproc>

#GetErrorNo.ErrorHelp#
<br /><br />
<a href="javascript:window.close()">Close</a>
</cfoutput>
</body>
</html>