<cfoutput>

		<!--- #$.content('body')# --->

		<cfset feedID=$.content().getContentID()>
		<cfset iterator=$.getBean("content").loadBy(contentid='#feedID#').getKidsIterator()>

		<cfif iterator.hasNext()>
			<div class="panel-group" id="accordion">
			
				<cfloop condition="iterator.hasNext()">
				<cfset item=iterator.next()>
				<cfset index=iterator.getRecordIndex()>
				<cfset panelTitle=LCase(item.getTitle())>
				<cfset panelTarget=Replace(panelTitle," ","","All")>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="##accordion" href="###panelTarget#"><i class="fa fa-caret-right"></i> #item.getTitle()#</a>
							</h4>
						</div>
						<div id="#panelTarget#" class="panel-collapse collapse<cfif index eq 1> in</cfif>">
							<div class="panel-body">
								#item.getBody()#
							</div>
						</div>
					</div>
				</cfloop>
				
			</div><!-- /.panel-group -->
		</cfif>
						
</cfoutput>