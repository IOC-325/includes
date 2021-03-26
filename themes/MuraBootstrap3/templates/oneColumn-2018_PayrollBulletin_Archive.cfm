
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
						<P>Date: #dateformat($.content('payrollBulletinDate'),'m/d/yyyy')#</p>
						<p>Number: #$.content('payrollBulletinNumber')#</p>
						<!--- Call helper method getKidsIterator, and see if we get any children --->
						<cfset iterator = $.content().getKidsIterator() /> 
						<cfif iterator.getRecordCount()>
							<!--- If there are children, loop through them. There should only be one. --->
							<cfloop condition="iterator.hasNext()">
								<cfset item=iterator.next()>
								<p>File: 
								<cfif $.content('payrollBulletinPDF') neq "">
									<!--- If you get here, it means there may be a child, but they may have placed a pdf in the parent, so render parent pdf instead --->
									<a href="/comptroller/cache/file/#$.content('payrollBulletinPDF')#.pdf">Download</a></p>
								<cfelse>
									<!--- get the child PDF file using item.getfunction and passing in FileID. How did I know about FileID? Do a dump on item and see the methods--->
									<a href="/comptroller/cache/file/#item.get('FileID')#.pdf">Download</a>
								</cfif>
								</p>
							</cfloop>
						<cfelse>
							<!--- If there is no child, then display pdf in custom class --->
							<p>File: <a href="/comptroller/cache/file/#$.content('payrollBulletinPDF')#.pdf">Download</a></p>
						</cfif>
					</div>
					
					<!---/Body --->
				
				</cfoutput>
			</section>
		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>