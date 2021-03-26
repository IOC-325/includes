<cfset kidsIterator = $.content().getKidsIterator() />
<cfoutput>
 <cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />
	 <!--- <cfinclude template="inc/pageTitle.cfm" /> --->
		<div class="container">
			<div class="row">
				<section class="col-md-8 col-md-offset-2 col-sm-12 col-xs-12 content">

					<center><img src="#$.getImageURL()#"></center>
					<div class="row">
 						<div class="col-xs-12 col-md-12">
         <style>span.h5.shelter-page p {
            margin-bottom: 10px;
          line-height:19px;
         }</style>
        <span class="h5 shelter-page">
    					#$.dspBody(
    						body=$.content('body')
    						, pageTitle=''
    						, crumbList=true
    						, showMetaImage=false
    						, metaImageClass=''
    					)#
        </span>
       </div>
      </div>
      <br/>
      <div class="row">
       <div class="col-xs-12 col-md-8">
        <h4>Contact Information for #$.Content('title')#</h4>
         <cfquery name="addressDetails" datasource="#application.localCMS#">
            SELECT attributeValue,name, stringvalue     
            FROM tclassextenddata with (nolock) 
            INNER JOIN tclassextendattributes with (nolock) On (tclassextenddata.attributeID=tclassextendattributes.attributeID)
            WHERE tclassextenddata.baseID= (SELECT ContentHistID  FROM  tcontent where SiteID = 'comptroller' AND Active=1 and ContentID = <cfqueryparam value="#$.getParentId()#" cfsqltype="cf_sql_varchar">)
            AND Name in ('streetaddress','city','state','zipcode','phone','website','email')
         </cfquery>        
         <p>
         #addressDetails.stringvalue[1]#oneColumn-shelter.cfm
         <br />#addressDetails.stringvalue[2]#, #addressDetails.stringvalue[3]# #addressDetails.stringvalue[4]#
         <br />#addressDetails.stringvalue[5]#
         <br /><A HREF="#$.content('website')#">#$.content('website')#</A>
              <!--- <br /><A HREF="#$.content('petfinder')#">#$.content('petfinder')#</A> --->
         <br /><a href="mailto:#$.content('email')#">#$.content('email')#</a>   </p>


       </div>
   				<div class="col-xs-12 col-md-4">
    					<!--- On 4/12/2017, I went to Google Maps API website and got a geocodiing key.
    					It is AIzaSyBgj8BKO0zwwS2ofMGXYP8mKYkEXDJvGik--->
   					 <cfajaximport params="#{googlemapkey='AIzaSyBgj8BKO0zwwS2ofMGXYP8mKYkEXDJvGik'}#">
     					<cfmap
     					name="mainMap"
     					centeraddress="#addressDetails.stringvalue[1]#, #addressDetails.stringvalue[2]#, #addressDetails.stringvalue[3]# #addressDetails.stringvalue[4]#"
     					zoomlevel="14"
     					width="200"
     					height="200"
     					/>
   				</div>
      </div>
					<p class="h1">Adoptable Critters</p><br/>

           
     <cfif kidsIterator.hasNext() EQ 'NO'>
      <p class="h4"> Critters Coming Soon ...!</p>
     <cfelse>
       <cfloop condition="#kidsIterator.hasNext()#">
        <cfset kid = kidsIterator.next() />
        <div class = "col-xs-12">
         <a href="#kid.getURL()#">
          <img
           src="#kid.getImageURL(size='medium')#"
           title="#kid.getTitle()#"
           alt="#kid.getTitle()#"
           <!--- width="100%" --->
           style="float:left; padding:10px;" />
         </a>
         <p class="h2"><a href="#kid.getURL()#">#kid.getTitle()#</a></p>
         <span class="h5">#kid.getSummary()#</span>

         <hr />
        </div>
       </cfloop>
     </cfif>



					<style>

						.item-container{
							margin-bottom: 20px;
						}

					  .item-title {
					  	background-color: ##BCAA61;
							text-align: center;
							padding: 5px 0px;
							margin: 0px;
							font-weight: bold;
					  }

						.item-title a{
							font-size: 12px;
							color: ##fff;
						}

					</style>

				</section>
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
