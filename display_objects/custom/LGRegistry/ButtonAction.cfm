<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>Contact Information</TITLE>
</HEAD>

<BODY>

<cfif isDefined("form.ViewPDF")>

<cfinclude template="resultsPDF.cfm">

</cfif>

<cfif isDefined("form.btnView")>
<cfinclude template="MultiResults.cfm">

</cfif>

</BODY>
</HTML>
