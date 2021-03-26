<body>

<cfinclude TEMPLATE="title.htm">
	  <cfset key="654321">

<cfquery NAME="getInquirer" DATASOURCE="#application.escheatDSN#">
Select FullName from EscheatUsers where EscheaterID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.EscheaterID#"/>
</cfquery>
<cfquery NAME="Results" DATASOURCE="#application.CheckForCashDSN#">
Select PAYEE_NAME,WARRANT_AMT as Amount,  LTRIM(RTRIM(SUBSTR(VENDOR, 6,4))) as SSN, WARRANT
FROM WH.IOC_ESCHEATS
where Warrant = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Decrypt(URL.warrant,"#key#")#" />
</cfquery>
<cfinclude template="ListPayeeName.cfm">


<!--- <p>We will process your request to replace the missing warrant. We will mail a Warrant Reference Affidavit for your signature. Please note that if the warrant exceeds $500.00 you must have your signature notarized in order to permit replacement of the warrant.
To inquire about Warrant Number <cfoutput>#URL.Warrant#</cfoutput>, enter the information below. --->

<p><strong>Warrant Replacement Request</strong></p>


<p>To initiate the warrant replacement process,  please complete the following information. </p>
<!--// load the qForm JavaScript API //-->
		<SCRIPT SRC="lib/qforms.js"></SCRIPT>
		<!--// you do not need the code below if you plan on just using the core qForm API methods. //-->
		<!--// [start] initialize all default extension libraries  //-->
		<SCRIPT LANGUAGE="JavaScript">
		<!--//
		// specify the path where the "/qforms/" subfolder is located
		qFormAPI.setLibraryPath("lib/");
		// loads all default libraries
		qFormAPI.include("*");
		qFormAPI.allowSubmitOnError=false;
		//-->
		</SCRIPT>
		<!--// [ end ] initialize all default extension libraries  //-->
<form ACTION="?linkservid=833DBE9C-5056-93B5-5E59FF58C5E45683" METHOD="Post" onSubmit="return checkSubmit(document.myForm)" NAME="myForm" class="form-horizontal">

<br> 
<div class="form-group">
    <label for="LegalName" class="col-sm-4 control-label"><strong>Legal name of the payee:</strong></label>
    <cfoutput><strong><font size="2">#Results.PAYEE_NAME#</font></strong></cfoutput>
    <div class="col-sm-8">
    </div>
  </div>

<div class="form-group">
    <label for="RegistrantName" class="col-sm-4 control-label"><strong>Registrant's Name:</strong></label>
    <cfoutput><strong>#getinquirer.FullName#</strong></cfoutput>
    <div class="col-sm-8">
    </div>
  </div>
<cfoutput><input TYPE="Hidden" NAME="Warrant" VALUE="#Decrypt(URL.warrant,"#key#")#">
<input TYPE="hidden" NAME="Amount" VALUE="#results.Amount#">
<input TYPE="hidden" NAME="LegalName" VALUE="#results.PAYEE_NAME#">
<input TYPE="hidden" NAME="fullName" VALUE="#getInquirer.FullName#">
</cfoutput>

<div class="form-group">
    <label for="Address1" class="col-sm-4 control-label"><strong>Address 1:*</strong></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="Addr1" name="Addr1" required>
    </div>
    </div>

<div class="form-group">
    <label for="Address2" class="col-sm-4 control-label"><strong>Address 2:</strong></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="Addr2" name="Addr2">
    </div>
    </div>

<div class="form-group">
    <label for="City" class="col-sm-4 control-label"><strong>City:*</strong></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="city" name="City" required>
    </div>
    </div>


<div class="form-group">
    <label for="State" class="col-sm-4 control-label"><strong>State:*</strong></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="state" name="State" required>
    </div>
    </div>
 
<div class="form-group">
    <label for="Zip" class="col-sm-4 control-label"><strong>Zip:*</strong></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="zip" name="Zip" required>
    </div>
    </div>

<div class="form-group">
    <label for="SSN" class="col-sm-4 control-label"><strong>SSN (Last Four Digits):*</strong></label>
    <div class="col-sm-8">
      <input type="password" class="form-control" id="ssn" name="SSN" required maxlength="4" >
    </div>
    </div>

<div class="form-group">
    <label for="required" class="col-sm-4 control-label">* Required fields</label>
    
    </div>
<p>If the legal name of the payee and the registrant's name are different, please give a description of your relationship to the payee (e.g. Executor of estate with a Power of Attorney...)

<div class="form-group">
    <label for="Relationship" class="col-sm-4 control-label"><strong>Relationship to payee:</strong></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="relationship" name="Relationship"  >
    </div>
    </div>

<cfif isDefined("form.SSN")>
  <cfset  theKey=generateSecretKey('AES')>
  <cfset encrypted=encrypt(#form.SSN# , theKey, "AES", "Base64")>
  
  <cfset decrypted=decrypt(encrypted, theKey, "AES", "Base64")>
  
</cfif>

<div ALIGN="center"><input TYPE="Submit" VALUE="Continue..."></div>
</form>
<script LANGUAGE="JavaScript"><!--
if (window.print)
    document.write('<form><input type="button" value="Print" onClick="window.print()"><\/form>');
//--></script>

<SCRIPT LANGUAGE="JavaScript">
	<!--//
	// initialize the qForm object
	objForm = new qForm("myForm");
	objForm.required("Addr1,City,State,Zip,SSN");
	// objForm.Email.required = true;
	//objForm.State.validateAlpha();
	objForm.Zip.validateNumeric();
	objForm.State.validateState();
	//objForm.LegalName.validateSame("fullName");
	//objForm.LegalName.isSame("fullName");
	//alert('dude');
	//} else {
	//alert('dude');
	//}
	//-->

	</SCRIPT>


