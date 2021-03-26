$(document).ready(function(){

  $('#phonenumber').mask('(999) 999-9999');
  $('[data-toggle="tooltip"]').tooltip();
  $("#comments").maxlength({max: 1000});

  var max_fields = 5;


  $('.alpha-numeric').keypress(function (e) {
      var regex = new RegExp("^[a-zA-Z0-9]+$");
      var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
      if (regex.test(str)) {
          return true;
      }

      e.preventDefault();
      return false;
  });

  $('.drivers-license').keypress(function (e) {
      var regex = new RegExp("^[a-zA-Z0-9-]+$");
      var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
      if (regex.test(str)) {
          return true;
      }

      e.preventDefault();
      return false;
  });  

  $('.datepicerval').keypress(function (e) {
      var regex = new RegExp("^[/0-9]+$");
      var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
      if (regex.test(str)) {
          return true;
      }

      e.preventDefault();
      return false;
  });  

  $('.numeric').keypress(function (e) {
      var regex = new RegExp("^[0-9]+$");
      var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
      if (regex.test(str)) {
          return true;
      }

      e.preventDefault();
      return false;
  });

  $('.iwnumeric').keypress(function (e) {
      var regex = new RegExp("^[0-9,]+$");
      var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
      if (regex.test(str)) {
          return true;
      }

      e.preventDefault();
      return false;
  });  

    function hideAllFields(){
      $(".firstName-container").attr("class","form-group firstName-container required hide");
      $(".middleName-container").attr("class","form-group middleName-container hide");
      $(".lastName-container").attr("class","form-group lastName-container required hide");
      $(".phonenumber-container").attr("class","form-group phonenumber-container required hide");
      $(".businessName-container").attr("class","form-group businessName-container required hide");
      $(".ssnfein-container").attr("class","input-group ssnfein-container required hide");
      $(".iwNumber-container").attr("class","form-group iwNumber-container required hide");
      $(".caddress-container").attr("class","form-group caddress-container hide");
      $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required hide");
      $(".cStreetaddress2-container").attr("class","form-group cStreetaddress2-container hide");
      $(".cCity-container").attr("class","form-group cCity-container required hide");
      $(".cState-container").attr("class","form-group cState-container required hide");
      $(".cZip-container").attr("class","form-group cZip-container required hide");
      $(".filescont").not('.has-error').attr("class", "col-xs-12 col-sm-12 filescont hide");
      $(".reasonProtest").not('.has-error').attr("class", "col-xs-12 col-sm-12 reasonProtest required hide");
      $(".form-submit-button").attr("class","form-submit-button hide");
    }
    function resetAllFields(){
      //Reset All field Values
      $("#firstName").val("");
      $("#middleName").val("");
      $("#lastName").val("");
      $("#phonenumber").val("");
      $("#businessName").val("");
      $("#ssnfein").val("");      
      $("#iwNumber").val("");
      $("#cStreetaddress").val("");
      $("#cStreetaddress2").val("");
      $("#cCity").val("");
      //$("#cState").val("");
      $("#cZip").val("");
      $("#comments").val("");

    }    
    function displayHideInfo(){
            hideAllFields();
            $(".firstName-container").attr("class","form-group firstName-container required show");
            $(".middleName-container").attr("class","form-group middleName-container show");
            $(".lastName-container").attr("class","form-group lastName-container required show");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required show");
            $(".businessName-container").attr("class","form-group businessName-container required show");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required show");            
            $(".iwNumber-container").attr("class","form-group iwNumber-container required show");
            $(".caddress-container").attr("class","form-group caddress-container show");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required show");
            $(".cStreetaddress2-container").attr("class","form-group cStreetaddress2-container show");//Optional
            $(".cCity-container").attr("class","form-group cCity-container required show");
            $(".cState-container").attr("class","form-group cState-container required show");
            $(".cZip-container").attr("class","form-group cZip-container required show");
            $(".form-submit-button").attr("class","form-submit-button show");
            $(".filescont").not('.has-error').attr("class", "col-xs-12 col-sm-12 filescont show");  
            $(".reasonProtest").not('.has-error').attr("class", "col-xs-12 col-sm-12 reasonProtest required show");    
    }
    hideAllFields();
    displayHideInfo();

   $("form").bind("keypress", function(e) {
    if (e.keyCode == 13) return false;
   });

  $("#submit").click(function(){

        if(($("#firstName").val() == "" || $.trim($("#firstName").val()) == "") && ( $.trim($("#businessName").val()) == "")){
            $(".firstName-container").attr("class","form-group firstName-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter First Name OR Business Name.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter First Name OR Business Name.");
                  return false;          
        }
        /*else if($("#middleName").val() == ""){
            $(".firstName-container").attr("class","form-group firstName-container");
            $(".middleName-container").attr("class","form-group middleName-container has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter Middle Initial.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter Middle Initial.");
                  return false;
        }*/        
        else if(($("#lastName").val() == "" || $.trim($("#lastName").val()) == "") && ( $.trim($("#businessName").val()) == "")){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter Last Name.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter Last Name.");
                  return false;
        }
        else if($("#phonenumber").val() == ""){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter Phone Number.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter Phone Number.");
                  return false;
        }
        else if(($("#businessName").val() == "" || $.trim($("#businessName").val()) == "") && ( $.trim($("#firstName").val()) == "" || $.trim($("#lastName").val()) == "")){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");          
            $(".businessName-container").attr("class","form-group businessName-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter Business Name.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter Business Name.");
                  return false;          
        }        
        else if($("#ssnfein").val() == "" || $.trim($("#ssnfein").val()) == ""){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter last 4 digits of Social Security Number (SSN)/FEIN Number.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter last 4 digits of Social Security Number (SSN)/FEIN Number.");
                  return false;
        }                 
        else if($("#iwNumber").val() == "" || ValidateIWNumber($("#iwNumber").val()) == false){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required");                                  
            $(".iwNumber-container").attr("class","form-group iwNumber-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter 14 digit IW Number");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter 14 digit IW Number");
                  return false;
        }
        else if($("#iwNumber2").val() != undefined && ValidateIWNumber($("#iwNumber2").val()) == false){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter 14 digit IW Number");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter 14 digit IW Number");
                  return false;
        }
        else if($("#iwNumber3").val() != undefined && ValidateIWNumber($("#iwNumber3").val()) == false){ //ValidateIWNumber($("#iwNumber3").val()) == false
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter 14 digit IW Number");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter 14 digit IW Number");
                  return false;
        }
        else if($("#iwNumber4").val() != undefined && ValidateIWNumber($("#iwNumber4").val()) == false){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
            $(".iwNumber-container4").attr("class","form-group iwNumber4-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter 14 digit IW Number");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter 14 digit IW Number");
                  return false;
        }
        else if($("#iwNumber5").val() != undefined && ValidateIWNumber($("#iwNumber5").val()) == false){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
            $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
            $(".iwNumber-container5").attr("class","form-group iwNumber5-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter 14 digit IW Number");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter 14 digit IW Number");
                  return false;
        }                                
        else if($("#cStreetaddress").val() == ""){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
            $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
            $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter Street Address.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter Street Address.");
                  return false;
        }
        else if($("#cCity").val() == ""){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
            $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
            $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
            $(".cCity-container").attr("class","form-group cCity-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter City.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter City.");
                  return false;
        }
        else if($("#cState").val() == "0"){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
            $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
            $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
            $(".cCity-container").attr("class","form-group cCity-container");
            $(".cState-container").attr("class","form-group cState-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please select State.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please select State.");
                  return false;
        } 
        else if($("#cZip").val() == ""){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
            $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
            $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
            $(".cCity-container").attr("class","form-group cCity-container required");
            $(".cState-container").attr("class","form-group cState-container required");          
            $(".cZip-container").attr("class","form-group cZip-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter ZIP Code.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter ZIP Code.");
                  return false;
        } 
        else if($("#comments").val() == ""){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
            $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
            $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
            $(".cCity-container").attr("class","form-group cCity-container required");
            $(".cState-container").attr("class","form-group cState-container required");          
            $(".cZip-container").attr("class","form-group cZip-container required");          
            $(".reasonProtest").attr("class","form-group reasonProtest required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter Reason for protest.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter Reason for protest.");
                  return false;          
        }
        else if($("#Signature").is(':checked') == false){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
            $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
            $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
            $(".cCity-container").attr("class","form-group cCity-container required");
            $(".cState-container").attr("class","form-group cState-container required");          
            $(".cZip-container").attr("class","form-group cZip-container required");          
            $(".reasonProtest").attr("class","form-group reasonProtest required"); 
            $("#messageHolderTop")
             .attr("class","alert alert-danger")
              .html("Please select the checkbox at the bottom of the screen to accept the conditions.");
            $("#messageHolderBottom")
              .attr("class","alert alert-danger")
               .html("Please select the checkbox at the bottom of the screen to accept the conditions.");
            return false;
        }        
        else{
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".ssnfein-container").attr("class","input-group ssnfein-container required"); 
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
            $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
            $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
            $(".cCity-container").attr("class","form-group cCity-container required");
            $(".cState-container").attr("class","form-group cState-container required");          
            $(".cZip-container").attr("class","form-group cZip-container required");          
            $(".dob-container").attr("class","form-group dob-container required"); 
            $(".reasonProtest").attr("class","form-group reasonProtest required");          
              $("#messageHolderTop")
                  .attr("class","hide")
                   .html("");
                $("#messageHolderBottom")
                    .attr("class","hide")
                     .html("");
            $('#OnlineForm').submit();
        }
  });

    var x = 1;
    $(".add_field_button").on("click",function(e){ //on add input button click
        e.preventDefault();
        if(x < max_fields){ //max input box allowed
            x++; //text box increment
            //SR 18101
            //Changed maxlength to 14 and editted placeholder.
            $("#input_fields_wrap")
              .append('<div class="col-xs-12 col-sm-12 col-md-6"> <div class="form-group required iwNumber-container' + x +'"> <label for="iwNumber">IW Number</label> <input class="form-control alpha-numeric" placeholder="14 digit IW Number" id="iwNumber' + x +'" name="iwNumber' + x +'" data-required="true" maxlength="14"> </div> </div> <div class="col-xs-12 col-sm-12 col-md-6 padt24"> <div class="form-group text-center iwNumber-container"> <button class="remove_field_button btn btn-success form-btn">Remove</button> </div> </div>'); //add input box
        }
    });
    
    $("#input_fields_wrap").on("click",".remove_field_button", function(e){ //user click on remove text
        e.preventDefault(); 
        console.log($(this).html());
        //$(this).parent('div').remove(); x--;
        $(this).parent().parent().parent().remove();
        x--;
    })


});
//SR 18101
//Changed maxlength to 14
function ValidateIWNumber(objVal){
  var objChkVal = 0;
  if(objVal == undefined){
    return false;
  }
  else if(objVal.length != "14"){
    return false;
  }
  else{
    return true;
  }
}
function ValidateDate(objVal) {

        var dateReg = /^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20|21)\d{2}$/;
        //if (isNaN(oDate)) {
         if(! dateReg.test(objVal) ) {
            return false;
        }else{
         return true;
        }
};