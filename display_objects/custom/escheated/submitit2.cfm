
<cflock scope="session" type="READONLY" timeout="190">
<cfquery name="getName" datasource="#application.escheatDSN#">
SELECT FullName, Email, Phone
from EscheatUsers
where EscheaterID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.EscheaterID#" />
</cfquery>

</cflock>


<!--- <cfmail to="webmaster@IllinoisComptroller.Gov" cc="ciottim@IllinoisComptroller.Gov" from="webmaster@IllinoisComptroller.Gov" subject="Escheat Request for Warrant #form.Warrant#">
Request for Warrant #form.Warrant#
Legal Name: #form.LegalName#
From: #getName.FullName#
Relationship if Different from Inquirer's Name: #form.RelationShip#
Mailing Address:
#form.Addr1#
<cfif Addr2 neq "">#form.Addr2#</cfif>
#form.City#, #form.State# #form.Zip#

<cfif getName.Email neq "">
Email: #getName.Email#
</cfif> 

<cfif getName.Phone neq "">
Phone: #getName.Phone#
</cfif> 

</cfmail>--->


<cfif cgi.HTTP_HOST does not contain "dev">
<cfset lstMailTo="andy.peterson@illinoiscomptroller.gov,richard.damron@illinoiscomptroller.gov, bonnie.haschemeyer@illinoiscomptroller.gov, nikitha.tera@illinoiscomptroller.gov">
<cfloop LIST="#lstMailTo#" INDEX="ii">
<cfmail to="#ii#" cc="" from="webmaster@illinoiscomptroller.gov" subject="Escheat Request for Warrant #form.Warrant# (#form.LegalName#)">
Request for Warrant #form.Warrant#
Legal Name: #form.LegalName#
Requester: #form.fullName#
<cfif form.relationship neq "">

Relationship if Different from Inquirer's Name: #form.RelationShip#<BR />
</cfif>
Mailing Address:
#form.Addr1#

<cfif Addr2 neq "">#form.Addr2#<BR /></cfif>
#form.City#, #form.State# #form.Zip#

<cfif getName.Email neq "">
Email: #getName.Email#
</cfif>

<cfif getName.Phone neq "">
Phone: #getName.Phone#
</cfif>


</cfmail>
</CFLOOP>
</cfif>

<P>Your request has been submitted.

<P>Please allow four weeks for receipt of your Replacement Warrant Request and Affidavit.  If you do not receive these documents, or a letter of explanation within four weeks, please contact our Adjustments Section at (217) 785-1128 or you can write the Office at:</P>

Illinois Office of the Comptroller<BR>
Attn:  Adjustment Section<BR>
325 West Adams Street<BR>
Springfield , Il 62704-1871
</p>


