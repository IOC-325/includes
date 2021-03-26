<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />
		<cfinclude template="inc/pageTitle.cfm" />
		<!--- Above Content Objects --->
		<div id="aboveContent">
			#$.dspObjects(4)#
		</div>
		<div class="container">
			<div class="row">
				<section class="col-lg-9 col-md-9 col-sm-8 col-xs-12 content">
					<div class="article-heading">
						<h2 class="pageTitle">#$.content('title')#</h2>
						<cfif len($.content('releaseDate'))><p class="pull-left pub-date">Posted on #dateTimeFormat($.content('releaseDate'),"mm/dd/yyyy")# </p></cfif>
						<cfif len($.content('credits'))><p class="pull-left pub-credits"> by #$.content('credits')#</p></cfif>
					</div>
					<div class="thumbnail">
						<img src="#$.content().getImageURL(width=1000,height=365)#">
					</div>
					#$.dspBody(
						body=$.content('body')
						, pageTitle=''
						, crumbList=false
						, showMetaImage=false
						, metaImageClass='thumbnail'
					)#
					#$.dspObjects(2)#
				</section>
				<aside class="col-lg-3 col-md-3 col-sm-4 col-xs-12 sidebar">
					#$.dspObjects(3)#
				</aside>
			</div><!--- /.row --->
			<!--- Above Footer Objects --->
			<div id="aboveFooter" class="row">
				#$.dspObjects(5)#
			</div>
		</div><!--- /.container --->
	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>