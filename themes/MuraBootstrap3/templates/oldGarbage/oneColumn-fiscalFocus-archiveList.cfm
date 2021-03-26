<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<div id="layout">
			<cfinclude template="inc/navbar.cfm" />

			<!-- START SUBMENU -->
			<cfset getSubNav = $.getSubNav() />
			<div id="submenu" class="hidden-xs">
				<div class="container">
					<ul>
						#getSubNav#
					</ul>
				</div>
			</div>
			<!-- END SUBMENU -->

			<!-- START CONTENT -->
			<!-- START ARCHIVE -->
				<div id="archive">
					<div class="container">
						<div class="row">
							<div class="col-sm-8 col-sm-offset-2">				
								<h1>Archives</h1>

								<cfset ffArticles = $.getFiscalFocusArchiveArticles() />
								<cfset currentArticleDate = "" />
								<cfset previousArticleDate = "" />

								<cfloop condition="#ffArticles.hasNext()#">
									<cfset art = ffArticles.next() />
									<cfset previousArticleDate = dateformat(currentArticleDate, 'mm/yy') />
									<cfset currentArticleDate = dateformat(art.getReleaseDate(), 'mm/yy') />
									
									<cfif previousArticleDate neq currentArticleDate>

										<cfif ffArticles.currentIndex() neq 1>
												</ul>
											</div>
										</cfif>

										<div class="block">
											<div class="date">
												#dateformat(currentArticleDate, 'mmmm yyyy')#
											</div>
											<ul>
										</cfif>

										<li>
											<span class="num">#dateformat( art.getReleaseDate(), 'dd' )#:</span> 
											<a href="#art.getURL()#">
												#art.getTitle()#
											</a>
										</li>

								
									

									<cfif ffArticles.currentIndex() eq ffArticles.getRecordCount()>
											</ul>
										</div>
									</cfif>

								</cfloop>
								<!--- 				
									<cfdump var="#ffArticles.getRecordCount()#" label="Iterator Index Count">
									<cfdump var="#ffArticles.currentIndex()#" label="Interator Current Index"> 
								--->

							</div>	
						</div>
					</div>
				</div>	
					<!-- END ARCHIVE -->



			<!-- END CONTENT -->

			<cfinclude template="inc/footer.cfm" />
		</div>
	</body>
	<cfinclude template="inc/html_foot.cfm" />

</cfoutput>