<!--- Added Error Trap for % --->
<cfif not isdefined("URL.code")><cflocation url="FilteredSearching.cfm?SearchType=ErrorMsg"></cfif>

<!--- Added Error Trap if no record found --->
<cfif URL.code eq ""><cflocation url="FilteredSearching.cfm?SearchType=ErrorMsg"></cfif>

<!--- Added Error Trap for Special Characters --->
<cfif refind("((([^=]+=[^&]*)&?)+)",URL.code)><cflocation url="FilteredSearching.cfm?SearchType=ErrorMsg"></cfif>

<cfstoredproc datasource="#application.LocGovWarehouse#" procedure="Get_WH_LandingPageContactInfo" result="Landing_Page_Header">
      <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Code" value="#URL.code#">
      <cfprocresult name="LandingPageContactInfo">
</cfstoredproc>
<cfparam name="landingpagecontactinfo.unitname" default="">
    <cfoutput>
        <link rel="stylesheet" type="text/css" href="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/assets/jquery-ui-1.10.3.custom.css">
    </cfoutput>

<!--- Added Error Trap if no record found --->
 <cfif LandingPageContactInfo.recordcount eq 0 and IsDefined("attributes.code") and attributes.code eq "">    <cflocation url="FilteredSearching.cfm?SearchType=ErrorMsg">
 </cfif>

<!--- Initialize() calls the Google Map --->
<body onload="initialize();">

       <cfif not LandingPageContactInfo.RecordCount>

           <!--- where are we ending up, the "LandingPage" or a "Compare" Page?--->
           <cfparam name="attributes.DestinationPage" default="LandingPage">
           <!---<cfdump var="#attributes#"/><cfabort>--->
           <!--- <cftry> --->
           <CFLocation url="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=DrillDown&Showheader=Yes&DestinationPage=#attributes.DestinationPage#&Code=#URL.originalSearchString#&SearchType=#URL.SearchType#&originalSearchString=#URL.originalSearchString#">
            <!--- <cfcatch type="any">
                <script>alert('An error has occurred with your search. Please try again.');
                    window.location(history.back());
                </script>
            </cfcatch>
            </cftry> --->
       <cfelse>
               
      <h1 class="pageTitle">
        <span><cfoutput query="LandingPageContactInfo"><cfif description neq "County">#UnitName# - A #Description# in #County# County<cfelse> #County# - a County in Illinois</cfif></cfoutput></span></h1>
      	
        <!---
        <h4><font color="red">The TIF Reports and Annual Audits Reports will be unavailable on Tuesday, January 21st from 3:00 pm to 5:00 pm.</font></h4>
		--->
        
		<cfif isdefined("BadSearch")><div class="alert alert-danger">Sorry, no data available. Please try another search!</div></cfif>
    <div class="row">
        	<div class="col-xs-12 col-sm-6">
            	
               <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
                    method = "FilingAmendment" 
                    Code = "#URL.code#" 
                    returnVariable = "FilingAmendment">
                    
             	<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
                    method = "IsDissolved" 
                    Code = "#URL.code#" 
                    returnVariable = "IsDissolved">
                
                <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
                    method = "GeneralUnitInfo" 
                    Code = "#URL.code#" 
                    returnVariable = "GeneralUnitInfo">
				<cfoutput>

                <cfif IsDissolved.IsDissolved eq "True">
                
					<cfif URL.code eq "016/000/00">
                        <div class="alert alert-danger">Sorry, there is no current documentation required for Cook County.  No data is available.</div>
                    <cfelse>
                        <div class="alert alert-danger">Sorry, but #landingpagecontactinfo.unitName# #landingpagecontactinfo.description# was dissolved<cfif trim(isdissolved.DissolvedDate) is not ""> on #DateFormat(isdissolved.DissolvedDate,"mm/dd/yyyy")#</cfif>. Please call the Toll Free Hotline number at (877) 304-3899 for questions regarding available data for the past three fiscal years.</div>
                    </cfif>
                    <!--- Use this with Phase 3 when tabs become available for years prior to Dissolved Dates --->
					<!---
					<cfelseif FilingAmendment gt 0 and IsDissolved.IsDissolved eq "True">
                        <p style="color:red; font-weight:bold;">Sorry, but #landingpagecontactinfo.unitName# #landingpagecontactinfo.description# was dissolved<cfif trim(isdissolved.DissolvedDate) is not ""> on #DateFormat(isdissolved.DissolvedDate,"mm/dd/yyyy")#</cfif> and has not supplied its required documentation for the last three fiscal years and/or is currently filing an amendment on their reports. No data is available.</p>
                    <cfelse>
                       <p style="color:red; font-weight:bold;">Sorry, but #landingpagecontactinfo.unitName# #landingpagecontactinfo.description# was dissolved<cfif trim(isdissolved.DissolvedDate) is not ""> on #DateFormat(isdissolved.DissolvedDate,"mm/dd/yyyy")#</cfif>. No data is available.</p>
                    </cfif>
					--->
                <cfelseif generalunitinfo.fy eq "">
                	<cfif URL.code eq "016/000/00">
                        <div class="alert alert-danger">Sorry, there is no current documentation required for Cook County.  No data is available.</div>
                    <cfelseif FilingAmendment gt 0>
                        <div class="alert alert-danger">Sorry, but #landingpagecontactinfo.unitName# #landingpagecontactinfo.description# has not supplied its required documentation for the last three fiscal years and/or is currently filing an amendment on their reports. No data is available.</div>
                    <cfelse>
                        <div class="alert alert-danger">Sorry, but #landingpagecontactinfo.unitName# #landingpagecontactinfo.description# has not supplied its required documentation for the last three fiscal years. No data is available.</div>
                    </cfif>
                
                <cfelse>
                
                <table class="table table-striped table-hover table-condensed">
                <thead>
                	<tr>
                    	<th colspan="2">#landingpagecontactinfo.unitname# At a Glance</th>
                    </tr>
                </thead>
                <tbody>
                	<tr>
                    	<td>For Fiscal Year</td><td>#GeneralUnitInfo.FY#</td>
                    </tr>
                    <tr>
                    	<td>Chief Executive Officer</td><td>#GeneralUnitInfo.CEO#</td>
                    </tr>
                    <tr>
                    	<td>Chief Financial Officer</td><td>#GeneralUnitInfo.CFO#</td>
                    </tr>
                    <cfif GeneralUnitInfo.POP neq 0>
                    <tr>
                    	<td>Population</td><td>#NumberFormat(GeneralUnitInfo.POP)#</td>
                    </tr>
                    </cfif>
                    <cfif GeneralUnitInfo.EAV neq 0>
                    <tr>
                    	<td>Equalized Assessed Valuation</td><td>#NumberFormat(GeneralUnitInfo.EAV)#</td>
                    </tr>
                    </cfif>
                    <cfif ((GeneralUnitInfo.C1 is "SP") or (GeneralUnitInfo.C1 is "MU") or (GeneralUnitInfo.C1 is "TW") or (GeneralUnitInfo.C1 is "CO"))>
					<cfif GeneralUnitInfo.TOTEMP neq 0>
                    <tr>
                    	<td>Total Employees</td><td>#GeneralUnitInfo.TOTEMP#</td>
                    </tr>
                    </cfif>
                    <cfif GeneralUnitInfo.TOTEXP neq 0>
					<tr>
                    	<td>Total Expenditures</td><td>$#Numberformat(GeneralUnitInfo.TOTEXP)#</td>
                    </tr>
                    </cfif>
                    <cfif GeneralUnitInfo.TotRev neq 0>
					<tr>
                    	<td>Total Revenues</td><td>$#Numberformat(GeneralUnitInfo.TotRev)#</td>
                    </tr>
                    </cfif>
                    <cfif GeneralUnitInfo.TotalIndebtedness neq 0>
                    <tr>
                    	<td>Total Indebtedness</td><td>$#Numberformat(GeneralUnitInfo.TotalIndebtedness)#</td>
                    </tr>
                    </cfif>
                    <cfif GeneralUnitInfo.FY ge '2013'>
                    <tr>
                    	<td>Pension/Retirement Benefits</td><td>#GeneralUnitInfo.Pension#</td>
                     </tr>
                    </cfif>
                </cfif>
                    
                </tbody>
                </table>
                
                <!---
                <p>For Fiscal Year #GeneralUnitInfo.FY#</p>
                <p>Chief Executive Officer : #GeneralUnitInfo.CEO#</p>
                <p>Chief Financial Officer : #GeneralUnitInfo.CFO#</p>
                <cfif GeneralUnitInfo.POP neq 0>
                <p>Population : #NumberFormat(GeneralUnitInfo.POP)#</p>
                </cfif>
                <cfif GeneralUnitInfo.EAV neq 0>
                <p>Equalized Assessed Valuation: $#Numberformat(GeneralUnitInfo.EAV)#
                </p>
                </cfif>
                <cfif ((GeneralUnitInfo.C1 is "SP") or (GeneralUnitInfo.C1 is "MU") or (GeneralUnitInfo.C1 is "TW") or (GeneralUnitInfo.C1 is "CO"))>
					<cfif GeneralUnitInfo.TOTEMP neq 0>
                    <p>Total Employees :  #GeneralUnitInfo.TOTEMP#</p>
                    </cfif>
                    <cfif GeneralUnitInfo.TOTEXP neq 0>
					<p>Total Expenditures : $#Numberformat(GeneralUnitInfo.TOTEXP)#</p>
                    </cfif>
                    <cfif GeneralUnitInfo.TotRev neq 0>
					<P>Total Revenues : $#Numberformat(GeneralUnitInfo.TotRev)#</P>
                    </cfif>
                    <cfif GeneralUnitInfo.TotalIndebtedness neq 0>
                    <p>Total Indebtedness : $#Numberformat(GeneralUnitInfo.TotalIndebtedness)#</p>
                    </cfif>
                    <cfif GeneralUnitInfo.FY ge '2013'>
                    <p>Pension/Retirement Benefits : #GeneralUnitInfo.Pension#</p>
                    </cfif>
                </cfif>--->
				</cfif>
				</cfoutput>

                			
                
<!--- if FormSubmitted = RegOnly , don't show TIFs or Audits --->
<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
        method = "FormSubmitted" 
        Code = "#URL.Code#" 
        CFY = "#application.LocGovWarehouseCFY#" 
        returnVariable = "FormSubmitted">
        
		
		<!--- if C1 <> MU, don't show TIFs received from UnitData --->
            </div>
            <div class="col-xs-12 col-sm-6">
                <div id="map_canvas"></div>
            </div>
        </div>

<div class="margintop30">
<cfif generalunitinfo.fy neq "" and isDissolved.IsDissolved is not "True">
<h2>Finances <small>At Your Fingertips</small></h2><!---<cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">--->
    <!---<h3>Ready for some data? Choose from the following:</h3>--->

    <div class="gray-div mytabs">
      <ul id="myTab" class="nav nav-tabs">
        <li class="active">
        	<a href="#Home" data-toggle="tab"><cfoutput>View <cfif LandingPageContactInfo.description eq "County">#LandingPageContactInfo.County#<cfelse>#LandingPageContactInfo.UnitName#</cfif></cfoutput>'s AFR</a></li>
        <li>
          <a href="#Compare" data-toggle="tab"><cfoutput>Compare <cfif LandingPageContactInfo.description eq "County">#LandingPageContactInfo.County#<cfelse>#LandingPageContactInfo.UnitName#</cfif>'s</cfoutput> Data</a></li>
          
         <!--- <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown" style="font-size:20px;">Annual Financial Reports <b class="caret"></b></a>
          <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
            <li><a href="#dropdown1" tabindex="-1" data-toggle="tab" style="font-size:20px;">View <cfoutput>#LandingPageContactInfo.UnitName#</cfoutput> Only</a></li>
            <li><a href="#dropdown2" tabindex="-1" data-toggle="tab" style="font-size:20px;">Compare <cfoutput>#LandingPageContactInfo.UnitName#</cfoutput> to...</a></li>
          </ul>
        </li>--->
        <cfif GeneralUnitInfo.ShowTIF is "Y">
        <li><a href="#TIFReports" data-toggle="tab">TIF Reports</a></li>
        </cfif>
        <cfif GeneralUnitInfo.ShowAudits is "Y">
        <li><a href="#AnnualAudits" data-toggle="tab">Annual Audits</a></li>
        </cfif>  
        <cfif GeneralUnitInfo.ShowDelinquency is "Y">
        <li><a href="#Delinquent" data-toggle="tab">Delinquent Reports</a></li>
        </cfif>      
      </ul>
      <div id="myTabContent" class="tab-content">
         <div class="tab-pane fade in active" id="Home">
         	<h3>View Annual Financial Report</h3>
          <form class="form-horizontal margintop" action="/financial-data/local-government-division/local-government-data/processsearchresults/" method="post" name="View_AFR" id="View_AFR">
            <input type="hidden" name="DisplayMode" value="GetAFR">
          	<cfoutput><input type="hidden" name="Code" value="#URL.code#"></cfoutput>
         
         <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_UnitScreensLastThreeFiscalYears">
        	<cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#right(URL.Code,10)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#application.LocGovWarehouseCFY#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@PageTYpe" VALUE="AFR">
            <cfprocresult NAME="GetUnitScreens1">
        </cfstoredproc>          
          
          <!---<cfdump var="#right(attributes.code,10)#">
          
          <cfdump var="#getunitscreens1#">--->
        <div class="row">
        <div class="col-sm-offset-2 col-sm-8">
            <div class="form-group">
            <label class="col-sm-5 control-label">Select Fiscal Year</label>
            <cfset Attributes.Query="GetUnitScreens1">
            <cfset Attributes.NAME1="CFY">
            <cfset Attributes.NAME2="AFRDesiredData">
            <cfset Attributes.DISPLAY1="FY">
            <cfset Attributes.DISPLAY2="AFRDropDown">
            <cfset Attributes.VALUE1="FY">
            <cfset Attributes.VALUE2="PAGENAME">
            <cfset Attributes.SIZE1="1">
            <cfset Attributes.SIZE2="1">
            <cfset Attributes.AUTOSELECTFIRST="No">
            <cfset Attributes.FORMNAME="View_AFR">
            <cfset Attributes.HTMLBETWEEN="Select Desired Data">

            <cfinclude template="TwoSelectsRelated.cfm">

          <!--- <CF_TwoSelectsRelated
            QUERY="GetUnitScreens1"
            NAME1="CFY"
            NAME2="AFRDesiredData"
            DISPLAY1="FY"
            DISPLAY2="AFRDropDown"
            VALUE1="FY"
            VALUE2="PAGENAME"
            SIZE1="1"
            SIZE2="1"
            AUTOSELECTFIRST="No"
            FORMNAME="View_AFR"
            HTMLBETWEEN="<br /> Select Desired Data &nbsp;">  --->
            
            </div>
            </div>
           <div class="form-group text-center">
               <button class="btn btn-primary" type="submit">Show Me the Data</button>
           </div>
          </form>
			
			<!---<h3>Ready for some data? Choose from the following:</h3>
            <p>From the tabs, you can <a href="#dropdown1" tabindex="-1" data-toggle="tab">view Annual Financial Reports</a>, <a href="#dropdown2" tabindex="-1" data-toggle="tab">compare Annual Financial Reports</a>, <a href="#TIFReports" data-toggle="tab">view TIF Reports</a>, and <a href="#AnnualAudits" data-toggle="tab">view Annual Audits</a>. Each tab has a distinct form that you can submit to view the information.</p>--->
  
         </div>
  
         <!---<div class="tab-pane fade" id="dropdown1">
        	<h3>View Annual Financial Report</h3>
          <form class="Landing-Page-Form" action="ProcessSearchResults.cfm" method="post" name="View_AFR" id="View_AFR">
               	<input type="hidden" name="DisplayMode" value="GetAFR">
          	<cfoutput><input type="hidden" name="Code" value="#attributes.code#"></cfoutput>
         
         <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_UnitScreensLastThreeFiscalYears">
        	<cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#right(attributes.Code,10)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#application.LocGovWarehouseCFY#">
            <cfprocresult NAME="GetUnitScreens">
        </cfstoredproc>          
          
          <p>Select Fiscal Year&nbsp; &nbsp; &nbsp; 
          <CF_TwoSelectsRelated
            QUERY="GetUnitScreens"
            NAME1="CFY"
            NAME2="AFRDesiredData"
            DISPLAY1="FY"
            DISPLAY2="PAGENAME"
            VALUE1="FY"
            VALUE2="PAGENAME"
            SIZE1="1"
            SIZE2="1"
            AUTOSELECTFIRST="No"
            FORMNAME="View_AFR"
            HTMLBETWEEN="<br /> Select Desired Data &nbsp;">   
            
            <br /><button class="btn btn-lg btn-primary" style="margin-left:100px;" type="submit">Show Me the Data</button>
        
          </form>

        </div>--->

        <div class="tab-pane fade" id="Compare">
        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_UnitScreensLastThreeFiscalYears">
        	<cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#right(URL.Code,10)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#application.LocGovWarehouseCFY#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@PageTYpe" VALUE="AFRSummary">
            <cfprocresult NAME="GetUnitScreensSum">
        </cfstoredproc> 
        <h3>Compare <cfoutput>#LandingPageContactInfo.UnitName#</cfoutput> To Another Unit</h3>
          
                <form onsubmit="return validateForm();" name="Compare_AFR" id="Compare_AFR" class="form-horizontal margintop"
                action="/financial-data/local-government-division/local-government-data/processsearchresults/" method="post">           
            	
               <!--- <input type="text" name="DisplayMode" value="ComparePrelim">---> <!---value="CompareAFRs"--->
				<cfoutput>
                <!---<input type="hidden" name="DestinationPage" value="ComparePage">--->
                <input type="hidden" name="Code" value="#URL.code#">
                <input type="hidden" name="DisplayMode" value="ComparePrelim"/>
                <input type="hidden" name="ShowHeader" value="No">
				</cfoutput>

                <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-6">

                <div class="form-group">
                <label class="col-sm-5 control-label">Select Fiscal Year</label>
                           <cfset Attributes.Query="GetUnitScreensSum">
                    <cfset Attributes.NAME1="AFRCFY">
                    <cfset Attributes.NAME2="AFRDesiredData">
                    <cfset Attributes.DISPLAY1="FY">
                    <cfset Attributes.DISPLAY2="SummaryDropDown">
                    <cfset Attributes.VALUE1="FY">
                    <cfset Attributes.VALUE2="PAGENAME">
                    <cfset Attributes.SIZE1="1">
                    <cfset Attributes.SIZE2="1">
                    <cfset Attributes.AUTOSELECTFIRST="No">
                    <cfset Attributes.FORMNAME="Compare_AFR">
                    <cfset Attributes.HTMLBETWEEN="Select Desired Data">

                          <cfinclude template="TwoSelectsRelated.cfm">
                  <!--- <CF_TwoSelectsRelated
                    QUERY="GetUnitScreensSum"
                    NAME1="AFRCFY"
                    NAME2="AFRDesiredData"
                    DISPLAY1="FY"
                    DISPLAY2="SummaryDropDown"
                    VALUE1="FY"
                    VALUE2="PAGENAME"
                    SIZE1="1"
                    SIZE2="1"
                    AUTOSELECTFIRST="No"
                    FORMNAME="Compare_AFR"
                    HTMLBETWEEN="<br /> Select Desired Data &nbsp;">    --->

                </div>
                <div class="col-xs-12 col-sm-12 col-md-6">
                <p class="search-compare">Search for the government you'd like to compare <cfoutput>#LandingPageContactInfo.UnitName#</cfoutput> to:</p>

				<!--- <cfinclude template="/IncludedSearchByName/EmbeddedCompareSearchForm.cfm"> --->
        <cfinclude template="EmbeddedCompareSearchForm.cfm">
                    <div class="form-group text-center">
                        <button class="btn btn-primary" type="submit">Compare</button>
                    </div>

  <!--- <tr><td colspan="2" style="text-align:center"><button class="btn btn-large btn-primary" style="padding:10px 50px 10px 50px; margin-right:225px;" type="submit">Compare</button> <p><br><br><br><br><br><br></p> </td></tr>--->
    
    </form>
   
          </div>
        
        <!---<cfif FormSubmitted Neq "SP">--->
        <!---<cfif FormSubmitted neq "RegOnly">--->
        <cfif GeneralUnitInfo.ShowTIF is "Y">
        <div class="tab-pane fade" id="TIFReports">
          <h3>TIF Reports</h3>
          <!---
          <cfinclude template="/IncludedSearchByName/EmbeddedTIFSearchForm.cfm">
		  --->
<!---           <cfinclude template="/Data/ViewTIFReports/DisplayTIFRpt.cfm">
          <cfinclude template="/financial-data/local-government-division/local-government-data/display-tif-rpt/"> --->
          <cfinclude template="DisplayTIFRpt.cfm">
        </div>
        </cfif>
       
        <cfif GeneralUnitInfo.ShowAudits is "Y">
        <div class="tab-pane fade" id="AnnualAudits">
           <h3>Annual Audits</h3>
          <!---<cfinclude template="/IncludedSearchByName/EmbeddedAuditSearchForm.cfm">--->
<!---          <cfinclude template="/Data/ViewAudits/DisplayAnnualAudit.cfm">
         <cfinclude template="/financial-data/local-government-division/local-government-data/display-annual-audit/"> --->
         <cfinclude template="DisplayAnnualAudit.cfm">
        </div>
        </cfif>
        
        <!--- Add Delinquency if the unit has any delinquent instruments --->
        <cfif GeneralUnitInfo.ShowDelinquency is "Y">
        <div class="tab-pane fade" id="Delinquent">
           	<h3>Delinquent Reports</h3>
          	<!---<cfinclude template="/IncludedSearchByName/EmbeddedAuditSearchForm.cfm">--->
         	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Delinquent/DisplayDelinquency.cfm">
        </div>
        </cfif>
<!---</cfif>--->
      </div>
</cfif>
    </div><!-- /example -->
         
</cfif>
    <cfoutput>
    <script type="text/javascript" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/assets/bootstrap-tabcollapse.js"></script></cfoutput>

  <script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=false&callback=initialise&key=AIzaSyBfMyjk4Poa-6v5xdSQhAHMKluvzIgFNTw"></script>

	  <script type="text/javascript">
        function initialize() {
            var address = <CFOUTPUT>"#LandingPageContactInfo.Address#, #LandingPageContactInfo.CITY#, IL"</CFOUTPUT>;
            geocoder = new google.maps.Geocoder();
        
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
 <!--- 
        $('#myTab').tabCollapse({
            tabsClass: 'hidden-sm hidden-xs',
            accordionClass: 'visible-sm visible-xs'
        });--->
      </script>
        
        <!--- Analytics
================================================== 
--->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-45854861-1', 'auto');
  ga('send', 'pageview');



</script>

</body>
