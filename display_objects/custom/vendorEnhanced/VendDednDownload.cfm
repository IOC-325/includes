
<!---
Modified Date: 10-14-14
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Deduction site per SR 14136
--->

<CFIF IsDefined ("form.SortBy")>
 <CFSET SortBy = form.SortBy>
<cfelseif IsDefined ("URL.SortBy")>
 <CFSET SortBy = URL.SortBy>
</CFIF>
<CFIF IsDefined ("form.AscDesc")>
 <CFSET AscDesc = form.AscDesc>
<cfelseif IsDefined ("URL.AscDesc")>
 <CFSET AscDesc = URL.AscDesc>
</CFIF>

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">

<cfif not isdefined("Session.VendTIN")>
	<cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>

</cfLock>

<CFSET Area = "DeductionDownloadForm">

<!---<CFINCLUDE TEMPLATE="VendHeader.cfm">--->



<!--- ***************************************************************** --->
<!--- *                   CSV File                                    * --->
<!--- ***************************************************************** --->

	<!---<cfset TmpSortOrder = "Generated_Date, Issue_Date, Name">--->
    <cfset TmpSortOrder="#urlDecode(SortBy)# #AscDesc#, Employee_Name">
	<cfif form.MostRecent is not "Y">

    	<!--- Excel Spreadsheet by Issue_Date range--->
		<cfoutput>
        <cfStoredProc  datasource="Deductions" Procedure="Get_CSVDeduction">
            <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Comp_Code" value="#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
            <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Actual_Code" value="#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">
            <cfprocparam type="In"  cfsqltype="CF_SQL_date" dbvarname="@Begin_Issue_Date" value="#form.StartDate#">
             <cfprocparam type="In"  cfsqltype="CF_SQL_date" dbvarname="@Last_Issue_Date" value="#form.EndDate#">
           	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SortOrder" value="#TmpSortOrder#">
          	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCSVDeductionRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCSVDeductionRetMsg">
            <cfprocresult name="GetCSVDeduction1">
        </cfstoredproc>


		<cfset TmpFileName = "Dedtn" & "_" & #left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),5)#  & "_" & #DateFormat(form.StartDate,"mm_dd")#  & "_" & #DateFormat(form.EndDate,"mm_dd")# & ".xls">
   		</cfoutput>
     <cfelse>
     	<!--- Excel Spreadsheet containing Most Recent deductions --->
    	<cfoutput>
        <cfStoredProc  datasource="Deductions" Procedure="Get_CSVDeduction">
            <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Comp_Code" value="#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
            <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Actual_Code" value="#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">
        	<cfprocparam type="In"  cfsqltype="cf_sql_date" dbvarname="@Begin_Issue_Date" null="yes">
        	<cfprocparam type="In"  cfsqltype="cf_sql_date" dbvarname="@Last_Issue_Date" null="yes">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SortOrder" value="#TmpSortOrder#">
        	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCSVDeductionRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCSVDeductionRetMsg">
            <cfprocresult name="GetCSVDeduction1">
        </cfstoredproc>



		<cfset TmpFileName = "Dedtn" & "_" & #left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),5)# & ".xls">
       	</cfoutput>

     </cfif>

    <cfset Counter=0>
    <cfcontent type="application/msexcel">
    <CFSETTING ENABLECFOUTPUTONLY="Yes" SHOWDEBUGOUTPUT="No">
  <!---  <cfsetting enablecfoutputonly="yes">--->
    <!---<cfprocessingdirective suppresswhitespace="yes">--->
    <cfoutput>
    <cfheader name="Content-Disposition" value="filename=#TmpFileName#.csv">
     <cfif TimeFormat(now(),"medium") GE "12:00:01 AM" and TimeFormat(now(),"medium") lt "9:00:00 AM">WARNING: Not all of the deductions might be included yet since it is before 9:00 AM.</cfif>
    <cfif isdefined("GetCSVDeduction1")>
        <cfloop query="GetCSVDeduction1">
            <CFSET Counter = Counter + 1>
            <CFIF Counter IS 1>
                SSN, Name, PP Beginning Date, PP Ending Date, Pay Period Number, Generated Date, Anticipated Direct_Deposit Date, Deduction Amount, Payroll Code, Trailer Code, Deduction Type, Voucher Number, Law Code, Fund, Deposit Warrant Trace, Total Deposit Amount<!---#chr(13)#--->
                xxx-xx-#SSN#, #trim(Name)#, #DateFormat(PP_Beginning_Date,"mm/dd/yyyy")#, #DateFormat(PP_Ending_Date,"mm/dd/yyyy")#, #NumberFormat(Pay_Period_Number,"09")#, #DateFormat(Generated_Date,"mm/dd/yyyy")#, #DateFormat(Anticipated_Direct_Deposit_Date,"mm/dd/yyyy")#, #NumberFormat(Deduction_Amount,"-99999999.99")#, #Payroll_Code#, #Trailer_Code#, #Deduction_Type#, #Voucher_Number#, #Law_Code#, #NumberFormat(Fund,"09999")#, #Deposit_Warrant_Trace#, #NumberFormat(Total_Deposit_Amount,"-9999999999.99")# <!---#chr(13)#--->
            <cfelse>
                xxx-xx-#SSN#, #trim(Name)#, #DateFormat(PP_Beginning_Date,"mm/dd/yyyy")#, #DateFormat(PP_Ending_Date,"mm/dd/yyyy")#, #NumberFormat(Pay_Period_Number,"09")#, #DateFormat(Generated_Date,"mm/dd/yyyy")#, #DateFormat(Anticipated_Direct_Deposit_Date,"mm/dd/yyyy")#, #NumberFormat(Deduction_Amount,"-99999999.99")#, #Payroll_Code#, #Trailer_Code#, #Deduction_Type#, #Voucher_Number#, #Law_Code#, #NumberFormat(Fund,"09999")#, #Deposit_Warrant_Trace#, #NumberFormat(Total_Deposit_Amount,"-9999999999.99")# <!---#chr(13)#--->
            </CFIF>
        </cfloop>
    <cfelse>
    	No Deductions for selected criteria
    </cfif>
    </cfoutput>
    <!---</cfprocessingdirective>--->
	<cfabort>


 <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>

