<style>

  /* Google Map */
  #map_canvas { width:100%; height: 325px; margin-top: 38px;}


</style>


 <cfinvoke component = "#m.getBean('licensee')#"
   method = "getLicenseeDetails"
   returnVariable = "rc">
   <cfinvokeargument name="id" value="#url.ID#">
 </cfinvoke>

<script async defer src="https://maps.google.com/maps/api/js?key=AIzaSyBfMyjk4Poa-6v5xdSQhAHMKluvzIgFNTw" type="text/javascript"></script>
  <script>

    function initialize() {
        var address = <CFOUTPUT>"#rc.LICENSEE_ADDRESS#, #rc.LICENSEE_CITY#, IL"</CFOUTPUT>;
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode( { 'address': address}, function(results, status) {
           if (status == google.maps.GeocoderStatus.OK) {
               var myOptions = {
                   zoom: 12,
                   center: results[0].geometry.location,
                   mapTypeId: google.maps.MapTypeId.ROADMAP
               };
               var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);

               var marker = new google.maps.Marker({
                   map: map,
                   position: results[0].geometry.location
               });
           } else {
               alert("Geocode was not successful for the following reason: " + status);
           }
        });
    }

</script>

 <div class="gray-div text-center marginb30"><h1><cfoutput>#rc.BUSINESS_NAME# <cfif rc.LICENSEE_TYPE neq 'E'>- #rc.COUNTY#</cfif></cfoutput></h1></div>

  <cfoutput>
    <cfif rc.LICENSEE_TYPE neq 'E'>
        <div class="row">
     <div class="col-sm-6 supressLeftMargin">
      <table class="table table-striped  table-hover table-condensed">
       <thead>
        <tr><th colspan="2">#rc.BUSINESS_NAME# At a Glance</th></tr>
       </thead>
       <tbody>
        <tr>
         <td>Licensee Type</td><td>#rc.LICENSEE_TYPE_NAME#</td>
        </tr>
        <tr>
         <td>Business Name</td><td>#rc.BUSINESS_NAME#</td>
        </tr>
        <tr>
         <td>Street Address</td><td>#rc.LICENSEE_ADDRESS#</td>
        </tr>
        <tr>
         <td>City</td><td>#rc.LICENSEE_CITY#</td>
        </tr>
        <tr>
         <td>State</td><td>#rc.LICENSEE_STATE#</td>
        </tr>
        <tr>
         <td>Zip Code</td><td>#rc.LICENSEE_ZIP#</td>
        </tr>
        <tr>
         <td>County</td><td>#rc.COUNTY#</td>
        </tr>
        <tr>
         <td>Licensee Status</td><td>#rc.LICENSEE_STATUS#</td>
        </tr>
        <tr>
         <td>License Issue Date</td><td>#rc.DATE_ISSUED#</td>
        </tr>
        <tr>
         <td>License Expiration Date</td><td>#rc.ANNAUL_REPORTING_DUE_DATE#</td>
        </tr>
       <!---  <tr>
         <td>Contact Name</td><td>#rc.CONTACT_NAME#</td>
        </tr> --->
        <tr>
         <td>Location Phone</td><td>#rc.CONTACT_PHONE#</td>
        </tr>
       </tbody>
      </table>
     </div>
     <div class="col-sm-6 supressLeftMargin">
      <div id="map_canvas"></div>
     </div>
      </div>
     <p><h2><a href="/about/place/complaints-and-concerns/">If you have any concerns about this facility, you may submit them here.</a></h2></p>
    <cfelse>
     <div class="supressLeftMargin">
      <p><strong>This Licensee is exempt. An Exempt Cemetery is a fraternal, municipal, State, federal or religious cemetery or a family burying ground. Those entities still register with the Comptroller's Office to determine if they are exempt.
      <a href="https://ilesonline.idfpr.illinois.gov/Lookup/LicenseLookup.aspx" target="_blank"> For additional information click here.</a></strong></p>
      <table class="table table-striped  table-hover table-condensed">
       <thead>
        <tr><th colspan="2">#rc.BUSINESS_NAME# At a Glance</th></tr>
       </thead>
       <tbody>
        <tr>
         <td>Licensee Type</td><td>#rc.LICENSEE_TYPE_NAME#</td>
        </tr>
        <tr>
         <td>Business Name</td><td>#rc.BUSINESS_NAME#</td>
        </tr>
        <tr>
         <td>License Issue Date</td><td>#rc.DATE_ISSUED#</td>
        </tr>
       </tbody>
      </table>
     </div>
    </cfif>
   </cfoutput>

<script>
var existGraphCondition = setInterval(function() {
 if ($('#map_canvas').length) {
      console.log("Exists1!");
      initialize();
      clearInterval(existGraphCondition);
 }
}, 100); // check every 100ms

</script>  

<script>

  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  ga('create', 'UA-23314189-4', 'illinoiscomptroller.com');
  ga('send', 'pageview');
</script>
</body>
</html>