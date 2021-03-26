<cfif not isDefined("form.Petition_Type")>
	
	<cfparam name="form.petition_type" default="State_Employee" >
	
</cfif>	

<style type="text/css">
#errmsg, #errmsg2, .errmsg
{
color: red;
}
</style>
	
<cfset variables.ActionFormTemplate = "/vendors/direct-deposit-fee-exemption-petition/direct-deposition-fee-exemption-petition/hardship-form-submission/">
<cfset variables.BackButton = "">

<script language="javascript" type="text/javascript">
	function checknumber(data) {
	    var checkOK = "()-0123456789. ";
	    var checkStr = data.value;
	    var allValid = true;
	    var allNum = "";
	    
	      for (i = 0;  i < checkStr.length;  i++) {
	        ch = checkStr.charAt(i);
	      for (j = 0;  j < checkOK.length;  j++)
	        if (ch == checkOK.charAt(j))
	          break;
	        if (j == checkOK.length) {
	          allValid = false;
	          break;
	        }
	        if (ch != ",")
	          allNum += ch;
	        }
	        if (!allValid) {
	          alert("Enter a valid phone number please.");
	          data.value = "";
	        return (false);
	      }
	    }
function limitText(limitField, limitCount, limitNum) {
	if (limitField.value.length > limitNum) {
		limitField.value = limitField.value.substring(0, limitNum);
	} else {
		limitCount.value = limitNum - limitField.value.length;
	}
}
function ValidateEmailForm(){
	var namel = document.EmailForm.NAMELAST;
	var namef = document.EmailForm.NAMEFIRST;
	var addressl = document.EmailForm.ADDRESSL;
	var cityl = document.EmailForm.Cityl;
	var statel = document.EmailForm.Statel;
	var zipl = document.EmailForm.Zipl;
	var phonel = document.EmailForm.Phonel;
	var emaill = document.EmailForm.Emaill;
	var emailv = document.EmailForm.Emailv;
	var agencyl = document.EmailForm.Agencyl;
	var TIN = document.EmailForm.TIN;
	var TIN2 = document.EmailForm.TIN2;
	var checkl = document.EmailForm.Checkl;
	
	
	if (namef.value == "") {
		window.alert("Please enter your first name.");
		namef.focus();
		return false;
	}
	if (namel.value == "") {
		window.alert("Please enter your last name.");
		namel.focus();
		return false;
	}
	if (addressl.value == "") {
		window.alert("Please enter address.");
		addressl.focus();
		return false;
	}
	if (cityl.value == "") {
		window.alert("Please enter city.");
		cityl.focus();
		return false;
	}
	if (statel.value == "") {
		window.alert("Please enter state.");
		statel.focus();
		return false;
	}
	if (zipl.value == "") {
		window.alert("Please enter zip code.");
		zipl.focus();
		return false;
	}
	if (agencyl.value == "") {
		window.alert("Please enter the state agency name.");
		agencyl.focus();
		return false;
	}
	if (phonel.value == "") {
		window.alert("Please enter valid phone number.");
		phonel.focus();
		return false;
	}
	
	if (emaill.value == "")
	{
	    window.alert("Please enter a valid e-mail address.");
	    emaill.focus();
	    return false;
	}

if (emaill.value.indexOf("@", 0) < 0)
	{
	    window.alert("Please enter a valid e-mail address.");
	    emaill.focus();
	    return false;
	}

if (emaill.value.indexOf(".", 0) < 0)
	{
	    window.alert("Please enter a valid e-mail address.");
	    emaill.focus();
	    return false;
	}


    if (emaill.value != emailv.value)
    {
        window.alert('Those emails don\'t match!');
        return false;
		emailv.focus();
    } 

    if (TIN.value != TIN2.value)
    {
        window.alert('Sorry, your TIN fields don\'t match!');
        return false;
		//ssn.focus();
    } 

	if (ssnl.value == "") {
		window.alert("Please enter a valid TIN/SSN.");
		//ssnl.focus();
		return false;
	}

	if (checkl.checked == 0) {
		window.alert("Please verify your signature by clicking in to the check box.");
		checkl.focus();
		return false;
	}
	
	

}
$(document).ready(function () {
  //called when key is pressed in textbox
  $(".numbersOnly").keypress(function (e) {
     //if the letter is not number then display error as well as avoid character input
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message    
		 $("#"+$(this).attr('name')).html("Numbers Only").show().fadeOut("slow");
               return false;
    }
   });
});
</script>

<!--- <cfif form.Petition_type eq "State_Employee">
	
	<h3>State Employee Payroll</h3>
	
<cfelse>
	
	<h3>Commercial Vendors</h3>
	
</cfif> --->

<p style="text-align:Right"><b>Agency Contact:</b> Direct Deposit Fee Exemption<br /> Office of the Comptroller<br /> 325 W. Adams Street<br />Springfield, IL 62704<br /> <a href="mailto:DDFeeExemption@IllinoisComptroller.Gov">DDFeeExemption@IllinoisComptroller.Gov</a>
</p>

<CFIF FORM.PETITION_TYPE EQ "STATE_EMPLOYEE">
	<p>Pursuant to 15 ILCS 405/9.03(b), all state payments for an employee's payroll or an employee's expense reimbursement must be made through direct deposit. Any state employee requesting an exemption from this direct deposit mandate due to hardship may petition for fee exemption status. You will be notified via e-mail that your fee exemption petition
	has been approved or denied at a later date.</p>

<cfelse>
	
<p>Pursuant to 15 ILCS 405/9.03(c), all State payments to a vendor that exceed the allowable limit of paper warrants in a fiscal year must be made through direct deposit. Any vendor requesting an exemption from this direct deposit mandate due to hardship may petition for fee exemption status. You will be notified via e-mail that your fee exemption petition has been approved or denied at a later date.</p>
	
</cfif>

<cfform name="EmailForm" action="#variables.ActionFormTemplate#" method="post">

<cfif form.Petition_Type eq "Commercial_Vendor">
	<INPUT TYPE="hidden" name="Petition_type" value="Commercial" />
<CFELSE>
	<INPUT TYPE="hidden" name="Petition_type" value="Payroll" />
</CFIF>
<h5><font color="white" style="background-color: #145089; padding: 15px 20px; display: block; text-align: center;"> SECTION 1: CONTACT INFORMATION </font></h5>

<legend>Contact Name:</legend>
<p>
First<font color="red"><sup>*</sup></font>: <input type="text" size="15" MAXLENGTH="15" name="NAMEFIRST" />
MI: <input type="text" size="1" MAXLENGTH="1" name="Middle_Initial" />
Last<font color="red"><sup>*</sup></font>: <input type="text" size="15" MAXLENGTH="15"  name="NAMELAST" />
</p>

<cfif form.Petition_Type eq "Commercial_Vendor">
<p>Title <input type="text" name="Title" value="" maxlength="40" size="45">  &nbsp; &nbsp; &nbsp; Company Name <input type="text" name="Company" value="" maxlength="40" size="45">
<cfelse>
	<input type="hidden" name="Title" value="" size="35">
	<input type="hidden" name="Company" value="">
</cfif>
<p>Address<font color="red"><sup>*</sup></font>:<input type="text" size="35" name="ADDRESSL"  MAXLENGTH="30" /> </p>
<p>Address Continued <input type="text" size="35" name="ADDRESS2"  MAXLENGTH="30" /> </p>
<p>
City<font color="red"><sup>*</sup></font>:<input type="text" size="25" name="Cityl" MAXLENGTH="18" /> 
State<font color="red"><sup>*</sup></font>:<input type="text" size="5" name="Statel" MAXLENGTH="2"/> 
Zip<font color="red"><sup>*</sup></font>:<input type="text" size="10" name="Zipl" MAXLENGTH="5" onchange="checknumber()"/>
-<input 
	type="text" 
	size="4" 
	maxlength="4" 
	name="ZipPlus4" />
</p>
<CFIF FORM.Petition_Type eq "State_Employee">
<p>State Agency (Employer)<font color="red"><sup>*</sup></font>:<input type="text" maxlength="50" size="60" name="Agencyl" /></p>
<cfelse>
	<input type="hidden" size="50" name="Agencyl" value="N/A" />
</cfif>
<p>DayTime Phone<font color="red"><sup>*</sup></font>:<input type="text" size="20" name="Phonel" MAXLENGTH="14" onchange="checknumber(this);" /> 
E-mail<font color="red"><sup>*</sup></font>:<input type="text" maxlength="40" size="50" name="Emaill"/> </p><p>
Re-Enter e-mail for verification<font color="red"><sup>*</sup></font>:<input maxlength="40" type="text" size="50" name="Emailv" /> </p>

<cfif form.petition_type eq "Commercial_Vendor">
	
	<input type="hidden" name = "Agencies" value = "N/A">
	
<cfelse>
	
	<input type="hidden" name = "Agencies" value = "N/A">
	
</cfif>
<h5><font color="white" style="background-color: #145089; padding: 15px 20px; display: block; text-align: center;"> SECTION 2: TAXPAYER IDENTIFICATION</font></h5>

<!--- +++++++++++ TIN and TIN 2 ---------------->

<p><cfif form.Petition_Type eq "State Employee">
	Social Security Number<cfelse>Taxpayer Identification Number
   </cfif><font color="red"><sup>*</sup></font>: 
<cfinput 
	required="true" 
	message="Please Enter your TIN - numbers only" 
	validate="integer" 
    class="numbersOnly"
    id="numbersOnly"
    type="password"
	Size="20" name="TIN" MAXLENGTH="9"  />
<!---	<input type="text" maxlength="9" size="20" name="TIN"/>--->
	<sup>1</sup>&nbsp;<span id="TIN" class="errmsg"></span></p>


<p>Validate<cfif form.Petition_Type eq "State Employee">SSN<cfelse>TIN</cfif><font color="red"><sup>*</sup></font>: 
<!---<input type="text" maxlength="9" size="20" name="TIN2"/>--->
	<cfinput 
		required="true" 
		message="Please Validate your TIN - numbers only" 
		validate="integer" 
		class="numbersOnly"
        id="numbersOnly2"
		Size="20" 
		name="TIN2" 
        type="password"
		MAXLENGTH="9"> No Dashes or Spaces Please &nbsp;<span id="TIN2" class="errmsg"></span></p>

<p><sup>1</sup>A copy of the IOC's Identification protection policy can be found on our website at:<br />
<a href="http://www.ioc.state.il.us/index.cfm/resources/general-resources/identity-protection-policy/" target="_blank" >http://www.ioc.state.il.us/index.cfm/resources/general-resources/identity-protection-policy/ </a></p>

<!--- +++++++++++ End of TIN and TIN 2 ------------>

<h5><font color="white" style="background-color: #145089; padding: 15px 20px; display: block; text-align: center;"> SECTION 3: REASON FOR EXEMPTION </font></h5>
<cftextarea rows="5" cols="70" name="limitedtextarea" required="true" message="Please a reason for your hardship request" onKeyDown="limitText(this.form.limitedtextarea,this.form.countdown,255);" 
onKeyUp="limitText(this.form.limitedtextarea,this.form.countdown,255);">
</cftextarea><br>
<font size="3">(Maximum characters: 255)<br>
You have <input readonly type="text" name="countdown" size="3" value="255"> characters left.</font>


 <p><cfinput type="checkbox" name="Checkl" required="true" message="Please check the box above this Submit button."/> "By submitting this form, you acknowledge that the content is truthful and accurate to the best of your knowledge. You further acknowledge that it is your intent that submission acts as your digital signature in place of your manual signature, and that your digital signature has the same legal effect as your manual signature."<br /></p>
 <input type="submit" value="Submit" onClick="return ValidateEmailForm();"/>
 <INPUT TYPE="reset" VALUE="Reset">
 <cfoutput>
 <INPUT TYPE="button" VALUE="Cancel" ONCLICK="window.location.href='#variables.BackButton#'">
 </cfoutput>
</cfform>
