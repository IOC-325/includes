<cfparam name="attributes.ShowHeader" default="Yes">
<!DOCTYPE html>
<html lang="en">
  <head>
  	<cf_formURL2Attributes>
<cfstoredproc datasource="#application.SQLSource#" procedure="Get_WH_LandingPageContactInfo" result="Landing_Page_Header">
  <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Code" value="#Unit_A_Code#">
  <cfprocresult name="Unit_A">
</cfstoredproc>
<cftry>
<cfstoredproc datasource="#application.SQLSource#" procedure="Get_WH_LandingPageContactInfo" result="Landing_Page_Header">
  <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Code" value="#Unit_B_Code#">
  <cfprocresult name="Unit_B">
</cfstoredproc>
<cfcatch type="any">
	<script>alert('An error has occurred. Please return to the Local Government landing Page and try another search.');</script>
</cfcatch>
</cftry>
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
    <link href="/assets/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
		background-color:#0088CC;
      }
      .sidebar-nav {
        padding: 9px 0;
      }

      @media (max-width: 980px) {
        /* Enable use of floated navbar text */
        .navbar-text.pull-right {
          float: none;
          padding-left: 5px;
          padding-right: 5px;
        }
      }

      .form-signin {
        /*max-width: 600px;*/
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

    </style>
    <link href="/assets/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="/ico/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="/ico/favicon.png">
  </head>

  <body>
<cfif attributes.Showheader eq "Yes">
    <div class="navbar <!---navbar-inverse---> navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
         <!--- For Fix 67 <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>--->
          <a class="brand" href="/" target="_parent">The Warehouse</a>
          <div<!--- class="nav-collapse collapse" fix for 67--->>
            <ul class="nav">
              <li><a href="/" target="_parent">Home</a></li>
              <cfoutput>
         	
                <li><a href="LandingPage.cfm?Code=#Unit_A_code#" target="_parent">Back to Landing Page for #unit_a.unitName#</a></li>

            	<!--- Partial search results will not have a landing page, so this has to be commented out unless we find a way to update it  --->
                <!--- <li>
                	<a href="LandingPage.cfm?Code=#Unit_B_code#" target="_parent">View Landing Page for #Unit_B_Code#</a>
                </li> --->

            </cfoutput>
              <li><a href="http://www.ioc.state.il.us/ioc-pdf/LocalGovt/AFR2013/2013ChartOfAccounts.pdf" target="_New">About the Data</a></li>
              
              <li><a href="Contact.cfm" target="_parent">Contact</a></li>
             <li><!-- AddThis Button BEGIN -->
<div align="center" class="addthis_toolbox addthis_default_style " style="margin-top:10px; text-align:center; margin-left:50px;">
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
</li>
            </ul>
             <ul class="nav" style="float:right;"><li style="color:#FFF; font-family:Georgia, 'Times New Roman', Times, serif;"><a style="color:white;">Susana A. Mendoza, Illinois Comptroller</a></li></ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
    </cfif>
    

	<!---    <title>Compare Header</title>

    <!-- Bootstrap core CSS -->
    <link href="/assets/css/bootstrap.css" rel="stylesheet">
    <!---<link href="BootstrapStarter_files/bootstrap.css" rel="stylesheet">--->

    <!-- Custom styles for this template -->
    <!---<link href="BootstrapStarter_files/starter-template.css" rel="stylesheet">--->
        <link href="/assets/css/bootstrap-responsive.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="../../assets/js/html5shiv.js"></script>
      <script src="../../assets/js/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>--->

<!-----------------------------------------------------------------------
        <div class="navbar <!---navbar-inverse---> navbar-fixed-top">
<!---      <div class="container">--->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="index.cfm" target="_parent">The Warehouse</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li>
			
			<cfstoredproc datasource="#application.SQLSource#" procedure="Get_WH_LandingPageContactInfo" result="Landing_Page_Header">
              <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="Code" value="#Unit_A_Code#">
              <cfprocresult name="Unit_A">
            </cfstoredproc>
            
            <cfstoredproc datasource="#application.SQLSource#" procedure="Get_WH_LandingPageContactInfo" result="Landing_Page_Header">
              <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="Code" value="#Unit_B_Code#">
              <cfprocresult name="Unit_B">
            </cfstoredproc>
            
			<cfoutput>
            <a href="LandingPage.cfm?Code=#Unit_A_code#" target="_parent">Back to Landing Page for #unit_a.unitName#</a></li>
            <!---<cfif Unit_A_code neq Unit_B_Code>--->
            	<li><a href="LandingPage.cfm?Code=#Unit_B_code#" target="_parent">View Landing Page for Peoria</a></li>
            <!---</cfif>--->
            </cfoutput>
<!---            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>--->
          </ul>
        </div><!--/.nav-collapse -->
<!---      </div>--->
    </div>

<!---
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="BootstrapStarter_files/jquery.js"></script>
    <script src="BootstrapStarter_files/bootstrap.js"></script>
  

</body></html>--->

---->
