
<cfoutput>
	<cfinclude template="inc/html_head_critters.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<!---  <cfinclude template="inc/home_page_navbar.cfm" />  --->
				<cfinclude template="inc/navbar.cfm" />		
				<cfinclude template="inc/pageTitleCritters.cfm" />
		
		<div class="container">
			<div class="row">
				<section class="col-lg-12 col-md-12 col-sm-12 col-xs-12 content">
					

					<!--- <h1 class="pageTitle">#ucase($.content('title'))#</h1> --->
 					<cfinclude template="/comptroller/includes/display_objects/custom/dsp_custom_critter_search.cfm">

					#$.dspCritterBody(body=$.content('body'),pageTitle='',crumbList=0,showMetaImage=0,metaImageClass='thumbnail')#

					#$.dspObjects(2)#

					
				</section>
			</div><!--- // row --->
		
		<!--- Dogs Slider --->
			<DIV class="container" style="background-color:silver;">
				<DIV CLASS="row">
<!--- 					<div class="col-md-1">&nbsp;</div> --->
					<div class="col-md-12">
						<h2 style="text-align:center;">ADOPTABLE DOGS</h2>
						<div class="container">
							#$.dspBxSlider(feed='Dogs')#
						</div>  <!--- / container --->
				</div>
<!--- 				<div class="col-md-1">&nbsp;</div> --->
				</DIV>
			</DIV>

<!--- / container --->

		<!--- Cats Slider --->
		<DIV class="container" style="background-color:##58595b;">
			<h2 style="color:white; text-align:center;">ADOPTABLE CATS</h2>
			<div class="container">
				#$.dspBxSlider(feed='Cats')#
			</div>  <!--- / container --->
		</DIV>

		<DIV class="container" style="background-color:##414042;">
			<h2 style="color:white; text-align:center;">OTHER CRITTERS</h2>
			<div class="container">
				#$.dspBxSlider(feed='Other Critters')#
			</div>  <!--- / container --->
		</div>

		<!--- Above Footer Objects 
			<div class="primary">
				<div class="container center">
				#$.dspObjects(15)#
				</div>
			</div>
--->

		</div><!--- / container --->			
	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>