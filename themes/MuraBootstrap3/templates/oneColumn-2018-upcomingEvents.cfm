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
            <cfset variables.newsItems = $.content().getKidsIterator() />
            <cfset variables.recordsPerPage = 10 />
            <cfset variables.totalRecords = variables.newsItems.recordcount() />
            <cfset variables.newsItems.setNextN( variables.recordsPerPage ) />
            <cfset variables.newsItems.setStartRow($.event("startrow"))>

            <!--- Body --->
              <div class="mura-body">
                
                  <cfloop condition="#variables.newsItems.hasNext()#">
                      <div class="row row-eq-height margintopbottom">
                      <cfset variables.newsItem = variables.newsItems.next() />
                      <!--- <cfif newsItem.getReleaseDate() GTE now()> --->
                        <cfscript>
                          variables.img = variables.newsItem.getImageURL(
                            size = 'large' // small, medium, large, custom, or any other pre-defined image size
                            ,complete = false // set to true to include the entire URL, not just the absolute path (default)
                          );
                          if( !len( img ) ){
                            variables.img = '/comptroller/assets/2018/news-fillin.jpg';
                          }
                        </cfscript>

                          <div class="col-xs-12 col-sm-2">
                              <p class="release-date">
                                #dateformat( variables.newsItem.getReleaseDate(), 'mmm dd')#
                              </p>
                          </div>

                        <cfset strippedBody = replaceNocase( variables.newsItem.getBody(), '<p>', '', 'ALL' ) />
                        <cfset strippedBody = replaceNocase( strippedBody, '</p>', '', 'ALL' ) />

                            <div class="col-xs-12 col-sm-6 pd-left0">
                                <p class="release-2col">
                                    <a href="#variables.newsItem.getRemoteURL()#" target="_blank">#strippedBody#</a>
                                </p>
                            </div>
                            <div class="col-xs-12 col-sm-4 pd-left0">
                                <div class="in-the-news-image">
                                  <img src="#variables.img#">
                                </div>
                            </div>
                      <!--- </cfif> --->
                    </div>    
                  </cfloop>
                                    <!--- pagination --->

                    <cfset variables.NumberOfPages=Ceiling(variables.totalrecords/variables.recordsPerPage)>
                    <cfset variables.CurrentPageNumber=Ceiling(request.StartRow/variables.recordsperpage)> 
                    <cfset variables.next=evaluate((request.startrow+variables.recordsperpage)) >
                    <cfset variables.previous=evaluate((request.startrow-variables.recordsperpage)) >
                    <cfset variables.through=iif(variables.totalrecords lt variables.next,variables.totalrecords,variables.next-1)> 

                    <div class="mura-next-n text-center">
                      <div class="moreResults">
                        <ul class="pagination">
                        <cfif variables.previous gte 1>
                          <li class="navPrev">
                            <a href="?startrow=#variables.previous#">Prev</a>
                          </li>
                        </cfif>
                        <cfloop from="1" to="#variables.NumberOfPages#" index="i">
                          <cfset i_startRecord = ( i * variables.recordsPerPage ) - 9 />
                          <cfset i_endRecord = i * variables.recordsPerPage />

                          <cfif $.event('startRow') gte i_startRecord AND $.event('startRow') lte i_endRecord >
                            <cfset variables.class = 'active'>
        
                          <cfelse>
                            <cfset variables.class = '' />
                          </cfif>
                          <li class="#variables.class#"><a href="?startRow=#i_startRecord#" class="#variables.class#">#i#</a></li>
                        </cfloop>
                        <cfif variables.through lt variables.totalrecords >
                          <li class="navNext">
                            <a href="?startrow=#next#">Next</a>
                          </li>
                        </cfif>
                      </ul>
                      </div>
                    </div>
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