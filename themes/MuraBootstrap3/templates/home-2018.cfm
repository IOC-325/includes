<cfabort>

<cfoutput>
	<cfinclude template="inc/html_head_2018.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<cfinclude template="inc/navbar_2018.cfm" />

		<div class="container">
				<section class="content">
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
			<div class="row">
				<section class="col-md-12 content" id="home-large-logos">
					<div class="col-md-3 col-md-offset-2 hover-state"><a href="/DTAReport/"><img alt="Debt Transparency Report" class="center-block" src="/comptroller/assets/2018/DTR_home.png" /></a>
					</div>

					<div class="col-md-3 hover-state"><a href="/"><img class="center-block" alt="Backlog Voucher Report" src="/comptroller/assets/2018/BVR_home.png" /></a>
					</div>

					<div class="col-md-3 hover-state"><a href="/news-portal/"><img alt="Latest News" class="center-block" src="/comptroller/assets/2018/NEWS_home.png" /></a>
					</div>
				</section>
			</div>

<div class="row"><p class="alert">Notice to local governmental bodies: As of Thursday, Feb. 6, 2020, the Illinois Office of Comptroller is no longer collecting unpaid red-light camera tickets on behalf of municipalities. Other collections continue. This new policy was announced Jan. 6, 2020. https://illinoiscomptroller.gov/news/press-releases/comptroller-mendoza-gives-red-light-to-red-light-ticket-collections/</p></div>

		</div><!-- /.container -->

	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot _2018.cfm" />
</cfoutput>