<cfinvoke component="Queries.revenues"
	method="getRevType"
	returnvariable="RevTypList" >
</cfinvoke>
<!--- Get Fiscal years --->
 <cfinvoke component="Queries.warehouse"
		method="getFYs"
		returnvariable="qFYList" >
	<cfinvokeargument name="numFYs" value="5"/>
    <cfinvokeargument name="MaxFY" value="#application.PopularQueryFY#"> 
</cfinvoke>
<CFPARAM NAME="FY" DEFAULT="#DATEFORMAT(NOW(), 'yyyy')#">
<!--- 	<cfdump var="#RevTypList#">  --->
<cfoutput>
	<div id="expense" class="">
		<div class="container">
			<div class="row">
				<div class="col-md-10 col-md-offset-1">
					<h1>Find a Revenue</h1>
					<p>The state of Illinois collects revenue from a variety of sources. Information provided by the Office of the Comptroller allows taxpayers to identify those revenue streams. Additional information pertaining to revenues can also be found in <a href="/find-reports">reports</a> compiled by the Comptroller's Office.</p>
					<a name="popular-revenue-searches"></a>					
					<div class="searches">
						<h2>Popular Searches</h2>

						<div class="row">
<!---        <div class="col-sm-offest-4 col-sm-4">
        Please select
       </div> --->
							<cfform role="form" action="/?LinkServID=9337D672-FAED-0D4D-2D6FA6ED510AE8B0" method="post">
								<fieldset>
									<div class="col-sm-7 col-xs-12">
										<select name="Type" id="Type">
											<option value="0">By Revenue Type</option>
											<cfloop query="RevTypList">
												<option value="#Type#">#Type# - #Name#</option>
											</cfloop>
										</select>
									</div>


									<div class="col-sm-3 col-xs-12"> <!--- <cfdump var="#application.PopularQueryFY#"> --->
                                    <cfselect name="FY" id="FY">
                                        <option value="#application.PopularQueryFY#" selected="selected">Fiscal Year</option>
                                        <Cfloop index="i" list="#qFYList#">
											<CFIF FY IS RIGHT(i,2)>
                                            	<option value="#RIGHT(i,2)#" selected="selected">20#i#</option>
                                            <cfelse>
                                            	<option value="#RIGHT(i,2)#">20#i#</option>
                                            </CFIF>
                                        </Cfloop>
                                    </cfselect>
									</div>

									<div class="col-sm-2 col-xs-12">
										<button type="button" id="searchBtn" class="btn btn-danger">Search</submit>
									</div>

								</fieldset>
							</cfform>

							<div class="result">
								<div class="col-sm-12" id="popular">
									<ul>
										<li>
											<div class="block" style="margin-bottom:0px;">
            <a href="/find-a-revenue/income-tax">
												<img src="#$.siteConfig('themeAssetPath')#/images/popular-icon1.png" alt="" />
												<span>Income Tax</span></a>

											</div>
											<div class="block" style="margin-bottom:0px;">
            <a href="/find-a-revenue/sales-tax">
												<img src="#$.siteConfig('themeAssetPath')#/images/popular-icon2.png" alt="" />
												<span>Sales Tax</span></a>

											</div>
										</li>
										<li>
											<div class="block" style="margin-bottom:0px;">
            <a href="/find-a-revenue/motor-fuel-tax">
												<img src="#$.siteConfig('themeAssetPath')#/images/popular-icon3.png" alt="" />
												<span>Motor Fuel Tax</span></a>
											</div>
											<div class="block" style="margin-bottom:0px;">
            <a href="/find-a-revenue/gaming">
												<img src="#$.siteConfig('themeAssetPath')#/images/popular-icon4.png" alt="" />
												<span>Gaming</span></a>
											</div>
										</li>
									</ul>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="advance">
									<h2>Advanced Search</h2>
									<ul>
										<li><a href="/find-a-revenue/statewide" class="opner">Statewide</a></li>
										<li><a href="/find-a-revenue/fund" class="opner">Fund</a></li>
										<li><a href="/find-a-revenue/agency" class="opner">Agency</a></li>
										<li><a href="/find-a-revenue/revenue-source" class="opner">Revenue Source</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END EXPENSE -->
	</cfoutput>
 <script>
$( document ).ready(function() {
$("#searchBtn").click(function(event) {
 var FY = 2016, SearchType;
 FY = $("#FY").val();
 SearchType = $("#Type").val();
 		var finalURL  = get_hostname(window.location.href) + "/index.cfm/find-a-revenue/revenue-source/?GetQueryData=true&Revenue_Source=0&Group=0&Class=0&RevSel=&RevTypeSel=" + SearchType + "&GroupBy=RevType&FY=" + FY + "&ShowMo=No";
 window.location = finalURL;
 console.log(finalURL);
});
});
function get_hostname(url) {
    var m = url.match(/^http:\/\/[^/]+/);
    return m ? m[0] : null;
}
</script>