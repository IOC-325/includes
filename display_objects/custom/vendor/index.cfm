<CFSET structDelete(session, "TheVendTin")>

<script language="JavaScript"><!--

  function OpenHelp (ErrorNo,Section) {
      mywindow =
      window.open("#application.webroot#/vendors/help/?ErrorNo=" + ErrorNo+ "&Section=" + Section, "Help", "location=1,status=1,scrollbars=1,width=275,height=275");

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
        <cfif not isdefined("form.Captcha")>
            <cfset ErrorNo = ListAppend(ErrorNo, "07A")>
        <cfelseif form.Captcha is not hash(form.captchaAnswer)>
            <cfset ErrorNo = ListAppend(ErrorNo, "07B")>
        </cfif>

        <cfif (trim(form.NotificationType) is "Email" or trim(form.NotificationType) is "Both") and trim(form.Email) is "" and trim(form.NotificationType) is "Email">
            <cfset ErrorNo = ListAppend(ErrorNo, "05B")>
        <cfelseif (trim(form.NotificationType) is "Email" or trim(form.NotificationType) is "Both") and trim(form.Email) is not "">
            <cfif not isValid("email", form.Email)>
              <cfset ErrorNo = ListAppend(ErrorNo, "05A")>
            </cfif>
        </cfif>

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

        <cfif ((trim(form.NotificationType) is "Text" or trim(form.NotificationType) is "Both") and trim(form.MobileProvider) is "None")>
            <cfset ErrorNo = ListAppend(ErrorNo, "03B")>
        </cfif>

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
        <cfif not isdefined("form.Captcha")>
            <cfset ErrorNo = ListAppend(ErrorNo, "07A")>
        <cfelseif form.Captcha is not hash(form.captchaAnswer)>
            <cfset ErrorNo = ListAppend(ErrorNo, "07B")>
        </cfif>

        <cfif trim(ErrorNo) is "">

          <CFSET session.TheVendTin = Encrypt(form.VendTIN,'ITBG111')>
      <cfset TmpVendTIN = encrypt(form.VendTIN,"ITBG111")>
            <!--- <cfset TmpVendTIN = #encrypt(form.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#> --->
            <!---<cfset TmpVendTIN = #encrypt("123456", application.theKey, application.theAlgor, application.TheEncode)#>

            <cflocation url="/vendors/vendor-payments-new/vendor-summary/?Mode=Login&NotificationType=None&SVendTIN=#UrlEncodedFormat(Encrypt(form.VendTIN,'ITBG111'))#&VENDTINNAME=#URLEncodedFormat(form.VendTINName)#&Rk=1" addtoken="No">--->
              <cflocation url="/vendors/vendor-payments-new/vendor-warrant-list?&Mode=ContForm&NotificationType=None&SVendTIN=#UrlEncodedFormat(Encrypt(form.VendTIN,'ITBG111'))#&VENDTINNAME=#URLEncodedFormat(form.VendTINName)#&Agency=All&AscDesc=Desc&FindContracts=Find Contracts&FY=#application.cfy#&Max=20&POType=All&SortBy=Contract Number&ContSel=" addtoken="No">             
        </cfif>
    </cfif>
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

<div class="home-panel panel panel-default">
  <div class="panel-heading text-center"><h4 class="text-uppercase">Vendor Payments</h4></div>
  <div class="panel-body">
    <p class="home-form-property-desc">
    This system allows State of Illinois vendors and
    commercial payees to view and download detailed, non-confidential remittance information for payments issued by the State of Illinois. Both payment and contract details can also be accessed. Please provide your Taxpayer Identification Number and either the Name of Business
    or your Last and First name (Last, First) to display payment information.</p>

    <cfset ListSorted = "#ListSort("#ListofGlyphicons#","numeric","asc")#">

    <CFIF isDefined("NotFound")>
      <div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
        <b>Sorry, but no vendors were found for that Vendor TIN / Vendor Name combination.</B>  Please verify the TIN and try again.
      </div>

    <cfelseif trim(ErrorNo) is not "">
      <div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
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
      <div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
        <b>You have been unsubscribed!</b>
      </div>
    </cfif>

                <form id="VendorForm" role="form" class="form-horizontal" name="Vendor" action="/vendors/" method="post">
                  <cfoutput>
                  <INPUT TYPE="hidden" NAME="Mode" VALUE="Login">

                  <div class="form-group row">
                      <div class="col-sm-5 col-md-4">
                          <label for="inputPassword3" class="control-label">Vendor TIN:</label>
                      </div>
                      <div class="col-sm-7 col-md-8">
                          <div <cfif listfind(ErrorNo,"01A") or listfind(ErrorNo,"01B")>class="has-error"<cfelse>class=""</cfif>>
                              <input placeholder="999999999" name="VendTIN" autocomplete="off" id="VendTIN2" class="form-control text-input" tabindex="1" data-original-title="" title="" type="password" style="display: inline-block;" >
                              &nbsp;<input id="toggle" onchange="togglePassword(this,document.getElementById('VendTIN2'),document.getElementById('toggleTextPwd'));" type="checkbox" value="0" style="vertical-align: middle;" /><span id="toggleTextPwd" style="display: inline-block;margin: 5px 0 0 5px;vertical-align: middle;
    font-size: 12px;">Show</span>
                          </div>
                      </div>
                  </div>

                  <div class="form-group row">
                      <div class="col-sm-5 col-md-4">
                          <label for="Vendor_TIN_Name" id="Vendor_TIN_Namelbl" class="control-label">Vendor Name: </label>
                      </div>
                      <div class="col-sm-7 col-md-8" <cfif listfind(ErrorNo,"02A")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                              <input <cfif not listfind(ErrorNo,"02A")>id="VendorTINName"<cfelse>id="VendorTINNameRed"</cfif> name="VendTINName" autocomplete="off" class="form-control text-input" tabindex="2" data-original-title="" <cfif trim(form.VendTINName) is not "">value="#form.VendTINName#"</cfif> title="" type="text">
                      </div>

                  </div>

                  <div class="text-center">
                   <cfStoredProc datasource="VendorPayment" Procedure="Get_GlyphiconsByNumber">
                          <cfprocparam type="In"  cfsqltype="cf_sql_integer" dbvarname="@GlyphiconNumber" value="#TargetGlyphicons#">
                          <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetGlyphiconsByNumberRetVal">
                          <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetGlyphiconsByNumberRetMsg">
                          <cfprocresult name="GetGlyphiconsByNumber">
                      </cfstoredproc>
                      Security Verification!: Select the <b>#GetGlyphiconsByNumber.GlyphiconsDescription#</b> . <a href="/vendors/enhanced-vendor-remittance1/captcha-help/" target="_new"><b>(What is this?)</b></a>
                  </div>

                    <cfset TmpCaptcha="#GetGlyphiconsByNumber.GlyphiconsDescription#">
                    <input type="hidden" name="CaptchaAnswer" value="#GetGlyphiconsByNumber.GlyphiconsDescription#">
                    <cfset CaptchaNo=1>
                    <cfset tbIndex=3>
                    <div <cfif listfind(ErrorNo,"01A") or listfind(ErrorNo,"01B") or listfind(ErrorNo,"02A") or listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B") or listfind(ErrorNo,"04A") or listfind(ErrorNo,"05A") or listfind(ErrorNo,"05B") or listfind(ErrorNo,"06A") or listfind(ErrorNo,"06B") or listfind(ErrorNo,"07A") or listfind(ErrorNo,"07B")>class="input-group has-error margintop10"<cfelse>class="input-group margintop10"</cfif>>
                      <cfloop index="i" list="#ListSorted#">
                        <cfStoredProc datasource="VendorPayment" Procedure="Get_GlyphiconsByNumber">
                            <cfprocparam type="In"  cfsqltype="cf_sql_integer" dbvarname="@GlyphiconNumber" value="#i#">
                            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetGlyphiconsByNumberRetVal">
                            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetGlyphiconsByNumberRetMsg">
                            <cfprocresult name="GetGlyphiconsByNumber">
                        </cfstoredproc>

                       <span class="input-group-addon pull-center text-center"><input type="radio" tabindex="#tbIndex#"  name="Captcha" id="AddCaptcha#CaptchaNo#" value="#Hash(trim(GetGlyphiconsByNumber.GlyphiconsDescription))#">&nbsp;<i class="#GetGlyphiconsByNumber.GlyphiconsName#"></i></span><cfset CaptchaNo=CaptchaNo+1>
                       <cfset tbIndex=tbIndex + 1>
                      </cfloop>
                    </div>
                    <!-- TAGS INPUT -->

                <div class="text-center">
                  <button name="Login" class="btn btn-label btn-sm btn-login" id="Submitbtn2" tabindex="8" data-original-title="" title="">Submit</button>
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

  $('#Submitbtn2').tooltip({
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
