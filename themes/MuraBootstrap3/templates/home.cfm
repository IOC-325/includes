<!--- MODAL. Different code in production for rendering. Either option will work --->
<cftry>
<!--- Visit tblParams in the IOCReference database. Set ShowHomePagePopUp to 1 or 0. If 1, the popup will show. --->
<cfquery datasource="IOCReference" name="modalParams">
    select top (1) strValue from tblParams
    where id = <cfqueryparam value="5EF448BB-08C7-48B4-8BC4-A482E84314C3" cfsqltype="cf_sql_varchar">
    and strItem = <cfqueryparam value="ShowHomePagePopUp" cfsqltype="cf_sql_varchar">
</cfquery>

<cfcatch type="any">
    <cfset modalParams.strValue = 0>
    <cfset hideModal="true">
</cfcatch>
</cftry>

<cfif modalParams.strValue>
    <cfparam name="hideModal" default="false">

    <cfif isDefined("cookie.hideModal") and cookie.hideModal eq "true">
	    <cfset hideModal = "true">
    </cfif>

    <cfif !hideModal>
        <cfquery datasource="MuraCMS2018" name="modalContent">
            select top(1) body as 'modalContent_text' from tcontent
            where siteID = <cfqueryparam value="comptroller" cfsqltype="cf_sql_varchar">
            and type = <cfqueryparam value="component" cfsqltype="cf_sql_varchar">
            and title= <cfqueryparam value="[Home Page] - Popup Modal Window Text" cfsqltype="cf_sql_varchar">
            order by lastUpdate desc
        </cfquery>
    </cfif>
</cfif>

<cfoutput>
    <div class="alert font-weight-bold alert-dismissible" style="margin-bottom:0px; font-size: 1.25em; background-color:yellow;" role="alert"> 
        <i class="fa fa-check-circle fa-lg text-danger"></i> &##x9; <b> View up to date information on the fiscal impact of COVID-19 to the State of Illinois 
           & helpful links from our <a href="/covid19-information">COVID-19 Response & Resources</a> page.</b> 
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <cfinclude template="inc/html_head_2018.cfm" />
    <body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
        <cfinclude template="inc/navbar_2018.cfm" />

        <div class="container">
            <div class="row">
                <section class="col-md-12 content">
                    <!--- 
                            The Content
                            See the file located under '/display_objects/page_default/index.cfm' to override body styling
                    --->
                    #$.dspBody(
                        body = $.content('body'),
                        pageTitle = '',
                        crumbList = false,
                        showMetaImage = false
                    )#

                </section>
            </div>
<!--- (2) Adding the August Issue of FF --->
<!---
<img class="img-responsive" src="/comptroller/assets/file/ff_home.png">--->
<!--- 
    (1) Removing 8/4/2020 
<h2 class="text-center"><u>STATEMENT FROM COMPTROLLER SUSANA A. MENDOZA</u></h2>
<h3 class="text-center"><i>Further payment delays are expected in coming weeks and months</i></h3>
<h3>The Illinois Office of Comptroller has received multiple inquiries as to the timing and volume of payments being released, given the circumstances related to the worldwide COVID-19 Coronavirus health emergency. <a href="https://illinoiscomptroller.gov/about/susana-a-mendoza/statement-from-comptroller-susana-a-mendoza/">Read more here.</a><br /><br></h3>

            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text-center">
                   <!--- <img src="/comptroller/assets/Image/TopTen2018Final.png" class="img-responsive"> --->
                   <!--- <iframe allowfullscreen="" class="embed-responsive-item" frameborder="0" mozallowfullscreen="" src="https://www.youtube.com/embed/rv9CnFSpVkE" webkitallowfullscreen="" width="100%" height="100%"></iframe> --->
                   <!--- <iframe allowfullscreen="" class="embed-responsive-item" src="https://www.youtube.com/embed/ka8mzQB1GbI?start=78" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen webkitallowfullscreen="" width="100%" height="100%"></iframe> --->
                   <!--- https://www.youtube.com/embed/OGzQQGQUbyE --->
                   <iframe 
                   	 	class="embed-responsive-item"
                   		src="https://www.youtube.com/embed/yVULea7Y6kA" 
                   		frameborder="0" 
                   		allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" 
                   		allowfullscreen 
                   		width="100%" 
                   		height="100%"></iframe>
                </div>
            </div>
        --->
<div>
    <h2 style="margin-top:0px"><strong>Illinois Tax Season Update</strong></h2>

    <p>The Illinois Office of Comptroller sends out income tax refunds after receiving the payment information from the <a href="https://www2.illinois.gov/rev/Pages/default.aspx">Illinois Department of Revenue</a>. The Illinois Department of Revenue will begin accepting 2020 state individual income tax returns on Friday, February 12th, the same day as the federal <a href="https://www2.illinois.gov/IISNews/22704-2021_Illinois_Tax_Filing_Season_Begins_Friday_February_12.pdf"></a>Internal Revenue Service will this year</a>. </p> 

    <p>After filing your state income tax with the Illinois Department of Revenue, you can check the status of your refund with the 'Where's My Refund' application available on <a href="https://mytax.illinois.gov/_/">MyTax Illinois</a>.</p>
    
    <p>Once your return is processed at the Illinois Department of Revenue, the information is sent to the Illinois Office of Comptroller, at which time your refund will be issued. You can check the status of your tax refund payment at <a href="https://myrefund.illinoiscomptroller.gov/">Find My Refund</a>. We appreciate your patience during this process. </p>

</div>

        <div class="ff-pageTitle clearfix">
    <h3><a href="https://medium.com/gdgf">Fiscal Focus</a></h3>
    <ul class="ff-socialIcons pull-right">
        <li><a href="https://twitter.com/ILComptroller"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
        <li><a href="https://facebook.com/ILComptroller"><i class="fa fa-facebook-square" aria-hidden="true"></i></a></li>
        <li><a href="https://instagram.com/ilcomptroller"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
        <li><a href="https://medium.com/_/subscribe/collection/gdgf" class="followBTN">Follow</a></li>
    </ul>
</div>

<div class="row">
    <div class="col-sm-8">
        <a href="https://medium.com/gdgf/message-from-the-comptroller-77172de7cb2c" class="ff-image-big ff-image"></a>
    </div>
    <div class="col-sm-4 ff-anchor">
        <a href="https://medium.com/gdgf/message-from-the-comptroller-77172de7cb2c">
            <h3 class="ff-title">Message From The Comptroller</h3>
            <p class="ff-subtitle">Federal Help Key to Illinois' Post-Pandemic Comeback</p>
        </a>
        <div class="comptrollerImage margintop">
            <a href="https://medium.com/@ILComptroller" class="avatar">
                <div class="avatar-inner">
                    <div class="avatar-halo"></div>
                    <div class="avatarIMG"></div>
                    <img src="/comptroller/assets/2018/Fiscal-Focus/2_HyKGlpMs0UORUIhF9HArEw.jpeg" alt="Go to the profile of Illinois State Comptroller" class="avatar-image">
                </div>
            </a>
            <div class="avatar-text">
                <a href="https://medium.com/@ILComptroller">Illinois State Comptroller</a>
                <p class="Datetime">Aug 2 . 3 min read</p>
            </div>
        </div>
    </div>
</div>
<div class="row margintop30">
    <div class="col-sm-4 ff-anchor">
        <a href="https://medium.com/gdgf/a-perfect-storm-ac6b8ae653ee">
            <div class="ff-image-small1 ff-image"></div>
            <h3 class="ff-title ff-title-font">A Perfect Storm</h3>
            <p class="ff-subtitle">HOPING FOR A COMEBACK, ILLINOIS WEATHERS A NEW TEMPEST: COVID-19</p>
        </a>
        <div class="comptrollerImage margintop marginb15">
            <a href="https://medium.com/@ILComptroller" class="avatar">
                <div class="avatar-inner">
                    <div class="avatar-halo"></div>
                    <div class="avatarIMG"></div>
                    <img src="/comptroller/assets/2018/Fiscal-Focus/2_HyKGlpMs0UORUIhF9HArEw.jpeg" alt="Go to the profile of Illinois State Comptroller" class="avatar-image">
                </div>
            </a>
            <div class="avatar-text">
                <a href="https://medium.com/@ILComptroller">Illinois State Comptroller</a>
                <p class="Datetime">Aug 2 . 3 min read</p>
            </div>
        </div>
    </div>
    <div class="col-sm-4 ff-anchor">
        <a href="https://medium.com/gdgf/timeline-how-covid-19-unfolded-in-illinois-fc8d124ae033">
            <div class="ff-image-small2 ff-image"></div>
            <h3 class="ff-title ff-title-font">TIMELINE: HOW COVID-19 UNFOLDED IN ILLINOIS</h3>
            <p class="ff-subtitle">TRACKING THE CRITICAL MOMENTS IN ILLINOIS' PANDEMIC RESPONSE</p>
        </a>
        <div class="comptrollerImage margintop marginb15">
            <a href="https://medium.com/@ILComptroller" class="avatar">
                <div class="avatar-inner">
                    <div class="avatar-halo"></div>
                    <div class="avatarIMG"></div>
                    <img src="/comptroller/assets/2018/Fiscal-Focus/2_HyKGlpMs0UORUIhF9HArEw.jpeg" alt="Go to the profile of Illinois State Comptroller" class="avatar-image">
                </div>
            </a>
            <div class="avatar-text">
                <a href="https://medium.com/@ILComptroller">Illinois State Comptroller</a>
                <p class="Datetime">Aug 2 . 3 min read</p>
            </div>
        </div>
    </div>
    <div class="col-sm-4 ff-anchor">
        <a href="https://medium.com/gdgf/as-pandemic-rages-rural-pharmacies-get-a-lifeline-da940d9c4aa6">
            <div class="ff-image-small3 ff-image"></div>
            <h3 class="ff-title ff-title-font">AS PANDEMIC RAGES, RURAL PHARMACIES GET A LIFELINE</h3>
            <p class="ff-subtitle">ILLINOIS' CRITICAL ACCESS PHARMACY PROGRAM MAKING A DIFFERENCE FOR LOCAL PHARMACIES</p>
        </a>
        <div class="comptrollerImage margintop marginb15">
            <a href="https://medium.com/@ILComptroller" class="avatar">
                <div class="avatar-inner">
                    <div class="avatar-halo"></div>
                    <div class="avatarIMG"></div>
                    <img src="/comptroller/assets/2018/Fiscal-Focus/2_HyKGlpMs0UORUIhF9HArEw.jpeg" alt="Go to the profile of Illinois State Comptroller" class="avatar-image">
                </div>
            </a>
            <div class="avatar-text">
                <a href="https://medium.com/@ILComptroller">Illinois State Comptroller</a>
                <p class="Datetime">Aug 2 . 3 min read</p>
            </div>
        </div>
    </div>
</div>

<!---
    <hr>
<h2 align="center" class="margintop30"><strong>Waiting for an Illinois state income tax refund?</strong></h2>

<p align="center">The Illinois Office of Comptroller sends out income tax refunds within 24-48 hours of receiving the information from the Illinois Department of Revenue.  If you have any questions about your refund or the timing of your refund, please contact the <a href="https://mytax.illinois.gov/_/">Department of Revenue- My Tax IL</a>. If you have questions about your federal tax refund, please contact <a href="https://sa.www4.irs.gov/irfof/lang/en/irfofgetstatus.jsp">the Internal Revenue Service (IRS)-Check My Refunds Status.</a></p>

<p align="center">Refunds will continue to be paid as Department of Revenue completes their reviews.  The extension of the tax filing deadline to July 15 will not slow down refunds.</p>
--->
<!--- 
    <hr>
<h2 align="center" class="margintop30"><strong>STATEMENT FROM COMPTROLLER SUSANA A. MENDOZA</strong></h2>
<h3 class="text-center"><i>Further payment delays are expected in coming weeks and months</i></h3>
<h3>The Illinois Office of Comptroller has received multiple inquiries as to the timing and volume of payments being released, given the circumstances related to the worldwide COVID-19 Coronavirus health emergency. <a href="https://illinoiscomptroller.gov/about/susana-a-mendoza/statement-from-comptroller-susana-a-mendoza/">Read more here.</a><br /><br></h3>
--->
<hr>

            <!---
            <div class="row">
                <div class="col-sm-12 text-center">
                    <!--- <h3 class="linkto"><img src="/comptroller/assets/2018/backpay.png" alt="Are you due back wages"> <a href="https://illinoiscomptroller.gov/about/back-wages-owed-to-certain-state-employees">Are you due back wages?</a></h3> --->
                    <h3 class="linkto" ><a href="/about/bicentennial-videos/"><img src="/comptroller/assets/image/Illinois-Bicentennial-Logo-150-circle.png" style="height:100px" ></a><a href="/about/bicentennial-videos/">Watch our Bicentennial Videos</a></h3>
                </div>
            </div>--->

            <div class="row" id="home-large-logos">
                
                <div class="col-xs-6 col-sm-3 col-sm-offset-0 col-md-2 col-md-offset-1 hover-state"> <a href="/financial-data/debt-transparency-reports-dtr/"><img alt="Debt Transparency Report" class="center-block" src="/comptroller/assets/2018/DTR_home_square.png" /></a></div>

                <div class="col-xs-6 col-sm-3 col-md-2 hover-state"><a href="/financial-data/backlog-voucher-report-bvr/"><img class="center-block" alt="Backlog Voucher Report" src="/comptroller/assets/2018/BVR_home_square.png" /></a></div>

                <div class="col-xs-6 col-sm-3 col-md-2 hover-state"><a href="/office/signup/"><img alt="Enewsletter" class="center-block" src="/comptroller/assets/2018/Enewsletter.png" /></a></div>

                <div class="col-xs-6 col-sm-3 col-md-2 hover-state"><a href="/news/fiscal-focus/"><img alt="Latest News" class="center-block" src="/comptroller/assets/2018/FiscalFocus.png" /></a></div>

                <div class="col-xs-6 col-sm-3 col-md-2 hover-state"><a href="/vendors/prevailing-wage/"><img alt="Latest News" class="center-block" src="/comptroller/assets/2018/PrevailingWageHome.png" /></a></div>

            </div>

            

            
            
<!--- 
            <div class="row">
                <section class="col-md-12 content" id="home-large-logos">
                    
                    <div class="col-md-2 col-md-offset-3 hover-state"><a href="/financial-data/debt-transparency-reports-dtr/"><img alt="Debt Transparency Report" class="center-block" src="/comptroller/assets/2018/DTR_home_square.png" /></a>
                    </div>

                    <div class="col-md-2 hover-state"><a href="/financial-data/backlog-voucher-report-bvr/"><img class="center-block" alt="Backlog Voucher Report" src="/comptroller/assets/2018/BVR_home_square.png" /></a>
                    </div>

                    <div class="col-md-2 hover-state"><a href="/news-portal/"><img alt="Latest News" class="center-block" src="/comptroller/assets/2018/NEWS_home_square.png" /></a>
                    </div>
                
                </section>

            </div> --->

            <!--- <div class="row">
                <section class="col-md-12 content">
                    <div class="row">
                        <div class="col-md-12">
                            <p class="text-center large-text">ABOUT THE COMPTROLLER'S OFFICE</p>
                        </div>
                    </div>

                    <div class="container">
                        <ul class="list-inline row">
                            <li class="col-sm-4" style="padding-right: 0px;">
                                <div class="col-md-6 col-lg-4 home-small-box home-small-box-first hover-state" style="padding: 7px;"><a href="/financial-data/local-government-division/"><img src="/comptroller/assets/2018/Local Gov.png" style="padding: 7px;" class="center-block"/></a>
                                    <p class="small-text text-center"><a href="/financial-data/local-government-division/">local government</a></p>
                                </div>

                                <div class="col-md-6 col-lg-4 hover-state home-small-box" style="padding: 7px;"><a href="/agencies/submit-a-report/"><img src="/comptroller/assets/2018/Submit a Report.png" style="padding: 7px;" class="center-block" /></a>
                                    <p class="small-text text-center"><a href="/agencies/submit-a-report/">submit a report</a></p>
                                </div>

                                <div class="col-md-6 col-lg-4 hover-state home-small-box" style="padding: 7px;"><a href="/financial-data/find-a-report/"><img src="/comptroller/assets/2018/Find a report.png" style="padding: 7px;" class="center-block" /></a>
                                    <p class="small-text text-center"><a href="/financial-data/find-a-report/">find a report</a></p>
                                </div>
                            </li>
                            <li class="col-sm-4" style="padding-right:0px; padding-left: 0px;">
                                <div class="col-md-6 col-lg-4 hover-state home-small-box" style="padding: 7px;"><a href="/vendors/"><img src="/comptroller/assets/2018/Vendor Payments.png" class="center-block" style="padding: 7px;" /></a>
                                    <p class="small-text text-center"><a href="/vendors/">vendor payments</a></p>
                                </div>
                                <div class="col-md-6 col-lg-4 home-small-box" style="padding-right:0px; padding-left: 0px;">
                                    <a href="/about/susana-a-mendoza/"><img src="/comptroller/assets/2018/comptroller.png"  style="width: 100%; height: 100%;"></a>
                                </div> 

                                

                                <div class="col-md-6 col-lg-4 hover-state home-small-box" style="padding: 7px;"><a href="/appropriation-inquiries/"><img src="/comptroller/assets/2018/Appropriation Inquiries.png" class="center-block" style="padding: 7px;"/></a>
                                    <p class="small-text text-center"><a href="/appropriation-inquiries/">appropriation inquiries</a></p>
                                </div>

                            </li>
                            <li class="col-sm-4" style="padding-left: 0px;">
                                
                                <div class="col-md-6 col-lg-4 hover-state home-small-box" style="padding: 7px;"><a href="https://myrefund.illinoiscomptroller.com/"><img src="/comptroller/assets/2018/Find My Refund.png" style="padding: 7px;" class="center-block" /></a>
                                                                    <p class="small-text text-center"><a href="https://myrefund.illinoiscomptroller.com/">find my refund</a></p>
                                                                </div>
                                
                                <div class="col-md-6 col-lg-4 hover-state home-small-box" style="padding: 7px;"><a href="/services/mypaystub"><img src="/comptroller/assets/2018/My Pay Stub.png" class="center-block" style="padding: 7px;" /></a>
                                                                <p class="small-text text-center"><a href="/services/mypaystub/">my pay stub</a></p>
                                                            </div>
                                                            

                                <div class="col-md-6 col-lg-4 hover-state home-small-box home-small-box-last" style="padding: 7px;"><a href="/about/contact/"><img src="/comptroller/assets/2018/Contact Us.png" class="center-block" style="padding: 7px;" /></a>
                                    <p class="small-text text-center"><a href="/about/contact/">contact us</a></p>
                                </div>
                                    
                                </div>
                            </li>
                        </ul>
                    </div>
                </section>
            </div> --->

            <div class="row">
                <section class="col-md-12 content">
                    <p class="text-center large-text">ABOUT THE COMPTROLLER'S OFFICE</p>
                        <ul class="list-inline comp-office clearfix">
                            <li>
                                <div class="office-box">
                                    <a href="/financial-data/local-government-division/"><img src="/comptroller/assets/2018/Local Gov.png" class="center-block"></a>
                                    <p class="small-text text-center"><a href="/financial-data/local-government-division/">local government</a></p>
                                </div>
                            </li>
                            <li>
                                <div class="office-box">
                                    <a href="/agencies/submit-a-report/"><img src="/comptroller/assets/2018/Submit a Report.png" class="center-block"></a>
                                    <p class="small-text text-center"><a href="/agencies/submit-a-report/">submit a report</a></p>
                                </div>
                            </li>
                            <li>
                                <div class="office-box">
                                    <a href="/financial-data/find-a-report/"><img src="/comptroller/assets/2018/Find a report.png" class="center-block"></a>
                                    <p class="small-text text-center"><a href="/financial-data/find-a-report/">find a report</a></p>
                                </div>
                            </li>
                            <li>
                                <div class="office-box">
                                    <a href="/vendors/"><img src="/comptroller/assets/2018/Vendor Payments.png" class="center-block"></a>
                                    <p class="small-text text-center"><a href="/vendors/">vendor payments</a></p>
                                </div>
                            </li>
                            <li>
                                <div class="office-box office-box-image">
                                    <a href="/about/susana-a-mendoza/"><span class="comptroller-image"></span></a>
                                </div>
                            </li>

                            <li>
                                <div class="office-box">
                                    <a href="/about/check-for-cash/"><img class="center-block" src="/comptroller/assets/2018/rsz_check_for_cash.png"></a>
                                    <p class="small-text text-center"><a href="/about/check-for-cash/">check for cash</a></p>
                                    <!---<a href="/appropriation-inquiries/"><img src="/comptroller/assets/2018/Appropriation Inquiries.png" class="center-block"></a>
                                    <p class="small-text text-center"><a href="/appropriation-inquiries/">appropriation inquiries</a></p>--->
                                </div>
                            </li>
                            <li>
                                <div class="office-box">
                                    <a href="https://myrefund.illinoiscomptroller.com/"><img src="/comptroller/assets/2018/Find My Refund.png" class="center-block"></a>
                                    <p class="small-text text-center"><a href="https://myrefund.illinoiscomptroller.com/">find my refund</a></p>
                                </div>
                            </li>
<!---                             <li>
                                <div class="office-box">
                                    <a href="/services/mypaystub"><img src="/comptroller/assets/2018/My Pay Stub.png" class="center-block"></a>
                                    <p class="small-text text-center"><a href="/services/mypaystub/">my pay stub</a></p>
                                </div>
                            </li> --->
                            <!---<li>
                                <div class="office-box"><span class="footer-icons">
                                    <a href="/news/social-media/"><img class="center-block" src="/comptroller/assets/2018/rsz_social_media.png" /></a></span>
                                    <p class="small-text text-center"><span class="footer-icons"><a href="/news/social-media/">social media</a></span></p>
                                </div>
                            </li>--->
                            <li>
                                <div class="office-box"><span class="footer-icons">
                                    <a href="/office/signup/"><img class="center-block" src="/comptroller/assets/2018/Enewsletter-small.png" /></a></span>
                                    <p class="small-text text-center"><span class="footer-icons"><a href="/office/signup/">Enewsletter <br>Sign Up</a></span></p>
                                </div>
                            </li>
                            <li>
                                <div class="office-box">
                                    <a href="/about/constituent-services/smart-business-illinois/"><img src="/comptroller/assets/2018/smart business.png" class="center-block"></a>
                                    <p class="small-text text-center"><a href="/about/constituent-services/smart-business-illinois/">smart business</a></p>
                                </div>
                            </li>
                        </ul>
                    </section>
            </div>            

        </div><!-- /.container -->

    <cfinclude template="inc/footer_2018.cfm" />
    <cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>
<!-- Modal -->
<cfif isDefined("modalContent.modalContent_text") and modalContent.RecordCount>
    <div class="modal mymodal" id="popUpModal" tabindex="-1" role="dialog" aria-labelledby="popUpModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content mymodal-border">
                <div class="modal-body">
                    <cfoutput>#modalContent.modalContent_text#</cfoutput>
                    <input type="checkbox" id="doNotShowAgain"> <label>Do not show this again.</label>
                </div>
                <div class="modal-footer mymodal-footer">
                    <button type="button" class="btn btn-label-grey" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <script>
    $(document).ready(function () {
        $('#popUpModal').modal('show');
    });

    // Toggles the accordion's chevron and saves/deletes cookie
    $('#doNotShowAgain').on('change', function (){
        if ($('#doNotShowAgain').prop('checked')) document.cookie = "hideModal=true; expires=Fri, 31 Dec 9999 23:59:59 GMT";
    });

    </script>
</cfif>
