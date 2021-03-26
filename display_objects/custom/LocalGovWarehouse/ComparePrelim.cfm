<cfif isDefined("form.Unit_A_Code")>
  <cfset Unit_A_Code = form.Unit_A_Code>
<cfelseif isDefined("URL.Unit_A_Code")>
  <cfset Unit_A_Code = URL.Unit_A_Code>
</cfif>

<cfif isDefined("form.Unit_B_Code")>
  <cfset Unit_B_Code = form.Unit_B_Code>
<cfelseif isDefined("URL.Unit_B_Code")>
  <cfset Unit_B_Code = URL.Unit_B_Code>
</cfif>

<cfif isDefined("form.Unit_A_FY")>
  <cfset Unit_A_FY = form.Unit_A_FY>
<cfelseif isDefined("URL.Unit_A_FY")>
  <cfset Unit_A_FY = URL.Unit_A_FY>
</cfif>

<cfif isDefined("form.Unit_B_FY")>
  <cfset Unit_B_FY = form.Unit_B_FY>
<cfelseif isDefined("URL.Unit_B_FY")>
  <cfset Unit_B_FY = URL.Unit_B_FY>
</cfif>


<cfif isDefined("form.AFRDesiredData")>
  <cfset AFRDesiredData = form.AFRDesiredData>
<cfelseif isDefined("URL.AFRDesiredData")>
  <cfset AFRDesiredData = URL.AFRDesiredData>
</cfif>


<cfif isDefined("form.ShowHeader")>
  <cfset attributes.ShowHeader = form.ShowHeader>
<cfelseif isDefined("URL.ShowHeader")>
  <cfset attributes.ShowHeader = URL.ShowHeader>
</cfif>


<cfif isDefined("form.DestinationPage")>
  <cfset DestinationPage = form.DestinationPage>
<cfelseif isDefined("URL.DestinationPage")>
  <cfset DestinationPage = URL.DestinationPage>
</cfif>

<cfif isDefined("form.originalSearchString")>
  <cfset attributes.originalSearchString = form.originalSearchString>
<cfelseif isDefined("URL.originalSearchString")>
  <cfset attributes.originalSearchString = URL.originalSearchString>
</cfif>

<cfif isDefined("form.originalSearchString")>
  <cfset originalSearchString = form.originalSearchString>
<cfelseif isDefined("URL.originalSearchString")>
  <cfset originalSearchString = URL.originalSearchString>
</cfif>

<cfoutput>
<!---   <cfdump var="/financial-data/local-government-division/local-government-data/compareprocesssearchresults/?ShowHeader=#attributes.ShowHeader#&DisplayMode=GetAFRSummary&Code=#Unit_A_Code#&CFY=#Unit_A_FY#&AFRDesiredData=#AFRDesiredData#&Unit_B_Code=#Unit_B_Code#"><br/>
  <cfdump var="/financial-data/local-government-division/local-government-data/compareprocesssearchresults/?ShowHeader=#attributes.ShowHeader#&DisplayMode=GetAFRSummary&Code=#Unit_B_Code#&CFY=#Unit_A_FY#&Unit_A_Code=#Unit_A_Code#&Unit_A_FY=#Unit_A_FY#&AFRDesiredData=#AFRDesiredData#&OriginalSearchString=#attributes.OriginalSearchString#"> --->
    
<div class="full-width-container">
<div class="row row-eq-height">
    <div class="col-sm-6">
<div class="resp-container">
        <iframe class="myFrame" <!---id="left_frame"---> src="/financial-data/local-government-division/local-government-data/compareprocesssearchresults/?ShowHeader=#attributes.ShowHeader#&DisplayMode=GetAFRSummary&Code=#Unit_A_Code#&CFY=#Unit_A_FY#&AFRDesiredData=#AFRDesiredData#&Unit_B_Code=#Unit_B_Code#"></iframe>
    </div>
</div>
    <div class="col-sm-6">
<div class="resp-container">
        <iframe class="myFrame" <!---id="right_frame"---> src="/financial-data/local-government-division/local-government-data/compareprocesssearchresults/?ShowHeader=#attributes.ShowHeader#&DisplayMode=GetAFRSummary&Code=#Unit_B_Code#&CFY=#Unit_A_FY#&Unit_A_Code=#Unit_A_Code#&Unit_A_FY=#Unit_A_FY#&AFRDesiredData=#AFRDesiredData#&OriginalSearchString=#attributes.OriginalSearchString#"></iframe>
    </div>
</div>
</div>
</div>
</cfoutput>


<script>
<!---  function resizeIframe(obj) {

    var TempVal1 = ((document.getElementById("left_frame").contentWindow.document.body.scrollHeight)/100)*40;
    var TempVal2 = ((document.getElementById("right_frame").contentWindow.document.body.scrollHeight)/100)*40;
    var FinalVal = 0;
    if(TempVal1 > TempVal2){
      FinalVal = TempVal1;
    }
    else{
      FinalVal = TempVal2;
    }
    //console.log("TempVal1 :" + TempVal1);
    //console.log("TempVal2 :" + TempVal2);
    //console.log("FinalVal :" + FinalVal);
    obj.style.height = FinalVal + 'px';
    //obj.style.height = ((obj.contentWindow.document.body.scrollHeight)/100)*40 + 'px';
    // onload="resizeIframe(this)"
  }--->
</script>

<!--- Added Error Trap for % onload="resizeIframe(this);"--->
<!---
 <cfif not isdefined("Unit_B_Code")>
  <cflocation url="LandingPage.cfm?code=#Unit_A_Code#&searchtype=AllUnits&originalSearchString=#originalSearchString#&BadSearch=Yes">
</cfif> 
<frameset rows="50,*">
	<FRAME scrolling="vertical" src="CompareHeader.cfm?Unit_A_Code=#Unit_A_Code#&Unit_A_FY=#Unit_A_FY#&Unit_B_Code=#Unit_B_Code#&Unit_B_FY=#Unit_B_FY#">
	<FRAMESET cols="50%, 50%">
		<FRAME src="/financial-data/local-government-division/local-government-data/processsearchresults/?ShowHeader=#attributes.ShowHeader#&DisplayMode=GetAFRSummary&Code=#Unit_A_Code#&CFY=#Unit_A_FY#&AFRDesiredData=#AFRDesiredData#&Unit_B_Code=#Unit_B_Code#">
		   
		<FRAME src="/financial-data/local-government-division/local-government-data/processsearchresults/?ShowHeader=#attributes.ShowHeader#&DisplayMode=GetAFRSummary&Code=#Unit_B_Code#&CFY=#Unit_A_FY#&Unit_A_Code=#Unit_A_Code#&Unit_A_FY=#Unit_A_FY#&AFRDesiredData=#AFRDesiredData#&OriginalSearchString=#attributes.OriginalSearchString#">	
    </FRAMESET>     
</cfoutput>
  <NOFRAMES>
      <P>This page uses frames</P>
  </NOFRAMES>
</FRAMESET>
--->
<!--- Analytics
================================================== --->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-23314189-4', 'illinoiscomptroller.com');
  ga('send', 'pageview');

</script>
