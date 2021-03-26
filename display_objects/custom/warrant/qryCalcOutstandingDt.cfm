


<!--- Calculate Outstanding/Non-Outstanding Date --->
<cfoutput>
<cfset FndOutStandingDt = "False">
<cfset CalcOutstandingDt = DateFormat(DateAdd("D",-1,Now()),"mm/dd/yyyy")>
	
<cfloop condition = "FndOutStandingDt equal False"><cfoutput>
	<cfquery name="CheckHoliday" datasource="CommonProd" dbtype="ODBC">
		SELECT     Holiday
		FROM         StateHoliday
		WHERE       Holiday = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(CalcOutstandingDt,"mm/dd/yyyy")#" />
	</cfquery>
	
	<cfif  CheckHoliday.recordcount>
		<!--- Holiday...re-calculate date --->
		<cfset CalcOutStandingDt = DateFormat(DateAdd("D",-1,CalcOutStandingDt),"mm/dd/yyyy") >
		
	<cfelseif DatePart("w",DateFormat(CalcOutStandingDt,"mm/dd/yyyy")) gt 6>
		<!--- Saturday...re-calculate date --->
		<cfset CalcOutStandingDt = DateFormat(DateAdd("D",-1,CalcOutStandingDt),"mm/dd/yyyy") >

	<cfelseif DatePart("w",DateFormat(CalcOutStandingDt,"mm/dd/yyyy")) lt 2>
		<!--- Sunday...re-calculate date --->
		<cfset CalcOutStandingDt = DateFormat(DateAdd("D",-2,CalcOutStandingDt),"mm/dd/yyyy") >
		
	<cfelse>
		<!--- Week day...date is OK --->
		<cfset FndOutStandingDt = "True">
	
	</cfif>
	</cfoutput>
</cfloop>
</cfoutput> 

