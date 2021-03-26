<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!-->
<html lang="en" class="no-js"> <!--<![endif]-->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="description" content="Enhanced Vendor Remittance">
<meta name="author" content="Gary Ashbaugh">

<!--- 
Created By: Gary Ashbaugh
Date Created: 7-27-2012
Modified By: Gary Ashbaugh
Modifications Made: Added API, MobileApp, and MobileAppType fields for the IOC EVR Mobile Application

Modification Date: 11-7-14
Modified By: Gary Ashbaugh
Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site

Description:  The program will allow Coordinators to register for the Vendor Remittance Site
--->


<script language="JavaScript"><!--

/*
	function ChangeMobileApp() {
		
		if (document.VendorRemit.MobileApp.value=='Y') {
			document.VendorRemit.MobileAppType.disabled = false;
		}
		else {
			document.VendorRemit.MobileAppType.value = 'None';
			document.VendorRemit.MobileAppType.disabled = true;
		}
		
	}
	*/

function SelectImage(NoOfImage) {
    document.VendorRemit.Captcha.value = NoOfImage;

}

function MakeMouseCursorWait() {
    document.body.style.cursor = 'wait';
}

function MakeMouseCursorPointer() {
    document.body.style.cursor = 'Default';
    document.VendorRemit.vendTIN.focus();
}

function ChangeCoordinator() {
    document.VendorRemit.PaymentNotification[0].disabled = false;
    document.VendorRemit.PaymentNotification[1].disabled = false;
    if (document.VendorRemit.PaymentNotification[0].checked == true) {
        document.VendorRemit.NotificationType.disabled = false;
        if (document.VendorRemit.NotificationType.value == 'Text') {
            document.VendorRemit.CellProvider.disabled = false;
            document.VendorRemit.CellPhone.disabled = false;
        }
        else {
            document.VendorRemit.CellProvider.value = 'None';
            document.VendorRemit.CellProvider.disabled = true;
            document.VendorRemit.CellPhone.value = '';
            document.VendorRemit.CellPhone.disabled = true;
        }
    }
    else {
        document.VendorRemit.NotificationType.value = 'None';
        document.VendorRemit.NotificationType.disabled = true;
        document.VendorRemit.CellProvider.value = 'None';
        document.VendorRemit.CellProvider.disabled = true;
        document.VendorRemit.CellPhone.value = '';
        document.VendorRemit.CellPhone.disabled = true;
    }

}

//-->
</script>

<!---<cfinclude template="/config/applicationsettings.cfm">--->

<cfinclude template="TmpVendorApplicationSettings.cfm">

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<cfoutput>
    <cfLock Scope="SESSION" TIMEOUT="120">
        <cfparam name="Session.vendTIN" default="">
        <cfparam name="Session.BankAcctNo" default="">
        <cfparam name="Session.RoutingNO" default="">
        <cfparam name="Session.AdmLevel" default="">
        <cfparam name="form.captcha" default="">
        <cfparam name="form.captchaAnswer" default="">
        <cfparam name="Session.TmpMobileApp" default="">
        <cfparam name="Session.TmpAPI" default="">
        <cfparam name="Session.TmpFirstName" default="">
        <cfparam name="Session.TmpLastName" default="">
        <cfparam name="Session.TmpPaymentNotification" default="">
        <cfparam name="Session.TmpNotificationType" default="">
        <cfparam name="Session.TmpCellProvider" default="">
        <cfparam name="Session.TmpCellPhone" default="">
        <cfparam name="Session.TmpAreaCode" default="">
        <cfparam name="Session.TmpPhonePrefix" default="">
        <cfparam name="Session.TmpPhoneSuffix" default="">
        <cfparam name="Session.TmpPhone" default="">
        <cfparam name="Session.TmpDisclaimerApproved" default="N">
        <cfparam name="Session.TmpEmail" default="">
        <cfparam name="Session.ErrorNo" default="">
        <cfset ErrorNo = "">
    </cfLock>
</cfoutput>

<!---<cffunction name="makeRandomString" returnType="string" output="false">
   <cfset var chars = "23456789ABCDEFGHJKMNPQRSTWXYZ">
   <cfset var length = randRange(4,7)>
   <cfset var result = "">
   <cfset var i = "">
   <cfset var char = "">
   
   <cfscript>
   for(i=1; i <= length; i++) {
      char = mid(chars, randRange(1, len(chars)),1);
      result&=char;
   }
   </cfscript>
      
   <cfreturn result>
</cffunction>--->


<!--- Get list of Glyphicons for captcha --->

<cfset ListSorted = "">

<cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_ListofGlyphiconCatcha">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@ListofGlyphicons" variable="ListofGlyphicons">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@TargetGlyphicons" variable="TargetGlyphicons">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetListofGlyphiconCatchaRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListofGlyphiconCatchaRetMsg">
    <cfprocresult name="GetListofGlyphiconCatcha">
</cfstoredproc>

<cfset ListSorted = "#ListSort("#ListofGlyphicons#", "numeric", "asc")#">

<cfif isdefined("form.Add")>

    <cfoutput>

        <cfif trim(form.VendTIN) is not "">
            <cfif len(trim(form.VendTIN)) is "5">
<!--- Payee Numbers are only 5 digits, so zero fill the last 4 digits --->
                <cfset TmpTaxpayerIdNo = trim(UCase(form.VendTIN)) & "0000">
            <cfelse>
                <cfset TmpTaxpayerIdNo = trim(UCase(form.VendTIN))>
            </cfif>
        <cfelse>
            <cfset TmpTaxpayerIdNo = " ">
        </cfif>

<!--- Removed per SR17107 --->
<!---
<cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_UserAPI">
   <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@EMail" value="#trim(UCase(form.Email))#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUserAPIRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUserAPIRetMsg">
    <cfprocresult name="GetUserAPI">
</cfstoredproc>

<Cfif GetUserAPIRetVal is 0>
    <cfset TmpAPI = "#GetUserAPI.API#">
    <cfset TmpOldMobileApp = "#GetUserAPI.MobileApp#">
<cfelse>
    <cfset TMPAPI = "">
    <cfset TmpOldMobileApp = "N">
</cfif>
--->

<!---
<cfif trim(form.BankAcctNo) is not "">
    <cfset TmpBankAcctNo = trim(form.BankAcctNo)>
    <cfloop condition="len(TmpBankAcctNo) lt 4">
        <cfset TmpBankAcctNo =  "0" & trim(form.BankAcctNo)>
    </cfloop>
<cfelse>
    <cfset TmpBankAcctNo = " ">
</cfif>
<cfif trim(form.RoutingNo) is not "">
    <cfset TmpBankRoutingNo = Numberformat(trim(form.RoutingNo),"09999")>
<cfelse>
    <cfset TmpBankRoutingNo = " ">
</cfif>--->

        <cfif trim(form.BankAcctNo) is not "">
            <cfset TmpBankAcctNo = trim(form.BankAcctNo)>
            <cfloop condition="len(TmpBankAcctNo) lt 4">
                <cfset TmpBankAcctNo = "0" & trim(form.BankAcctNo)>
            </cfloop>
        <cfelse>
            <cfset TmpBankAcctNo = " ">
        </cfif>

        <cfif trim(form.RoutingNo) is not "">
            <cfset TmpBankRoutingNo = trim(form.RoutingNo)>
            <cfloop condition="len(TmpBankRoutingNo) lt 5">
                <cfset TmpBankRoutingNo = "0" & trim(form.RoutingNo)>
            </cfloop>
        <cfelse>
            <cfset TmpBankRoutingNo = " ">
        </cfif>

<!--- Removed per SR17107 --->
<!---
<cfif form.MobileApp is "Y">
    <cfset TmpMobileApp = "Y">
<cfelse>
    <cfset TmpMobileApp = "N">
</cfif>
--->

        <cfif isdefined("PaymentNotification")>
            <cfset TmpPaymentNotification = "#PaymentNotification#">
        <cfelse>
            <cfset TmpPaymentNotification = "N">
        </cfif>

        <cfif isdefined("NotificationType")>
            <cfset TmpNotificationType = "#NotificationType#">
        <cfelse>
            <cfset TmpNotificationType = "None">
        </cfif>

        <cfif isdefined("CellProvider")>
            <cfset TmpCellProvider = "#CellProvider#">
        <cfelse>
            <cfset TmpCellProvider = "None">
        </cfif>

        <cfif isdefined("form.CellPhone")>
            <cfif len(form.CellPhone) is 14>
                <cfset TmpAreaCode = "#mid(form.CellPhone, 2, 3)#">
                <cfset TmpPhonePrefix = "#mid(form.CellPhone, 7, 3)#">
                <cfset TmpPhoneSuffix = "#mid(form.CellPhone, 11, 4)#">
                <cfelseif len(form.Contact_Phone) is 8>
                <cfset TmpAreaCode = "">
                <cfset TmpPhonePrefix = "#mid(form.CellPhone, 1, 3)#">
                <cfset TmpPhoneSuffix = "#mid(form.CellPhone, 5, 4)#">
            <cfelse>
                <cfset TmpAreaCode = "">
                <cfset TmpPhonePrefix = "">
                <cfset TmpPhoneSuffix = "">
            </cfif>
            <cfset Session.TmpCellPhone = "#form.CellPhone#">
        <cfelse>
            <cfset TmpAreaCode = "">
            <cfset TmpPhonePrefix = "">
            <cfset TmpPhoneSuffix = "">
            <cfset Session.TmpCellPhone = "">
        </cfif>

        <cfif trim(form.Contact_Phone) is not "">
            <cfset TmpPhone = "#form.Contact_Phone#">
        <cfelse>
            <cfset TmpPhone = "">
        </cfif>

        <cfif isdefined("form.DisclaimerApproved")>
            <cfif form.DisclaimerApproved is "Y">
                <cfset Session.TmpDisclaimerApproved = "Y">
            <cfelse>
                <cfset Session.TmpDisclaimerApproved = "N">
            </cfif>
        <cfelse>
            <cfset Session.TmpDisclaimerApproved = "N">
        </cfif>

<!--- Verifies that the user is signing up for a FEIN which belongs to only a user or Deduction --->
        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_ValidVendor">
            <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckValidVendorRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckValidVendorRetMsg">
            <cfprocresult name="CheckValidVendor">
        </cfstoredproc>

        <cfif (CheckValidVendor.recordcount gt 1) and form.Number_Code is "">
            <div class="Col-sm-12">Are you trying to register for Deduction or a Commercial?</div>
            <form role="form" class="form-horizontal" name="VendorRemit"
                  action="/vendors/enhanced-vendor-remittance/enhanced-vendor-registration/" method="post">
                <div class="col-sm-12">&nbsp;</div>
            <div class="col-sm-12 pull-right">
            <cfoutput><a href="/vendors/enhanced-vendor-remittance/enhanced-vendor-registration/" id="ReturnBack"><span
                    class="input-group-addon pull-left"><i
                    class="glyphicon glyphicon-share-alt"></i></span>Cancel</a></cfoutput></div>
            <cfoutput>

                <div class="form-group">
                        <input type="hidden" name="VendTIN" value="#form.VendTIN#">
                    <input type="hidden" name="vendTINCheck" value="#form.vendTINCheck#">
                    <input type="hidden" name="FirstName" value="#form.FirstName#">
                    <input type="hidden" name="LastName" value="#form.LastName#">
                    <input type="hidden" name="Contact_Phone" value="#form.Contact_Phone#">
                    <input type="hidden" name="Email" value="#form.Email#">

<!--- Removed per SR17107 --->
<!---
<cfif GetUserAPIRetVal is 0>
    <input type="hidden" name="MobileApp" value="Y">
<cfelse>
    <input type="hidden" name="MobileApp" value="#form.MobileApp#">
</cfif>
--->
                    <input type="hidden" name="VendorAdmin" value="Y">
                        <input type="hidden" name="PaymentNotification" value="#form.PaymentNotification#">
                    <input type="hidden" name="NotificationType" value="#form.NotificationType#">
                <cfif isdefined("form.CellProvider")>
                        <input type="hidden" name="CellProvider" value="#CellProvider#">
                <cfelse>
                        <input type="hidden" name="CellProvider" value="None">
                </cfif>
                <cfif isdefined("form.CellPhone")>
                        <input type="hidden" name="CellPhone" value="#form.CellPhone#">
                <cfelse>
                        <input type="hidden" name="CellPhone" value="">
                </cfif>
                <input type="hidden" name="RoutingNo" value="#form.RoutingNo#">
                    <input type="hidden" name="RoutingNoCheck" value="#form.RoutingNoCheck#">
                    <input type="hidden" name="BankAcctNo" value="#form.BankAcctNo#">
                    <input type="hidden" name="BankAcctNoCheck" value="#form.BankAcctNoCheck#">
                <cfif isdefined("form.DisclaimerApproved")>
                        <input type="hidden" name="DisclaimerApproved" value="Y">
                </cfif>
                <input type="hidden" name="captchaAnswer" value="#form.captchaAnswer#">
                    <input type="hidden" name="Captcha" value="#form.Captcha#">

                <div class="col-sm-2">
                    <label for="Number_Code" id="NumberCodelbl" class="control-label">Type?</label>
                </div>
                <div class="col-sm-8">
                    <div class="col-sm-4">
                        <input type="radio" class="control-label" name="Number_Code" id="Number_Code1" value="1"
                               tabindex="1" required> Commercial
                    </div>
                    <div class="col-sm-4">
                        <input type="radio" class="control-label" name="Number_Code" id="Number_Code4" value="4"
                               tabindex="2" required> Deduction
                    </div>
                </div>
                <div class="col-sm-2">&nbsp;</div>
            </div>
                <div class="col-sm-12">&nbsp;</div>
                <div class="form-group">
                    <div class="col-sm-offset-4 col-sm-2">
                        <button class="btn btn-custom-primary btn-sm btn-block btn-login" Name="Add" id="Addbtn2"
                                tabindex="21"><i class="fa fa-arrow-circle-o-right"></i>Continue
                        </button>
                    </div>
                </div>
                <div class="col-sm-12">&nbsp;</div>
            </cfoutput>
            </form>
            <cfabort>
        <cfelse>

            <cfif trim(form.Number_Code) is not "">
                <cfset TmpNumberCode = "#form.Number_Code#">
            <cfelse>
                <cfset TmpNumberCode = "#CheckValidVendor.Number_Code#">
            </cfif>

            <cfif TmpNumberCode is "4">
                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_AccptMiscCode">
                    <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@TaxpayerIdNo" value="#TmpTaxpayerIdNo#">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckAcceptMiscCodeRetVal">
                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckAcceptMiscCodeRetMsg">
                    <cfprocresult name="CheckAcceptMiscCode">
                </cfstoredproc>

                <cfif CheckAcceptMiscCodeRetVal gt 0>
                    <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                    aria-hidden="true"></span>
                    <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                        as an authorized user of the Secure Enhanced Vendor Remittance application since you are trying
                        to register with an Invalid Trailer Code!</b>
                    </div>
                    <cfset ErrorNo = "1">
                    <cfelseif CheckAcceptMiscCode.IOC_Only is "Y">
                    <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                    aria-hidden="true"></span>
                    <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                        as an authorized user of the Secure Enhanced Vendor Remittance application since you are trying
                        to register with a Trailer Code reserved for IOC Personnel!</b>
                    </div>
                    <cfset ErrorNo = "1">
                </cfif>

            </cfif>

            <cfif TmpNumberCode is not "4" or (TmpNumberCode is "4" and ErrorNo is not "1")>
<!--- Check to see if there is already a Coordinator assigned to the Vendor --->
                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_NoVendorCoordinator">
                    <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                    <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
                    <cfprocresult name="CheckNoVendorCoordinator">
                </cfstoredproc>

<!--- Check to see if there has been more than 3 rejects for today for the vendor --->
                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_NoRejVendor">
                    <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                    <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                    <cfprocparam type="In" cfsqltype="cf_sql_timestamp" dbvarname="@RejDt" value="#DateFormat(NOW(), "mm/dd/yyyy")#">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoRejVendorRetVal">
                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoRejVendorRetMsg">
                    <cfprocresult name="CheckNoRejVendor">
                </cfstoredproc>

<!--- Check to see if Email has been marked as being returned --->
                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_EmailReturned">
                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckEmailReturnedRetVal">
                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckEmailReturnedRetMsg">
                    <cfprocresult name="CheckEmailReturned">
                </cfstoredproc>


<!--- Verify E-Mail isn't already being used for this vendor --->
                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_VendorRemit">
                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@TaxpayerIdNo" value="#TmpTaxpayerIdNo#">
                    <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckValidEmailRetVal">
                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckValidEmailRetMsg">
                    <cfprocresult name="CheckValidEmail">
                </cfstoredproc>

<!--- Verify  user is trying to sign up for a acceptable Misc COde if Number_Code is 4 --->
                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_ValidAccptMiscCode">
                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@TaxpayerIdNo" value="#TmpTaxpayerIdNo#">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@AccptMiscCode" variable="AccptMiscCode">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckValidAccptMiscCodeRetVal">
                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckValidAccptMiscCodeRetMsg">
                    <cfprocresult name="CheckValidAccptMiscCode">
                </cfstoredproc>

<!--- Verifies that the user has entered a correct Bank Account Number, Routing Number for FEIN --->
                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Check_ValidVendor2">
                    <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                    <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@BankAcctNo" value="#TmpBankAcctNo#">
                    <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@RoutingNo" value="#TmpBankRoutingNo#">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckValidVendor2RetVal">
                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckValidVendor2RetMsg">
                    <cfprocresult name="CheckValidVendor2">
                </cfStoredProc>

                <cfif CheckNoVendorCoordinator.CoordinatorCount eq 0>
                    <cfset TmpNoRej = 0>
                    <cfif CheckNoRejVendorRetVal is 1>
                        <cfset TmpNoRej = 0>
                    <cfelse>
                        <cfset TmpNoRej = "#CheckNoRejVendor.rejRegistrations#">
                    </cfif>
                    <cfif TmpNoRej lt 3>

<!--- Verify user has used the '@' sign and a '.' --->
                        <cfset FindAt = False>
                        <cfset AtPost = 0>
                        <cfset FindPeriod = False>
                        <cfset i = 1>
                        <cfif trim(form.Email) is not "">
                            <cfloop condition="#i# lt #len(form.Email)#">
                                <cfif mid(form.Email, #i#, 1) is '@'>
                                    <cfset atPos = "#i#">
                                    <cfset FindAt = True>
                                </cfif>
                                <cfif (FindAt is True) and (mid(form.Email, #i#, 1) is ".")>
                                    <cfset FindPeriod = True>
                                </cfif>
                                <cfset i = i + 1>

                            </cfloop>
                        </cfif>

<!--- Verify user has not used a '+' sign before the  '@' sign --->
                        <cfset FindPlus = False>
                        <cfset i = 1>
                        <cfif trim(form.Email) is not "">
                            <cfloop condition="#i# lt #atPos#">
                                <cfif (mid(form.Email, #i#, 1) is "+")>
                                    <cfset FindPlus = True>
                                </cfif>
                                <cfset i = i + 1>

                            </cfloop>
                        </cfif>

                        <cfif CheckValidVendor2RetVal gt 0>
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since the
                                Banking Information entered doesn't match our offices records!</b>
                            </div>
                            <cfset ErrorNo = "1">

                            <cfStoredProc datasource="#application.VendorPayments#" Procedure="Add_RejRegistration">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Email" value="#form.Email#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@BankAcctNo" value="#TmpBankAcctNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@RoutingNo" value="#TmpBankRoutingNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@FirstName" value="#form.FirstName#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@LastName" value="#form.LastName#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Phone" value="#TmpPhone#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@VendorAdmin" value="Y">
                                <cfif TmpPaymentNotification is "Y">
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="Y">
                                    <cfif TmpNotificationType is "Text">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="#tmpCellProvider#">
                                        <cfif TmpAreaCode is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" value="#TmpAreaCode#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" null="Yes">
                                        </cfif>
                                        <cfif TmpPhonePrefix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" value="#TmpPhonePrefix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" null="Yes">
                                        </cfif>
                                        <cfif TmpPhoneSuffix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" value="#TmpPhoneSuffix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" null="Yes">
                                        </cfif>
                                    <cfelse>
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                    </cfif>

                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@RejReason" value="#CheckValidVendor2RetVal#">
                                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
                                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
                                <cfprocresult name="CheckNoVendorCoordinator">
                            </cfstoredproc>

                            <cfLock Scope="SESSION" TIMEOUT="120">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("OldMobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelseif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">

</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>

<!--- Verifies the user has not tried to signup with an Email that has been marked as being returned  --->
                            <cfelseif CheckEmailReturnedRetVal is 0>
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since the
                                Email you are trying to register with has been marked as being "Undeliverable" by our
                                office!</b>
                            </div>
                            <cfset ErrorNo = "1">

                            <cfStoredProc datasource="#application.VendorPayments#" Procedure="Add_RejRegistration">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Email" value="#form.Email#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@BankAcctNo" value="#TmpBankAcctNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@RoutingNo" value="#TmpBankRoutingNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@FirstName" value="#form.FirstName#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@LastName" value="#form.LastName#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Phone" value="#TmpPhone#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@VendorAdmin" value="Y">
                                <cfif TmpPaymentNotification is "Y">
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="Y">
                                    <cfif TmpNotificationType is "Text">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="#tmpCellProvider#">
                                        <cfif TmpAreaCode is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" value="#TmpAreaCode#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" null="Yes">
                                        </cfif>
                                        <cfif TmpPhonePrefix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" value="#TmpPhonePrefix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" null="Yes">
                                        </cfif>
                                        <cfif TmpPhoneSuffix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" value="#TmpPhoneSuffix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" null="Yes">
                                        </cfif>
                                    <cfelse>
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                    </cfif>

                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@RejReason" value="8">
                                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
                                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
                                <cfprocresult name="CheckNoVendorCoordinator">
                            </cfstoredproc>

                            <cfLock Scope="SESSION" TIMEOUT="120">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("OldMobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelseif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">

</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>

<!--- Verifies the user has entered a valid TaxpayerIdNo --->
                            <cfelseif trim(form.vendTIN) is not trim(form.vendTINCheck) or trim(form.VendTIN) is "">
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since the
                                Identification Number and the Re-Enter Identification Number do not match or you have
                                failed to supply your Identification Number!</b>
                            </div>

                            <cfLock Scope="SESSION" TIMEOUT="120">
                                <cfset ErrorNo = "2">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>

<!--- Verifies the user has entered a valid Bank Routing Number--->
                            <cfelseif trim(form.RoutingNo) is not trim(form.RoutingNoCheck) or trim(form.RoutingNo) is "">
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since theBank
                                Routing Number and the Re-Enter Bank Routing Number do not match or you have failed to
                                supply your Bank Routing Number!</b>
                            </div>
                            <cfLock Scope="SESSION" TIMEOUT="120">
                                <cfset ErrorNo = "4">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>
<!--- Verifies the user has entered a valid Bank Account Number --->
                            <cfelseif trim(form.BankAcctNo) is not trim(form.BankAcctNoCheck) or trim(form.BankAcctNo) is "">
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since theBank
                                Account Number and the Re-Enter Bank Account Number do not match or you have failed to
                                supply your Bank Account Number!</b>
                            </div>

                            <cfLock Scope="SESSION" TIMEOUT="120">
                                <cfset ErrorNo = "5">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>
<!--- Verifies the user has checked the Disclaimer --->
                            <cfelseif trim(Session.TmpDisclaimerApproved) is not "Y">
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since the
                                Disclaimer has not been checked!</b>
                            </div>

                            <cfLock Scope="SESSION" TIMEOUT="120">
                                <cfset ErrorNo = "6">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>
<!--- Verifies the user has entered a their first name, last name, and E-Mail address --->
                            <cfelseif (trim(form.LastName) is "" or trim(form.FirstName) is "" or trim(form.Email) is "")>
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since you
                                failed to fill out either your Identification Number, First Name, Last Name, and/or
                                E-Mail!</b>
                            </div>

                            <cfLock Scope="SESSION" TIMEOUT="120">
                                <cfset ErrorNo = "7">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>
<!--- Verifies the user has entered a E-Mail address format --->
                            <cfelseif (((FindAt is "False") or (FindPeriod is "False")) and (trim(form.Email) is not ""))>
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since you
                                failed to give us a valid E-Mail!</b>
                            </div>

                            <cfLock Scope="SESSION" TIMEOUT="120">
                                <cfset ErrorNo = "8">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>
<!--- Verifies the user has entered a E-Mail that doesn't contain a + sign before the @ sign...google issue --->
                            <cfelseif (FindPlus is "True")>
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since you
                                failed to give us a valid E-Mail!</b>
                            </div>

                            <cfLock Scope="SESSION" TIMEOUT="120">
                                <cfset ErrorNo = "9">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>
<!--- Verifies that if the user has signed up for text notifications that he/she has given us their cell phone provider --->
                            <cfelseif trim(TmpPaymentNotification) is "Y" and TmpNotificationType is "Text" and (TmpCellProvider is "None")>
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since you
                                failed to give us a valid Cell Phone Provider when asking for a Text notification!</b>
                            </div>

                            <cfLock Scope="SESSION" TIMEOUT="120">
                                <cfset ErrorNo = "10">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>
<!--- Verifies that if the user has signed up for text notifications that he/she has given us their cell phone provider and phone number --->
                            <cfelseif trim(TmpPaymentNotification) is "Y" and TmpNotificationType is "Text" and (len(trim(TmpAreaCode)) lt 3 or len(trim(TmpPhonePrefix)) lt 3 or len(trim(TmpPhoneSuffix)) lt 4)>
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since you
                                failed to give us a valid Cell Phone Number when asking for a Text notification!</b>
                            </div>

                            <cfLock Scope="SESSION" TIMEOUT="120">
                                <cfset ErrorNo = "11">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>

<!--- Verifies that if the user has signed up for notifications that he/she has given the type of notifications that he/she wishes to receive --->
                            <cfelseif trim(TmpPaymentNotification) is "Y" and (trim(TmpNotificationType) is not "Text" and trim(TmpNotificationType) is not "EMail")>
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                because the user is marked as receiving payment notification but has failed to tell us
                                the type of notification (E-Mail or Text)!</b>
                            </div>

                            <cfLock Scope="SESSION" TIMEOUT="120">
                                <cfset ErrorNo = "12">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>

<!--- Verifies the user has entered the captcha entry correctly --->
                            <cfelseif form.Captcha is not hash(form.captchaAnswer)>
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since the
                                "Captcha Image" you selected was incorrect!</b>
                            </div>

                            <cfset ErrorNo = "13">
                            <cfStoredProc datasource="#application.VendorPayments#" Procedure="Add_RejRegistration">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Email" value="#form.Email#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@BankAcctNo" value="#TmpBankAcctNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@RoutingNo" value="#TmpBankRoutingNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@FirstName" value="#form.FirstName#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@LastName" value="#form.LastName#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Phone" value="#TmpPhone#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@VendorAdmin" value="Y">
                                <cfif TmpPaymentNotification is "Y">
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="Y">
                                    <cfif TmpNotificationType is "Text">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="#tmpCellProvider#">
                                        <cfif TmpAreaCode is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" value="#TmpAreaCode#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" null="Yes">
                                        </cfif>
                                        <cfif TmpPhonePrefix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" value="#TmpPhonePrefix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" null="Yes">
                                        </cfif>
                                        <cfif TmpPhoneSuffix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" value="#TmpPhoneSuffix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" null="Yes">
                                        </cfif>
                                    <cfelse>
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                    </cfif>

                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@RejReason" value="4">
                                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
                                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
                                <cfprocresult name="CheckNoVendorCoordinator">
                            </cfstoredproc>

                            <cfLock Scope="SESSION" TIMEOUT="120">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>

<!--- Verifies the user has entered a correct Bank Account Number and Routing Number for the Vendor we have on file --->
                            <cfelseif CheckValidVendor.ValidVendorUser is not "Yes">
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since the
                                Banking Information doesn't match our files!</b>
                            </div>

                            <cfset ErrorNo = "14">
                            <cfStoredProc datasource="#application.VendorPayments#" Procedure="Add_RejRegistration">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Email" value="#form.Email#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@BankAcctNo" value="#TmpBankAcctNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@RoutingNo" value="#TmpBankRoutingNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@FirstName" value="#form.FirstName#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@LastName" value="#form.LastName#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Phone" value="#TmpPhone#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@VendorAdmin" value="Y">
                                <cfif TmpPaymentNotification is "Y">
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="Y">
                                    <cfif TmpNotificationType is "Text">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="#tmpCellProvider#">
                                        <cfif TmpAreaCode is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" value="#TmpAreaCode#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" null="Yes">
                                        </cfif>
                                        <cfif TmpPhonePrefix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" value="#TmpPhonePrefix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" null="Yes">
                                        </cfif>
                                        <cfif TmpPhoneSuffix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" value="#TmpPhoneSuffix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" null="Yes">
                                        </cfif>
                                    <cfelse>
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                    </cfif>

                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@RejReason" value="3">
                                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
                                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
                                <cfprocresult name="CheckNoVendorCoordinator">
                            </cfstoredproc>

                            <cfLock Scope="SESSION" TIMEOUT="120">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>

                            <cfelseif CheckValidEmailRetVal eq 0>
                            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                            aria-hidden="true"></span>
                            <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                as an authorized user of the Secure Enhanced Vendor Remittance application since the
                                E-Mail address already is being used by this Vendor.  You can NOT use this form to reset
                                your password.  Contact your Vendor Coordinator to have your password reset if you have
                                forgotten it!</b>
                            </div>

                            <cfset ErrorNo = "15">
                            <cfStoredProc datasource="#application.VendorPayments#" Procedure="Add_RejRegistration">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Email" value="#form.Email#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@BankAcctNo" value="#TmpBankAcctNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@RoutingNo" value="#TmpBankRoutingNo#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@FirstName" value="#form.FirstName#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@LastName" value="#form.LastName#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Phone" value="#TmpPhone#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@VendorAdmin" value="Y">
                                <cfif TmpPaymentNotification is "Y">
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="Y">
                                    <cfif TmpNotificationType is "Text">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="#tmpCellProvider#">
                                        <cfif TmpAreaCode is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" value="#TmpAreaCode#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" null="Yes">
                                        </cfif>
                                        <cfif TmpPhonePrefix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" value="#TmpPhonePrefix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" null="Yes">
                                        </cfif>
                                        <cfif TmpPhoneSuffix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" value="#TmpPhoneSuffix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" null="Yes">
                                        </cfif>
                                    <cfelse>
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                    </cfif>

                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@RejReason" value="5">
                                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
                                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
                                <cfprocresult name="CheckNoVendorCoordinator">
                            </cfstoredproc>

                            <cfLock Scope="SESSION" TIMEOUT="120">

<!--- Removed per SR17107 --->
<!---
<cfif isdefined("MobileApp")>
    <cfset Session.TmpMobileApp = "#Evaluate("MobileApp")#">

<cfelse>
    <cfset Session.TmpMobileApp = "N">
</cfif>
--->

                                <cfset Session.TmpFirstName = "#form.FirstName#">
                                <cfset Session.TmpLastName = "#form.LastName#">
                                <cfif isdefined("PaymentNotification")>
                                    <cfset Session.TmpPaymentNotification = "#PaymentNotification#">
                                <cfelse>
                                    <cfset Session.TmpPaymentNotification = "N">
                                </cfif>
                                <cfif isdefined("NotificationType")>
                                    <cfset Session.TmpNotificationType = "#NotificationType#">
                                <cfelse>
                                    <cfset Session.TmpNotificationType = "None">
                                </cfif>
                                <cfif isdefined("CellProvider")>
                                    <cfset Session.TmpCellProvider = "#CellProvider#">
                                <cfelse>
                                    <cfset Session.TmpCellProvider = "None">
                                </cfif>
                                <cfif isdefined("TmpAreaCode")>
                                    <cfset Session.TmpAreaCode = "#TmpAreaCode#">
                                <cfelse>
                                    <cfset Session.TmpAreaCode = "">
                                </cfif>
                                <cfif isdefined("TmpPhonePrefix")>
                                    <cfset Session.TmpPhonePrefix = "#TmpPhonePrefix#">
                                <cfelse>
                                    <cfset Session.TmpPhonePrefix = "">
                                </cfif>
                                <cfif isdefined("TmpPhoneSuffix")>
                                    <cfset Session.TmpPhoneSuffix = "#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfset Session.TmpPhoneSuffix = "">
                                </cfif>
                                <cfif trim(form.Contact_Phone) is not "">
                                    <cfset Session.TmpPhone = "#form.Contact_Phone#">
                                <cfelse>
                                    <cfset Session.TmpPhone = " ">
                                </cfif>
                                <cfset Session.TmpEmail = "#form.Email#">
                                <cfif isdefined("form.DisclaimerApproved")>
                                    <cfif form.DisclaimerApproved is "Y">
                                        <cfset Session.TmpDisclaimerApproved = "Y">
                                    <cfelse>
                                        <cfset Session.TmpDisclaimerApproved = "N">
                                    </cfif>
                                <cfelse>
                                    <cfset Session.TmpDisclaimerApproved = "N">
                                </cfif>
                            </cfLock>

                        <cfelse>

<!--- Registration passes all of the tests...OK to register the user --->

<!--- Set API --->
<!--- Removed per SR17107 --->
<!---
<cfif  TmpMobileApp is "Y" and trim(TMPAPI) is "" and trim(TmpNumberCode) is not "4">

    <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_LastSeqAPINumber">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@NextAPI" variable="NextAPI">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLastSeqAPINumberRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLastSeqAPINumberRetMsg">
        <cfprocresult name="GetLastSeqAPINumber">
    </cfstoredproc>

    <cfif GetLastSeqAPINumberRetVal is 0>

        <cfset TmpNo = "#NumberFOrmat(NextAPI,"0000000009")#">

    <cfelse>

        <cfset TmpNo = "0000000001">

    </cfif>


    <cfset TmpAPI = "IOC" & "#UCase(mid(form.FirstName,1,2))#" & "#UCase(Mid(form.LastName,1,2))#" & "#UCase(mid(form.Email,1,4))#" & "EVRMOBILE" & "IL" & "#NumberFormat(TmpNo,"0999999999")#" >
    <cfset TMPAPI = hash(TMPAPI,"SHA-256")>

</cfif>
--->
                            <cfStoredProc datasource="#application.VendorPayments#" Procedure="Add_VendorUserInfo">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                                <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
<!--- 1,2 is Corporate; 4 is Deduction --->
                                <cfif trim(TmpNumberCode) is "4">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@Number_Code" value="4">
                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@Number_Code" null="Yes">
                                </cfif>
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@Firstname" value="#trim(form.Firstname)#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@Lastname" value="#trim(form.Lastname)#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@Phone" value="#trim(TmpPhone)#">

<!--- Removed per SR17107 --->
<!---
<Cfif GetUserAPIRetVal is 0 and GetUserAPI.MobileApp is "Y">
    <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@API" value="#GetUserAPI.API#">
    <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@MobileApp" value="#GetUserAPI.MobileApp#">

<cfelseif trim(TmpMobileApp) is "Y">
    <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@API" value="#TmpAPI#">
    <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@MobileApp" value="Y">

<cfelse>
    <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@API" null="Yes">
    <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@MobileApp" value="N">

</cfif>
--->

                                <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@API" null="Yes">
                                <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@MobileApp" value="N">
                                <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@VendorAdmin" value="Y">
                                <cfif TmpPaymentNotification is "Y">
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="Y">
                                    <cfif TmpNotificationType is "Text">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="#tmpCellProvider#">
                                        <cfif TmpAreaCode is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" value="#TmpAreaCode#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" null="Yes">
                                        </cfif>
                                        <cfif TmpPhonePrefix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" value="#TmpPhonePrefix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" null="Yes">
                                        </cfif>
                                        <cfif TmpPhoneSuffix is not "">
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" value="#TmpPhoneSuffix#">
                                        <cfelse>
                                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" null="Yes">
                                        </cfif>
                                    <cfelse>
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                    </cfif>

                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@EnteredBy" value="#trim(form.Email)#">
                                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="AddVendorUserInfoRetVal">
                                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="AddVendorUserInfoRetMsg">
                                <cfprocresult name="AddVendorUserInfo">
                            </cfstoredproc>

                            <cfif AddVendorUserInfoRetVal eq 0>

<!--- Check to see if we need to send out a "Verify Your E-Mail" --->
                                <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_UserInfo">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
                                    <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                                    <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUserInfoRetVal">
                                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GEtUserInfoRetMsg">
                                    <cfprocresult name="GetUserInfo">
                                </cfstoredproc>
                                <cfif trim(GetUserInfo.DtEmailValidated) is "">
                                    <div class="alert alert-success col-sm-12"><span class="glyphicon glyphicon-ok"
                                                                                     aria-hidden="true"></span>
                                    <b>Thank You, #trim(form.FirstName)# #trim(form.LastName)#
                                        for registering with us on #DateFormat(Now(), "mm/dd/yyyy")#
                                        for the Vendor Remittance Site!<br><br>You will be receiving a Confirmation
                                        E-Mail from us shortly.  Please open the E-Mail and click on the "Verify E-Mail
                                        Address" hyperlink to validate your E-Mail.  If you do NOT receive the E-Mail,
                                        please check your "Junk E-Mail" folder.  After validating your E-Mail, you will
                                        be given the opportunity to create your password.  Once you have successfully
                                        created your password, you will be ready to use the Secure Enhanced Vendor
                                        Remittance Site!</b>
                                    </div>

<!--- Create Password --->
                                    <CFMail
                                            TO="#trim(form.EMail)#"
                                            from="#application.VendorRemitEmail#"
                                            subject="Secure Enhanced Vendor Remittance Registration"
                                            type="html">
                                        <P>This is an automated E-Mail sent to you by the Illinois Office of the
                                            Comptroller.  It is being sent to you from the State of Illinois
                                            Comptroller's Secure Enhanced Vendor Remittance Site.<br><br><b>You have
                                            been registered as a user of this site.</b><br><br>Please click on
                                                <a href="#application.EVRSite#/vendors/enhanced-vendor-remittance/create-password/?ValidateEmail=Yes&TaxpayerInfoNo=#urlEncodedformat(encrypt(TmpTaxpayerIdNo, application.theKey, application.theAlgor, application.TheEncode))#&Email=#urlEncodedFormat(form.EMail)#&Number_Code=#urlEncodedformat(TmpNumberCode)#">
                                        Verify E-Mail Address</a> to verify that you have received this E-Mail.  If the
                                        "Verify E-Mail Address" link does not work, you will need to copy and paste this
                                        link into your Internet Browser's Internet Site
                                        Address.    #application.EVRSite#
                                            /vendors/enhanced-vendor-remittance/create-password/?ValidateEmail=yes&TaxpayerInfoNo=#urlEncodedformat(encrypt(TmpTaxpayerIdNo, application.theKey, application.theAlgor, application.TheEncode))#
                                            &Email=#urlEncodedFormat(form.EMail)#
                                            &Number_Code=#urlEncodedformat(TmpNumberCode)#
                                            <br/><br/>If you have received this E-Mail by mistake, please contact our
                                            office at
                                                <a href="Mailto:#application.SecAdmEmail#?Subject=Secure Enhanced Vendor Remittance Registration">#application.SecAdmEmail#</a>
                                        or contact our office at #application.SecAdmPhone#
                                            .  You must verify your E-Mail address before you will be given the chanceto
                                            create your personal password for the site.<br/><br/>After you have clicked
                                            the link above, you will be given the opportunity to create a password.
                                            While doing so, please remember passwords must be 6-25 characters.  To
                                            ensure your company's remittance information is kept private, passwords
                                            expire every 30 days.  When this happens you will be redirected
                                            automatically to a Web page that allows you to create a new password for the
                                            next 30-day period.  You must not reuse a password from the last 10 times
                                            you have changed it.  You will not be able to log into the Secure Enhanced
                                            Vendor Remittance Site until both steps have been completed.<br/><br/><b>ATTENTION
                                            USER COORDINATORS:</b> Did you know the IOC can alert you when state
                                            payments are on the way? You and any additional users can choose to receive
                                            either an SMS text message or an E-Mail the morning after your warrants are
                                            issued. Messages contain the vendor's name, the payment(s) amount, and an
                                            anticipated deposit date. Standard text message rates may apply. Click on
                                            "Manage Accounts" once you have logged in to the Secure Enhanced Vendor
                                            Remittance Site to activate Payment Notifications.

<!--- Removed per SR17107 --->
<!---
<cfif trim(TmpMobileApp) is "Y" and trim(TmpNumberCode) is not "4"><br /><br /><br />You also have been registered to use IOC mobile app.  After inputting and saving your API key into the mobile App, payment information will be available the following business day, and each business day thereafter.  Your API number, which is your User Id for the app, is shown below:<br /><br />#TMPAPI#<br /><br /></cfif>--->

                                            <br><br>
                                            Thank You,
                                            <br><br><Br><Br>
                                            Illinois Office of the Comptroller</P>
                                    </cfmail>

                                <cfelse>
                                    <div class="alert alert-success col-sm-12"><span class="glyphicon glyphicon-ok"
                                                                                     aria-hidden="true"></span>
                                    <b>Thank You, #trim(form.FirstName)# #trim(form.LastName)#
                                        for registering with us on #DateFormat(Now(), "mm/dd/yyyy")#
                                        for the Vendor Remittance Site!<br/><br/>You are now ready to use the Secure
                                        Enhanced Vendor Remittance Site!</b>
                                    </div>

                                </cfif>

<!--- Removed per SR17107 --->
<!---
<cfif trim(TmpAPI) is not "" and trim(TmpNumberCode) is not "4">

    <!--- Get list of all vendors for user --->
    <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_ListofUserVendors">
        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(form.Email)#">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetListofUserVendorsoRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListofUserVendorsRetMsg">
        <cfprocresult name="GetListofUserVendors">
    </cfstoredproc>

    <cfloop query="GetListofUserVendors">

        <CFQUERY NAME="CheckDBExist"  Datasource="#application.WHDB2#">
            Select *
            from wh.ma_api_vendor
            where API = <cfqueryparam cfsqltype="cf_sql_char" value="#TmpAPI#"> and
                Taxpayer_Id_No = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetListofUserVendors.TaxpayerIdNo#">

        </CFQUERY>

        <cfif not CheckDBExist.recordcount>
            <cfquery name="Insert_MA_API_Vendor" Datasource="#application.WHDB2#">
            insert into wh.ma_api_vendor (API, Taxpayer_Id_No,Vendor_TIN)
            values(<cfqueryparam cfsqltype="cf_sql_char" value="#TmpAPI#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#GetListofUserVendors.TaxpayerIdNo#">,<cfqueryparam cfsqltype="cf_sql_char" value="#NumberFormat(GetListofUserVendors.TaxpayerIdNo,"099999999")#">)

            </cfquery>

        </cfif>
    </cfloop>
</cfif>
--->
                            <cfelse>
                                <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                                aria-hidden="true"></span>
                                <b>We can not register #trim(form.FirstName)# #trim(form.LastName)#
                                    as an authorized user of the Secure Enhanced Vendor Remittance application.  We might
                                    be experiencing a heavy volumn of requests at this time...please try again in a few
                                    minutes.   If you continue to have problems trying to register you can either call
                                    us at #application.VendorRemitPhone#or E-Mail us at
                                    <a href="mailto:#application.VendorRemitEmail#">#application.VendorRemitEmail#</a>.
                            </b>
                            </div>
                                <cfset ErrorNo = "16">
                            </cfif>
                        </cfif>

                    <cfelse>
                        <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                        aria-hidden="true"></span>
                        <b>We have had more then 3 registrations with critical errors
                            on #dateformat(now(), "mm/dd/yyyy")#for your Vendor so we can not register you
                        until #dateformat(dateadd("d", 1, now()), "mm/dd/yyyy")#
                            .  If on #dateformat(dateadd("d", 1, now()), "mm/dd/yyyy")#
                            you continue to have problems trying to register you can either call us
                            at #application.VendorRemitPhone#or E-Mail us at
                            <a href="mailto:#application.VendorRemitEmail#">#application.VendorRemitEmail#</a>.</b>
                    </div>
                        <cfset ErrorNo = "17">
                        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Add_RejRegistration">
                            <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Email" value="#form.Email#">
                            <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                            <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                            <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@BankAcctNo" value="#TmpBankAcctNo#">
                            <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@RoutingNo" value="#TmpBankRoutingNo#">
                            <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@FirstName" value="#form.FirstName#">
                            <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@LastName" value="#form.LastName#">
                            <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Phone" value="#TmpPhone#">
                            <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@VendorAdmin" value="Y">
                            <cfif TmpPaymentNotification is "Y">
                                <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="Y">
                                <cfif TmpNotificationType is "Text">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="#tmpCellProvider#">
                                    <cfif TmpAreaCode is not "">
                                        <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" value="#TmpAreaCode#">
                                    <cfelse>
                                        <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" null="Yes">
                                    </cfif>
                                    <cfif TmpPhonePrefix is not "">
                                        <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" value="#TmpPhonePrefix#">
                                    <cfelse>
                                        <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" null="Yes">
                                    </cfif>
                                    <cfif TmpPhoneSuffix is not "">
                                        <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" value="#TmpPhoneSuffix#">
                                    <cfelse>
                                        <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" null="Yes">
                                    </cfif>
                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                    <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>

                            <cfelse>
                                <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                            </cfif>
                            <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@RejReason" value="7">
                            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
                            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
                            <cfprocresult name="CheckNoVendorCoordinator">
                        </cfstoredproc>

                    </cfif>

                <cfelse>
                    <cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
                        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_VendorCoordinator">
                            <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                            <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetVendorCoordinatorRetVal">
                            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetVendorCoordinatorRetMsg">
                            <cfprocresult name="GetVendorCoordinator">
                        </cfstoredproc>
                    </cfLock>

                    <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove"
                                                                    aria-hidden="true"></span>
                    <b>We show that your Vendor already has a Coordinator assigned to your
                        Vendor, #GetVendorCoordinator.Firstname# #GetVendorCoordinator.LastName#
                        .  Please go through your Vendor Coordinator to get signed up for the Enhanced Vendor
                        Application.</b>
                    </div>
                    <cfset ErrorNo = "18">
                    <cfStoredProc datasource="#application.VendorPayments#" Procedure="Add_RejRegistration">
                        <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Email" value="#form.Email#">
                        <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxPayerIdNo" value="#TmpTaxpayerIdNo#">
                        <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@Number_Code" value="#TmpNumberCode#">
                        <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@BankAcctNo" value="#TmpBankAcctNo#">
                        <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@RoutingNo" value="#TmpBankRoutingNo#">
                        <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@FirstName" value="#form.FirstName#">
                        <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@LastName" value="#form.LastName#">
                        <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Phone" value="#TmpPhone#">
                        <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@VendorAdmin" value="Y">
                        <cfif TmpPaymentNotification is "Y">
                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="Y">
                            <cfif TmpNotificationType is "Text">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="#tmpCellProvider#">
                                <cfif TmpAreaCode is not "">
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" value="#TmpAreaCode#">
                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@AreaCode" null="Yes">
                                </cfif>
                                <cfif TmpPhonePrefix is not "">
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" value="#TmpPhonePrefix#">
                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhonePrefix" null="Yes">
                                </cfif>
                                <cfif TmpPhoneSuffix is not "">
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" value="#TmpPhoneSuffix#">
                                <cfelse>
                                    <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>
                            <cfelse>
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="#TmpNotificationType#">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                                <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                            </cfif>

                        <cfelse>
                            <cfprocparam type="In" cfsqltype="cf_sql_Char" dbvarname="@PaymentNotification" value="N">
                            <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@NotificationType" value="None">
                            <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@CellProvider" value="None">
                            <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@AreaCode" null="Yes">
                            <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhonePrefix" null="Yes">
                            <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@PhoneSuffix" null="Yes">
                        </cfif>
                        <cfprocparam type="In" cfsqltype="cf_sql_varChar" dbvarname="@RejReason" value="6">
                        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
                        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
                        <cfprocresult name="CheckNoVendorCoordinator">
                    </cfstoredproc>

                </cfif>
            </cfif>
        </cfif>
    </cfoutput>
</cfif>

<!---<head>
<title>Secure Enhanced Vendor Remittance Registration</title>
</head>

<body onLoad="Javascript:MakeMouseCursorPointer(); ChangeCoordinator();">--->

<!---<cfset captcha=makeRandomString()>
<cfset captchaHash=hash(captcha)>--->

<!---<p style="background-color:#D3D3D3">--->
    <p id="Instructions">This form should be completed by the State vendor seeking access to the secure enhanced
        vendor remittance site on the IOC's website, <a href="https://IllinoisComptroller.Gov">https://IllinoisComptroller.Gov</a>.
        You should
        only use this form if you are the Vendor's Coordinator and there has NOT been a Coordinator assigned already to
        your Vendor.
        If there has been a Coordinator assigned to your Vendor, please contact him/her for access to the Enhanced
        Vendor application.
        You must enter your Identification Number, Last 5 digits of your Vendor's Bank Routing Number, Last 4 digits of
        your Vendor's
        Bank Account Number twice. All information is required to register for the Enhanced Vendor Application. Once you
        have been
        validated, you will receive an E-Mail requiring you to click on an embedded hyperlink to validate your E-Mail
        address that you
        register with. After your E-Mail has been validated, you will be directed to a screen that will allow you to
        create your own personal password.
        These two items will be required to be able to log into the Enhanced Vendor application.</p>

<form role="form" class="form-horizontal" name="VendorRemit" action="/vendors/enhanced-vendor-remittance/enhanced-vendor-registration/" method="post">
    <input type="hidden" name="Number_Code" value="">

    <div class="margintop30"><a href="https://IllinoisComptroller.Gov/vendors/" id="ReturnBack"><i class="glyphicon glyphicon-share-alt"></i> Return Back</a></div>
<cfoutput>
    <div class="text-center marginb30">
            <button class="btn btn-primary" name="Add" id="Addbtn" tabindex="22">Register Me!</button>
    </div>
    <div class="form-group">
        <input type="hidden" name="Number_Code" value="">
        <div class="col-sm-4 col-md-3">
            <label for="VendTIN" id="VendTINlbl" class="control-label">Identification No </label>
        </div>
        <div class="col-sm-6 col-md-3">
            <div class="input-group passwordContainer">
               <input tabindex="1" name="VendTIN" type="password" required maxlength="50" id="VendTIN2"
               <cfif not listfind(ErrorNo, "2") and not listfind(ErrorNo, "3") and not listfind(ErrorNo, "7") and not listfind(ErrorNo, "14")>class="form-control"
               <cfelse>class="form-control VendTIN2Red"</cfif>
               autocomplete="off" placeholder="999999999">
               <label class="input-group-addon">
                   <input type="checkbox" style="display:none" onclick="(function(e, el){
                         document.getElementById('VendTIN2').type = el.checked ? 'text' : 'password';
                          el.parentNode.lastElementChild.innerHTML = el.checked ? '<i class=\'glyphicon glyphicon-eye-close\'>' : '<i class=\'glyphicon glyphicon-eye-open\'>';
                          })(event, this)">
                   <span><i class="glyphicon glyphicon-eye-open"></i></span>
               </label>
            </div>
        </div>
        <div class="col-sm-4 col-md-3">
           <label for="VendTINReEnter" id="VendTINReEnterlbl" class="control-label">Re-Enter Identification No</label>
        </div>
        <div class="col-sm-6 col-md-3 registerinput">
            <div class="input-group passwordContainer">
                <input tabindex="2" name="VendTINCheck" type="password" required maxlength="50" id="VendTINCheck"
                <cfif not listfind(ErrorNo, "2") and not listfind(ErrorNo, "3") and not listfind(ErrorNo, "7") and not listfind(ErrorNo, "14")>class="form-control"
                <cfelse>class="form-control VendTINCheckRed"</cfif>
                autocomplete="off" placeholder="999999999">
                  <label class="input-group-addon">
                      <input type="checkbox" style="display:none" onclick="(function(e, el){
                        document.getElementById('VendTINCheck').type = el.checked ? 'text' : 'password';
                        el.parentNode.lastElementChild.innerHTML = el.checked ? '<i class=\'glyphicon glyphicon-eye-close\'>' : '<i class=\'glyphicon glyphicon-eye-open\'>';
                        })(event, this)">
                      <span><i class="glyphicon glyphicon-eye-open"></i></span>
                  </label>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-4 col-md-3">
            <label for="FirstName" id="CoordinaltorNamelbl" class="control-label">Coordinator's First Name </label>
        </div>
        <div class="col-sm-6 col-md-3">
            <!---<div <cfif listfind(ErrorNo,"7")>class="input-group has-error"<cfelse>class="input-group"</cfif>>--->
            <input type="text" required
                   <cfif not listfind(ErrorNo, "7")>id="FirstName"<cfelse>id="FirstNameRed"</cfif>
                   name="FirstName" value="#Session.TmpFirstName#"  tabindex="3" class="form-control">
        </div>
        <div class="col-sm-4 col-md-3">
            <label for="LastName" id="LastNamelbl" class="control-label">Coordinator's Last Name </label>
        </div>
        <div class="col-sm-6 col-md-3 registerinput">
            <!---<div <cfif listfind(ErrorNo,"7")>class="input-group has-error"<cfelse>class="input-group"</cfif>>--->
                <input type="text" required  name="LastName" value="#Session.TmpLastName#" tabindex="4"
                       <cfif not listfind(ErrorNo, "7")>id="LastName"<cfelse>id="LastNameRed"</cfif>  class="form-control">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-4 col-md-3">
            <label for="Phone" id="Phonelbl" class="control-label">Phone </label>
        </div>
        <div class="col-sm-6 col-md-3">
            <div class="input-group">
            <!--- <input type="text" required id="Phone2" placeholder="(999) 999-9999" <cfif listfind(ErrorNo,"7")>class="input-group has-error"<cfelse>class="input-group"</cfif>  name="Contact_Phone" value="#Session.TmpPhone#" tabindex="5">--->
                <input type="text" class="form-control" name="Contact_Phone"
                       <cfif not listfind(ErrorNo, "7")>id="Phone2"<cfelse>id="Phone2Red"</cfif>
                       placeholder="(999) 999-9999"  value="#Session.TmpPhone#" tabindex="5">
                <span class="input-group-addon"><i class="fa fa-phone"></i></span>
            </div>
        </div>
        <div class="col-sm-4 col-md-3">
            <label for="Email" id="Emaillbl" class="control-label">E-Mail</label>
        </div>
        <div class="col-sm-6 col-md-3 registerinput">
        <!---<div <cfif listfind(ErrorNo,"1") or listfind(ErrorNo,"7") or listfind(ErrorNo,"8") or listfind(ErrorNo,"9") or listfind(ErrorNo,"15")>class="input-group has-error"<cfelse>class="input-group"</cfif>>--->
            <div class="input-group">
                    <input class="form-control" type="email" required  name="Email" placeholder="myname@mail.com" value="#Session.TmpEmail#"
                           tabindex="6"
                           <cfif not listfind(ErrorNo, "1") and not listfind(ErrorNo, "7") and not listfind(ErrorNo, "8") and not listfind(ErrorNo, "9") and not listfind(ErrorNo, "15")>id="Email"
                           <cfelse>id="EmailRed"</cfif>>
                <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
            </div>
        </div>
    </div>

<!--- Removed per SR17107 --->
<!---
<div class=" col-sm-12"><p class="text-warning" align="left"><b>Note:  If you are signed up for another Vendor and you are also signed up for the mobile app, you will also be signed up for the mobile app for this vendor automatically.  If you so choose, you can switch your settings to not use the mobile app for any vendor via the Coordinator's Manage User once you are logged into Enhanced Vendor application.  <font color="Red">The Mobile App is no longer available or supported.  The Mobile App features are going to be brought into EVR as a future enhancement.</font></b></div>
<div class="form-group">
    <div class="col-sm-3">
        <label for="MobileApp" id="MobileApplbl" class="control-label">Do you wish to use EVR's Mobile App? </label>
    </div>
    <div class="col-sm-5">
        <div class="col-sm-4">
            <select name="MobileApp" class="form-control" id="MobileApp" tabindex="9">
            <option value="N" <cfif Session.TmpMobileApp is not "Y">selected</cfif>>No</option>
            <option value="Y" <cfif Session.TmpMobileApp is "Y">selected</cfif>>Yes</option>
            </select>
        </div>
        <div class="col-sm-1"><span class="input-group-addon"><i class="fa fa-apple"></i>&nbsp;</span><span class="input-group-addon">&nbsp;<i class="fa fa-android"></i></span>
        </div>
    </div>
     <div class="col-sm-4">&nbsp;</div>
</div>
--->
    <div class="form-group">
        <div class="col-sm-4 col-md-3">
            <label for="VendorAdmin" id="VendorAdminlbl" class="control-label">Coordinator</label>
        </div>
        <div class="col-sm-6 col-md-3">
            <input type="text" required id="VendorAdmin" name="VendorAdmin" value="Y" readonly tabindex="100" class="form-control">
        </div>
        <div class="col-sm-12 col-md-6">(ONLY VENDOR COORDINATORS SHOULD REGISTER USING THIS FORM)</div>
    </div>
    <div class="form-group">
        <div class="col-sm-4 col-md-3">
            <label for="PaymentNotification" id="PaymentNotificationlbl" class="control-label">Payment
                Notification? </label>
        </div>
        <div class="col-sm-6 col-md-9">
            <input type="radio" class="control-label" name="PaymentNotification" id="PaymentNotification" value="Y"
                           tabindex="10" onclick="ChangeCoordinator()"
                           <cfif Session.TmpPaymentNotification is "Y">checked</cfif>> Yes
            <input type="radio" class="control-label marginl15" name="PaymentNotification" id="PaymentNotificationN" value="N"
                       tabindex="11" onclick="ChangeCoordinator()"
                       <cfif Session.TmpPaymentNotification is not "Y">checked</cfif>> No
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-4 col-md-3">
            <label for="NotificationType" id="NotificationTypelbl" class="control-label">Type of Notification? </label>
        </div>
        <div class="col-sm-6 col-md-3">
            <select name="NotificationType" id="NotificationType"
                <cfif not listfind(ErrorNo, "12")>class="form-control" <cfelse>class="form-control has-error" </cfif>
                tabindex="12" onchange="ChangeCoordinator();"
                <cfif Session.TmpPaymentNotification is "">disabled="disabled"</cfif>>
                <option value="None"
                <cfif Session.TmpNotificationType is not "EMail" and Session.TmpNotificationType is not "Text">selected</cfif>>
                None</option>
                <option value="EMail"
                <cfif Session.TmpNotificationType is "EMail">selected</cfif>>EMail</option>
                <option value="Text"
                <cfif Session.TmpNotificationType is "Text">selected</cfif> >Text</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-4 col-md-3">
            <label for="CellProvider" id="CellProviderlbl" class="control-label">Cell Provider </label>
        </div>
        <div class="col-sm-6 col-md-3">
            <select name="CellProvider" id="CellProvider"  tabindex="13"
                <cfif not listfind(ErrorNo, "10")>class="form-control  "<cfelse>class="form-control has-error"</cfif>
                <cfif Session.TmpPaymentNotification is "">disabled="disabled"</cfif> onchange="ChangeCoordinator();">
                <option value="None"
                <cfif Session.TmpCellProvider is "" or Session.TmpCellProvider is "None">selected</cfif>>None</option>
                <option value="ATT"
                <cfif Session.TmpCellProvider is "ATT">selected</cfif>>AT&amp;T</option>
                <option value="Boost"
                <cfif Session.TmpCellProvider is "Boost">selected</cfif>>Boost</option>
                <option value="Cricket"
                <cfif Session.TmpCellProvider is "Cricket">selected</cfif>>Cricket</option>
                <option value="Sprint PCS"
                <cfif Session.TmpCellProvider is "Sprint PCS">selected</cfif>>Sprint</option>
                <option value="T-Mobile"
                <cfif Session.TmpCellProvider is "T-Mobile">selected</cfif>>T-Mobile</option>
                <option value="U.S. Cellular"
                <cfif Session.TmpCellProvider is "U.S. Cellular">selected</cfif>>U.S. Cellular</option>
                <option value="Verizon"
                <cfif Session.TmpCellProvider is "Verizon">selected</cfif>>Verizon</option>
                <option value="Virgin Mobile"
                <cfif Session.TmpCellProvider is "Virgin Mobile">selected</cfif>>Virgin Mobile</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-4 col-md-3">
            <label for="CellPhone" id="CellPhonelbl" class=" control-label">Cell Phone </label>
        </div>
        <div class="col-sm-6 col-md-3">
        <!---<div <cfif listfind(ErrorNo,"11")>class="input-group  has-error"<cfelse>class="input-group"</cfif>>--->
            <div class="input-group">
                <input type="tel" required  class="form-control" placeholder="(999) 999-9999" name="CellPhone"  value="#Session.TmpCellPhone#"
                           tabindex="14"
                           <cfif not listfind(ErrorNo, "11")>id="CellPhone2"<cfelse>id="CellPhone2Red"</cfif>
                <cfif Session.TmpCellProvider is "" or Session.TmpCellProvider is "None">disabled="disabled"</cfif>>
                <span class="input-group-addon "><i class="fa fa-phone"></i></span>
            </div>
        </div>
    </div>


    <h3 class="margintop30"><strong>FINANCIAL INSTITUTION INFORMATION</strong></h3>
    <p class="marginb20">For security reasons, we must verify the vendor's banking information. Please provide current
        financial institution information to verify your current ACH account. Feel comfortable that even though you are
        supplying us with this information, we take precautions to secure your information. The information that you
        provide to us is saved in an encrypted format.
    </p>

    <div class="form-group">
        <div class="col-sm-6 col-md-4">
            <label for="RoutingNo" id="RoutingNolbl" class="control-label"><b><i><a
                    href="/vendors/enhanced-vendor-remittance/check-examples/" target="_new"><img
                    src="/Comptroller/images/report.gif" width="10" height="10"/>Bank Routing Number (Last 5 Digits)</a></i></b>
            </label>
        </div>
        <div class="col-sm-6 col-md-2">
<!---           <div class="input-group">
            <input type="password" required placeholder="99999"  name="RoutingNo" tabindex="15" <cfif not listfind(ErrorNo,"4") and not listfind(ErrorNo,"14")>id="RoutingNo"<cfelse>id="RoutingNoRed"</cfif> size="5" maxlength="5">
            <span class="input-group-addon"><i class="fa fa-money"></i></span>
            </div> --->
            <div class="input-group passwordContainer">
            <input tabindex="15" name="RoutingNo" required type="password" size="5" maxlength="5" id="RoutingNo"
                   <cfif not listfind(ErrorNo, "4") and not listfind(ErrorNo, "14")>class="form-control"
                   <cfelse>class="form-control RoutingNoRed"</cfif>
                   placeholder="99999">
                       <label class="input-group-addon">
                           <input type="checkbox" style="display:none" onclick="(function(e, el){
                                 document.getElementById('RoutingNo').type = el.checked ? 'text' : 'password';
                                  el.parentNode.lastElementChild.innerHTML = el.checked ? '<i class=\'glyphicon glyphicon-eye-close\'>' : '<i class=\'glyphicon glyphicon-eye-open\'>';
                                  })(event, this)">
                           <span><i class="glyphicon glyphicon-eye-open"></i></span>
                       </label>
            </div>
        </div>
       <div class="col-sm-6 col-md-4">
           <label for="RoutingNoReEnter" id="RoutingNoReEnterlbl" class="control-label">Re-Enter Bank Routing Number (Last 5 Digits)</label>
       </div>
       <div class="col-sm-6 col-md-2 registerinput">
<!---          	<div class="input-group">
            <input type="password" required placeholder="99999"  name="RoutingNoCheck"  tabindex="16" <cfif not listfind(ErrorNo,"4") and  not listfind(ErrorNo,"14")>id="RoutingNoCheck"<cfelse>id="RoutingNoCheckRed"</cfif> size="5" maxlength="5">
            <span class="input-group-addon"><i class="fa fa-money"></i></span>
            </div> --->

            <div class="input-group passwordContainer">
            <input tabindex="16" name="RoutingNoCheck" required type="password" size="5" maxlength="5"
                   id="RoutingNoCheck"
                   <cfif not listfind(ErrorNo, "4") and not listfind(ErrorNo, "14")>class="form-control"
                   <cfelse>class="form-control RoutingNoCheckRed"</cfif>
                   placeholder="99999">
                       <label class="input-group-addon">
                           <input type="checkbox" style="display:none" onclick="(function(e, el){
                                 document.getElementById('RoutingNoCheck').type = el.checked ? 'text' : 'password';
                                  el.parentNode.lastElementChild.innerHTML = el.checked ? '<i class=\'glyphicon glyphicon-eye-close\'>' : '<i class=\'glyphicon glyphicon-eye-open\'>';
                                  })(event, this)">
                           <span><i class="glyphicon glyphicon-eye-open"></i></span>
                       </label>
            </div>

        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-6 col-md-4">
            <label for="BankAcctNo" id="BankAcctNolbl" class="control-label"><b><i><a
                    href="/vendors/enhanced-vendor-remittance/check-examples/" target="_new"><img
                    src="/Comptroller/images/report.gif" width="10" height="10"/>Bank Account Number (Last 4 Digits)</a></i></b>
            </label>
        </div>
        <div class="col-sm-6 col-md-2">
<!---            <div class="input-group">
            <input type="password" required placeholder="9999"  name="BankAcctNo" tabindex="17" <cfif not listfind(ErrorNo,"5") and not listfind(ErrorNo,"14")>id="BankAcctNo"<cfelse>id="BankAcctNoRed"</cfif> size="4" maxlength="4">
            <span class="input-group-addon"><i class="fa fa-money"></i></span>
            </div> --->
            <div class="input-group passwordContainer">
                <input tabindex="17" name="BankAcctNo" required type="password" size="4" maxlength="4" id="BankAcctNo"
                <cfif not listfind(ErrorNo, "5") and not listfind(ErrorNo, "14")>class="form-control"
                <cfelse>class="form-control BankAcctNoRed"</cfif>
                placeholder="9999">
                <label class="input-group-addon">
                   <input type="checkbox" style="display:none" onclick="(function(e, el){
                         document.getElementById('BankAcctNo').type = el.checked ? 'text' : 'password';
                          el.parentNode.lastElementChild.innerHTML = el.checked ? '<i class=\'glyphicon glyphicon-eye-close\'>' : '<i class=\'glyphicon glyphicon-eye-open\'>';
                          })(event, this)">
                   <span><i class="glyphicon glyphicon-eye-open"></i></span>
                </label>
            </div>
        </div>
        <div class="col-sm-6 col-md-4">
            <label for="BankAcctNoReEnter" id="BankAcctNoReEnterlbl" class="control-label">Re-Enter Bank Account Number (Last 4 Digits)</label>
        </div>
        <div class="col-sm-6 col-md-2 registerinput">
<!---         	 <div class="input-group">
            <input type="password" required placeholder="9999"  name="BankAcctNoCheck"  tabindex="18" <cfif not listfind(ErrorNo,"5") and not listfind(ErrorNo,"14")>id="BankAcctNoCheck"<cfelse>id="BankAcctNoCheckRed"</cfif> size="4" maxlength="4">
            <span class="input-group-addon"><i class="fa fa-money"></i></span>
            </div> --->
            <div class="input-group passwordContainer">
                <input tabindex="17" name="BankAcctNoCheck" required type="password" size="4" maxlength="4" id="BankAcctNoCheck"
                <cfif not listfind(ErrorNo, "5") and not listfind(ErrorNo, "14")>class="form-control"
                <cfelse>class="form-control BankAcctNoCheckRed"</cfif>
                placeholder="9999">
                   <label class="input-group-addon">
                       <input type="checkbox" style="display:none" onclick="(function(e, el){
                             document.getElementById('BankAcctNoCheck').type = el.checked ? 'text' : 'password';
                              el.parentNode.lastElementChild.innerHTML = el.checked ? '<i class=\'glyphicon glyphicon-eye-close\'>' : '<i class=\'glyphicon glyphicon-eye-open\'>';
                              })(event, this)">
                       <span><i class="glyphicon glyphicon-eye-open"></i></span>
                   </label>
            </div>
        </div>
    </div>

    <div class="marginb15">
        <cfif not listfind(ErrorNo, "6")>
        <div class="checkbox">
            <label>
                <input type="checkbox" required id="DisclaimerApproved" name="DisclaimerApproved" value="Y"
                           <cfif Session.TmpDisclaimerApproved is "Y">Checked</cfif> tabindex="19">
                You acknowledge that the content is truthful and accurate to the best of your knowledge. You further
                acknowledge that it is your intent that submission acts as your digital signature in place of your
                manual signature, and that your digital signature has the same legal effect as your manual signature.
            </label>
        </div>
        <cfelse>
            <div class="has-error">
                <div class="checkbox">
                    <label>
                        <input type="checkbox" required id="DisclaimerApprovedRed" name="DisclaimerApproved" value="Y"
                                   tabindex="19" <cfif Session.TmpDisclaimerApproved is "Y">Checked</cfif>>
                        You acknowledge that the content is truthful and accurate to the best of your knowledge. You further
                        acknowledge that it is your intent that submission acts as your digital signature in place of your
                        manual signature, and that your digital signature has the same legal effect as your manual signature.
                    </label>
                </div>
            </div>
        </cfif>
    </div>
    <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_GlyphiconsByNumber">
        <cfprocparam type="In" cfsqltype="cf_sql_integer" dbvarname="@GlyphiconNumber" value="#TargetGlyphicons#">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetGlyphiconsByNumberRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetGlyphiconsByNumberRetMsg">
        <cfprocresult name="GetGlyphiconsByNumber">
    </cfstoredproc>
    <div class="text-center">Select the <b>#GetGlyphiconsByNumber.GlyphiconsDescription#</b>.  <a
        href="/vendors/enhanced-vendor-remittance/captcha-help/" target="_new"><b>(What is this?)</b></a>
    </div>
    <input type="hidden" name="captchaAnswer" value="#GetGlyphiconsByNumber.GlyphiconsDescription#">

    <div
        <cfif listfind(ErrorNo, "13")>class="input-group has-error margintop10"<cfelse>class="input-group margintop10"</cfif>>
        <cfloop index="i" list="#ListSorted#">
        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_GlyphiconsByNumber">
            <cfprocparam type="In" cfsqltype="cf_sql_integer" dbvarname="@GlyphiconNumber" value="#i#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetGlyphiconsByNumberRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetGlyphiconsByNumberRetMsg">
            <cfprocresult name="GetGlyphiconsByNumber">
        </cfstoredproc>

            <span class="input-group-addon pull-center">
            <center><input type="radio" name="Captcha"
                           id="AddCaptcha"  value="#Hash(trim(GetGlyphiconsByNumber.GlyphiconsDescription))#">&nbsp;
                <i class="#trim(GetGlyphiconsByNumber.GlyphiconsName)#"></i></center></span>

    </cfloop><!---<input type="hidden" name="captcha" id="captcha" required  tabindex="20" />--->
    </div>

    <div class="text-center">
        <button class="btn btn-primary" Name="Add" id="Addbtn2" tabindex="21">Register Me!</button>
    </div>

</cfoutput>

</form>

<!-- Bootstrap core JavaScript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="/comptroller/jquery/jquery.js"></script>
<script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
<script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
<script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>


<script>
    $('#VendTIN2').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter your Vendor Identification Number (FEIN, SSN, or Payee Number)."
    });
    // $('#VendTIN2Red').tooltip({
    // 	'show': false,
    // 		'placement': 'top',
    // 		'title': "Enter your Vendor Identification Number (FEIN, SSN, or Payee Number)."
    // });
    $('#VendTINCheck').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Re-Enter Vendor Identification Number (FEIN, SSN, or Payee Number)."
    });
    // $('#VendTINCheckRed').tooltip({
    // 	'show': false,
    // 		'placement': 'top',
    // 		'title': "Re-Enter Vendor Identification Number (FEIN, SSN, or Payee Number)."
    // });
    $('#Addbtn').tooltip({
        'show': false,
        'placement': 'top',
        'title': "After you supplied us with all of your registration information, click this ADD button."
    });
    $('#Addbtn2').tooltip({
        'show': false,
        'placement': 'top',
        'title': "After you supplied us with all of your registration information, click this ADD button."
    });
    $('#FirstName').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter your First Name."
    });
    $('#LastName').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter your Last Name."
    });
    $('#Phone2').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter your contact phone number in the format of (999)999-9999."
    });
    $('#PhoneRed').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter your contact phone number in the format of (999)999-9999."
    });
    $('#CellPhone').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter your contact phone number in the format of (999) 999-9999."
    });
    $('#CellPhoneRed').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter your contact phone number in the format of (999) 999-9999."
    });
    $('#Email').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter a valid Email where your registration information will be sent."
    });
    $('#EmailRed').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter a valid Email where your registration information will be sent."
    });
    $('#MobileApp').tooltip({
        'show': false,
        'placement': 'top',
        'title': "You will need to answer Yes to receive your API Number which is required to log into the mobile application.  The App is available for both the Android and IPhone."
    });
    $('#PaymentNotification').tooltip({
        'show': false,
        'placement': 'top',
        'title': "You will need to answer Yes to receive either an Email or Text message when your Vendor receives a payment."
    });
    $('#PaymentNotificationRed').tooltip({
        'show': false,
        'placement': 'top',
        'title': "You will need to answer Yes to receive either an Email or Text message when your Vendor receives a payment."
    });
    $('#PaymentNotificationN').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Click No if you do not want to receive either an Email or Text message when your Vendor receives a payment."
    });
    $('#PaymentNotificationNRed').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Click No if you do not want to receive either an Email or Text message when your Vendor receives a payment."
    });
    $('#NotificationType').tooltip({
        'show': false,
        'placement': 'top',
        'title': "If you answered YES to Payment Notification, select either Email or Text."
    });
    $('#NotificationTypeRed').tooltip({
        'show': false,
        'placement': 'top',
        'title': "If you answered YES to Payment Notification, select either Email or Text."
    });
    $('#CellProvider').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Since you answered Text to Type of Notification, select either Cell Phone Provider."
    });
    $('#CellProviderRed').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Since you answered Text to Type of Notification, select either Cell Phone Provider."
    });
    $('#CellPhone2').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter your cell phone number in the format of (999) 999-9999.  You are responsible for any charges your provider might charge for such text messages."
    });
    $('#CellPhone2Red').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter your cell phone number in the format of (999) 999-9999.  You are responsible for any charges your provider might charge for such text messages."
    });
    $('#RoutingNo').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter the last 5-digits of your Vendor's Bank Routing Number."
    });
    // $('#RoutingNoRed').tooltip({
    // 	'show': false,
    // 		'placement': 'top',
    // 		'title': "Enter the last 5-digits of your Vendor's Bank Routing Number."
    // });
    $('#RoutingNoCheck').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Re-Enter the last 5-digits of your Vendor's Bank Routing Number."
    });
    // $('#RoutingNoCheckRed').tooltip({
    // 	'show': false,
    // 		'placement': 'top',
    // 		'title': "Re-Enter the last 5-digits of your Vendor's Bank Routing Number."
    // });
    $('#BankAcctNo').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Enter the Last 4-digits of your Vendor's Bank Account Number."
    });
    // $('#BankAcctNoRed').tooltip({
    // 	'show': false,
    // 		'placement': 'top',
    // 		'title': "Enter the Last 4-digits of your Vendor's Bank Account Number."
    // });
    $('#BankAcctNoCheck').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Re-Enter the Last 4-digits of your Vendor's Bank Account Number."
    });
    // $('#BankAcctNoCheckRed').tooltip({
    // 	'show': false,
    // 		'placement': 'top',
    // 		'title': "Re-Enter the Last 4-digits of your Vendor's Bank Account Number."
    // });
    $('#captcha').tooltip({
        'show': false,
        'placement': 'top',
        'title': "Select the image as being requested above.  This step helps to prevent unfair use of automated programs."
    });

    $('#Phone2').mask("(999) 999-9999");
    $('#Phone2Red').mask("(999) 999-9999");
    $('#CellPhone2').mask("(999) 999-9999");
    $('#CellPhone2Red').mask("(999) 999-9999");
</script>

