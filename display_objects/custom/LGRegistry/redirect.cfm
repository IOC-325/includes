<cfif isdefined("form.County") and isdefined("form.govType") and isdefined("form.alpha")>
	<cflocation url="/financial-data/local-government-division/view-local-government-contact-information/contact-information-2/?county=#form.county#&govType=#form.govType#&alpha=#form.alpha#">
	
<cfelseif isdefined("form.County") and isdefined("form.govType")>
	<cflocation url="/financial-data/local-government-division/view-local-government-contact-information/contact-information-2/?county=#form.county#&govType=#form.govType#&alpha=">
	
<cfelseif isdefined("form.govType") and isdefined("form.alpha")>
	<cflocation url="/financial-data/local-government-division/view-local-government-contact-information/contact-information-2/?county=&govType=#form.govType#&alpha=#form.alpha#">
	
<cfelseif isdefined("form.County") and isdefined("form.alpha")>
	<cflocation url="/financial-data/local-government-division/view-local-government-contact-information/contact-information-2/?county=#form.county#&govType=&alpha=#form.alpha#">
	
<cfelseif isdefined("form.County")>
	<cflocation url="/financial-data/local-government-division/view-local-government-contact-information/contact-information-2/?county=#form.county#&govType=&alpha=">
	
<cfelseif isdefined("form.govType")>
	<cflocation url="/financial-data/local-government-division/view-local-government-contact-information/contact-information-2/?county=&govType=#form.govType#&alpha=">
	
<cfelseif isdefined("form.alpha")>
	<cflocation url="/financial-data/local-government-division/view-local-government-contact-information/contact-information-2/?county=&govType=&alpha=#form.alpha#">

<cfelse>
	<cflocation url="/financial-data/local-government-division/view-local-government-contact-information/contact-information-2/?county=&govType=&alpha=">
	
</cfif>
