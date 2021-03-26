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
										size = 'medium' // small, medium, large, custom, or any other pre-defined image size
										,complete = false // set to true to include the entire URL, not just the absolute path (default)
									);
								</cfscript>

							</cfif>
						<!--- /Primary Associated Image --->
						
						<cfif $.content( 'hidePageTitle' ) neq 'yes'>
						
							<cfif structKeyExists( variables, "img" )>
								<h1 class="mura-page-title pageTitle">
										<img src="#img#" style="margin-right: 14px; width:110px"><span>#m.renderEditableAttribute(attribute='title')#</span>
								</h1>
							<cfelse>
								<h1 class="mura-page-title pageTitle">
								<span>#m.renderEditableAttribute(attribute='title')#</span>
								</h1>
							</cfif>
						</cfif>
			

							<div class="mura-body">
								
								<cfset variables.blogContent = $.getBean('content').loadby( contentId = 'EBF696C5-5056-93B5-5E0BBD4823C3C6B9' ) />
								#variables.blogContent.getSummary()#
								
								<a href="#variables.blogContent.getURL()#" style="color: grey; font-weight: bold; font-family: 'AvenirBold'; text-transform: uppercase;">Read More <i class="fa fa-caret-down" aria-hidden="true"></i></a>
								
								#$.renderEditableAttribute(attribute="body",type="htmlEditor")#
							</div>
	
						<!--- /Body --->
							
					</cfoutput>


				</section>
		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>