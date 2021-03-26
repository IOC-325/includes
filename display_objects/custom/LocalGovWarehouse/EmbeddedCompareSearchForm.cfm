<!--- The Filtered Search Form is going to accept various filtered searches. It will call the NameSearch CFC, and the method will be dynamically generated --->
<!---
	Expects : URL.SEARCHTYPE
	--->

<!---<cfinclude template="/formurl2attributes.cfm">--->


<cfparam name="attributes.SearchType" default="Municipalities">

<!---<CFSWITCH expression="#attributes.SearchType#">
	<cfcase value="AFRSearch">
    	<cfset variables.SearchTitle = "Annual Finiancial Reports (AFRs)">
        <cfset variables.CFCMethod = "getMunicipalities">
    </cfcase>
    <cfcase value="TIFSearch">
    	<cfset variables.SearchTitle = "Tax Increment Financing (TIF) Reports">
        <cfset variables.CFCMethod = "getMunicipalities">
    </cfcase>
    <cfcase value="AuditSearch">
    	<cfset variables.SearchTitle = "Audits">
        <cfset variables.CFCMethod = "getMunicipalities">        
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
        <cfset variables.CFCMethod = "getSearchAllLocalUnits">
    </cfcase> 
    </CFSWITCH>--->
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="/test/jquery-ui-1.10.3.custom/css/smoothness/jquery-ui-1.10.3.custom.css">
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

<script type="text/javascript">
$(function() {
    $("#category").autocomplete({
		minLength:3,
        source: "/Queries/LocalGoveWarehouseSearchService.cfc?method=getSearchAllLocalUnitsOptionC&returnformat=json"
    });
});
</script>

<input class="form-control" placeholder="Enter Local Unit Name" id="category" name="GovUnit"<!--- x-webkit-speech---><!--- style="width:75%;" ---><!---style="max-width:250px;"---> />

</div>
</div>

<!--- <cfset variables.CFCMethod = "getSearchAllLocalUnits">
    <cf_asug url="/IncludedSearchByName/namesearch.cfc?method=#variables.CFCMethod#">
    <input type="text" name="govUnit" id="govUnit" placeholder="Enter Government Name" /> 
    </cf_asug>--->


