<cfoutput>
	<cfinclude template="inc/html_head_2018.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<cfinclude template="inc/navbar_2018.cfm" />

		<div class="container">
			
				<section class="content" style="margin-bottom: 14px;">
					<!--- 
							The Content
							See the file located under '/display_objects/page_default/index.cfm' to override body styling
					--->
					<cfoutput>

						<!--- Primary Associated Image --->

							<cfif $.content().hasImage(usePlaceholder=false)>
								<cfscript>
									img = $.content().getImageURL(
										size = 'medium' // small, medium, large, custom, or any other pre-defined image size
										,complete = false // set to true to include the entire URL, not just the absolute path (default)
									);
								</cfscript>

							</cfif>
						<!--- /Primary Associated Image --->
						
						<cfif structKeyExists( variables, "img" )>
							<h1 class="mura-page-title pageTitle">
									<img src="#img#" style="margin-right: 14px; width:110px;"><span>#m.renderEditableAttribute(attribute='title')#</span>
							</h1>
						<cfelse>
							<h1 class="mura-page-title pageTitle">
							<span>#m.renderEditableAttribute(attribute='title')#</span>
							</h1>
						</cfif>

						<!--- PR Only Tempate --->
						<cfif $.event('submit') neq ''>
							<cfscript>
							
								dynamicFeed=$.getBean('feed');
								dynamicFeed.setName('temp');
								dynamicFeed.setIsActive(1);
								
								dynamicFeed.addParam(
													relationship='AND'
													,field='tcontent.parentId'
													,dataType='varchar'
													,criteria=trim( '1DB6817A-E0C7-3CE9-034D3BC5D881187C' )
													,condition='EQ'
												);
												
										if ( len(trim($.event('press-release-keyword'))) ) {
												dynamicFeed.addParam(relationship='andOpenGrouping');
												
												dynamicFeed.addParam(
													relationship='OR'
													,field='tcontent.title'
													,dataType='varchar'
													,criteria=trim( $.event('press-release-keyword') )
													,condition='CONTAINS'
												);

											dynamicFeed.addParam(relationship='closeGrouping');
										}
										
										if( len( $.event('press-release-date') ) ){
											dynamicFeed.addParam(relationship='andOpenGrouping');
	
												prStartDate = createDate( listLast( $.event('press-release-date'), '-'), listFirst( $.event('press-release-date'), '-' ), listGetAt( $.event('press-release-date'), 2, '-') );
												prEndDate = dateAdd( 'm', 1, prStartDate );
												
												dynamicFeed.addParam(
													relationship='OR'
													,field='tcontent.releaseDate'
													,dataType='date'
													,criteria=prStartDate
													,condition='GTE'
												);
												
												dynamicFeed.addParam(
													relationship='AND'
													,field='tcontent.releaseDate'
													,dataType='date'
													,criteria=prEndDate
													,condition='LT'
												);
												
											dynamicFeed.addParam(relationship='closeGrouping');
										}
							
							</cfscript>
							<cfset variables.prItems = dynamicFeed.getIterator() />
						<cfelse>
							<cfset variables.prItems = $.content().getKidsIterator() />
						</cfif>
						
						<cfset variables.recordsPerPage = 10 />
						<cfset variables.totalrecords = variables.prItems.getRecordCount() />
						<cfset variables.prItems.setNextN( variables.recordsPerPage ) />
						<cfset variables.prItems.setStartRow($.event("startrow"))>

						<!--- Body --->
							<div class="mura-body">
									
							<form name="pressRelease" id="" action="" method="get">
								<div class="row">
								  <div class="col-xs-12 col-sm-5 label-div">
								      <input type="text" name="press-release-keyword" value="#$.event('press-release-keyword')#" placeholder="FILTER BY KEYWORD" class="form-control">
								  </div>
								  <div class="col-xs-12 col-sm-5">
								    <select id="press-release-date" name="press-release-date">
								      <option value="">FILTER BY DATE</option>
									  <cfloop from="1" to="36" index="x" step="1"> 
								      	<cfset theMonth = dateAdd("m", -1 * x, now())> 
								      	<option value="#dateFormat(theMonth,"mm-01-yyyy")#" <cfif $.event('press-release-date') eq dateFormat(theMonth,"mm-01-yyyy")>selected</cfif> >#dateFormat(theMonth,"mmmm yyyy")#</option>
								      </cfloop>
								    </select>
								  </div>
								  <div class="col-xs-12 col-sm-2 text-center">
								  	<input type="submit" class="btn btn-success btn-apply nomargin" id="btnSearch" name="submit" value="Apply"></div>
								</div>
							</form>
									
									<cfloop condition="#variables.prItems.hasNext()#">
										<div class="row row-eq-height margintopbottom">
											<cfset variables.prItem = variables.prItems.next() />

											<div class="col-xs-12 col-sm-2">
												<p class="release-date">
													#dateformat( variables.prItem.getReleaseDate(), 'mmm dd')#
												</p>
											</div>
											<div class="col-xs-12 col-sm-6 pd-left0">
												<p class="release-2col">
													<a href="#variables.prItem.getURL()#" target="_blank">#variables.prItem.getTitle()#</a>
												</p>
											</div>
											<div class="col-xs-12 col-sm-4 pd-left0">
												<div class="release-3col">
												<cfset variables.cleanSummary = trim( stripHTML(variables.prItem.getSummary() ) ) />
												<cfif variables.cleanSummary gt 300>
													#left( variables.cleanSummary , 300 )#&##8230;
												<cfelse>
												#variables.cleanSummary#
												</cfif>
												</div>
											</div>
										</div>		
									</cfloop>
									<!--- pagination --->

										<!--- <cfset variables.NumberOfPages=Ceiling(variables.totalrecords/variables.recordsPerPage)>
										<cfset variables.CurrentPageNumber=Ceiling(request.StartRow/variables.recordsperpage)> 
										<cfset variables.next=evaluate((request.startrow+variables.recordsperpage))	>
										<cfset variables.previous=evaluate((request.startrow-variables.recordsperpage))	>
										<cfset variables.through=iif(variables.totalrecords lt variables.next,variables.totalrecords,variables.next-1)> 

										<div class="mura-next-n ">
											<div class="moreResults">
												<ul class="pagination">
												<cfif variables.previous gte 1>
													<li class="navPrev">
														<a href="./?startrow=#variables.previous#">Previous</a>
													</li>
												</cfif>
												
												<cfif variables.numberOfPages gt 1>
												
												<cfloop from="1" to="#variables.NumberOfPages#" index="i">
												
													<cfset i_startRecord = ( i * variables.recordsPerPage ) - 9 />
													<cfset i_endRecord = i * variables.recordsPerPage ) />

													<cfif $.event('startRow') gte i_startRecord AND $.event('startRow') lte i_endRecord >
														<cfset variables.class = 'active'>
													<cfelse>
														<cfset variables.class = '' />
													</cfif>
													<li><a href=".?/startRow=#i_startRecord#" class="#variables.class#">#i#</a></li>
												</cfloop>
												
												<cfelse>
												
												</cfif>
												
													<li class="navNext">
														<a href="./?startrow=#next#">#variables.$.rbKey('search.next')#</a>
													</li>
												
											</ul>
											</div>
										</div> --->
							</div>

							<div class="mura-body">
								#$.renderEditableAttribute(attribute="body",type="htmlEditor")#
							</div>
						<!--- /Body --->
					</cfoutput>
				</section>
			
		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>

<cfscript>

/**
 * Removes HTML from the string.
 * v2 - Mod by Steve Bryant to find trailing, half done HTML.
 * v4 mod by James Moberg - empties out script/style blocks
 * v5 mod by dolphinsboy
 * 
 * @param string      String to be modified. (Required)
 * @return Returns a string. 
 * @author Raymond Camden (ray@camdenfamily.com) 
 * @version 4, October 4, 2010 
 */
function stripHTML(str) {
    // remove the whole tag and its content
    var list = "style,script,noscript";
    for (var tag in list){
        str = reReplaceNoCase(str, "<s*(#tag#)[^>]*?>(.*?)","","all");
    }

    str = reReplaceNoCase(str, "<.*?>","","all");
    //get partial html in front
    str = reReplaceNoCase(str, "^.*?>","");
    //get partial html at end
    str = reReplaceNoCase(str, "<.*$","");

    return trim(str);

}

</cfscript>

<style>

.select2-container .select2-selection--single {
height: 47px !important;
font-size: 18px;
padding: 10px;
}

.select2-selection__arrow{
margin-top: 10px;
}

</style>