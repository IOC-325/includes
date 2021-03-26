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
						<!--- /Primary Associated Image--->
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

						<!--- <cfif m.getTitle() eq "Employment"><h2>Employment Opportunities</h2></cfif> --->

						<!--- Body --->
                        <div class="mura-body">
                                <cfloop condition="#variables.itItems.hasNext()#">
                                    <cfset variables.item = variables.itItems.next() />
                                    <h3>
                                        <a href="#variables.item.getURL()#">#variables.item.getTitle()#</a>
                                    </h3>
                                    <cfif variables.item.getValue('summary') NEQ "">
                                        <p>
                                            #variables.item.getValue('summary')#
                                        </p>
                                    </cfif>
                                </cfloop>
                            #$.renderEditableAttribute(attribute="body",type="htmlEditor")#
                        </div>
						<!--- /Body --->
					</cfoutput>
				</section>
		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>