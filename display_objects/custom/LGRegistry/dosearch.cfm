<!---  Select All and Clear All buttons --->
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function selectAll(cbList,bSelect) {
  for (var i=0; i<cbList.length; i++) 
    cbList[i].selected = cbList[i].checked = bSelect
}

function reverseAll(cbList) {
  for (var i=0; i<cbList.length; i++) {
    cbList[i].checked = !(cbList[i].checked) 
    cbList[i].selected = !(cbList[i].selected)
  }
}
//  End -->
</script>	

<!--- Help Popup --->
<script type="text/javascript" src="http://www.shawnolson.net/scripts/public_smo_scripts.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=1,width=420,height=230');");
}
// End -->
</script>

<!--- Style for fonts --->
<style><!--

.fl:link{color:#7777CC}
-->
</style>



<style type="text/css">
<!--
.style2 {
	font-size: 12px;
	color: #000000;
}
-->
</style>

<style type="text/css">
<!--
.style1 {font-size: 16px}
-->
</style>


<style type="text/css">
<!--
.style1 {font-size: 16px}
-->
</style>

<div>
<!--- after entering blank text --->
<cfif not isDefined("form.formname")>
	<cflocation URL="/financial-data/local-government-division/view-local-government-contact-information/">
</cfif>
<cfif form.formname eq "">You must enter some text!! To go back to the previous screen click </font><a HREF="javascript:history.back()">here.</a><cfabort></cfif>  
	<cfif #Len(form.formname)# LTE 2>
	  <p><font COLOR="red">A minimum of three characters are required for a search.</font><br> 
	</p>
	<div>To go back to the previous screen click </font><a HREF="javascript:history.back()">here.</a></div>
	  <cfabort></cfif><!------>

<CFIF ISDEFINED("FORM.Drill")>

<!--- drill down code --->
	<cfStoredProc datasource="AFRSQLPROD" Procedure="Reg_getListByName">
        <cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@UnitName" value="%#FORM.formName#%">
        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@alpha" value="#form.alpha#">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="RegSelectRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="RegSelectRetMsg">
        <cfprocresult name="Select">
	</cfstoredproc>

<cfelse>
	<!--- GO BUTTON IS PRESSED --->
    <cfstoredproc DATASOURCE="AFRSQLProd" PROCEDURE="Search_Registry">
     <cfprocparam CFSQLTYPE="cf_sql_varchar" DBVARNAME="@strUnitName" VALUE="#form.formname#" TYPE="in">
     <cfprocresult NAME="getList">
    </cfstoredproc>
</cfif>
<cfparam NAME="Form.formname" TYPE="string"> 
	<!--- no text error --->
<font COLOR="red">
<cfif #getList.RecordCount# LTE 0>
	<cfoutput>You have no results for #FORM.formname# as your key word search.</font>
	<p><font COLOR="black">To go back to the previous screen click </font><a HREF="javascript:history.back()">here.</a>
	</cfoutput>
</cfif> 

	<!--- results text --->
<cfoutput QUERY="getList" MAXROWS="1"><font color="black"><span class="style1">Your search for <em><strong>#FORM.formname#</strong></em>
  resulted in #getList.RecordCount# Unit Name(s)</span> </cfoutput>
<cfif #getList.RecordCount# GTE 1>
Click on the Unit Name you're interested, to display the Contact Information&nbsp; </em></strong>To go back to the previous screen click <a HREF="javascript:history.back()">here.</a></p>
</font></div>
<table width="100%">
<tr>

<!--- alpha sort menu --->
<CFOUTPUT>

<cfif getList.recordcount>
 <cfif not isDefined("form.drill")> 
	<cfset alphabet="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z">
	<cfset myAlphaList = "">
	<cfloop QUERY="getList">
		<cfset myAlpha = left(unitName, 1)>
		<cfif not listFind(myAlphaList,myAlpha)>
			<cfset myAlphaList = listAppend(myAlphaList,myAlpha)>
		</cfif>
	</cfloop>
	<span STYLE="text-align:center; ">
	<font color="black">Skip to Unit Starting With:</font><br><cfloop LIST="#alphabet#" INDEX="ii"> 
	<cfif listFind(myAlphaList,ii)>
		<form style="margin:0;background-color:##F7F7F8;display:inline;" ACTION="/financial-data/local-government-division/view-local-government-contact-information/search-contact-informaiton/" METHOD="POST">
		<INPUT TYPE="hidden" NAME="formname" VALUE="#form.formname#">
		<INPUT TYPE="hidden" NAME="alpha" VALUE="#ii#">
		<input TYPE="hidden" NAME="drill" VALUE="yes">
		<input TYPE="SUBMIT" NAME="go" VALUE="#ii#">
		</form>
	<cfelse>
		<font color="black"><span STYLE="color;silver;">| #ii# |</span></font>
	</cfif> 
	</cfloop>
	</span>
 <cfelse>
		<span STYLE="text-align:center; "><a HREF="javascript:history.back();">Go Back</a></span>
	</cfif> 
	</cfif>
<br>
<h2><font color="black">#getList.recordcount# Results <cfif isdefined("form.drill")>for Units beginning with <cfoutput>#form.alpha#</cfoutput></cfif>
</font></h2>
</cfoutput>

</tr>  
<tr>
<td></td>
<td width=""><font size="+1">Name</font></td>
<td><font size="+1">County</font></td>
    <td><font size="+1">Type</font></td>	
</tr>

	<!--- query for list --->
    <cfStoredProc datasource="AFRSQLPROD" Procedure="Reg_getList2">
        <CFIF ParameterExists(URL.RecordID)>
            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Code" value="#Trim(form.county)#">
        <cfelse>
            <cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@Code" null="yes">
        </CFIF>
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="ReggetListRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="ReggetListRetMsg">
        <cfprocresult name="GetRecord">
	</cfstoredproc>

<font color="red" size="2.5">
<!--- output list --->
<cfoutput QUERY="getList">

<tr>
	<td>
	<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" method="GET">
	<input type="checkbox" name="list" value="#code#">
	</td> 
	<td width=""><a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a></td>
	 <TD><a HREF="contact1.cfm?SelUnitCode=#code#">#County#</a></TD> 
	  <TD><a HREF="contact1.cfm?SelUnitCode=#code#">#Description#</TD></label>
<cfif "list" eq "">sfsdf</cfif></cfoutput>

<!--- navigation buttons --->
<INPUT type="submit" name="btnView"value="View Results">-<INPUT type="submit" name="ViewPDF" value="View PDF" target="test2.cfm">-<input type="button" value="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" ONCLICK="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input type="button" value="Help" onClick="javascript:popUp('Help.cfm')"></A> <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> 
<hr></form> 

</td>
    </tr>
</table></cfif>

	<!--- link to adobe reader download --->
	<!---
</cf_layout>
--->
<a href="http://www.adobe.com/acrobat/readstep.html"><img src="/iwgraph/GETACRO.gif"></a>

