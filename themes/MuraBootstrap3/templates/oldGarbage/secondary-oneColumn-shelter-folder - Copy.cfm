<!--- SR 17057 --->
<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />


			  <cfinclude template="inc/pageTitle.cfm" />
<br/>


<div class="col-xs-12 col-md-offset-3 col-md-6">#$.dspCrumbListLinks("crumbList")#</div>
<!--- 			#$.dspBody(
						body=$.content('body')
						, pageTitle=''
						, crumbList=true
						, showMetaImage=false
						, metaImageClass=''
					)# --->



		<!--- Above Content Objects --->
		<div id="aboveContent">
			#$.dspObjects(4)#
		</div>
		<div class="container">
			<div class="row">
				<cfif $.getContentId() eq'3260A275-1CC1-DE6E-2F483A9EA3549DBC'>
					<cfset thisClass = 'col-md-10 col-md-offset-1 col-sm-12 col-xs-12 content' />
				<cfelseif $.getContentId() eq '657E28E4-1CC1-DE6E-2F261063DCF1B998' >
					<cfset thisClass = 'col-xs-12 content' />
				<cfelseif $.getContentId() eq '64DE0A13-1CC1-DE6E-2F2676D3AA6A7E52'>
					<cfset thisClass = 'col-md-8 col-sm-12 col-xs-12 content' />
				<cfelse>
					<cfset thisClass = 'col-md-8 col-md-offset-2 col-sm-12 col-xs-12 content' />
				</cfif>
				<section class="#thisClass#">
					<!--- #$.dspBody(
						body=$.content('body')
						, pageTitle=''
						, crumbList=false
						, showMetaImage=false
						, metaImageClass='thumbnail'
					)# --->

					<!--- <h2>A list of the Current Shelters</h2> --->

					<cfset kidsIterator = $.content().getKidsIterator() />
					<cfloop condition="#kidsIterator.hasNext()#">
						<cfset kid = kidsIterator.next() />
						<div class = "col-xs-12 col-sm-3">
							<a href="#kid.getURL()#">
								<img
									src="#kid.getImageURL(size='critterListImage')#"
									title="#kid.getTitle()#"
									alt="#kid.getTitle()#"

									style="float:left; padding:10px;" />
							</a>
						</div>
						<div class="col-xs-12 col-sm-9">
							<h4><a href="#kid.getURL()#">#kid.getTitle()#</a></h4>
							<p>#kid.getSummary()#</p>
							<hr />
						</div>
					</cfloop>
					<div class="row col-xs-12">
						#$.dspObjects(2)#
					</div>

				</section>
		</div><!--- /.row --->
		</div><!--- /.container --->

			<!--- Above Footer Objects --->
			<div id="aboveFooter">
				<div class="container">
					<cfif $.getParentId() eq '85D715F4-1CC1-DE6E-2F48C6B0E8FF59E0'>
						<h4 class="members-title">MEMBERS</h4>
						<div class="col-xs-12 col-sm-8 col-sm-offset-2 members-listing">
							#$.dspObjects(5)#
						</div>
					<cfelse>
						#$.dspObjects(5)#
					</cfif>
				</div>
			</div>

	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
	<script src="#$.siteConfig('assetPath')#/jquery/CustomSearch.js"></script>
</cfoutput>
