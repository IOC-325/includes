<cf_layout>
<h1>Whoops!</h1>
<!--- <p>You have been timed out of the system. A timeout occurs if you are inactive on this site for over 20 minutes. Please <a href="index.cfm">re-register</a>.</p> --->

<h3>An Error Has Occurred</h3>
<p>An error has occurred and an email has been sent to the webmaster. Here are the details.</p>
<cfoutput>
<!--- <cfif isdefined("error.GeneratedContent")>
<br>Generated Content: #Error.GeneratedContent#
</cfif> --->
<cfif isdefined("Error.ExtendedInfo")>
<br>Extended Info: #Error.ExtendedInfo#
</cfif>
<cfif isdefined("Error.Diagnostics")>
<br>Diagnostics: #Error.Diagnostics#
</cfif>
<cfif isdefined("error.Template")>
<br>Template: #Error.Template#
</cfif>
<cfif isdefined("Form.FieldNames")>
	<cfloop list="#Form.Fieldnames#" index="field">
	 #Field# = #Evaluate("form.#Field#")#<br>
	</cfloop>
</cfif>
<cfif isDefined("cgi.Path_info")>
<br>Path: #cgi.Path_Info#
</cfif>

<cfif isdefined("cgi.http_referer")>
 <br>Referer: #cgi.http_referer#
</cfif>

<cfif isdefined("cgi.query_string")>
 <br>Query String: #cgi.query_string#
</cfif>

<cfif isdefined("cgi.cf_template_path")>
 <br>Template Path: #Cgi.cf_template_path#
</cfif>

<cfif isdefined("client.urltoken")>
 <br>Token: #client.URLToken#
</cfif>

<cfif isdefined("cgi.Remote_addr")>
 <br>Remote Address: #cgi.Remote_Addr#)
</cfif>

<cfif isdefined("cgi.Path_Translated")>
<br>Translated Path: #cgi.Path_Translated#
</cfif>

<p>An email is being sent to the administrator.</p>
</cfoutput>
<cfmail to="webmaster@IllinoisComptroller.Gov" from="webmaster@IllinoisComptroller.Gov" type="HTML" subject="Escheat Error">

<table border="1">
<tr>
<td>

<p>On #dateFormat(Now(), "mm/dd/yyyy")# at #timeFormat(now(), "hh:mm tt")#, the following error occurred:

<cfif isdefined("error.GeneratedContent")>
<br>Generated Content: #Error.GeneratedContent#
</cfif>
<cfif isdefined("Error.ExtendedInfo")>
<br>Extended Info: #Error.ExtendedInfo#
</cfif>
<cfif isdefined("Error.Diagnostics")>
<br>Diagnostics: #Error.Diagnostics#
</cfif>
<cfif isdefined("error.Template")>
<br>Template: #Error.Template#
</cfif>
<cfif isdefined("Form.FieldNames")>
	<cfloop list="#Form.Fieldnames#" index="field">
	 #Field# = #Evaluate("form.#Field#")#<br>
	</cfloop>
</cfif>
<cfif isDefined("cgi.Path_info")>
<br>Path: #cgi.Path_Info#
</cfif>

<cfif isdefined("cgi.http_referer")>
 <br>Referer: #cgi.http_referer#
</cfif>

<cfif isdefined("cgi.query_string")>
 <br>Query String: #cgi.query_string#
</cfif>

<cfif isdefined("cgi.cf_template_path")>
 <br>Template Path: #Cgi.cf_template_path#
</cfif>

<cfif isdefined("client.urltoken")>
 <br>Token: #client.URLToken#
</cfif>

<cfif isdefined("cgi.Remote_addr")>
 <br>Remote Address: #cgi.Remote_Addr#)
</cfif>

<cfif isdefined("cgi.Path_Translated")>
<br>Translated Path: #cgi.Path_Translated#
</cfif>

</td>
</tr>


</table>


</cfmail>

</cf_layout>
