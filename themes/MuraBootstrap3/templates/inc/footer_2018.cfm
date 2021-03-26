<cfoutput>
	<footer id="myFooter">
	    <div class="container">
	        <ul>
				<li><a href="/internships">INTERNSHIPS</a></li>
				<li><a href="/resources/employment">EMPLOYMENT</a></li>
				<li><a href="/privacy-policy">PRIVACY POLICY</a></li>
				<li><a href="/about/identity-protection-policy/">IDENTITY PROTECTION POLICY</a></li>
                <li><a href="/iocresources/ioc-procurement-policy-board/">COMPTROLLER PPB</a></li>
				<li><a href="/about/office-of-the-executive-inspector-general/">INSPECTOR GENERAL</a></li>
				<li><a href="/about/contact/">CONTACT US</a></li>							
	        </ul>
		    <p class="footer-copyright text-center">
					&copy; #datePart('yyyy', now())# ILLINOIS COMPTROLLER'S OFFICE ALL RIGHTS RESERVED<br/>
					<a href="/about/susana-a-mendoza/in-loving-memory/">IN LOVING MEMORY - JBT</a>
			 		<cfquery datasource="General" name="getDateBar" cachedwithin="#CreateTimeSpan(
						 0,
						 0,
						 4,
						 0
					 )#">
			        SELECT  strValue
			        from  tblParams
			        where strItem = <cfqueryparam cfsqltype="cf_sql_varchar" value="DateBar">
			        </cfquery>
					<br /><a target="_blank" href="/Stats/StatsSummary.cfm"><span style="font-size:9px;">UPDATED #UCASE(
						getDateBar.strValue
					)#</span></a>
		    </p>
	    </div>
	</footer>
</cfoutput>

