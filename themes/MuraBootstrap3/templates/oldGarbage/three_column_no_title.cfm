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

			<!--- Breadcrumbs --->
			<div class="row">
				<nav>#$.dspCrumbListLinks(id='',class='breadcrumb',separator='>  ')#</nav>
			</div>
			
			<div class="row">
				<aside class="col-lg-3 col-md-3 col-sm-4 col-xs-12">
					#$.dspObjects(1)#
				</aside>
				<div class="clearfix visible-xs"></div>
				<section class="col-lg-6 col-md-6 col-sm-8 col-xs-12 content">
					#$.dspBody(
						body=$.content('body')
						, pageTitle=$.content('')
						, crumbList=false
						, showMetaImage=true
						, metaImageClass='thumbnail'
					)#
					#$.dspObjects(2)#
				</section>
				<aside class="col-lg-3 col-md-3 col-sm-4 col-xs-12">
					#$.dspObjects(3)#
				</aside>
			</div><!--- /.row --->
			<!--- Above Footer Objects --->
			<div id="aboveFooter" class="row">
				#$.dspObjects(5)#
			</div>
		</div><!-- /.container -->
	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>