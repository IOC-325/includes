<!--- <!DOCTYPE html>    <cfdump var="#application#"><Cfabort> --->
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
<!---<head>--->
	<!---<title>Vendor Payments</title>--->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Vendor Payments">
	<meta name="author" content="Gary Ashbaugh">



<!---
Modified Date: 11-18-14
Modified By: Gary Ashbaugh
Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.
	It will also require people to enter at least the first 4-characters of the Vendor's Name.  He/She will also
	be able to sign-up to receive email/test notications when the vendor gets a payment.
--->

<!---
</head>--->

<script language="JavaScript"><!--

	function OpenHelp (ErrorNo,Section) {

/*
			mywindow = window.open("#application.webroot#/vendors/vendor-payments-new/help/?ErrorNo=" + ErrorNo+ "&Section=" + Section, "Help", "location=1,status=1,scrollbars=1,width=275,height=275");
			*/
			mywindow =
			window.open("#application.webroot#/vendors/vendor-payments-new/help/?ErrorNo=" + ErrorNo+ "&Section=" + Section, "Help", "location=1,status=1,scrollbars=1,width=275,height=275");

			mywindow.moveTo(250,250);

	}

	function ChangeCoordinator() {
		document.Vendor.NotificationType.disabled = false;
		if (document.Vendor.NotificationType.value == 'Text') {
			document.Vendor.Email.value = '';
			document.Vendor.Email.disabled = true;
			document.Vendor.MobileProvider.disabled = false;
			document.Vendor.MobilePhone.disabled = false;
		}
		else if (document.Vendor.NotificationType.value == 'Email') {
			document.Vendor.Email.disabled = false;
			document.Vendor.MobileProvider.disabled = true;
			document.Vendor.MobilePhone.value = '';
			document.Vendor.MobilePhone.disabled = true;
		}
		else if (document.Vendor.NotificationType.value == 'Both') {
			document.Vendor.Email.disabled = false;
			document.Vendor.MobileProvider.disabled = false;
			document.Vendor.MobilePhone.disabled = false;
		}

		else {
			document.Vendor.MobileProvider.value = 'None';
			document.Vendor.Email.value = '';
			document.Vendor.Email.disabled = true;
			document.Vendor.MobileProvider.disabled = true;
			document.Vendor.MobilePhone.value = '';
			document.Vendor.MobilePhone.disabled = true;
		}
	}

 //-->
</script>

<body onLoad="ChangeCoordinator();">
<cfparam name="form.captcha" default="">
<cfparam name="form.captchaAnswer" default="">
<cfparam name="form.Mode" default="">
<cfparam name="form.Email" default="">
<cfparam name="form.FirstName" default="">
<cfparam name="form.LastName" default="">
<cfparam name="form.NotificationType" default="None">
<cfparam name="form.MobileProvider" default="None">
<cfparam name="form.MobilePhone" default="">
<cfparam name="form.VendTIN" default="">
<cfparam name="form.VendTINName" default="">
<cfparam name="ErrorNo" default="">



<!--- <cfinclude template="TmpVendorapplicationSettings.cfm"> --->

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">

<cfif isDefined("session.TheVendTin")>
 <cfset vendTIN = Decrypt(session.TheVendTin,"ITBG111")>
</cfif>

<cfif len(VendTiN) eq 8>
 <cfSet VendTin="0#VendTIN#">
<cfelseif len(VendTiN) eq 7>
 <cfSet VendTin="00#VendTIN#">
<cfelse>
 <cfSet VendTin="#VendTIN#">
</cfif>

<CFINCLUDE TEMPLATE="VendHeader.cfm">
<cfoutput>

    <cfif form.Mode is "Login2">


            <!--- Check Required Fields --->
           <cfif trim(form.NotificationType) is not "None">
                <!--- Check Required Fields --->

                    <cfif (trim(form.NotificationType) is "Email" or trim(form.NotificationType) is "Both") and trim(form.Email) is "">
                        <cfset ErrorNo = ListAppend(ErrorNo, "05B")>
                    <!--- Validate Email address --->
                    <cfelseif (trim(form.NotificationType) is "Email" or trim(form.NotificationType) is "Both") and trim(form.Email) is not "">
                        <!--- Make sure Email is in correct format --->
                        <cfif not isValid("email", form.Email)>
                          <cfset ErrorNo = ListAppend(ErrorNo, "05A")>
                        </cfif>
                    </cfif>

                    <!--- If user entered mobile phone number he/she must supply provider and vise versa --->
                    <cfif ((trim(form.NotificationType) is "Text" or trim(form.NotificationType) is "Both") and trim(form.MobilePhone) is "")>
                            <cfset ErrorNo = ListAppend(ErrorNo, "03A")>
                        <cfelseif isdefined("form.MobilePhone")>
                            <cfif not isValid("regex", form.MobilePhone, "^((\(?[1-9][0-9][0-9]\)?)[ ][0-9][0-9][0-9][-]\s?\d{4})?$") and (trim(Form.Notificationtype) is "Text" or trim(form.NotificationType) is "Both")> 
                                <cfset ErrorNo = ListAppend(ErrorNo, "06A")>
                            <cfelse>
                                <cfset variables.myCleanPhoneNbr =
                                reReplaceNoCase(form.MobilePhone,
                                '[^[:digit:]]', '', 'ALL') >
                                <cfset form.MobilePhone = variables.myCleanPhoneNbr>
                                <cfif len(trim(form.MobilePhone)) neq "10" and (trim(Form.Notificationtype) is "Text" or trim(form.NotificationType) is "Both")>
                                    <cfset ErrorNo = ListAppend(ErrorNo, "06B")>
                                </cfif>
                            </cfif>
                    </cfif>
            </cfif>

            <!--- If Text/Both must supply mobile phone provider --->
            <cfif ((trim(form.NotificationType) is "Text" or trim(form.NotificationType) is "Both") and trim(form.MobileProvider) is "None")>
                <cfset ErrorNo = ListAppend(ErrorNo, "03B")>
            </cfif>
            <!--- Must have check the "Certify" checkbox --->
            <cfif (not isdefined("form.certify"))>
                <cfset ErrorNo = ListAppend(ErrorNo, "04A")>
            </cfif>            
            <cfif trim(form.FirstName) is "">
                <cfset ErrorNo = ListAppend(ErrorNo, "09A")>
            </cfif>
            <cfif trim(form.LastName) is "">
                <cfset ErrorNo = ListAppend(ErrorNo, "10A")>
            </cfif>


           <cfif trim(ErrorNo) is "">
                <cfset TmpVendTIN = decrypt(form.SVendTIN,"ITBG111")>
                <!--- Registering Notification Information --->

                <cfStoredProc datasource="Vendor" Procedure="Check_VendorRemitEmail">
                    <cfif trim(form.NotificationType) is "Email">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@Email" value="#form.Email#">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@CellProvider" null="yes">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@AreaCode" null="Yes">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhonePrefix" null="Yes">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhoneSuffix" null="Yes">
                    <cfelseif trim(form.NotificationType) is "Text">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@Email" null="yes">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@CellProvider" value="#form.MobileProvider#">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@AreaCode" value="#left(form.MobilePhone,3)#">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhonePrefix" value="#mid(form.MobilePhone,4,3)#">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhoneSuffix" value="#mid(form.MobilePhone,7,4)#">
                    <cfelseif trim(form.NotificationType) is "Both">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@Email" value="#form.Email#">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@CellProvider" value="#form.MobileProvider#">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@AreaCode" value="#left(form.MobilePhone,3)#">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhonePrefix" value="#mid(form.MobilePhone,4,3)#">
                        <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhoneSuffix" value="#mid(form.MobilePhone,7,4)#">
                    </cfif>
                    <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@TaxPayerIdNo" value="#VendTin#">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckVendorRemitEmailRetVal">
                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckVendorRemitEmailRetMsg">
                    <cfprocresult name="CheckVendorRemitEmail">
                </cfstoredproc>
                    <cfif CheckVendorRemitEmailRetVal is 0>
                        <cfStoredProc datasource="Vendor" Procedure="Updt_VendorUserInfo">
                            <cfif trim(form.NotificationType) is "Email" or trim(form.NotificationType) is "Both">
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@Email" value="#form.Email#">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@Email" null="yes">
                            </cfif>
                            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@TaxPayerIdNo" value="#form.VendTIN#">
                            <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@FirstName" value="#form.FirstName#">
                            <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@LastName" value="#form.LastName#">
                            <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@NotificationType" value="#form.NotificationType#">
                            <cfif trim(form.NotificationType) is "Text" or trim(form.NotificationType) is "Both">
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@CellProvider" value="#form.MobileProvider#">
                                 <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@AreaCode" value="#left(form.MobilePhone,3)#">
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhonePrefix" value="#mid(form.MobilePhone,4,3)#">
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhoneSuffix" value="#mid(form.MobilePhone,7,4)#">
                            <cfelse>
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@CellProvider" null="yes">
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@AreaCode" null="Yes">
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhonePrefix" null="Yes">
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhoneSuffix" null="Yes">
                            </cfif>
                            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="UpdtVendorUserInfoRetVal">
                            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="UpdtVendorUserInfoRetMsg">
                            <cfprocresult name="UpdtVendorUserInfo">
                        </cfstoredproc>

                            <cfif UpdtVendorUserInfoRetVal is 0>
                                <cflocation url="/vendors/vendor-payments-new/payment-notification/?Mode=Login2&NotificationType=#URLEncodedFormat(form.NotificationType)#&VENDTINNAME=#URLEncodedFormat(form.VendTINName)#&RecSaved=Yes&SVendTIN=#urlEncodedFormat(form.SVendTIN)#" addtoken="No">
                            </cfif>                        
                    <cfelse>

                            <cfStoredProc datasource="Vendor" Procedure="Add_VendorUserInfo">
                                <cfif trim(form.NotificationType) is "Email" or trim(form.NotificationType) is "Both">
                                    <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@Email" value="#form.Email#">
                                <cfelse>
                                    <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@Email" null="yes">
                                </cfif>
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@TaxPayerIdNo" value="#form.VendTIN#">
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@FirstName" value="#form.FirstName#">
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@LastName" value="#form.LastName#">
                                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@NotificationType" value="#form.NotificationType#">
                                <cfif trim(form.NotificationType) is "Text" or trim(form.NotificationType) is "Both">
                                    <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@CellProvider" value="#form.MobileProvider#">
                                    <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@AreaCode" value="#left(form.MobilePhone,3)#">
                                    <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhonePrefix" value="#mid(form.MobilePhone,4,3)#">
                                    <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhoneSuffix" value="#mid(form.MobilePhone,7,4)#">
                                <cfelse>
                                    <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@CellProvider" null="yes">
                                    <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@AreaCode" null="Yes">
                                    <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhonePrefix" null="Yes">
                                    <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhoneSuffix" null="Yes">
                                </cfif>
                                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="AddVendorUserInfoRetVal">
                                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="AddVendorUserInfoRetMsg">
                                <cfprocresult name="AddVendorUserInfo">
                            </cfstoredproc>


                            <cfif AddVendorUserInfoRetVal is 0>
                                <cflocation url="/vendors/vendor-payments-new/payment-notification/?Mode=Login2&NotificationType=#URLEncodedFormat(form.NotificationType)#&VENDTINNAME=#URLEncodedFormat(form.VendTINName)#&RecSaved=Yes&SVendTIN=#urlEncodedFormat(form.SVendTIN)#" addtoken="No">
                            </cfif>
                    </cfif>
           </cfif>
    </cfif>
</cfoutput>

<cfif isdefined("URL.RecSaved")>
    <div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
        <b>Notification Information has been saved!</b>
    </div>
</cfif>        

    <cfif trim(ErrorNo) is not "">
        <div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
           <b><u>Issue(s) with Form Submission</u></b>
            <cfloop list="#ErrorNo#" index="theError">
                <cfoutput>
                <cfStoredProc datasource="Vendor" Procedure="Get_ErrorMsg">
                    <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@ErrorNo" value="#theError#">
                    <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Section" value="VendorSummary">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetErrorNoRetVal">
                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetErrorNoRetMsg">
                    <cfprocresult name="GetErrorNo">
                </cfstoredproc>

                <ul class="text-danger">
                <li>#GetErrorNo.ErrorDescription#<cfif GetErrorNo.ErrorHelp is not ""></cfif></li>
                </ul>
                </cfoutput>
            </cfloop>
        </div>
    </cfif>
<cfoutput>
        <form id="VendorForm" class="form-horizontal" name="Vendor" action="/vendors/vendor-payments-new/payment-notification/?Mode=Login2" method="post">
            <INPUT TYPE="hidden" NAME="Mode" VALUE="Login2">
            <input type="hidden" name="VendTINName" value="#VendTINName#">
            <INPUT TYPE="hidden" NAME="SVendTin" value="#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#">
            <INPUT TYPE="hidden" NAME="VendTin" value="#VendTIN#">
            <div  class="alert alert-warning"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>&nbsp;<b>The following information is optional.  If you'd like to receive an email or text message when we process your payment, please enter your email address or mobile number/provider below.  NOTE: Notifications are active for 90 days. To continue receiving notifications afterwards, please repeat the registration process.</b>
            </div>
            <div class="form-group">
                    <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-2">
                        <label for="NotificationType" name="NotificationTypelbl" class="control-label">Payment Notification</label>
                    </div>
                    <div class="col-sm-6">
                        <select id="NotificationType" name="NotificationType" class="form-control"  tabindex="3" onchange="ChangeCoordinator();">
                            <option value="None">None</option>
                            <option value="Email" <cfif trim(form.NotificationType) is "Email">selected</cfif>>Email</option>
                            <option value="Text" <cfif trim(form.NotificationType) is "Text">selected</cfif>>Text</option>
                            <option value="Both" <cfif trim(form.NotificationType) is "Both">selected</cfif>>Both</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-2">
                    <label for="Name" id="Contactlbl" class=" control-label">Contact Name</label>
                    </div>
                    <div class="col-sm-3">
                            <input type="text" name="FirstName" <cfif not listfind(ErrorNo,"09A")>id="FirstName"<cfelse>id="FirstNameRed"</cfif> placeholder="First Name" class="form-control" tabindex="4" <cfif trim(form.FirstName) is not "">value="#form.FirstName#"</cfif>>
                    </div>
                    <div class="col-sm-3 mt10">
                            <input type="text" name="LastName" <cfif not listfind(ErrorNo,"10A")>id="LastName"<cfelse>id="LastNameRed"</cfif> placeholder="Last Name" class="form-control" tabindex="5" <cfif trim(form.LastName) is not "">value="#form.LastName#"</cfif>>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-2">
                    <label for="Email" id="Emaillbl" class="control-label">Email</label>
                    </div>
                   <div class="col-sm-6">
                    <div  <cfif listfind(ErrorNo,"05A") or listfind(ErrorNo,"05B")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                     <input type="email" onchange="ChangeCoordinator();" <cfif not listfind(ErrorNo,"05A") and not listfind(ErrorNo,"05B")>id="Email"</cfif> name="Email" placeholder="myname@mail.com" tabindex="6" class="form-control" <cfif trim(form.Email) is not "">value="#form.Email#"</cfif>>
                     <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    </div>
                   </div>
               </div>
                <div class="form-group">
                    <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-2">
                        <label for="MobilePhone" name="MobliePhonelbl" class="control-label">Mobile Phone</label>
                    </div>
                   <div class="col-sm-6">
                    <div  <cfif listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B") or listfind(ErrorNo,"06A") or listfind(ErrorNo,"06B")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                        <input type="text" name="MobilePhone" <cfif listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B") or listfind(ErrorNo,"06A") or listfind(ErrorNo,"06B")>id="CellPhoneRed"<cfelse>id="CellPhone"</cfif> placeholder="(999) 999-9999" class="form-control" tabindex="7" <cfif trim(form.MobilePhone) is not "">value="#form.MobilePhone#"</cfif> onChange="ChangeCoordinator();"><span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    </div>
                   </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-2">
                        <label for="MobileProvider" name="MobileProviderlbl" class="control-label">Mobile Provider</label>
                    </div>
                    <div class="col-sm-6">
                        <select id="CellProvider" <cfif listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B")>class="form-control has-error"<cfelse>class="form-control"</cfif> name="MobileProvider" class="form-control"  tabindex="8" onchange="ChangeCoordinator();">
                            <option value="None" >None</option>
                            <option value="ATT" <cfif trim(form.MobileProvider) is "ATT">selected</cfif>>AT&amp;T</option>
                            <option value="Boost" <cfif trim(form.MobileProvider) is "Boost">selected</cfif>>Boost</option>
                            <option value="Cricket" <cfif trim(form.MobileProvider) is "Cricket">selected</cfif>>Cricket</option>
                            <option value="Sprint PCS" <cfif trim(form.MobileProvider) is "Sprint PCS">selected</cfif>>Sprint</option>
                            <option value="T-Mobile" <cfif trim(form.MobileProvider) is "T-Mobile">selected</cfif>>T-Mobile</option>
                            <option value="U.S. Cellular" <cfif trim(form.MobileProvider) is "U.S. Cellular">selected</cfif>>U.S. Cellular</option>
                            <option value="Verizon" <cfif trim(form.MobileProvider) is "Verizon">selected</cfif>>Verizon</option>
                            <option value="Virgin Mobile" <cfif trim(form.MobileProvider) is "Virgin Mobile">selected</cfif>>Virgin Mobile</option>
                        </select>
                    </div>
                </div>

                <cfif not listfind(ErrorNo,"01A") and not listfind(ErrorNo,"01B") and not listfind(ErrorNo,"02A") and not listfind(ErrorNo,"03A") and not listfind(ErrorNo,"03B") and not listfind(ErrorNo,"04A") and not listfind(ErrorNo,"04B") and not  listfind(ErrorNo,"05A") and not listfind(ErrorNo,"05B") and not listfind(ErrorNo,"06A") and not  listfind(ErrorNo,"06B") and not listfind(ErrorNo,"07A") and not listfind(ErrorNo,"07B")>
                    <div class="checkbox">
                        <input type="checkbox" id="certify"  name="certify" value="Y" tabindex="9">
                        <label for="certify">By checking this box I certify that the email and mobile phone number provided are registered to me. I authorize the Office of the Comptroller to send me occasional emails/texts.</label>
                    </div>
                <cfelse>
                    <div class="has-error">
                      <div class="checkbox">
                          <input type="checkbox" id="certify" name="certify" value="Y">
                          <label>By checking this box I certify that the email and mobile phone number provided are registered to me. I authorize the Office of the Comptroller to send me occasional emails/texts.</label>
                      </div>
                    </div>
                 </cfif>

                <div class="text-center">
                     <button name="Update" class="btn btn-primary" id="Loginbtn2" tabindex="10">Submit</button>
                </div>
       </form>
</cfoutput>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>

<script>
  $(document).ready(function(){
   $('#VendTIN2').attr('autocomplete', 'off');
   setTimeout('$("#VendTIN2").val("");', 1000);
  });
  </script>
<script>
	$('#VendTIN2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your Social Security Number or Federal Employer Identification Number here."
	});
	$('#VendorTINName').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter the name of your business or last name followed by your first name."
	});
	$('#Loginbtn1').tooltip({
            'show': false,
                'placement': 'top',
                'title': "After entering the Vendor TIN Number and Vendor Name, click the Submit button."
        });

	$('#Loginbtn2').tooltip({
            'show': false,
                'placement': 'top',
                'title': "After entering the Vendor TIN Number and Vendor Name, click the Submit button."
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

	$('#FirstNameRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your First Name."
	});

	$('#LastNameRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your Last Name."
	});

	$('#NotificationType').tooltip({
		'show': false,
			'placement': 'top',
			'title': "OPTIONAL: Select from the dropdown the medium in which you would like to receive payment notifications: Email, Text, or Both."
	});

	$('#Email').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Provide a valid email address in this field if you would like to receive a payment notification via email."
	});
	$('#CellProvider').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the company you contract with for mobile data if you would like to receive a payment notification via SMS text message."
	});
	$('#CellPhone').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Provide a valid mobile phone number in this field if you would like to receive a payment notification via SMS text message. Use the (###) ###-#### format. Check with your mobile provider to see if data charges apply."
	});

	$('#VendTINRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your Social Security Number or Federal Employer Identification Number here."
	});
	$('#VendorTINNameRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter the name of your business or last name followed by your first name."
	});
	$('#EmailRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Provide a valid email address in this field if you would like to receive a payment notification via email."
	});
	$('#CellProviderRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the company you contract with for mobile data if you would like to receive a payment notification via SMS text message."
	});
	$('#CellPhoneRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Provide a valid mobile phone number in this field if you would like to receive a payment notification via SMS text message. Use the (###) ###-#### format. Check with your mobile provider to see if data charges apply."
	});

	$('#CellPhoneRed').mask("(999) 999-9999");
	$('#CellPhone').mask("(999) 999-9999");
	</script>


</body>
<!---</html>
--->
