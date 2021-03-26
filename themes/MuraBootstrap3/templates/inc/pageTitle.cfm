<cfoutput>
	<!--- If there's a background image --->
	<!---
<cfif len($.content().getPageBanner())>
		<cfset titleBgImageID = $.content().getPageBanner()>
	</cfif>
--->
    <cfset sectionBanner=$.content().getPageBanner()>
    <cfloop from="#arrayLen($.event('crumbdata'))#" to="2" step="-1" index="i">
            <cfset c = $.getBean("contentBean").loadBy(contentId = $.event('crumbdata')[i].contentId)>
            <cfif trim(c.getValue("useSectionBanner")) eq 1>
                <cfset sectionBanner=trim(c.getPageBanner())>
                <cfset i = 1>
            </cfif>
    </cfloop> 

<cfif $.getContentId() eq '1FDE522A-5056-93B5-5EAAD11B3DE7C42F'>
	<div id="pageTitleBanner" 
    style="background-image:url(#$.createHREFforImage(fileid=sectionBanner,size='source')#); position: relative;">
        
          <div class="searchwellContainer">
            <div class="container">
              <div class="transbox row">
                <div class="col-sm-4">
                <p class="search-text hidden-xs pull-right">Looking for something specific?</p>
                </div>
                <div class="col-xs-12 col-sm-8">
                  <form id="" class="search-form" role="search" action="/search">
                    <div class="input-group">
                      <input type="text" name="Keywords" id="txtKeywords" class="form-control" value="#HTMLEditFormat($.event('keywords'))#" placeholder="#$.rbKey('search.search')#">
                      <span class="input-group-btn">
                        <button type="submit" class="btn btn-danger">Search</button>
                      </span>
                    </div>
                    <input type="hidden" name="display" value="search">
                    <input type="hidden" name="newSearch" value="true">
                    <input type="hidden" name="noCache" value="1">
                  </form>
                </div>
              </div>
            </div>
          </div>
        

<!--- 		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<cfset sectionTitle=$.content().getTitle()>
					<cfloop 
            from="#arrayLen($.event('crumbdata'))#" 
            to="2" 
            step="-1" 
            index="i">
		          <cfset c = $.getBean("contentBean").loadBy(contentId = $.event('crumbdata')[i].contentId)>
		          <cfif trim(c.getValue("useSectionTitle")) eq 1>
                <cfset sectionTitle=trim(c.getTitle())>
                <cfset i = 1>
		          </cfif>
					</cfloop>
					<!--- as cool as this is, we're looking to place the title in the white area--->
					<!--- <h1 class="pageTitle center">#sectionTitle#</h1>--->
					<!--- <h1 class="pageTitle">#$.content('title')#</h1> --->
        </div>
			</div>
		</div> --->

	</div>
  <cfelse>
    <div class="secondary-hero">
      <img src="#$.createHREFforImage(fileid=sectionBanner,size='source')#" />
    </div>
  </cfif>
  <div class="col-xs-12 text-center">
	 <h2 class="large-page-header">#$.content('title')#</h3>
  </div>
</cfoutput>