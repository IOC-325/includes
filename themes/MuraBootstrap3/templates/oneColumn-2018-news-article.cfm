<cfoutput>
	<cfinclude template="inc/html_head_2018.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<cfinclude template="inc/navbar_2018.cfm" />

		<div class="container">
			<div class="row">
				<section class="col-sm-10 col-sm-offset-1 content" style="margin-bottom: 14px;">
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
						
							<h1 class="mura-page-title pageTitle">
							<span>#m.renderEditableAttribute(attribute='title')#</span>
							</h1>
							

						<!--- Body --->
							<div class="mura-body">
								<hr style="margin-top: 20px;" />
								#$.renderEditableAttribute(attribute="body",type="htmlEditor")#
								<hr style="margin-bottom: 20px;" />
								<img src="#img#" class="center-block">
							</div>
						<!--- /Body --->

					</cfoutput>


				</section>
			</div>
		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>