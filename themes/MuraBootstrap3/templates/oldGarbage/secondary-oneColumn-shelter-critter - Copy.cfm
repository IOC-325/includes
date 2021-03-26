<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />

		<!--- don't show page title file for items in news and FAQ page --->
		<cfif
			$.getParentId() neq '1DB6817A-E0C7-3CE9-034D3BC5D881187C' and
			$.getTitle() neq 'FAQ' and
			$.getParentId() neq '85D715F4-1CC1-DE6E-2F48C6B0E8FF59E0'>
			<!--- <cfinclude template="inc/pageTitle.cfm" /> ---><br/>
   <h2 class="text-center large-page-header">#$.content('title')#</h2>
   <br/>
		<cfelse>
			<h3 style="text-transform: uppercase; text-align: center;">#$.getTitle()#</h3>
		</cfif>

		<!--- Above Content Objects --->
		<div id="aboveContent">
			#$.dspObjects(4)#
		</div>
		<div class="container">
 			<div class="row">
 				<!--- <section class="col-md-10 col-md-offset-1 col-sm-12 col-xs-12 content"> --->
     <div class="col-xs-12 col-md-12">
        #$.dspBody(
         body=$.content('body')
         , pageTitle=''
         , crumbList=true
         , showMetaImage=false
         , metaImageClass='thumbnail'
        )#
     </div>
    </div>

					<div class="row">
 						<div class="col-xs-12 col-md-8"><br/>
   					<cfif $.content('fileExt') neq 'png'><p class="h1 text-center">Adopt Me!</p><br/>
   						<img class="center-block" style="margin-bottom: 20px;" src="#$.getURLForImage(fileId = $.content('fileId'), size='large')#">
   					</cfif>
 						</div>
						 <div class="col-xs-12 col-md-4">

   						<cfparam name="session.streetaddress" default="">
   						<cfparam name="session.city" default="">
   						<cfparam name="session.state" default="">
   						<cfparam name="session.phone" default="">
   						<cfparam name="session.website" default="">
   						<cfparam name="session.email" default="">
   						<cfparam name="session.zipcode" default="">

   						<cfajaximport params="#{googlemapkey='AIzaSyBgj8BKO0zwwS2ofMGXYP8mKYkEXDJvGik'}#">

   						<cfmap
   						name="mainMap"
   						centeraddress="#session.streetaddress#, #session.city#, #session.state# #session.zipcode#"
   						zoomlevel="14"
   						width="200"
   						height="200"
   						/>
     					<p>
     					#session.streetaddress#
     					<br />#session.city#, #session.state# #session.zipcode#
     					<br />#session.phone#
     					<br /><A HREF="#session.website#">#session.website#</A>
     					<br /><a href="mailto:#session.email#">#session.email#</a></p>
						</div>
					</div>
     <div class="row">
    					<div class="row col-xs-12">
    						#$.dspObjects(2)#
    					</div>
			  </div><!--- /.row --->
		</div><!--- /.container --->

			<!--- Above Footer Objects --->
			<div id="aboveFooter">
				<div class="container">
					#$.dspObjects(5)#
				</div>
			</div>

	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
</cfoutput>
