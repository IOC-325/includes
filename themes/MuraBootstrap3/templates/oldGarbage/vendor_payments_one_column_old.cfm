<cfoutput>
	<cfinclude template="inc/vendor_payments_html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />
		<cfinclude template="inc/pageTitle.cfm" />
		<!--- Above Content Objects --->
		<div id="aboveContent">
			#$.dspObjects(4)#
		</div>
		<div class="container">
			<div class="row">
				<section class="content col-lg-12 col-md-12 col-sm-12 col-xs-12">
					#$.dspBody(body=$.content('body'),pageTitle='',crumbList=0,showMetaImage=1,metaImageClass='thumbnail')#
					#$.dspObjects(2)#
				</section>
			</div>
			<!--- <!--- Above Footer Objects --->
			<div id="aboveFooter" class="row">
				#$.dspObjects(5)#
			</div> --->
		</div><!-- /.container -->
	<!--- <cfinclude template="inc/footer.cfm" /> --->
	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>