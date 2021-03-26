<cfoutput>
	<!--- Footer --->
	<div class="secondary footerTop">
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-sm-6">
					<h4>Newsletter</h4>
					<form>
						<div class="form-group">
							<input type="text" class="form-control" name="name" placeholder="Your Name">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" name="email" placeholder="Your Email">
						</div>
						<div class="form-group">
							<button class="btn btn-primary pull-right" value="Subscribe">Subscribe</button>
						</div>
						
					</form>
				</div>
				<div class="col-md-4 col-sm-6 testimonials">
					<!--- <h4>Comptroller's Critters</h4> --->
					<h4>Features</h4>
					<!--- 
					Get the testimonial feed. 
					To Use a different feed, change the 'name' to whatever the feed name is in your Content Collections
					--->
					<!--- <cfset feed=$.getBean('feed').loadBy(name='Testimonials Footer')> --->
					<cfset feed=$.getBean('feed').loadBy(name='features')>
					<cfset it=feed.getIterator()>
					<cfloop condition="it.hasNext()">
						<cfset item=it.next()>
						<p><!--- <img src="#item.getImageURL()#" style="float:left;">#item.getImageURL()# --->
						<img class="profile-image" src="#item.getImageURL('small')#" style="border-radius:50px;">
						<br>
						<a href="#item.getURL()#">#item.getTitle()#</a></p>
						<!--- <p><span>- #item.getTAuthor()#</span><br>
						#item.getTCompany()#</p>  --->
					</cfloop>
				</div>
				<!--- Footer Contact Info --->
				<div class="col-md-4 col-sm-6">
					#$.dspObject('component','[footer] Contact')#
				</div>
			</div>
		</div>
	</div>
	<footer>
		<div class="container">
			<div class="col-lg-12">
				<ul class="list-inline">
					<li><a href="#$.createHref(filename='')#">Home</a></li>
					<li><a href="#$.createHref(filename='about')#">About</a></li>
					<li><a href="#$.createHref(filename='features')#">Features</a></li>
					<li><a href="#$.createHref(filename='blog')#">Blog</a></li>
					<li><a href="#$.createHref(filename='contact')#">Contact</a></li>
				</ul>
				<p><small>&copy; #year(now())# #HTMLEditFormat($.siteConfig('site'))# All rights reserved.</small></p>
			</div>
		</div>
	</footer>
</cfoutput>