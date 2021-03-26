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
			<h2 class="large-page-header" style="text-align: center;">#$.getTitle()#</h3>
		</cfif>
		
		<!--- Above Content Objects --->
		<div id="aboveContent">
			#$.dspObjects(4)#
		</div>
		<div class="container">
			<div class="row">
				<section class="col-md-8 col-md-offset-2 col-sm-12 col-xs-12 content">
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

		<div class="blue-callout">
				<cfset initCallout = $.getBean('content').loadBy(contentid='89D7499D-5056-93B5-5ECB14B300C74694') />
			<div class="container">
				<div class="col-xs-12 col-sm-8 col-sm-offset-2 blue-callout-interior">
					#initCallout.getBody()#
				</div>
			</div>

		</div>
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
</cfoutput>