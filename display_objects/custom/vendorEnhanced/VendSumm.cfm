<cfif IsDefined("form.mode") && form.mode is "Register">
        <cflocation url="/vendors/enhanced-vendor-remittance/enhanced-vendor-registration/" addtoken="No">
</cfif>


<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

<!---
Modified Date: 4-27-12
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Enhanced Vendor Remittance Site per SR11108 based on the regular site but requiring a UserID/Password

Modification Date: 11-7-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site

Description:  The page shows the user summary information for his/her Vendor's Contract and Payments
--->

<cfparam name="Session.Vendor_Name" default="">


<CFIF IsDefined ("URL.VALUSER")>
 <CFSET VALUSER = URL.VALUSER>
<cfelseif IsDefined ("form.VALUSER")>
 <CFSET VALUSER = form.VALUSER>
<cfelseif IsDefined ("VALUSER")>
 <CFSET VALUSER = VALUSER>
</CFIF>

<CFIF IsDefined ("URL.FORMTYPE")>
 <CFSET FORMTYPE = URL.FORMTYPE>
<cfelseif IsDefined ("form.FORMTYPE")>
 <CFSET FORMTYPE = form.FORMTYPE>
<cfelseif IsDefined ("FORMTYPE")>
 <CFSET FORMTYPE = FORMTYPE>
</CFIF>

<CFIF IsDefined ("URL.VendorSelected")>
 <CFSET VendorSelected = URL.VendorSelected>
<cfelseif IsDefined ("form.VendorSelected")>
 <CFSET VendorSelected = form.VendorSelected>
<cfelseif IsDefined ("VendorSelected")>
 <CFSET VendorSelected = VendorSelected>
</CFIF>

<CFIF IsDefined ("URL.SelectVendor")>
 <CFSET SelectVendor = URL.SelectVendor>
<cfelseif IsDefined ("form.SelectVendor")>
 <CFSET SelectVendor = form.SelectVendor>
<cfelseif IsDefined ("SelectVendor")>
 <CFSET SelectVendor = SelectVendor>
</CFIF>

<!--- <cfif IsDefined ("form.IOCID")>
    <cfdump var="#decrypt(form.IOCID, application.theKey, application.theAlgor, application.TheEncode)#">
</cfif>
<cfdump var="#form#" abort="true"> --->

<cfif IsDefined ("form.IOCID") && IsDefined ("form.Number_Code")>
    <CFSET VendorSelected = decrypt(form.IOCID, application.theKey, application.theAlgor, application.TheEncode)>
    <CFSET VendorSelected = VendorSelected & form.Number_Code>
    <CFSET SelectVendor = "Select">
    <cfset Session.Email = "#form.VENDTIN#">
    <cfset Session.Number_Code = "#form.Number_Code#">

</CFIF>

<!--- <cfif isDefined("VendorSelected")>
 <cfdump var="#VendorSelected#">
</cfif> 
<cfdump var="#Session.VendTIN#">
<cfdump var="#form#">
--->



 <!--- Remove when application.cfc gets fixed --->
<cfinclude template="TmpVendorapplicationSettings.cfm">
<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<cfif not isdefined("VALUSER")>
	<!--- Calls Index from VendorEnhanced --->
	<cflocation url="/vendors/" addtoken="No">
</cfif>

<cfif isdefined("SelectVendor")>

	<cfif trim(VendorSelected) is not "">
        <CFLOCK SCOPE="Session" timeout="10">
        <cfoutput>
        <Cfset Session.VendTIN = "#encrypt(left(VendorSelected,len(VendorSelected)-1), application.theKey, application.theAlgor, application.TheEncode)#">
        <!---
        <cfif right(VendorSelected,1) is "X">
        	<cfset Session.Deduction = "N">
        <cfelse>
        	<cfset Session.Deduction = "Y">
		</cfif>
		--->
        

        <cfStoredProc  datasource="Deductions" Procedure="Get_MaxDeductionEndDt">
            <cfprocparam type="Out"  cfsqltype="CF_SQL_Date" dbvarname="@MaxIssue_Date" variable="GetMaxIssue_Date">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetMaxDeductionEndDtRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetMaxDeductionEndDtRetMsg">
            <cfprocresult name="GetMaxDeductionEndDt">
        </cfstoredproc>     

        <cfif right(VendorSelected,1) is "4">
        	<cfset Session.Deduction = "Y">
        	<cfset Session.Number_Code = "4">
            <cfset Session.Vendor_Name="X">
<cfdump  var="#application.vendorpayments#">
            <!--- <cfset Session.AdmLevel = "User"> --->
            <cfStoredProc  datasource="#application.VendorPayments#" Procedure="Get_VendorUserInfo">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@TaxpayerIdNo" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@EMail" value="#trim(Session.EMail)#">
                <cfif trim(Session.Number_Code) is "4">
                    <cfprocparam type="In"  cfsqltype="CF_SQL_char"  dbvarname="@Number_Code" value="#trim(Session.Number_Code)#">
                <cfelse>
                    <cfprocparam type="In"  cfsqltype="CF_SQL_char"  dbvarname="@Number_Code" null="yes">
                </cfif>
                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetVendorUserInfoRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GerVendorUserInfoRetMsg">
                <cfprocresult name="GetVendorUserInfo">
            </cfstoredproc>

            <cfif GetVendorUserInfo.VendorAdmin is "Y">
                <cfset Session.AdmLevel = "Coordinator">
            <cfelse>
                <cfset Session.AdmLevel = "User">
            </cfif>
                    
            <!--- <cflocation url="/vendors/enhanced-vendor-remittance/vendor-deduction-form/" addtoken="no"> --->
            <cflocation url="/vendors/enhanced-vendor-remittance/deduction-list/?Mode=Summ&ValUser=True&AscDesc=Desc&LastRecentDate=#DateFormat(GetMaxIssue_Date,"mm/dd/yyyy")#&max=20&MostRecent=Y&SortBy=Issue_Date&MostRecentDate=" addtoken="no">
        <cfelse>
        	<cfset Session.Deduction = "N">
        	<cfset Session.Number_Code = "">
            <CFQUERY NAME="GetVendorNm" DATASOURCE="VendorDB2">
                SELECT 	Vendor_TIN,
                        VENDOR_NAME
                FROM #application.whOwner#VENDOR
               <CFLOCK SCOPE="Session" timeout="120" type="readonly">	 where VENDOR_TIN =<cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"></CFLOCK>

            </CFQUERY>
            <cfset Session.Vendor_Name = "#GetVendorNm.Vendor_Name#">
        </cfif>

        <cfStoredProc  datasource="#application.VendorPayments#" Procedure="Get_VendorUserInfo">
        	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@TaxpayerIdNo" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
    		<cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@EMail" value="#trim(Session.EMail)#">
            <cfif trim(Session.Number_Code) is "4">
            	<cfprocparam type="In"  cfsqltype="CF_SQL_char"  dbvarname="@Number_Code" value="#trim(Session.Number_Code)#">
            <cfelse>
            	<cfprocparam type="In"  cfsqltype="CF_SQL_char"  dbvarname="@Number_Code" null="yes">
            </cfif>
   			<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetVendorUserInfoRetVal">
    		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GerVendorUserInfoRetMsg">
    		<cfprocresult name="GetVendorUserInfo">
		</cfstoredproc>

        <cfif GetVendorUserInfo.VendorAdmin is "Y">
        	<cfset Session.AdmLevel = "Coordinator">
        <cfelse>
        	<cfset Session.AdmLevel = "User">
        </cfif>
        <cfif (dateformat(now(),"mm") ge "01") and  (dateformat(now(),"mm") lt "07")>
            <cfset TmpDt = "20" & "#dateformat(now(),"YY")#">
        <cfelse>
            <cfset TmpDt2 = DateAdd("YYYY",1,now())>
            <cfset TmpDt = "20" & "#dateformat(TmpDt2,"YY")#">
        </cfif>        
        <CFQUERY NAME="GetDtRange"  DATASOURCE="VendorDB2"  cachedwithin="#CreateTimeSpan(0,12,0,0)#" >
            SELECT  DISTINCT #application.whOwner#IOC_WARR_HDR.RECORD_DATE
            FROM    #application.whOwner#IOC_WARR_HDR
            WHERE   <CFLOCK SCOPE="Session" timeout="120"  type="readonly">#application.whOwner#IOC_WARR_HDR.VENDOR_TIN =  <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"> </CFLOCK>
                and #application.whOwner#ioc_WARR_HDR.Fiscal_Year = <cfqueryparam cfsqltype="cf_sql_smallint" value="#TmpDt#">
            order by Record_Date desc
            fetch first 1 rows only
        </CFQUERY>
        <cfif trim(GetDtRange.Record_Date) is not "">
            <CFSET varStartDate = DateFormat(dateadd("d",-30,GetDtRange.Record_Date),"mm/dd/yyyy")>
        <cfelse>
           <CFSET varStartDate = DateFormat(dateadd("d",-30,now()),"mm/dd/yyyy")>
        </cfif>            
         <CFSET varEndDate = DateFormat(now(),"mm/dd/yyyy")>

        <cflocation url="/vendors/enhanced-vendor-remittance/vendor-warrant-list/?Mode=Summ&ValUser=True&AscDesc=Desc&Agency=All&Contsel=&StartDate=#varStartDate#&EndDate=#varEndDate#&FY=#application.CFY#&INVSEL=&max=20&SortBy='Record Date'&Status=All" addtoken="no">

        </cfoutput>
        </CFLOCK>
    <cfelse>
       <div class="alert alert-danger" align="left">You must select a vendor from the list before clicking the "Search" button.</div>
    </cfif>
</cfif>
<body>


<cfLock Scope="SESSION" TIMEOUT="120">
<cfif (not isdefined("form.VendTIN")) and (not isdefined("Session.VendTIN"))>


	<!--- Calls Index from VendorEnhanced --->
    <!--- Development & Production --->
	<cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">

<cfelseif isDefined("form.VENDTIN") and isdefined("form.Password") and (formType is "Enhanced") and (ValUser is "False")>

	<cfif trim(form.VENDTIN) is not "" and trim(form.Password) is not "">
        <!---<cftry>--->
        <cfoutput>
        <cfStoredProc  datasource="#application.VendorPayments#" Procedure="Validate_User">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@EMail" value="#trim(form.VENDTIN)#">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@Password" value="#trim(form.Password)#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="ValidateUsersRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="ValidateUserRetMsg">
            <cfprocresult name="ValidateUser">
        </cfstoredproc>

        <cfif ValidateUser.Number_Code is "4">
        	<cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_AccptMiscCode">
                <cfprocparam type="In"  cfsqltype="CF_SQL_char"  dbvarname="@TaxpayerIdNo" value="#ValidateUser.TaxpayerIdNo#">
                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckAccptMiscCodeRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckAccptMiscCodeRetMsg">
            	<cfprocresult name="CheckAccptMiscCode">
        	</cfstoredproc>

            <cfif CheckAccptMiscCodeRetVal gt 0>
            	<cflocation url="/vendors/enhanced-vendor-remittance?InvalidMiscCode=Yes" addtoken="No">
            <cfelseif CheckAccptMiscCode.IOC_Only is "Y" and (not(form.VENDTIN contains "@IllinoisComptroller.Gov"))>
            	<cflocation url="/vendors/enhanced-vendor-remittance?IOCOnlyMiscCode=Yes" addtoken="No">
            </cfif>
        </cfif>

        <cfif ValidateUsersRetVal gt 0>
            <!--- Calls Index from VendorEnhanced --->
            <cflocation url="/vendors/?UserFound=No" addtoken="No">
        <cfelse>

            <cfset Session.Email = "#ValidateUser.Email#">
            <cfset Session.VendTIN = "#encrypt(ValidateUser.TaxpayerIdNo, application.theKey, application.theAlgor, application.TheEncode)#">
            <cfif ValidateUser.VendorAdmin is "Y">
                <cfset Session.AdmLevel = "Coordinator">
            <cfelse>
                <cfset Session.AdmLevel = "User">
            </cfif>

             <cfif ValidateUser.Number_Code is "4">
                <cfset Session.Deduction = "Y">
                <cfset Session.Number_Code = "4">
                <cfset Session.Vendor_Name="X">
             <cfelse>
                <cfset Session.Deduction = "N">
                <cfset Session.Number_Code = "">
            </cfif>

            <cfif ((trim(ValidateUser.DtPasswordChged) is  "") or (DateFormat(ValidateUser.DtPasswordChged,"mm/dd/yyyy") Lt DateFormat(dateadd('d',-30,now()),"mm/dd/yyyy")) or (trim(ValidateUser.Password) is "")) and not (trim(Session.EMail) contains 'IllinoisComptroller.Gov')>
                <!--- Calls ChangePassword from VendorEnhanced --->
                <!--- Development & Production --->

                <cflocation url="/vendors/enhanced-vendor-remittance/change-password/?ChangePasswordRequired=Yes" addtoken="No">
            </cfif>
        </cfif>
        </cfoutput>
        <!---<cfcatch type="any">
            <b><font color="Red">Sorry, but it appears that the site is not available at this time...please try back later!</font></b>
        </cfcatch>
        </cftry>--->
    <cfelse>
        <!--- Call Index from VendorEnhanced --->
        <cflocation url="/vendors/?UserFound=No" addtoken="No">
    </cfif>

<cfelse>

    <cfif (ValUser is not "True")>
    	<!--- Call Index from VendorEnhanced --->
    	<cflocation url="/vendors/?UserFound=No" addtoken="No">
    </cfif>

</cfif>

<cfif isdefined("ValidateUser.Number_Code")>
	<cfif ValidateUser.Number_Code is "4">
        <cfStoredProc  datasource="Deductions" Procedure="Get_MaxDeductionEndDt">
            <cfprocparam type="Out"  cfsqltype="CF_SQL_Date" dbvarname="@MaxIssue_Date" variable="GetMaxIssue_Date">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetMaxDeductionEndDtRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetMaxDeductionEndDtRetMsg">
            <cfprocresult name="GetMaxDeductionEndDt">
        </cfstoredproc>    

		<!--- <cflocation url="/vendors/enhanced-vendor-remittance/vendor-deduction-form/" addtoken="No"> --->
                    <cflocation url="/vendors/enhanced-vendor-remittance/deduction-list/?Mode=Summ&ValUser=True&AscDesc=Desc&LastRecentDate=#DateFormat(GetMaxIssue_Date,"mm/dd/yyyy")#&max=20&MostRecent=Y&SortBy=Issue_Date&MostRecentDate=" addtoken="no">
    </cfif>
</cfif>

</cflock>

<!-- SQL Query -->
<cftry>
<cfoutput>
<CFQUERY NAME="VendVerify"  DATASOURCE="VendorDB2"   cachedwithin="#CreateTimeSpan(1,0,0,0)#">
	SELECT Vendor_TIN
	FROM #application.whOwner#VENDOR
   <cfLock Scope="SESSION" TIMEOUT="120" type="readonly"> where #application.whOwner#VENDOR.Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"> </cfLock>
	GROUP BY #application.whOwner#VENDOR.Vendor_TIN
</CFQUERY>

<CFQUERY NAME="ContSumm" DATASOURCE="VendorDB2"  cachedwithin="#CreateTimeSpan(1,0,0,0)#">
	SELECT
		Sum(CONTRACT_AMT) AS ContTotal,
		Sum(CONTRACT_ENC_AMT) AS ContEncTotal,
		Sum(CONTRACT_EXP_AMT) AS ContExpTotal
	FROM #application.whOwner#SUMM_VEND_CONT_#application.CFY#
    <cfLock Scope="SESSION" TIMEOUT="120" type="readonly"> where #application.whOwner#SUMM_VEND_CONT_#application.CFY#.Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">
    and wh.SUMM_VEND_CONT_#application.CFY#.Transaction_Agency != <cfqueryparam cfsqltype="cf_sql_varchar" value="999">
    </cfLock>
	GROUP BY #application.whOwner#SUMM_VEND_CONT_#application.CFY#.Vendor_TIN
</CFQUERY>

<CFQUERY NAME="ContCount"  DATASOURCE="VendorDB2"  cachedwithin="#CreateTimeSpan(1,0,0,0)#">
	SELECT COUNT(*) AS ContCountNum
	FROM  #application.whOwner#SUMM_VEND_CONT_#application.CFY#
   <cfLock Scope="SESSION" TIMEOUT="120" type="readonly"> where  #application.whOwner#SUMM_VEND_CONT_#application.CFY#.Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"> </cfLock>
</CFQUERY>

<CFQUERY NAME="ExpSumm"  DATASOURCE="VendorDB2"  cachedwithin="#CreateTimeSpan(1,0,0,0)#">
	SELECT
		Sum(ENCUMBERED_AMT) AS EncTotal,
		Sum(EXPENDED_AMT) AS ExpTotal
	FROM #application.whOwner#SUMM_VEND_EXP_#application.CFY#
    <cfLock Scope="SESSION" TIMEOUT="120" type="readonly"> where #application.whOwner#SUMM_VEND_EXP_#application.CFY#.Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"> </cfLock>
	GROUP BY #application.whOwner#SUMM_VEND_EXP_#application.CFY#.Vendor_TIN
</CFQUERY>
</cfoutput>
 <cfcatch type="any">
 </cfcatch>
</cftry>
<!-- End of SQL Query -->

<!-- Send it back to the login if the TIN isn't valid -->
<!---<CFIF (#Mode# is "Login")>
	<CFIF VendVerify.RecordCount eq 0 >
    	<!--- Calls Index in VendorEnhanced --->
		<CFLOCATION URL="/vendors/enhanced-vendor-remittance?NotFound=">
	</CFIF>
</CFIF>
--->

<cfStoredProc  datasource="#application.VendorPayments#" Procedure="Check_EmailTextReturned">
	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@EMail" value="#trim(Session.Email)#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckEmailTextReturnedRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckEmailTextReturnedRetMsg">
    <cfprocresult name="CheckEmailTextReturned">
</cfstoredproc>


<CFSET Area = "Summary">


<CFINCLUDE TEMPLATE="VendHeader.cfm">

<cfif GetVendor.SAMS_Delete_Date is not "">
   <p class="text-center"><b>Vendor Status: No longer on file.  No activity in the past two years.</b></p>
<cfelseif trim(GetVendor.Cert_Ind) is "C">
   <p class="text-center"><b>Vendor Status: Certified</b></p>
<cfelseif trim(GetVendor.Cert_Ind) is "N" or trim(GetVendor.Cert_Ind) is "T">
   <p class="text-center"><b>Vendor Status: On file, but not certified</b></p>
</cfif>

<cfif isdefined("PasswordChanged")>
<div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
    Password Changed!
</div>
</cfif>

<!--- Added on 5-11-16 to stop for Deductions ---->
<cfif Session.Number_Code is "4">
	<cfabort>
</cfif>

<cfif CheckEmailTextReturnedRetVal is 0><cfoutput>
<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
    <cfif trim(CheckEmailTextReturned.DtEmailReturned) is not "">We show that E-Mail #CheckEmailTextReturned.Email# has been marked as not being able to receive E-Mails from us.  Please have your Coordinator correct your E-Mail or contact your Information Technology personnel and let them know of the issue.  Thank You!<br></cfif>

    <cfif trim(CheckEmailTextReturned.DtTextReturned) is not "">We show that your cell phone number (#CheckEmailTextReturned.AreaCode#) #CheckEmailTextReturned.PhonePrefix#-#CheckEmailTextReturned.PhoneSuffix# has been marked as not being able to receive text messages from us.  Please have your Coordinator correct your cell phone number and/or provider.  Thank You!</cfif>
</div></cfoutput>
</cfif>

<!-- Vendor Summary Results Table -->
<cfoutput>
<p id="instructions2">Please note the change to Fiscal Year 20#application.cfy#</p>
<p id="instructions2">To view payment/contract information from FY 20#application.pfy#, be sure to select it from the drop down on the next screen. Thank you.</p>
</cfoutput>

	<!-- Contract Summary -->
    <!--- AS Per SR18123 RK commented the below code --->
        <!---
	<div id="Heading"><p><b>Contracts</b></p></div>

	<CFIF #ContCount.ContCountNum# is "0" >
        <!---<p id="instructions2">--->(No contract information was found for the current Fiscal Year.)<!---</p>--->
    <CFELSE>
		<CFOUTPUT QUERY="ContCount">
            <table class="table table-bordered">
                <tr>
                    <th><label for="ContContNum" id="ContContNumlbl">Number of Contracts</label></th>
                </tr>
                <tr>
                    <td>#NumberFormat(ContCountNum)#</td>
                </tr>
            </table>
		</CFOUTPUT>
		<CFOUTPUT QUERY="ContSumm">
            <table class="table table-bordered">
                <tr>
                    <th><label for="TotCont" id="TotContlbl">Total Contract Amount</label></th>
                    <th><label for="TotContEncumb" id="TotContEncumblbl">Total Contract Encumbrances</label></th>
                    <th><label for="TotContExp" id="TotContExplbl">Total Contract Expenditures</label></th>
                </tr>
                <tr>
                    <td>#DollarFormat(ContTotal)#</td>
                    <td>#DollarFormat(ContEncTotal)#</td>
                    <td>#DollarFormat(ContExpTotal)#</td>
                </tr>
            </table>
		</CFOUTPUT>
	</CFIF>

	<!-- Payment Summary -->
	<div id="Heading" class="margintop30"><p><b>Payments</b></p></div>

	<CFIF #ExpSumm.RecordCount# is "0" >
        <p id="instructions2">(No expenditure information was found for the current Fiscal Year.)</p>
    <CFELSE>
		<CFOUTPUT QUERY="ExpSumm">
            <table class="table table-bordered">
                <tr>
                    <th><label for="TotPaymentEncumb" id="TotPaymentEncumblbl">Total Encumbrances</label></th>
                    <th><label for="TotExpEncumb" id="TotExplbl">Total Expenditures</label></th>
                </tr>
                <tr>
                    <td>#DollarFormat(EncTotal)#</td>
                    <td>#DollarFormat(ExpTotal)#</td>
                </tr>
            </table>
		</CFOUTPUT>
	</CFIF>
        --->
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>


<!---</BODY>

</HTML>--->