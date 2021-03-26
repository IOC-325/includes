<CFPARAM NAME="FY" DEFAULT="#application.PopularQueryFY#">
<cfparam name="ApprClsSel" default="">
<!--- Get Fiscal years --->
 <cfinvoke component="Queries.warehouse"
		method="getFYs"
		returnvariable="qFYList" >
	<cfinvokeargument name="numFYs" value="5"/>
    <cfinvokeargument name="MaxFY" value="#application.PopularQueryFY#">
</cfinvoke>
<cfinvoke component="Queries.warehouse"
 method="GetClassList"
 returnvariable="ApprClsList">
</cfinvoke>
<cfoutput>
<!-- START EXPENSE -->
<div id="expense">
	<div class="container">
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<h1>Find an Expense</h1>

				<p>The expense database allows taxpayers to see how public dollars are spent. Information provided by the Illinois Office of the Comptroller allows users to identify any state spending. Additional information pertaining to expenses can also be found in <a href="/reports">reports</a> compiled by the Comptroller&rsquo;s Office.</p>
				<a name="popular-expense-searches"></a>
				<div class="searches">
					<h2>Popular Searches</h2>

					<div class="row">
						<cfform action="" method="get" enctype="application/x-www-form-urlencoded" preloader="no">
							<fieldset>
								<div class="col-sm-7 col-xs-12">
                                 <select name="ApprClsSel" id="ApprClsSel">
                                 <OPTION VALUE="" selected="selected">Appropriation Class</option>
                                 <cfloop query="ApprClsList">
                                    <CFIF ApprClsSel is ApprClsList.Class>
                                         <OPTION VALUE="#Class#" SELECTED>#Class# - #Name#</option>
                                     <CFELSE>
                                         <OPTION VALUE="#Class#">#Class# - #Name#</option>
                                     </CFIF>
                                 </cfloop>
                                 </SELECT>
        					</div>

								<div class="col-sm-3 col-xs-12">
                                <cfselect name="FY" id="FY">
                                    <option value="#DATEFORMAT(NOW(), 'yy')#" selected="selected">Fiscal Year</option>
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
										<div class="block" style="margin-bottom:0px;"><a href="/find-an-expense/education"><img alt="" src="#$.siteConfig('themeAssetPath')#/images/popular-icon5.png" /> <span>Education</span></a></div>

										<div class="block" style="margin-bottom:0px;"><a href="/find-an-expense/medicaid"><img alt="" src="#$.siteConfig('themeAssetPath')#/images/popular-icon6.png" /> <span>Medicaid</span></a></div>
									</li>
									<li>
										<div class="block" style="margin-bottom:0px;"><a href="/find-an-expense/capital"><img alt="" src="#$.siteConfig('themeAssetPath')#/images/popular-icon7.png" /> <span>Capital</span></a></div>

										<div class="block" style="margin-bottom:0px;"><a href="/find-an-expense/pension-Systems"><img alt="" src="#$.siteConfig('themeAssetPath')#/images/popular-icon8.png" /> <span>Pension Systems</span></a></div>
									</li>
									<li>
										<div class="block" style="margin-bottom:0px;"><a href="/find-an-expense/debt-Payments"><img alt="" src="#$.siteConfig('themeAssetPath')#/images/popular-icon9.png" /> <span>Debt Payments</span></a></div>

										<div class="block" style="margin-bottom:0px;"><a href="/find-an-expense/delayed-Payment-Interest"><img alt="" src="#$.siteConfig('themeAssetPath')#/images/popular-icon11.png" /> <span>Late Payment Interest Penalties</span></a></div>
									</li>
									<li>
										<div class="block" style="margin-bottom:0px;"><a href="/state-contracts"><img alt="" src="#$.siteConfig('themeAssetPath')#/images/popular-icon10.png" /> <span>Contracts</span></a></div>

										<div class="block" style="margin-bottom:0px;"><a href="/salary-database/"><img alt="" src="#$.siteConfig('themeAssetPath')#/images/popular-icon12.png" /> <span>Salary Database</span></a></div>
									</li>
								</ul>
							</div>
						</div>

						<div class="col-sm-12">
							<div class="advance">
								<h2>Advanced Search</h2>

								<ul>
									<li><a class="opner" href="/find-an-expense/statewide">Statewide</a></li>
									<li><a class="opner" href="/find-an-expense/by-fund">Fund</a></li>
									<li><a class="opner" href="/find-an-expense/by-agency">Agency</a></li>
									<li><a class="opner" href="/find-an-expense/by-object-of-expenditure">Object of Expenditure</a></li>
									<li><a class="opner" href="/find-an-expense/by-detailed-object">Detailed Object</a></li>
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
 SearchType = $("#ApprClsSel").val();
 var finalURL  = get_hostname(window.location.href) +  "/index.cfm/find-an-expense/by-object-of-expenditure/?GetQueryData=true&ObjeSel=0&Type=0&Group=0&Class=0&ApprClsSel=" + SearchType + "&Groupby=ApprCls&FY=" + FY + "&Showmo=No";
 window.location = finalURL;
 console.log(finalURL);
});
});
function get_hostname(url) {
    var m = url.match(/^http:\/\/[^/]+/);
    return m ? m[0] : null;
}
</script>
