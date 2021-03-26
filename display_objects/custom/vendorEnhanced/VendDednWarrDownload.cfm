
<!---
Modified Date: 11-10-15
	Modified By: Gary Ashbaugh
	Modifications Made: Created a CSV Download for the Warrant page
--->

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">

<cfif not isdefined("Session.VendTIN")>
	<cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>

</cfLock>

<CFSET Area = "DeductionDownloadForm">

<!---<CFINCLUDE TEMPLATE="VendHeader.cfm">--->


<CFIF IsDefined ("form.SortBy")>
  <CFSET SortBy = form.SortBy>  
<cfelseif IsDefined ("url.SortBy")>
 <CFSET SortBy = URL.SortBy>
</CFIF>
<CFIF IsDefined ("form.AscDesc")>
 <CFSET AscDesc = form.AscDesc>
<cfelseif IsDefined ("URL.AscDesc")>
 <CFSET AscDesc = URL.AscDesc>
</CFIF>


<!--- ***************************************************************** --->
<!--- *                   CSV File                                    * --->
<!--- ***************************************************************** --->

	<cfset TmpSortOrder="#urlDecode(SortBy)# #AscDesc#, Employee_Name">
    <cfset TmpCompCode = "#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
    <cfset TmpActualCode = "#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">

	<cftry>
<cfStoredProc  datasource="Deductions" Procedure="Get_DeductionByWarrant">
    <cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@Comp_Code" value="#TmpCompCode#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Actual_Code" value="#TmpActualCode#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Trailer_Warrant_Number" value="#form.Warrant#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Trailer_Warrant_Trace" value="#form.Trace#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SortOrder" value="#TmpSortOrder#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetDeductionByWarrantRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetDeductionByWarrantRetMsg">
    <cfprocresult name="GetDeductionByWarrant">
</cfstoredproc>
<cfcatch type="any">
<b>Sorry, there appears to be a problem..please try back later!</b>
</cfcatch>
</cftry>

<!---<Cfdump var="#GetDeductionByWarrant#"><cfabort>--->

<cfset TmpFileName = "DedtnWarr" & "_" & #left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),5)# & "_" & #form.Warrant#  & "_" & #form.Trace# & ".xls">
        

    <cfset Counter=0>
    <cfcontent type="application/msexcel">
    <CFSETTING ENABLECFOUTPUTONLY="Yes" SHOWDEBUGOUTPUT="No">
    <cfoutput>
    <cfheader name="Content-Disposition" value="filename=#TmpFileName#.csv">
    <cfif TimeFormat(now(),"medium") GE "12:00:01 AM" and TimeFormat(now(),"medium") lt "9:00:00 AM">WARNING: Not all of the deductions might be included yet since it is before 9:00 AM.</cfif>
    <cfif isdefined("GetDeductionByWarrant")>
        <cfloop query="GetDeductionByWarrant">
            <CFSET Counter = Counter + 1>
            <CFIF Counter IS 1>
                SSN, Name, PP Beginning Date, PP Ending Date, Pay Period Number, Generated Date, Anticipated Direct_Deposit Date, Deduction Amount, Payroll Code, Trailer Code, Deduction Type, Voucher Number, Law Code, Fund, Deposit Warrant Trace, Total Deposit Amount<!---#chr(13)#--->       
                xxx-xx-#Id#, #trim(Employee_Name)#, #DateFormat(PP_Beginning_Date,"mm/dd/yyyy")#, #DateFormat(PP_Ending_Date,"mm/dd/yyyy")#, #NumberFormat(Pay_Period,"09")#, #DateFormat(Work_Date,"mm/dd/yyyy")#, #DateFormat(Issue_Date,"mm/dd/yyyy")#, #NumberFormat(Deduction_Amount,"-99999999.99")#, #NumberFormat(Pay_Code,"09999")#, #Comp_Code#-#Actual_Code#, #Deduction_Type#, #Voucher_Number#, #Law_Code#, #NumberFormat(Fund,"09999")#, #Trailer_Warrant_Number#-#Trailer_Warrant_Trace#, #NumberFormat(Trailer_Warrant_Amount,"-9999999999.99")# <!---#chr(13)#--->
            <cfelse>
                xxx-xx-#Id#, #trim(Employee_Name)#, #DateFormat(PP_Beginning_Date,"mm/dd/yyyy")#, #DateFormat(PP_Ending_Date,"mm/dd/yyyy")#, #NumberFormat(Pay_Period,"09")#, #DateFormat(Work_Date,"mm/dd/yyyy")#, #DateFormat(Issue_Date,"mm/dd/yyyy")#, #NumberFormat(Deduction_Amount,"-99999999.99")#, #NumberFormat(Pay_Code,"09999")#, #Comp_Code#-#Actual_Code#, #Deduction_Type#, #Voucher_Number#, #Law_Code#, #NumberFormat(Fund,"09999")#, #Trailer_Warrant_Number#-#Trailer_Warrant_Trace#, #NumberFormat(Trailer_Warrant_Amount,"-9999999999.99")# <!---#chr(13)#--->
            </CFIF>
        </cfloop> 
    <cfelse>
    	No Deductions for selected criteria
    </cfif> 
    </cfoutput>      
 
	<cfabort>

 
 <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    
