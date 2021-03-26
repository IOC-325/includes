<cfoutput>

	<div class="nav-header">
		<div class="col-xs-12 col-sm-6 col-sm-offset-3 text-center">
			<a href="/">
				<img
				src="/comptroller/assets/image/nav-header-seal-text.jpg"
				title="Leslie Geissler Munger - Illinois Comptroller"
				alt="Leslie Geissler Munger - Illinois Comptroller" />
			</a>
		</div>
		<div class="hidden-xs col-sm-3 pull-right apps">
			<a href="https://play.google.com/store/apps/details?id=com.planetbomba.ilpays">
				<img src="/comptroller/assets/Image/google-play-logo.png"
				title="Download our app on Google Play"
				alt="Download our app on Google Play"
				align="right"
				class="app-image" />
			</a>
			<a href="https://itunes.apple.com/us/app/il-pays/id687293444">
				<img src="/comptroller/assets/Image/apple-app-store-icon.png"
				title="Download our app on the App Store"
				alt="Download our app on the App Store"
				align="right"
				class="app-image" />
			</a>
		</div>
	</div>

	<div class="nav-container">
		<div class="container">
			<nav class="navbar" role="navigation">
				<div class="col-sm-12">
						<div class="navbar-header">
							<!--- Uncomment to have your brand element in the navbar --->
							<!--- <a class="navbar-brand" href="#$.createHREF(filename='')#">#HTMLEditFormat($.siteConfig('site'))#</a> --->
							<button
								type="button"
								class="navbar-toggle"
								data-toggle="collapse"
								data-target="##navbar1">
        <span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
						</div><!--- /.navbar-header --->
						<div class="collapse navbar-collapse navbar-ex1-collapse" id="navbar1">
							<div class="row">
								<div class="col-md-12 text-center">
									<cf_CacheOMatic key="dspPrimaryNav" nocache="1">
										#$.dspPrimaryNav(
											viewDepth=0
											, id='navPrimary'
											, class='nav navbar-nav navbar-right'
											, displayHome='always'
											, closeFolders=true
											, showCurrentChildrenOnly=false
											, ulTopClass='nav navbar-nav navbar-right'
											, ulNestedClass='dropdown-menu'
											, liHasKidsClass='dropdown'
											, liHasKidsAttributes=''
											, liHasKidsNestedClass='dropdown-submenu'
											, liNestedClass=''
											, aHasKidsClass='dropdown-toggle'
											, aHasKidsAttributes='role="button" data-toggle="dropdown" data-target="##"'
											, liCurrentClass=''
											, aCurrentClass=''
											, siteid=$.event('siteid')
										)#
									</cf_CacheOMatic>
									<!---
										Optional named arguments for Primary Nav are:
										displayHome="Always/Never/Conditional"
										openFolders/closeFolders="contentid,contentid"
											(e.g. show specific sub-content in dropdown nav)
									--->
									<script>
										$(function(){

											$(#serializeJSON($.getCurrentURLArray())#).each(
												function(index, value){
													$("##navPrimary [href='" + value + "']").closest("li").addClass("active");
												}
											);

											var path = window.location.pathname;

											if( path != "/" ){
												$(".search-icon-li").clone().appendTo("##navPrimary");
											}

		                  function setURLVars() {

		                    var queryString = $('##searchForm').serialize();
		                    $('##searchForm').attr('action', '/search?' + queryString).submit();
		                  }

							        jQuery('.search').click(function () {
							            if(jQuery('.search-btn').hasClass('icon-search')){
							                jQuery('.search-open').fadeIn(500);
							                jQuery('.search-btn').removeClass('icon-search');
							                jQuery('.search-btn').addClass('icon-remove');
							            } else {
							                jQuery('.search-open').fadeOut(500);
							                jQuery('.search-btn').addClass('icon-search');
							                jQuery('.search-btn').removeClass('icon-remove');
							            }
							        });
										})
									</script>
								</div>
							</div><!--- /.row --->
						</div><!--- /.navbar-collapse --->

				</div> <!--- /col-sm-12 --->
			</nav><!--- /nav --->
		</div>
		<!--- </header> --->

		<style>
		.hidden{ display: none;}
		</style>

		<div class="hidden">
			<li class="search-icon-li">
				<div class="hidden-xs">
				<!---<cfinclude template="/GoogleCSE_1.cfm">--->
				<form id="searchForm" name="searchForm" class="search-form" role="search" action="/search">
				<i class="search fa fa-search search-btn nav-search icon-search"></i>
					<div class="search-open" style="display: none;">
						<div class="input-group animated fadeInDown">
							<!--- This version of the navbar (for the home page - navbar_home.cfm, has it's seach feature in the home.cfmm template. Therefore, it is removed from here. To see the search feature, check eitehr home.cfm, or navbar.cfm - ASP')--->
						</div>
					</div>
				</form>
				</div>
				<div class="visible-xs">
					<a href="/search" class="xs-small-search">Search</a>
				</div>
			</li>

		</div>
				<!--- <div class="col-md-3 col-sm-7">
					<form id="searchForm" class="navbar-form navbar-right" role="search">
						<i class="fa fa-search"></i>
						<div class="input-group">
							<input type="text" name="Keywords" id="txtKeywords" class="form-control" value="#HTMLEditFormat($.event('keywords'))#" placeholder="#$.rbKey('search.search')#">
							<span class="input-group-btn">
								<button type="submit" class="btn btn-primary">GO</button>
							</span>
						</div>
						<input type="hidden" name="display" value="search">
						<input type="hidden" name="newSearch" value="true">
						<input type="hidden" name="noCache" value="1">
					</form>
				</div><!--- /search div ---> --->
			</div><!--- /container --->

</cfoutput>