<!DOCTYPE html>
<html lang="en"><head>
<!---<script src="/assets/js/jquery-1.9.1.min.js"></script>--->
<!---<script src="http://code.jquery.com/jquery-1.5.2.min.js"></script>--->


<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<!--- This tag ensures proper rendering and touch-zooming --->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="The Warehouse - Illinois State Comptroller">
<meta name="author" content="Andy Peterson, Gary Ashbaugh">

<title>
The Warehouse - Illinois State Comptroller
</title>
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
background-color: #232C5E;  
background: url("assets/img/warehouse_background_blue_linear.png") repeat-x scroll left top #92A5DE;
/*background: url("assets/img/warehouse_background_blue_linear_cancer.png") left top no-repeat #92A5DE;*/
}

.bs-docs-section {
  /*background-color:white;*/
  <!---background-color:#B1C0C7;--->
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

        <form action="" id="localGovWarehouse" method="post" name="localGovWarehouse">
        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
                <div class="btn-label">Report Name</div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
                <select id="ReportNo" class="select2" name="ReportNo" onchange="SetReport();">
                    <option value="" selected>Report Name</option>
                    <option value="AFRSearch"> Annual Financial Reports</option>
                    <option value="AuditSearch"> Annual Audits</option>
                    <option value="TIFSearch"> Tax Increment Financial Reports</option>
                </select>
            </div>

             <div class="col-xs-12 col-sm-2 text-center">
                <input class="btn btn-success nomargin" id="btnSearch" name="submit" type="submit" value="Search" />
                <!--- onclick='window.location.href = $("##reportName").val();' --->
              </div>
        </div>

<!-- Docs page layout -->
<header class="navbar-wrapper">
  <div class="container"><!--- id="cf3"--->
    <h1>
      <a href="">
        The WAREHOUSE
        <!---<img src="Home%20-%20Before%20The%20Bell_files/logo.png" class="pull-left" id="logo" alt="">--->
               <!--- <img class="bottom" src="/assets/img/Server_Room.jpg" class="pull-left bottom" id="logo" />--->
                <img src="/assets/img/Warehouse_Background.jpg" class="pull-left top" id="logo" />        
      </a>
    </h1>
    
    <div class="clearfix"></div>
    
  </div>
</header>
      

<div class="container bs-docs-container">
  <div class="row" style="background-color:#E0E0E0;"> <!---style="background: url('assets/img/subtle_background.png') repeat #E8E8E8;">---><!---background-color:#E8E8E8---> <!--- -D9DBD5---> <!---#B2B0BC ---><!---#D3D5C8;#A4B2B8#F7F7F8;--->
   
    <div class="col-xs-12 col-sm-6 col-md-3"<!--- style="max-width:300px;"--->>
      <div class="bs-sidebar hidden-print affix-top" role="complementary">
        <ul class="nav bs-sidenav">
              
        <li class="sidenav-header">Searching by Report Type</li>
            
        <li><a href="FilteredSearching.cfm?SearchType=AFRSearch">Annual Financial Reports</a></li>
        <li><a href="FilteredSearching.cfm?SearchType=AuditSearch">Annual Audits</a></li>
        <li><a href="FilteredSearching.cfm?SearchType=TIFSearch">Tax Increment Financial Reports</a></li>
        <li><a href="https://IllinoisComptroller.Gov/ioc-pdf/LocalGovt/rptDelinquents_PublicViewing.pdf" target="new">Delinquent Reports</a></li>
        <li><a href="CircuitClerk.cfm">Circuit Clerk Funds Report</a></li>
        <!---<li><a href="/assets/files/16-3-14_circuit-clerks-fund-report.pdf">Circuit Clerk Funds Report</a></li>  --->     
        <cfset archivedData = application.cfy - 2002>
        <cfoutput>
        <li><a href="Downloads.cfm">Reports Prior to FY #archivedData#</a></li>
        </cfoutput>
        <li class="nav-divider"></li>
        <li class="sidenav-header">Searching by Unit Type</li>
        <li><a href="FilteredSearching.cfm?SearchType=Counties">Counties</a></li>     
        <li><a href="FilteredSearching.cfm?SearchType=Municipalities">Municipalities</a></li>
        <li><a href="FilteredSearching.cfm?SearchType=Townships">Townships</a></li>
        <li><a href="FilteredSearching.cfm?SearchType=SpecialTaxingDistricts">Special Purpose Districts</a></li>     
        <li><a href="FilteredSearching.cfm?SearchType=AllUnits">All Units</a></li>   
        
       <li class="nav-divider"></li>
        <li><a href="Contact.cfm">Contact</a></li>
        <li><cfoutput><a href="#application.LocGovWarehouse#">Warehouse Home</a></cfoutput></li>  
        <li><a href="http://www.ioc.state.il.us">Comptroller's Home Page</a></li>        
        
        </ul>

      </div>
  </div>
<!--- col-sm-6 col-md-6 --->
<div class="col-sm-9 col-md-9" role="main"<!--- style="background-color:#E0E0E0 <!--- -D9DBD5---> <!---#B2B0BC --->"--->><!---#D3D5C8;#A4B2B8;--->
 
 <!-- Letter
 =================================================== -->

 <div class="bs-docs-section">
  <div class="page-header">
      <h1 id="jbt-letter" style="text-shadow: 1px 1px 1px #ffffff;">Welcome to The Warehouse!</h1>
    </div>
 
<!--- Uncomment this --->

<p>The Warehouse is your portal to local government finances. Each year, the Comptroller's Office collects more than 9,200 financial reports from counties, municipalities, and special taxing districts across the state. We have taken those records and made them all available for taxpayer review at this site, allowing you to scour our Warehouse from wherever you are located.</p>

<p>You can search the Warehouse by report type, unit of government or community name. Once you have selected a local government, you will be taken to a landing page where you can review a snapshot of finances, Annual Financial Reports, and Audits. And by clicking on a "compare data" button, you can see how one unit of government stacks up against another.</p>

<h3 class="sidenav-header" style="text-align:center; padding-top:10px;">Begin Search</h3>
      <cfset attributes.searchType = "allunits">
    <cfinclude template="IncludedSearchByName/FilteredSearchForm.cfm">
 </div>

 <!-- AddThis Button BEGIN -->
<!---<div class="addthis_toolbox addthis_default_style ">
<a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
<a class="addthis_button_tweet"></a>
<a class="addthis_button_pinterest_pinit" pi:pinit:layout="horizontal"></a>
<a class="addthis_counter addthis_pill_style"></a>
</div>
<script type="text/javascript">var addthis_config = {"data_track_addressbar":true};</script>
<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-52434f13732a2f77"></script>
<!-- AddThis Button END -->
--->
  </div>
<!---<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.no-icons.min.css" rel="stylesheet">--->
<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">

<!--- LGM Comment Out 

<div class="col-sm-3 col-md-3" role="complementary">
 <div id="right-column" style="border-radius:5px;">
  <div style="background-color:#1E2F64;border-radius:5px;<!--- #3276B1;--->">
      <!---<h3 style="margin-top:45px; padding-top:10px; text-align:center; color:white;">Begin Search</h3>--->
        <h3 class="sidenav-header" style="text-align:center; padding-top:10px;">Begin Search</h3>
      <cfset attributes.searchType = "allunits">
    <cfinclude template="/IncludedSearchByName/FilteredSearchForm.cfm">
        </div></div>
        <p style="text-align: center; margin-top:30px;"><a href="https://www.facebook.com/Comptroller.Judy.Baar.Topinka" title="Comptroller Judy Baar Topinka's Facebook Page"><i class="icon-facebook-sign icon-3x" style="color:#1E2F64;"></i></a>&nbsp;&nbsp;
<a href="http://twitter.com/#!/CompTopinka/" title="Follow the Comptroller on Twitter"><i class="icon-twitter-sign icon-3x" style="color:#1E2F64;"></i></a><!---&nbsp;&nbsp;<a href=""><i class="icon-google-plus-sign icon-4x " style="color:#1E2F64;"></i></a>--->

</p><cfinclude template="addthis.cfm">
 </div>--->
</div>
</div>
</div>
</div>

</div>

    <!-- Footer
    ================================================== -->
    <footer class="bs-footer" role="contentinfo">
      <div class="container">
       
        
        <div class="bs-social">   

<!---  <ul class="bs-social-buttons">


    <li class="follow-btn">
      <iframe data-twttr-rendered="true" title="Twitter Follow Button" style="width: 232px; height: 20px;" class="twitter-follow-button twitter-follow-button" src="Other_Assets/follow_button.htm" allowtransparency="true" frameborder="0" scrolling="no"></iframe>
    </li><li class="tweet-btn">
      <iframe data-twttr-rendered="true" title="Twitter Tweet Button" style="width: 107px; height: 20px;" class="twitter-share-button twitter-count-horizontal" src="Other_Assets/tweet_button.htm" allowtransparency="true" frameborder="0" scrolling="no"></iframe>
    </li>
    



  </ul>--->
</div>


     <!---   <p>Designed and built with all the love in the world by <a href="http://twitter.com/mdo" target="_blank">@mdo</a> and <a href="http://twitter.com/fat" target="_blank">@fat</a>.</p>
        <p>Code licensed under <a href="http://www.apache.org/licenses/LICENSE-2.0" target="_blank">Apache License v2.0</a>, documentation under <a href="http://creativecommons.org/licenses/by/3.0/">CC BY 3.0</a>.</p>
        <ul class="footer-links">
          <li><a href="http://getbootstrap.com/2.3.2/">Bootstrap 2.3.2 docs</a></li>
          <li class="muted">·</li>
          <li><a href="http://blog.getbootstrap.com/">Blog</a></li>
          <li class="muted">·</li>
          <li><a href="https://github.com/twbs/bootstrap/issues?state=open">Issues</a></li>
          <li class="muted">·</li>
          <li><a href="https://github.com/twbs/bootstrap/releases">Releases</a></li>
        </ul>--->
      </div>
    </footer>

    <!-- JS and analytics only. -->
    <!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<!---This page causes the autosuggest to crash; conflicts with the jquery at the top <script src="Other_Assets/jquery.js">--->

<!---<script src="Other_Assets/bootstrap.js"></script>--->

<!---<script src="/assets/js/bootstrap-scrollspy.js"></script>--->
<!---<script src="Other_Assets/widgets.js"></script>
<script src="Other_Assets/holder.js"></script>
<script src="Other_Assets/application.js"></script>--->


<!--- Analytics
================================================== --->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-45854861-1', 'auto');
  ga('send', 'pageview');

</script>
</body></html>