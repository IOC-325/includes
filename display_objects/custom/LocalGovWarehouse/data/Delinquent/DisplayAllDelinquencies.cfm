<html>
<!--- 
Date CReated: 11/14/2013
CReated By: Gary Ashbaugh
Description: Displays the delinquent instruments for a particular government
--->
<cflock scope="session" TIMEOUT="1000">

<cftry>
<cfStoredProc datasource="AFRUAT" Procedure="Get_WHAllDelinquency">
   <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetDelinquencyInfoRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetDelinquencyInfoRetMsg">
    <cfprocresult name="GetDelinquencyInfo">
</cfstoredproc>
<cfcatch type="any">
<b>Sorry, Could not get Delinquency Information</b>
</cfcatch>
</cftry>

<cfset TmpCounty="">
<cfset TmpCode="">
<cfset TmpFY="">
<cfset TmpCount=0>
<cfset TotDelq = 0>

<body>
<center>
<table border="1" style="border-style:ridge" width="50%">
<tr><td width="90%"><center><b><font size="+2">Local Government Division - Delinquent Units</font></b></center></td></tr>
</table>
</center>
<br>
<table border="0" width="95%">
<tr><td width="55%">&nbsp;</td>
<td width="35%"><cfoutput>#DateFormat(now(),"dddd, mmmm dd, YYYY")# #TimeFormat(now(),"hh:MM:SS tt")#</cfoutput></td>
</tr>
</table>
<table width="95%" border="0" cellspacing="1">
<cfoutput query="GetDelinquencyInfo">
<cfset TotDelq = TotDelq + 1>
<cfif GetDelinquencyInfo.recordcount>
	<cfif TmpCounty is not GetDelinquencyInfo.CountyMixed>
    	<cfif TmpCount Gt 0>
    		<tr><td colspan="9"><hr color="##999999" /></td></tr>
        </cfif>
    <tr><td colspan="9"><center><b>#GetDelinquencyInfo.CountyMixed# County</b></center></td></tr>
    <cfset TmpCounty="#GetDelinquencyInfo.CountyMixed#">
    <cfset TmpCode="">
	<cfset TmpFY="">
    </cfif>
    <cfif TmpCode is not GetDelinquencyInfo.Code>
    <tr>
    <td width="10%"><b>Code</b></td>
    <td width="30%" colspan="2"><b>Unit Name</b></td>
    </tr>
    <tr><Td colspan="9"><hr color="##666666" /></td><tr>
    <tr>
    <td width="10%"><b>#GetDelinquencyInfo.Code#<cfset TmpCode = "#GetDelinquencyInfo.Code#"> </b></td>
    <td width="30%" colspan="2"><b>#GetDelinquencyInfo.UnitName# #Description#</b></td>
    </tr>
    <tr>
    	<td width="10%">&nbsp;</td>
    	<td width="15%">&nbsp;</td>
        <td width="15%">&nbsp;</td>
    	<td><b><br /><br /><u>FY&nbsp;&nbsp;&nbsp;&nbsp;</u></b></td>
    	<td width="25%"><b><br /><br /><u>Instrument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></b></td>
        <td><b><br /><br /><u>FYEnd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></b></td>
        <td><b><br /><br /><u>Extension</u></b></td>
        <td><b>Final<br />Due<br /><u>Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></b></td>
        <td><b><br />Awaiting<br /><u>Approval</u></b></td>
    </tr>
    </cfif>
	<cfset TmpPending = "N">

    
    	<cfif C5 is '1' and trim(Instrument) is "Annual Audits">
            <cfStoredProc datasource="#application.sqlsource#" Procedure="Check_AuditRptApproval">
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(GetDelinquencyInfo.Code)#">
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" value="#trim(GetDelinquencyInfo.FY)#">
                <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckAuditRptApprovalRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckAuditRptApprovalRetMsg">
                <cfprocresult name="CheckAuditRptApproval">
            </cfstoredproc>
            
            <cfif CheckAuditRptApproval.recordcount gt 0>
            	<cfset TmpPending = "Y">
            <cfelse>
            	<cfset TmpPending = "N">
            </cfif>
        <cfelseif C5 is '7'>
        	<cfStoredProc datasource="#application.sqlsource#" Procedure="Check_TIFRptApproval">
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(GetDelinquencyInfo.Code)#">
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" value="#trim(GetDelinquencyInfo.FY)#">
                <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Instrument" value="#trim(GetDelinquencyInfo.Instrument)#">
                <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckTIFRptApprovalRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckTIFRptApprovalRetMsg">
                <cfprocresult name="CheckTIFRptApproval">
            </cfstoredproc>
            
            <cfif CheckTIFRptApproval.recordcount gt 0>
            	<cfset TmpPending = "Y">
            <cfelse>
            	<cfset TmpPending = "N">
            </cfif>
        </cfif>
        <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    	<td>#FY#</td>
    	<td>#Instrument#</td>
        <td>#DateFormat(FYEnd,"mm/dd/yyyy")#</td>
        <td><center>#Extension#</center></td>
        <td>#DateFormat(FinalDueDate,"mm/dd/yyyy")#</td>
        <td><center>#TmpPending#</center></td>
    	</tr>
	<cfset TmpCount = TmpCount +1>
</cfif>
 </cfoutput>
 <tr><td colspan="9">&nbsp;</td></tr>
 <tr><td colspan="9"><hr color="#CCCCCC">
 <tr><td colspan="9"><b>Total Delinquency Reports: <cfoutput>#NumberFormat(TotDelq,"999,999,999")#</cfoutput></b></td></tr> 
</cflock>
</table>
</body>

</html>

