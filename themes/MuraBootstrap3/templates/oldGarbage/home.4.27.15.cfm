<cfsetting showdebugoutput="true">
<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<!---  <cfinclude template="inc/home_page_navbar.cfm" />  --->
				<cfinclude template="inc/navbar.cfm" />
		<cfif $.content('heroType') eq "Slider">
			<!---
				The Carousel/Slideshow
				Refer to the theme's contentRenderer.cfc for details on this method and its arguments/options
				NOTES:
					* This theme is designed for Mura 6.1+
					* Only content items with an 'Associated Image' will be rendered
					* You can control the crop of the carousel image by using the custom defined 'carouselimage' image size // 'carouselimage'
			--->

			#$.dspCarouselByFeedName(
				feedName=$.content('feedName')
				, showCaption=true
				, cssID='myCarousel'
				, size='source'
				, interval=5000
				, autoStart=true
			)#
		<cfelseif $.content('heroType') eq "Static">

			<!--- Static Hero Banner --->
				<div class="hero">
					<div class="container hero-content">
						#$.dspObject('component','[Home] Banner Text')#
					</div><!--- // hero-content --->

					<!--- Hero-Search --->
						<!--- Let's try to put search feature here --->
     <div class="searchwellContainer">
			              <form id="" class="navbar-form" role="search">
								<!--- <i class="fa fa-search"></i> --->
								<div class="input-group">
									<input type="text" name="Keywords" id="txtKeywords" class="form-control" value="#HTMLEditFormat($.event('keywords'))#" placeholder="#$.rbKey('search.search')#">
									<span class="input-group-btn">
										<button type="submit" class="btn btn-primary">GO</button>
									</span>
								</div>
								<input type="hidden" name="display" value="search">
								<input type="hidden" name="newSearch" value="true">
								<input type="hidden" name="noCache" value="1">
							</form>

     </div>
						<!--- // hero-search --->
				</div>

			<!--- // Static Hero --->
		<cfelse>

		<!--- No content --->

		</cfif>

		<div class="container">
			<div class="row">
				<section class="col-lg-12 col-md-12 col-sm-12 col-xs-12 content">
					<!--- The content --->
					#$.dspBody(
						body=$.content('body')
						, pageTitle=''
						, crumbList=false
						, showMetaImage=false
					)#
					<!--- Display Objects assigned to display region 2 (Main Content) --->
					#$.dspObjects(2)#
				</section>
			</div><!--- // row --->
		</div><!--- / container --->

		<!--- Blog Feed --->
		<div class="feed-wrapper">
			<div class="container blog-feed">
				<div class="row">
					<h2 class="col-md-12 center">News Updates</h2>
				</div>
				<div class="row">
					#$.dspObject('feed','From Our Blog')#
				</div>
				<div class="row">
					<div class="col-md-12 center"><a href="#$.createHREF(filename='blog')#" class="btn btn-lg btn-primary">View All News Releases</a></div>
				</div>
			</div><!--- // container --->
		</div><!--- // feed-wrapper --->

		<!--- Testimonial Slider ---><!--- <h5>Most Recent Updates (because there is no feed called 'testimonials'</h5> --->
			<div class="container testimonials">
				#$.dspBxSlider(feed='Critter Updates')#
			</div> <!--- / container --->

		<!--- Above Footer Objects --->
			<div class="primary">
				<div class="container center">
				#$.dspObjects(15)#
				</div>
			</div>
	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>