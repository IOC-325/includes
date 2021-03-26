<CFIF IsDefined("URL.NoCache") AND URL.NoCache IS "true">
    <cfcache action = "flush" ></cfcache>
	    <cfinclude template="socialmedia_body.cfm">
    
<cfelse>
	<cfcache action = "cache" timespan = "#createTimeSpan(0,0,0,0)#">
		<cfinclude template="socialmedia_body.cfm">
    </cfcache>
</cfif>
