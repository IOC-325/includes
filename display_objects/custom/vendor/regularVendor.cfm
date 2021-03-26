
<!--- <!DOCTYPE html>    <cfdump var="#application#"><Cfabort> --->
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
<!---<head>--->
	<!---<title>Vendor Payments</title>--->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Vendor Payments">
	<meta name="author" content="Gary Ashbaugh">
<CFSET structDelete(session, "TheVendTin")>
<!---<cfif Compare(cgi.SERVER_PORT,443)>
  <cflocation url="https://illinoiscomptroller.gov#cgi.path_info#?#cgi.query_string#" addtoken="false"/>
</cfif>--->


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
<cfset ErrorStruct = StructNew()>
<cfset ErrorNo = "">

<!--- <cfinclude template="TmpVendorapplicationSettings.cfm"> --->

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">


<cfif (form.Mode is "Login")>
	<cfoutput>
    <!--- Check values if user sign up to be notified --->
    <cfif trim(form.NotificationType) is not "None">
    <!--- Check Required Fields --->

    	<!--- Must have a Vendor TIN --->
		<cfif trim(form.VendTIN) is not "">
            <cfset variables.myCleanSSN =
              reReplaceNoCase(form.VendTIN,
              '[^[:digit:]]', '', 'ALL') >
            <cfset form.VendTIN = variables.myCleanSSN>
            <cfif len(form.VendTIN) neq "9">
                <cfset ErrorNo = ListAppend(ErrorNo, "01A")>
            </cfif>
        <cfelse>
            <cfset ErrorNo = ListAppend(ErrorNo, "01B")>
        </cfif>

        <!--- Must have supplied part of a Vendor Name --->
        <cfif trim(form.VendTINName) is "">
            <cfset ErrorNo = ListAppend(ErrorNo, "02A")>
        </cfif>

        <!--- captcha Check --->
        <cfif not isdefined("Captcha")>
            <cfset ErrorNo = ListAppend(ErrorNo, "07A")>
        <cfelseif form.Captcha is not hash(form.captchaAnswer)>
            <cfset ErrorNo = ListAppend(ErrorNo, "07B")>
        </cfif>

        <cfif (trim(form.NotificationType) is "Email" or trim(form.NotificationType) is "Both") and trim(form.Email) is "" and trim(form.NotificationType) is "Email">
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
        	<cfif not isValid("telephone", form.MobilePhone) and (trim(Form.Notificationtype) is "Text" or trim(form.NotificationType) is "Both")>

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
            <cfset TmpVendTIN = encrypt(form.VendTIN,"ITBG111")>

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
                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@TaxPayerIdNo" value="#form.VendTIN#">
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
                    <CFSET session.TheVendTin = Encrypt(form.VendTIN,'ITBG111')>
                    <cflocation url="/vendors/vendor-payments-new/vendor-summary/?Mode=Login&NotificationType=#URLEncodedFormat(form.NotificationType)#&SVendTIN=#URLEncodedFormat(TmpVendTIN)#&VENDTINNAME=#URLEncodedFormat(form.VendTINName)#&RecSaved=Yes" addtoken="No">
                </cfif>
            <cfelseif CheckVendorRemitEmailRetVal is 1>
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
                 <CFSET session.TheVendTin = Encrypt(form.VendTIN,'ITBG111')>
                	<cflocation url="/vendors/vendor-payments-new/vendor-summary/?Mode=Login&NotificationType=#URLEncodedFormat(form.NotificationType)#&SVendTIN=#urlEncodedFormat(TmpVendTIN)#&VENDTINNAME=#URLEncodedFormat(form.VendTINName)#&RecSaved=Yes" addtoken="No">
                    <!---<cflocation url="/vendors/vendor-payments-new/vendor-summary/?Mode=Login&NotificationType=#URLEncodedFormat(form.NotificationType)#&VENDTINNAME=#URLEncodedFormat(form.VendTINName)#&RecSaved=Yes&SVendTIN=#TmpVendTIN#" addtoken="No">--->
                </cfif>
            <cfelse>
            	<cfset ErrorNo="11A">
            </cfif>
        </cfif>
    <cfelse>

   		<!--- Check values for users not requesting notification --->
    	<cfif trim(form.VendTIN) is not "">
            <cfset variables.myCleanSSN =
              reReplaceNoCase(form.VendTIN,
              '[^[:digit:]]', '', 'ALL') >
            <cfset form.VendTIN = variables.myCleanSSN>
            <cfif len(form.VendTIN) neq "9">
                <cfset ErrorNo = ListAppend(ErrorNo, "01A")>
            </cfif>
        <cfelse>
            <cfset ErrorNo = ListAppend(ErrorNo, "01B")>
        </cfif>
        <cfif trim(form.VendTINName) is "">
            <cfset ErrorNo = ListAppend(ErrorNo, "02A")>
        </cfif>
        <!--- captcha Check --->
        <cfif not isdefined("Captcha")>
            <cfset ErrorNo = ListAppend(ErrorNo, "07A")>
        <cfelseif form.Captcha is not hash(form.captchaAnswer)>
            <cfset ErrorNo = ListAppend(ErrorNo, "07B")>
        </cfif>

        <cfif trim(ErrorNo) is "">
          <CFSET session.TheVendTin = Encrypt(form.VendTIN,'ITBG111')>
			<cfset TmpVendTIN = encrypt(form.VendTIN,"ITBG111")>
            <cflocation url="/vendors/vendor-payments-new/vendor-summary/?Mode=Login&NotificationType=None&SVendTIN=#UrlEncodedFormat(Encrypt(form.VendTIN,'ITBG111'))#&VENDTINNAME=#URLEncodedFormat(form.VendTINName)#&Rk=1" addtoken="No">
        </cfif>
    </cfif>
    <!---</cfif>--->
	</cfoutput>
</CFIF>

<cfset ListSorted = "">

<cfStoredProc datasource="VendorPayment" Procedure="Get_ListofGlyphiconCatcha">
    <cfprocparam type="Out"  cfsqltype="cf_sql_varchar" dbvarname="@ListofGlyphicons" variable="ListofGlyphicons">
    <cfprocparam type="Out"  cfsqltype="cf_sql_varchar" dbvarname="@TargetGlyphicons" variable="TargetGlyphicons">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetListofGlyphiconCatchaRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListofGlyphiconCatchaRetMsg">
    <cfprocresult name="GetListofGlyphiconCatcha">
</cfstoredproc>

<cfset ListSorted = "#ListSort("#ListofGlyphicons#","numeric","asc")#">

        <CFIF isDefined("NotFound")>
            <div class="col-sm-12">&nbsp;</div>
            <div class="col-sm-12">
            <p class="text-danger" align="left"><b>Sorry, but no vendors were found for that Vendor TIN / Vendor Name combination.</B>  Please verify the TIN and try again.</p>
            </div>

            <div class=" col-sm-12">&nbsp;</div>

        <cfelseif trim(ErrorNo) is not "">
        	<div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
<b><u>Issue(s) with Form Submission</u></b>
                <cfloop list="#ErrorNo#" index="theError">
					<cfoutput>
                	<cfStoredProc datasource="Vendor" Procedure="Get_ErrorMsg">
                        <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@ErrorNo" value="#theError#">
                        <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Section" value="Landing">
                        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetErrorNoRetVal">
                        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetErrorNoRetMsg">
                        <cfprocresult name="GetErrorNo">
                    </cfstoredproc>

                    <ul class="text-danger">
                    <li>#GetErrorNo.ErrorDescription#<cfif GetErrorNo.ErrorHelp is not "">  Click <a href="javascript:OpenHelp('#theError#','Landing')">here</a> for help solving the error.</cfif></li>
                    </ul>
                    </cfoutput>
                </cfloop>
            </div>

        <cfelseif isdefined("url.Unsubscribe")>
        	<div class="alert alert-success col-sm-12"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                <b>You have been unsubscribed!</b>
            </div>
		</cfif>

<div class="panel panel-default">
  <div style="font-size: 26px;"class="panel-heading text-center"><strong>Regular Vendor</strong></div>
  <div class="panel-body">


                <form id="VendorForm" role="form" class="form-horizontal" name="Vendor" action="/vendors/vendor-payments-new/" method="post">
                <cfoutput>
                <INPUT TYPE="hidden" NAME="Mode" VALUE="Login">

                <div class="form-group">
                 <div class="col-sm-offset-2 col-sm-3">
                   <label for="inputPassword3"  class="control-label">Vendor TIN:</label>
                 </div>
                 <div class="col-sm-4">
                  <div  <cfif listfind(ErrorNo,"01A") or listfind(ErrorNo,"01B")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                   <input type="password" placeholder="999999999" <!---required--->  name="VendTIN" autocomplete="off" <cfif not listfind(ErrorNo,"01A") or not listfind(ErrorNo,"01B")>id="VendTIN2"<cfelse>id="VendTINRed"</cfif> class="form-control" tabindex="1">
                   <span class="input-group-addon"><i class="fa fa-user"></i></span>
                  </div>
                 </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-3">
                     <label for="Vendor_TIN_Name" id="Vendor_TIN_Namelbl" class="control-label">Vendor Name: </label>
                    </div>
                    <div>
                   	 	<div class="col-sm-4"  <cfif listfind(ErrorNo,"02A")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                        <input type="text" <!---required---> <cfif not listfind(ErrorNo,"02A")>id="VendorTINName"<cfelse>id="VendorTINNameRed"</cfif> name="VendTINName"  autocomplete="off" class="form-control" tabindex="2" <cfif trim(form.VendTINName) is not "">value="#form.VendTINName#"</cfif>>
                       </div>
                       <div class="col-sm-2">&nbsp;</div>
                    </div>
                </div>
                <!--- <div class="col-sm-offset-3 col-sm-8"> --->
                	<cfStoredProc datasource="VendorPayment" Procedure="Get_GlyphiconsByNumber">
                        <cfprocparam type="In"  cfsqltype="cf_sql_integer" dbvarname="@GlyphiconNumber" value="#TargetGlyphicons#">
                        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetGlyphiconsByNumberRetVal">
                        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetGlyphiconsByNumberRetMsg">
                        <cfprocresult name="GetGlyphiconsByNumber">
                    </cfstoredproc>
                	<div class="col-sm-offset-3 col-sm-8">
                   Select the <b>#GetGlyphiconsByNumber.GlyphiconsDescription#</b> :
                   <a href="/vendors/enhanced-vendor-remittance1/captcha-help/" target="_new"><b>(What is this?)</b></a>
                    <cfset TmpCaptcha="#GetGlyphiconsByNumber.GlyphiconsDescription#">
                	   <input type="hidden" name="CaptchaAnswer" value="#GetGlyphiconsByNumber.GlyphiconsDescription#">
                 </div>
                 <div class="col-sm-2">&nbsp;</div>
                  <div style="padding-left:10px;" <cfif listfind(ErrorNo,"01A") or listfind(ErrorNo,"01B") or listfind(ErrorNo,"02A") or listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B") or listfind(ErrorNo,"04A") or listfind(ErrorNo,"05A") or listfind(ErrorNo,"05B") or listfind(ErrorNo,"06A") or listfind(ErrorNo,"06B") or listfind(ErrorNo,"07A") or listfind(ErrorNo,"07B")>class="col-sm-6 input-group has-error"<cfelse>class="col-sm-6 input-group"</cfif>>
                   <cfset CaptchaNo=1>
                   <cfloop index="i" list="#ListSorted#">
                       <cfStoredProc datasource="VendorPayment" Procedure="Get_GlyphiconsByNumber">
                           <cfprocparam type="In"  cfsqltype="cf_sql_integer" dbvarname="@GlyphiconNumber" value="#i#">
                           <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetGlyphiconsByNumberRetVal">
                           <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetGlyphiconsByNumberRetMsg">
                           <cfprocresult name="GetGlyphiconsByNumber">
                       </cfstoredproc>

                      <span class="input-group-addon pull-center"><center><input type="radio" name="Captcha" id="AddCaptcha#CaptchaNo#" value="#Hash(trim(GetGlyphiconsByNumber.GlyphiconsDescription))#">&nbsp;<i class="#GetGlyphiconsByNumber.GlyphiconsName#"></i></center></span><cfset CaptchaNo=CaptchaNo+1>

                   </cfloop><!---<input type="hidden" name="captcha" id="captcha" required  tabindex="20" />--->
                  </div>
                  <!-- TAGS INPUT -->
                  <div class="col-sm-2">&nbsp;</div>
                 </div>
                <div class="form-group">
                	<div class="col-sm-2">&nbsp;</div>
                    <div style="padding-bottom:10px;" class="col-sm-offset-3 col-sm-3">
                     <button nsme="Login" class="btn btn-danger btn-lg btn-block btn-login" id="Loginbtn2" tabindex="10"><!--- <i class="fa fa-arrow-circle-o-right"> </i>--->Submit</button>
                    </div>
                    <div class="col-sm-2">&nbsp;</div>
                </div>
                 <div  class="col-sm-offset-1 col-sm-10  example alert alert-info">
                   <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>&nbsp;The following information is optional.  If you'd like to receive an email or text message when we process your payment, please enter your email address or mobile number/provider below.  NOTE: Notifications are active for 90 days. To continue receiving notifications afterwards, please repeat the registration process.
                 </div>

                 <div class="form-group">
                    <div style="padding-bottom:10px;" class="col-sm-offset-1 col-sm-4">
                        <label for="NotificationType" name="NotificationTypelbl" class=" control-label" >Payment Notification: </label>
                    </div>
                    <div style="padding-bottom:10px;" class="col-sm-4">
                        <select name="NotificationType" id="NotificationType" class="form-control"  tabindex="3" onChange="ChangeCoordinator();">
                            <option value="None" <cfif trim(form.NotificationType) is not "Email" and trim(form.NotificationType) is "Text">Selected</cfif>>None</option>
                            <option value="Email" <cfif trim(form.NotificationType) is "Email">selected</cfif>>Email</option>
                            <option value="Text" <cfif trim(form.NotificationType) is "Text">selected</cfif>>Text</option>
                            <option value="Both" <cfif trim(form.NotificationType) is "Both">selected</cfif>>Both</option>
                        </select>
                    </div>
                 </div>
                <div class="form-group">
                    <div style="padding-bottom:10px;" class="col-sm-offset-1 col-sm-4">
                    <label for="Name" id="Contactlbl" class=" control-label" >Contact Name:</label>
                    </div>
                    <div style="padding-bottom:10px;" class="col-sm-3" >
                            <input type="text" name="FirstName"  <cfif not listfind(ErrorNo,"09A")>id="FirstName"<cfelse>id="FirstNameRed"</cfif> placeholder="First Name" class="form-control" tabindex="4" <cfif trim(form.FirstName) is not "">value="#form.FirstName#"</cfif>>
                    </div>
                    <div class="col-sm-3">
                            <input type="text" name="LastName" <cfif not listfind(ErrorNo,"10A")>id="LastName"<cfelse>id="LastNameRed"</cfif> placeholder="Last Name" class="form-control" tabindex="5" <cfif trim(form.LastName) is not "">value="#form.LastName#"</cfif>>
                    </div>
                </div>
                <div class="form-group">
                 <div style="padding-bottom:10px;" class="col-sm-offset-1 col-sm-4">
                  <label for="Email" class=" control-label" >Email:</label>
                 </div>
                  <div style="padding-bottom:10px;" class="col-sm-4">
                   <div  <cfif listfind(ErrorNo,"05A") or listfind(ErrorNo,"05B")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                     <input type="email" <cfif not listfind(ErrorNo,"05A") and not listfind(ErrorNo,"05B")>id="Email"<cfelse>id="EmailRed"</cfif> name="Email" placeholder="myname@mail.com"  tabindex="6" class="form-control" <cfif trim(form.Email) is not "">value="#form.Email#"</cfif> onChange="ChangeCoordinator();">
                     <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                   </div>
                  </div>
                </div>
                <div class="form-group">
                   <div style="padding-bottom:10px;" class="col-sm-offset-1 col-sm-4">
                        <label for="MobilePhone" name="MoboliePhonelbl" class=" control-label">Mobile Phone:</label>
                   </div>
                   <div style="padding-bottom:10px;" class="col-sm-4">
                    	<div  <cfif listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B") or listfind(ErrorNo,"06A") or listfind(ErrorNo,"06B")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                     <input type="text" name="MobilePhone" <cfif listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B") or listfind(ErrorNo,"06A") or listfind(ErrorNo,"06B")>id="CellPhoneRed"<cfelse>id="CellPhone"</cfif> placeholder="(999) 999-9999" class="form-control" tabindex="7" <cfif trim(form.MobilePhone) is not "">value="#form.MobilePhone#"</cfif> onChange="ChangeCoordinator();"><span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    	</div>
                   </div>
                </div>
                <div class="form-group">
                    <div style="padding-bottom:10px;" class="col-sm-offset-1 col-sm-4">
                        <label for="MobileProvider" name="MobileProviderlbl" class=" control-label" >Mobile Provider: </label>
                    </div>
                    <div style="padding-bottom:10px;" class="col-sm-4">
                        <select id="CellProvider" name="MobileProvider" <cfif listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B")>class="form-control  has-error"<cfelse>class="form-control"</cfif> tabindex="8" onChange="ChangeCoordinator();">
                            <option value="None" <cfif trim(form.MobileProvider) is "None" or trim(form.MobileProvider) is "">selected</cfif>>None</option>
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



                <cfif not listfind(ErrorNo,"01A") and not listfind(ErrorNo,"01B") and not listfind(ErrorNo,"02A") and not  listfind(ErrorNo,"03A") and not listfind(ErrorNo,"03B") and not listfind(ErrorNo,"04A") and not listfind(ErrorNo,"05A") and not listfind(ErrorNo,"05B") and not listfind(ErrorNo,"06A") and not listfind(ErrorNo,"06B") and not listfind(ErrorNo,"07A") and not listfind(ErrorNo,"07B")>
                 <div class="form-group">
                   <div style="padding-left:10px;" class="input-group col-sm-12">
                     <div class="checkbox">
                         <div class="text-right">
                             <input type="checkbox" id="certify"  name="certify" value="Y" tabindex="9" >
                         </div>
                             <label for="certify">By checking this box I certify that the email and mobile phone number provided are registered to me. I authorize the Office of the Comptroller to send me occasional emails/texts.</label>
                     </div>
                   </div>
                 </div>
                 <cfelse>
                  <div class="form-group has-error">
                   <div style="padding-left:10px;" class="input-group col-sm-12">
                         <div class="checkbox">
                             <div class="text-right">
                                 <input type="checkbox" id="certify"  name="certify" value="Y" tabindex="9" >
                             </div>
                                 <label for="certify">By checking this box I certify that the email and mobile phone number provided are registered to me. I authorize the Office of the Comptroller to send me occasional emails/texts.</label>
                         </div>
                   </div>
                   <div class="col-sm-12">&nbsp;</div>
                  </div>
                </cfif>
                   <div style="padding-bottom: 55px;" class="form-group">
                     <div class="col-sm-offset-4 col-sm-3">
                       <button name="Login" class="btn btn-danger btn-lg btn-block" id="Loginbtn1" tabindex="10">Submit</button>
                     </div>
                   </div>

			</cfoutput>

            </form>
  </div>
</div>

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
