<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

<!---
Date Modified: 4-18-12
Modified By: Gary Ashbaugh
Modifications Made:  Allow user's of the Enhanced Vendor Payment Inquiry site to create their own personal password

Modification Date: 11-7-14
Modified By: Gary Ashbaugh
Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site

Description: Allows the user to create his/her own password.
--->


 <!--- Remove when application.cfc gets fixed --->
<cfinclude template="TmpVendorapplicationSettings.cfm">
<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">


<!---<cfif not isdefined("application.theKey")>

        <cfset depth=5>
        <cfinclude template="#repeatString('../',depth)#config/applicationSettings.cfm">
</cfif>--->


<cfparam name="url.ResetAuthCd" default=" ">
<cfparam name="SystemMessage2" default=" ">
<cfparam name="url.AdmLevel" default="N">
<cfparam name="SystemMessage3" default=" ">
<cfparam name="url.VendTIN" default="">
<cfparam name="url.Email" default="">
<cfparam name="url.DtChngEmailSent" default="">


<CFIF IsDefined ("URL.ResetAuthCd")>
 <CFSET ResetAuthCd = URL.ResetAuthCd>
<cfelseif IsDefined ("form.ResetAuthCd")>
 <CFSET ResetAuthCd = form.ResetAuthCd>
<cfelseif IsDefined ("ResetAuthCd")>
 <CFSET ResetAuthCd = ResetAuthCd>
</CFIF>

<CFIF IsDefined ("URL.SystemMessage2")>
 <CFSET SystemMessage2 = URL.SystemMessage2>
<cfelseif IsDefined ("form.SystemMessage2")>
 <CFSET SystemMessage2 = form.SystemMessage2>
<cfelseif IsDefined ("SystemMessage2")>
 <CFSET SystemMessage2 = SystemMessage2>
</CFIF>

<CFIF IsDefined ("URL.AdmLevel")>
 <CFSET AdmLevel = URL.AdmLevel>
<cfelseif IsDefined ("form.AdmLevel")>
 <CFSET AdmLevel = form.AdmLevel>
<cfelseif IsDefined ("AdmLevel")>
 <CFSET AdmLevel = AdmLevel>
</CFIF>

<CFIF IsDefined ("URL.SystemMessage3")>
 <CFSET SystemMessage3 = URL.SystemMessage3>
<cfelseif IsDefined ("form.SystemMessage3")>
 <CFSET SystemMessage3 = form.SystemMessage3>
<cfelseif IsDefined ("SystemMessage3")>
 <CFSET SystemMessage3 = SystemMessage3>
</CFIF>

<CFIF IsDefined ("URL.VendTIN")>
 <CFSET VendTIN = URL.VendTIN>
<cfelseif IsDefined ("form.VendTIN")>
 <CFSET VendTIN = form.VendTIN>
<cfelseif IsDefined ("VendTIN")>
 <CFSET VendTIN = VendTIN>
</CFIF>

<CFIF IsDefined ("URL.Email")>
 <CFSET Email = URL.Email>
<cfelseif IsDefined ("form.Email")>
 <CFSET Email = form.Email>
<cfelseif IsDefined ("Email")>
 <CFSET Email = Email>
</CFIF>

<CFIF IsDefined ("URL.DtChngEmailSent")>
 <CFSET DtChngEmailSent = URL.DtChngEmailSent>
<cfelseif IsDefined ("form.DtChngEmailSent")>
 <CFSET DtChngEmailSent = form.DtChngEmailSent>
<cfelseif IsDefined ("DtChngEmailSent")>
 <CFSET DtChngEmailSent = DtChngEmailSent>
</CFIF>


<cfif ParameterExists(form.ChangePassword)>
	<cfif UCase(form.NewPassword) is not UCase(form.NewPassword2)>
            <cflocation url="/vendors/enhanced-vendor-remittance/create-password/?ResetAuthCd=#form.ResetAuthCd#&DtChngEmailSent=#form.DtChngEmailSent#&SystemMessage3=Passwords do not match. Please check your spelling and try again." addtoken="No">

    <cfelseif len(form.NewPassword) lt 6 or len(form.NewPassword) gt 25>
    	<!---<cfset SystemMessage2="Passwords must be beween 6 and 25 characters.  Please enter a new password!">--->

            <cflocation url="/vendors/enhanced-vendor-remittance/create-password/?ResetAuthCd=#form.ResetAuthCd#&DtChngEmailSent=#form.DtChngEmailSent#&SystemMessage3=Passwords must be beween 6 and 25 characters.  Please enter a new password!" addtoken="No">

	<cfelseif (trim(form.SecurityQuestion) is "") or (trim(form.SecurityAnswer) is "")>

        	<!--- Calls VendorCreatePassword in VendorEnhanced --->
            <cflocation url="/vendors/enhanced-vendor-remittance/create-password/?ResetAuthCd=#form.ResetAuthCd#&DtChngEmailSent=#form.DtChngEmailSent#&SystemMessage3=You must select a Security Question and supply an answer to the Security Question!" addtoken="No">


	<cfelse>
        <cftry>
		<cfoutput>

       <!--- form.NewPassword=#form.NewPassword#<br>
        form.ResetAuthCd=#form.ResetAuthCd#<br>
        form.SecurityQuestion=#form.SecurityQuestion#<br>
        form.SecurityAnswer=#form.SecurityAnswer#<br>
        form.DtChngEmailSent=#form.DtChngEmailSent#<br><cfabort>--->

		<cfStoredProc  datasource="#application.VendorPayments#" Procedure="Change_Password">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@EMail" null="Yes">
			<cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@Password" value="#form.NewPassword#">
            <cfif trim(form.ResetAuthCd) is not "">
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" value="#form.ResetAuthCd#">
            <cfelse>
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" null="Yes">
            </cfif>
            <cfif trim(form.SecurityQuestion) is not "" and trim(form.SecurityAnswer) is not "">
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SecurityQuestion" value="#form.SecurityQuestion#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SecurityAnswer" value="#form.SecurityAnswer#">
            <cfelse>
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SecurityQuestion" null="Yes">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SecurityAnswer" null="Yes">
            </cfif>
           <cfprocparam type="In"  cfsqltype="cf_sql_timestamp" dbvarname="@DtChngEmailSent" value="#form.DtChngEmailSent#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="ChangePasswordRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="ChangePasswordRetMsg">
            <cfprocresult name="ChangePassword">
		</cfstoredproc>



		<cfif ChangePasswordRetVal gt 0>

                <cflocation url="/vendors/enhanced-vendor-remittance/create-password/?ResetAuthCd=#form.ResetAuthCd#&DtChngEmailSent=#form.DtChngEmailSent#&SystemMessage2=#ChangePasswordRetMsg#" addtoken="No">


		<cfelse>
            <!--- Direct the user to the Login Screen --->
            <cflocation url="/vendors/enhanced-vendor-remittance?SystemMessage2=Password Changed" addtoken="No">

        </cfif>
		</cfoutput>
       <cfcatch type="any">
			 Direct the user to the Login Screen
        	<cflocation url="/vendors/enhanced-vendor-remittance?SystemMessage2=Opps, we could not change your password...You can NOT change your password via the Create Password E-Mail after you already changed it from that E-Mail&ResetAuthCd=#form.ResetAuthCd#&DtChngEmailSent=#form.DtChngEmailSent#" addtoken="No">

        </cfcatch>
		</cftry>

	</cfif>

<cfelse>

	<!--- Validate the user's Email address --->
	<cfif isdefined("url.ValidateEmail")>
    	<cfoutput>
		<!--- Check to see if we need to send out a "Verify Your E-Mail" --->
        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_UserInfoByEmail">
            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#trim(Url.Email)#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUserInfoRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GEtUserInfoRetMsg">
            <cfprocresult name="GetUserInfo">
        </cfstoredproc>
        <cfif GetUserInfoRetVal is 1>
        	<div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>We do not show #url.Email# as being registered to use the Enhance Vendor application.</b>
            </div><cfabort>
        </cfif>
        <cfif trim(GetUserInfo.DtPasswordChged) is "">
            <cfset TmpResetAuthCd = "#CreateUUID()#">
            <cfset TestUnique=0>

            <cfloop condition="TestUnique greater than 0">

                <cfStoredProc  datasource="#application.VendorPayments#" Procedure="Check_ResetAuthCd">
                    <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" value="#TmpResetAuthCd#">
                    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckResetAuthCdRetVal">
                    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckResetAuthCdRetMsg">
                    <cfprocresult name="CheckResetAuthCd">
                </cfstoredproc>

                <cfif CheckResetAuthCdRetVal gt 0>
                    <cfset TmpResetAuthCd = "#CreateUUID()#">
                <cfelse>
                    <cfset TestUnique=1>
                </cfif>
            </cfloop>

            <cfStoredProc datasource="#application.VendorPayments#" Procedure="Validate_EmailInfo">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@EMail" value="#url.EMail#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@DtValidated" value="#DateFormat(now(),"mm/dd/yyyy")#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" value="#TmpResetAuthCd#">
                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="ValidateEmailInfoRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="ValidateEmailInfoRetMsg">
                <cfprocresult name="ValidateEmailInfo">
            </cfstoredproc>

            <cfif ValidateEmailInfoRetVal is 0>
            	<div class="alert alert-success col-sm-12"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                <b>Thank you for validating your E-Mail address with the Illinois Office of the Comptroller!</b>
                </div>

            <cfelse>
            	<div class="alert alert-success col-sm-12"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                <b>Thank you for validating your E-Mail address with the Illinois Office of the Comptroller!</b>
                </div>

           </cfif>

        <cfelse>
            <!--- Password already set --->
             <cfStoredProc datasource="#application.VendorPayments#" Procedure="Validate_EmailInfo">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@EMail" value="#url.EMail#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@DtValidated" value="#DateFormat(now(),"mm/dd/yyyy")#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" null="yes">
                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="ValidateEmailInfoRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="ValidateEmailInfoRetMsg">
                <cfprocresult name="ValidateEmailInfo">
            </cfstoredproc>


            <cfif ValidateEmailInfoRetVal is 0>
            	<!--- Development & Production --->
                <cflocation url="/vendors/enhanced-vendor-remittance?Email=#url.EMail#&ResetAuthCd=#ResetAuthCd#&DtChngEmailSent=#Dateformat(now(),"mm/dd/yyyy")#&SystemMessage2=E-Mail Validated" addtoken="No">

            <cfelseif ValidateEmailInfoRetVal is 1>
            	<!--- Development & Production --->
                <cflocation url="/vendors/enhanced-vendor-remittance?Email=#url.EMail#&ResetAuthCd=#ResetAuthCd#&DtChngEmailSent=#Dateformat(now(),"mm/dd/yyyy")#&SystemMessage2=E-Mail Validated" addtoken="No">

            <cfelse>
            	<!--- Development & Production --->
            	<cflocation url="/vendors/enhanced-vendor-remittance?Email=#url.EMail#&ResetAuthCd=#ResetAuthCd#&DtChngEmailSent=#Dateformat(now(),"mm/dd/yyyy")#&SystemMessage2=E-Mail Validated" addtoken="No">
             </cfif>

        </cfif>
        </cfoutput>
    </cfif>

	<cfoutput>
    <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_SecurityQuestions">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetSecurityQuestionsRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetSecurityQuestionsRetMsg">
        <cfprocresult name="GetSecurityQuestions">
    </cfstoredproc>
    </cfoutput>

    <cfif trim(url.ResetAuthCd) is "">
		<cfoutput>
        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_UserInfoByEmail">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@EMail" value="#url.EMail#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetuserInfoRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetuserInfoRetMsg">
            <cfprocresult name="GetUserInfo">
        </cfstoredproc>
        </cfoutput>

    <cfelse>

    	<cfoutput>
        <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_UserInfoByResetCd">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" value="#url.ResetAuthCd#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetuserInfoRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetuserInfoRetMsg">
            <cfprocresult name="GetUserInfo">
        </cfstoredproc>
        </cfoutput>

    </cfif>

    <div class="col-sm-12">
    To create your personal password, enter your desired password in the "New Password", "Re-Enter" fields and click the "Create Password" button.  Your password must be between 6-25 characters in length.  Also, you can NOT use a password that you have used in the last 10 times.  Passwords are case-sensitive.  You must also select a Security Question and supply us with your answer so we can allow you to change your own password if you forget it.
    </div>
    <div class="col-sm-12">&nbsp;</div>

   <!--- <div name="FormWrapper" id="FormWrapper" class="col-sm-12">--->

	<!--- Development & Production --->
    <form role="form" class="form-horizontal" method="POST" name="CreatePassword" action="/vendors/enhanced-vendor-remittance/create-password/">
    <cfoutput>

    <input type="hidden" name="DtChngEmailSent" value="#DateFormat(now(),"mm/dd/yyyy")#">
	
    <cfif isdefined("TmpResetAuthCd")>
    	<input type="hidden" name="RESETAUTHCD" value="#TmpResetAuthCd#">
    <cfelseif isdefined("url.ResetAuthCd")>
    	<input type="hidden" name="RESETAUTHCD" value="#url.ResetAuthCd#">
    <cfelse>
    	<input type="hidden" name="RESETAUTHCD" value="None">
    </cfif>
    <cfif isdefined("url.ForgotPassword")>
    	<div class="alert alert-success col-sm-12"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
    	<b>Your Security Question/Answer has been validated.  You can now change your password.</b>
    	</div>
    <cfelse>
    	<cfif trim(SystemMessage2) is not "">
        	<div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
    		<b>#SystemMessage2#</b>
    		</div>
        </cfif>
    </cfif>

    <cfif trim(SystemMessage3) is not "">
    	<div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
    		<b>#SystemMessage3#</b>
    		</div>
    </cfif>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-3">
            <label for="NewPassword" id="NewPasswordlbl" class="control-label">New Password: </label>
        </div>
        <div class="col-sm-3">
             <div class="input-group passwordContainer">
                 <input name="NewPassword" type="password" maxlength="50" id="NewPassword" tabindex="1" class="form-control" autocomplete="off" placeholder="Password">
                 <label class="input-group-addon">
                     <input type="checkbox" style="display:none" onclick="(function(e, el){
                         document.getElementById('NewPassword').type = el.checked ? 'text' : 'password';
                          el.parentNode.lastElementChild.innerHTML = el.checked ? '<i class=\'glyphicon glyphicon-eye-close\'>' : '<i class=\'glyphicon glyphicon-eye-open\'>';
                          })(event, this)">
                     <span><i class="glyphicon glyphicon-eye-open"></i></span>
                 </label>
             </div>              
        </div>
        <div class="col-sm-4">&nbsp;</div>
	</div>
    <!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-3">
            <label for="NewPassword2" id="NewPassword2lbl" class="control-label">Re-Enter: </label>
        </div>
        <div class="col-sm-3">
             <div class="input-group passwordContainer">
                 <input name="NewPassword2" type="password" maxlength="50" id="NewPassword2" tabindex="2" class="form-control" autocomplete="off" placeholder="Password">
                 <label class="input-group-addon">
                     <input type="checkbox" style="display:none" onclick="(function(e, el){
                         document.getElementById('NewPassword2').type = el.checked ? 'text' : 'password';
                          el.parentNode.lastElementChild.innerHTML = el.checked ? '<i class=\'glyphicon glyphicon-eye-close\'>' : '<i class=\'glyphicon glyphicon-eye-open\'>';
                          })(event, this)">
                     <span><i class="glyphicon glyphicon-eye-open"></i></span>
                 </label>
             </div>               
        </div>
        <div class="col-sm-4">&nbsp;</div>
	</div>
    <!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-3">
            <label for="SecurityQuestion" id="SecurityQuestionlbl" class="control-label">Security Question: </label>
        </div>
        <div class="col-sm-3">
            <select name="SecurityQuestion" class="form-control" id="SecurityQuestion"  tabindex="3">
        		<Option Value="" Selected>&nbsp;</option>
                <Cfloop query="GetSecurityQuestions">
                	<Option Value="#trim(SecurityQuestion)#">#trim(SecurityQuestion)#</option></Cfloop>
         	</select>
        </div>
        <div class="col-sm-4">&nbsp;</div>
	</div>
    <!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
     <div class="form-group">
        <div class="col-sm-offset-2 col-sm-3">
            <label for="SecurityAnswer" id="SecurityAnswerlbl" class="control-label">Security Question's Answer: </label>
        </div>
        <div class="col-sm-3">
            <input type="text" required class="form-control" id="SecurityAnswer" name="SecurityAnswer" tabindex="4">
        </div>
        <div class="col-sm-4">&nbsp;</div>
	</div>
  <!---  <div class="form-control2 col-sm-12">&nbsp;</div>--->
	<!---<div class="form-group">--->
      	<div class="col-sm-offset-5 col-sm-3">
     	<button name="ChangePassword" id="CreatePassword" VALUE="Create Password" <!---class="btn btn-custom-primary btn-sm btn-block btn-login"---> class="btn btn-danger btn-sm btn-block" tabindex="5"> Create Password</button>
        </div>

    <!---</div>--->
    <div class="col-sm-12">&nbsp;</div>
    </cfoutput>

    </form>
<!---    </div>--->

</cfif>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>


<script>
	$('#CreatePassword').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter a password between 6 and 25 characters.  Passwords will expire every 30 days.  You can not re-use a password you have used in the last 10 password changes."
	});
	$('#CreatePassword2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Re-Enter the password which you entered above."
	});
	$('#SecurityQuestion').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the Security Question which you will be asked to supply if you ever use the Forgot My Password feature."
	});
	$('#SecurityAnswer').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter the answer to the Security Question which you will be asked to supply if you ever use the Forgot My Password feature."
	});
	$('#ChangePassword').tooltip({
            'show': false,
                'placement': 'top',
                'title': "After you supplied your Password, re-Entered it, supplied us with your Security Question and Security Question's Answer, click here to be Create Your Password."
        });
</script>

<!---</body>

</html>--->
