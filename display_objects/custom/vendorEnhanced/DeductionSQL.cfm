<!---
Modified Date: 4-27-12
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Enhanced Vendor Remittance Site per SR11108 based on the regular site but requiring a UserID/Password
--->

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">

<cfinclude template="TmpVendorapplicationSettings.cfm">
<cfif (not isdefined("Session.VendTIN"))>
	<!--- Calls Index from VendorEnhanced --->
    <!--- Development & Production --->
    <cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>
</cfLock>
<cfparam name="MostRecent" default="Y">

<cftry>
<!---<cfset SortOrder = "#SortBy# " & "#AscDesc#, Employee_Name">--->
<cfif SortBy is not "Employee_Name">
	<cfset SortOrder = "#SortBy# " & "#AscDesc#, Employee_Name">
<cfelse>
	<cfset SortOrder = "#SortBy# " & "#AscDesc#">
</cfif>
<cfif MostRecent is not "Y">
	<!---<cfif DateFormat(endDate,"mm/dd/yyyy") gt DateFormat(DateAdd("d",1,now()),"mm/dd/yyyy")>
        <cfset TmpEndDate = "#DateFormat(DateAdd("D",1,now()),"mm/dd/yyyy")#">
   	<cfelse>--->
    	<cfset TmpEndDate = "#DateFormat(EndDate,"mm/dd/yyyy")#">
    <!---</cfif>--->

	<cfStoredProc  datasource="Deductions" Procedure="Get_Deduction">
       	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@Comp_Code" value="#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
        <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Actual_Code" value="#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">
        <cfprocparam type="In"  cfsqltype="cf_sql_date" dbvarname="@Begin_Issue_Date" value="#DateFormat(StartDate,"mm/dd/yyyy")#">
        <cfprocparam type="In"  cfsqltype="cf_sql_date" dbvarname="@Last_Issue_Date" value="#DateFormat(TmpEndDate,"mm/dd/yyyy")#">
        <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SortOrder" value="#SortOrder#">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetDeductionRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetDeductionRetMsg">
        <cfprocresult name="GetDeduction">
    </cfstoredproc>
	
<cfelse>
    <cfStoredProc  datasource="Deductions" Procedure="Get_Deduction">
        <cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@Comp_Code" value="#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
        <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Actual_Code" value="#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">
        <cfprocparam type="In"  cfsqltype="cf_sql_date" dbvarname="@Begin_Issue_Date" null="Yes">
        <cfprocparam type="In"  cfsqltype="cf_sql_date" dbvarname="@Last_Issue_Date" null="yes">       
        <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SortOrder" value="#SortOrder#">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetDeductionRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetDeductionRetMsg">
        <cfprocresult name="GetDeduction">
    </cfstoredproc>
    
</cfif>

<cfcatch type="any">
<b>Sorry, there appears to be a problem..please try back later!</b>
</cfcatch>
</cftry>