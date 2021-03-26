<html>
<!--- 
Date CReated: 11/14/2013
CReated By: Gary Ashbaugh
Description: Displays the delinquent instruments for a particular government
--->
<cflock scope="session" TIMEOUT="1000">

<cftry>
<cfStoredProc datasource="#application.sqlsource#" Procedure="Get_WHAllDelinquency">
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
<cfdocument format="pdf" encryption="128-bit" permissions="allowprinting" orientation="portrait" marginleft=".5" marginbottom=".5" marginright=".5" margintop=".5">
<center>
<table border="1" style="border-style:ridge" width="100%">
<tr><td><center><b><font face="Verdana, Geneva, sans-serif" pointsize="18">Local Government Division - Delinquent Units</font></b></center></td></tr>
</table>
</center>
<br>
<table border="0" width="95%">
<tr><td width="45%">&nbsp;</td>
<td width="55%"><font face="Verdana, Geneva, sans-serif" pointsize="8"><cfoutput>#DateFormat(now(),"dddd, mmmm dd, YYYY")# #TimeFormat(now(),"hh:MM:SS tt")#</cfoutput></font></td>
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
    <tr><td colspan="9"><center><font face="Verdana, Geneva, sans-serif" pointsize="14"><b>#GetDelinquencyInfo.CountyMixed# County</b></font></center></td></tr>
    <cfset TmpCounty="#GetDelinquencyInfo.CountyMixed#">
    <cfset TmpCode="">
	<cfset TmpFY="">
    </cfif>
    <cfif TmpCode is not GetDelinquencyInfo.Code>
    <tr><Td>&nbsp;</Td></tr>
    <tr>
    <td width="15%"><font face="Verdana, Geneva, sans-serif" pointsize="9"><b>Code</b></font></td>
    <td width="50%" colspan="8"><font face="Verdana, Geneva, sans-serif" pointsize="9"><b>Unit Name</b></font></td>
    </tr>
    <tr><Td colspan="9"><hr color="##666666" /></td><tr>
    <tr valign="top">
    <td width="10%"><b>#GetDelinquencyInfo.Code#<cfset TmpCode = "#GetDelinquencyInfo.Code#"> </b></td>
    <td width="90%" colspan="9"><font face="Verdana, Geneva, sans-serif" pointsize="9"><b>#GetDelinquencyInfo.UnitName# #Description#</b></font></td>
    </tr>
    <tr><td colspan="10">&nbsp;</td></tr>
    <tr valign="top">
    	<td width="5%">&nbsp;</td>
    	<td width="5%">&nbsp;</td>
        <td width="5%">&nbsp;</td>
    	<td width="10%"><b><br /><br /><u>FY&nbsp;&nbsp;&nbsp;&nbsp;</u></b></td>
        <td>&nbsp;</td>
    	<td width="20%"><font face="Verdana, Geneva, sans-serif" pointsize="9"><b><br /><br /><u>Instrument&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></b></font></td>
        <td>&nbsp;</td>
        <td width="15%"><font face="Verdana, Geneva, sans-serif" pointsize="9"><b><br /><br /><u>FYEnd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></b></font></td>
        <td>&nbsp;</td>
        <td width="15%"><font face="Verdana, Geneva, sans-serif" pointsize="9"><b><br /><br /><u>Ext</u></b></font></td>
        <td>&nbsp;</td>
        <td width="15%"><font face="Verdana, Geneva, sans-serif" pointsize="9"><b>Final<br />Due<br /><u>Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></b></font></td>
        <td>&nbsp;</td>
        <td width="10%"><font face="Verdana, Geneva, sans-serif" pointsize="9"><b>Uploaded<br />Awaiting<br /><u>Approval</u></b></font></td>
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
        <tr valign="top">
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    	<td><font face="Verdana, Geneva, sans-serif" pointsize="8">#FY#</font></td>
        <td>&nbsp;</td>
    	<td><font face="Verdana, Geneva, sans-serif" pointsize="8">#Instrument#</font></td>
        <td>&nbsp;</td>
        <td><font face="Verdana, Geneva, sans-serif" pointsize="8">#DateFormat(FYEnd,"mm/dd/yyyy")#</font></td>
        <td>&nbsp;</td>
        <td><font face="Verdana, Geneva, sans-serif" pointsize="8"><center>#Extension#</center></font></td>
        <td>&nbsp;</td>
        <td><font face="Verdana, Geneva, sans-serif" pointsize="8">#DateFormat(FinalDueDate,"mm/dd/yyyy")#</font></td>
        <td>&nbsp;</td>
        <td><font face="Verdana, Geneva, sans-serif" pointsize="8"><center>#TmpPending#</center></font></td>
    	</tr>
	<cfset TmpCount = TmpCount +1>
</cfif>
 </cfoutput>
 <tr><td colspan="9">&nbsp;</td></tr>
 <tr><td colspan="9"><hr color="#CCCCCC">
 <tr><td colspan="9"><font face="Verdana, Geneva, sans-serif" pointsize="9"><b>Total Delinquency Reports: <cfoutput>#NumberFormat(TotDelq,"999,999,999")#</cfoutput></b></font></td></tr> 

</table>
<br>
<cfdocumentitem type="footer"> 
<div align="center"><font color="navy" pointsize="8" face="Verdana, Geneva, sans-serif">Delinquency Report created from the Illinois Office of the Comptroller's Local Government Warehouse - <cfoutput>#cfdocument.currentpagenumber# of #cfdocument.totalpagecount#</cfoutput></font>
</div><br>
 
</cfdocumentitem >
</cfdocument>

</body>
</cflock>
</html>

