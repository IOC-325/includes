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
	Modified Date: 11-21-00
	Modified By: Gary Ashbaugh
	Modifications Made: Add redirect when VendTIN is not defined

	Modified Date: 11-18-14
	Modified By: Gary Ashbaugh
	Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.
		It will also require people to enter at least the first 4-characters of the Vendor's Name.  He/She will also
		be able to sign-up to receive email/test notications when the vendor gets a payment.
--->

<!--- new as of 11/19/13 --->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-45854861-1', 'state.il.us');
  ga('send', 'pageview');

</script>


<script language="JavaScript"><!--

	function OpenHelp (ErrorNo,Section) {

			mywindow = window.open("#application.webroot#/vendors/vendor-payments-new/help/?ErrorNo=" + ErrorNo+ "&Section=" + Section, "Help", "location=1,status=1,scrollbars=1,width=275,height=275");

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

<!---<CFINCLUDE TEMPLATE="/config/cfapplication.cfm">--->
<cfinclude template="TmpVendorapplicationSettings.cfm">


<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">

<cfparam name="form.Mode" default="">
<cfparam name="form.Email" default="">
<cfparam name="form.FirstName" default="">
<cfparam name="form.LastName" default="">
<cfparam name="form.NotificationType" default="">
<cfparam name="url.NotificationType" default="None">
<cfparam name="form.MobileProvider" default="None">
<cfparam name="form.MobilePhone" default="">
<cfparam name="form.VendTIN" default="">
<cfparam name="form.VendTINName" default="">
<cfparam name="ErrorNo" default="">
<cfset ErrorStruct2 = StructNew()>
<cfset ErrorNo = "">


<cfif (not isdefined("VendTIN")) and (not isdefined("SVendTIN"))>
	<!---<CFLOCATION URL="/QuickTake/Vend/">--->
    <cflocation url="/vendors/" addtoken="No">
</cfif>

<cfif isDefined("url.sVendTIN")>
 <cfdump var="#URL#"><cfabort>
<!---  <cfset vendTIN = Decrypt(URLDecode(SVendTIN),"ITBG111")> --->
  <cfset vendTIN = decrypt(URLDecode(url.SVendTIN),"ITBG111")>
</cfif>

<!-- SQL Query -->

<CFIF (Mode is "Login")>
	<cfset TmpVendor_Name = "#left(rereplace(url.VENDTINNAME,"[^0-9A-Za-z]","","all"),4)#">
<cfelse>
	<cfset TmpVendor_Name = "#left(rereplace(VENDTINNAME,"[^0-9A-Za-z]","","all"),4)#">
</CFIF>

 <cftry>
	<CFQUERY NAME="VendVerify" DATASOURCE="DB2PRD" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
	SELECT Vendor_TIN
	FROM wh.VENDOR
	WHERE wh.VENDOR.Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTIN#" /> and
		left(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(Vendor_Name,' ',''),'-',''),'*',''),'####',''),'''',''),'!',''),'@',''),'$',''),'%',''),'^',''),'&',''),')',''),'(',''),'_',''),'+',''),'.',''),',',''),'"',''),4) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCase(TmpVendor_Name)#" />
	GROUP BY wh.VENDOR.Vendor_TIN
    </CFQUERY>
	<cfcatch type="database">
	 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
	</cfcatch>
</cftry>

<cftry>
<CFQUERY NAME="ContSumm" DATASOURCE="DB2PRD" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
	SELECT
		Sum(CONTRACT_AMT) AS ContTotal,
		Sum(CONTRACT_ENC_AMT) AS ContEncTotal,
		Sum(CONTRACT_EXP_AMT) AS ContExpTotal
	FROM wh.SUMM_VEND_CONT_#application.CFY#
	WHERE wh.SUMM_VEND_CONT_#application.CFY#.Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTIN#" />
	GROUP BY wh.SUMM_VEND_CONT_#application.CFY#.Vendor_TIN
</CFQUERY>
<cfcatch type="database">
 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
</cfcatch>
</cftry>

<cftry>
<CFQUERY NAME="ContCount" DATASOURCE="DB2PRD" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
	SELECT COUNT(*) AS ContCountNum
	FROM  wh.SUMM_VEND_CONT_#application.CFY#
	WHERE wh.SUMM_VEND_CONT_#application.CFY#.Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTIN#" />
</CFQUERY>
<cfcatch type="database">
 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
</cfcatch>
</cftry>

<cftry>
<CFQUERY NAME="ExpSumm" DATASOURCE="DB2PRD" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
	SELECT
		Sum(ENCUMBERED_AMT) AS EncTotal,
		Sum(EXPENDED_AMT) AS ExpTotal
	FROM wh.SUMM_VEND_EXP_#application.CFY#
	WHERE wh.SUMM_VEND_EXP_#application.CFY#.Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTIN#" />
	GROUP BY wh.SUMM_VEND_EXP_#application.CFY#.Vendor_TIN
</CFQUERY>
<cfcatch type="database">
 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
</cfcatch>
</cftry>

<cftry>
<CFQUERY NAME="PaymentCount" DATASOURCE="DB2PRD" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
	SELECT COUNT(*) AS PaymentCountNum
	FROM  wh.SUMM_VEND_Exp_#application.CFY#
	WHERE wh.SUMM_VEND_Exp_#application.CFY#.Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTIN#" />
</CFQUERY>
<cfcatch type="database">
 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
</cfcatch>
</cftry>
<!-- End of SQL Query -->
<body onload="ChangeCoordinator()">
<CFSET Area = "Summary">
<CFINCLUDE TEMPLATE="VendHeader.cfm">
<div class="text-center"><h2>Vendor Summary</h2></div>
<div class="text-center">
    <cfif GetVendor.SAMS_Delete_Date is not "">
        <p class="text-danger"><b>Vendor Status: No longer on file.  No activity in the past two years.</b></p>
    <cfelseif trim(GetVendor.Cert_Ind) is "C">
        <p class="text-danger"><b>Vendor Status: Certified</b></p>
    <cfelseif trim(GetVendor.Cert_Ind) is "N" or trim(GetVendor.Cert_Ind) is "T">
        <p class="text-danger"><b>Vendor Status: On file, but not certified</b></p>
    </cfif>
</div>

<cfoutput>
<p id="instructions2" class="text-center">Fiscal Year 20#application.cfy# Payment Information</p>
<p id="instructions2">To view payment/contract information from FY 20#application.pfy#, be sure to select it from the drop down on the next screen. Thank you.</p>
</cfoutput>
<!-- Send it back to the login if the TIN isn't valid -->


<CFIF (Mode is "Login")>
	<CFIF (#VendVerify.RecordCount# is "0")>
		<CFLOCATION URL="/vendors?NotFound=">
	</CFIF>

</CFIF>

<CFIF (Mode is "Login2")>
	<cfoutput>
  	<!--- Check Required Fields --->
   <cfif trim(form.NotificationType) is not "None">
    <!--- Check Required Fields --->

        <cfif (trim(form.NotificationType) is "Email" or trim(form.NotificationType) is "Both") and trim(form.Email) is "" and trim(form.NotificationType) is "Email">
            <!---<cfset structInsert(ErrorStruct2, "ErrorDefinition05B", "Since you have asked for us to notify you by email of any new payments, you must supply us with your email address.  After entering your email, selecting the captcha image and checking the disclaimer boxes, click on the Login button to resubmit your information.")>--->
            <cfset ErrorNo = ListAppend(ErrorNo, "05B")>
        <!--- Validate Email address --->
        <cfelseif (trim(form.NotificationType) is "Email" or trim(form.NotificationType) is "Both") and trim(form.Email) is not "">
        	<!--- Make sure Email is in correct format --->
            <cfif not isValid("email", form.Email)>
              <!---<cfset structInsert(ErrorStruct2, "ErrorDefinition05A", "Since you gave us an email address, please make sure it is in the proper format.  After re-entering your email, selecting the captcha image and checking the disclaimer boxes, click on the Login button to resubmit your information.")>--->
              <cfset ErrorNo = ListAppend(ErrorNo, "05A")>
            </cfif>
        </cfif>

        <!--- If user entered mobile phone number he/she must supply provider and vise versa --->
		<cfif ((trim(form.NotificationType) is "Text" or trim(form.NotificationType) is "Both") and trim(form.MobilePhone) is "")>
        	<!---cfset structInsert(ErrorStruct, "ErrorDefinition03A", "Missing Required Information.  If you would like text notification, you must supply us with both your Mobile Phone Number and Mobile Provider.  After entering your mobile phone number, selecting the captcha image and checking the disclaimer boxes, click on the Login button to resubmit your information.")>--->
            <cfset ErrorNo = ListAppend(ErrorNo, "03A")>

        <cfelseif isdefined("form.MobilePhone")>
        	<cfif not isValid("telephone", form.MobilePhone) and (trim(Form.Notificationtype) is "Text" or trim(form.NotificationType) is "Both")>
                <!---<cfset structInsert(ErrorStruct2, "ErrorDefinition06A", "You entered a mobile phone number, but it is not valid. Please make sure that the phone number you supplied is correct (area code and phone number).  After re-entering your mobile phone number, selecting the captcha image and checking the disclaimer boxes, click on the Login button to resubmit your information.")>--->
                <cfset ErrorNo = ListAppend(ErrorNo, "06A")>
            <cfelse>
                <cfset variables.myCleanPhoneNbr =
                reReplaceNoCase(form.MobilePhone,
                '[^[:digit:]]', '', 'ALL') >
                <cfset form.MobilePhone = variables.myCleanPhoneNbr>
                <cfif len(trim(form.MobilePhone)) neq "10" and (trim(Form.Notificationtype) is "Text" or trim(form.NotificationType) is "Both")>
                    <!---<cfset structInsert(ErrorStruct2, "ErrorDefinition06B", "You entered a mobile phone number, but it is not in the correct format of (999) 999-9999.  After re-entering your mobile phone number, selecting the captcha image and checking the disclaimer boxes, click on the Login button to resubmit your information.")>--->
                    <cfset ErrorNo = ListAppend(ErrorNo, "06B")>
                </cfif>
             </cfif>
        </cfif>

        <!--- If Text/Both must supply mobile phone provider --->
        <cfif ((trim(form.NotificationType) is "Text" or trim(form.NotificationType) is "Both") and trim(form.MobileProvider) is "None")>
            <!---<cfset structInsert(ErrorStruct2, "ErrorDefinition03B", "Missing Required Information.  If you would like text notification, you must supply us with both your Mobile Phone Number and Mobile Provider.  After selecting your mobile phone provider, selecting the captcha image and checking the disclaimer boxes, click on the Login button to resubmit your information.")>--->
            <cfset ErrorNo = ListAppend(ErrorNo, "03B")>

        </cfif>

        <cfif trim(form.FirstName) is "">
            <!---<cfset structInsert(ErrorStruct2, "ErrorDefinition09", "You have not entered your First Name.  After entering your First Name, selecting the captcha image and checking the disclaimer boxes, click on the Login button to resubmit your information.")>--->
            <cfset ErrorNo = ListAppend(ErrorNo, "09A")>
        </cfif>
       	<cfif trim(form.LastName) is "">
            <!---<cfset structInsert(ErrorStruct2, "ErrorDefinition10A", "You have not entered your Last Name.  After entering your Last Name, selecting the captcha image and checking the disclaimer boxes, click on the Login button to resubmit your information.")> --->
            <cfset ErrorNo = ListAppend(ErrorNo, "10A")>
        </cfif>

       <!--- <cfif StructIsEmpty(ErrorStruct2)>--->
       <cfif trim(ErrorNo) is "">
            <cfset TmpVendTIN = decrypt(url.SVendTIN,"ITBG111")>
            <!---<<cfset TmpVendTIN = #encrypt(VendTIN, application.theKey, application.theAlgor, application.TheEncode)#>--->
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
                    <cflocation url="/vendors/vendor-payments-new/vendor-summary/?Mode=Login&NotificationType=#URLEncodedFormat(form.NotificationType)#&VENDTINNAME=#URLEncodedFormat(form.VendTINName)#&RecSaved=Yes&SVendTIN=#TmpVendTIN#" addtoken="No">
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

                    <cflocation url="/vendors/vendor-payments-new/vendor-summary/?Mode=Login&NotificationType=#URLEncodedFormat(form.NotificationType)#&VENDTINNAME=#URLEncodedFormat(form.VendTINName)#&RecSaved=Yes&SVendTIN=#TmpVendTIN#" addtoken="No">
                </cfif>
            </cfif>
        </cfif>
    <cfelse>

        <cfif isdefined("form.Email") or isdefined("form.MobileProvider") or isdefined("form.MobilePhone")>
            <div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
             <b>Sorry, but your notification information was not saved since you selected "None" for Notification Type!</b>
            </div>
   		</cfif>
    </cfif>
    </cfoutput>
</cfif>

<cfif isdefined("RecSaved")>
<div class="alert alert-success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
    <b>Notification Information has been saved!</b>
</div>
</cfif>

<!-- Vendor Summary Results Table -->
<cfSet RR=RandRange(2,9)>
<CFSET S=VENDTIN * RR>
<!-- Contract Summary -->
<form role="form" class="form-horizontal" action="/vendors/vendor-payments-new/vendor-contract-form/" name="VendorSumm" method="Post">
<CFIF ContCount.ContCountNum is "0">
   	<CFOUTPUT>
   	<div class="form-group">
    	<div class="col-sm-offset-2 col-sm-3 text-center"><h2><B><I>Contracts</I></B></h2></div>
        <div class="col-sm-7">&nbsp;</div>
    </div>
	</CFOUTPUT>
	<div class="form-group">
    	<div class=" col-sm-offset-2 col-sm-10"><p id="instructions2">(No contract information was found for the current Fiscal Year.)</p>
        </div>
	</div>
<CFELSE>
	<cfinclude template="randRange.cfm">

    <CFOUTPUT QUERY="ContCount">

     <div class="form-group">
     	<div class="col-sm-offset-2 col-sm-4">
            <label for="ContContNum" id="ContContNumlbl">Number of Contracts: </label>
        </div>
        <div class="col-sm-6">#NumberFormat(ContCountNum)#</div>
    </div>
    </CFOUTPUT>
    <CFOUTPUT QUERY="ContSumm">
     <div class="form-group">
        <div class="col-sm-offset-2 col-sm-4">
            <label for="TotCont" id="TotContlbl">Total Contract Amount: </label>
        </div>
        <div class="col-sm-6">#DollarFormat(ContTotal)#
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-4">
            <label for="TotContEncumb" id="TotContEncumblbl">Total Contract Encumbrances: </label>
        </div>
        <div class="col-sm-6">#DollarFormat(ContEncTotal)#
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-4">
            <label for="TotContExp" id="TotContExplbl">Total Contract Expenditures: </label>
        </div>
        <div class="col-sm-6">#DollarFormat(ContExpTotal)#
        </div>
    </div>
    </CFOUTPUT>

    <cfoutput>
    <div class="form-group">
		<INPUT TYPE="hidden" NAME="V" VALUE="#S#">
        <INPUT TYPE="hidden" NAME="RR" VALUE="#RR#">
        <INPUT TYPE="hidden" NAME="SVendTin" value="#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#">
        <INPUT TYPE="hidden" NAME="VendTin" value="#VendTIN#">
        <INPUT TYPE="hidden" NAME="VendTinName" value="#VendTinName#">
        <INPUT TYPE="hidden" NAME="Mode" value="#Mode#">
        <div class="col-sm-offset-2 col-sm-4">
         <button name="Contracts" class="btn btn-custom-primary btn-lg btn-block btn-login" id="FindContracts2" tabindex="10"><i class="fa fa-arrow-circle-o-right"></i> Contract Details</button>
        </div>
        <div class="col-sm-6">&nbsp;</div>
    </div>


    </CFOUTPUT>
</CFIF>
</FORM>
<div class="form-group">
	<div class="col-sm-12">&nbsp;</div>
</div>
<form role="form" class="form-horizontal" action="/vendors/vendor-payments-new/vendor-warrant-form/" method="Post">
<CFIF #ExpSumm.RecordCount# is "0" >
    <CFOUTPUT>
    <div class="form-group">
    	<div class="col-sm-offset-2 col-sm-3 text-center"><h2><B><I>Payments</I></B></h2></div>
    </div>
    </CFOUTPUT>
    <div class="form-group">
    	 <div class="col-sm-offset-2 col-sm-6"><p id="instructions2">(No expenditure information was found for the current Fiscal Year.)</p></div>
	</div>
<CFELSE>


     <!---<div class="form-control2 col-sm-12">&nbsp;</div>--->
    <CFOUTPUT QUERY="ExpSumm">
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-4">
            <label for="TotPaymentEncumb" id="TotPaymentEncumblbl">Total Encumbrances: </label>
        </div>
        <div class="col-sm-4">#DollarFormat(EncTotal)#</div>
        <div class="col-sm-2">&nbsp;</div>
    </div>
   	<div class="form-group">
        <div class="col-sm-offset-2 col-sm-4">
            <label for="TotExpEncumb" id="TotExplbl">Total Expenditures: </label>
        </div>
        <div class="col-sm-4">#DollarFormat(ExpTotal)#
        </div>
         <div class="col-sm-2">&nbsp;</div>
    </div>
   	</CFOUTPUT>

	<CFOUTPUT>

	<div class="form-group">
		<INPUT TYPE="hidden" NAME="V" VALUE="#S#">
        <INPUT TYPE="hidden" NAME="RR" VALUE="#RR#">
        <INPUT TYPE="hidden" NAME="SVendTin" value="#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#">
        <INPUT TYPE="hidden" NAME="VendTin" value="#VendTIN#">
        <INPUT TYPE="hidden" NAME="VendTinName" value="#VendTinName#">
        <INPUT TYPE="hidden" NAME="Mode" value="#Mode#">
        <div class="col-sm-offset-2 col-sm-4">
         <button name="Payments" class="btn btn-custom-primary btn-lg btn-block btn-login" id="FindPayments2" tabindex="10"><i class="fa fa-arrow-circle-o-right"></i> Payment Details</button>
        </div>
    </div>


    </CFOUTPUT>
</CFIF>
</FORM>
<cfif url.Mode is "Login" or url.Mode is "Login2">
	<!---<cfif not StructIsEmpty(ErrorStruct2)>
        <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span><b><u>Issue(s) with Form Submission</u></b>
            <cfloop collection="#ErrorStruct2#" item="theError">
                <cfoutput>
                <ul class="text-danger">
                <li>#ErrorStruct2[theError]#</li>
                </ul>
                </cfoutput>
            </cfloop>
        </div>
    </cfif>--->
	<cfif trim(ErrorNo) is not "">
        <div class="alert alert-danger col-sm-12"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
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
                <li>#GetErrorNo.ErrorDescription#<cfif GetErrorNo.ErrorHelp is not "">  Click <a href="javascript:OpenHelp('#theError#','Landing')">here</a> for help solving the error.</cfif></li>
                </ul>
                </cfoutput>
            </cfloop>
        </div>
	</cfif>
	<cfif trim(url.NotificationType) is "None" or trim(form.NotificationType) is "None" or trim(ErrorNo) is not "">
    	<div class="form-group">
        	<div class=" col-sm-12">&nbsp;</div>
        </div>
        <cfoutput>

        <form id="VendorForm" class="form-horizontal" name="Vendor" action="/vendors/vendor-payments-new/vendor-summary/?Mode=Login2" method="post">
            <INPUT TYPE="hidden" NAME="Mode" VALUE="Login2">
            <input type="hidden" name="VendTINName" value="#VendTINName#">
            <INPUT TYPE="hidden" NAME="SVendTin" value="#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#">
            <INPUT TYPE="hidden" NAME="VendTin" value="#VendTIN#">
            <div  class="alert alert-warning col-sm-offset-1 col-sm-11"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>&nbsp;<ui class="text-warning"><b>The following information is optional.  If you'd like to receive an email or text message when we process your payment, please enter your email address or mobile number/provider below.</b></ui>
            </div>
            <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-3">
                        <label for="NotificationType" name="NotificationTypelbl" class="control-label">Payment Notification:</label>
                    </div>
                    <div class="col-sm-4">
                        <select id="NotificationType" name="NotificationType" class="form-control"  tabindex="3" onchange="ChangeCoordinator();">
                            <option value="None">None</option>
                            <option value="Email" <cfif trim(form.NotificationType) is "Email">selected</cfif>>Email</option>
                            <option value="Text" <cfif trim(form.NotificationType) is "Text">selected</cfif>>Text</option>
                            <option value="Both" <cfif trim(form.NotificationType) is "Both">selected</cfif>>Both</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-3">
                    <label for="Name" id="Contactlbl" class=" control-label">Contact Name:</label>
                    </div>
                    <div class="col-sm-3">
                            <input type="text" name="FirstName" <cfif not listfind(ErrorNo,"09A")>id="FirstName"<cfelse>id="FirstNameRed"</cfif> placeholder="First Name" class="form-control" tabindex="4" <cfif trim(form.FirstName) is not "">value="#form.FirstName#"</cfif>>
                    </div>
                    <div class="col-sm-3">
                            <input type="text" name="LastName" <cfif not listfind(ErrorNo,"10A")>id="LastName"<cfelse>id="LastNameRed"</cfif> placeholder="Last Name" class="form-control" tabindex="5" <cfif trim(form.LastName) is not "">value="#form.LastName#"</cfif>>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-3">
                    <label for="Email" id="Emaillbl" class=" control-label" >Email:</label>
                    </div>
                   <div class="col-sm-4">
                    <div  <cfif listfind(ErrorNo,"05A") or listfind(ErrorNo,"05B")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                     <input type="email" onchange="ChangeCoordinator();" <cfif not listfind(ErrorNo,"05A") and not listfind(ErrorNo,"05B")>id="Email"</cfif> name="Email" placeholder="myname@mail.com"  tabindex="6" class="form-control" <cfif trim(form.Email) is not "">value="#form.Email#"</cfif>>
                     <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    </div>
                   </div>
               </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-3">
                        <label for="MobilePhone" name="MoboliePhonelbl" class=" control-label">Mobile Phone:</label>
                    </div>
                   <div class="col-sm-4">
                    <div  <cfif listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B") or listfind(ErrorNo,"06A") or listfind(ErrorNo,"06B")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                     <input type="text" name="MobilePhone" <cfif not listfind(ErrorNo,"03A") and not listfind(ErrorNo,"03B") and not listfind(ErrorNo,"06A") and not listfind(ErrorNo,"06B")>id="CellPhone"</cfif> placeholder="(999) 999-9999" class="form-control" tabindex="7" <cfif trim(form.MobilePhone) is not "">value="#form.MobilePhone#"</cfif> onchange="ChangeCoordinator();">
                     <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    </div>
                   </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-3">
                        <label for="MobileProvider" name="MobileProviderlbl" class=" control-label" >Mobile Provider: </label>
                    </div>
                   	<div class="col-sm-4">
                        <select id="CellProvider" <cfif listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B")>class="form-control  has-error"<cfelse>class="form-control"</cfif> name="MobileProvider" class="form-control"  tabindex="8" onchange="ChangeCoordinator();">
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
                	<div class="form-group">
                	<div class="col-sm-offset-4 col-sm-1 text-right">
                        <input type="checkbox" id="certify"  name="certify" value="Y" tabindex="9" >
                   	</div>
                   	<div class="input-group col-sm-4">
                     	<label for="certify">By checking this box I certify that the email and mobile phone number provided are registered to me. I authorize the Office of the Comptroller to send me occasional emails/texts.</label></div>
                </div>
                <cfelse>
                    <div class="has-error">
                      <div class="checkbox">
                        <div class="col-sm-offset-4 col-sm-1 text-right">
                          <input type="checkbox" id="certify" name="certify" value="Y">
                         </div>
                         <div class="col-sm-4">
                          	<label>By checking this box I certify that the email and mobile phone number provided are registered to me. I authorize the Office of the Comptroller to send me occasional emails/texts.</label>
                        </div>
                      </div>
                    </div>
                 </cfif>

                <div class="form-group">
                    <div class="col-sm-offset-5 col-sm-3">
                     <button name="Update" class="btn btn-custom-primary btn-lg btn-block btn-login" id="Loginbtn2" tabindex="10"><i class="fa fa-arrow-circle-o-right"></i> Submit</button>
                    </div>
                </div>

            <div class="col-sm-12">&nbsp;</div>
        </form>
        </cfoutput>
    </cfif>
</cfif>
<!---</div>--->
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>


<script>
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
	$('#Contracts2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to view information about contracts issued to this vendor."
	});
	$('#FindContracts2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to view information about contracts issued to this vendor."
	});
	$('#Payments2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to view information about payments issued to this vendor."
	});
	$('#FindPayments2').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to view information about payments issued to this vendor."
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

	$('#CellPhone').mask("(999) 999-9999");
    $('#CellPhoneRed').mask("(999) 999-9999");
	</script>
    </body>