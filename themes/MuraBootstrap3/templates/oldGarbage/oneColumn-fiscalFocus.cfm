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

				<cfset ffArticles = $.getFiscalFocusArticles() />
<!--- 				<cfdump var="#ffArticles.getRecordCount()#" label="Iterator Index Count">
				<cfdump var="#ffArticles.currentIndex()#" label="Interator Current Index"> --->

				<!-- START FISCAL -->
				<div id="fiscal">
					<div class="container">

						<div class="row">
	                      <div class="col-sm-9 col-sm-offset-1">
	                        <div class="row">
	                              <div class="col-sm-11 col-sm-offset-1">
	                                <h1 style="font-size:1.8em;">Fiscal Focus</h1>
	                                <hr>
	                              </div>
	                          </div>
	                      </div>
	                    </div>

						<div class="row">
							<div class="col-sm-9 col-sm-offset-1">
								<cfset artCounter = 0 />
                               
								<cfloop condition="#ffArticles.hasNext()#">
                                
									<cfset artCounter++ />
									<cfset art = ffArticles.next() />
                                   
									<!--- is this the first item - yes
									show more details --->
									<cfif ffArticles.currentIndex() eq 1>
										<div class="row">
											<div class="col-sm-11 col-sm-offset-1">
												<h3>#art.getTitle()#</h3>
                                                
												<div class="date">
													#dateformat(art.getReleaseDate(), 'long' )#
												</div>
												#art.getBody()#
												<div class="row" style="margin-bottom:10px;">
													<div class="col-sm-5">
														<div class="social">
															<!-- AddThis Button BEGIN -->
															<div class="addthis_toolbox addthis_default_style " style="text-align:center">
															<a class="addthis_button_preferred_1"></a>
															<a class="addthis_button_preferred_2"></a>
															<a class="addthis_button_preferred_3"></a>
															<a class="addthis_button_preferred_4"></a>
															<a class="addthis_button_compact"></a>
															<a class="addthis_counter addthis_bubble_style"></a>
															</div> 
															<script type="text/javascript">var addthis_config = {"data_track_addressbar":true};</script>
															<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js##pubid=ra-52434f13732a2f77"></script> 
															<script type="text/javascript">
															var addthis_config = addthis_config||{};
															    addthis_config.data_track_addressbar = false;
															    addthis_config.data_track_clickback = false;
															</script>

															<!-- AddThis Button END -->
														</div> 
													
													</div>

													<div class="col-sm-7">
														<!--- <div class="tag">
															<!--- <span style="color: black;">Tags:</span>
																<cfloop list="#$.getTags()#" index="tag">
																	#tag#
																</cfloop> --->

															<cfloop from="1" to="#ListLen(art.getTags())#" index="t">
																<a href="#$.content().getURL(queryString='tag=#URLEncodedFormat(trim(ListGetAt(art.getTags(),t)))#')#"<cfif trim($.event('tag')) eq trim(ListGetAt(art.getTags(), t))> class="current"</cfif>>#HTMLEditFormat(trim(ListGetAt(art.getTags(), t)))#</a><cfif t neq ListLen(art.getTags())>, </cfif>
															</cfloop>
														</div> --->
													</div>
												</div>
										</div>
									<cfelse>
										<cfif ffArticles.currentIndex() eq 2 or $.event('startRow') gt 5>
											<div class="list">
												<ul>
										</cfif>
													<li>
														<div class="date">
															#dateformat( art.getReleaseDate(), 'long' )#
														</div>
														<h4><a href="#art.getURL()#">#art.getTitle()#</a></h4>
													</li>
										<cfif ffArticles.currentIndex() mod 5 eq 0 or ffArticles.currentIndex() eq ffArticles.getRecordCount()>
												</ul>
											</div>
										</cfif>
									</cfif>
								</cfloop>
							</div>

							<div class="row">
								<div class="col-sm-4 col-xs-4">
									<!--- <a class="valign text-primary" href="/#$.getFileName()#/archives"><strong>Archives</strong></a>--->
								</div>

								<div class="col-sm-8 col-xs-8 align-right">
									
									<cfset prevStartRow = $.event('startRow')-5 />
									<cfif prevStartRow lte 0>
										<cfset prevStartRow = 1 />
									</cfif>

									<cfif $.event('startRow') gte 5>
										<a class="valign btn btn-success" href="/index.cfm/#$.getURL()#/?startRow=#prevStartRow#">&lt;&lt; Previous</a>
									</cfif>

									<cfset nextStartRow = $.event('startRow')+5 />
									<cfif nextStartRow gt ffArticles.getRecordCount()>
										<cfset nextStartRow = ffArticles.getRecordCount() />
									</cfif>

									<cfif ffArticles.currentIndex() neq ffArticles.getRecordCount()>
										<a class="valign btn btn-success" href="/index.cfm/#$.getURL()#/?startRow=#nextStartRow#">Next &gt;&gt;</a>
									</cfif>
								</div>
							</div>						

						</div>	
					</div>
				</div>	
                </div>	
				<!-- END FISCAL -->

			<!-- END CONTENT -->
		
			<cfinclude template="inc/footer.cfm" />
		</div>
</body>
<cfinclude template="inc/html_foot.cfm" />

</cfoutput>