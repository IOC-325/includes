<link rel="stylesheet" type="text/css" href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/jquery-ui-1.10.3.custom.css">
<cfscript>
  param name='message' default={};
</cfscript>
<!--- Copy this condition. It is mandatory for the url action to link (start) --->
<cfif isDefined("url.mcaction")>
   <cfinclude template="inc/#LCase(m.event('mcaction'))#.cfm" />
<cfelse>

    <cfif isDefined("form.SEARCHTEXT")>
            <style>
                .results-th{
                    background-color:gray;
                    color: #fff;
                }
            </style>

              <!--- <cfdump var="#form#"> --->

               <cfinvoke component = "model/beans/licensee"
                 method = "getLicensee"
                 returnVariable = "rc">
                 <cfinvokeargument name="searchText" value="#form.SEARCHTEXT#">
               </cfinvoke>

                 <div class="resultsContainer">
                  <h3 class="text-center">Below are the Search Results: </h3>
                  <div class="row">
                   <div class="col-sm-10 col-sm-offset-1">
                    <table class="table table-striped">
                     <thead class="results-th">
                      <tr>
                       <td>Type</td>
                       <td>Licensee Name</td>
                       <td>Business Name</td>
                       <td>Street</td>
                       <td>City</td>
                       <td>Zip Code</td>
                       <td>County</td>
                       <td>Status</td>
                      </tr>
                     </thead>
                     <cfoutput>
                      <cfloop query="#rc#">
                       <tr>
                        <td>#rc.LICENSEE_TYPE_NAME#</td>
                        <td>#rc.LICENSEE_NAME#</td>
                        <td><a href="#$.content().getURL()#?mcaction=details&ID=#rc.LICENSEE_NUMBER#">#rc.BUSINESS_NAME#</a></td>
                        <td><cfif Trim(rc.LICENSEE_ADDRESS) eq ''>N/A</cfif>#rc.LICENSEE_ADDRESS#</td>
                        <td><cfif Trim(rc.LICENSEE_CITY) eq ''>N/A</cfif>#rc.LICENSEE_CITY#</td>
                        <td><cfif Trim(rc.LICENSEE_ZIP) eq ''>N/A</cfif>#rc.LICENSEE_ZIP#</td>
                        <td><cfif Trim(rc.COUNTY) eq ''>N/A</cfif>#rc.COUNTY#</td>
                        <td><cfif Trim(rc.LICENSEE_STATUS) eq ''>N/A</cfif>#rc.LICENSEE_STATUS#</td>
                       </tr>
                      </cfloop>
                     </cfoutput>
                    </table>
                   </div>
                  </div>
                 </div>

    <cfelse>
        <!--- Copy this condition. It is mandatory for the url action to link (end) --->  

        <style>
          .ui-autocomplete {
          max-height:250px;
          overflow-y: auto;
          overflow-x: hidden;
          width:auto;
          }
          /* IE 6 doesn't support max-height
          * we use height instead, but this forces the menu to always be this tall
          http://dev.ioc-dev.ioc.com/plugins/publicPlace/app2/model/services/licenseeSearch.cfc
          */
          * html .ui-autocomplete {
          height: 300px;
          }
        </style>

        <script type="text/javascript">
         $(function() {
          $('[data-toggle="tooltip"]').tooltip();
          $("#searchtext").on('change keyup paste', function() {
              $("#searchtext").attr("class","ui-autocomplete-input form-control");
          });
          $("#btnSearch").click(function(event){
           if($("#searchtext").val().length <3){
            $("#searchtext").parent().attr("class","col-md-10 has-error");
             event.preventDefault();
           }
          });
          $("#searchtext").autocomplete({
           minLength:3,
           <cfoutput>
           source: "/Queries/licensee.cfc?method=getLicenseeAutoSuggest&returnformat=json",
           </cfoutput>
          });

         });

        </script>


        <cfoutput>

         <div id="payment" class="contract">
            <div class="main2">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <form enctype="application/x-www-form-urlencoded" id="searchform" name="submitAReport" action="#$.content().getURL()#?mcaction=results" preloader="no">
                          <h2>Search for funeral homes, cemeteries, and crematories</h2>
                            <div class="row">
                                <div class="col-sm-10 label-div">
                                  <input class="form-control" type="text" id="searchtext" name="searchtext" id="searchtext" value="" placeholder="Search by Business Name, Zip Code or Location by typing min 3 character" >
                                </div>
                                <div class="col-sm-2 text-center">
                                    <input class="btn btn-success nomargin" id="btnSearch" name="submit" type="submit" value="Search" >
                                </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        </div>

        </cfoutput>
    </cfif>
</cfif>  


