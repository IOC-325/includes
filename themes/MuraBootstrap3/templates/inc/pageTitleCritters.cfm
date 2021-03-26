<cfoutput>
	<!--- If there's a background image --->
	<!---
<cfif len($.content().getPageBanner())>
		<cfset titleBgImageID = $.content().getPageBanner()>
	</cfif>
--->
	<div id="pageTitleBanner"
		<cfset sectionBanner=$.content().getPageBanner()>
		<cfloop from="#arrayLen($.event('crumbdata'))#" to="2" step="-1" index="i">
            <cfset c = $.getBean("contentBean").loadBy(contentId = $.event('crumbdata')[i].contentId)>
            <cfif trim(c.getValue("useSectionBanner")) eq 1>
                <cfset sectionBanner=trim(c.getPageBanner())>
                <cfset i = 1>
            </cfif>
		</cfloop> style="background-image:url(#$.createHREFforImage(fileid=sectionBanner,size='source')#)">
		
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<cfset sectionTitle=$.content().getTitle()>
					<cfloop from="#arrayLen($.event('crumbdata'))#" to="2" step="-1" index="i">
		                <cfset c = $.getBean("contentBean").loadBy(contentId = $.event('crumbdata')[i].contentId)>
		                <cfif trim(c.getValue("useSectionTitle")) eq 1>
                            <cfset sectionTitle=trim(c.getTitle())>
                            <cfset i = 1>
		                </cfif>
					</cfloop>
					<!--- as cool as this is, we're looking to place the title in the white area--->
					 <!--- <h1 class="pageTitle center">#sectionTitle#</h1> --->
           <span style="float:left;"><h1 class="pageTitle">#$.content('title')#</h1><span>
          
				</div>
			</div>
		</div>
	</div>
</cfoutput>