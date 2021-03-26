<STYLE TYPE="TEXT/CSS">
label,input {
	display: block;
	width: 150px;
	float: left;
	margin-bottom: 10px;
}

label {
	text-align: right;
	width: 130px;
	padding-right: 20px;
}

br {
	clear: left;
}
</STYLE>
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
<!---<br /> needed for space --->
<form action="/?linkservid=8318C651-5056-93B5-5E041C0DB301FD19" method="post" name="myForm">

<!--- Eliminating TIN for search start--->
<!--- <div STYLE="margin-left:75px; "> --->
<!--- <label for="Vendor">TIN or SSN:</label>
<input type = "password" ID="name" name="Vendor" size="9" maxlength="9"> (For individuals, enter Social Security Number)
<br /><!--- </div> --->
<cfif not isDefined("notFirstTry")>
<p> --->
<!--- Eliminating TIN for search end --->

<p><b>Search Page:</b></p>
<p>Enter the name you are inquiring about as it would have appeared on the original warrant* from the State of Illinois. You can search the name of an individual or a business. Tip: for an individual, start your search with the last name only.
</p>


<p>

<div class="form-group">
    <label for="payee_name" class="col-sm-4 control-label">Vendor Name</label>
    <div class="col-sm-8">
      
    
<input TYPE="TEXT" NAME="Payee_Name" ID="payee_name" required> &nbsp;(For individuals, enter last name only)<br /></div>
</div>
<cfif not isDefined("notFirstTry")>
<p>Once the associated Vendor Name is entered, click on "Go!" to process your inquiry.</p>
</cfif>

<div align="center"><input name="submit" type="submit" value="Go!" style="float:none;"></div>

</span></span>

</form>

<p><br />*A warrant is also known as a check.</p>
<SCRIPT LANGUAGE="JavaScript">
	<!--//
	// initialize the qForm object
	objForm = new qForm("myForm");
	objForm.required("Payee_Name");
	<!---objForm.Vendor.validateSSN("Please enter a valid TIN");--->
	//-->	
	
	</SCRIPT>