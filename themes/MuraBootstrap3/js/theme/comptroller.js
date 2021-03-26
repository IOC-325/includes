// 2020-01-02 - ASP - "SetHighlightingOnfooterNav_V2()" should only be called after the element with the class "footer-icons" exists
var existCondition = setInterval(function() {
 if ($('.footer-icons').length) {
    console.log("Exists!");
    clearInterval(existCondition);
    setHighlightingOnFooterNav_V2();  
 }
}, 100); // check every 100ms



window.onload = function() {

$('#sign-up-newsletter').modal('show');

setHighlightingOnFooterNav_V2();

// $.getScript('jquery.waituntilexists.min.js', function()
// {
//     // script is now loaded and executed.
//     // put your dependent JS here.
// });
//


//Below code is redundent but we have to call this on different intervels to make sure the componets are getting highlighted
/*setTimeout( function(){ 
     setHighlightingOnFooterNav_V2();  
  }  , 300 );

setTimeout( function(){ 
     setHighlightingOnFooterNav_V2();  
  }  , 1500 );

setTimeout( function(){ 
     setHighlightingOnFooterNav_V2();  
  }  , 2000 );

setTimeout( function(){ 
     setHighlightingOnFooterNav_V2();  
  }  , 3000 );

setTimeout( function(){ 
     setHighlightingOnFooterNav_V2();  
  }  , 3500 );*/

};

 function setHighlightingOnFooterNav_V2(){
  var divs = document.querySelectorAll(".footer-icons>a"), i;
  var arrURLLink, linkToCheck;
  var currentURL = window.location.href;//window.location.href.split("?")[0];

		for (i = 0; i < divs.length; ++i) {
			//console.log(currentURL);
			//console.log(divs[i].href);
			//if(divs[i].href.split("?")[0] == currentURL){
			if(divs[i].href == currentURL){				
				divs[i].parentElement.parentElement.classList.add("hovered");
			}
		}		

   currentURL = window.location.href.replace("/index.cfm","").split("?")[0];

    for (i = 0; i < divs.length; ++i) {
      //console.log(currentURL);
      //console.log(divs[i].href);
      //if(divs[i].href.split("?")[0] == currentURL){
      if(divs[i].href.split("?")[0] == currentURL){       
        divs[i].parentElement.parentElement.classList.add("hovered");
		divs[i].closest("div").classList.add("hovered");
      }
    }     


 }


 
 function setHighlightingOnFooterNav(){
  var divs = document.querySelectorAll(".footer-icons>a"), i;
  var arrURLLink, linkToCheck;
  var currentURL = window.location.href;
	
	if( currentURL.substr(currentURL.length - 1) == '/' ){
		currentURL = currentURL.slice(0, -1);
	}
  //console.log( divs );
		for (i = 0; i < divs.length; ++i) {
			var lastChar = divs[i].href.substr(divs[i].href.length - 1);
			
		  if( lastChar = '/' ){
			nodeURL = divs[i].href.slice(0, -1);
		  } else {
			nodeURL = divs[i].href;
		  }
  
		  arrURLLink = nodeURL.split("/");
		  linkToCheck = arrURLLink[arrURLLink.length - 1];

		  if( currentURL.indexOf( linkToCheck ) > -1 ) {
			divs[i].parentElement.parentElement.classList.add("hovered");
		  } else {
			
			}
 		}
 }

  function togglePassword(el, obj, toggleTextObj){
 
  // Checked State
  var checked = el.checked;

  if(checked){
   // Changing type attribute
   obj.type = 'text';

   // Change the Text
   toggleTextObj.textContent= "Hide";
  }else{
   // Changing type attribute
   obj.type = 'password';

   // Change the Text
   toggleTextObj.textContent= "Show";
  }

 }


 // function togglePassword(el){
 
 //  // Checked State
 //  var checked = el.checked;

 //  if(checked){
 //   // Changing type attribute
 //   document.getElementById("password").type = 'text';

 //   // Change the Text
 //   document.getElementById("toggleText").textContent= "Hide";
 //  }else{
 //   // Changing type attribute
 //   document.getElementById("password").type = 'password';

 //   // Change the Text
 //   document.getElementById("toggleText").textContent= "Show";
 //  }

 // }
// $(".mura-body").ready(function(){
// 	setHighlightingOnFooterNav_V2();//.delay(500);
// });