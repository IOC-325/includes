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

					<div><nav aria-label="You are here:" role="navigation">#$.dspCrumbListLinks()#</nav></div>

					<cfif $.content( 'hidePageTitle' ) neq 'yes'>

						<cfif structKeyExists( variables, "img" )>
							<h1 class="mura-page-title pageTitle">
									<img src="#img#" style="margin-right: 14px; width:110px;"><span>#m.renderEditableAttribute(attribute='title')#</span>
							</h1>
						<cfelse>
							<h1 class="mura-page-title pageTitle">
							<span>#m.renderEditableAttribute(attribute='title')#</span>
							</h1>
						</cfif>
					</cfif>


					<!--- Body --->
						<div class="mura-body">
							<cfset kidsIterator = $.content().getKidsIterator() /><!---sortOrder='asc'--->
							<cfset kidsiterator.setNextN(0)>
							<cfloop condition="#kidsIterator.hasNext()#">
								<cfset kid = kidsIterator.next() />
								<div class="row row-eq-height margintopbottom">
									<div class = "col-xs-12 col-sm-3 animal-shelters-image">
										<a href="#kid.getURL()#">
											<img
												src="#kid.getImageURL(size='critterListImage')#"
												title="#kid.getTitle()#"
												alt="#kid.getTitle()#"
												 />
										</a>
									</div>
									<div class="col-xs-12 col-sm-9">
										<div class="animal-shelters">
											<h4><a href="#kid.getURL()#">#kid.getTitle()#</a></h4>
											<p class="text-success">#kid.getSummary()#</p>
                                		</div>
									</div>
								</div>
							</cfloop>
						</div>
					<!--- /Body --->

				</cfoutput>
			</section>
		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>