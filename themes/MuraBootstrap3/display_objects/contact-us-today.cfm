<cfoutput>
	<div class="row contact-us-info">
		<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			<p><strong>#$.siteConfig('site')#</strong><br />
			#$.siteConfig('contactAddress')#<br />
			#$.siteConfig('contactCity')#, #$.siteConfig('contactState')# #$.siteConfig('contactZip')#</p>
		</div>
		<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			<p><i class="fa fa-phone"></i> #$.siteConfig('contactPhone')#<br />
			<i class="fa fa-envelope"></i> #$.siteConfig('contactEmail')#</p>
		</div>
	</div>
</cfoutput>