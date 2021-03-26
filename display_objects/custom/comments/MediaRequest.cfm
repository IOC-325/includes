<script language="JavaScript"><!--

//global variable for error flag
var errfound=false
//function to validate by length
function ValidLength(item,len) {
return(item.length>=len);
}

//display an error alert
function error(elem,text) {
//abort if we already found an error
if(errfound) return; 
window.alert(text);
elem.select();
elem.focus();
errfound=true;
}
//main validation function
function Validate() {
errfound=false;
if (!ValidLength(document.regform.EMAIL.value,5))
error(document.regform.EMAIL,"Please enter valid email address!");
return !errfound; /*true if there are no errors */
}
// --></script>

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

<cfparam name="url.First_Name" default="">
<cfparam name="url.Last_Name" default="">
<cfparam name="url.Email" default="">
<cfparam name="url.Phone" default="">
<cfparam name="url.Company" default="">
<cfparam name="url.Request" default="">
<cfparam name="url.tmpError" default="No">
<cfparam name="url.TmpDivision" default="General Inquiry">
<cfparam name="url.TmpUser_Type" default="">
<cfparam name="url.TmpCompany" default="">
<cfparam name="url.TmpFax" default="">

<p> This form is for members of the Media to ask a specific question. Your questions will be addressed immediately and should be responded to in the next business day.
<hr>
<H3>Step 1: Please provide the following information about yourself.</H3>

<cfif url.TmpError is not "No">
	<p><font color="red">You entered the verification code incorrectly!  Please try it again!	</font></p>
	<cfset url.TmpError = "No">
</cfif>

<cfset captcha=makeRandomString()>
<cfset captchaHash=hash(captcha)>

<!---/default/includes/display_objects/custom/comments/insert.cfm--->
<cfform action="/comptroller/?LinkServID=646EB9F7-1CC1-DE6E-2F4811C5B4E86DE5" method="POST" name="regform" onsubmit="return Validate();">
<P>
	Your First Name: <cfinput type="Text" name="FIRST_NAME" value="#url.First_Name#" size="15"><p>
	Last Name: <cfinput type="Text" name="LAST_NAME" VALUE="#url.Last_Name#" size="15" maxlength="255"><P>
	Email: <cfinput type="Text" name="EMAIL" size="30" VALUE="#url.Email#" validate="regular_expression" Pattern="^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.(([a-zA-Z]{2,3})|(aero|coop|info|museum|name))$" message="invalid email address."><P>
	Phone: <cfinput type="Text" name="PHONE" size="40" maxlength="255" VALUE="#url.Phone#"><p>
	Your Company: <cfinput type="Text" name="COMPANY" size="50" VALUE="#url.Company#"><p>
	<hr>
<H3>Step 2: What is it you seek? <b>PLEASE BE AS SPECIFIC AS POSSIBLE!</b></h3><p>
	<cfoutput><textarea name="REQUEST" cols="50" rows="10" wrap="VIRTUAL">#url.Request#</textarea></cfoutput>

	<p><strong>How would you like to be notified?</strong>
    <dl>
        <dd>
        	<cfset checked="Yes">
        	
         <cfinput CHECKED="#checked#" 
        		type="radio"
            name="CONTACT_METHOD"
         	value="suggestion">By Phone
			
			<cfset checked="no">	
        	
         <cfinput 
        		type="radio"
            name="CONTACT_METHOD" 
            value="email">By Email
            </dd>
    </dl>
    
     <p><strong>This step helps prevent unfair use of automated programs.</strong>
        
         <p><strong>Enter the verification code as it is shown in the box below.  <a href="http://www.ioc.state.il.us/comptroller/?LinkServID=5085562C-1CC1-DE6E-2F488D7D8BFDA8AC" target="_New">How does code verification work?</strong></a>
		
        <DL> 
        	<DD>Verification Code : <input type="text" name="captcha" /></DD>
        </DL>
        
        <dl>
        	<dd><cfimage action="captcha" width="300" height="75" text="#captcha#" fonts="Arial,Helvetica,Times,Calibri,Courier,Geneva,Georgia" difficulty="high" >
            	<cfinput type="hidden" name="captchaHash" value="#captchaHash#" />
            </dd>
        </dl>
      <p>Just one more thing. The sum of 2 and 3 is <cfinput TYPE="TEXT" NAME="mth"></p>
    <p><input type="submit" value="Submit"></p>
</cfform>






