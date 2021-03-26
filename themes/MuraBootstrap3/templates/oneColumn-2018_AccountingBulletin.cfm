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
						#$.renderEditableAttribute(attribute="body",type="htmlEditor")#
						<P>Date: #dateformat($.content('accountingBulletinDate'),'m/d/yyyy')#</p>
						<p>Number: #$.content('accountingBulletinNumber')#</p>
						 <cfset variables.itItems = $.content().getKidsIterator() />
						 <cfset variables.item = variables.itItems.next() />
						 <p>Click <a style="color: gray;white-space: normal;" href="#variables.item.getURL()#">here</a> for file</p>
					</div>
					<!---/Body --->
				</cfoutput>
			</section>
		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>