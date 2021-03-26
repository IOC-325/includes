<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar2.cfm" />
		<cfinclude template="inc/pageTitle.cfm" />
		<!--- Above Content Objects --->
		<div id="aboveContent">
			#$.dspObjects(4)#
		</div>
		<div class="container">
			<div class="row">
				<section class="content col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<nav>#$.dspCrumbListLinks(id='',class='breadcrumb',separator='>  ')#</nav>

					<!--- Success message for Subscription (or other) signup --->
					<cfif isDefined("URL.msg")>
				       <div class="alert alert-success">
				        <a href="" class="close" data-dismiss="alert">&times;</a>
				        <strong>Success!</strong> Your message has been sent successfully.
				       </div>
				      </cfif>
					<!--- /success --->
					<div class="paragraph" style="border-left: 6px solid ##2b8695; padding-left:10px;  margin-bottom:25px; margin-left:40px; padding-bottom:20px;">
					<h1 class="pageTitle">#ucase($.content('title'))#</h1>

					#$.dspBody(body=$.content('body'),pageTitle='',crumbList=0,showMetaImage=1,metaImageClass='thumbnail')#

					</div>
					#$.dspObjects(2)#
				</section>
			</div>
			<!--- Above Footer Objects --->
			<div id="aboveFooter" class="row">
				#$.dspObjects(5)#
			</div>
		</div><!-- /.container -->
	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>