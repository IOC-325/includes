<cfquery name="Record" DATASOURCE="General">
Select id, monthUpload, stFileName, intMonth, intYear 
from tblExhibit1 
order by intMonth, intYear
</cfquery>
<!---actFetchFile.cfm--->

<cfif isDefined("form.STFILENAME")>
<cfoutput>
<h3>Opening #stFileName# in a new window.</h3>

<p>If the file did not open for you, then click on the button below to get your file.</p>

<script language="javascript">
window.open('http://www.wh1.ioc.state.il.us/fiscalcondition/#stFileName#','mywindow','width=400,height=200');
</script>

<cfFORM>
<cfINPUT NAME="button" type="button" value="Get #stFileName#" onClick="window.open('http://www.wh1.ioc.state.il.us/fiscalcondition/#stFileName#','mywindow','width=400,height=200')">
</cfFORM> 


</cfoutput>
<!---<cflocation url="#stfilename#">. --->

<cfabort>
</cfif>

<cfFORM ACTION="/comptroller/index.cfm/fiscal-condition/general-funds-revenues-and-expenditures/" METHOD="post" NAME="Record">

<INPUT TYPE="hidden" NAME="fuseaction" VALUE="displayExhibit">
    General Funds Revenues 
    and Expenditures:

    <SELECT NAME="stFileName" SIZE="1">
      <cfoutput query="Record"> 
	  <CFSWITCH EXPRESSION="#intMonth#">
	<CFCASE VALUE="1">
		<CFSET strMonth = "January">
	</CFCASE>
	<CFCASE VALUE="2">
		<CFSEt strMonth = "February">
	</CFCASE>
	<CFCASE VALUE="3">
		<CFSET strMonth = "March">
	</CFCASE>
	<CFCASE VALUE="4">
		<CFSET strMonth = "April">
	</CFCASE>
	<CFCASE VALUE="5">
		<CFSET strMonth = "May">
	</CFCASE>
	<CFCASE VALUE="6">
		<CFSET strMonth = "June">
	</CFCASE>
	<CFCASE VALUE="7">
		<CFSET strMonth = "July">
	</CFCASE>
	<CFCASE VALUE="8">
		<CFSET strMonth = "August">
	</CFCASE>
	<CFCASE VALUE="9">
		<CFSET strMonth = "September">
	</CFCASE>
	<CFCASE VALUE="10">
		<CFSET strMonth = "October">
	</CFCASE>
	<CFCASE VALUE="11">
		<CFSET strMonth = "November">
	</CFCASE>
	<CFCASE VALUE="12">
		<CFSET strMonth = "December">
	</CFCASE>

	<CFDEFAULTCASE>
		<CFSET strMonth = "Unknown">
	</CFDEFAULTCASE>
</CFSWITCH>
        <OPTION VALUE="#stFileName#">#strMonth# #intYear#</OPTION>
      </cfoutput>  
    </SELECT><INPUT TYPE="submit" NAME="Go" VALUE="GO">
  </cfFORM>
  
<HR>
<P> Or select from the list below.</P>
<!--- spreadsheet links --->
All General Funds Revenues and Expenditures 
<cfquery DATASOURCE="General" name="uploadExample">
Select id, monthUpload, stFileName, intMonth, intYear from tblExhibit1
order by intMonth, intYear
</cfquery>
<ul style="list-style-type: none;margin: 5px 0 0 0;padding: 0;">
<cfoutput query="uploadExample">

<CFSWITCH EXPRESSION="#intMonth#">
	<CFCASE VALUE="1">
		<CFSET strMonth = "January">
	</CFCASE>
	<CFCASE VALUE="2">
		<CFSEt strMonth = "February">
	</CFCASE>
	<CFCASE VALUE="3">
		<CFSET strMonth = "March">
	</CFCASE>
	<CFCASE VALUE="4">
		<CFSET strMonth = "April">
	</CFCASE>
	<CFCASE VALUE="5">
		<CFSET strMonth = "May">
	</CFCASE>
	<CFCASE VALUE="6">
		<CFSET strMonth = "June">
	</CFCASE>
	<CFCASE VALUE="7">
		<CFSET strMonth = "July">
	</CFCASE>
	<CFCASE VALUE="8">
		<CFSET strMonth = "August">
	</CFCASE>
	<CFCASE VALUE="9">
		<CFSET strMonth = "September">
	</CFCASE>
	<CFCASE VALUE="10">
		<CFSET strMonth = "October">
	</CFCASE>
	<CFCASE VALUE="11">
		<CFSET strMonth = "November">
	</CFCASE>
	<CFCASE VALUE="12">
		<CFSET strMonth = "December">
	</CFCASE>

	<CFDEFAULTCASE>
		<CFSET strMonth = "Unknown">
	</CFDEFAULTCASE>
</CFSWITCH>
	<LI style="background: url(/comptroller/includes/themes/submersion/images/sidebar-list.png) no-repeat top left;
	padding: 0 0 3px 10px;
	margin: 0 0 3px 0;
	word-wrap: break-word;"><A HREF="http://www.wh1.ioc.state.il.us/fiscalcondition/#stFileName#"><u>#strMonth# #intYear#</u></A></LI>
</cfoutput>
</ul>


