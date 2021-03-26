<cfinclude template="searchLogic.cfm" />

<style>
      #map-canvas {
        height: 475px;
        margin: 0px;
        padding: 0px
      }
    </style>

<script>

function initialise() {
  // create object literal to store map properties

  map = new google.maps.Map(document.getElementById('map-canvas'), {
    zoom: 6,
    center: {lat: 40.0000, lng: -89.0000}
  });

  <cfif arrayLen(arrShelter)>


  // create map bounds object - our locations will be added to the bounds object
  // and the map will be centered based upon the coordinates of the locations
  var bounds = new google.maps.LatLngBounds();

  // create other variables used later in script
  var locations = [];
  var iteration = 0;
  var info = "";
  var name = "";
  var latitude = "";
  var longitude = "";

  // loop through our ColdFusion array to create a JavaScript location array
  <cfoutput>
  <cfloop array="#arrShelter#" index="local.shelter">
    // use ColdFusion toScript method to convert ColdFusion output to JavaScript

    // populate JavaScript name variable
    var name = "#local.shelter.name#";

    // populate JavaScript latitude variable
    var latitude = #local.shelter.latitude#;

    // populate JavaScript longitude variable
    var longitude = #local.shelter.longitude#;

    // populate JavaScript info variable which will store the content of our info window - appears when marker is clicked
    var info = "<p><strong>#local.shelter.name#</strong><br />#local.shelter.address#<br>#local.shelter.city# #local.shelter.state#, #local.shelter.zip#<br/><a href='#local.shelter.website#' target='_blank'>Website &raquo;</a></p>";

    // add location to locations array
    locations[ iteration ] = [ name, latitude, longitude, info ];

    iteration++;
  </cfloop>
 </cfoutput>

  // loop through locations
  for( var i=0; i<locations.length; i++ )
  {
    // get current location
    var location = locations[ i ];

    // create map position
    var position = new google.maps.LatLng( location[ 1 ], location[ 2 ] );

    // add position to bounds
    bounds.extend( position );

    // create marker
    var marker = new google.maps.Marker({
      animation: google.maps.Animation.DROP
      , icon: "http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png"
      , map: map
      , position: position
      , title: location[ 0 ]
    });

    // create info window and add to marker
    google.maps.event.addListener( marker, "click", (
      function( marker, i ) {
        return function() {
          var infowindow = new google.maps.InfoWindow();
          infowindow.setContent( locations[ i ][ 3 ] );
          infowindow.open( map, marker );
        }
      }
    )( marker, i ) );
  };

  // fit map to bounds
  map.fitBounds( bounds );
  </cfif>
}

// load map after page has finished loading
function loadScript() {
  var script = document.createElement( "script" );
  script.type = "text/javascript";
  script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialise";
  document.body.appendChild( script );
}

window.onload = loadScript;


</script>

<cfoutput>

<div class="col-xs-12">
  <!--- <h4 class="text-center">CRITTERS SHELTERS</h4> --->

  <div class="col-xs-12">
    <a href="/services/critters/animal-shelters/" style="text-decoration:underline; color:blue;" align="center">
      <h3 align="center">View All Shelters</h3></a>
  <div class="col-xs-12 col-sm-6">

    <div class="shelter-search">
      <h4>SEARCH</h4>
      <form name="shelter-search" action="" method="post" id="shelter-search">
        <div class="inline-form">
          <div class="form-group">
            <label class="control-label col-xs-12 col-sm-3 form-label" for="zipcode">
            Zip Code
            </label>
            <input type="text" name="zipcode" id="zipcode" class="form-control form-input col-xs-12 col-sm-9" value="#$.event('zipCode')#" required>

            <label class="control-label col-xs-12 col-sm-3 form-label" for="distance">
              Distance
            </label>
            <select name="distance" id="distance" class="form-control form-input col-xs-12 col-sm-9">
              <option value="5" <cfif $.event('distance') eq 5>selected</cfif>>5 Miles</option>
              <option value="10" <cfif $.event('distance') eq 10>selected</cfif>>10 Miles</option>
              <option value="25" <cfif $.event('distance') eq 25>selected</cfif>>25 Miles</option>
              <option value="50" <cfif $.event('distance') eq 50>selected</cfif>>50 Miles</option>
            </select>
            <p>
              <br/>
              <br/>
              <br/>
              <br/>
              <input type="submit" name="doSearch" id="doShelterSearch" value="Search" class="btn btn-danger">
            </p>
          </div> <!--- end form-group --->

        </div> <!--- end inline-form --->

      </form>
    </div> <!--- end shelter-search --->

<style>
  .shelter-results {
    height: 200px;
    overflow: scroll;
    padding-left: 10px;
    padding-top: 10px;
    margin-top: 25px;

  }

  .results-number{
    font-size: 16px;
    font-weight: bold;
  }

  .form-input {
    margin-bottom: 10px;
  }

  .form-label {
    padding-left: 0px;
  }
</style>
  <hr />
    <div class="shelter-results">
      <cfset sCounter = 0 />
      <cfloop array="#arrShelter#" index="shelterItem">
        <cfset sCounter ++ />
        <div class="col-xs-1">
          <span class="results-number">#sCounter#.</span>
        </div>
        <div class="col-xs-11">
          <p>
            <span class="shelter-title"><strong>#shelterItem.name#</strong><br />
            #shelterItem.address#<br />
            #shelterItem.city#, #shelterItem.state# #shelterItem.zip#<br />
            <a href="#shelterItem.website#" target="blank">WEBSITE</a>
          </p>
        </div>
      </cfloop>

    </div>

  </div>

  <div class="col-xs-12 col-sm-6">
    <div class="shelters-map">
      <div id="map-canvas"></div>
    </div>
  </div>
</div>

</cfoutput>
