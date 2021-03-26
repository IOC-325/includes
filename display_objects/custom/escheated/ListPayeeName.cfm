<cfif isdefined("form.payee_name")>
<cfif LEN(form.payee_name) gte 3>
<cfset myName = LTRIM(RTRIM(ucase(form.payee_name)))>

<cfquery name="Results" datasource="#application.CheckForCashDSN#">
Select  PAYEE_NAME , WARRANT_AMT , ISSUE_DATE , WARRANT
FROM WH.IOC_ESCHEATS
where PAYEE_NAME LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#myName#%" />
order by PAYEE_NAME
</cfquery><!--- order by replace(PAYEE_NAME,'      ',' ') ASC --->

<cfelseif LEN(form.payee_name) eq 2>
<cfset myName = LTRIM(RTRIM(ucase(form.payee_name)))>
<cfquery name="Results" datasource="#application.CheckForCashDSN#">
Select * 
FROM WH.IOC_ESCHEATS
where Payee_Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#myName# %" />
order by replace(PAYEE_NAME,'      ',' ') ASC
</cfquery>

<cfelseif LEN(form.payee_name) eq 1>
<cfset myName = LTRIM(RTRIM(ucase(form.payee_name)))>
<cfquery name="Results" datasource="#application.CheckForCashDSN#">
Select * 
FROM WH.IOC_ESCHEATS
where Payee_Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#myName# %" />
order by replace(PAYEE_NAME,'      ',' ') ASC
</cfquery>

</cfif>
</cfif>

