<style>
    /* page specific styles, should move to illnois.css */
    span.h5.shelter-page p {
        margin-bottom: 10px;
        line-height: 19px;
    }
</style>

<cfoutput>
    <cfinclude template="inc/html_head_2018.cfm"/>
    <body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav"
                                                                                data-offset="50">
    <cfinclude template="inc/navbar_2018.cfm"/>

    <div class="container">
    <section class="content">
<!---
        The Content
        See the file located under '/display_objects/page_default/index.cfm' to override body styling
--->
    <cfoutput>

<!--- Primary Associated Image --->

        <cfif $.content().hasImage(usePlaceholder = false)>
            <cfscript>
                img = $.content().getImageURL(
                    size = 'large' // small, medium, large, custom, or any other pre-defined image size
                        , complete = false // set to true to include the entire URL, not just the absolute path (default)
                        );
            </cfscript>

        </cfif>
<!--- /Primary Associated Image --->

        <div>
        <nav aria-label="You are here:" role="navigation">#$.dspCrumbListLinks()#</nav></div>

            <img src="#img#" class="center-block marginb20">

<!--- Body --->
            <div class="mura-body">

            <cfset kidsIterator = $.content().getKidsIterator()/>

            <div class="row">
            <div class="col-xs-12 col-sm-6 col-md-7">
            <h4><strong>Contact Information for #$.Content('title')#</strong></h4>
            <p>
                #$.content('streetaddress')#
                <br/>#$.content('city')#, #$.Content('state')# #$.Content('zipcode')#
                <br/>#$.content('phone')#
                <br/><a href="#$.content('website')#">#$.content('website')#</a>
<!--- <br /><A HREF="#$.content('petfinder')#">#$.content('petfinder')#</A> --->
                <br/><a href="mailto:#$.content('email')#">#$.content('email')#</a>   </p>
            <cflock scope="Session" type="exclusive" timeout="200">
                <cfset session.streetaddress = $.content('streetaddress')/>
                <cfset session.city = $.content('city')/>
                <cfset session.state = $.content('state')/>
                <cfset session.zipcode = $.content('zipcode')/>
                <cfset session.phone = $.content('phone')/>
                <cfset session.website = $.content('website')/>
                <cfset session.email = $.content('email')/>
                <cfset session.petfinder = $.content('email')/>
            </cflock>
            </div>

            <div class="col-xs-12 col-sm-6 col-md-5">
<!--- On 4/12/2017, I went to Google Maps API website and got a geocodiing key.
It is AIzaSyBgj8BKO0zwwS2ofMGXYP8mKYkEXDJvGik--->
             <cfajaximport params="#{googlemapkey = 'AIzaSyBgj8BKO0zwwS2ofMGXYP8mKYkEXDJvGik'}#">
                <cfmap
                name="mainMap"
                centeraddress="#$.content('Address')#, #$.content('City')#, #$.content('State')# #$.content('zipCode')#"
                zoomlevel="14"
                width="340"
                height="200"/>
            </div>

            </div>

                <p class="h1 margintop"><strong>Adoptable Critters</strong></p><br/>

            <cfif kidsIterator.hasNext() EQ 'NO'>
                    <p class="h4"> Critters Coming Soon!</p>
            <cfelse>
                <cfloop condition="#kidsIterator.hasNext()#">
                    <cfset kid = kidsIterator.next()/>
                        <div class="row">
                        <div class="col-xs-12">
                        <div class="animal-shelters-details clearfix">
                                <a href="#kid.getURL()#">
                            <img
                            src="#kid.getImageURL(size='medium')#"
                            title="#kid.getTitle()#"
                            alt="#kid.getTitle()#"
<!--- width="100%" --->
                        style="float:left; padding:0 15px 15px 0;" />
                        </a>
                        <p class="h2"><a href="#kid.getURL()#">#kid.getTitle()#</a></p>
                    <span class="h5">#kid.getSummary()#</span>
                    </div>
                    </div>
                    </div>
                </cfloop>
            </cfif>

            </div>
<!--- /Body --->
    </cfoutput>

    </section>
    </div><!-- /.container -->
    <cfinclude template="inc/footer_2018.cfm"/>
    <cfinclude template="inc/html_foot_2018.cfm"/>
</cfoutput>