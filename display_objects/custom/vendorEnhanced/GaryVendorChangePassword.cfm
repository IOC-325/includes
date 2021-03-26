
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
Modifications Made:  Allow user's of the Enhanced Vendor Payment Inquiry site to change their own personal password

Modification Date: 11-7-14
Modified By: Gary Ashbaugh
Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site

Description: Allows the user to change his/her password
--->


<cfLock Scope="SESSION" TIMEOUT="120">
<cfparam name="url.SystemMessage2" default=" ">
<cfparam name="Session.AdmLevel" default="N">
<cfparam name="Session.VendTIN" default="">
<cfparam name="Session.Number_Code" default="">
</cfLock>



<!--- Remove when application.cfc gets fixed --->
<cfinclude template="TmpVendorapplicationSettings.cfm">
<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
<!---<cfif not isdefined("Session.VendTIN") and trim(url.ResetAuthCd) is "">--->
<cfif ((not isdefined("Session.EMail")) and (not isdefined("url.ResetAuthCd")))>
	<!--- Calls Index from VendorEnhanced --->
    <!--- Development & Production --->
    <cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
    
</cfif>
</cfLock>


<!---<cfif not isdefined("application.theKey")>

        <cfset depth=5>
        <cfinclude template="#repeatString('../',depth)#config/applicationSettings.cfm">	
</cfif>--->


<cfif ParameterExists(ChangePassword)>

	<cfif UCase(form.NewPassword) is not UCase(form.NewPassword2)>
    	<!---<cfset SystemMessage2="Passwords do not match. Please check your spelling and try again.">--->
        <!--- Calls VendorChangePassword in VendorEnhanced --->
        <!--- Development & Production --->
        <cflocation url="/vendors/enhanced-vendor-remittance/gary-change-password/?ResetAuthCd=#form.ResetAuthCd#&DtChngEmailSent=#form.DtChngEmailSent#&SystemMessage2=Passwords do not match. Please check your spelling and try again." addtoken="No">
    
    <cfelseif len(trim(form.NewPassword)) lt 6 or len(trim(form.NewPassword)) gt 25>
    	<!---<cfset SystemMessage2="Passwords must be beween 6 and 25 characters.  Please enter a new password!">--->
        <cfif isdefined("form.Email")>
        	<!--- Calls VendorChangePassword in VendorEnhanced --->
            <!--- Development & Production --->
        	<cflocation url="/vendors/enhanced-vendor-remittance/gary-change-password/?SystemMessage2=Passwords must be beween 6 and 25 characters.  Please enter a new password!" addtoken="No">
        <cfelse>
        	<!--- Calls VendorChangePassword in VendorEnhanced --->
            <!--- Development & Production --->
            <cflocation url="/vendors/enhanced-vendor-remittance/gary-change-password/?ResetAuthCd=#form.ResetAuthCd#&DtChngEmailSent=#form.DtChngEmailSent#&SystemMessage2=Passwords must be beween 6 and 25 characters.  Please enter a new password!" addtoken="No">
        </cfif>
        
    <cfelseif (trim(form.SecurityQuestion) is "") or (trim(form.SecurityAnswer) is "")>
        
        	<!--- Calls VendorCreatePassword in VendorEnhanced --->
            <!--- Development & Production --->
            <cflocation url="/vendors/enhanced-vendor-remittance/gary-change-password/?ResetAuthCd=#form.ResetAuthCd#&DtChngEmailSent=#form.DtChngEmailSent#&SystemMessage2=You must select a Security Question and supply an answer to the Security Question!" addtoken="No">
   
	<cfelse>     
     
        <!---<cftry>--->
		<cfoutput>
  		form.EMail=#form.EMail#<br>
        form.Password=#form.NewPassword#<br>
        form.ResetAuthCd=#form.ResetAuthCd#<br>
        form.SecurityAnswer=#form.SecurityAnswer#<br>
        form.SecurityQuestion=#form.SecurityQuestion#<br>
        form.DtChngEmailSent=#form.DtChngEmailSent#<br>
		<cfabort>
        
        <cfset TmpPassword = "#encrypt(form.NewPassword, application.theKey, application.theAlgor, application.TheEncode)#">
		<!---TmpPassword=#TmpPassword#<br>--->
		<cfStoredProc datasource="#application.VendorPayments#" Procedure="Change_Password">
        	<cfif isdefined("form.EMail")>
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@EMail" value="#form.EMail#">
            <cfelse>
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@EMail" null="yes">
           	</cfif>
			<cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@Password" value="#TmpPassword#">
            <!---<cfif isdefined("form.ResetAuthCd")>
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" value="#form.ResetAuthCd#">
            <cfelse>
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@ResetAuthCd" null="Yes">
            </cfif>--->
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
           
			<!--- Calls VendorChangePassword from VendorEnhanced --->
            <cflocation url="/vendors/enhanced-vendor-remittance/gary-change-password/?ResetAuthCd=#form.ResetAuthCd#&DtChngEmailSent=#form.DtChngEmailSent#&PasswordChanged=No&SystemMessage2=#ChangePasswordRetMsg#" addtoken="No">

		<cfelse>
           <!--- Password changed...take to summary page --->
           <cfif isdefined("form.ResetAuthCd")>
           		<cflocation url="/vendors/enhanced-vendor-remittance?PasswordChanged=Yes" addtoken="No">
            <cfelse>
            	<cflocation url="/vendors/enhanced-vendor-remittance/vendor-summary/?Mode=Summ&ValUser=True&PasswordChanged=Yes" addtoken="No">
            </cfif>
		</cfif>
		
		</cfoutput>

	</cfif>
</cfif>
    
    	<cfoutput>
		<cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_SecurityQuestions">
    		<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetSecurityQuestionsRetVal">
    		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetSecurityQuestionsRetMsg">
    		<cfprocresult name="GetSecurityQuestions">
		</cfstoredproc>
		</cfoutput>
        
        <cfif isdefined("Session.Email")>
			<cfoutput>
            <cfStoredProc datasource="#application.VendorPayments#" Procedure="Get_UserInfo">
                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@EMail" value="#Session.Email#">
                <cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@TaxpayerIdNo" value="#Session.VendTIN#">
                <cfif isdefined("Session.Number_Code")>
                    <cfprocparam type="In"  cfsqltype="CF_SQL_char"  dbvarname="@Number_Code" value="#trim(Session.Number_Code)#">
                <cfelse>
                    <cfprocparam type="In"  cfsqltype="CF_SQL_char"  dbvarname="@Number_Code" null="yes">
                </cfif>
                <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetuserInfoRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetuserInfoRetMsg">
                <cfprocresult name="GetUserInfo">
            </cfstoredproc>
            </cfoutput>
        
        </cfif>
     
		<!---<CFINCLUDE TEMPLATE="VendHeader.cfm">--->
    	<div class="col-sm-12">&nbsp;</div>
        <cfif not $.content().getURL() contains "/vendors/enhanced-vendor-remittance/gary-change-password/">
            <div class="col-sm-12 pull-right">
            	<cfif isdefined("ChangePasswordRequired")>
                	<cfoutput><a href="/vendors/" id="Cancel"><span class="input-group-addon pull-left"><i class="glyphicon glyphicon-share-alt"  ></i></span>Cancel</a></cfoutput>
                <cfelse>
                	<cfif isdefined("Session.Number_Code")>
					<!---<cfif Session.Number_Code is "4">--->
                        <!--- Return to Deduction Form --->
                        
                        <cfoutput><a href="/vendors/enhanced-vendor-remittance/vendor-deduction-form/" id="Cancel"><span class="input-group-addon pull-left"><i class="glyphicon glyphicon-share-alt"  ></i></span>Cancel</a></cfoutput>
                    <cfelse>
                        <!--- Return to Vendor Summary --->
                        <cfoutput><a href="/vendors/enhanced-vendor-remittance/vendor-summary/?Mode=Summ&ValUser=True" id="Cancel"><span class="input-group-addon pull-left"><i class="glyphicon glyphicon-share-alt"  ></i></span>Cancel</a></cfoutput>
                    </cfif>
                  </cfif>
            </div>
        </cfif>
       
    	<div class="col-sm-12">
        To change your personal password, enter your desired password in the "New Password", "Re-Enter" fields and click the "Change Password" button.  Your password must be between 6-25 characters in length.  Also, you can NOT use a password that you have used in the last 10 times.  Passwords are case-sensitive.  You must also select a Security Question and supply us with your answer so we can allow you to change your own password if you forget it.
        </div>
        <div class="col-sm-12">&nbsp;</div>
        <!---<div name="FormWrapper" id="FormWrapper" class="col-sm-12">--->
		
        <!--- Development & Production --->
        <form role="form" class="form-horizontal" method="POST" name="ChangePassword" action="/vendors/enhanced-vendor-remittance/gary-change-password/">
        <cfoutput>
        <div class="col-sm-12">
        
        
        <Cfif isdefined("url.ResetAuthCd")>
        	<input type="hidden" name="ResetAuthCd" value="#url.ResetAuthCd#">
      	<Cfelse>
            <input type="hidden" name="EMail" value="#Session.EMail#">
            <input type="hidden" name="TaxpayerIdNo" value="#Session.VendTIN#">
            <input type="hidden" name="ResetAuthCd" value="">
        </Cfif>
        <cfif isdefined("url.DtChngEmailSent")>
    		<input type="hidden" name="DtChngEmailSent" value="#url.DtChngEmailSent#">
   		<cfelse>
    		<input type="hidden" name="DtChngEmailSent" value="#dateformat(now(),"mm/dd/yyyy")#">
    	</cfif>
   		
       		<p class="text-danger" align="left"><b>#SystemMessage2#</b></p>
		</div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-3">
                <label for="NewPassword" id="NewPasswordlbl" class="control-label">New Password: </label>
            </div>
            <div class="col-sm-3">
            	<div  class="input-group">
                <input type="Password" required class="form-control" id="NewPassword"  autocomplete="off" name="NewPassword" tabindex="1">
                <span class="input-group-addon"><i class="fa fa-lock"></i></span>
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
            	<div  class="input-group">
                <input type="Password" required class="form-control" id="NewPassword2"  autocomplete="off" name="NewPassword2" tabindex="2">
                <span class="input-group-addon"><i class="fa fa-lock"></i></span>
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
                    	<cfif isdefined("GetUserInfo")>
                        	<Option Value="#trim(SecurityQuestion)#" <cfif trim(GetUserInfo.Security_Question) is trim(SecurityQuestion)>selected</cfif>>#trim(SecurityQuestion)#</option>
                      	<cfelse>
                        	<Option Value="#trim(SecurityQuestion)#">#trim(SecurityQuestion)#</option>
                        </cfif>
                  	</Cfloop>
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
            	<cfif isdefined("GetUserInfo")>
                	<input type="text" required id="SecurityAnswer" name="SecurityAnswer" value="#GetUserInfo.Security_Answer#" class="form-control"  tabindex="4">
              	<cfelse>
                	<input type="text" required id="SecurityAnswer" name="SecurityAnswer" class="form-control"  tabindex="4">
                </cfif>
            </div>
            <div class="col-sm-4">&nbsp;</div>
        </div>
        <!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
        <!---<div class="form-group">--->
            <div class="col-sm-offset-5 col-sm-3">
            <button name="ChangePassword" id="ChangePasswordbtn" VALUE="Change Password" <!---class="btn btn-custom-primary btn-sm btn-block btn-login"---> class="btn btn-danger btn-sm btn-block" tabindex="5"> Change Password</button>
            </div> 
        <!---</div>--->
        <div col-sm-12">&nbsp;</div>
        </cfoutput>
          
        </form> 
  
       <!--- </div>--->
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    

<script>
	$('#NewPassword').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter a password between 6 and 25 characters.  Passwords will expire every 30 days.  You can not re-use a password you have used in the last 10 password changes."
	});
	$('#NewPassword2').tooltip({
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
	$('#ChangePasswordbtn').tooltip({
		'show': false,
			'placement': 'top',
			'title': "After you supplied your Password, re-Entered it, supplied us with your Security Question and Security Question's Answer, click here to be Change Your Password."
	});
</script>

<!---</body>

</html>--->
