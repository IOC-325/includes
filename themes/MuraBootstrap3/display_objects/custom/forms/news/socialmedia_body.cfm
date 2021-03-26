<!--- ************************************************** --->
<!--- ************************************************** --->
<!---            CFC Pulls for Social Media              --->
<!--- ************************************************** --->
<!--- ************************************************** --->

<!--- Youtube --->
<cfinvoke component="Queries.api"
		  method="GetYouTubeCurrentVideos"
          returnvariable="qYouTube">
</cfinvoke>
<!--- Facebook --->
<cfinvoke component="Queries.api"
	method="GetFacebookData"
    returnvariable="qFB">
</cfinvoke>
<!--- Instagram --->
<cfinvoke component="Queries.api"
	method="GetInstagramData"
    returnvariable="qIG">
</cfinvoke>
<!--- Twitter --->
 <cfinvoke component="Queries.api"
	method="GetTwitterData"
    returnvariable="qTwitter">
 </cfinvoke>
<CFSET MinutePivot = 90>
<CFSET HoursPivot = 72> 
<CFSET ThisTime = DateAdd('h', 6, CREATEODBCDATETIME(NOW()))>
<CFSET ThisFaceBookTime = DateAdd('h', 5, CREATEODBCDATETIME(NOW()))>
<CFSET ThisTwitterTime = DateAdd('h', 1, CREATEODBCDATETIME(NOW()))>
<!--- ************************************************** --->
<!--- ************************************************** --->
<!--- ************************************************** ---> 
<style type="text/css">
	.bg {
        min-height: 600px;
        background: rgb(255,255,255);
        background: -moz-linear-gradient(-45deg, rgba(255,255,255,1) 0%, rgba(21,81,138,1) 100%);
        background: -webkit-linear-gradient(-45deg, rgba(255,255,255,1) 0%,rgba(21,81,138,1) 100%);
        background: linear-gradient(135deg, rgba(255,255,255,1) 0%,rgba(21,81,138,1) 100%);
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#15518a',GradientType=1 );
    }

    .social-fb, .social-tw, .social-insta, .social-yt{
        margin-top: 10px;
        margin-bottom: 20px;
    }

    .fb-item, .insta-item, .tw-item, .yt-item {
        background-color: #fff;
        margin-top: 10px;
        padding: 5px;
    }

    .fb-item p, .insta-item p, .tw-item p, .yt-item p{
        color: #000;
        font-size: 12px;
    }

    .insta-item img, .yt-item img {
        width: 100%;
    }

    .video-responsive {
        width: 100%;
        height: 200px;
    }

    .video-responsive object, .video-responsive object embed{
        width: 100% !important;
        height: 100% !important;
    }

 </style>
<cfoutput>  

        <div class="row bg">
        <!--- Facebook --->
            <div class="col-md-3 social-fb">
                <div><a href="https://www.facebook.com/ILComptroller/" target="_blank"><img src="/comptroller/assets/2018/facebook.png" /></a></div>

                    <Cfloop index="i" from="1" to="#ArrayLen(qFB)#">
                    <CFIF StructKeyExists(qFB[i],"Message")>
                        <CFSET FB_AgingTime = qFB[i].created_Time>
                        <CFSET FB_AgingMinutes = DateDiff('n',FB_AgingTime, ThisFaceBookTime)>
                        <CFSET FB_AgingHours = DateDiff('h',FB_AgingTime, ThisFaceBookTime)>
                        <CFSET FB_ReportDate = Dateformat(qFB[i].created_Time, "mmm dd yyyy")>
                        <cfset FB_Message = rereplaceNoCase(qFB[i].Message, '(((http(s)?:)|(www))\.?(\S+))', '<a href="\1" target="_blank">\1</a>', 'all')/>

                        <div class="fb-item">
                            <p>Illinois Comptroller -
                                <CFIF FB_AgingMinutes LTE MinutePivot>
                                    #ABS(FB_AgingMinutes)# minutes ago
                                <cfelseif FB_AgingHours GTE HoursPivot>
                                    #FB_ReportDate#
                                <cfelse>
                                    #ABS(FB_AgingHours)# hours ago
                                </CFIF></p>

                            <p>#FB_Message#</p>
                        </div>
                        </cfif>
                    </cfloop>

            </div>
			<!--- Twitter --->
            <div class="col-md-3 social-tw">
                    <div><a href="https://twitter.com/ilcomptroller" target="_blank"><img src="/comptroller/assets/2018/twitter.png" /></a></div>

                    <Cfloop index="i" from="1" to="#ArrayLen(qTwitter)#">
                    <!--- Convert Java Date/time to SQL Date/time --->
                    <CFSET AgingTime = parseDateTime(qTwitter[i].created_at, "EEE MMM dd HH:nn:ss zzz yyyy")>
                    
                    <CFSET AgingMinutes = DateDiff('n',AgingTime, ThisTwitterTime)>
                    <CFSET AgingHours = DateDiff('h',AgingTime, ThisTwitterTime)>
                    
                    <CFSET ReportDate = Dateformat(qTwitter[i].created_at, "mmm dd yyyy")>
                    <!--- If this is a retweet then do this --->
                    <CFIF StructKeyExists(qTwitter[i],"retweeted_status")>
                    <CFSET TwitterScreenName = qTwitter[i].retweeted_status.user.screen_name>
                    <!---     <CFSET TwitterMessage = qTwitter[i].retweeted_status.full_text> --->
                    <cfset TwitterMessage = rereplaceNoCase(qTwitter[i].retweeted_status.full_text, '(((http(s)?:)|(www))\.?(\S+))', '<a href="\1" target="_blank">\1</a>', 'all')/> 
                        <div class="tw-item">
                            <p>
                                #qTwitter[i].retweeted_status.user.name# @#TwitterScreenName# -  
                                <CFIF AgingMinutes LTE MinutePivot>
                                #AgingMinutes# minutes ago
                                <cfelseif AgingHours GTE HoursPivot>
                                #ReportDate#
                                <cfelse>
                                #AgingHours# hours ago
                                </CFIF>
                            </p>

                            <p>#TwitterMessage#</p>
                        </div>
                      <cfelse>
						<CFSET TwitterScreenName = qTwitter[i].user.screen_name>
                        <cfset TwitterMessage = rereplaceNoCase(qTwitter[i].full_text, '(((http(s)?:)|(www))\.?(\S+))', '<a href="\1" target="_blank">\1</a>', 'all')/> 
                      	 <div class="tw-item">
                            <p>
                                #qTwitter[i].user.name#  @#TwitterScreenName# -  
									<CFIF AgingMinutes LTE MinutePivot>
                                    	#AgingMinutes# minutes ago
                                    <cfelseif AgingHours GTE HoursPivot>
                                    	#ReportDate#
                                    <cfelse>
                                    	#AgingHours# hours ago
                                    </CFIF>
                            </p>

                            <p>#TwitterMessage#</p>
                        </div>
                      </cfif>
                     </cfloop>

            </div>
			<!--- Instagram --->
            <div class="col-md-3 social-insta">

                    <div><a href="https://www.instagram.com/ILComptroller/" target="_blank"><img src="/comptroller/assets/2018/instagram.png" /></a></div>


                    	<cfloop index="i" from="1" to="#ArrayLen(qIG)#">
						<CFSET CreatedTime_IG = DateAdd("s", qIG[i].caption.created_time,"1970-01-01 00:00:00")>
                        <CFSET IG_AgingMinutes = DateDiff('n',CreatedTime_IG,ThisTime)>
                        <CFSET IG_AgingHours = DateDiff('h',CreatedTime_IG, ThisTime)>
                        <CFSET IG_ReportDate = Dateformat(CreatedTime_IG, "mmm dd yyyy")>
                        <div class="insta-item">
                            <p> 
								<CFIF IG_AgingMinutes LTE MinutePivot>
                                	#IG_AgingMinutes# minutes ago
                                <cfelseif IG_AgingHours GTE HoursPivot>
                                	#IG_ReportDate#
                                <cfelse>
                                	#IG_AgingHours# hours ago
                                </CFIF>
							</p>

                            <p><!--- <img src="#qIG[i].images.thumbnail.url#" alt="#qIG[i].caption.text#" name="pic#i#" /> --->
                            <img src="#qIG[i].images.low_resolution.url#" alt="#qIG[i].caption.text#" name="pic#i#" />
                            </p>
                        </div>
					    </cfloop>

            </div>
		<!--- Youtube --->
            <div class="col-md-3 social-yt">

                    <div><a href="https://www.youtube.com/channel/UCrgG0yQBYsUvYFmn_KjfVxw" target="_blank"><img src="/comptroller/assets/2018/youtube.png" /></a></div>
                   
                      <cfloop index="i" from="1" to="#ArrayLen(qYouTube)#">
                         <!--- Get Youtube Video ID  --->
                         <CFSET MyVideoID = qYouTube[i].id.videoID>
                         <!--- Get Youtube Player and Video from CFC --->
                         <cfset yt = createObject("component", "Queries.api")>
                        <div class="yt-item">
                            <p>#qYouTube[i].snippet.title#</p>
                        
                            <p class="video-responsive">#yt.getEmbedCode('#myVideoID#')#</p>
                            <!---<p>#yt.getEmbedCode('#myVideoID#')#</p>--->
                        </div>
                      </cfloop>

            </div>
        </div>

</cfoutput>