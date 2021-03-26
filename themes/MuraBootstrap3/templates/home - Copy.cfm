<cfoutput>
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

            <div class="row">
<section class="col-md-12 content" id="home-large-logos">
    <div class="col-md-2 col-md-offset-3 hover-state"><a href="/financial-data/debt-transparency-reports-dtr/"><img alt="Debt Transparency Report" class="center-block" src="/comptroller/assets/2018/DTR_home_square.png" /></a>
    </div>

    <div class="col-md-2 hover-state"><a href="/financial-data/backlog-voucher-report-bvr/"><img class="center-block" alt="Backlog Voucher Report" src="/comptroller/assets/2018/BVR_home_square.png" /></a>
    </div>

    <div class="col-md-2 hover-state"><a href="/news-portal/"><img alt="Latest News" class="center-block" src="/comptroller/assets/2018/NEWS_home_square.png" /></a>
    </div>
</section>

            </div>

            <div class="row">
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
<!--- /about/susana-a-mendoza/ --->
                                <!--- <div class="col-md-6 col-lg-4 home-small-box" style="background-image: url('/comptroller/assets/2018/comptroller.png'); background-size: cover;"></div> --->
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

            </div>

        </div><!-- /.container -->

    <cfinclude template="inc/footer_2018.cfm" />
    <cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>