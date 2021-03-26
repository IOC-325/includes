<cfset varFinancialData = "">
<cfif FindNoCase("/financial-data/", $.content().getURL()) NEQ 0 > <!--- OR FindNoCase("/appropriation-inquiries/", $.content().getURL()) NEQ 0> --->
  <cfset varFinancialData = " active">
</cfif>  

<cfset varNews = "">
<cfif FindNoCase("/news/", $.content().getURL()) NEQ 0>
  <cfset varNews = " active">
</cfif> 

<cfset varAbout = "">
<cfif FindNoCase("/about/", $.content().getURL()) NEQ 0>
  <cfset varAbout = " active">
</cfif> 

<cfset varVendors = "">
<cfif FindNoCase("/vendors/", $.content().getURL()) NEQ 0>
  <cfset varVendors = " active">
</cfif> 

<cfset varAgencies = "">
<!--- <cfif FindNoCase("/vendors/", $.content().getURL()) EQ 0 >
  <cfset varAgencies = " active"> 
<cfelseif FindNoCase("/agencies/", $.content().getURL()) NEQ 0>
  <cfset varAgencies = " active"> --->
<cfif FindNoCase("/agencies/", $.content().getURL()) NEQ 0 > 
  <!--- AND FindNoCase("/appropriation-inquiries/", $.content().getURL()) EQ 0> --->
  <cfset varAgencies = " active">  
</cfif> 


<cfoutput>
  <header class="navbar-wrapper" style="margin-bottom:40px;">
   <div class="container">
      <nav class="navbar">        
        <!--/.navbar-header-->
        <div class="navbar-header">
          <button type="button" data-toggle="collapse" data-target="##bs-example-navbar-collapse-1" class="navbar-toggle">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href="/" class="navbar-brand logo">
            <img class="img-responsive" src="/RDA/assets/images/logos/web/website-logo_sized.png" title="Susana A. Mendoza - Illinois State Comptroller"
                               alt="Susana A. Mendoza - Illinois State Comptroller"> 
            <!--- comptroller-logo.png website-branding_002.png --->
          </a>
        </div>              


        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                  <ul class="nav navbar-nav">
                    <li class="dropdown#varFinancialData#">
                        <a href="/financial-data/">FINANCIAL DATA</a>
                        <ul class="dropdown-menu multi-column columns-3">
                          <div class="row">
                            <div class="col-sm-5">
                              <ul class="multi-column-dropdown">
                                <li><a href="/financial-data/backlog-voucher-report-bvr/">Backlog Voucher Report</a></li>
                                <li><a href="/financial-data/debt-transparency-reports-dtr/">Debt Transparency Report</a></li>
                                <li class="dropdown">
                                  <a href="/financial-data/find-a-report">Find A Report</a>
                                  <!--- <ul class="dropdown-menu" style="margin-top: -10px; margin-left: 50px; width: 250px;">
                                      <li><a href="/financial-data/find-a-report/local-government-finances">Local Government Finances</a></li>
                                      <li><a href="/financial-data/find-a-report/debt-transparency">Debt Transparency</a></li>
                                      <li><a href="/financial-data/find-a-report/public-accountability-fund">Public Accountability Fund</a></li>
                                      <li><a href="/financial-data/find-a-report/fee-imposition-final">Fee Imposition Final</a></li>
                                      <li><a href="/financial-data/find-a-report/tax-expenditure">Tax Expenditure</a></li>
                                  </ul> --->
                                </li>
                                <li class="dropdown-submenu">
                                  <a href="/financial-data/fiscal-focus" class="dropdown-toggle">Fiscal Information</a>
                                  <div class="dropdown-menu multi-column leftflow-sub columns-2">
                                    <div class="row">
                                      <div class="col-sm-6">
                                        <ul class="multi-column-dropdown">
                                          <li><a href="/financial-data/fiscal-focus-blog/bill-backlog/">Bill Backlog</a></li>
                                          <li><a href="/financial-data/fiscal-focus-blog/general-funds/">General Funds</a></li>
                                          <li><a href="/financial-data/fiscal-focus-blog/bond-ratings/">Bond Ratings</a></li>
                                          <li><a href="/agencies/resources/appropriation-inquiries/">Appropriation Inquiries</a></li>
                                        </ul>
                                      </div>
                                      <div class="col-sm-6">
                                        <ul class="multi-column-dropdown">
                                           <li><a href="/financial-data/fiscal-focus-blog/fund-search/">Fund Search</a></li>
                                           <li><a href="/financial-data/fiscal-focus-blog/archive/">Archive</a></li>
                                           <!--- <li><a href="/financial-data/fiscal-focus-blog/charts-graphs/">Charts/Graphs</a></li> --->
                                           <li><a href="/financial-data/fiscal-focus-blog/charts-graphs/">Charts/Graphs</a></li>
                                        </ul>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                              </ul>
                            </div>
                            <div class="col-sm-4">
                              <ul class="multi-column-dropdown">
                                <li><a href="/financial-data/state-expenditures/contracts/">State Contracts</a></li>
                                <li><a href="/financial-data/state-expenditures/employee-salary-database/">Salary Database</a></li>
                                <li class="dropdown-submenu">
                                  <a href="/financial-data/state-revenues/" class="dropdown-toggle">State Revenues</a>
                                  <ul class="dropdown-menu multi-column rightflow-sub columns-2">
                                  <div class="row">
                                    <div class="col-sm-6">
                                      <ul class="multi-column-dropdown">
                                         <li><a href="/financial-data/state-revenues/statewide">Statewide</a></li>
                                         <li><a href="/financial-data/state-revenues/by-fund">Fund</a></li>
                                         <li><a href="/financial-data/state-revenues/by-agency">Agency</a></li>
                                         <li><a href="/financial-data/state-revenues/by-revenue-source">Revenue Source</a></li>
                                      </ul>
                                    </div>
                                    <div class="col-sm-6">
                                      <ul class="multi-column-dropdown">
                                        <li><a href="/financial-data/state-revenues/income-tax">Income Tax</a></li>
                                        <li><a href="/financial-data/state-revenues/sales-tax">Sales Tax</a></li>
                                        <li><a href="/financial-data/state-revenues/motor-fuel-tax">Motor/Fuel</a></li>
                                        <li><a href="/financial-data/state-revenues/gaming">Gaming</a></li>
                                      </ul>
                                    </div> 
                                  </div>
                                  </ul>
                                </li>
                                <li class="dropdown-submenu">
                                    <a href="/financial-data/state-expenditures/" class="dropdown-toggle">State Expenditures</a>
                                    <ul class="dropdown-menu multi-column rightflow-sub columns-2">
                                    <div class="row">
                                      <div class="col-sm-6">
                                        <ul class="multi-column-dropdown">                                     
                                          <li><a href="/financial-data/state-expenditures/statewide">Statewide</a></li>
                                          <li><a href="/financial-data/state-expenditures/by-fund">Fund</a></li>
                                          <li><a href="/financial-data/state-expenditures/by-agency">Agency</a></li>
                                          <li><a href="/financial-data/state-expenditures/object-of-expenditure">Object of Expenditure</a></li>
                                          <li><a href="/financial-data/state-expenditures/detail-object/">Detail Object</a></li>
                                        </ul>
                                      </div>
                                      <div class="col-sm-6">
                                        <ul class="multi-column-dropdown">
                                          <li><a href="/financial-data/state-expenditures/education/">Education</a></li>
                                          <li><a href="/financial-data/state-expenditures/medicaid/">Medicaid</a></li>
                                          <li><a href="/financial-data/state-expenditures/pension-systems/">Pension Systems</a></li>
                                           <li><a href="/financial-data/state-expenditures/debt-payments">Debt Payments</a></li>
                                           <li><a href="/financial-data/state-expenditures/delayed-payment-interest">Late Payment Interest Penalties</a></li>
                                           <li><a href="/financial-data/state-expenditures/Infrastructure">Infrastructure</a></li>
                                        </ul>
                                      </div>
                                    </div>
                                    </ul>
                                </li>
                              </ul>
                            </div>
                            <div class="col-sm-3">
                              <ul class="multi-column-dropdown">
                                <li><a href="/financial-data/payments">Payments</a></li>
                                <li><a href="/financial-data/openbook/">OpenBook</a></li>
                                <li><a href="/financial-data/local-government-division/">Local Government</a></li>
                              </ul>
                            </div>
                          </div>
                        </ul>
                    </li>

                    <li class="dropdown#varAgencies#">
                      <a href="/AGENCIES">AGENCIES</a>
                      <ul class="dropdown-menu multi-column columns-2">
                        <div class="row">
                          <div class="col-sm-6">
                            <ul class="multi-column-dropdown">
                              <li><a href="/agencies/submit-a-report/">Submit  A Report</a></li>
                              <li class="dropdown-submenu">
                                <a href="/agencies/sams/direct-access/" class="dropdown-toggle">SAMS</a>
                                <ul class="dropdown-menu multi-column leftflow-sub columns-2">
                                <div class="row">
                                  <div class="col-sm-6">
                                    <ul class="multi-column-dropdown">
                                      <li><a href="/agencies/sams/sams-manual/">SAMS Manual</a></li>
                                      <li><a href="/agencies/sams/sams-procedure-bulletins">SAMS Bulletins</a></li>
                                      <li><a href="/agencies/sams/sams-manual-procedure-2-internal-controls">Supplement to Manual Procedure 2</a></li>
                                      <li><a href="/agencies/sams/sams-revision-request-form/">SAMS Revision Request</a></li>
                                    </ul>
                                  </div>
                                  <div class="col-sm-6">
                                    <ul class="multi-column-dropdown">
                                       <li><a href="/agencies/sams/sams-monthly-report/">SAMS Monthly Reports</a></li>
                                       <li><a href="/agencies/sams/agency-report-portal/">Agency Report Portal</a></li>
                                       <li><a href="/agencies/sams/direct-access">Direct Access</a></li>
                                    </ul>
                                  </div>
                                </div>
                                </ul>
                              </li>
                            </ul>
                          </div>
                          <div class="col-sm-6">
                            <ul class="multi-column-dropdown">
                              <li class="dropdown-submenu">
                                <a href="/agencies/financial-gaap-reporting/" class="dropdown-toggle"> Financial Reporting</a>
                                <ul class="dropdown-menu multi-column rightflow-sub columns-2">
                                  <div class="row">
                                    <div class="col-sm-6">
                                      <ul class="multi-column-dropdown">
                                        <li><a href="/agencies/wedge/wedge-20-user-registration/">WEDGE Registration</a></li>                                        
                                        <li><a href="https://reporting.ioc.state.il.us/">WEDGE</a></li>
                                        <li><a href="/agencies/wedge/sco563-grant-analysis">SCO 563 Grant Analysis</a></li>                                        
                                        <li><a href="/agencies/financial-gaap-reporting/locally-held-funds/">Locally Held Funds</a></li>
                                      </ul>
                                    </div>
                                    <div class="col-sm-6">
                                      <ul class="multi-column-dropdown">
                                        <li><a href="/agencies/financial-gaap-reporting/training-manuals">Training Manuals</a></li>                                        
                                        <li><a href="/agencies/financial-gaap-reporting/state-agency-contacts">State Agency Contacts</a></li>
                                        <li><a href="/agencies/financial-gaap-reporting/delinquent-agency-list">Delinquent Agency List</a></li>
                                        <li><a href="/agencies/wedge/wedge-training-video">Training Videos</a></li>
                                      </ul>
                                    </div>
                                  </div>
                                </ul>
                              </li>
                              <li class="dropdown-submenu">
                                <a href="##" class="dropdown-toggle">Resources</a>
                                <ul class="dropdown-menu multi-column rightflow-sub columns-2">
                                  <div class="row">
                                    <div class="col-sm-6">
                                      <ul class="multi-column-dropdown">
                                        <li><a href="/agencies/resources/accounting-forms">Accounting Forms</a></li>
                                         <li><a href="/agencies/resources/accounting-bulletins">Accounting Bulletins</a></li>
                                        <li><a href="/agencies/resources/appropriation-inquiries">Appropriation Inquiries & Account Codes</a></li>
                                        <li><a href="/agencies/resources/invoice-voucher-fillable-form-c-13">Fillable Invoice Voucher</a></li>
                                      </ul>
                                    </div>
                                    <div class="col-sm-6">
                                      <ul class="multi-column-dropdown">
                                         <li><a href="/agencies/resources/pay-schedules">Pay Schedules</a></li>
                                         <li><a href="/agencies/resources/payroll-bulletins">Payroll Bulletins</a></li>
                                         <li><a href="/agencies/resources/position-classification-and-payroll-code-books">Position Classification & Payroll Code Books</a></li>
                                         <li><a href="/agencies/resources/statutorily-required/">Statutorily Required</a></li>
                                      </ul>
                                    </div>
                                  </div>
                                </ul>
                              </li>

                            </ul>
                          </div>
                        </div>
                      </ul>
                    </li>


                    <li class="dropdown#varVendors#">
                      <a href="/vendors">VENDORS</a>
                      <ul class="dropdown-menu">
                        <li><a href="/vendors/">Vendor Payments</a></li>
                        <li><a href="/vendors/warrant-inquiry-form">Warrant Inquiry</a></li>
                        <li><a href="/vendors/prevailing-wage">Prevailing Wage Inquiries</a></li>
                        <li><a href="/vendors/direct-deposit/">Direct Deposit Sign Up</a></li>
                        <!--<li><a href="/vendors/direct-deposit-hardship">Direct Deposit Hardship Info</a></li>-->
                      </ul>
                    </li>

                    <li class="dropdown#varNews#">
                        <a href="/news/press-releases">NEWS</a>
                        <ul class="dropdown-menu">
                          <li><a href="/news/in-the-news/">In The News</a></li>
                          <li><a href="/news/press-releases">Press Releases</a></li>
                          <li><a href="/news/event-requests">Event Requests</a></li>
<!---                     <li><a href="/news/upcoming-events">Upcoming Events</a></li> --->
                          <li><a href="/news/social-media/">Social Media</a>
<!---                               <ul class="dropdown-menu leftflow-sub">
                                  <li><a href="/news/social-media/facebook">Facebook</a></li>
                                  <li><a href="/news/social-media/twitter">Twitter</a></li>
                                  <li><a href="/news/social-media/instagram">Instagram</a></li>
                                  <li><a href="/news/social-media/youtube">YouTube</a></li>
                              </ul> --->
                          </li>
                          <li><a href="/news/fiscal-focus-articles/">Fiscal Focus</a></li>
                        </ul>
                    </li>

                    <li class="dropdown#varAbout#">
                      <a href="/about/susana-a-mendoza/">ABOUT</a>
                      <ul class="dropdown-menu multi-column rightflow columns-2">
                        <div class="row">
                          <div class="col-sm-6">
                            <ul class="multi-column-dropdown">
                                <li><a href="/about/what-is-a-comptroller/">What Is A Comptroller?</a></li>
                                <li><a href="/about/susana-a-mendoza/">Susana A. Mendoza</a></li>
                                <!--- <li><a href="/about/ioc-glossary-and-terms/">IOC Glossary &amp; Terms</a></li> --->
                                <li class="dropdown-submenu">
                                    <a href="##" class="dropdown-toggle">Press Resources</a>
                                    <ul class="dropdown-menu leftflow-sub">
                                        <li><a href="/about/press-resources/media-requests/">Media Requests</a></li>
                                    </ul>
                                </li>
                                <li class="dropdown-submenu">
                                        <a href="##" class="dropdown-toggle">Constituent Services</a>
                                    <ul class="dropdown-menu multi-column rightflow-sub columns-2">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="/about/check-for-cash/">Check for Cash</a></li>
                                                    <li><a href="/about/programs/critters/">Comptroller's Critters</a></li>
                                                    <li><a href="/about/programs/culinary-kids/">Culinary Kids</a></li>
                                                    <li><a href="/about/programs/smart-consumers-illinois/">Smart Consumers</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="/about/programs/smart-business-illinois/">Smart Business</a></li>
                                                    <li><a href="/about/find-my-refund">Find My Refund</a></li>
                                                    <li><a href="/about/place/">PLACE</a></li>
                                                    <li><a href="/about/myPayStub">My Pay Stub</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </ul>
                                </li>
                            </ul>
                              <li><a href="/about/contact/send-us-a-message/">Send Us a Message</a></li>                            
                          </div>
                          <div class="col-sm-6">
                            <ul class="multi-column-dropdown">
                               <li><a href="/about/press-resources/record-requests-and-foia/">Record Requests &amp; FOIA</a></li>
                               <li><a href="/about/office-of-the-executive-inspector-general/">Inspector General</a></li>
                               <li class="dropdown-submenu">
                                <a href="/about/contact/" class="dropdown-toggle">Contact Us</a>
                                <ul class="dropdown-menu leftflow-sub">
                                    <li><a href="/about/contact/our-mailing-addresses-and-phone-numbers/">Phone &amp; Mailing Addresses</a></li>
                                    <li><a href="/about/contact/agency-contact-information/">Agency Contacts</a></li>
                                </ul>
                              </li>


                            </ul>
                          </div>
                        </div>
                      </ul>
                    </li>


                    <li class="dropdown">
                        <a class="search-icon" href="##"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></a>
                        <ul class="dropdown-menu search-bar">
                    <li><gcse:search></gcse:search></li>
                              </ul>
                          </li>
                  </ul>
        </div>

                  <script>
                  // Add hover effect to menus
            
            var $nav = $('.navbar-collapse > ul > li');
                    $nav.hover(
                      function() {
                        $('a',this).first().css({"background-color":"yellow"});
                      },
                      function() {
                        $('a',this).first().css({"background-color":"transparent"});
                      }
                    );
            
                  jQuery('ul.dropdown-menu li.dropdown-submenu').hover(function() {
                    jQuery(this).find('.dropdown-menu').stop(true, true).delay(0).fadeIn();
                  }, function() {
                    jQuery(this).find('.dropdown-menu').stop(true, true).delay(0).fadeOut();
                  });

                  </script>

                  <!--/.navbar-collapse-->


      </nav>
   </div>

<div id='cse' style='width: 100%;'>Loading</div>
<script src='//www.google.com/jsapi' type='text/javascript'></script>
<style>
div##cse {
    display: none;
}

##___gcse_0>.input-group{
  width: 100% !important;
}

</style>
<script type='text/javascript'>
  (function() {
    var cx = '015800503075325803674:cl2rrtlg50e';
    var gcse = document.createElement('script');
    gcse.type = 'text/javascript';
    gcse.async = true;
    gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(gcse, s);
  })();
</script>

</header>
</cfoutput>

<style type='text/css'>
  .input-group {
    width:100%;
  }
  .gsc-control-wrapper-cse {
    /* Added by Andy */


  }
  .gsc-control-cse {

  }
  .gsc-control-cse .gsc-table-result {
   /* font-family: Arial, sans-serif;*/
  }
  input.gsc-input, .gsc-input-box, .gsc-input-box-hover, .gsc-input-box-focus {
    /*border-color: #D9D9D9;*/
  }

  .gsc-search-button
{
   background-color: #1C2B48 !important;
   border-radius: 5px;

}

input.gsc-search-button, input.gsc-search-button:hover, input.gsc-search-button:focus {
    background-color: #1C2B48 !important;
    background-image: url("http://www.google.com/uds/css/v2/search_box_icon.png") !important;
    background-position: 50% 50%;
    background-repeat: no-repeat;
    /*height: 20px !important;*/
    border-color: #1C2B48 !important;
    filter: none;

    box-sizing:content-box;
    line-height:normal;
}

 /*AM22 - To make google search box appear correct - START*/
input.gsc-input, .gsc-input-box, .gsc-input-box-hover, .gsc-input-box-focus, .gsc-search-button
{
  box-sizing: content-box;
  line-height: normal;
}
/*AM22 - To make google search box appear correct - END*/

  .gsc-tabHeader.gsc-tabhInactive {
   /* border-color: #FF9900;
    background-color: #FFFFFF;*/
  }
  .gsc-tabHeader.gsc-tabhActive {
    /*border-color: #E9E9E9;
    background-color: #E9E9E9;
    border-bottom-color: #FF9900*/
  }
  .gsc-tabsArea {
    /*border-color: #FF9900;*/
  }
  .gsc-webResult.gsc-result, .gsc-results .gsc-imageResult {
   /* border-color: #FFFFFF;
    background-color: #FFFFFF;*/
  }
  .gsc-webResult.gsc-result:hover, .gsc-imageResult:hover {
    /*border-color: #FFFFFF;
    background-color: #FFFFFF;*/
  }
  .gs-webResult.gs-result a.gs-title:link, .gs-webResult.gs-result a.gs-title:link b, .gs-imageResult a.gs-title:link, .gs-imageResult a.gs-title:link b  {
    /*color: #0000CC;*/
  }
  .gs-webResult.gs-result a.gs-title:visited, .gs-webResult.gs-result a.gs-title:visited b, .gs-imageResult a.gs-title:visited, .gs-imageResult a.gs-title:visited b {
    /*color: #0000CC;*/
  }
  .gs-webResult.gs-result a.gs-title:hover, .gs-webResult.gs-result a.gs-title:hover b, .gs-imageResult a.gs-title:hover, .gs-imageResult a.gs-title:hover b {
    /*color: #0000CC;*/
  }
  .gs-webResult.gs-result a.gs-title:active, .gs-webResult.gs-result a.gs-title:active b, .gs-imageResult a.gs-title:active, .gs-imageResult a.gs-title:active b {
    /*color: #0000CC;*/
  }
  .gsc-cursor-page {
    /*color: #0000CC;*/
  }
  a.gsc-trailing-more-results:link {
    color: #0000CC;
  }
  .gs-webResult .gs-snippet, .gs-imageResult .gs-snippet, .gs-fileFormatType {
    color: #000000;
  }
  .gs-webResult div.gs-visibleUrl, .gs-imageResult div.gs-visibleUrl {
    color: #008000;
  }
  .gs-webResult div.gs-visibleUrl-short {
    color: #008000;
  }
  .gs-webResult div.gs-visibleUrl-short  {
    display: none;
  }
  .gs-webResult div.gs-visibleUrl-long {
    display: block;
  }
  .gs-promotion div.gs-visibleUrl-short {
    display: none;
  }
  .gs-promotion div.gs-visibleUrl-long  {
    display: block;
  }
  .gsc-cursor-box {
    /*border-color: #FFFFFF;*/
  }
  .gsc-results .gsc-cursor-box .gsc-cursor-page {
    /*border-color: #E9E9E9;
    background-color: #FFFFFF;
    color: #0000CC;*/
  }
  .gsc-results .gsc-cursor-box .gsc-cursor-current-page {
    /*border-color: #FF9900;
    background-color: #FFFFFF;
    color: #0000CC;*/
  }
  .gsc-webResult.gsc-result.gsc-promotion {
   /* border-color: #336699;
    background-color: #FFFFFF;*/
  }
  .gsc-completion-title {
    color: #0000CC;
  }
  .gsc-completion-snippet {
    color: #000000;
  }
  .gs-promotion a.gs-title:link,.gs-promotion a.gs-title:link *,.gs-promotion .gs-snippet a:link  {
    color: #0000CC;
  }
  .gs-promotion a.gs-title:visited,.gs-promotion a.gs-title:visited *,.gs-promotion .gs-snippet a:visited {
    color: #0000CC;
  }
  .gs-promotion a.gs-title:hover,.gs-promotion a.gs-title:hover *,.gs-promotion .gs-snippet a:hover  {
    color: #0000CC;
  }
  .gs-promotion a.gs-title:active,.gs-promotion a.gs-title:active *,.gs-promotion .gs-snippet a:active {
    color: #0000CC;
  }
  .gs-promotion .gs-snippet, .gs-promotion .gs-title .gs-promotion-title-right, .gs-promotion .gs-title .gs-promotion-title-right * {
    color: #000000;
  }
  .gs-promotion .gs-visibleUrl,.gs-promotion .gs-visibleUrl-short  {
    color: #008000;
  }
  /* RK Added this on 8/3/2015 to fix close button in IE */
  input[type=text]::-ms-clear {
    display: none;
  }
  /* RK Added this on 8/4/2015 to fix popup box which has Relevance button in all browsers */
  .gsc-results-wrapper-visible *,
  .gsc-results-wrapper-visible *:before,
  .gsc-results-wrapper-visible *:after {
    -webkit-box-sizing: content-box !important;
    -moz-box-sizing: content-box !important;
    box-sizing: content-box !important;
  }
</style>