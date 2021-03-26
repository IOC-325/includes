<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />
		<cfinclude template="inc/pageTitle.cfm" />
		<!--- Above Content Objects --->
		<div id="aboveContent">
			#$.dspObjects(4)#
		</div>
		<div class="container">
			<div class="row">
				<section class="content col-lg-9 col-md-9 col-sm-8 col-xs-12">

					#$.dspBody(body=$.content('body'),pageTitle=$.content('title'),crumbList=1,showMetaImage=1,metaImageClass='thumbnail')#
					#$.dspObjects(2)#
				</section>
				<aside class="col-lg-3 col-md-3 col-sm-4 col-xs-12 sidebar">
					#$.dspObjects(3)#
				</aside>
			</div>
			<!--- Above Footer Objects --->
			<div id="aboveFooter" class="row">
				#$.dspObjects(5)#
			</div>
		</div><!-- /.container -->

<!--- Blog Feed --->
		<div class="feed-wrapper">
			<div class="container blog-feed">
				<div class="row">
					<h2 class="col-md-12 center">Take a look at our Financial Workshops.</h2>
				</div>
				<div class="row">
					#$.dspObject('feed','Consumer Affairs Financial Workshops')#
				</div>
				<div class="row">
					<div class="col-md-12 center"><a href="#$.createHREF(filename='services/advisory-councils/financial-workshops/')#" class="btn btn-lg btn-primary">View All Workshops</a></div>
				</div>
			</div><!--- // container --->
		</div><!--- // feed-wrapper --->

	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>