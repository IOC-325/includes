<!---
This is the GENERAL COMMENTS form for the website.
This form feeds to IOCFeedInsert.cfm via LinkServID=641FA94E-1CC1-DE6E-2F48A2249C6E40E4
7/16/15
--->


<!--- Mark's Fancy Captcha! --->
<script language="javascript" type="text/javascript">
<!--
function openCaptchaDictionary(url) {
    newwindow=window.open(url,'name','height=400,width=350');
    if (window.focus) {newwindow.focus()}
    return false;
}

// -->
</script>
<!--- Get Random Captcha word --->
<!--- Fancy Captcha --->
<!--- To call up the Security module, a virtual mapping has been created in IIS --->
<!--- <cfdump var="#application.securitydatasource#"><cfabort> --->
<cfparam name="application.securityDataSource" Default="IOCUsers">

<cfinvoke
 component="security.IOCSecurity"
 method="FancyCaptcha"
 returnvariable="CaptchaArray">
</cfinvoke>

<CFSET IDList = CaptchaArray[2][1][1]>
<CFSET NameList = CaptchaArray[2][1][2]>
<CFSET DescriptionList = CaptchaArray[2][1][3]>


<style>

#regform input[type="radio"] {
 margin:15px;
}
</style>

<!--- ASP --->
<cffunction name="makeRandomString" returnType="string" output="false">
   <cfset var chars = "23456789ABCDEFGHJKMNPQRSTWXYZ">
   <cfset var length = randRange(4,7)>
   <cfset var result = "">
   <cfset var i = "">
   <cfset var char = "">

   <cfscript>
   for(i=1; i <= length; i++) {
      char = mid(chars, randRange(1, len(chars)),1);
      result&=char;
   }
   </cfscript>

   <cfreturn result>
</cffunction>

<cfset showForm = true>
<cfparam name="form.captcha" default="">
<cfparam name="form.captchaHash" default="">


<cfparam name="url.TmpComment_Type" default="Suggestion">
<cfparam name="url.TmpSUBJECT" default="">
<cfparam name="url.TmpComments" default="">
<cfparam name="url.TmpFNAME" default="">
<cfparam name="url.TmpMNAME" default="">
<cfparam name="url.TmpNAME" default="">
<cfparam name="url.TmpTELEPHONE" default="">
<cfparam name="url.TmpEMAIL" default="">
<cfparam name="url.TmpDivision" default="General Inquiry">
<cfparam name="url.TmpUser_Type" default="">
<cfparam name="url.TmpCompany" default="">
<cfparam name="url.TmpFax" default="">
<cfparam name="url.TmpAddress1" default="">
<cfparam name="url.TmpAddress2" default="">
<cfparam name="url.TmpCity" default="">
<cfparam name="url.TmpState" default="">
<cfparam name="url.TmpZipCode" default="">
<!--- If the Session.comments values are set it is because there was an error detected when the comments form was submitted.  --->
<CFIF IsDefined ("Session.comments")>
    <CFSET url.TmpComment_Type = Session.Comments.COMMENT_TYPE>
    <CFSET url.TmpUser_Type = Session.Comments.USER_TYPE>
    <CFSET url.TmpSUBJECT = Session.Comments.SUBJECT>
    <CFSET url.TmpDivision = Session.Comments.Division>
    <CFSET url.TmpComments = Session.Comments.COMMENTS>
    <CFSET url.TmpFNAME = Session.Comments.FirstName>
    <CFSET url.TmpMNAME = Session.Comments.middleName>
    <CFSET url.TmpNAME = Session.Comments.lastName>
    <CFSET url.TmpCompany = Session.Comments.COMPANY>
    <CFSET url.TmpTELEPHONE = Session.Comments.telephone>
    <CFSET url.TmpFax = Session.Comments.FAX>
    <CFSET url.TmpEMAIL = Session.Comments.Email>
    <CFSET url.TmpAddress1 = Session.Comments.Address1>
    <CFSET url.TmpAddress2 = Session.Comments.Address2>
    <CFSET url.TmpCity = Session.Comments.City>
    <CFSET url.TmpState = Session.Comments.State>
	<CFSET url.TmpZipCode = Session.Comments.ZipCode>
	<!--- Delete the comments session values after it has set the URL values which are used to repopulate the comments form below. --->
    <CFSET structDelete(session, "Comments")>
</CFIF>

<p>Tell us what you think about the Comptroller's website. What do you like about it? How can it be improved? We appreciate all of your comments and suggestions.</p>

<cfif IsDefined ("URL.Error") AND URL.Error IS 2>
	<p><font color="red">You entered the incorrect captcha!  Please try it again!	</font></p>
</cfif> 

<!--- ASP --->
<cfif showForm>



    <cfform action="/comptroller/?LinkServID=641FA94E-1CC1-DE6E-2F48A2249C6E40E4" method="POST" name="regform">
	<cfoutput>
    
     <div class="row">
        <div class="col-sm-12">
        <h2>What
        kind of comment would you like to send?</h2>
        </div>
    </div>
<div class="row">
    <div class="col-sm-12">
        <div class="btn-group" data-toggle="buttons">
            <label class="btn btn-default">
                <input type="radio" name="COMMENT_TYPE" value="suggestion" <cfif url.TmpComment_Type is "Suggestion" or url.TmpComment_Type is "">checked</cfif>>Suggestion
            </label>
            <label class="btn btn-default">
                <input type="radio"
                    name="COMMENT_TYPE" value="praise" <cfif url.TmpComment_Type is "praise">checked</cfif>>Praise
            </label>
           <label class="btn btn-default">
                    <input type="radio"
                    name="COMMENT_TYPE" value="praise" <cfif url.TmpComment_Type is "Question">checked</cfif>>Question
            </label>
            <label class="btn btn-default">
                    <input type="radio"
                    name="COMMENT_TYPE" value="complaint" <cfif url.TmpComment_Type is "complaint">checked</cfif>>Complaint
            </label>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-sm-12">
        <h2>Are you new to this site?</h2>
    </div>
</div>

<div class="row">
    <div class="col-sm-12">
        <div class="btn-group" data-toggle="buttons">
            <label class="btn btn-default">
                <input type="radio" name="USER_TYPE" value="new" <cfif url.TmpUser_Type is "new" or url.TmpUser_Type is "">checked</cfif>>New User
            </label>
            <label class="btn btn-default">
                <input type="radio" name = "USER_TYPE" value="regular" <cfif url.TmpUser_Type is "regular">checked</cfif>>Regular User
            </label>
        </div>

<div class="row">
    <div class="col-sm-12">
        <h3>What is the subject of your message?*</h3>
    </div>
</div>
<div class="row">
    <div class="col-sm-12">

        <dl>
            <dd><input type="text" size="26"
                maxlength="50" name="SUBJECT" value="#url.TmpSubject#"></dd>
        </dl>
        <p><strong>So we can better direct your inquiry, please select a category that best describes your comments?*</strong> </p>
        <dl>
          <dd>
            <cfselect NAME="Division">
                <option value="General Inquiry" <cfif url.TmpDivision is "General Inquiry" or url.TmpDivision is "">selected</cfif>>General Inquiry</option>
                <option value="1099" <cfif url.TmpDivision is "1099">selected</cfif>>1099</option>
                <option value="PLACE" <cfif url.TmpDivision is "PLACE">selected</cfif>>PLACE</option>
                <option value="FeeRpt" <cfif url.TmpDivision is "FeeRpt">selected</cfif>>Fee Report</option>
                <!--- <option value="IW" <cfif url.TmpDivision is "IW">selected</cfif>>Information Warehouse</option> --->
                <option value="LocGov" <cfif url.TmpDivision is "LocGov">selected</cfif>>Local Government</option>
                <!--- <option value="SAMSMonthlyRpt" <cfif url.TmpDivision is "SAMSMonthlyRpt">selected</cfif>>SAMS Monthly Reports</option> --->
                <option value="Spanish" <cfif url.TmpDivision is "Spanish">selected</cfif>>Spanish</option>
                <option value="TaxExp" <cfif url.TmpDivision is "TaxExp">selected</cfif>>Tax Expenditure</option>
                <option value="W2" <cfif url.TmpDivision is "W2">selected</cfif>>W2</option>
           </cfselect>
          </dd>
        </dl>
        <p><strong>Enter your comments in the space provided below:*</strong>
        <dl>
            <dd><textarea name="COMMENTS" rows="5" cols="45"><cfif trim(url.TmpComments) is not "">#url.TmpComments#</cfif></textarea>
            </dd>
        </dl>
        <p><strong>Tell us how to get in touch with you:</strong>

    <div class="form-group">
        <label for="prefix">Name</label>
        <input type="text" size="4" id="prefix" maxlength="10" name="prefix" value="" placeholder="Mr.">
        <input type="text" size="15" id="firstName" maxlength="25" name="firstName" value="#url.TmpFNAME#" placeholder="First Name" required>
        <input type="text" size="15" id="middleName" maxlength="25" name="middleName" value="#url.TmpMNAME#" placeholder="Middle Name/Initial">
        <input type="text" size="25" id="lastName" maxlength="35" name="lastName" value="#url.TmpName#" placeholder="Last Name" required>
        <input type="text" size="4" id="suffix" maxlength="10" name="suffix" value="" placeholder="Sr.">
    </div>

    <div class="form-group">
      <label for="COMPANY">Company</label>
      <input type="text" size="35" maxlength="256" id="COMPANY" name="COMPANY" value="#url.TmpCompany#">
    </div>

    <div class="form-group">
      <label for="Address">Address</label>
      <input type="text" size="35" maxlength="256" id="Address1" name="Address1" placeholder="123 Main St." value="#URL.TmpAddress1#" required>
    </div>
    <div class="form-group">
      <input type="text" size="35" maxlength="256" id="Address2" name="Address2" placeholder="Apt. C" value="#URL.TmpAddress2#">
    </div>

    <div class = "form-group">

      <input type="text" size="35" maxlength="256" id="City" name="City" value="#URL.TmpCity#" placeholder="City" required>
      <input type="text" size="4" id="state" maxlength="10" name="state" value="#URL.TmpState#" placeholder="IL" required>


    <input type="text" size="11" id="zip" maxlength="11" name="zipCode" value="#URL.TmpZipCode#" placeholder="62704" required>

    </div>
    <div class="form-group">
      <label for="telephone">Telephone</label>
      <input type="text" size="35" maxlength="256" id="telephone" name="TELEPHONE" value="#url.TmpTelephone#">
    </div>

    <div class="form-group">
      <label for="fax">Fax</label>
      <input type="text" size="35" maxlength="256" id="fax" name="FAX" value="#url.TmpFax#">
    </div>

    <div class="form-group">
      <label for="Email">E-mail*</label>
      <cfinput type="text" size="35" maxlength="256" id="Email" name="EMAIL" validate="regular_expression" Pattern="^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.(([a-zA-Z]{2,3})|(aero|coop|info|museum|name))$" message="invalid email address." value="#url.TmpEMail#" required>

    </div>


  </div>
</div>
<div class="row">
        <div class="col-sm-12">
     <p><strong>This step helps prevent unfair use of automated programs.</strong></p>
     <cfinput type="hidden" name="captcha_check" value="#CaptchaArray[3][1][2]#">
     <cfinput type="hidden" name="captcha_check2" value="#CaptchaArray[3][1][3]#">
     <!--- Captcha Group --->
      <cfoutput>
    <!---  <label for="Captcha" class="control-label sr-only">Captcha</label> --->
     <div class="form-group">
        <!--- <div class="col-sm-12">
         <div class="col-sm-offset-1 col-sm-12"> --->
                    Select the <b>#CaptchaArray[1][1][3]#</b> : <a href="captchahelp.cfm" onclick="return openCaptchaDictionary('captchahelp.cfm')"><b>(What is this?)</b></a>
         <!--- </div> --->
            <p align="center">

           <cfloop index="i" from="1" to="#ListLen(NameList)#">
                <CFSET ThisID = ListGetAt(IDList,i)>
                   <span class="input-group-addon pull-center">
                    <input type="radio" name="CaptchaWord" <cfif i eq 1>required </cfif> value="#ThisID#">&nbsp;<i class="#ListGetAt(NameList,i)#"></i></center>
                   </span>
            </cfloop>

            </p>
        <!--- </div> --->
     </div>
     </cfoutput>
</div></div>
     <!--- WARNINGS --->
     <div id="messageHolder" class="hide"></div>
      <CFIF IsDefined ("IsBot") AND IsBot IS "true">
       <div class="alert alert-danger">
        The captcha selected is incorrect.  Please select captcha correctly.
       </div>
      </CFIF>
      <CFIF IsDefined ("IsBot") AND IsBot IS "NoEmailMatch">
      <div class="alert alert-danger">
       There is no account with the email address you entered.
      </div>
      </CFIF>

<div class="row">
        <div class="col-sm-12">
        <p><input type="submit" value="Submit!"> <input
        type="reset" value="Clear Form"></p>
        </cfoutput>
</div></div>
    </cfform>
    *Mandatory fields
    <hr>

</cfif>
