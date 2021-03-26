 <cfscript>
	request.bodytopic = "FILL OUT FORM BELOW";
	request.title="Uncashed State Checks - Illinois Comptroller's Office";
</cfscript>



<p><b>Registration Page:</b></p>
<p>To make an inquiry you must first register. If you do not have a legal relationship with the Vendor* you are searching, you must identify the business you are associated with. The system will not allow you to proceed until the following information is completed:</p>


<form action="/?LinkServID=81A75456-5056-93B5-5E33D53AFFB5C613" method="post"  onsubmit="return validateForm()",name="myForm" class="form-horizontal">
<div class="form-group">
    <label for="inputName" class="col-sm-4 control-label">Name (Last, First)</label>
    <div class="col-sm-8 col-md-5">
      <input type="text" class="form-control" id="name" name="FullName">
    </div>
  </div>
  <div class="form-group">
    <label for="inputBusinessName" class="col-sm-4 control-label">Business Name(if applicable)</label>
    <div class="col-sm-8 col-md-5">
      <input type="text" class="form-control" id="BusinessName" name="BusinessName">
    </div>
  </div>
  <div class="form-group">
    <label for="inputEmail" class="col-sm-4 control-label">E-mail</label>
    <div class="col-sm-8 col-md-5">
      <input type="text" class="form-control" id="email" name="Email">
    </div>
  </div>
  <div class="form-group">
    <label for="inputPhoneNumber" class="col-sm-4 control-label">Phone Number</label>
    <div class="col-sm-8 col-md-5">

<input type="text" class="form-control" id="phone" name="Phone">
    </div>
  </div>

    <div class="text-center">
      <button type="submit" class="btn btn-success" id="btnSubmit">Continue</button>
    </div>
</form>

<p class="margintop30">*Vendor refers to the name of the person or organization listed on the original warrant.</p>
<script src="/comptroller/includes/display_objects/custom/escheated/lib/qforms/jquery.min.js"></script>
<script src="/comptroller/includes/display_objects/custom/escheated/lib/qforms/jquery.maskedinput.min.js" type="text/javascript">  </script>






<script type="text/javascript">
jQuery(function($){
 $("#phone").mask('(999) 999-9999');
 $("#btnSubmit").click(function()
  {
     var phonenumber=$("#phone").val();
     var emailaddress=$("#email").val();
     var fullname=$("#name").val();
     if (fullname==null ||fullname=="")
     {
       alert("Name must be filled out");
       return false;
     }
     if (emailaddress!="" && !validateEmail(emailaddress))
     {
       alert("Invalid Email Address");
       return false;
     }
     if(phonenumber=="" && emailaddress=="")
     {
       alert("Please enter either Email Address or Phone Number");
       return false;
     }
     else{
       return true;
     }
 });

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



</script>

