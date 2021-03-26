<cfoutput>
	<cfinclude template="inc/html_head_2018.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<cfinclude template="inc/navbar_2018.cfm" />

		<div class="container">
				<section class="content">
					<!--- 
							The Content
							See the file located under '/display_objects/page_default/index.cfm' to override body styling
					--->
					<cfoutput>
						<!--- Primary Associated Image --->
							<cfif $.content().hasImage(usePlaceholder=false)>
								<cfscript>
									img = $.content().getImageURL(
										size = 'large' // small, medium, large, custom, or any other pre-defined image size
										,complete = false // set to true to include the entire URL, not just the absolute path (default)
									);
								</cfscript>
							</cfif>
						<!--- /Primary Associated Image --->
						
						<cfset variables.parentNode = $.getBean('content').loadBy( $.content().getParentId() ) />
						
						<div><nav aria-label="You are here:" role="navigation">#$.dspCrumbListLinks()#</nav></div>
						
						<cfif $.content( 'hidePageTitle' ) neq 'yes'>
							<h1 class="mura-page-title pageTitle">
							<span>#variables.parentNode.getTitle()# > #m.renderEditableAttribute(attribute='title')#</span>
							</h1>
						</cfif>
			
						<div class="mura-body">
										#$.renderEditableAttribute(attribute="body",type="htmlEditor")#
								<div class="row">
									<div class="col-sm-6">
										<h2 class="text-center">ADOPT ME</h2>
										<img src="#img#" class="center-block" />
									</div>
									
									
									<div class="col-sm-6">
										<div class="animal-map">
										<cfajaximport params="#{googlemapkey='AIzaSyBgj8BKO0zwwS2ofMGXYP8mKYkEXDJvGik'}#">
										<cfmap
										  name="mainMap"
										  centeraddress="#variables.parentNode.getStreetAddress()#, #variables.parentNode.getCity()#, #variables.parentNode.getState()# #variables.parentNode.getZip()#"
										  zoomlevel="14"
										  width="340"
										  height="240"
										/>
                						</div>
										<p class="margintop">
											#variables.parentNode.getTitle()#<br/>
											#variables.parentNode.getStreetAddress()#<br/>
											#variables.parentNode.getCity()#, #variables.parentNode.getState()# #variables.parentNode.getZip()#<br/>
											#variables.parentNode.getPhone()#<br/>
											#variables.parentNode.getWebsite()#<br/>
											#variables.parentNode.getEmail()#</p>
									</div>
								</div>
						</div>
						<!--- /Body --->
					</cfoutput>
				</section>
		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>