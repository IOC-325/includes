function inquire(warrnum,TIN){
	
		inquireWin = window.open('inquire.cfm?Warrant=' + warrnum +'&TIN=' + TIN, 'INVESTMENT', 'height=470,width=600,resizable=yes,scrollbars=yes,status=no,toolbar=no')
		inquireWin.focus();
		
}

function espinquire(warrnum,TIN){
	
		inquireWin = window.open('espinquire.cfm?Warrant=' + warrnum +'&TIN=' + TIN, 'INVESTMENT', 'height=470,width=600,resizable=yes,scrollbars=yes,status=no,toolbar=no')
		inquireWin.focus();
		
}

function setStatus(str){
	window.status = str;
	return true;
}


function stripSpaces(x) { 
	return x.replace(/^\W+/,'');
	 }
	 
function empty(x) { if (x.length > 0) return false; else return true; }
	 

function _CF_onError(form_object, input_object, object_value, error_message)
    {
	alert(error_message);
       	return false;	
    }



function _CF_checkregex(object_value, regex)
	{
	//Returns true if the value matches the Regular Expression passed in.
	
	return regex.test(object_value);

	}
function validateTIN(what) 	
{
if (empty(stripSpaces(what.Vendor.value))) {
	alert('Please provide a TIN or SSN.');
	return false;
	}
var Chars = "0123456789";
var theString = what.Vendor.value;
   for (var i = 0; i < theString.length; i++) {
      if (Chars.indexOf(theString.charAt(i)) == -1) {
          alert('You have entered something other than a numeric value for the TIN or SSN.');
		  return false;
		 }
    }
    	
if (theString.length != 9) {
      alert('Vendor TIN or SSN must be 9 characters in length.');
     return false;
   }
 return true;
}
	
	
function validateValues(what) {

  	
if (empty(stripSpaces(what.Email.value))) {	
} else {
 if  (!_CF_checkregex(what.Email.value, /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name|IllinoisComptroller.Gov|state.il.us))$/))

        {

       		alert('If you would like to enter an email address, please supply a valid one, like joe@comptroller.com');
            return false; 

            
}
        }	
	
	
	
	if (empty(stripSpaces(what.Phone.value))) {
	 if (empty(stripSpaces(what.Email.value))) {
		alert('Both your phone number and your email address are empty. Please provide one or both of these');
		return false;
	 }
	}
   if (empty(stripSpaces(what.FullName.value))) {
   		alert('Please provide a Name.');
		return false;
		}
	if (empty(stripSpaces(what.TIN.value))) {
		alert('Please provide a TIN or SSN.');
		return false;
		}
	
	var Chars = "0123456789";
	var theString = what.TIN.value;
    for (var i = 0; i < theString.length; i++) {
       if (Chars.indexOf(theString.charAt(i)) == -1) {
          alert('You have entered something other than a numeric value for the TIN or SSN.');
		  return false;
		  }
    	}
    	
	if (theString.length != 9) {
        alert('Vendor TIN or SSN must be 9 characters in length.');
        return false;
    }
		
		
		
 return true;
}


function checkSubmit(what) {
//alert('checking' + what.LegalName.value + 'value');
if (empty(stripSpaces(what.LegalName.value))) {
	alert('Please enter the Legal Name of the Payee.');
    return false;           
	}
if (empty(stripSpaces(what.Addr1.value))) {
	alert('Please enter information on the Address line.');
    return false;           
	}        
if (empty(stripSpaces(what.City.value))) {
	alert('Please enter information on the City line.');
    return false;           
	}     
	
if (empty(stripSpaces(what.State.value))) {
	alert('Please enter information on the State line.');
    return false;           
	}     
	
if (empty(stripSpaces(what.Zip.value))) {
	alert('Please enter information on the Zip line.');
    return false;           
	}     		 		
 return true;
}