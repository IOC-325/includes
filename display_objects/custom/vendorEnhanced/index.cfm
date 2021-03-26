	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">
<!--- <cfif Compare(cgi.SERVER_PORT,443) and cgi.server_name does not contain "uat">
	<cflocation url="https://illinoiscomptroller.gov#cgi.path_info#?#cgi.query_string#" addtoken="false"/>
</cfif> --->


<SCRIPT LANGUAGE="Javascript">

	function HelpDoc() {

	 	remote = window.open("","remotewin","width=1000,height=800,scrollbars=1");
	remote.location.href = "#application.webroot#Comptroller/vendors/enhanced-vendor-remittance/instructions/";
		if (remote.opener == null) remote.opener = window;
	 	remote.opener.name = "opener";
	 }

	function RegisterMe() {
        document.getElementById("Mode").value ="Register";        
		window.location.href = "#application.webroot#vendors/enhanced-vendor-remittance/enhanced-vendor-registration/";
	}

    $(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
//-->

</SCRIPT>
<!---<body>--->

<cfoutput>

<cfparam name="url.SystemMessage2" default=" ">

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<div class="home-panel panel panel-default">
    <div class="panel-heading text-center"><h4 class="text-uppercase">Enhanced Vendor Remittance</h4></div>
    <div class="panel-body">
        <p class="home-form-property-desc">Enhanced Vendor Remittance (EVR) allows State of Illinois vendors and commercial payees to quickly and easily view and download detailed remittance information for payments issued by the State of Illinois.
        In addition to the information presented through Vendor Payments, EVR displays fields that would be included on the hard-copy warrant stub. These fields include confidential payment information, such as vendor address and payment text.
        Vendors must have authorized <strong><a href="https://illinoiscomptroller.gov/vendors/direct-deposit/">Direct Deposit</a></strong> in order to register for this system.<br />

            <!--- <br /> We strongly advise you to disable any password managers or auto-complete features within your browser as they are likely to create an error during login attempts. ---></p>


<!---         <div class="alert alert-info" id="UserGuide"> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>&nbsp;
            <b class="text-info"><a href="https://illinoiscomptroller.gov/comptroller/assets/file/instructions.pdf" target="_blank" class="alert-link">Please click here to open User Guide</a></b>
        </div> --->

         <CFIF isDefined("url.UserFound")>
         	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
             <b>Sorry, but you are not authorized to access the Secure Enhanced Vendor Remittance Site!</b>
             </div>
         </cfif>

         <CFIF isDefined("url.NotFound")>
         	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
            <b>Sorry, but there are no records associated with the Vendor you are authorized to view!</b>
             </div>
         </cfif>

         <CFIF isDefined("url.InvalidUser")>
         	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
             <b>Sorry, but either you gave us the wrong answer to Security Question or you have not validated E-Mail....we could not automatically reset your password.  Please contact your Vendor Coordinator to have him/her reset it for you.</b>
             </div>
         </cfif>

         <CFIF isDefined("url.InvalidMiscCode")>
         	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
             <b>Sorry, but you are trying to log into Enhanced Vendor Remittance application for a Invalid Trailer Code.</b>
             </div>
         </cfif>

         <CFIF isDefined("url.IOCOnlyMiscCode")>
         	<div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
             <b>Sorry, but you are trying to log into Enhanced Vendor Remittance application for a Trailer Code reserved for IOC Personnel.</b>
             </div>
         </cfif>

         <cfif isdefined("url.PasswordChanged")>
         	<div class="alert alert-success"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
             <b>Your password has been changed!</b>
             </div>
         </cfif>

         <CFIF isDefined("url.TimedOut")>
         	<cfLock Scope="SESSION" TIMEOUT="100">
         	<cfset Session.VendTIN = "">
         	<cfset Session.AdmLevel = "">
         	<cfset Session.EMail="">
             </cfLock>
             <div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
             <b>Sorry, but it appears that you might have been timed out!  Please try logging back into the application!</b>
             </div>
         </cfif>

         <cfif trim(url.SystemMessage2) is not "">
         	<div <cfif url.SystemMessage2 EQ 'Password Changed'>class="alert alert-success"<cfelse>class="alert alert-danger"</cfif>><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
             <b>#url.SystemMessage2#</b>
             </div>
         </cfif>

            <div class="alert alert-info">User name is your email address.</div>

    <form METHOD="Post" role="form" class="form-horizontal" ACTION="/vendors/enhanced-vendor-remittance/vendor-summary/"  name="EnhancedRemit" id="EnhancedRemit">
             <INPUT TYPE="hidden" id="Mode" NAME="Mode" VALUE="Login">
             <input type="hidden" name="formType" value="Enhanced" />
             <input type="hidden" name="ValUser" value="False" />
             <cfif isdefined("url.IOCID")>
                <input type="hidden" name="IOCID" value="#URL.IOCID#" />
             </cfif>
             <cfif isdefined("url.NCode")>
                <cfif url.NCode EQ "">
                    <input type="hidden" name="Number_Code" value="X" />
                <cfelse>
                    <input type="hidden" name="Number_Code" value="#url.NCode#" />
                </cfif>
                
             </cfif>             
             <div class="form-group row">
                 <div class="col-sm-5 col-md-4">
                     <label for="UserId" id="lblUserId" class="control-label"><a style="text-decoration: none; color:##333;" href="" data-toggle="tooltip" title="This is your email address.">User ID <i class="fa fa-question-circle" aria-hidden="true"></i></a>:</label>
                 </div>
                 <div class="col-sm-7 col-md-8">
                        <cfif isdefined("url.IOCUser")>
                            <cftry>
                                <cfset TmpName = decrypt(url.IOCName, application.theKey, application.theAlgor, application.TheEncode)>
                            <cfcatch type="any">
                                <cfset TmpName="">
                            </cfcatch>
                            </cftry>
                            <input type="text"  id="UserId" name="VendTIN" value="#TmpName#"  autocomplete="off" tabindex="9" class="form-control text-input" placeholder="Email address">
                        <cfelse>                        
                            <input type="text"  id="UserId" name="VendTIN"  autocomplete="off" tabindex="9" class="form-control text-input" placeholder="Email address">
                        </cfif>
                 </div>
             </div>
             <div class="form-group row">
                 <div  class="col-sm-5 col-md-4">
                     <label for="Password" id="lblPassword" class="control-label">Password: </label>
                 </div>
                 <div class="col-sm-7 col-md-8">
                     <div class="passwordContainer">
                        <cfif isdefined("url.IOCUser")>
                            <cftry>
                                <cfset TmpId = decrypt(url.IOCId, application.theKey, application.theAlgor, application.TheEncode)>
                            <cfcatch type="any">
                                <cfset TmpId="">
                            </cfcatch>
                            </cftry>
                            <input name="password" type="password" value="#TmpId#" maxlength="50" id="password" tabindex="10" class="form-control text-input" autocomplete="off" placeholder="Password">
                        <cfelse>
                            <input name="password" type="password" maxlength="50" id="password" tabindex="10" class="form-control text-input" autocomplete="off" placeholder="Password" style="display: inline-block;" > &nbsp;<input id="toggle" onchange="togglePassword(this,document.getElementById('password'),document.getElementById('toggleText'));" type="checkbox" value="0" style="vertical-align: middle;" /><span id="toggleText" style="display: inline-block;margin: 5px 0 0 5px;vertical-align: middle;
    font-size: 12px;">Show</span>
                        </cfif>
                         
                     </div>
                 </div>
             </div>
             <div class="form-group text-center">
                     <button name="Enchanced" id="Submitbtn" value="Log In" class="btn btn-label btn-sm bbtn-login" tabindex="11" data-original-title="" title="">Login</button>

                     <button name="Register" id="Regbtn" value="Register" class="btn btn-label btn-sm" onclick="RegisterMe()" tabindex="12" data-original-title="" title="">Register</button>
             </div>
         </form>
                <div class="form-group row linking-font">
                    <div class="col-sm-5 ">
                    <b><a href="/vendors/enhanced-vendor-remittance/forgot-my-password/" id="ForgotPassword">Forgot Your Password</a></b>
                    </div>
                    <div class="col-sm-4">
                    <b><a href="https://illinoiscomptroller.gov/vendors/enhanced-vendor-remittance/having-trouble-logging-in/" id="TroubleLoggingIn" target="New">Trouble Logging In</a></b>
                    </div>
                    <div class="col-sm-3">
                        <b><a href="https://illinoiscomptroller.gov/comptroller/assets/file/instructions.pdf" target="New">User Guide</a></b>
                        </div>
                </div>
     </div>
 </div>

</cfoutput>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>

<cfif not isdefined("url.IOCUser")>
	<script>
  $(document).ready(function(){
   $('#UserId').attr('autocomplete', 'off');
   setTimeout('$("#UserId").val("");', 1000);
  });
  $(document).ready(function(){
   $('#Password').attr('autocomplete', 'off');
   setTimeout('$("#Password").val("");', 1000);
  });
  </script>
</cfif>

<script>
	$('#UserId').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is your email address."
	});
	$('#Password').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Must be between 6 and 25 characters."
	});
	$('#Submitbtn').tooltip({
            'show': false,
                'placement': 'top',
                'title': "After you supplied your User ID and Password, click here to log into the application."
        });
	$('#Regbtn').tooltip({
		'show': false,
			'placement': 'top',
			'title': "If there is nobody from your Vendor signed up as a Coordinator, click here to register.  Otherwise, you will need to have your Vendor's Coordinator sign you up."
	});
	$('#UserGuide').tooltip({
            'show': false,
                'placement': 'top',
                'title': "Click here to read the Enhanced Vendor User Guide."
        });
	$('#ForgotPassword').tooltip({
		'show': false,
			'placement': 'top',
			'title': "You can click this link if you do not remember your password.  You will be required to supply your validated Email address along with your Security Question/Answer to get a 'Change Password' Email sent to you."
	});
	$('#TroubleLoggingIn').tooltip({
		'show': false,
			'placement': 'top',
			'title': "You can click this link if you are having trouble logging into the application.  It contains some helpful information that might help you solve your issue."
	});
	$('#IdentityPolicy').tooltip({
		'show': false,
			'placement': 'top',
			'title': "You can click this link to read the Illinois Office of the Comptroller's Identity Protection Policy."
	});


	</script>

