

<cfparam name="application.EscheatDSN" default="intra">
<script src="javascript.js" type="text/javascript"></script>

<!--- run query to determine if user exists --->
<!--- if user exists, proceed. If not...--->
<!--- inserting into SQL Server DB --->
<!--- set client variable --->

<cfinclude template="title.htm">
<cfparam name="email" default="">


<cfparam name="phone" default="">
<!--- <cfinsert datasource="SQLGeneral" tablename="EscheatUsers" formfields="Name,email,phone,Tin"> --->
<!--- <cftransaction action="begin"> --->


<!--- <cfdump var="#application.escheatDSN#"><cfabort> --->
<cfquery datasource="#application.escheatDSN#">
insert into EscheatUsers(FullName,Email,Phone)
values('#form.Fullname#', '#form.email#', '#form.phone#')
</cfquery>

<cfquery datasource="#application.escheatDSN#" name="getID">
select max(EscheaterID) as newID from EscheatUsers
</cfquery><!--- <CFABORT> --->

<cflock scope="session" timeout="200" type="exclusive">
	<!---<cfset session.TIN=form.TIN>--->
	<cfset session.EscheaterID=getID.newID>
</cflock>
<!--- </cftransaction> --->

<cfif isDefined("Session.EscheaterID")>
<!---
	<cfparam name="form.CheckThisTin" default="">
	<cfif form.CheckThisTin neq "">
		<cfset myName = ucase(left(form.payee_name, 4))>
		<cfquery name="Results" datasource="#application.CheckForCashDSN#">
		Select Warrant, Warrant_Amt as Amount, Issue_Date
		FROM WH.IOC_ESCHEATS
		where Vendor = '#form.TIN#'
		AND Payee_Name LIKE '#myName#%'
		</cfquery>

	
		<cfif results.recordcount>
		<cfinclude template="dspRecordsFound.cfm">
			<table align="center" width="80%" frame="box" rules="groups" border=1 cellpadding=3 cellspacing="0">
			<tr>
			<th>Warrant<br>Amount</th><th>Issue<br>Date</th><th>Inquire</th>
			</tr>
			<cfoutput query="results">
			<tr>
			<td align="right">#DollarFormat(Amount)#</td><td align="center">#DateFormat(Issue_Date, 'mm/dd/yyyy')#</td>
			<td>
			<a 
				onMouseOut="return setStatus('');" 
				onMouseOver="return setStatus('Request #Warrant#');" 
				title="Edit #Warrant#" 
				href="javascript:inquire('#Warrant#','#form.TIN#');"><font color="blue">Request Warrant Replacement</font></a>
			</td>
			</tr>
			</cfoutput>
			</table>
			<cfinclude TEMPLATE="toselect.cfm">
		<cfelse>
			<cfinclude template="dspSorry.htm">
		</cfif>
			
	<cfelse>
		
			<p>Please provide the 9 digit Vendor TIN you are inquiring about. Do not enter dashes or spaces.</p>
</cfif>
  --->
<cfinclude template="/comptroller/includes/display_objects/custom/escheated/checkForm.cfm">

<cfelse>

<!---<cflocation url="index.cfm">--->
</cfif>

