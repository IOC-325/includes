<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta name="robots" content="noindex,nofollow">
<!--- 
Created By: Gary Ashbaugh
Date Created: 2-15-2012
Description:  The program will allow users to select a location
--->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Locations for "Follow the Money"</title>
</head>

<script language="JavaScript"><!--
	 
	  function ReturnLocation(RegLocation) { 
	 	
		//targetitem.value = RegLocation;
		// For Once ANDY solved my problem!!!!
		window.opener.targetitem.value=RegLocation;
		this.close();
		return;

	 }
	 
// -->	 
</script>

<cfoutput>
    
    <cfStoredProc datasource="LDRPConfReg" Procedure="Get_TrainingConfLocation">
		<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTrainingConfLocationRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTrainingConfLocationRetMsg">
		<cfprocresult name="GetTrainingConfLocation">
	</cfstoredproc>
 

</cfoutput>

<body>

<cfoutput>

<table width="100%" border="0" cellpadding="1" cellspacing="1" align="left">
<Tr><Td><font size="+2"><center><b>Locations for<br />"Follow the Money"</b></center></font></Td></Tr>
<tr><td>&nbsp;</td></tr>
<tr><td><b>Please click on the training location of your choice.</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td><b><u>Locations</u></b></td></tr>
<cfloop query="GetTrainingConfLocation">
<tr><td><a href="javascript:ReturnLocation('#Location#')"><img name="LeftArrow" src="/comptroller/images/RightArrowBlue2.gif" width="12" height="12" border="0" id="RightArrowBlue" alt="" /><font size="-2"><b>#Location#</b></font></a></td></tr>
<tr><td>&nbsp;</td></tr>
</cfloop>
<tr><td>&nbsp;</td></tr>
</table>
</cfoutput>
</body>
</html>