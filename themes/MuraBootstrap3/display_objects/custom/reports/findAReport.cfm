<!-- START EXPENSE -->
<cfoutput>
	<div id="expense" class="report">
		<div class="container">
			<div class="row">	
				<div class="col-md-10 col-md-offset-1">
					<h1>#$.getTitle()#</h1>
					#$.getSummary()#
					<div class="searches">
						<div class="row">
							<div class="col-sm-12">
								<div class="advance">
									<ul class="c_accordion">
										<cfset variables.reportCategories = $.getKidsIterator() />
										<cfloop condition="#variables.reportCategories.hasNext()#">
											<cfset reportCategory = variables.reportCategories.next() />
											
											<li class="<cfif variables.reportCategories.getRecordIndex() eq 1>active</cfif>">
											<a href="##" class="opner">#reportCategory.getTitle()#</a>
												<div class="content">
													<ul>
														<cfset reportCategoryKids = reportCategory.getKidsIterator() />
														
														<cfloop condition="#reportCategoryKids.hasNext()#">
															<cfset reportCategoryKid = reportCategoryKids.next() />
															<cfset lightboxId = createUUID() />
															<li>
																<a href="#reportCategoryKid.getURL()#">
																	#reportCategoryKid.getTitle()#
																</a>
																<a href="##lightbox_#lightboxId#" class="tooltip-icon lightbox-link" data-toggle="tooltip" title="#replacenocase(replacenocase(reportCategoryKid.getSummary(), '</p>', ''), '<p>', '')#">?</a>
																<div class="lightbox" id="lightbox_#lightboxId#">
																	#reportCategoryKid.getSummary()#
																</div>
															</li>
														</cfloop>
													</ul>
												</div>
											</li>
										</cfloop>
									</ul>	<!--- // end c_accordion --->													
								</div> <!--- // end advance --->
							</div> <!--- // end col-sm-12 --->
						</div><!--- // end row --->
					</div> <!--- // end searches --->
				</div> <!--- // end col-md-10 --->
			</div> <!--- // end row --->	
		</div> <!--- // end container --->
	</div> <!--- // end expense --->
</cfoutput>
	<!-- END EXPENSE -->