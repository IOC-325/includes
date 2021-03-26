<!---
Modified Date: 4-27-12
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Enhanced Vendor Remittance Site per SR11108 based on the regular site but requiring a UserID/Password
--->

<!---
<cfparam name="vendorTin" default="#Session.vendTIN#">
--->

<cf_FormURL2Attributes>

<CFIF IsDefined ("form.INVSEL")>
 <CFSET INVSEL = form.INVSEL>
<cfelseif IsDefined ("URL.INVSEL")>
 <CFSET INVSEL = URL.INVSEL>
 <cfelse>
 <CFSET INVSEL = "">
</CFIF>

<CFIF IsDefined ("form.FY")>
 <CFSET FY = form.FY>
<cfelseif IsDefined ("URL.FY")>
 <CFSET FY = URL.FY>
</CFIF>


<CFIF IsDefined ("form.AGENCY")>
 <CFSET AGENCY = form.AGENCY>
<cfelseif IsDefined ("URL.AGENCY")>
 <CFSET AGENCY = URL.AGENCY>
</CFIF>

<CFIF IsDefined ("form.Contsel")>
 <CFSET Contsel = form.Contsel>
<cfelseif IsDefined ("URL.Contsel")>
 <CFSET Contsel = URL.Contsel>
</CFIF>

<CFIF IsDefined ("form.Status")>
 <CFSET Status = form.Status>
<cfelseif IsDefined ("URL.Status")>
 <CFSET Status = URL.Status>
 <cfelse>
 <CFSET Status = "All">
</CFIF>

<CFIF IsDefined ("form.SortBy")>
 <CFSET SortBy = form.SortBy>
<cfelseif IsDefined ("URL.SortBy")>
 <CFSET SortBy = URL.SortBy>
</CFIF>

<CFIF IsDefined ("form.AscDesc")>
 <CFSET AscDesc = form.AscDesc>
<cfelseif IsDefined ("URL.AscDesc")>
 <CFSET AscDesc = URL.AscDesc>
</CFIF>

<CFIF IsDefined ("form.SpreadsheetStartRow")>
 <CFSET SpreadsheetStartRow = form.SpreadsheetStartRow>
<cfelseif IsDefined ("URL.SpreadsheetStartRow")>
 <CFSET SpreadsheetStartRow = URL.SpreadsheetStartRow>
</CFIF>

<!--- <cfparam NAME="url.SpreadsheetStartRow" DEFAULT="1"> --->

<cfinclude template="vendorSQL.cfm">

<cfinclude template="toExcel.cfm">