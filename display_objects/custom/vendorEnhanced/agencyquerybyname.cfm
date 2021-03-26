<cfoutput><p style="color:silver;">#cgi.script_name#</p></cfoutput>
<CFQUERY NAME="AgcyList" DATASOURCE="#application.whDSN#"><!--- cachedwithin="#CreateTimeSpan(1,0,0,0)#"--->
SELECT * FROM #application.whOwner#AGENCY_#application.CFY#

WHERE AGENCY IN( 'IPS' , 'ACC')or ((agency = '799') OR (AGENCY < '699')) <!--- modified SR# 12026--->

ORDER BY NAME
</CFQUERY>