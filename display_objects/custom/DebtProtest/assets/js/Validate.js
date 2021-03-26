$(document).ready(function(){
  //$(".date-picker").datepicker();
  $('#phonenumber').mask('(999) 999-9999');
  $('[data-toggle="tooltip"]').tooltip();
  $("#comments").maxlength({max: 1000});
  $('#dob').mask('99/99/9999');

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
      $(".businessName-container").attr("class","form-group businessName-container required hide");
      $(".firstName-container").attr("class","form-group firstName-container required hide");
      $(".middleName-container").attr("class","form-group middleName-container hide");
      $(".lastName-container").attr("class","form-group lastName-container required hide");
      $(".phonenumber-container").attr("class","form-group phonenumber-container required hide");
      $(".ssn-container").attr("class","input-group ssn-container required hide");
      $(".ssn-label-container").attr("class","ssn-label-container hide");
      $(".iwNumber-container").attr("class","form-group iwNumber-container required hide");
      $(".caddress-container").attr("class","form-group caddress-container hide");
      $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required hide");
      $(".cStreetaddress2-container").attr("class","form-group cStreetaddress2-container hide");
      $(".cCity-container").attr("class","form-group cCity-container required hide");
      $(".cState-container").attr("class","form-group cState-container required hide");
      $(".cZip-container").attr("class","form-group cZip-container required hide");
      $(".dob-container").attr("class","form-group dob-container required hide");
      $(".dod-container").attr("class","form-group dod-container required hide");
      $(".dlsid-container").attr("class","form-group dlsid-container hide");
      $(".tickNumber-container").attr("class","form-group tickNumber-container required hide");
      $(".bcaseNum-container").attr("class","form-group bcaseNum-container required hide");
      $(".pdate-container").attr("class","form-group pdate-container required hide");
      $(".faddress-container").attr("class","form-group faddress-container required hide");
      $(".fStreetaddress-container").attr("class","form-group fStreetaddress-container required hide");
      $(".fStreetaddress2-container").attr("class","form-group fStreetaddress2-container hide");
      $(".fCity-container").attr("class","form-group fCity-container required hide");
      $(".fState-container").attr("class","form-group fState-container required hide");
      $(".fZip-container").attr("class","form-group fZip-container required hide");
      $(".executer-container").attr("class","form-group executer-container required hide");
      $(".filescont").not('.has-error').attr("class", "col-xs-12 col-sm-12 filescont hide");
      $(".reasonProtest").not('.has-error').attr("class", "col-xs-12 col-sm-12 reasonProtest required hide");
      $(".form-submit-button").attr("class","form-submit-button hide");
    }
    function resetAllFields(){
      //Reset All field Values
      $("#businessName").val("");
      $("#firstName").val("");
      $("#middleName").val("");
      $("#lastName").val("");
      $("#ssn").val("");
      $("#phonenumber").val("");      
      $("#iwNumber").val("");
      $("#cStreetaddress").val("");
      $("#cStreetaddress2").val("");
      $("#cCity").val("");
      //$("#cState").val("");
      $("#cZip").val("");
      $("#dob").val("");
      $("#dod").val("");
      $("#dlsid").val("");
      $("#tickNumber").val("");
      $("#bcaseNum").val("");
      $("#pdate").val("");
      $("#fStreetaddress").val("");
      $("#fStreetaddress2").val("");
      $("#fCity").val("");
      $("#fState").val("");
      $("#fZip").val("");
      $("#Executer").val("");
      $("#comments").val("");
    }    
    function displayHideInfo(){
          var selDropdownVal = $("#reasonstoProtest").val();
          if(selDropdownVal == "1" || selDropdownVal == "2" || selDropdownVal == "7"){
            //firstName-container,middleName-container,lastName-container,iwNumber-container,caddress,cStreetaddress-container,cStreetaddress2-container,cCity-container,cState-container,
            //cZip-container,dob-container,dlsid-container(opt)
            hideAllFields();
            $(".firstName-container").attr("class","form-group firstName-container required show");
            $(".middleName-container").attr("class","form-group middleName-container show");
            $(".lastName-container").attr("class","form-group lastName-container required show");
            $(".ssn-container").attr("class","input-group ssn-container required");
            $(".ssn-label-container").attr("class","ssn-label-container show");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required show");
            $(".iwNumber-container").attr("class","form-group iwNumber-container required show");
            $(".caddress-container").attr("class","form-group caddress-container show");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required show");
            $(".cStreetaddress2-container").attr("class","form-group cStreetaddress2-container show");//Optional
            $(".cCity-container").attr("class","form-group cCity-container required show");
            $(".cState-container").attr("class","form-group cState-container required show");
            $(".cZip-container").attr("class","form-group cZip-container required show");
            $(".dob-container").attr("class","form-group dob-container required show");
            $(".dlsid-container").attr("class","form-group dlsid-container show");//Optional
            $(".form-submit-button").attr("class","form-submit-button show");
            $(".filescont").not('.has-error').attr("class", "col-xs-12 col-sm-12 filescont show");  
            $(".reasonProtest").not('.has-error').attr("class", "col-xs-12 col-sm-12 reasonProtest required show");    
          }
          if(selDropdownVal == "3"){
            //firstName-container,middleName-container,lastName-container,iwNumber-container,caddress,cStreetaddress-container,cStreetaddress2-container,cCity-container,cState-container,
            //cZip-container,dob-container,dlsid-container(opt),tickNumber-container,pdate-container
            hideAllFields();
            $(".firstName-container").attr("class","form-group firstName-container required show");
            $(".middleName-container").attr("class","form-group middleName-container show"); //Optional
            $(".lastName-container").attr("class","form-group lastName-container required show");
            $(".ssn-container").attr("class","input-group ssn-container required");
            $(".ssn-label-container").attr("class","ssn-label-container show");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required show");
            $(".iwNumber-container").attr("class","form-group iwNumber-container required show");
            $(".caddress-container").attr("class","form-group caddress-container show");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required show");
            $(".cStreetaddress2-container").attr("class","form-group cStreetaddress2-container show");//Optional
            $(".cCity-container").attr("class","form-group cCity-container required show");
            $(".cState-container").attr("class","form-group cState-container required show");
            $(".cZip-container").attr("class","form-group cZip-container required show");
            $(".dob-container").attr("class","form-group dob-container required show"); 
            $(".dlsid-container").attr("class","form-group dlsid-container show");//Optional
            $(".tickNumber-container").attr("class","form-group tickNumber-container required show");
            $(".pdate-container").attr("class","form-group pdate-container required show");
            $(".form-submit-button").attr("class","form-submit-button show");
            $(".filescont").not('.has-error').attr("class", "col-xs-12 col-sm-12 filescont show");
            $(".reasonProtest").not('.has-error').attr("class", "col-xs-12 col-sm-12 reasonProtest required show");      
          }
          if(selDropdownVal == "4"){
                //firstName-container,middleName-container,lastName-container,iwNumber-container,caddress,cStreetaddress-container,cStreetaddress2-container,cCity-container,cState-container,
                //cZip-container,dob-container,dlsid-container(opt),faddress-container,fStreetaddress-container,fStreetaddress2-container,fCity-container,fState-container,fZip-container
                hideAllFields();
                $(".firstName-container").attr("class","form-group firstName-container required show");
                $(".middleName-container").attr("class","form-group middleName-container show"); //Optional
                $(".lastName-container").attr("class","form-group lastName-container required show");
                $(".ssn-container").attr("class","input-group ssn-container required");
                $(".ssn-label-container").attr("class","ssn-label-container show");               
                $(".phonenumber-container").attr("class","form-group phonenumber-container required show");
                $(".iwNumber-container").attr("class","form-group iwNumber-container required show");
                $(".caddress-container").attr("class","form-group caddress-container show");
                $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required show");
                $(".cStreetaddress2-container").attr("class","form-group cStreetaddress2-container show");//Optional
                $(".cCity-container").attr("class","form-group cCity-container required show");
                $(".cState-container").attr("class","form-group cState-container required show");
                $(".cZip-container").attr("class","form-group cZip-container required show");
                $(".dob-container").attr("class","form-group dob-container required show");
                $(".dlsid-container").attr("class","form-group dlsid-container show");//Optional
                $(".faddress-container").attr("class","form-group faddress-container required show");
                $(".fStreetaddress-container").attr("class","form-group fStreetaddress-container required show");
                $(".fStreetaddress2-container").attr("class","form-group fStreetaddress2-container show");//Optional
                $(".fCity-container").attr("class","form-group fCity-container required show");
                $(".fState-container").attr("class","form-group fState-container required show");
                $(".fZip-container").attr("class","form-group fZip-container required show");
                $(".form-submit-button").attr("class","form-submit-button show");
                $(".filescont").not('.has-error').attr("class", "col-xs-12 col-sm-12 filescont show");
                $(".reasonProtest").not('.has-error').attr("class", "col-xs-12 col-sm-12 reasonProtest required show");          
          }
          if(selDropdownVal == "5"){
              //firstName-container,middleName-container,lastName-container,iwNumber-container,dob-container,dod-container,executer-container
              hideAllFields();
              $(".firstName-container").attr("class","form-group firstName-container required show");
              $(".middleName-container").attr("class","form-group middleName-container show");
              $(".lastName-container").attr("class","form-group lastName-container required show");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".ssn-label-container").attr("class","ssn-label-container show");            
              $(".phonenumber-container").attr("class","form-group phonenumber-container required show");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required show");        
              $(".dob-container").attr("class","form-group dob-container required show");
              $(".dod-container").attr("class","form-group dod-container required show");
              $(".executer-container").attr("class","form-group executer-container required show");
              $(".form-submit-button").attr("class","form-submit-button show");
              $(".filescont").not('.has-error').attr("class", "col-xs-12 col-sm-12 filescont show");
              $(".reasonProtest").not('.has-error').attr("class", "col-xs-12 col-sm-12 reasonProtest required show");        
          }
          if(selDropdownVal == "6"){
              //firstName-container,middleName-container,lastName-container,iwNumber-container,caddress,cStreetaddress-container,cStreetaddress2-container,cCity-container,cState-container,
              //cZip-container,dob-container,dlsid-container(opt),bcaseNum-container
              hideAllFields();
              $(".firstName-container").attr("class","form-group firstName-container required show");
              $(".middleName-container").attr("class","form-group middleName-container show"); //Optional
              $(".lastName-container").attr("class","form-group lastName-container required show");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".ssn-label-container").attr("class","ssn-label-container show");            
              $(".phonenumber-container").attr("class","form-group phonenumber-container required show");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required show");
              $(".caddress-container").attr("class","form-group caddress-container show");
              $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required show");
              $(".cStreetaddress2-container").attr("class","form-group cStreetaddress2-container show");//Optional
              $(".cCity-container").attr("class","form-group cCity-container required show");
              $(".cState-container").attr("class","form-group cState-container required show");
              $(".cZip-container").attr("class","form-group cZip-container required show");
              $(".dob-container").attr("class","form-group dob-container required show");
              $(".dlsid-container").attr("class","form-group dlsid-container show");//Optional
              $(".bcaseNum-container").attr("class","form-group bcaseNum-container required show");
              $(".form-submit-button").attr("class","form-submit-button show");
              $(".filescont").not('.has-error').attr("class", "col-xs-12 col-sm-12 filescont show");
              $(".reasonProtest").not('.has-error').attr("class", "col-xs-12 col-sm-12 reasonProtest required show");
          }
          if(selDropdownVal == "8"){
            //firstName-container,middleName-container,lastName-container,iwNumber-container,caddress,cStreetaddress-container,cStreetaddress2-container,cCity-container,cState-container,
            //cZip-container,dob-container,dlsid-container(opt)
            hideAllFields();
            $(".businessName-colClass").attr("class","col-xs-12 col-sm-6 businessName-colClass");
            $(".businessName-container").attr("class","form-group businessName-container required show");
            $(".ssn-container").attr("class","input-group ssn-container required");
            $(".ssn-label-container").attr("class","ssn-label-container show");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required show");
            $(".iwNumber-container").attr("class","form-group iwNumber-container required show");
            $(".caddress-container").attr("class","form-group caddress-container show");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required show");
            $(".cStreetaddress2-container").attr("class","form-group cStreetaddress2-container show");//Optional
            $(".cCity-container").attr("class","form-group cCity-container required show");
            $(".cState-container").attr("class","form-group cState-container required show");
            $(".cZip-container").attr("class","form-group cZip-container required show");
            $(".dlsid-container").attr("class","form-group dlsid-container show");//Optional
            $(".form-submit-button").attr("class","form-submit-button show");
            $(".filescont").not('.has-error').attr("class", "col-xs-12 col-sm-12 filescont show");  
            $(".reasonProtest").not('.has-error').attr("class", "col-xs-12 col-sm-12 reasonProtest required show");    
          }          
          if(selDropdownVal == "0"){
            hideAllFields();
          }          
    }
    hideAllFields();
    displayHideInfo();

   $("form").bind("keypress", function(e) {
    if (e.keyCode == 13) return false;
   });
   /*$("#user").blur(function(){
    alert(ValidateDate($(this).val()));
   });*/

  /*
  Based on the drop down value selected please validate the required fields
  1. Required firstName,middleName,lastName,iwNumber,cStreetaddress,cStreetaddress2,cCity,cState,cZip,dob,(dlsid)
  2. Required firstName,middleName,lastName,iwNumber,cStreetaddress,cStreetaddress2,cCity,cState,cZip,dob,(dlsid)
  3. Required firstName,lastName,iwNumber,cStreetaddress,cStreetaddress2,cCity,cState,cZip,dob,tickNumber,pdate,(middleName, dlsid)
  4. Required firstName,lastName,iwNumber,cStreetaddress,cStreetaddress2,cCity,cState,cZip,dob,fStreetaddress,fStreetaddress2,fCity,fState,fZip,(middleName,dlsid)
  5. Required firstName,middleName,lastName,iwNumber,dob,dod,Deceased
  6. Required firstName,lastName,iwNumber,cStreetaddress,cStreetaddress2,cCity,cState,cZip,dob,bcaseNum,,(middleName,dlsid)
  7. Required firstName,middleName,lastName,iwNumber,cStreetaddress,cStreetaddress2,cCity,cState,cZip,dob,,(dlsid)


   caddress - cStreetaddress,cStreetaddress2,cCity,cState,cZip
   faddress - fStreetaddress,fStreetaddress2,fCity,fState,fZip
  */

    $("#reasonstoProtest").change(function(){
        var selVal = $("#reasonstoProtest").val();
          if(selVal == "1"){
          $("#infomationMsg1").attr("class","alert alert-info show");
          $("#infomationMsg2").attr("class","alert alert-info hide");
          $("#infomationMsg3").attr("class","alert alert-info hide");
          $("#infomationMsg4").attr("class","alert alert-info hide");
          $("#infomationMsg5").attr("class","alert alert-info hide");
          $("#infomationMsg6").attr("class","alert alert-info hide");
          $("#infomationMsg7").attr("class","alert alert-info hide");                              
          $("#infomationMsg8").attr("class","alert alert-info hide");
        }
        if(selVal == "2"){
          $("#infomationMsg1").attr("class","alert alert-info hide");
          $("#infomationMsg2").attr("class","alert alert-info show");
          $("#infomationMsg3").attr("class","alert alert-info hide");
          $("#infomationMsg4").attr("class","alert alert-info hide");
          $("#infomationMsg5").attr("class","alert alert-info hide");
          $("#infomationMsg6").attr("class","alert alert-info hide");
          $("#infomationMsg7").attr("class","alert alert-info hide");
          $("#infomationMsg8").attr("class","alert alert-info hide"); 
        }
        if(selVal == "3"){
          $("#infomationMsg1").attr("class","alert alert-info hide");
          $("#infomationMsg2").attr("class","alert alert-info hide");
          $("#infomationMsg3").attr("class","alert alert-info show");
          $("#infomationMsg4").attr("class","alert alert-info hide");
          $("#infomationMsg5").attr("class","alert alert-info hide");
          $("#infomationMsg6").attr("class","alert alert-info hide");
          $("#infomationMsg7").attr("class","alert alert-info hide");
          $("#infomationMsg8").attr("class","alert alert-info hide"); 
        }
        if(selVal == "4"){
          $("#infomationMsg1").attr("class","alert alert-info hide");
          $("#infomationMsg2").attr("class","alert alert-info hide");
          $("#infomationMsg3").attr("class","alert alert-info hide");
          $("#infomationMsg4").attr("class","alert alert-info show");
          $("#infomationMsg5").attr("class","alert alert-info hide");
          $("#infomationMsg6").attr("class","alert alert-info hide");
          $("#infomationMsg7").attr("class","alert alert-info hide");
          $("#infomationMsg8").attr("class","alert alert-info hide"); 
        }
        if(selVal == "5"){
          $("#infomationMsg1").attr("class","alert alert-info hide");
          $("#infomationMsg2").attr("class","alert alert-info hide");
          $("#infomationMsg3").attr("class","alert alert-info hide");
          $("#infomationMsg4").attr("class","alert alert-info hide");
          $("#infomationMsg5").attr("class","alert alert-info show");
          $("#infomationMsg6").attr("class","alert alert-info hide");
          $("#infomationMsg7").attr("class","alert alert-info hide");
          $("#infomationMsg8").attr("class","alert alert-info hide"); 
        }
        if(selVal == "6"){
          $("#infomationMsg1").attr("class","alert alert-info hide");
          $("#infomationMsg2").attr("class","alert alert-info hide");
          $("#infomationMsg3").attr("class","alert alert-info hide");
          $("#infomationMsg4").attr("class","alert alert-info hide");
          $("#infomationMsg5").attr("class","alert alert-info hide");
          $("#infomationMsg6").attr("class","alert alert-info show");
          $("#infomationMsg7").attr("class","alert alert-info hide");
          $("#infomationMsg8").attr("class","alert alert-info hide"); 
        }
        if(selVal == "7"){
          $("#infomationMsg1").attr("class","alert alert-info hide");
          $("#infomationMsg2").attr("class","alert alert-info hide");
          $("#infomationMsg3").attr("class","alert alert-info hide");
          $("#infomationMsg4").attr("class","alert alert-info hide");
          $("#infomationMsg5").attr("class","alert alert-info hide");
          $("#infomationMsg6").attr("class","alert alert-info hide");
          $("#infomationMsg7").attr("class","alert alert-info show");
          $("#infomationMsg8").attr("class","alert alert-info hide"); 
        }
        if(selVal == "8"){
          $("#infomationMsg1").attr("class","alert alert-info hide");
          $("#infomationMsg2").attr("class","alert alert-info hide");
          $("#infomationMsg3").attr("class","alert alert-info hide");
          $("#infomationMsg4").attr("class","alert alert-info hide");
          $("#infomationMsg5").attr("class","alert alert-info hide");
          $("#infomationMsg6").attr("class","alert alert-info hide");
          $("#infomationMsg7").attr("class","alert alert-info hide");
          $("#infomationMsg8").attr("class","alert alert-info show"); 
        }        
    });

  $("#nxtBtn").click(function(){
    $("#InformationSection").html(' Note that you must complete all the required fields<span class="red"> (*) </span> in order for your protest to be processed. Once you complete the form and have attached any additional supporting document(s) that you may have, you may submit the form. Please have the document(s) prepared before you fill out this form if you plan to attach them.');    
    if($("#reasonstoProtest").val() !== "0"){
          $(".reasonstoProtest-container").attr("class","form-group reasonstoProtest-container hide");
          $(".nxtBtn-container").attr("class","col-xs-4 col-sm-4 nxtBtn-container hide");
              $("#messageHolderTop")
                  .attr("class","hide")
                   .html("");
        }
        if($("#reasonstoProtest").val() === "0"){
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please select your reason for protest.");
        }
    resetAllFields();
    displayHideInfo();
  });
  
  $("#cnlBtn").click(function(){
          $("#InformationSection").html('Select the reason for your protest below and click on the continue button to file your protest with our office. Note that you must complete all the required fields<span class="red"> (*) </span> in order for your protest to be processed. Once you complete the form and have attached any additional supporting document(s) that you may have, you may submit the form. Please have the document(s) prepared before you fill out this form if you plan to attach them.');
  });

  $("#submit").click(function(){
    var selDropdownValue = $("#reasonstoProtest").val();
      if(selDropdownValue == "1" || selDropdownValue == "2" || selDropdownValue == "7"){

        if($("#firstName").val() == "" || $.trim($("#firstName").val()) == ""){
            $(".firstName-container").attr("class","form-group firstName-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter First Name.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter First Name.");
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
        else if($("#lastName").val() == "" || $.trim($("#lastName").val()) == ""){
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
        else if($("#ssn").val() == "" || $.trim($("#ssn").val()) == ""){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required has-error");
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
            $(".ssn-container").attr("class","input-group ssn-container required");                                   
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
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".ssn-container").attr("class","input-group ssn-container required");
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
        else if($("#dob").val() == "" || ! ValidateDate($("#dob").val())){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
            $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
            $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
            $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
            $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
            $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");
            $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
            $(".cCity-container").attr("class","form-group cCity-container required");
            $(".cState-container").attr("class","form-group cState-container required");          
            $(".cZip-container").attr("class","form-group cZip-container required");          
            $(".dob-container").attr("class","form-group dob-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter Date of Birth.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter Date of Birth.");
                  return false;
        }
        else if($("#comments").val() == ""){
            $(".firstName-container").attr("class","form-group firstName-container required");
            $(".middleName-container").attr("class","form-group middleName-container");
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".ssn-container").attr("class","input-group ssn-container required");
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
      }
      else if(selDropdownValue == "3"){
          if($("#firstName").val() == "" || $.trim($("#firstName").val()) == ""){
              $(".firstName-container").attr("class","form-group firstName-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter First Name.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter First Name.");
                    return false;          
          }
          else if($("#lastName").val() == "" || $.trim($("#lastName").val()) == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
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
          else if($("#ssn").val() == "" || $.trim($("#ssn").val()) == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required has-error");
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
              $(".lastName-container").attr("class","form-group lastName-container required");                           
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");                                     
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".lastName-container").attr("class","form-group lastName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");
              $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
              $(".cCity-container").attr("class","form-group cCity-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
          else if($("#dob").val() == "" || ! ValidateDate($("#dob").val())){
              $(".firstName-container").attr("class","form-group firstName-container required");                        
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");                                  
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");
              $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
              $(".cCity-container").attr("class","form-group cCity-container required");
              $(".cState-container").attr("class","form-group cState-container required");          
              $(".cZip-container").attr("class","form-group cZip-container required");          
              $(".dob-container").attr("class","form-group dob-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Date of Birth.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Date of Birth.");
                    return false;
          }
          else if($("#tickNumber").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");                        
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".tickNumber-container").attr("class","form-group tickNumber-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Ticket Number.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Ticket Number.");
                    return false;
          }
          else if($("#pdate").val() == "" || ! ValidateDate($("#pdate").val())){
              $(".firstName-container").attr("class","form-group firstName-container required");                        
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".tickNumber-container").attr("class","form-group tickNumber-container required");        
              $(".pdate-container").attr("class","form-group pdate-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Payment Date.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Payment Date.");
                    return false;
          }
          else if($("#comments").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");                        
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".tickNumber-container").attr("class","form-group tickNumber-container required");        
              $(".pdate-container").attr("class","form-group pdate-container required"); 
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".tickNumber-container").attr("class","form-group tickNumber-container required");        
              $(".pdate-container").attr("class","form-group pdate-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".tickNumber-container").attr("class","form-group tickNumber-container required");        
              $(".pdate-container").attr("class","form-group pdate-container required");
              $(".reasonProtest").attr("class","form-group reasonProtest required");           
                $("#messageHolderTop")
                    .attr("class","hide")
                     .html("");
                  $("#messageHolderBottom")
                      .attr("class","hide")
                       .html("");
                $('#OnlineForm').submit();
          }
      }
      else if(selDropdownValue == "4"){
          if($("#firstName").val() == "" || $.trim($("#firstName").val()) == ""){
              $(".firstName-container").attr("class","form-group firstName-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter First Name.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter First Name.");
                    return false;          
          }      
          else if($("#lastName").val() == "" || $.trim($("#lastName").val()) == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
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
          else if($("#ssn").val() == "" || $.trim($("#ssn").val()) == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required has-error");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");                                    
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");              
              $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
              $(".cCity-container").attr("class","form-group cCity-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");              
              $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
              $(".cCity-container").attr("class","form-group cCity-container required");
              $(".cState-container").attr("class","form-group cState-container required");          
              $(".cZip-container").attr("class","form-group cZip-container has-error required");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter ZIP Code.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter ZIP Code.");
                    return false;
          }
          else if($("#dob").val() == "" || ! ValidateDate($("#dob").val())){
              $(".firstName-container").attr("class","form-group firstName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");              
              $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
              $(".cCity-container").attr("class","form-group cCity-container required");
              $(".cState-container").attr("class","form-group cState-container required");          
              $(".cZip-container").attr("class","form-group cZip-container required");          
              $(".dob-container").attr("class","form-group dob-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Date of Birth.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Date of Birth.");
                    return false;
          }
          else if($("#fStreetaddress").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".fStreetaddress-container").attr("class","form-group fStreetaddress-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Former Street Address.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Street Address.");
                    return false;
          }
          else if($("#fCity").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".fStreetaddress-container").attr("class","form-group fStreetaddress-container required");          
              $(".fCity-container").attr("class","form-group fCity-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Former City.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Former City.");
                    return false;
          }
          else if($("#fState").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".fStreetaddress-container").attr("class","form-group fStreetaddress-container required"); 
              $(".fCity-container").attr("class","form-group fCity-container required");                     
              $(".fState-container").attr("class","form-group fState-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Former State.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Former State.");
                    return false;
          } 
          else if($("#fZip").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".fStreetaddress-container").attr("class","form-group fStreetaddress-container required"); 
              $(".fCity-container").attr("class","form-group fCity-container required");                     
              $(".fState-container").attr("class","form-group fState-container required");        
              $(".fZip-container").attr("class","form-group fZip-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Former ZIP Code.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Former ZIP Code.");
                    return false;
          }
          else if($("#comments").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".fStreetaddress-container").attr("class","form-group fStreetaddress-container required"); 
              $(".fCity-container").attr("class","form-group fCity-container required");                     
              $(".fState-container").attr("class","form-group fState-container required");        
              $(".fZip-container").attr("class","form-group fZip-container required"); 
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".fStreetaddress-container").attr("class","form-group fStreetaddress-container required"); 
              $(".fCity-container").attr("class","form-group fCity-container required");                     
              $(".fState-container").attr("class","form-group fState-container required");        
              $(".fZip-container").attr("class","form-group fZip-container required");
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
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".fStreetaddress-container").attr("class","form-group fStreetaddress-container required"); 
              $(".fCity-container").attr("class","form-group fCity-container required");                     
              $(".fState-container").attr("class","form-group fState-container required");        
              $(".fZip-container").attr("class","form-group fZip-container required");
              $(".reasonProtest").attr("class","form-group reasonProtest required");                       
                $("#messageHolderTop")
                    .attr("class","hide")
                     .html("");
                  $("#messageHolderBottom")
                      .attr("class","hide")
                       .html("");
                $('#OnlineForm').submit();
          }        
      }
      else if(selDropdownValue == "5"){
          if($("#firstName").val() == "" || $.trim($("#firstName").val()) == ""){
              $(".firstName-container").attr("class","form-group firstName-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter First Name.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter First Name.");
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
          else if($("#lastName").val() == "" || $.trim($("#lastName").val()) == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              //$(".middleName-container").attr("class","form-group middleName-container required");
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
                //$(".middleName-container").attr("class","form-group middleName-container required");
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
          else if($("#ssn").val() == "" || $.trim($("#ssn").val()) == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required has-error");
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
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");                      
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
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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

          else if($("#dob").val() == "" || ! ValidateDate($("#dob").val())){
              $(".firstName-container").attr("class","form-group firstName-container required");
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");              
              $(".dob-container").attr("class","form-group dob-container required has-error");
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Date of Birth.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Date of Birth.");
                    return false;
          }
          else if($("#dod").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");              
              $(".dod-container").attr("class","form-group dod-container required has-error");            
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Date of Death.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Date of Death.");
                    return false;
          }
          else if($("#executer").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");              
              $(".dob-container").attr("class","form-group dob-container required");
              $(".executer-container").attr("class","form-group executer-container required has-error");            
                   $("#messageHolderTop")
                    .attr("class","alert alert-danger")
                     .html("Please enter Executor.");
                  $("#messageHolderBottom")
                      .attr("class","alert alert-danger")
                       .html("Please enter Executor.");
                    return false;
          }
          else if($("#comments").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");              
              $(".dob-container").attr("class","form-group dob-container required");
              $(".executer-container").attr("class","form-group executer-container required"); 
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
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");              
              $(".dob-container").attr("class","form-group dob-container required");
              $(".executer-container").attr("class","form-group executer-container required");
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
              //$(".middleName-container").attr("class","form-group middleName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");              
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
              $(".iwNumber-container").attr("class","form-group iwNumber-container required");
              $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
              $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
              $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
              $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");              
              $(".dob-container").attr("class","form-group dob-container required");
              $(".executer-container").attr("class","form-group executer-container required");
              $(".reasonProtest").attr("class","form-group reasonProtest required");                                          
                $("#messageHolderTop")
                    .attr("class","hide")
                     .html("");
                  $("#messageHolderBottom")
                      .attr("class","hide")
                       .html("");
                $('#OnlineForm').submit();
          }       
      }
      else if(selDropdownValue == "6"){
        if($("#firstName").val() == "" || $.trim($("#firstName").val()) == ""){
                $(".firstName-container").attr("class","form-group firstName-container required has-error");
                     $("#messageHolderTop")
                      .attr("class","alert alert-danger")
                       .html("Please enter First Name.");
                    $("#messageHolderBottom")
                        .attr("class","alert alert-danger")
                         .html("Please enter First Name.");
                      return false;          
            }
            else if($("#lastName").val() == "" || $.trim($("#lastName").val()) == ""){
                $(".firstName-container").attr("class","form-group firstName-container required");
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
            else if($("#ssn").val() == "" || $.trim($("#ssn").val()) == ""){
                $(".firstName-container").attr("class","form-group firstName-container required");
                //$(".middleName-container").attr("class","form-group middleName-container required");
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required has-error");
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
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");                    
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
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
                $(".iwNumber-container").attr("class","form-group iwNumber-container required");
                $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
                $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
                $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
                $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");                
                $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
                $(".cCity-container").attr("class","form-group cCity-container required");
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
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
            else if($("#dob").val() == "" || ! ValidateDate($("#dob").val())){
                $(".firstName-container").attr("class","form-group firstName-container required");
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
                $(".iwNumber-container").attr("class","form-group iwNumber-container required");
                $(".iwNumber-container2").attr("class","form-group iwNumber2-container required");                                              
                $(".iwNumber-container3").attr("class","form-group iwNumber3-container required");                                              
                $(".iwNumber-container4").attr("class","form-group iwNumber4-container required");                                              
                $(".iwNumber-container5").attr("class","form-group iwNumber5-container required");                
                $(".cStreetaddress-container").attr("class","form-group cStreetaddress-container required");          
                $(".cCity-container").attr("class","form-group cCity-container required");
                $(".cState-container").attr("class","form-group cState-container required");          
                $(".cZip-container").attr("class","form-group cZip-container required");          
                $(".dob-container").attr("class","form-group dob-container required has-error");
                     $("#messageHolderTop")
                      .attr("class","alert alert-danger")
                       .html("Please enter Date of Birth.");
                    $("#messageHolderBottom")
                        .attr("class","alert alert-danger")
                         .html("Please enter Date of Birth.");
                      return false;
            }
            else if($("#bcaseNum").val() == ""){
                $(".firstName-container").attr("class","form-group firstName-container required");
                $(".lastName-container").attr("class","form-group lastName-container required");
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
                $(".bcaseNum-container").attr("class","form-group bcaseNum-container required has-error");
                     $("#messageHolderTop")
                      .attr("class","alert alert-danger")
                       .html("Please enter Bankruptcy Case Number.");
                    $("#messageHolderBottom")
                        .attr("class","alert alert-danger")
                         .html("Please enter Bankruptcy Case Number.");
                      return false;
            }
          else if($("#comments").val() == ""){
              $(".firstName-container").attr("class","form-group firstName-container required");
              $(".lastName-container").attr("class","form-group lastName-container required");
              $(".phonenumber-container").attr("class","form-group phonenumber-container required");
              $(".ssn-container").attr("class","input-group ssn-container required");
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
              $(".bcaseNum-container").attr("class","form-group bcaseNum-container required");
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
                $(".lastName-container").attr("class","form-group lastName-container required");                
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
                $(".bcaseNum-container").attr("class","form-group bcaseNum-container required");
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
                $(".lastName-container").attr("class","form-group lastName-container required");                
                $(".phonenumber-container").attr("class","form-group phonenumber-container required");
                $(".ssn-container").attr("class","input-group ssn-container required");
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
                $(".bcaseNum-container").attr("class","form-group bcaseNum-container required");
                $(".reasonProtest").attr("class","form-group reasonProtest required");        
                  $("#messageHolderTop")
                      .attr("class","hide")
                       .html("");
                    $("#messageHolderBottom")
                        .attr("class","hide")
                         .html("");
                    $('#OnlineForm').submit();
            }                 
      }
      else if(selDropdownValue == "8"){
        if($("#businessName").val() == "" || $.trim($("#businessName").val()) == ""){
            $(".businessName-container").attr("class","form-group businessName-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter Business Name.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter Business Name.");
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
        else if($("#phonenumber").val() == ""){
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter Phone Number.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter Phone Number.");
                  return false;
        }                 
        else if($("#ssn").val() == "" || $.trim($("#ssn").val()) == ""){
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required has-error");
                 $("#messageHolderTop")
                  .attr("class","alert alert-danger")
                   .html("Please enter last 4 digits of Social Security Number (SSN)/FEIN Number.");
                $("#messageHolderBottom")
                    .attr("class","alert alert-danger")
                     .html("Please enter last 4 digits of Social Security Number (SSN)/FEIN Number.");
                  return false;
        }        
        
        else if($("#iwNumber").val() == "" || ValidateIWNumber($("#iwNumber").val()) == false){
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");                                  
            $(".ssn-container").attr("class","input-group ssn-container required"); 
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
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");             
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
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");            
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
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".businessName-container").attr("class","form-group businessName-container required");
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".businessName-container").attr("class","form-group businessName-container required");                        
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".businessName-container").attr("class","form-group businessName-container required");                        
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".businessName-container").attr("class","form-group businessName-container required");                        
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".businessName-container").attr("class","form-group businessName-container required");                        
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".businessName-container").attr("class","form-group businessName-container required");                        
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".businessName-container").attr("class","form-group businessName-container required");                        
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
            $(".businessName-container").attr("class","form-group businessName-container required");                        
            $(".phonenumber-container").attr("class","form-group phonenumber-container required");
            $(".ssn-container").attr("class","input-group ssn-container required");
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
                  .attr("class","hide")
                   .html("");
                $("#messageHolderBottom")
                    .attr("class","hide")
                     .html("");
            $('#OnlineForm').attr('autocomplete', 'off');
            $('#OnlineForm').submit();
        }
      }
      else
      {
        return false;
      }
  });

    var x = 1;
    $(".add_field_button").on("click",function(e){ //on add input button click
        e.preventDefault();
        if(x < max_fields){ //max input box allowed
            x++; //text box increment
            $("#input_fields_wrap")
              .append(' <div class="col-xs-12 col-sm-12 col-md-6"> <div class="form-group required iwNumber-container' + x +'"> <label for="iwNumber">IW Number</label> <input class="form-control alpha-numeric" placeholder="14 digit IW Number" id="iwNumber' + x +'" name="iwNumber' + x +'" data-required="true" maxlength="14"> </div> </div> <div class="col-xs-12 col-sm-12 col-md-6 padt24"> <div class="form-group text-center iwNumber-container"> <button class="remove_field_button btn btn-success form-btn">Remove</button> </div> </div> '); //add input box
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
function ValidateIWNumber(objVal){
  var objChkVal = 0;
  /*if(objVal !== ""){
    if(objVal.indexOf(",") !== "-1"){
      //Has a comma
      var objArr = objVal.split(",");
      for(var i = 0; i < objArr.length; i++) {
       if(objArr[i].length != "14"){
        objChkVal = 1;
       }
      }
      if(objChkVal == "1"){
        return false;        
      }
      else{
        return true;
      }
    }
    else if(objVal.length != "14"){
      return false;
    }
  }
  else{
    return false;
  }*/
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