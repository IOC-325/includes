<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />
		<h3 style="text-transform: uppercase; text-align: center;">#$.getTitle()#</h3>
		
		<!--- Above Content Objects --->
		<div id="aboveContent">
			#$.dspObjects(4)#
		</div>
		<div class="container">
			<div class="row">
				
				<section class="col-md-8 col-md-offset-2 col-sm-12 col-xs-12 content">
					<img src="#$.getURLForImage(fileId = $.content('fileId'), size='large')#" class="news-image" />
					#$.dspBody(
						body=$.content('body')
						, pageTitle=''
						, crumbList=false
						, showMetaImage=false
						, metaImageClass='thumbnail'
					)#
					<cfinclude template="/CommonCode/addThis.cfm"/>								
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
</cfoutput>