<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Check Errors</title>
</head>

<body>

<cfLock Scope="SESSION" TIMEOUT="500">
<CFSET ShowStopper="No">
<cfoutput>
<CFSET aProblems = ARRAYNEW(2)> 

<cfStoredProc Datasource="#application.SQLSource#" Procedure="Get_UnitInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="cf_sql_smallint" dbvarname="@C4" value="#GetAFRRptPg1.C4#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitInfoRetMsg">
	<cfprocresult name="GetUnitInfo">
</cfstoredproc>

<cfStoredProc Datasource="#application.SQLSource#" Procedure="Get_UnitStatInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitStatInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitStatInfoRetMsg">
	<cfprocresult name="GetUnitStatInfo">
</cfstoredproc>

<cfif UCase(GetUnitStatInfo.AbbrFrmFlag) is "Y" and UCase(GetUnitStatInfo.GASB34Flag) is "N">
    <cfset variables.DataEntryType = "%Abbrv%">
<cfelseif UCase(GetUnitStatInfo.GASB34Flag) is "Y">
    <cfset variables.DataEntryType = "%GASB34%">
<!--- <cfelseif Session.QuestionType is "REGONLY">
	 <cfset variables.DataEntryType = "%RegOnly%"> --->
<cfelse>
    <cfset variables.DataEntryType = "%Spreadsheet%">
</cfif>

<cfset variables.C1 = "%#ltrim(rtrim(GetUnitInfo.C1))#%">
<cfset variables.C4 = "%,#ltrim(rtrim(GetUnitInfo.C4))#,%">

<cfStoredProc Datasource="#application.SQLSource#" Procedure="Get_FinishUpErrMsg">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_VarChar" dbvarname="@DataEntryType" value="#variables.DataEntryType#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_VarChar" dbvarname="@C1" value="#variables.C1#">
	<cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@C4" value="#Variables.C4#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFinishUpErrMsgRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFinishUpErrMsgRetMsg">
	<cfprocresult name="GetFinishUpErrMsg">
</cfstoredproc>

<!--- Remove the warning messages received the last time the user came to this page --->
<cfStoredProc Datasource="#application.SQLSource#" Procedure="Del_LocGovErrMsg">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="DelLocGovErrMsgRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="DelLocGovErrMsgRetMsg">
	<cfprocresult name="DelLocGovErrMsg">
</cfstoredproc>

<cfloop query="GetFinishUpErrMsg">
	<cfset variables.ErrorNo=#GetFinishUpErrMsg.ErrorNo#>
	<cfset variables.Heading=#GetFinishUpErrMsg.Heading#>
    <cfset variables.ShowstopperTest ="#GetFinishUpErrMsg.Showstopper#">
	<cfset variables.Err_Msg_Blink1=#GetFinishUpErrMsg.Err_Msg_Blink1#>
	<cfset variables.CalcAmt1=#GetFinishUpErrMsg.CalcAmt1#>	
	<cfset variables.BCalcTxt1=#GetFinishUpErrMsg.BCalcTxt1#>	
	<cfset variables.ACalcTxt1=#GetFinishUpErrMsg.ACalcTxt1#>
	<cfset variables.CalcAmt2=#GetFinishUpErrMsg.CalcAmt2#>	
	<cfset variables.BCalcTxt2=#GetFinishUpErrMsg.BCalcTxt2#>	
	<cfset variables.ACalcTxt2=#GetFinishUpErrMsg.ACalcTxt2#>
	<cfset variables.CalcAmt3=#GetFinishUpErrMsg.CalcAmt3#>	
	<cfset variables.BCalcTxt3=#GetFinishUpErrMsg.BCalcTxt3#>	
	<cfset variables.ACalcTxt3=#GetFinishUpErrMsg.ACalcTxt3#>
	<cfset variables.CalcAmt4=#GetFinishUpErrMsg.CalcAmt4#>	
	<cfset variables.BCalcTxt4=#GetFinishUpErrMsg.BCalcTxt4#>	
	<cfset variables.ACalcTxt4=#GetFinishUpErrMsg.ACalcTxt4#>
	<cfset variables.LinkMsg1=#GetFinishUpErrMsg.LinkMsg1#>
	<cfset variables.link1=#GetFinishUpErrMsg.link1#>
	<cfset variables.AdminDiff1= #GetFinishUpErrMsg.AdminDiff1#>
	<cfset variables.Err_Msg_Alink1=#GetFinishUpErrMsg.Err_Msg_Alink1#>
	<cfset variables.Err_Msg_Blink2=#GetFinishUpErrMsg.Err_Msg_Blink2#>
	<cfset variables.LinkMsg2=#GetFinishUpErrMsg.LinkMsg2#>
	<cfset variables.link2=#GetFinishUpErrMsg.link2#>
	<cfset variables.AdminDiff2 = #GetFinishUpErrMsg.AdminDiff2#>
	<cfset variables.Err_Msg_Alink2=#GetFinishUpErrMsg.Err_Msg_Alink2#>
	<cfset variables.Err_Msg_Blink3=#GetFinishUpErrMsg.Err_Msg_Blink3#>
	<cfset variables.LinkMsg3=#GetFinishUpErrMsg.LinkMsg3#>
	<cfset variables.link3=#GetFinishUpErrMsg.link3#>
	<cfset variables.AdminDiff3 = #GetFinishUpErrMsg.AdminDiff3#>
	<cfset variables.Err_Msg_Alink3=#GetFinishUpErrMsg.Err_Msg_Alink3#>

	<cfStoredProc Datasource="#application.SQLSource#" Procedure="#StoredProcedure#">
		<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
		<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
		<cfprocparam type="In"  cfsqltype="CF_SQL_VarChar" dbvarname="@C1" value="#GetUnitInfo.C1#">
		<cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@C4" value="#GetUnitInfo.C4#">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@HRetVal1" variable="HRetVal1#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_char" dbvarname="@HRetValType1" variable="HRetValType1#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@HRetVal2" variable="HRetVal2#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_char" dbvarname="@HRetValType2" variable="HRetValType2#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetVal1" variable="RetVal1#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_char" dbvarname="@RetValType1" variable="RetValType1#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetVal2" variable="RetVal2#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_char" dbvarname="@RetValType2" variable="RetValType2#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetVal3" variable="RetVal3#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_char" dbvarname="@RetValType3" variable="RetValType3#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetVal4" variable="RetVal4#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_char" dbvarname="@RetValType4" variable="RetValType4#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetVal5" variable="RetVal5#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_char" dbvarname="@RetValType5" variable="RetValType5#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetVal6" variable="RetVal6#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_char" dbvarname="@RetValType6" variable="RetValType6#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_char" dbvarname="@ShowStopper" variable="ShowStopper#StoredProcedure#">
		<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="#StoredProcedure#RetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="#StoredProcedure#RetMsg">
		<cfprocresult name="#StoredProcedure#">
	</cfstoredproc>
	
	<cfif Evaluate("#StoredProcedure#RetVal") eq 1>
	
		<!--- Store the warning messages received in the UnitErrors table --->
		<cfStoredProc Datasource="#application.SQLSource#" Procedure="Add_LocGovErrMsg">
			<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
			<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
			<cfprocparam type="In"  cfsqltype="CF_SQL_VARCHAR" dbvarname="@ErrorNo" value="#variables.ErrorNo#">
			<cfprocparam type="In"  cfsqltype="CF_SQL_Date" dbvarname="@DateEntered" value="#DateFormat(NOW(), "MM/DD/YY")#">
			<cfprocparam type="In"  cfsqltype="CF_SQL_VarChar" dbvarname="@EnteredBy" value="#url.Code#">
			<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="AddLocGovErrMsgRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="AddLocGovErrMsgRetMsg">
			<cfprocresult name="AddLocGovErrMsg">
		</cfstoredproc>
	</cfif>		
	
</cfloop>
</cfoutput>
</cfLock>
</body>
</html>