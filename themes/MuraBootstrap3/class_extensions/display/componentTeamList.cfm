<!---
			This file is part of the Down to Business Mura CMS Theme
--->
<cfoutput>
	<cfsilent>
		<cfscript>
			feed = $.getBean('feed').loadBy(name=$.component('contentListFeed'));
			it = feed.getIterator();
		</cfscript>
	</cfsilent>

	<div class="row">

			<cfloop condition="#it.hasNext()#">
				<cfsilent>
					<cfscript>
						item = it.next();
						img = $.getURLForImage(fileid=item.getValue('fileid'), size='small');
						hasImage = YesNoFormat($.component('tlPhotos')) and Len(img);
						hasDesc = YesNoFormat($.component('tlDesc')) and Len(item.getSummary());
						hasImageClass = hasImage ? 'has-image' : 'no-image';
					</cfscript>
				</cfsilent>
				<div class="col-lg-4 col-md-4 col-sm-6 teamMemberWrap">
					<div class="top"></div>
					<div class="teamMember">
						<cfif hasDesc>
							<div class="desc">#item.getSummary()#</div>
						</cfif>
						<cfif len(item.getTMFacebook())>
							<a href="#item.getTMFacebook()#"> <i class="fa fa-facebook"></i></a>
						</cfif>
						<cfif len(item.getTMPinterest())>
							<a href="#item.getTMPinterest()#"> <i class="fa fa-pinterest"></i></a>
						</cfif>
						<cfif len(item.getTMDribble())>
							<a href="#item.getTMDribble()#"> <i class="fa fa-dribbble"></i></a>
						</cfif>
						<cfif len(item.getTMTwitter())>
							<a href="#item.getTMTwitter()#"> <i class="fa fa-twitter"></i></a>
						</cfif>
						<cfif hasImage>
							<a href="#item.getURL()#"><img src="#img#"></a>
						</cfif>
						<div class="bottom">
							<div class="title">#item.getTitle()#</div>
							<div class="position">#item.getTMPosition()#</div>
							<a class="email" href="mailto:#item.getTMEmail()#">#item.getTMEmail()#</a>
						</div>
					</div>
				</div>
			</cfloop>
			
	</div>
</cfoutput>