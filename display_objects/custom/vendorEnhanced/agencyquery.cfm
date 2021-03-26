<!---<cfoutput><p style="color:silver;">#cgi.script_name#</p></cfoutput>--->
<CFQUERY NAME="AgcyList" DATASOURCE="DB2PRD"><!--- cachedwithin="#CreateTimeSpan(1,0,0,0)#"--->
SELECT * FROM #application.whOwner#AGENCY_#application.CFY#

WHERE AGENCY IN( 'IPS' , 'ACC') or ((agency = '799') OR (agency = '899') OR(AGENCY < '699')) <!--- modified SR# 12026--->

ORDER BY AGENCY
</CFQUERY>