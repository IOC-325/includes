<!DOCTYPE html>
<html lang="en">
  <head>
  	<cf_formURL2Attributes>
    <meta charset="utf-8">
    <title>Searching</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Search Local Governments">
    <meta name="author" content="Comptroller">
  	<!--- Placed at the top; I don't know if I can place this at the bottom. 
    Used for AutoSuggest --->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js" language="javascript"></script>
    <script src="http://code.jquery.com/jquery-1.5.2.min.js"></script>
    <!-- Le styles -->
<!-- Bootstrap core CSS -->
<link href="/Other_Assets/bootstrap.css" rel="stylesheet">
<link href="/Other_Assets/signin.css" rel="stylesheet">
<!-- Documentation extras -->
<link href="/Other_Assets/docs.css" rel="stylesheet">
<link href="/Other_Assets/pygments-manni.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="../assets/js/html5shiv.js"></script>
  <script src="../assets/js/respond.min.js"></script>
<![endif]-->

<!-- Favicons -->
<link rel="shortcut icon" href="/assets/ico/favicon.ico">

<!-- Place anything custom after this. -->
<style>

.sidenav-header {
  display: block;
  padding: 3px 15px;
  font-size: 15px;
  font-weight: bold;
  line-height: 30px;
	color:white;
 /* asp mods color: #999999;
  text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
  */
  text-transform: uppercase;
}


#homepage {
background: url("assets/img/warehouse_background_blue_linear.png") repeat-x scroll left top #92A5DE;
/*background: url("assets/img/warehouse_background_blue_linear_cancer.png") left top no-repeat #92A5DE;*/
}

.bs-docs-section {
	background-color:white;
	padding:0px 10px 0px 10px;
}

#jbt-letter {
	padding-top:10px;	
	font-size:28px;
	text-align:center;
}
</style>
  </head>

<body id="homepage" class="sysHome" data-spy="scroll" data-target=".subnav" data-offset="50">

<!-- Docs page layout -->
<header class="navbar-wrapper">
	<div class="container"><!--- id="cf3"--->
		<h1>
			<a href="index.cfm">
				The WAREHOUSE
				<!---<img src="Home%20-%20Before%20The%20Bell_files/logo.png" class="pull-left" id="logo" alt="">--->
               <!--- <img class="bottom" src="/assets/img/Server_Room.jpg" class="pull-left bottom" id="logo" />--->
                <img src="/assets/img/Warehouse_Background.jpg" class="pull-left top" id="logo" />
                
                
			</a>
		</h1>
		
		<div class="clearfix"></div>
		
	</div>
</header>

<!---
    <div class="navbar <!---navbar-inverse---> navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="/">The Warehouse</a>
          <div class="nav-collapse collapse">
            <!---<p class="navbar-text pull-right">
              Logged in as <a href="#" class="navbar-link">Username</a>
            </p>--->
            <ul class="nav">
              <!---<li class="active"><a href="/">Home</a></li>--->
              <!---<li><a href="#about">About</a></li>--->
              <li><a href="Contact.cfm">Contact</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>--->
    
    
<cfparam name="SearchType" default="AFRSearch"><!---<<< I am adding this line because I want the active class to be set on the right hyperlink --->
<div class="container bs-docs-container">
  <div class="row" style="background-color:#E0E0E0 <!--- -D9DBD5---> <!---#B2B0BC --->;">
   
    <div class="col-md-3"<!--- style="max-width:300px;"--->>
      <div class="bs-sidebar hidden-print affix-top" role="complementary">
        <ul class="nav bs-sidenav">
              
        <li class="sidenav-header">Searching by Report Type</li>
            
        <li <cfif url.SearchType eq "AFRSearch"> class="disabled"</cfif>><a href="FilteredSearching.cfm?SearchType=AFRSearch">Annual Financial Reports</a></li>
        <li <cfif url.SearchType eq "AuditSearch"> class="disabled"</cfif>><a href="FilteredSearching.cfm?SearchType=AuditSearch">Annual Audits</a></li>
        <li <cfif url.SearchType eq "TIFSearch"> class="disabled"</cfif>><a href="FilteredSearching.cfm?SearchType=TIFSearch">Tax Increment Financial Reports</a></li>
        <li><!---<a href="https://IllinoisComptroller.Gov/ioc-pdf/LocalGovt/rptDelinquents_PublicViewing.pdf" target="new">---><a href="http://10.20.30.177:8027/data/Delinquent/DisplayAllDelinquenciesPDF.cfm" target="New">Delinquent Reports</a></li>
        <li><a href="CircuitClerk.cfm">Circuit Clerk Funds Report</a></li>
        <cfset archivedData = application.LocGovWarehouseCFY - 2002>
        <cfoutput>
        <li <cfif cgi.script_name contains "downloads"> class="disabled"</cfif>><a href="Downloads.cfm">Reports Prior to FY #archivedData#</a></li>
        </cfoutput>
        <!--- <li class="nav-divider"></li>
        <li class="sidenav-header">Searching by Unit Type</li>
        <li <cfif url.SearchType eq "Counties"> class="disabled"</cfif>><a href="FilteredSearching.cfm?SearchType=Counties">Counties</a></li>     
        <li <cfif url.SearchType eq "Municipalities"> class="disabled"</cfif>><a href="FilteredSearching.cfm?SearchType=Municipalities">Municipalities</a></li>
        <li <cfif url.SearchType eq "Townships"> class="disabled"</cfif>><a href="FilteredSearching.cfm?SearchType=Townships">Townships</a></li>
        <li <cfif url.SearchType eq "SpecialTaxingDistricts"> class="disabled"</cfif>><a href="FilteredSearching.cfm?SearchType=SpecialTaxingDistricts">Special Purpose Districts</a></li>     
        <li <cfif url.SearchType eq "AllUnits"> class="disabled"</cfif>><a href="FilteredSearching.cfm?SearchType=AllUnits">All Units</a></li>   
        
        
        <li class="nav-divider"></li>
        <li><a href="Contact.cfm">Contact</a></li>
        <li><cfoutput><a href="#application.LocGovWarehouse#">Warehouse Home</a></cfoutput></li>  
        <li><a href="http://www.ioc.state.il.us">Comptroller's Home Page</a></li>        
        <li><a href="http://ledger.illinoiscomptroller.com">The Ledger Home Page</a></li>     --->       
        </ul>
      </div>
	</div>

<div class="col-md-9" role="main">

<cfparam name="attributes.SearchType" default="AllUnits">
          <cfswitch expression="#attributes.SearchType#">
          	
            <cfcase value="ErrorMsg">
    				<div class="hero-unit" style="padding:10px;">
        			<Br /><br /><br /><Br /><Br />
        			Sorry, no data available. Click <cfoutput><a href="#application.LocGovWarehouse#"></cfoutput>here</a> to try another search!
        		</div>
    		</cfcase>
   
<!---             <cfcase value="Municipalities">
            	<h1>Searching Municipalities</h1>
              	<div class="hero-unit">
                    <h3>A municipality is any incorporated city, town, or village. Those who live within a municipality's boundaries may benefit from services the corporation provides and may also be subject to taxes it levies. Illinois law does not mandate services a municipality must provide nor what revenue should be collected. However state statute does govern certain aspects of these services and revenues.</h3>
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
                    <!---<cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">--->
              	</div>
          	</cfcase>
            <cfcase value="Counties">
            	<h1>Searching Counties</h1>
              	<div class="hero-unit">
                <h3>Governed by commissioners representing districts, counties provide services pertaining to law enforcement, education administration, a judicial system, tax collection and revenue distribution, public health, road and bridge maintenance, retention of vital records, and tax assessment. Revenues are raised primarily through property tax levies.</h3>
                   
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
              	</div>
          	</cfcase>            
            <cfcase value="CommunityColleges">
            	<h1>Searching Community Colleges</h1>
              	<div class="hero-unit">
                    <h3>Type some text below.</h3>
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
              	</div>
          	</cfcase>      
            <cfcase value="SchoolDistricts">
            	<h1>Searching School Districts</h1>
              	<div class="hero-unit">
                    <h3>Type some text below.</h3>
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
              	</div>
          	</cfcase>    
           	<cfcase value="SpecialTaxingDistricts">
            	<h1>Searching Special Purpose Districts</h1>
              	<div class="hero-unit">
                    <h3>There is not a specific definition of a special purpose district, but generally these are types of governments that are incorporated through referendum to provide a specific service, such as fire protection, park district, mosquito abatement, water service, manage an airport, maintain public parks, or spur economic development. </h3>
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
              	</div>
          	</cfcase>  
           	<cfcase value="Townships">
            	<h1>Searching Townships</h1>
              	<div class="hero-unit">
                    
                    <h3>Voters may petition for the incorporation of a unit of government that may overlap other municipalities and districts within a county. This unit of government is known as a township, which provides general assistance programs, property assessment, and road and bridge upkeep.</h3>
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
              	</div>
          	</cfcase>     
           	<cfcase value="AllUnits">
            	<h1>Searching All Units</h1>
              	<div class="hero-unit">
                    <h3>Begin your search by typing text into the search box below.</h3>
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
              	</div>
          	</cfcase>                
           	<cfcase value="Other">
            	<h1>Searching for All Other Local Governments</h1>
              	<div class="hero-unit">
                    <h3>Begin your search by typing text into the search box below.</h3>
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
              	</div>
          	</cfcase>      --->  
           	<cfcase value="AFRSearch">
            	<h1>Searching for Annual Financial Reports</h1>
              	<div class="hero-unit">
                    <h3>The Illinois Fiscal Responsibility Report Card Act requires all local governments to submit a report card, called the Annual Financial Reports (AFR) to the Office of the Comptroller annually.  AFRs are self-reported financial records, summarizing the revenues, expenditures, fund balance and debt of units of local government throughout the state.  </h3>
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
              	</div>
          	</cfcase> 
           	<cfcase value="TIFSearch">
            	<h1>Searching for Tax Increment Financial Reports</h1>
              	<div class="hero-unit">
                    <h3>A Tax Increment Financing District (TIF District) is a geographic area, which has its boundaries set by a municipality government, that pays an extra tax for the purpose of investing in redevelopment projects within the same space.  A TIF District administrator must complete a TIF Annual Financial Report to the Office of the Comptroller annually.  </h3>
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
              	</div>
          	</cfcase> 
           	<cfcase value="AuditSearch">
            	<h1>Searching for Local Government's Annual Audits</h1>
              	<div class="hero-unit">
                    <h3>A Local Government, in addition to providing the Local Government Division an Annual Financial Report,  may also be required to provide a copy of the Annual Audit for the local government based off factors such as population, revenue and bonded debt.  The Annual Audit shall be made  in  accordance  with  generally accepted  auditing  standards.  Reporting  on the financial position and results of financial operations for each fund of the municipality  shall be  in accordance with generally accepted accounting principles, insofar as  possible.</h3>
                    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
              	</div>
          	</cfcase>                                                                                
          </cfswitch>
                    

 </div>
</div>
</div>
</div>
</div>

</div>

    <!-- Footer
    ================================================== -->
    <footer class="bs-footer" role="contentinfo">
      <div class="container">
       <!--- <div class="bs-social">
  <ul class="bs-social-buttons">



  </ul>
</div>--->
<!-- AddThis Button BEGIN -->
<div align="center" class="addthis_toolbox addthis_default_style " style="margin-top:25px; text-align:center; margin-left:60px;">
<a class="addthis_button_preferred_1"></a>
<a class="addthis_button_preferred_2"></a>
<a class="addthis_button_preferred_3"></a>
<a class="addthis_button_preferred_4"></a>
<a class="addthis_button_compact"></a>
<a class="addthis_counter addthis_bubble_style"></a>
</div>
<script type="text/javascript">var addthis_config = {"data_track_addressbar":true};</script>
<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-52434f13732a2f77"></script>
<!-- AddThis Button END -->



      </div>
    </footer>

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

</body></html>
