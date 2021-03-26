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
				<section class="col-md-10 col-md-offset-1 col-sm-12 col-xs-12 content">
					<cfif $.content('fileExt') neq 'png'>
						<img class="center-block" style="margin-bottom: 20px;" src="#$.getURLForImage(fileId = $.content('fileId'), size='large')#">
					</cfif>
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
					#$.dspObjects(5)#
				</div>
			</div>
		
	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>