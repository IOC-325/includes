<cfset kidsIterator = $.content().getKidsIterator() />
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
         <p>
         #$.content('streetaddress')#
         <br />#$.content('city')#, #$.Content('state')# #$.Content('zipcode')#
         <br />#$.content('phone')#
         <br /><A HREF="#$.content('website')#">#$.content('website')#</A>
              <!--- <br /><A HREF="#$.content('petfinder')#">#$.content('petfinder')#</A> --->
         <br /><a href="mailto:#$.content('email')#">#$.content('email')#</a>   </p>
         <cflock scope="Session" type="exclusive" timeout="200">


         <cfset session.streetaddress = $.content('streetaddress')>
         <cfset session.city = $.content('city')>
         <cfset session.state = $.content('state')>
         <cfset session.zipcode = $.content('zipcode')>
         <cfset session.phone = $.content('phone')>
         <cfset session.website = $.content('website')>
         <cfset session.email = $.content('email')>
         <cfset session.petfinder = $.content('email')>
         </cflock>
       </div>
   				<div class="col-xs-12 col-md-4">
    					<!--- On 4/12/2017, I went to Google Maps API website and got a geocodiing key.
    					It is AIzaSyBgj8BKO0zwwS2ofMGXYP8mKYkEXDJvGik--->
   					 <cfajaximport params="#{googlemapkey='AIzaSyBgj8BKO0zwwS2ofMGXYP8mKYkEXDJvGik'}#">
     					<cfmap
     					name="mainMap"
     					centeraddress="#$.content('Address')#, #$.content('City')#, #$.content('State')# #$.content('zipCode')#"
     					zoomlevel="14"
     					width="200"
     					height="200"
     					/>
   				</div>
      </div>
					<p class="h1">Adoptable Critters</p><br/>

     <cfif kidsIterator.hasNext() EQ 'NO'>
      <p class="h4"> Critters Coming Soon!</p>
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


			<!--- 		</cfloop> --->

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
