<!--- [axof: 1020 wl: 30 hours] sr 17057 rk --->
<cfinclude template="searchLogic.cfm"/>
<!--- <cfdump var="#m.globalConfig('datasource')#"> --->
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
            <cfif local.shelter.latitude NEQ "">
                var latitude = #local.shelter.latitude#;
            <cfelse>
                    var latitude = 41.879901;
            </cfif>

                // populate JavaScript longitude variable
            <cfif local.shelter.latitude NEQ "">
                var longitude = #local.shelter.longitude#;
            <cfelse>
                    var longitude = -87.620524;
            </cfif>

                // populate JavaScript info variable which will store the content of our info window - appears when marker is clicked
            var info = "<p><strong>#local.shelter.name#</strong><br />#local.shelter.address#<br>#local.shelter.city# #local.shelter.state#, #local.shelter.zip#<br/><a href='#local.shelter.website#' target='_blank'>Website &raquo;</a></p>";

                // add location to locations array
                locations[iteration] = [name, latitude, longitude, info];

                iteration++;
        </cfloop>
    </cfoutput>

        // loop through locations
        for (var i = 0; i < locations.length; i++) {
            // get current location
            var location = locations[i];

            // create map position
            var position = new google.maps.LatLng(location[1], location[2]);

            // add position to bounds
            bounds.extend(position);

            // create marker
            var marker = new google.maps.Marker({
                animation: google.maps.Animation.DROP
                , icon: "https://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png"
                , map: map
                , position: position
                , title: location[0]
            });

            // create info window and add to marker
            google.maps.event.addListener(marker, "click", (
                    function (marker, i) {
                        return function () {
                            var infowindow = new google.maps.InfoWindow();
                            infowindow.setContent(locations[i][3]);
                            infowindow.open(map, marker);
                        }
                    }
            )(marker, i));
        };

        // fit map to bounds
        map.fitBounds(bounds);
</cfif>
}

// load map after page has finished loading
function loadScript() {
    var script = document.createElement("script");
    script.type = "text/javascript";
//  script.src = "https://maps.googleapis.com/maps/api/js?sensor=false&callback=initialise";
    script.src = "https://maps.google.com/maps/api/js?sensor=false&callback=initialise&key=AIzaSyBfMyjk4Poa-6v5xdSQhAHMKluvzIgFNTw";
    document.body.appendChild(script);
}

window.onload = loadScript;


</script>
<cfoutput>
<!--- <h4 class="text-center">CRITTERS SHELTERS</h4> --->

<!---   <p class="custom-top-padding" align="center"> <a href="/services/critters/animal-shelters/" class="btn btn-success center-block">View All Shelters</a> </p> --->

    <p class="custom-top-padding"><strong>Search for a Comptroller's Critters shelter by zip code, county, or shelter
        name</strong></p>
    <form name="shelter-search" action="" method="post" id="shelter-search">
<!--- <div class="alert alert-info" style="font-size:1.3em;">INSTRUCTIONS: You can search by zip code and/or County and/or shelter name. The distance will apply to the first result in the search.</div> --->
        <cfif arrShelter.len() EQ 0>
            <div class="form-group">
                <div class="alert alert-warning">No record found.</div>
            </div>
        </cfif>
            <div id="errortop" class="alert alert-danger hide">Please search by Zip code / County / Shelter Name. Please
                enter atleast one option.
            </div>

        <div class="form-group row">
            <label for="phone" class="col-xs-12 col-sm-2 control-label">Zip Code</label>
            <div class="col-xs-12 col-sm-2">
                <input type="text" name="zipcode" id="zipcode" class="form-control" placeholder="Zip Code"
                       input value="#$.event('zipCode')#">
            </div>
            <label for="phone" class="col-xs-12 col-sm-2 control-label mt15">County</label>
            <div class="col-xs-12 col-sm-3">
                <select id="county" name="county" class="form-control">
                    <option value="" <cfif $.event('county') eq 0>selected</cfif>>County</option>
                    <cfloop query="countyList">
                            <option value="#countyList.attributeValue#"
                            <cfif countyList.attributeValue eq $.event('county')>selected</cfif>>#countyList.attributeValue#</option>
                    </cfloop>
                </select>
            </div>
            <div class="col-xs-12 col-sm-3 mt10">
                <select name="distance" id="distance" class="form-control">
                <!--- <option value="0">Distance</option> --->
                    <option value="5" <cfif $.event('distance') eq 5>selected</cfif>>Within 5 Miles</option>
                        <option value="10" <cfif $.event('distance') eq 10 OR $.event('distance') eq 0>selected</cfif>>Within 10 Miles</option>
                        <option value="15" <cfif $.event('distance') eq 15>selected</cfif>>Within 15 Miles</option>
                        <option value="25" <cfif $.event('distance') eq 25>selected</cfif>>Within 25 Miles</option>
                        <option value="50" <cfif $.event('distance') eq 50>selected</cfif>>Within 50 Miles</option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-xs-12 col-sm-2 control-label" for="cityName">Shelter Name</label>
            <div class="col-xs-12 col-sm-10">
                <input type="text" name="shelterName" id="shelterName" class="form-control"
                   placeholder="Shelter Name" value="#$.event('shelterName')#">
            </div>
        </div>
        <div class="form-group text-center">
            <input type="submit" name="doSearch" id="doSearch" value="Search" class="btn btn-success">
            <a href="/services/critters/animal-shelters/" class="btn btn-success">View All Shelters</a>
        </div>
        <div class="shelter-search"></div>

    </form>


<hr/>
    <cfif arrShelter.len() NEQ 0>
        <div class="row">
            <div class="col-xs-12 col-sm-6">
                <div class="shelter-results">
                    <cfset sCounter = 0/>
                    <cfloop array="#arrShelter#" index="shelterItem">
                        <cfset sCounter++/>
                        <div class="col-xs-1">
                            <span class="results-number">#sCounter#.</span>
                        </div>
                        <div class="col-xs-11">
                            <p>
                                <a class="shelter-title-link" href="/#shelterItem.Filename#"><span class="shelter-title">
                                <strong>#shelterItem.name#</strong></span></a><br/>
                                #shelterItem.address#<br/>
                                #shelterItem.city#, #shelterItem.state# #shelterItem.zip#<br/>
                                <a class="shelter-title-link" href="#shelterItem.website#" target="blank">#shelterItem.website#</a>
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
    </cfif>

</cfoutput>
<script>
    $(document).ready(function () {
        $('#doSearch').click(function () {
            if ($("#zipcode").val() == "" && $("#county").val() == "" && $("#shelterName").val() == "") {
                $("#errortop").removeClass('hide');
                $("#zipcode").val('');
                $("#county").val('');
                $("#shelterName").val('');
                return false;
            }
            else if ($("#zipcode").val() !== "" || $("#county").val() !== "" || $("#shelterName").val() !== "") {
                $("#errortop").addClass('hide');
                $(this).closest('form').submit();
            }
        });
    });
</script>