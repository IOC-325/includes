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
						<cfset variables.itItems = $.content().getKidsIterator() />
						<cfset variables.itItems.setNextN( 0 ) />

						<!--- Body --->
							<div class="mura-body">
							<div class="row">
								<div class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                                    <div class="table-responsive">
									<table id="example" class="table table-bordered table-hover">
										<thead>
											<tr>
												<th class="text-center" style="background-color: rgba(88,88,91,1); color: white;">ACCOUNTING FORMS</th>
											</tr>
										</thead>
										<tbody>


									<cfloop condition="#variables.itItems.hasNext()#">
										
										<cfset variables.item = variables.itItems.next() />
											
										<tr>
											<td style="padding-left: 80px;"><a style="color: gray;" href="#variables.item.getURL()#">#variables.item.getTitle()#</a></td>
										</tr>

									</cfloop>
								</tbody>
							</table>
                                    </div>
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
	  bFilter: false, bInfo: false,	"bLengthChange": false,
	  "pageLength": 5,
	  "ordering": false
	} );	

</script>	