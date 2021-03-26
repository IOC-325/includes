<!---
Date CReated: 11/14/2013
CReated By: Gary Ashbaugh
Description: Displays the delinquent instruments for a particular government
--->

<cfparam name="url.Code" default="">

<cflock scope="session" TIMEOUT="1000">

<cfif url.Code is "">
	<b>You must supply a unit of government</b>
    <cfabort>
</cfif>

<cftry>
<cfStoredProc datasource="AFRUAT" Procedure="Get_WHDelinquency">
    <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(url.Code)#">
    <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" null="yes">
     <cfprocparam type="in" cfsqltype="cf_sql_nvarchar" dbvarname="@County" null="yes">
    <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetDelinquencyInfoRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetDelinquencyInfoRetMsg">
    <cfprocresult name="GetDelinquencyInfo">
</cfstoredproc>
<cfcatch type="any">
<b>Sorry, Could not get Delinquency Information</b>
</cfcatch>
</cftry>
<table class="table table-bordered table-white margintop">
<cfif GetDelinquencyInfo.recordcount>
	<cfset TmpPending = "N">
        <tr>
            <td class="text-center"><b>FY</b></td>
            <td align="left"><b>Instrument</b></td>
            <td align="left"><b>FYEnd</b></td>
            <td class="text-center"><b>Extension</b></td>
            <td align="left"><b>Final Due Date</b></td>
            <td class="text-center"><b>Awaiting Approval</b></td>
        </tr>
    <cfoutput query="GetDelinquencyInfo">
    	<cfif C5 is '1' and trim(Instrument) is "Annual Audits">
            <cfStoredProc datasource="#application.sqlsource#" Procedure="Check_AuditRptApproval">
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(url.Code)#">
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
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(url.Code)#">
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
            <td class="text-center">#FY#</td>
            <td>#Instrument#</td>
            <td>#DateFormat(FYEnd, "mm/dd/yyyy")#</td>
            <td class="text-center">#Extension#</td>
            <td>#DateFormat(FinalDueDate, "mm/dd/yyyy")#</td>
            <td class="text-center">#TmpPending#</td>
        </tr>
    </cfoutput>
<cfelse>
    <tr><td>Unit of Government is not Delinquent</td></tr>
</cfif>
</table>

</cflock>

