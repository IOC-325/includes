<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />
<style>
.x-border-box, .x-border-box * {
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    -ms-box-sizing: border-box;
    -webkit-box-sizing: border-box;
} 
</style>
<!--- User Story #1235 --->
         <cfquery name="qryParentInfo" datasource="#application.localCMS#">
         SELECT  Title  FROM  tcontent where SiteID = 'comptroller' AND Active=1 and ContentID = <cfqueryparam value="#$.getParentId()#" cfsqltype="cf_sql_varchar">
       </cfquery>   

		<!--- don't show page title file for items in news and FAQ page --->
		<cfif
			$.getParentId() neq '1DB6817A-E0C7-3CE9-034D3BC5D881187C' and
			$.getTitle() neq 'FAQ' and
			$.getParentId() neq '85D715F4-1CC1-DE6E-2F48C6B0E8FF59E0'>
			<!--- <cfinclude template="inc/pageTitle.cfm" /> ---><br/>
   <h3 class="text-center large-page-header">#qryParentInfo.Title# >> #$.content('title')#</h3>
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
    </div><cfquery name="addressDetails" datasource="#application.localCMS#">
            SELECT attributeValue,name, stringvalue     
            FROM tclassextenddata with (nolock) 
            INNER JOIN tclassextendattributes with (nolock) On (tclassextenddata.attributeID=tclassextendattributes.attributeID)
            WHERE tclassextenddata.baseID= (SELECT ContentHistID  FROM  tcontent where SiteID = 'comptroller' AND Active=1 and ContentID = <cfqueryparam value="#$.getParentId()#" cfsqltype="cf_sql_varchar">)
            AND Name in ('streetaddress','city','state','zipcode','phone','website','email')
         </cfquery>    

					<div class="row">
 						<div class="col-xs-12 col-md-8"><br/>
   					<cfif $.content('fileExt') neq 'png'><p class="h1 text-center">Adopt Me!</p><br/>
   						<img class="center-block" style="margin-bottom: 20px;" src="#$.getURLForImage(fileId = $.content('fileId'), size='large')#">
   					</cfif>
 						</div>
						 <div class="col-xs-12 col-md-4">
         <p><h4>#$.getTitle()#</h4></p></br>
   						
   						<cfajaximport params="#{googlemapkey='AIzaSyBgj8BKO0zwwS2ofMGXYP8mKYkEXDJvGik'}#">

   						<cfmap
     					name="mainMap"
     					centeraddress="#addressDetails.stringvalue[1]#, #addressDetails.stringvalue[2]#, #addressDetails.stringvalue[3]# #addressDetails.stringvalue[4]#"
     					zoomlevel="14"
     					width="200"
     					height="200"
     					/>
     					<p>
               #qryParentInfo.Title#
     		 <br />#addressDetails.stringvalue[1]#
         <br />#addressDetails.stringvalue[2]#, #addressDetails.stringvalue[3]# #addressDetails.stringvalue[4]#
         <br />#addressDetails.stringvalue[5]#
         <br /><A HREF="#$.content('website')#">#$.content('website')#</A>
              <!--- <br /><A HREF="#$.content('petfinder')#">#$.content('petfinder')#</A> --->
         <br /><a href="mailto:#$.content('email')#">#$.content('email')#</a>   </p>
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
