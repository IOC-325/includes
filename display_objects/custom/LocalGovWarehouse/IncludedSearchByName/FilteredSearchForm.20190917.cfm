<!--- The Filtered Search Form is going to accept various filtered searches. It will call the NameSearch CFC, and the method will be dynamically generated --->
<!---
	Expects : URL.SEARCHTYPE
--->
<script language="JavaScript"><!--

function validateForm() 
{
var x=document.forms["SearchForm"]["govUnit"].value;
if (x==null || x=="" || x=="Enter Government Name")
  {
  alert("Please enter search criteria in order to proceed.");
  return false;
  }
}

function validateForm2() 
{
var x=document.forms["SearchForm"]["category"].value;
if (x==null || x=="" || x=="Enter Government Name")
  {
  alert("Please enter search criteria in order to proceed.");
  return false;
  }
}

//--></script>

<cfparam name="variables.SearchType" default="Municipalities">

<cfif isDefined("form.ReportNo")>
  <cfset variables.SearchType = form.ReportNo>
<cfelseif isDefined("URL.SearchType")>   
  <cfset variables.SearchType = URL.SearchType>    
</cfif>  


<CFSWITCH expression="#variables.SearchType#">
    <cfcase value="AFRSearch">
        <cfset variables.SearchTitle = "Annual Finiancial Reports (AFRs)">
        <!---<cfset variables.CFCMethod = "getSearchAllLocalUnits">--->
        <cfset variables.CFCMethod = "getSearchAllLocalUnitsOptionC">
    </cfcase>
    <cfcase value="TIFSearch">
        <cfset variables.SearchTitle = "Tax Increment Financing (TIF) Reports">
        <!---<cfset variables.CFCMethod = "getMunicipalities"> --->  
        <cfset variables.CFCMethod = "getTIFS">
    </cfcase>
    <cfcase value="AuditSearch">
        <cfset variables.SearchTitle = "Audits">
       <!--- <cfset variables.CFCMethod = "getMunicipalities"> --->
         <cfset variables.CFCMethod = "getAudits">         
    </cfcase>
    <cfcase value="Municipalities">
        <cfset variables.SearchTitle = "Municipalities">
        <cfset variables.CFCMethod = "getMunicipalities">
    </cfcase>
    <cfcase value="Counties">
        <cfset variables.SearchTitle = "Counties">
        <cfset variables.CFCMethod = "getCounties">
    </cfcase>    
    <cfcase value="CommunityColleges">
        <cfset variables.SearchTitle = "Community Colleges">
        <cfset variables.CFCMethod = "getCommunityColleges">
    </cfcase>    
    <cfcase value="SchoolDistricts">
        <cfset variables.SearchTitle = "School Districts">
        <cfset variables.CFCMethod = "getSchoolDistricts">
    </cfcase>  
    <cfcase value="SpecialTaxingDistricts">
        <cfset variables.SearchTitle = "Special Taxing Districts">
        <cfset variables.CFCMethod = "getSpecialTaxingDistricts">
    </cfcase>       
    <cfcase value="Townships">
        <cfset variables.SearchTitle = "Townships">
        <cfset variables.CFCMethod = "getTownships">
    </cfcase>  
    <cfcase value="Other">
        <cfset variables.SearchTitle = "Other Units of Government">
        <cfset variables.CFCMethod = "getOther">
    </cfcase> 
     <cfcase value="AllUnits">
        <cfset variables.SearchTitle = "All Units of Government">
        <cfset variables.CFCMethod = "getSearchAllLocalUnitsOptionC">
    </cfcase> 
    <!---     
    <cfcase value="AllUnits">
        <cfset variables.SearchTitle = "All Units of Government">
        <cfset variables.CFCMethod = "getSearchAllLocalUnits">
    </cfcase> 
    --->
    <!---<cfcase value="AllUnitsOptionA">
        <cfset variables.SearchTitle = "All Units of Government">
        <cfset variables.CFCMethod = "getSearchAllLocalUnitsOptionA">
    </cfcase>  --->   
    <cfcase value="AllUnitsOptionC">
        <cfset variables.SearchTitle = "All Units of Government">
        <cfset variables.CFCMethod = "getSearchAllLocalUnitsOptionC">
    </cfcase>       
    </CFSWITCH>
<!--- If the search is NOT an All Unit or AFR Search, then use the form that automatically drops down the list upon cursor entry --->   

	<!--- use this form if the dropdown is AllUnits or AFRSearch. It waits for three characters to be entered--->
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <cfoutput>
        <link rel="stylesheet" type="text/css" href="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/assets/jquery-ui-1.10.3.custom.css">
    </cfoutput>
     <style>
    .ui-autocomplete {
    max-height:250px;
    overflow-y: auto;
    /* prevent horizontal scrollbar */
    overflow-x: hidden;
    /*max-width:250px;*/
    width:auto;
    }
    /* IE 6 doesn't support max-height
    * we use height instead, but this forces the menu to always be this tall
    */
    * html .ui-autocomplete {
    height: 300px;
    }
    </style>
    <!---
    <cfset variables.cfcMethod = "getSearchAllLocalUnitsOptionC">
    
    <cfif cgi.cf_template_path contains "Index_Option_A">
    	<cfset variables.cfcMethod = "getSearchAllLocalUnitsOptionA">
    <cfelseif cgi.cf_template_path contains "index.cfm">
        	<cfset variables.cfcMethod = "getSearchAllLocalUnitsOptionC">
    <cfelse>
    	<cfset variables.cfcMethod = "getSearchAllLocalUnits">
    </cfif>--->
    <script type="text/javascript">
    $(function() {
        $("#category").autocomplete({
            minLength:3,
            /*delay:500,*/
            
            <cfoutput>
            source: "/Queries/LocalGoveWarehouseSearchService.cfc?method=#variables.CFCMethod#&returnformat=json",
            </cfoutput>
            //response(results.slice(0,10));
            /*var results = result;
            response(results.slice(0,10));*/
            //max:10;
            /*response: results.slice(0.10);*/
        });
    });
    </script>

<cfif IsDefined("URL.SearchType") && URL.SearchType eq "AFRSearch">
    <h1 class="pageTitle"><span>Annual Financial Reports</span></h1>
    <p>The Illinois Fiscal Responsibility Report Card Act requires all local governments to submit a report card, called the Annual Financial Reports (AFR) to the Office of the Comptroller annually. AFRs are self-reported financial records, summarizing the revenues, expenditures, fund balance and debt of units of local government throughout the state.</p>
<cfelseif  IsDefined("URL.SearchType") && URL.SearchType  eq "AuditSearch">
    <h1 class="pageTitle"><span>Annual Audits</span></h1>
    <p>A Local Government, in addition to providing the Local Government Division an Annual Financial Report, may also be required to provide a copy of the Annual Audit for the local government based off factors such as population, revenue and bonded debt. The Annual Audit shall be made in accordance with generally accepted auditing standards. Reporting on the financial position and results of financial operations for each fund of the municipality shall be in accordance with generally accepted accounting principles, insofar as possible.</p>
<cfelseif  IsDefined("URL.SearchType") && URL.SearchType  eq "TIFSearch">
    <h1 class="pageTitle"><span>Tax Increment Financial Reports</span></h1>
    <p>A Tax Increment Financing District (TIF District) is a geographic area, which has its boundaries set by a municipality government, that pays an extra tax for the purpose of investing in redevelopment projects within the same space. A TIF District administrator must complete a TIF Annual Financial Report to the Office of the Comptroller annually.</p>
<cfelse>    
    <h1 class="pageTitle"><span>Search Form</span></h1>
</cfif>
    
    <form class="form-signin margintop30" action="/financial-data/local-government-division/local-government-data/processsearchresults/" method="post" name="SearchForm" id="SearchForm" onsubmit="return validateForm2();" style="<cfif cgi.SCRIPT_NAME neq "/FilteredSearching.cfm"></cfif>">
    
    <input type="hidden" name="displayMode" value="GetLandingPage" />
    <cfoutput>
    <input type="hidden" name="SearchType" value="#variables.SearchType#" />
    
   <!--- <p>#variables.cfcmethod#</p>--->

    </cfoutput>
    <!--- if this template is included in FilteredSearching.cfm, then style it differently than if it is coming from the home page --->
    <cfif cgi.SCRIPT_NAME eq "/FilteredSearching.cfm">
        <p><strong>Instructions:</strong> Type in at least three letters into the search box below to begin your local government search. Then press the Enter key or the Search button.</p>
        <div class="row">
            <div class="col-xs-12 col-sm-4 label-div">
                <div class="btn-label-grey btn-label label-gray">Government Name</div>
            </div>
            <div class="col-xs-12 col-sm-6 label-div">
                <input class="form-control" id="category" placeholder="Enter Government Name" name="GovUnit">
            </div>
            <div class="col-xs-12 col-sm-2 text-center">
                <button class="btn btn-primary nomargin" type="submit">Search</button>
            </div>
        </div>
     <cfelse><!--- this is embedded on the home page --->
    <p><strong>Instructions:</strong> Type in at least three letters into the search box below to begin your local government search. Then press the Enter key or the Go button.</p>
    <div class="row">
        <div class="col-xs-12 col-sm-4 label-div">
            <div class="btn-label-grey btn-label label-gray">Government Name</div>
        </div>
        <div class="col-xs-12 col-sm-6 label-div">
            <input class="form-control" id="category" placeholder="Enter Government Name"  name="GovUnit" >
        </div>
        <div class="col-xs-12 col-sm-2 text-center">
            <button class="btn btn-primary nomargin" type="submit">Go</button>
        </div>
    </div>

    </cfif>
    </form>
<!---</cfif>--->