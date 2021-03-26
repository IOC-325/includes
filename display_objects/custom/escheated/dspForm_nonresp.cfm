 <cfscript>
	request.bodytopic = "FILL OUT FORM BELOW";
	request.title="Uncashed State Checks - Illinois Comptroller's Office";
</cfscript>



<p><b>Registration Information:</b>
<p>The individual making the inquiry must register at this point.  The inquirer must also identify the business they are associated with if the inquirer does not have a legal relationship with the Vendors that they are going to search.  The system will not allow you to proceed until the following information is completed:</p>


<form action="/?LinkServID=81A75456-5056-93B5-5E33D53AFFB5C613" method="post"  onsubmit="return validateForm()",name="myForm" id="myForm">
  <table>
    <tr>
      <td nowrap colspan="4">
	  Name of Inquirer:&nbsp;
	  <input name="FullName" type="text" id="Name" size="30" >
	</td>
    </tr>
	 <tr>
      <td nowrap colspan="4">
	  Business Name (if applicable):&nbsp;
	  <input name="BusinessName" type="text" size="40">
	</td>
    </tr>



  <tr>
  	<td colspan=4 nowrap>E-mail Address of Inquirer:
      <input type="text" class="left phone-group" name="Email" id="email"  size="20" ></td>

  </tr>


   <tr>
   		<td colspan="4" nowrap>Phone Number:
<input type="text" class="phone" name="Phone" id="phone" size="18"  >(include area code)


		</td>
   </tr>



  <tr>
    <td colspan="4" align="center"><input name="Input" type="submit" id="btnSubmit" value="Continue..." ></td>
  </tr>

</table>

</form>



<script src=/comptroller/includes/display_objects/custom/escheated/lib/qforms/jquery.min.js"></script>
<script src="/comptroller/includes/display_objects/custom/escheated/lib/qforms/jquery.maskedinput.min.js" type="text/javascript">  </script>






<script type="text/javascript">
jQuery(function($){
 $(".phone").mask('(999) 999-9999');
});

function validateEmail(email)
{
 var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
 if (reg.test(email)){
 return true; }
 else{
 return false;
 }
} 


$(document).ready(function(e)
{
 $('#btnSubmit').click(function()
  { 
  
    
    var phonenumber=document.forms["myForm"]["Phone"].value;
    var emailaddress=document.forms["myForm"]["Email"].value;
    var fullname=document.forms["myForm"]["FullName"].value;

    
    if (emailaddress!="" && !validateEmail(emailaddress)) 
      {
        alert('Invalid Email Address');
        return false;
      }
    
  

if (fullname==null ||fullname=="")
  {
  alert("Name must be filled out");
  return false;
  }

   

   {
      if(phonenumber=="" && emailaddress=="")
      {
       alert("Please enter either Email Address or Phone Number");
       return false;
      }
      else{
       return true;
      }
    }

 });
});
</script>

