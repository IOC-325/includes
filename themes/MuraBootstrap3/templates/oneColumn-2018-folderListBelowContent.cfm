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

						<cfif structKeyExists( variables, "img" )>
							<h1 class="mura-page-title pageTitle">
									<img src="#img#" style="margin-right: 14px; width:110px;"><span>#m.renderEditableAttribute(attribute='title')#</span>
							</h1>
						<cfelse>
							<h1 class="mura-page-title pageTitle">
							<span>#m.renderEditableAttribute(attribute='title')#</span>
							</h1>
						</cfif>

						<!--- News Only Tempate --->
						<cfset variables.itItems = $.content().getKidsIterator() />
						<cfset variables.itItems.setNextN( 0 ) />

						<!--- Body --->
							<div class="mura-body">
								#$.renderEditableAttribute(attribute="body",type="htmlEditor")#
                                <div class="row">
								<div class="col-sm-10 col-sm-offset-1">
									<cfloop condition="#variables.itItems.hasNext()#">
										
										<cfset variables.item = variables.itItems.next() />
											
										<p>
											<a href="#variables.item.getURL()#" target="_blank">#variables.item.getTitle()#</a>
										</p>				

									</cfloop>
								</div>
								</div>
                                <p class="margintop">&nbsp;</p>
                                <div class="mura-async-object mura-object mura-object-select" data-async="true" data-class="" data-cssclass="" data-inited="true" data-instanceid="53C0CFBE-E366-4D8E-B82CA48ACCB0918B" data-object="component" data-objecticonclass="mi-clone" data-objectid="61066B9D-5056-93B5-5E25DD883DD4947B" data-objectname="Component">&nbsp;</div>
							</div>

						<!--- /Body --->

					</cfoutput>
				</section>

		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>