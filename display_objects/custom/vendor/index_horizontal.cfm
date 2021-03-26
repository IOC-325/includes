
<!DOCTYPE html>
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
</head>
<body>
--->
					
		<div class="col-sm-12">
			<p id="Instructions"><!--- This system allows State of Illinois vendors and commercial payees to view non-confidential remittance information for payments issued to them by the Illinois Office of the Comptroller.<br><br> --->
				In the blank text field below, please key-in the Federal Employer Identification Number (FEIN) or Social Security Number (SSN) that would have been submitted to the Comptroller on payment vouchers. Do not use dashes or spaces.<br><br>
                In the Vendor Name field, enter the whole or at least the first four characters of your State of Illinois vendors and commercial payees name
            </p>
        </div>
        
        <CFIF isDefined("NotFound")>
        <div class="col-sm-12">&nbsp;</div>
        <div class="col-sm-12">
		<p class="text-danger" align="left"><b>Sorry, but no vendors were found for that TIN number.</B>  Please verify the TIN and try again.</p>
		</div>
        <div class="col-sm-12">&nbsp;</div>
        </cfif>
                    
        <form id="VendorForm" role="form" class="form-horizontal" name="Vendor" action="/vendors/vendor-payments-new/vendor-summary/" method="post">
        <INPUT TYPE="hidden" NAME="Mode" VALUE="Login">
        <div class="control-group">
    		<div class="controls">
	      	<button name="Login" id="Loginbtn" VALUE="Log In" class="btn btn-custom-primary btn-sm btn-block btn-login col-sm-2"  tabindex="10"><i class="fa fa-arrow-circle-o-right"></i> Login</button>
			</div>
	  	</div>
        <div class="col-sm-12">&nbsp;</div>
        <div class="control-group">
            <label for="VendTIN" id="VendTINlbl" class="pull-right control-label">Vendor TIN Num: </label>
            <div class="controls">
            <input type="password" required placeholder="999999999" id="VendTIN" name="VendTIN" class="pull-left" tabindex="1">
            <span class="input-group-addon pull-left"><i class="fa fa-user"></i></span>
            </div>
        </div>
        <div class="col-sm-12">&nbsp;</div>
        <div class="control-group">
        	<label for="Vendor_TIN_Name" id="Vendor_TIN_Namelbl" class="pull-right control-label">Vendor Name: </label>
            <div class="controls">
            	<input type="text" required placeholder="First four characters" id="VendorTINName" name="VendTINName" class="pull-left" tabindex="2">
            </div>
        </div>
        <div class="col-sm-12">&nbsp;</div>
        <div class="col-sm-12">
        <!---<p class="text-warning">---><p id="Instructions">The following information is optional.  If you would like to be notified by an Email or a Text message when your vendor or commercial payee has received a payment, Select type of notification you would like to receive, Enter your first and last name and then enter both your Email address and Cell Provider/Phone Number.  Make sure to check the box below stating that this is your contact information.  Finally, click on the <i>Log In</i> button.</p>
        </div>
        <div class="col-sm-12">&nbsp;</div>        
        <div class="control-group">
           <label for="NotificationType" name="NotificationTypelbl" class="pull-right control-label" >Payment Notification: </label>
           <div class="controls">                            
                <select id="NotificationType" name="NotificationType" class="pull-left"  tabindex="3">
                    <option value="None">None</option>
                    <option value="EMail">Email</option>
                    <option value="Text">Text</option>
                </select>
           </div>
        </div>
        <div class="col-sm-12">&nbsp;</div>
        <div class="control-group">
        	<label for="Name" id="Contactlbl" class="pull-right control-label" >Contact Name:</label>
            <div class="controls">                        
           		<input type="text" name="FirstName"  id="FirstName" placeholder="First Name (Optional)" tabindex="4">
                &nbsp;&nbsp;                  
                <input type="text" name="LastName" id="LastName" placeholder="Last Name (Optional)" tabindex="5">
            </div>
        </div>
        <div class="col-sm-12">&nbsp;</div>
        <div class="control-group">
            <label for="Email" id="Emaillbl" class="pull-right control-label" >Email:</label>
            <div class="controls">
                <input type="email" id="Email" name="Email" placeholder="Email (Optional)"  tabindex="6" class="pull-left">
                <span class="input-group-addon pull-left"><i class="fa fa-envelope"></i></span>
            </div>
       </div>
       <div class="col-sm-12">&nbsp;</div>  
        <div class="control-group">
            <label for="MobilePhone" name="MoboliePhonelbl" class="pull-right control-label">Mobile Phone:</label>
           	<div class="controls">                       	
                <input type="text" name="MobilePhone" id="CellPhone" placeholder="(999) 999-9999" class="pull-left" tabindex="7">                 
                <span class="input-group-addon pull-left"><i class="fa fa-phone"></i></span>
            </div>
        </div> 
        <div class="col-sm-12">&nbsp;</div>
        <div class="control-group">
            <label for="MobileProvider" name="MobileProviderlbl" class="pull-right control-label" >Mobile Provider: </label>
            <div class="controls">                            
                <select id="CellProvider" name="MobileProvider" class="pull-left"  tabindex="8">
                    <option value="None">None</option>
                    <option value="ATT">AT&amp;T</option>
                    <option value="Sprint PCS">Sprint PCS</option>
                    <option value="T-Mobile">T-Mobile</option>
                    <option value="U.S. Cellular">U.S. Cellular</option>
                    <option value="Verizon">Verizon</option>
                    <option value="Virgin Mobile">Virgin Mobile</option>
                </select>
            </div>
        </div>
        <div class="col-sm-12">&nbsp;</div>
        <div class="control-group">
           	<input type="checkbox" id="certify" name="certify" class="pull-right"  tabindex="9">
           	<div class="controls"> 
           		<label for="certify" class="col-sm-10"  >By checking this box I certify that the email and mobile phone number provided are registered to me. I authorize the Office of the Comptroller to send me occasional emails/texts.</label>
           	</div>
        </div>
        <div class="control-group">
    		<div class="controls">
            <button name="Login" id="Loginbtn2" VALUE="Log In" class="btn btn-custom-primary btn-sm btn-block btn-login col-sm-2"  tabindex="10"><i class="fa fa-arrow-circle-o-right"></i> Login</button>
            </div>
        </div>
        <div class="col-sm-12">&nbsp;</div> 
    </form>
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!---<script src="/comptroller/jquery/jquery.js"></script>--->
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    

<script>
	$('#VendTIN').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your Vendor Taxpayer Identification Number."
	});
	$('#VendorTINName').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter the name of your business or last name followed by your first name."
	});
	$('#Loginbtn').tooltip({
            'show': false,
                'placement': 'top',
                'title': "After entering the Vendor TIN Number and Vendor Name, click the Login button."
        });
	$('#Loginbtn2').tooltip({
            'show': false,
                'placement': 'top',
                'title': "After you supplied us with both the Vendor TIN and at least 4-digits of the Vendor Name, click this Login button."
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
	$('#NotificationType').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select the type of notification you would like to receive.  Select NONE if you do NOT want to receive any notiifications."
	});
	$('#Email').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter a valid Email address."
	});
	$('#CellProvider').tooltip({
		'show': false,
			'placement': 'top',
			'title': "If you would like to receive your Vendor Payment Notification in the form of a text message, select your mobile phone provider."
	});
	$('#CellPhone').tooltip({
		'show': false,
			'placement': 'top',
			'title': "If you would like to receive your Vendor Payment Notification in the form of a text message, enter your mobile phone number in the format of (999)999-9999.  You are responsible for any charges from your provider might charge for such text messages."
	});

	$('#CellPhone').mask("(999) 999-9999");
	</script>

<!---
</body>
</html>
--->
