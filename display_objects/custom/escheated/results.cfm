
<cfif isdefined("form.payee_name")>
<script src="javascript.js"></script>
<!--- <cfinclude template="../common/dsp_top.cfm"> --->


<cfinclude template="ListPayeeName.cfm">



<cfinclude template="title.htm"> 

<cfparam NAME="variables.numHigh" DEFAULT=0>

<cfif results.recordcount>
	<h3 align="center">Warrant(s) Found</h3>
	<cfoutput>


		<!--- <cfinclude template="dspRecordsFound.cfm"> --->

</cfoutput>

<cfif variables.numHigh gt 0>
<p>Our records indicate that there is at least one escheated warrant that may be replaceable under this Vendor Name. Due to the nature or value of the escheated warrant(s), you must contact our Adjustment Section at (217) 785-1128 to further process your request, or you can write our Office at:</p>

<p>Illinois Office of the Comptroller<br />
Attn: Adjustment Section<BR>
325 West Adams Street<BR>
Springfield, IL 62704-1871</p>
</cfif>
<!--- <cfif results.recordcount
and variables.numHigh lt 1>
<table align="center" width="80%" frame="box" rules="groups" border=1 cellpadding=3 cellspacing="0">
<tr>
<th>Payee Name</th>
<th>Issue<br>Date</th><th>Inquire</th>
</tr>
</cfif> --->
<!--- <cfdump var="#results#"> --->

<p>Our records indicate there 

<cfif results.recordcount gt 1>are <cfelse>is </cfif>
 <cfoutput> #results.recordcount#</cfoutput> escheated warrant<cfif results.recordcount gt 1>s</cfif> that may be replaceable <!--- to (NAME)  --->under this Vendor Name . If you want to start the replacement process<cfif results.recordcount gt 1> for any warrant listed below</cfif>, please click on the "Request Warrant Replacement" to the right of the warrant.</p>
<cfset loopyloop=0>
<cfoutput query="results">
<!--- <cfif results.WARRANT_AMT gt "10000">
	<cfset variables.numHigh = variables.numHigh + 1>
<cfelse>
<cfif variables.numHigh eq 0>--->
<cfif loopyloop eq 0> 
<table align="center" width="80%" frame="box" rules="groups" border=1 cellpadding=3 cellspacing="0">
<tr>
<th>Payee Name</th>
<th>Issue<br>Date</th><th>&nbsp;</th>
</tr>
</cfif>
<cfset loopyloop = 1>
<tr>
<td align="center">#reReplace("#Payee_Name#","\s+"," ","All")#</td>
<!--- <td align="center">#DollarFormat(WARRANT_AMT)#</td> --->
<td align="center">#DateFormat(Issue_Date, 'mm/dd/yyyy')#</td>

             <cfset key="654321">         

            <td align="center">
			<a href="/?LinkServID=832E2B31-5056-93B5-5E3C9C48097599AA&warrant=#URLEncodedFormat(Encrypt(warrant,"#key#"))#" ><font color="blue">Request Warrant Replacement</font></a> 
			</td>
			
</tr>
<!--- </cfif>
</cfif> --->
</cfoutput>
<cfif results.recordcount and variables.numHigh lt 1>
</table>
</cfif>

<cfinclude TEMPLATE="toselect.cfm">
<cfset notFirstTry="True">
</p>
<!--- <p>More text supplied by SAD.</p> --->
<cfelse>
	<cfinclude template="dspSorry.htm">
</cfif>
<!--- <p>Enter another TIN or SSN: --->
<cfinclude template="checkForm.cfm">


<cfelse>
<cflocation url="Index.cfm">
</cfif>
