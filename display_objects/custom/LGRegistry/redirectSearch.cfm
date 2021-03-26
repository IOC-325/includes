<cfif isdefined("form.formname")>
	<cflocation url="/financial-data/local-government-division/view-local-government-contact-information/search-contact-informaiton/?formname=#form.formname#">
<cfelse>
	<cfif not isDefined("form.formname")>
		You must enter some text!! To go back to the previous screen click </font><a HREF="javascript:history.back()">here.</a><cfabort>
	</cfif>
	<cfif form.formname eq "">
		You must enter some text!! To go back to the previous screen click </font><a HREF="javascript:history.back()">here.</a><cfabort>
	</cfif>  
	<cfif #Len(form.formname)# LTE 2>
	  <p><font COLOR="red">A minimum of three characters are required for a search.</font><br> 
		</p>
		<div>To go back to the previous screen click </font><a HREF="javascript:history.back()">here.</a></div>
	  <cfabort>
	 </cfif>

</cfif>
