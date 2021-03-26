<cfscript>
	myFeed=$.getBean('feed');
	myFeed.setMaxItems(0); // 0=unlimited;
	myFeed.setNextN(0);
	myFeed.addParam(
		field='parentId'
		,   relationship='AND'
		,   condition='eq'
		,   criteria='E92146FC-9161-DF3C-156C233E5ABE383A'
		,   dataType='varchar'
		);
	
	// sort by functions
	// myFeed.setSortBy('payrollBulletinDate'); // sorts by string (01 (january), 02 (febrary), regardless of year)
	//myFeed.setSortBy('bulletinNumber');
	myFeed.setSortBy('releaseDate');
	//myFeed.setSortBy('orderNo');
	myFeed.setSortDirection('desc');
	myIterator = myFeed.getIterator();
	</cfscript>
<cfoutput>
	<cfinclude template="inc/html_head_2018.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
		<cfinclude template="inc/navbar_2018.cfm" />

		<div class="container">
			<section class="content">
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

					<!--- News Only Tempate --->
					<!--- <cfset variables.itItems = $.content().getIterator() />
					<cfset variables.itItems.setNextN( 0 ) /> --->

					<!--- Body --->
						<div class="mura-body">
							<div class="row">
								<div class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
									<cfif myIterator.hasNext()>
                                        <div class="table-responsive">
									    <table id="example" class="table table-bordered table-hover">
    									    <thead>
        									<tr style="background-color: rgba(88,88,91,1); color: white;">
         									    <th>
              										<strong>Dated</strong>
          									 	</th>
           										<th>
                									<strong>Number</strong>
          										</th>
           										<th>
                									<strong>Title</strong>
            									</th>
        									</tr>
											</thead>
											<tbody>    
												<cfoutput>
													<cfloop condition="myIterator.hasNext()">
														<cfset item=myIterator.next()>
														<cfif len(item.getPayrollBulletinPDF())>
															<cfset AppendUrl = "/comptroller/cache/file/#item.getPayrollBulletinPDF()#.pdf">
														<cfelse>
															<cfset AppendUrl = "#variables.item.getURL()#">
														</cfif>
															<tr>
																<td>
																	<a href="#AppendUrl#">#dateformat(item.getPayrollBulletinDate(),'mm/dd/yyyy')#
																	</a>
																</td>
																<td nowrap>
																	<a href="#AppendUrl#">#item.getPayrollBulletinNumber()#
																	</a>	
																</td>
																<td>
																	<a href="#AppendUrl#">#item.getMenuTitle()#</a>                      
																</td>
															</tr>           
													</cfloop>
												</cfoutput>
											</tbody>
										</table>
                                            </div>
									<cfelse>
									<p>No payroll Bulletins exist. Archives below.</p>
									</cfif>
								</div>
                            </div>
							#$.renderEditableAttribute(attribute="body",type="htmlEditor")#
						</div>
					<!--- /Body --->
				</cfoutput>
			</section>
		</div><!-- /.container -->
	<cfinclude template="inc/footer_2018.cfm" />
	<cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>
<script>
    $('#example').dataTable( {
      bFilter: false, bInfo: false, "bLengthChange": false,
      "pageLength": 15,
      "ordering": false,
      "searching": true
    } );    
</script>   