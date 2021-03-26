<cfset kidsIterator = $.content().getKidsIterator() />
<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />
		<cfinclude template="inc/pageTitle.cfm" />
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

					<cfloop condition="#kidsIterator.hasNext()#">
						<cfset kid = kidsIterator.next() />
						<div class="col-xs-12 col-sm-6 item-container">
								<a href="#kid.getURL()#">
									<img 
										src="#kid.getImageURL(size='large')#"
										title="#kid.getTitle()#"
										alt="#kid.getTitle()#"
										width="100%" />
								</a>
							<div class="item-title">
								<a href="#kid.getURL()#">#kid.getTitle()#</a>
							</div>
						</div>
						
					</cfloop>

					<style>

						.item-container{
							margin-bottom: 20px;
						}

					  .item-title {
					  	background-color: ##BCAA61;
							text-align: center;
							padding: 5px 0px;
							margin: 0px;
							font-weight: bold;
					  }

						.item-title a{
							font-size: 12px;
							color: ##fff;
						}
						
					</style>
					
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