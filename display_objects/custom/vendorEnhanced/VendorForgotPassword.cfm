
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

<!---
Date Created: 8-6-12
Created By: Gary Ashbaugh

	Modification Date: 11-7-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site

Description:  The program will allow the user to tell us what Security Question and Security Answer he/she gave us
	when he/she changed his/her password.  If the user has validated his/her E-Mail and supplies us with the correct
	Security Question/Answer then the program will set AuthResetCd for the user record and send out an E-Mail to them that allows him/her
	to change his/her own password.
--->

 <!--- Remove when application.cfc gets fixed --->
<cfinclude template="TmpVendorapplicationSettings.cfm">
<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<cfparam name="url.ResetAuthCd" default=" ">
<cfparam name="url.SystemMessage2" default=" ">
<cfparam name="url.AdmLevel" default="N">
<cfparam name="url.VendTIN" default="">
<cfparam name="url.Email" default="">

<cfparam name="variables.Error" default="">

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

<cfif ParameterExists(form.ForgotPassword)>

    <cfoutput>
        <cfStoredProc  datasource="#application.VendorPayments#" Procedure="Check_ValidUser">
        	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@EMail" value="#trim(form.EMail)#">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SecurityQuestion" value="#trim(form.SecurityQuestion)#">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SecurityAnswer" value="#trim(form.SecurityAnswer)#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckValidUserRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckValidUserRetMsg">
    		<cfprocresult name="CheckValidUser">
    	</cfstoredproc>
    </cfoutput>
    <cfif CheckValidUserRetVal is 0>

        <cfoutput>
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

             <cfStoredProc datasource="#application.VendorPayments#" Procedure="Reset_UserPassword">
                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@EMail" value="#CheckValidUser.EMail#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" value="#TmpResetAuthCd#">
                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="ResetUserPasswordRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="ResetUserPasswordRetMsg">
                <cfprocresult name="ResetUserPassword">
            </cfstoredproc>

            <cfif ResetUserPasswordRetVal eq 0>

                <CFMail to="#trim(form.EMail)#" 
                    from="#application.VendorRemitEmail#"
                    subject="Secure Enhanced Vendor Remittance Change Password"
                    type="html" <!---server="ioc-web-edge" port="25"--->>
                    <P>This is an automated E-Mail sent to you by the Illinois Office of the Comptroller.  It is being sent to you from the State of Illinois Comptroller's Secure Enhanced Vendor Remittance Site.<br><br>Please click on <a href='#application.EVRSite#/vendors/enhanced-vendor-remittance/change-password?ResetAuthCd=#TmpResetAuthCd#&DtChngEmailSent=#dateformat(now(),"mm/dd/yyyy")#&ForgotPassword=Yes'>Change Password</a> to create your own personal password.  If the "Change Password" link does not work, you will need to copy and paste this link into your Internet Browser's Internet Site Address.     #application.EVRSite#/vendors/enhanced-vendor-remittance/change-password?ResetAuthCd=#TmpResetAuthCd#&DtChngEmailSent=#dateformat(now(),"mm/dd/yyyy")#&ForgotPassword=Yes  <br /><br />Your Password must be between 6-25 characters in length.  You will need to change it every 30 days and you can NOT use the same password that you have used in the last 10 times.  If you forget your password, please contact your Coordinator to have it reset.  If you have received this E-Mail by mistake, please contact our office at <a href="Mailto:#application.SecAdmEmail#?Subject=Secure Enhanced Vendor Remittance Registration">#application.SecAdmEmail#</a> or contact our office at #application.SecAdmPhone#.
                    <br><br>
                    Thank You,
                    <br><br><Br><Br>
                    Illinois Office of the Comptroller</P>
                    <BR>
                    <BR>
                </cfmail>  
                <cfset variables.Error = "0"                      >
               <!--- <cflocation url="/vendors/enhanced-vendor-remittance/change-password?ResetAuthCd=#TmpResetAuthCd#&DtChngEmailSent=#dateformat(now(),"mm/dd/yyyy")#&ForgotPassword=Yes" addtoken="No"> --->
            </cfif>
        </cfoutput>        
	<cfelse>
    	<!--- Send the user back because information doesn't match with what we have on file --->
		<!--- <cflocation url="https://illinoiscomptroller.gov/vendors/" addtoken="No"> --->
        <cfset variables.Error = "-1">
    </cfif>
<!--- <cfelse> --->
</cfif>    
    <cfif variables.Error EQ "-1">
        <div class="alert alert-danger col-sm-12"> 
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> <b>Invalid E-mail or security Question/Answer combo. Please enter accurate information to proceed!</b>
        </div>
    </cfif>

    <cfif variables.Error EQ "0">
        <div class="alert alert-success col-sm-12"> 
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> <b>Email hasbeen sent sucessfully!. Click here to <a href="/vendors/">return</a></b>
        </div>
    </cfif>          

	<cfoutput>
	<cfStoredProc  datasource="#application.VendorPayments#" Procedure="Get_SecurityQuestions">
   	 	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetSecurityQuestionsRetVal">
    	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetSecurityQuestionsRetMsg">
    	<cfprocresult name="GetSecurityQuestions">
	</cfstoredproc>
	</cfoutput>

	<!--- User must supply us with valid information --->

	<p id="Instructions" class="marginb20">If you have forgotten your password and have validated your E-Mail address with us, you can reset your password without having to contact either your Vendor Coordinaor or Illinois Office of the Comptroller.  Simply enter your E-Mail address, Tell us what "Security Question" you selected the last time you changed your password, tell us the answer to that security question, and click on the "Forgot Password" button. An E-Mail with an embedded hyperlink will be sent to you. Click on that hyperlink and you will be taken to the "Create Password" screen.</p>

        <div class="alert alert-info col-sm-12"> 
           <b>"E-Mail address",  "Security Question" and  "Security Answer" should match our records.</b>
        </div>

	<form role="form" class="form-horizontal" method="POST" name="ForgotPassword" action="/vendors/enhanced-vendor-remittance/forgot-my-password/">
    <cfoutput>
    <input type="hidden" name="ResetAuthCd" value="#url.ResetAuthCd#">
	<div class="form-group">
        <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
            <label for="EMail" id="EMaillbl" class="control-label">E-Mail</label>
        </div>
        <div class="col-sm-5">
            <div  class="input-group">
            <input type="text" required class="form-control"  autocomplete="off" id="Email" name="Email" c>
            <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
            </div>
        </div>
	</div>

    <div class="form-group">
        <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
            <label for="SecurityQuestion" id="SecurityQuestionlbl" class="control-label">Security Question</label>
        </div>
        <div class="col-sm-5">
            <select name="SecurityQuestion" class="form-control" required  id="SecurityQuestion">
        		<Option Value="">&nbsp;</option>
                <Cfloop query="GetSecurityQuestions">
                	<Option Value="#trim(SecurityQuestion)#">#trim(SecurityQuestion)#</option>
                </Cfloop>
            </select>
        </div>
	</div>

    <div class="form-group">
        <div class="col-sm-offset-1 col-sm-4 col-md-offset-2 col-md-3">
            <label for="SecurityAnswer" id="SecurityAnswerlbl" class="control-label">Security Question's Answer</label>
        </div>
        <div class="col-sm-5">
            <div class="control">
            <input type="text" required class="form-control"  autocomplete="off" id="SecurityAnswer" name="SecurityAnswer" >
            </div>
        </div>
	</div>

    <div class="form-group">
      	<div class="text-center">
     	<button name="ForgotPassword" id="ForgotPasswordbtn" VALUE="Forgot Password" <!---class="btn btn-custom-primary btn-sm btn-block btn-login"---> class="btn btn-success" tabindex="21">Forgot Password</button>
        </div>
    </div>
    </cfoutput>

    </form>

<!--- </cfif> --->

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>


<script>
	$('#Email').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter the Email address you gave to us when you registered."
	});
	$('#ForgotPasswordbtn').tooltip({
            'show': false,
                'placement': 'top',
                'title': "After you supplied your E-Mail address, Security Question and Security Question's Answer, click here to be taken to the Change Your Password screen."
        });
	$('#SecurityQuestion').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the Security Question you selected the last time you changed your password."
	});
	$('#SecurityAnswer').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter the answer to the Security Question which you supplied the last time you changed your password."
	});
</script>

<!---</body>

</html>--->
