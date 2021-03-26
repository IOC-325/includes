
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


<cfparam name="form.Email" default="">
<cfparam name="form.MobileProvider" default="None">
<cfparam name="form.MobilePhone" default="">
<cfparam name="form.VendTIN" default="">
<cfparam name="ErrorNo" default="">
<cfparam name="form.mode" default="">
<cfset ErrorStruct = StructNew()>
<cfset ErrorNo = "">

<cfinclude template="TmpVendorapplicationSettings.cfm">

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">

<CFIF (form.Mode is "Unsubscribe")>
	<cfoutput>
    
	<!--- Must have a Vendor TIN --->
    <cfif trim(form.VendTIN) is not "">
        <cfset variables.myCleanSSN =
          reReplaceNoCase(form.VendTIN,
          '[^[:digit:]]', '', 'ALL') >
        <cfset form.VendTIN = variables.myCleanSSN>
        <cfif len(form.VendTIN) neq "9"> 
            <cfset structInsert(ErrorStruct, "ErrorDefinition1", "You entered a Vendor TIN Number, but it does not have 9 digits. Please make sure that the Vendor TIN Number you supplied is 9 digits in length.  After re-entering your Vendor TIN Number, click on the Unsubscribe button to resubmit your information.")> 
            <cfset ErrorNo = ListAppend(ErrorNo, "1")>
        </cfif> 
    <cfelse>
        <cfset structInsert(ErrorStruct, "ErrorDefinition1", "You have not entered a Vendor TIN Number. Please make sure that the Vendor TIN Number you supplied is 9 digits in length.  After re-entering your Vendor TIN Number, click on the Unsubscribe button to resubmit your information.")> 
        <cfset ErrorNo = ListAppend(ErrorNo, "1")>
    </cfif>      
        
	<!--- Validate Email address --->
    <cfif trim(form.Email) is not "">
        <!--- Make sure Email is in correct format --->
        <cfif not isValid("email", form.Email)>
          <cfset structInsert(ErrorStruct, "ErrorDefinition5", "Since you gave us an email address, please make sure it is in the proper format.  After re-entering your email, click on the Unsubscribe button to resubmit your information.")>
          <cfset ErrorNo = ListAppend(ErrorNo, "5")>
        </cfif>
    </cfif>

	<!--- If user entered mobile phone number he/she must supply provider and vise versa --->
    <cfif (trim(form.MobilePhone) is "" and trim(form.MobileProvider) is not "None")>
        <cfset structInsert(ErrorStruct, "ErrorDefinition3", "Missing Required Information.  If you would like to unsubscribe to a text notification, you must supply us with both your Mobile Phone Number and Mobile Provider.  After entering your mobile phone number, click on the Unsubscribe button to resubmit your information.")>
        <cfset ErrorNo = ListAppend(ErrorNo, "3")>
    <cfelseif (trim(form.MobilePhone) is not "" and trim(form.MobileProvider) is "None")>
        <cfset structInsert(ErrorStruct, "ErrorDefinition3", "Missing Required Information.  If you would like to unsubscribe to a text notification, you must supply us with both your Mobile Phone Number and Mobile Provider.  After selecting your mobile phone provider, click on the Unsubscribe button to resubmit your information.")>
        <cfset ErrorNo = ListAppend(ErrorNo, "3")>
    </cfif>

	<!--- Validate Mobile Phone --->
    <cfif trim(form.MobilePhone) is not "">
        <cfif not isValid("telephone", form.MobilePhone)>
            <cfset structInsert(ErrorStruct, "ErrorDefinition6", "You entered a mobile phone number, but it is not valid. Please make sure that the phone number you supplied is correct (area code and phone number).  After re-entering your mobile phone number, click on the Unsubscribe button to resubmit your information.")>
            <cfset ErrorNo = ListAppend(ErrorNo, "6")>
        <cfelse>
            <cfset variables.myCleanPhoneNbr =
            reReplaceNoCase(form.MobilePhone,
            '[^[:digit:]]', '', 'ALL') >
            <cfset form.MobilePhone = variables.myCleanPhoneNbr>
            <cfif len(trim(form.MobilePhone)) neq "10">
                <cfset structInsert(ErrorStruct, "ErrorDefinition6", "You entered a mobile phone number, but it does not have 10 digits. Please make sure that the phone number is in the correct format (area code and phone number).  After re-entering your mobile phone number, click on the Unsubscribe button to resubmit your information.")>
                <cfset ErrorNo = ListAppend(ErrorNo, "6")>
            </cfif>
         </cfif>
	</cfif>
        
	<cfif StructIsEmpty(ErrorStruct)>
        <cfStoredProc datasource="Vendor" Procedure="UnSubscribe">
        	<cfif trim(form.Email) is not "">
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@Email" value="#form.Email#">
            <cfelse>
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@Email" null="yes">
            </cfif>
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@TaxPayerIdNo" value="#form.VendTIN#">
            <cfif trim(form.MobileProvider) is not "None">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@CellProvider" value="#form.MobileProvider#">
            <cfelse>
                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@CellProvider" null="yes">
            </cfif>
            <cfif trim(form.MobilePhone) is not "">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@AreaCode" value="#left(form.MobilePhone,3)#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhonePrefix" value="#mid(form.MobilePhone,4,3)#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhoneSuffix" value="#mid(form.MobilePhone,7,4)#">
            <cfelse>
                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@AreaCode" null="Yes">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhonePrefix" null="Yes">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@PhoneSuffix" null="Yes">
            </cfif>
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="UnsubscribeRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="UnsubscribeRetMsg">
            <cfprocresult name="Unsubscribe">
        </cfstoredproc>

        <cfif UnsubscribeRetVal is 0>
            <cflocation url="/vendors/vendor-payments-new/?Unsubscribe=Yes" addtoken="No">
        <cfelse>
        	 <cfset structInsert(ErrorStruct, "ErrorDefinition6", "Sorry, we could not unsubscribe you from receiving notifications based upon the information you have supplied to us.  Please call us if you need help.")>
                <cfset ErrorNo = ListAppend(ErrorNo, "9")>
        </cfif>
	</cfif>
    </cfoutput>
</cfif>


<div class="col-sm-12" style="border-left:6px solid #2b8695; padding:0 0 0 20px; margin-bottom:40px; position:relative; vertical-align:top top:3px;"><h2>Unsubscribe</h2><p>To unsubscribe from receive notificaitons when a vendor receives payments from our office you must supply to us the information below.  If you signed up for Email Notifications, the Taxpayer Identification Number and Email Address are required.  If you signed up for Text Notifications, the Taxpayer Identification Number, Mobile Phone Number, and Mobile Phone Provider are required.</p></div>

        <CFIF isDefined("NotFound")>
        <div class="col-sm-12">&nbsp;</div>
        <div class="col-sm-12">
		<p class="text-danger" align="left"><b>Sorry, but no vendors were found for that TIN number.</B>  Please verify the TIN and try again.</p>
		</div>
        <div class=" col-sm-12">&nbsp;</div>
        </cfif>
        
        <cfif not StructIsEmpty(ErrorStruct)>
            <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
<b><u>Issue(s) with Form Submission</u></b>
                <cfloop collection="#ErrorStruct#" item="theError">
                    <cfoutput>
                    <ul class="text-danger">
                    <li>#ErrorStruct[theError]#</li>
                    </ul>
                    </cfoutput>
                </cfloop>
            </div>
		</cfif>

                <form id="VendorForm" role="form" class="form-horizontal" name="Vendor" action="/vendors/vendor-payments-new/unsubscribe/" method="post">
                <cfoutput>
                <INPUT TYPE="hidden" NAME="Mode" VALUE="Unsubscribe">

                <div class="form-group">
                 <div class="col-sm-offset-2 col-sm-3">
                 <label for="inputPassword3"  class="control-label">Vendor TIN:</label>
                 </div>
                 <div class="col-sm-4">
                  <div  <cfif listfind(ErrorNo,"1")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                   <input type="password" placeholder="999999999" <!---required--->  name="VendTIN" <cfif not listfind(ErrorNo,"1")>id="VendTIN2"<cfelse>id="VendTINRed"</cfif> class="form-control" tabindex="1" <cfif trim(form.VendTIN) is not "">value="#form.VendTIN#"</cfif>>
                   <span class="input-group-addon"><i class="fa fa-user"></i></span>
                  </div>
                 </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-3">
                    <label for="Email" class=" control-label" >Email:</label>
                    </div>
                   <div class="col-sm-4">
                    <div  <cfif listfind(ErrorNo,"5")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                     <input type="email" <cfif not listfind(ErrorNo,"5")>id="Email"<cfelse>id="EmailRed"</cfif> name="Email" placeholder="myname@mail.com"  tabindex="6" class="form-control" <cfif trim(form.Email) is not "">value="#form.Email#"</cfif> onchange="ChangeCoordinator();">
                     <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    </div>
                   </div>
               </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-3">
                        <label for="MobilePhone" name="MoboliePhonelbl" class=" control-label">Mobile Phone:</label>
                    </div>
                   <div class="col-sm-4">
                    <div  <cfif listfind(ErrorNo,"3") or listfind(ErrorNo,"6")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                     <input type="text" name="MobilePhone" <cfif listfind(ErrorNo,"3") or listfind(ErrorNo,"6")>id="CellPhoneRed"<cfelse>id="CellPhone"</cfif> placeholder="(999) 999-9999" class="form-control" tabindex="7" <cfif trim(form.MobilePhone) is not "">value="#form.MobilePhone#"</cfif> onchange="ChangeCoordinator();"><span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    </div>
                   </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-3">
                        <label for="MobileProvider" name="MobileProviderlbl" class=" control-label" >Mobile Provider: </label>
                    </div>
                    <div class="col-sm-4">
                        <select id="CellProvider" name="MobileProvider" <cfif listfind(ErrorNo,"3")>class="form-control  has-error"<cfelse>class="form-control"</cfif> tabindex="8" onchange="ChangeCoordinator();">
                            <option value="None" <cfif trim(form.MobileProvider) is "None" or trim(form.MobileProvider) is "">selected</cfif>>None</option>
                            <option value="ATT" <cfif trim(form.MobileProvider) is "ATT">selected</cfif>>AT&amp;T</option>
                           <option value="Boost" <cfif trim(form.MobileProvider) is "Boost">selected</cfif>>Boost</option>
                            <option value="Cricket" <cfif trim(form.MobileProvider) is "Cricket">selected</cfif>>Cricket</option>
                            <option value="Sprint PCS" <cfif trim(form.MobileProvider) is "Sprint PCS">selected</cfif>>Sprint PCS</option>
                            <option value="T-Mobile" <cfif trim(form.MobileProvider) is "T-Mobile">selected</cfif>>T-Mobile</option>
                            <option value="U.S. Cellular" <cfif trim(form.MobileProvider) is "U.S. Cellular">selected</cfif>>U.S. Cellular</option>
                            <option value="Verizon" <cfif trim(form.MobileProvider) is "Verizon">selected</cfif>>Verizon</option>
                            <option value="Virgin Mobile" <cfif trim(form.MobileProvider) is "Virgin Mobile">selected</cfif>>Virgin Mobile</option>
                        </select>
                    </div>
                </div>
               
                <div class="form-group">
                	<div class="col-sm-2">&nbsp;</div>
                    <div class="col-sm-offset-2 col-sm-2">
                     <button nsme="Login" class="btn btn-custom-primary btn-lg btn-block btn-login" id="Login2" tabindex="10"><i class="fa fa-arrow-circle-o-right"></i> Unsubscribe</button>
                    </div>
                    <div class="col-sm-2">&nbsp;</div>
                </div>

			</cfoutput>

            </form>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!---<script src="/comptroller/jquery/jquery.js"></script>--->
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>


<script>
	$('#VendTIN2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your Social Security Number or Federal Employer Identification Number here."
	});
	;
	$('#Login2').tooltip({
            'show': false,
                'placement': 'top',
                'title': "After entering the Vendor TIN Number and notification information, click the Unsubscribe button."
        });
	$('#Email').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter a valid Email address."
	});
	$('#CellProvider').tooltip({
		'show': false,
			'placement': 'top',
			'title': "If you are receiving your Vendor Payment Notification in the form of a text message, select your mobile phone provider."
	});
	$('#CellPhone').tooltip({
		'show': false,
			'placement': 'top',
			'title': "If you are receiving your Vendor Payment Notification in the form of a text message, enter your mobile phone number in the format of (999)999-9999."
	});
	
	$('#VendTINRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter your Social Security Number or Federal Employer Identification Number here."
	});

	$('#EmailRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Enter a valid Email address."
	});
	$('#CellProviderRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "If you are receiving your Vendor Payment Notification in the form of a text message, select your mobile phone provider."
	});
	$('#CellPhoneRed').tooltip({
		'show': false,
			'placement': 'top',
			'title': "If you are receiving your Vendor Payment Notification in the form of a text message, enter your mobile phone number in the format of (999)999-9999.  You are responsible for any charges from your provider might charge for such text messages."
	});

	$('#CellPhone').mask("(999) 999-9999");
	</script>

<!---
</body>
</html>
--->
