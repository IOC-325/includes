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

			<!-- START FISCAL -->
				<div id="fiscal"><!---  class="laypse" --->
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
								<div class="row">
									<div class="col-sm-11 col-sm-offset-1">
										<h1>#$.getTitle()#</h1>
										<div class="date">#dateformat( $.getReleaseDate(), 'long' )#</div>
										#$.getBody()#

										<div class="row">
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
<div class="tag">
	<!---<span style="color: black;">Tags:</span>
		 <cfloop list="#$.getTags()#" index="tag">
			#tag#


		</cfloop> --->

		<!--- <cfloop from="1" to="#ListLen($.getTags())#" index="t">
								<a href="#$.content().getURL(queryString='tag=#URLEncodedFormat(trim(ListGetAt($.getTags(),t)))#')#"<cfif trim($.event('tag')) eq trim(ListGetAt($.getTags(), t))> class="current"</cfif>>#HTMLEditFormat(trim(ListGetAt($.getTags(), t)))#</a><cfif t neq ListLen($.getTags())>, </cfif>
							</cfloop> --->
</div>
											</div>
										</div>

									</div>
								</div>
								<cfset rsRelated = $.content().getRelatedContentIterator()>
								<cfif rsRelated.getRecordCount() gt 0>
									<div class="list">
										<ul>
											<cfloop condition="#rsRelated.hasNext()#">
												<cfset rel = rsRelated.next() />
												<li>
													<cfif rsRelated.currentIndex() eq 1>
														<h4 class="text-info">Recommended</h4>
													</cfif>
													<div class="date">
														#dateformat( rel.getReleaseDate(), 'long' )#</div>
													<h4><a href="#rel.getURL()#">#rel.getTitle()#</a></h4>
												</li>
											</cfloop>
										</ul>
									</div> 
								</cfif>

								<!--- if in the archives section, don't show --->
								<cfif !listFind( $.getPath(),"29DDF64A-BFD3-4295-9DE2A7DB60350D62")>
									<div class="row">
										<div class="col-sm-11 col-sm-offset-1">
											<!--- <a class="valign text-primary" href="/index.cfm/archives"><strong>Archives</strong></a> --->
										</div>
									</div>
								</cfif>

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