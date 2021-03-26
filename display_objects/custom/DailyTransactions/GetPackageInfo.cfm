<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<cfoutput>
<cfinvoke component = "/ledger/includes/display_objects/custom/EmplSalarySQL/Component/EmployeeSalary" 
    method = "GetSSISPackageLogInfo" 
    Pkg_Name = "cash" 
    srce="LedgerDB2" 
    returnVariable = "GetSSISPackageLogInfo">
</cfoutput>
<p style="text-align:center; margin:5px 0 0 10px;"><cfoutput><cfif trim(GetSSISPackageLogInfo.Date) is not "">As of #DateFormat(GetSSISPackageLogInfo.Date,"mm/dd/yyyy")#</cfif></cfoutput></p>
</body>
</html>