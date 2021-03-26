<cfsetting showdebugoutput="true">
<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<!---  <cfinclude template="inc/home_page_navbar.cfm" />  --->
		<cfinclude template="inc/navbar_home.cfm" />
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
				, showCaption=trueplease
				, cssID='myCarousel'
				, size='source'
				, interval=5000
				, autoStart=true
			)#
		<cfelseif $.content('heroType') eq "Static">

			<!--- Static Hero Banner --->
				<div>


     			<div class="searchwellContainer">
     				<div class="container">
	     				<div class="transbox row">
	     					<div class="col-sm-4">
	     					<p class="search-text hidden-xs pull-right">Looking for something specific?</p>
	     					</div>
	     					<div class="col-xs-12 col-sm-8">
	
								<cfinclude template="/GoogleCSE_1.cfm">

								</div>
	     				</div>
	     			</div>


     			</div>
						<!--- // hero-search --->
				</div>

			<!--- // Static Hero --->
		<cfelse>

		<!--- No content --->

		</cfif>

		<div class="container">
			<div class="row">
				</cfoutput>
						<style>
			
			.date{    padding-bottom: 40px;
    text-transform: uppercase;
    font-size: 27px;
    font-weight: 700;
				text-align: center;
			}
			
			
			.amount {
    font-size: 45px;
    font-weight: 900;
}
		
		.btn {
    padding: 10px;
    font-size: 17px;
    font-weight: 600;
    text-transform: uppercase;
    border-radius: 0;
    -moz-border-radius: 0;
    -webkit-border-radius: 0;
    box-shadow: 1px 1px 1px rgba(0,0,0,0.9);
    -webkit-box-shadow: 1px 1px 1px rgba(0,0,0,0.9);
}
/*bootstrap.min.css:14*/
.btn-default {
    color: #333;
    background-color: #82B1FF;
    border-color: #ccc;
}
/*bootstrap.min.css:14*/
.btn {
    display: inline-block;
    margin-bottom: 0;
    /*font-weight: normal;*/
    text-align: center;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    background-image: none;
    /*border: 1px solid transparent;*/
    white-space: nowrap;
    /*padding: 6px 12px;*/
    /*font-size: 14px;*/
    line-height: 1.42857143;
    border-radius: 4px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}
		
		
		</style>
			<div class="row">

				<!--- Website Offline? Make mention here. --->
				<!--- <p>Please note that the website will be offline for a short time due to routine maintenance over the weekend. We apologize for the inconvenience and appreciate your patience!</p> --->

				<cfinclude template="/ledger/includes/themes/TheLedger/display_objects/custom/fiscal-condition/BVREditable.cfm">
					</div>
					<cfoutput>			
				#$.dspObject('component', '[Home] - BVR')#
				

				<section class="col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1 col-sm-12 col-xs-12 content">
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
					<h4 class="text-center" style="color: ##fff; font-weight: bold;">LATEST NEWS</h4>
     <!--- <div class="col-xs-12 col-sm-3 col-sm-offset-1"></div> --->
					#$.dspObject('feed','From Our Blog')#
				</div>
				<div class="row">
					<div class="col-xs-12 center text-center">
						<a href="#$.createHREF(filename='news-portal')#"><strong>VIEW ALL NEWS RELEASES &raquo;</strong></a>
					</div>
				</div>
			</div><!--- // container --->
		</div><!--- // feed-wrapper --->

		<!--- Testimonial Slider ---><!--- <h5>Most Recent Updates (because there is no feed called 'testimonials'</h5> --->
			<!--- <div class="container">
			<!--- 	#$.dspBxSlider(feed='Dogs')#
 --->			</div> ---> <!--- / container --->

	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
	<script src="#$.siteConfig('assetPath')#/jquery/CustomSearch.js"></script>
</cfoutput>