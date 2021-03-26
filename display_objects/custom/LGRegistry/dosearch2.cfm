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


<CFPARAM NAME="url.county" DEFAULT="">
<CFPARAM NAME="url.govType" DEFAULT="">
<CFPARAM NAME="url.alpha" DEFAULT="">
<CFPARAM NAME="newTypeList" DEFAULT="">

<CFIF ISDEFINED("url.drill")>

	<!--- drill down code --->
    <cfStoredProc datasource="AFRSQLPROD" Procedure="Reg_getListByName">
        <cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@UnitName" value="%#url.formName#%">
        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@alpha" value="#url.alpha#">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="RegSelectRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="RegSelectRetMsg">
        <cfprocresult name="getList">
    </cfstoredproc>


<cfelse>
	<!--- GO BUTTON IS PRESSED --->
    <cfstoredproc DATASOURCE="AFRSQLProd" PROCEDURE="Search_Registry">
         <cfprocparam CFSQLTYPE="cf_sql_varchar" DBVARNAME="@strUnitName" VALUE="#url.formname#" TYPE="in">
         <cfprocresult NAME="getList">
    </cfstoredproc>
</cfif>
<cfparam NAME="url.formname" TYPE="string"> 
	<!--- no text error --->
<cfif #getList.RecordCount# LTE 0>
	<cfoutput>You have no results for #url.formname# as your key word search.</font>
	<p><font COLOR="black">To go back to the previous screen click </font><a HREF="javascript:history.back()">here.</a>
	</cfoutput>
</cfif> 

	<!--- results text --->
<cfoutput QUERY="getList" MAXROWS="1"><font color="black"><span class="style1"><font color="Red">Your search for <em><strong>#url.formname#</strong></em>
  resulted in #getList.RecordCount# Unit Name(s)</font></span> </cfoutput>
<cfif #getList.RecordCount# GTE 1>
Click on the Unit Name you're interested, to display the Contact Information&nbsp; </em></strong>To go back to the previous screen click <a HREF="javascript:history.back()">here.</a></p>

<table width="100%">
<tr>

<!--- alpha sort menu --->
<CFOUTPUT>

<cfif getlist.recordcount>
 	<cfif not isDefined("form.drill")> 
		<cfset alphabet="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z">
		<cfset myAlphaList = "">
		<cfloop QUERY="getlist">
			<cfset myAlpha = left(unitName, 1)>
			<cfif not listFind(myAlphaList,myAlpha)>
				<cfset myAlphaList = listAppend(myAlphaList,myAlpha)>
			</cfif>
		</cfloop>

		Skip to Unit Starting With:<br><br>| <cfloop LIST="#alphabet#" INDEX="ii"> 
		<cfif listFind(myAlphaList,ii)>
			<a href="/financial-data/local-government-division/view-local-government-contact-information/contact-information-2/?alpha=#ii#&county=#url.county#&drill=Yes&govtype=#url.govtype#">#ii# |</a>
		<cfelse>
		 	#ii# |
		</cfif> 
		</cfloop>
 	<cfelse>
		<span STYLE="text-align:center; "><a HREF="javascript:history.back();">Go Back</a></span>
	</cfif> 
</cfif>
<br><br>
<h4><font color="black">#getList.recordcount# Results <cfif isdefined("url.drill")>for Units beginning with <cfoutput>#url.alpha#</cfoutput></cfif>
</font></h4><br>
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

<tr align="top">
	hello
	<form NAME="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" style="background-color:##F7F7F8;" METHOD="Post">
	<td align="left" valign="absmiddle"><input type="checkbox" name="list" value="'#code#'">
	</td> 
	<td width=""><a HREF=specific-contact-information/?&SelUnitCode=#code#">#UnitName#</a></td>
	 <TD><a HREF="specific-contact-information/?SelUnitCode=#code#">#County#</a></TD> 
	  <TD><a HREF="specific-contact-information/?SelUnitCode=#code#">#Description#</TD>
<cfif "list" eq ""></cfif>

</cfoutput>

<!--- navigation buttons --->
<INPUT type="submit" name="btnView"value="View Results">-<INPUT type="submit" name="ViewPDF" value="View PDF" target="test2.cfm">-<input type="button" value="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" ONCLICK="selectAll(this.form.list,false)"><A HREF="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')">-<input type="button" value="Help" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A> 
<hr>
</form> 

</td>
</tr>
</table>
</cfif>

	<!--- link to adobe reader download --->
	<!---
</cf_layout>
--->
<a href="http://www.adobe.com/acrobat/readstep.html"><img src="/iwgraph/GETACRO.gif"></a>

