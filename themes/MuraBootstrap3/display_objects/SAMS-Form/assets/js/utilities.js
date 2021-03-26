// Add validation to blur events
$(document).ready(function(){
    $('.container').on('blur', '#firstName',  function() {     validateField('#firstName'); });
    $('.container').on('blur', '#lastName',  function() {      validateField('#lastName'); });
    $('.container').on('blur', '#telephone', function() {     validateTelephone('#telephone'); });
    $('.container').on('blur', '#email', function() {         validateRegex('#email', /^[^\s@]+@[^\s@]+\.[^\s@]+$/, 'Must be a valid email'); });
    $('.container').on('blur', '#street', function() {        validateField('#street'); });
    $('.container').on('blur', '#city', function() {          validateField('#city'); });
    $('.container').on('blur', '#stateID', function() {       validateField('#stateID'); });
    $('.container').on('blur', '#zipcode', function() {       validateRegex('#zipcode', /^\d{5}(?:[-\s]?\d{4})?$/, 'Invalid'); });
    $('.container').on('blur', '#agencyID', function() {      validateField('#agencyID'); });
    $('.container').on('blur', '#procedureID', function() {   validateRegex('#procedureID', /^(\d{2}\.){2}\d{2}.*/, 'Must be a valid procedure number'); });
    $('.container').on('blur', '#reason', function() {        validateField('#reason'); });
    $('.container').on('blur', '#description', function() {   validateField('#description'); });
});

// validates all the required fields and doesn't submit unless all there
function validateSubmission()
{
    allowSubmit = true;     // Default to allow submission

    cleanFields('.form-control');  // Resets all errors

    // If the captcha exists on the page, validate if it has been completed
    if($('.g-recaptcha-response').length)   
    {
        var response = grecaptcha.getResponse();

        if(response.length == 0)
        {
            allowSubmit = false;

            // Show error if not completed
            if(!$("#captcha-alert").children(".alert").length)
                $("#captcha-alert").append("<div class='alert alert-danger'>The reCaptcha must be completed to submit</div>");
        }
    }
    

    // If error on any validation then disallow submission.
    // validate that all requester fields are not empty
    if(!validateLength('#firstName'))
        allowSubmit = false;
    if(!validateLength('#lastName'))
        allowSubmit = false;
    if(!validateRegex('#email', /^[^\s@]+@[^\s@]+\.[^\s@]+$/, 'Must be a valid email'))       // Checks if valid email
        allowSubmit = false;
    if(!validateLength('#agencyID'))
        allowSubmit = false;
    if(!validateLength('#street'))
        allowSubmit = false;
    if(!validateLength('#city'))
        allowSubmit = false;
    if(!validateLength('#stateID'))
        allowSubmit = false;
    if(!validateRegex('#zipcode', /^\d{5}(?:[-\s]?\d{4})?$/, 'Invalid'))    // Checks if valid zip code
        allowSubmit = false;
    if(!validateTelephone('#telephone'))    // Checks if valid phone number
        allowSubmit = false;


    // Validate that all the revision fields are not empty
    //      Check revisionType and handle accordingly
    if($('input[name=revisionType]:checked').val() == "existing")
    {
        if(!validateRegex('#procedureID', /^(\d{2}\.){2}\d{2}.*/, "Must be a valid procedure number"))
            allowSubmit = false;
    }
    else if($('input[name=revisionType]:checked').val() != "new") //change
    {
        allowSubmit = false;

        if(!$("#type-alert").children(".alert").length)
            $("#type-alert").append("<div class='alert alert-danger'>The procedure must be new or existing</div>");
    }
    
    if(!validateLength('#reason'))
        allowSubmit = false;
    if(!validateLength('#description'))
        allowSubmit = false;

    if (allowSubmit) 
	{
		$('#revisionForm').submit();
	}
}


// Removes error visuals
function cleanFields(fieldClass)
{
    $(fieldClass).parent().removeClass("has-error");
    $(fieldClass).parent().children(".error-message").remove();
    $('.alert').remove();
}


// Add the error class and error message if that field is empty
function validateLength(fieldLocation)
{
    if($(fieldLocation).val().length == 0)
    {
        addError(fieldLocation, "Required");
        return false;
    }
    else
        return true;
}


// Runs basic no-input validation and cleans up if valid
function validateField(fieldLocation)
{
    if(validateLength(fieldLocation))
    {
        $(fieldLocation).parent().removeClass("has-error");
        $(fieldLocation).parent().children(".error-message").remove();
    }
}


// Validates telephone number field with regex
function validateTelephone(fieldLocation)
{
    if(validateLength(fieldLocation))
    {
        var phoneField = $(fieldLocation).val();
        var letterRegex = /.*[a-zA-z]+.*/;
        var phoneRegex = /^1?[2-9]\d{9}$/;

        // Check if field has any letters
        if(letterRegex.test(phoneField))
        {
            addError(fieldLocation, "Must be a valid phone number");
            return false;
        }
        else
        {
            var phoneNumber = phoneField.replace(/[^0-9]/g, '');    // Get only the numbers

            if(phoneNumber[0] == "1" && phoneNumber.length > 7)
                $(fieldLocation).val(phoneNumber[0] +' (' + phoneNumber.substring(1,4) + ') ' + phoneNumber.substring(4,7) + '-' + phoneNumber.substring(7));
            else if(phoneNumber.length  > 6)
                $(fieldLocation).val('(' + phoneNumber.substring(0,3) + ') ' + phoneNumber.substring(3,6) + '-' + phoneNumber.substring(6));


            // Check if it matches phone number format
            if(phoneRegex.test(phoneNumber))
            {
                $(fieldLocation).parent().removeClass("has-error");
                $(fieldLocation).parent().children(".error-message").remove();
                return true;
            }
            else
            {
                addError(fieldLocation, "Must be a valid phone number");
                return false;
            }
        }
    }
    else
        return false;
}


// Validates a field testing it against a regex expression
//   and sending a custom error message
function validateRegex(fieldLocation, regex, message)
{
    //Validate length and regex if required
    if(validateLength(fieldLocation))
    {
        if(regex.test($(fieldLocation).val()))
        {
            $(fieldLocation).parent().removeClass("has-error");
            $(fieldLocation).parent().children(".error-message").remove();
            return true;
        }
        else
        {
            addError(fieldLocation, message);
            return false;
        }
    }
    else
        return false;
}

// Adds error classes and message to the fields
function addError(fieldLocation, message)
{
    $(fieldLocation).parent().addClass("has-error");
            
    if($(fieldLocation).parent().children(".error-message").length)
    {
        $(fieldLocation).parent().children(".error-message").remove();
        $(fieldLocation).parent().children(".field-label").after("<span class='error-message'>" + message + "</span>");
    }
    else
        $(fieldLocation).parent().children(".field-label").after("<span class='error-message'>" + message + "</span>");
}


// Hides procedure number or section field if radio is changed
function procedureOrSection()
{
    $("#procedureID-container").toggle();
    $("#section-container").toggle();
}

/**************************
*   UNUSED FUNCTIONS
***************************/

//document.getElementById("procedureID").onkeypress = validateNum;
//document.getElementById("procedureID").onkeyup = procIDMask;

//Only allows digits for input
function validateNum(myEvent)
{
    if( (myEvent.charCode >= 48 && myEvent.charCode <= 57) || myEvent.keyCode == 9 || myEvent.keyCode == 10 || myEvent.keyCode == 13 || myEvent.keyCode == 8 || myEvent.keyCode == 116 || myEvent.keyCode == 46 || (myEvent.keyCode <= 40 && myEvent.keyCode >= 37) )
    {
        allowInput = true;
    }
    else 
    {
        allowInput = false;
    }

    return allowInput;
}

//Applies a mask to a textbox 
function procIDMask()
{
    var mask = "__.__.__";
    var procIDBox = document.getElementById("procedureID");
    var text = "";
    var numbers = [];
    var output = "";
    var lastPosition = 0;
    text = procIDBox.value;

    //Get numbers
    for(var i=0; i < text.length; i++)
    {
        if(!isNaN(text.charAt(i)) && text.charAt(i) != " ")
        {
            numbers.push(text.charAt(i));
        }
    }

    //Write over the mask
    for(var j=0; j < mask.length; j++)
    {
        if(mask.charAt(j) == "_")
        {
            if(numbers.length == 0)
                output = output + mask.charAt(j);
            else
            {
                output = output + numbers.shift();
                lastPosition = j + 1;
            }
        }
        else
        {
            output = output + mask.charAt(j);
        }
    }

    procIDBox.value = output;
    procIDBox.setSelectionRange(lastPosition, lastPosition);
}