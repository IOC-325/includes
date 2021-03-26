<!-- START EXPENSE -->
<cfoutput>
	<div id="expense" class="report">
			<div class="row">
				<div class="col-md-10 col-md-offset-1">
					<!--- <h1>#$.getTitle()#.</h1> --->
					#$.getSummary()# 

								<ul class="list-it">
									
									<cfset variables.getReports = $.getKidsQuery() />
									<cfloop query="#variables.getReports#">
										<li><a class="report-link active" target="_blank" href="/#getReports.filename#">#getReports.title#</a></li>
									</cfloop>

								</ul>

				</div> <!--- // end col-md-10 --->
			</div> <!--- // end row --->	
	</div> <!--- // end expense --->
</cfoutput>
	<!-- END EXPENSE -->