<cfquery NAME="MatchSSN" DATASOURCE="#application.CheckForCashDSN#">
Select  LTRIM(RTRIM(SUBSTR(VENDOR, 6,4))) as SSN
FROM WH.IOC_ESCHEATS
where Warrant = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Warrant#" />
</cfquery>




<cfif #MatchSSN.SSN# neq LTRIM(RTRIM(#form.SSN#)) >
	<cfoutput>The SSN you have provided do not match the Payee's SSN. If you wish to try again, Please click on the Back button below.</cfoutput>
<form action="/?LinkServID=8176F89B-5056-93B5-5E375259C47E9741" method="Post">
<br><div align="center"><input type="Submit" value="Back">
</div>
</form>


<cfelse>
	<form action="/?LinkServID=834FEB73-5056-93B5-5EC5907F812F617C" method="Post">
<cfoutput>

<p>I, #form.FullName#,  authorize the Office of the Comptroller to replace warrant number #form.Warrant# .  The information I have provided is current and accurate.  I am legally entitled to make this request.  I understand that the Office of the Comptroller will respond to this request by sending to me a Replacement Warrant Request and Affidavit for my completion and signature.  I further understand that I must sign the Affidavit, and if the warrant amount exceeds $500.00, I must have my signature notarized.   I understand that the replacement process can not be completed until I return the Replacement Warrant Request and Affidavit to the Office of the Comptroller.
<br />



<input type="Hidden" name="Warrant" value="#warrant#">

<input type="Hidden" name="FullName" value="#form.FullName#">
<input type="Hidden" name="LegalName" value="#form.LegalName#">


<input type="hidden" name="Addr1" value="#form.Addr1#">
<input type="hidden" name="Addr2" value="#form.Addr2#">
<input type="hidden" name="City" value="#form.city#">
<input type="hidden" name="State" value="#form.State#">
<input type="hidden" name="Zip" value="#form.zip#">

<input type="hidden" name="Relationship" value="#form.relationship#">

<br><div align="center"><input type="Submit" value="Submit Request">
</div>
</form>
</p>  </cfoutput>
</cfif>
</body></html>



