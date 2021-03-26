<!---
Modification : Added a default parameter for form.transaction_number and an if statement to check for it
Date : Wednesday, December 11, 2002 9:09:29 AM

--->

<!--- 3/7/13 
	Determined that it is actually in use
--->

<cfparam name="Neg" default="Yes">
<cfparam name="form.Transaction_number" default="">
<cftry> 
<CFQUERY NAME="Results" DATASOURCE="#application.whDSN#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
        SELECT END_DATE as DISP_END_DATE, END_TIME as Time, RUN_NUMBER AS DISP_RUN_NUMBER
        FROM wh.RUN_CONTROL
        WHERE RUN_NUMBER =
      	(SELECT	MAX(RUN_NUMBER)
	FROM wh.RUN_CONTROL)
</CFQUERY>
		<cfcatch type="database">	
			<cfinclude template="/warehouseOfflineMessage.htm">
			<cfabort>
		</cfcatch>
		</cftry> 

<cfinclude template="/comptroller/includes/display_objects/custom/warrant/qryCalcOutstandingDt.cfm">

<cfif trim(form.Transaction_number) neq "">
	<cfquery name="statusCheck" datasource="#application.whDSN#" dbtype="ODBC">
	SELECT      STATUS
	FROM         WH.WARRANT_STATUS 
	WHERE       WARRANT = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCase(form.transaction_number)#" /></cfquery>

	<h3>Checking the Warrant Status of <cfoutput><b>#form.transaction_number#</b></cfoutput></h3>
	<cfif statusCheck.recordcount>
	 <cfif findNoCase(statusCheck.status, "O")> 
	<p>According to our records, warrant <cfoutput>#form.transaction_number#</cfoutput> was outstanding on <cfoutput>#CalcOutstandingDt#</cfoutput>.</p>
	<cfelse>
	<p style="color:red;">Warning: According to our records, warrant <cfoutput>#form.transaction_number#</cfoutput> was not outstanding on <cfoutput>#CalcOutstandingDt#</cfoutput>. If you need more information on this warrant, please contact our Records Center at 217 782-5897
	Monday through Friday between 8:30 - 4:30.</p>
	</cfif>
	
	<cfelse>
	<p>Warning: According to our records,<cfoutput> #form.transaction_number#</cfoutput> is not a valid warrant number.</p>
	</cfif>
	
	
<cfelse>
	<h3 align="center">Warrant Status Inquiry</h3>
</cfif>
<!--- include form again --->
<p><a href="/vendors/warrant-inquiry-form/">Click here to try again</a>.</p>
