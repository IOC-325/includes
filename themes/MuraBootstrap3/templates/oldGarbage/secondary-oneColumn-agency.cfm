<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />

		<!--- don't show page title file for items in news and FAQ page --->
		<cfif
			$.getParentId() neq '1DB6817A-E0C7-3CE9-034D3BC5D881187C' and
			$.getTitle() neq 'FAQ' and
			$.getParentId() neq '85D715F4-1CC1-DE6E-2F48C6B0E8FF59E0'>
			<cfinclude template="inc/pageTitle.cfm" />
		<cfelse>
			<h3 style="text-transform: uppercase; text-align: center;">#$.getTitle()#</h3>
		</cfif>

		<!--- Above Content Objects --->
		<div id="aboveContent">
			#$.dspObjects(4)#
		</div>
		<div class="container">
			<div class="row">
				<cfif $.getContentId() eq'3260A275-1CC1-DE6E-2F483A9EA3549DBC'>
					<cfset thisClass = 'col-md-10 col-md-offset-1 col-sm-12 col-xs-12 content' />
				<cfelseif $.getContentId() eq '657E28E4-1CC1-DE6E-2F261063DCF1B998'>
					<cfset thisClass = 'col-xs-12 content' />
				<cfelse>
					<cfset thisClass = 'col-md-12 col-sm-12 col-xs-12 content' />
				</cfif>
				<section class="#thisClass#">
					#$.dspBody(
						body=$.content('body')
						, pageTitle=''
						, crumbList=false
						, showMetaImage=false
						, metaImageClass='thumbnail'
					)#
					<div class="row col-xs-12">
						#$.dspObjects(2)#
					</div>
				</section>
			</div><!--- /.row --->
		</div><!--- /.container --->

			<!--- Above Footer Objects --->
			<div id="aboveFooter">
				<div class="container">
					<cfif $.getParentId() eq '85D715F4-1CC1-DE6E-2F48C6B0E8FF59E0'>
						<h4 class="members-title">MEMBERS</h4>
						<div class="col-xs-12 col-sm-8 col-sm-offset-2 members-listing">
							#$.dspObjects(5)#
						</div>
					<cfelse>
						#$.dspObjects(5)#
					</cfif>
				</div>
			</div>

	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
	<script src="#$.siteConfig('assetPath')#/jquery/CustomSearch.js"></script>
</cfoutput>