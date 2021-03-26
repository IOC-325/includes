<cfoutput>

	<cfset feed=$.getBean('content').loadBy(contentID=$.content('contentID'))>
	<cfset it=feed.getKidsIterator()>
	
	<div id="kidsNav" class="container">
		<div class="row">
			<nav class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<ul class="list-inline">
				<cfloop condition="it.hasNext()">
				<cfset item=it.next()>
				<cfset index=it.getRecordIndex()>
					<li><a href="#item.getURL()#">#item.getTitle()#</a></li>
				</cfloop>
				</ul>
			</nav>
		</div>
	</div>

</cfoutput>