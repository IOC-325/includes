<cfset kidsIterator = $.content().getKidsIterator() />
<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />
		<cfinclude template="inc/pageTitle.cfm" />
		<div class="container">
			<div class="row" style="border-left:1px blue;">
				<section class="col-md-10 col-md-offset-1 col-sm-12 col-xs-12 content">

					<cfloop condition="#kidsIterator.hasNext()#">
						<cfset kid = kidsIterator.next() />
						<div class="col-xs-12 col-sm-6 item-container">

							<div 
								class="item-image" 
								data-title="#REReplaceNoCase( 
									kid.getSummary(), 
									'<[^>]*(?:>|$)', 
									'', 
									'ALL')#">
								<a href="#kid.getURL()#"
									<cfif kid.getTitle() eq 'Find My Refund'>
										target="_blank"
									</cfif> >
									<img 
										src="#kid.getImageURL(size='large')#"
										title="#kid.getTitle()#"
										alt="#kid.getTitle()#"
										width="100%" />
								</a>
							</div>
							<div class="item-title">
								<a href="#kid.getURL()#">#kid.getTitle()#</a>
							</div>
						</div>
						
					</cfloop>
					
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