<cfoutput>
    <cfinclude template="inc/html_head_2018.cfm" />
    <body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
        <cfinclude template="inc/navbar_2018.cfm" />

        <div class="container">
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




            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text-center">
                    <iframe 
                        class="embed-responsive-item" 
                        src="https://www.youtube.com/embed/yVULea7Y6kA" 
                        frameborder="0" 
                        allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" 
                        allowfullscreen width="100%" 
                        height="100%"></iframe>
                </div>
            </div>

            <div class="row">
                <h2 align="center"><strong>How is the State responding to COVID-19?</strong></h2>
            <div class="alert alert-danger" role="alert">
            <p style="font-size:1.1em;"><b>COVID19 State Fiscal Impact as of 04/01/2020.</b> Blurb update if you want.
                Blurb update if you want. Blurb update if you want. Blurb update if you want. Blurb update if you want.
                Blurb update if you want. Blurb update if you want. Blurb update if you want. Blurb update if you want.
                Blurb update if you want. Blurb update if you want. Blurb update if you want. Blurb update if you want.
            </p>
            </div><!---
                <div class="text-center">
                    <script type='text/javascript' src='https://analytics.illinoiscomptroller.gov/javascripts/api/viz_v1.js'></script>
                   <div class='tableauPlaceholder' style='width: 1200px; height: 775px;'>
                        <object class='tableauViz' width='1200' height='775' style='display:none;'>
                            <param name='host_url' value='https%3A%2F%2Fanalytics.illinoiscomptroller.gov%2F' /> 
                            <param name='embed_code_version' value='3' /> 
                            <param name='site_root' value='/t/Development' />
                            <param name='name' value='IOCExpensesDuetoCOVID2019/Dashboard' />
                            <param name='tabs' value='no' />
                            <param name='toolbar' value='no' />
                            <param name='showAppBanner' value='false' />
                            <param name='filter' value='iframeSizedToWindow=true' />
                        </object>
                    </div>
                </div>
            </div>
--->
                <div class="text-center">
                    <script type='text/javascript' src='https://analytics.illinoiscomptroller.gov/javascripts/api/viz_v1.js'></script>
                    <div class='tableauPlaceholder' style='width: 1200px; height: 1200px;'>
                        <object class='tableauViz' width='1200' height='1200' style='display:none;'>
                            <param name='host_url' value='https%3A%2F%2Fanalytics.illinoiscomptroller.gov%2F' /> 
                            <param name='embed_code_version' value='3' /> 
                            <param name='site_root' value='/t/Development' />
                            <param name='name' value='IOCExpensesDuetoCOVID2019V2/Dashboard2' />
                            <param name='tabs' value='no' />
                            <param name='toolbar' value='no' />
                            <param name='showAppBanner' value='false' />
                            <param name='filter' value='iframeSizedToWindow=true' />
                        </object>
                    </div>
                </div>
            </div>

<h2 align="center"><strong>Waiting for an Illinois state income return?</strong></h2>

<p align="center">Our office sends out state income tax refunds within 24-48 hours after they arrive in our office from the State Dept. of Revenue. Any questions about the status of your refund should be directed to the Dept. of Revenue: <a href="https://www2.illinois.gov/rev/Pages/Taxpayer-Resources-during-COVID-19-%28Coronavirus%29-Outbreak.aspx">https://www2.illinois.gov/rev/Pages/Taxpayer-Resources-during-COVID-19-%28Coronavirus%29-Outbreak.aspx</a></p>

<p align="center">Refunds will continue going out to taxpayers as they file state returns and will not be affected by the extension of the tax filing deadline to July 15.</p>
<p><br></p>


            <div class="row" id="home-large-logos"></a>
                <div class="col-xs-6 col-sm-3 col-sm-offset-0 col-md-2 col-md-offset-2 hover-state"> <a href="/financial-data/debt-transparency-reports-dtr/"><img alt="Debt Transparency Report" class="center-block" src="/comptroller/assets/2018/DTR_home_square.png" /></a></div>
                <div class="col-xs-6 col-sm-3 col-md-2 hover-state"><a href="/financial-data/backlog-voucher-report-bvr/"><img class="center-block" alt="Backlog Voucher Report" src="/comptroller/assets/2018/BVR_home_square.png" /></a></div>
                <div class="col-xs-6 col-sm-3 col-md-2 hover-state"><a href="/news-portal/"><img alt="Latest News" class="center-block" src="/comptroller/assets/2018/NEWS_home_square.png" /></a></div>
                <div class="col-xs-6 col-sm-3 col-md-2 hover-state"><a href="https://illinoiscomptroller.gov/news/fiscal-focus/"><img alt="Latest News" class="center-block" src="/comptroller/assets/2018/FiscalFocus.png" /></a></div>
            </div>
            <div><a href="https://2018-uat.illinoiscomptroller.gov/office/iConstituent/index.cfm">Click Here</a> to sign up e-news letter.</div>
            <div class="alert alert-success" role="alert">
            <p style="font-size:1.1em;"><b>Notice to local governmental bodies:</b> As of Thursday, Feb. 6, 2020, the Illinois Office of Comptroller is no longer collecting unpaid red-light camera tickets on behalf of municipalities. Other collections continue. This new policy was announced Jan. 6, 2020. <a href="https://illinoiscomptroller.gov/news/press-releases/comptroller-mendoza-gives-red-light-to-red-light-ticket-collections/">https://illinoiscomptroller.gov/news/press-releases/comptroller-mendoza-gives-red-light-to-red-light-ticket-collections/</a></p>
            </div>
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
                        <a href="/about/check-for-cash/"><img src="/comptroller/assets/2018/rsz_check_for_cash.png" class="center-block"></a>
                        <p class="small-text text-center"><a href="/about/check-for-cash/">check for cash</a></p>
                    </div>
                </li>
                <li>
                    <div class="office-box">
                        <a href="https://myrefund.illinoiscomptroller.com/"><img src="/comptroller/assets/2018/Find My Refund.png" class="center-block"></a>
                        <p class="small-text text-center"><a href="https://myrefund.illinoiscomptroller.com/">find my refund</a></p>
                    </div>
                </li>
                <li>
                    <div class="office-box"><span class="footer-icons">
                        <a href="/news/social-media/"><img class="center-block" src="/comptroller/assets/2018/rsz_social_media.png" /></a></span>
                        <p class="small-text text-center"><span class="footer-icons"><a href="/news/social-media/">social media</a></span></p>
                    </div>
                </li>
                <li>
                    <div class="office-box">
                        <a href="/about/constituent-services/smart-business-illinois/"><img src="/comptroller/assets/2018/smart business.png" class="center-block"></a>
                        <p class="small-text text-center"><a href="/about/contact/">smart business</a></p>
                    </div>
                </li>
            </ul>
        </div><!-- /.container -->

    <cfinclude template="inc/footer_2018.cfm" />
    <cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>