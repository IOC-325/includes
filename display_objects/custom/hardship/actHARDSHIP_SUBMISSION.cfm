<cfif not isDefined("form.tin")>
	
	<cflocation url="#variables.FormPage#">
	
</cfif>

<cfif form.Tin neq form.tin2>
		<p>Sorry, your Taxpayer Identification Numbers do not match. Please <a href="javascript:history.back();">go back.</a></p>
<cfelse>
<CFSET VARIABLES.MYKEY = "ITBG">
<cfset VARIABLES.REMOVE_SPACES_IN_LAST_NAME = Replace(FORM.NAMELAST, " ", "", "ALL")>
<CFSET VARIABLES.FIRSTFOUR = RIGHT(VARIABLES.REMOVE_SPACES_IN_LAST_NAME,4)>
<CFSET VARIABLES.MIDDLEFOUR = RANDRANGE(1000,9999)>
<CFSET VARIABLES.LASTSIX = DATEFORMAT(NOW(),"MMDDYY")>
<CFSET VARIABLES.UNIQUE_ID = ucase(VARIABLES.FIRSTFOUR) & "-" & VARIABLES.MIDDLEFOUR & "-" & VARIABLES.LASTSIX>

<CFSET form.tin = encrypt(form.tin,variables.mykey)>

<cfstoredproc procedure="HARDSHIP_APPLICANT_INSERT" datasource="ELECTRONIC_COMMERCE" returncode="1">

	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@HARDSHIP_ID" value="#VARIABLES.UNIQUE_ID#">
    <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@NameFirst" value="#FORM.NAMEFIRST#">
    <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@NAMELAST" value="#FORM.NAMELAST#">	
    <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@MIDDLE_INITIAL" value="#FORM.MIDDLE_INITIAL#">	
    <cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@TITLE" value="#FORM.TITLE#">
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@COMPANY" value="#FORM.COMPANY#">
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@ADDRESS" value="#FORM.ADDRESSL#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" dbvarname="@ADDRESS_2" VALUE="#FORM.ADDRESS2#"> 
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@CITY" value="#FORM.CITYL#">
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@STATE" value="#FORM.STATEL#">
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@ZIP" value="#FORM.ZIPL#">
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@ZIP_PLUS_4" value="#FORM.ZipPlus4#">
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@PHONE" value="#FORM.PHONEL#">
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@EMAIL" value="#FORM.EMAILL#">
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@AGENCIES" value="#FORM.agencyl#">
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@TIN" value="#FORM.TIN#">
	<cfprocparam cfsqltype="cf_sql_varchar" dbvarname="@PETITION_TYPE" value="#FORM.Petition_Type#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" dbvarname="@HARDSHIP_REASON" VALUE="#FORM.limitedtextarea#">
	
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="RetMsg">
	<cfprocparam type="Out" cfsqltype="CF_SQL_integer" dbVarName = "@RetVal" variable="RetVal" >
	
</cfstoredproc>

<cfif RetVal eq "0">

<P>Thank you for submitting your Direct Deposit Hardship Petition.</P>

<p>PETITION NUMBER: <cfoutput>#VARIABLES.UNIQUE_ID#</cfoutput>

<P>Please save this number for your records.</P>

<p>Your Hardship Petition will be reviewed by staff at the Comptroller's Office.  You will receive an e-mail when the review of your petition is complete.</p>

<p>If approved, you will receive hard-copy warrants without additional cost.</p>

<p>If denied, you will have the option to sign-up for direct deposit or receive hard-copy warrants and be subject to a $2.50 per warrant processing fee as established by <a href="http://ilga.gov/legislation/publicacts/fulltext.asp?Name=097-0348&GA=97">Public Act 97-0348</a>.</p>


<!--- This is in the rrot folder i.e. Main folder --->
<cfinclude template="/hardship_form_petition_email.cfm" >

<cfelse>
	
	<h3>An Error Has Occurred</h3>
	<p>#RetMsg#</p>

</cfif>

</cfif>