<cfoutput><div id="toolbar">
            <div class="container">

              <div class="navbar-header">


                <img src="/comptroller/includes/themes/MuraBootstrap3/images/logo.png" style="padding-bottom:5px;">

<!---                   <ul class="list-inline social">
                    <cfif len($.siteConfig().getSiteTwitter())>
                      <li><a href="#$.siteConfig().getSiteTwitter()#" title="Twitter"><i class="fa fa-twitter"></i><span>Twitter</span></a></li>
                    </cfif>
                    <cfif len($.siteConfig().getSiteFacebook())>
                      <li><a href="#$.siteConfig().getSiteFacebook()#" title="Facebook"><i class="fa fa-facebook"></i><span>Facebook</span></a></li>
                    </cfif>
                    <li><a href="##" title="RSS"><i class="fa fa-rss"></i><span>RSS</span></a></li>
                  </ul> --->



                <!--- Uncomment to have your brand element in the navbar --->
                <!--- <a class="navbar-brand" href="#$.createHREF(filename='')#">#HTMLEditFormat($.siteConfig('site'))#</a> --->
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
              </div><!--- /.navbar-header --->
              <div class="collapse navbar-collapse navbar-ex1-collapse">
                <div class="row" style="padding-top:5px;">
                  <!--- <div class="col-md-1"><img src="/comptroller/includes/themes/MuraBootstrap3/images/logo.png" style="padding-bottom:10px;"></div> --->
                  <!--- <div class="col-md-2">
                    <ul class="list-inline social">

                    <cfif len($.siteConfig().getSiteTwitter())>
                      <li><a href="#$.siteConfig().getSiteTwitter()#" title="Twitter"><i class="fa fa-twitter"></i><span>Twitter</span></a></li>
                    </cfif>
                    <cfif len($.siteConfig().getSiteFacebook())>
                      <li><a href="#$.siteConfig().getSiteFacebook()#" title="Facebook"><i class="fa fa-facebook"></i><span>Facebook</span></a></li>
                    </cfif>
                    <li><a href="##" title="RSS"><i class="fa fa-rss"></i><span>RSS</span></a></li>
                  </ul>
                  <cfif len($.siteConfig('contactPhone'))><p class="toolbar-link"><i class="fa fa-phone"></i>#$.siteConfig('contactPhone')#</p></cfif>
                  </div> --->

                  <div class="col-md-10">
                    <cf_CacheOMatic key="dspPrimaryNav">
                      #$.dspPrimaryNav(
                        viewDepth=0
                        , id='navPrimary'
                        , class='nav navbar-nav'
                        , displayHome='always'
                        , closeFolders=true
                        , showCurrentChildrenOnly=false
                        , ulTopClass='nav navbar-nav'
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

                      })
                    </script>
                  </div>
                </div><!--- /.row --->
              </div><!--- /.navbar-collapse --->
            </div><!--- /.container --->
</div>
</cfoutput>