<!--- Pseudo Code for changes
Form for buttons created.
The buttons call the page doSearchActions.cfm to perform each function
The Help link creates a popup for instructions on using the buttons  --->
	

<!---  Select All and Clear All buttons --->
<SCRIPT LANGUAGE="JavaScript1.2">
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
<script TYPE="text/javascript" SRC="http://www.shawnolson.net/scripts/public_smo_scripts.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=1,width=420,height=230');");
}
// End -->
</script>


<CFINCLUDE TEMPLATE="CapFirst.cfm">
<CFINCLUDE TEMPLATE="celticMcCaps.cfm">

<CFPARAM NAME="form.county" DEFAULT="">
<CFPARAM NAME="form.govType" DEFAULT="">
<CFPARAM NAME="form.alpha" DEFAULT="">
<CFPARAM NAME="newTypeList" DEFAULT="">

<!--- Set text from param tags --->
 <cfif form.county eq "" and form.govType eq "" and form.alpha eq ""><p><span class="red">You must make a selection!!<br> To go back to the previous screen click </span><a href="javascript:history.back()">here.</a></p><cfabort></cfif>

	<cfif ISDEFINED("form.county") and form.county neq "">
		<cfset variables.newCountyList = Replace(form.county,","," County, ","All")>
		<cfset variables.newCountyList = Replace(variables.newCountyList, "'","","All")>
		<cfset variables.newCountyList = lCase(variables.newCountyList)>
	</cfif>
	
	<cfset newTypeList ="">	
	<cfif form.govType neq "">

		<cfif form.govType contains "1,2T"><!---  contains ",1,2" or form.govType eq "1,2" --->
			<!--- <cfset newTypeList = newTypeList & "Townships"> --->
			<cfset newTypeList = listAppend(newTypeList, "Township")>
			<!--- <cfset multiGov=multiGov&"True,"> --->
			<cfset form.govType=Replace(form.govType,"T","","ALL")>
			<cfset request.twpchange = "true">
		</cfif>	
		<cfif form.govType contains "30,31,32">
			<!--- <cfset newTypeList = newTypeList & ", Municipalities"> --->
			<cfset newTypeList = listAppend(newTypeList, "Municipalities")>
			<!--- <cfset multiGov=multiGov&"True,"> --->
		</cfif>	
        <!---	
		<cfif form.govType contains "3,4,5,7,8,9,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,33,34,40,38,29,75,36,53,51,54">
		--->
        <cfif url.govType contains "3,4,5,7,8,9,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,33,37,38,39,40,41,42,45,46,50,55">
			<!--- <cfset newTypeList = newTypeList & ", Other Special Districts"> --->
			<cfset newTypeList = listAppend(newTypeList, "Other Special Districts")>
			<!--- <cfset multiGov=multiGov&"True,"> --->
		</cfif>
		<cfif form.govType contains ",0" or listFirst(form.govType) eq "0">
			<!--- <cfset newTypeList = newTypeList & ", Counties"> --->
			<cfset newTypeList = listAppend(newTypeList, "Counties")> 
		</cfif>
		<cfif form.govType contains "12">
			<!--- <cfset newTypeList = newTypeList & ", Park Districts"> --->
			<cfset newTypeList = listAppend(newTypeList, "Park Districts")>
		</cfif>			
		<cfif form.govType contains "10">
			<!--- <cfset newTypeList = newTypeList & ", Public Library Districts"> --->
			<cfset newTypeList = listAppend(newTypeList, "Public Library Districts")>
		</cfif>			

		<!---<cfif form.govType contains "38,6">--->
       	<cfif form.govType contains "6">
			<!--- <cfset multiGov=multiGov&"True,"> --->
			<!--- <cfset newTypeList = newTypeList & ", Fire Protection Districts"> --->
			<cfset newTypeList = listAppend(newTypeList, "Fire Protection Districts")>
		</cfif>
		
	</cfif>
 
<!--- SEQUENCE 2 - 1 COUNTY, NO TYPES, NO ALPHA (type then alpha) --->
<CFIF form.county neq "" and form.county does not contain ","
	and form.govType eq ""
	and form.alpha eq "">
	<CFSET sortBy = "ORDER BY b.Description, unitName">
	<cfset sequence = 2>
	
<!--- SEQUENCE 3 - no COUNTY, 1 TYPE, NO ALPHA (County then alpha) --->
<CFELSEIF form.County eq ""
	and newTypeList neq "" and newTypeList does not contain ","
	and form.alpha eq "">
	<CFSET sortBy = "ORDER BY County, unitName">
	<cfset sequence = 3>
<!--- and form.govType neq "" and form.govType does not contain "," --->

<!--- SEQUENCE 4 - no COUNTY, no TYPE, 1 ALPHA (type then County then alpha) --->
<CFELSEIF form.County eq ""
	and form.govType eq ""
	and form.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, County, unitName">
	<cfset sequence = 4>
	
<!--- SEQUENCE 5 - multiple COUNTY, no TYPE, no ALPHA (County then alpha) --->
<CFELSEIF form.county neq "" and form.county contains ","
	and form.govType eq ""
	and form.alpha eq "">
	<CFSET sortBy = "ORDER BY county, b.Description, unitName">
	<cfset sequence = 5>	

<!--- SEQUENCE 6 - no COUNTY, multiple TYPE, no ALPHA (County then alpha) --->
<CFELSEIF form.county eq ""
	and newTypeList neq "" and newTypeList contains ","
	and form.alpha eq "">
	<CFSET sortBy = "ORDER BY b.Description, County, unitName">
	<cfset sequence = 6>
	
<!--- SEQUENCE 7 - no COUNTY, no TYPE, multiple ALPHA (County then alpha) --->
<CFELSEIF form.county eq ""
	and form.govType eq ""
	and form.alpha neq "" and form.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, County, unitName">
	<cfset sequence = 7>
	
<!--- SEQUENCE 8 - one COUNTY, one TYPE, no ALPHA (alpha) --->
<CFELSEIF form.county neq "" and form.county does not contain ","
	and newTypeList neq "" and newTypeList does not contain ","
	and form.alpha eq "">
	<CFSET sortBy = "ORDER BY County, b.Description, unitName">
	<cfset sequence = 8>
	
<!--- SEQUENCE 9 - one COUNTY, multiple TYPE, no ALPHA (type then alpha) --->
<CFELSEIF form.county neq "" and form.county does not contain ","
	and newTypeList neq "" and newTypeList contains ","
	and form.alpha eq "">
	<CFSET sortBy = "ORDER BY b.Description, unitName">
	<cfset sequence = 9>
	
<!--- SEQUENCE 10 - one COUNTY, one TYPE, one ALPHA (alpha) --->
<CFELSEIF form.county neq "" and form.county does not contain ","
	and newTypeList neq "" and newTypeList does not contain ","
	and form.alpha neq "" and form.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, County, unitName">
	<cfset sequence =10>
	
<!--- SEQUENCE 11 - one COUNTY, one TYPE, multiple ALPHA (alpha) --->
<CFELSEIF form.county neq "" and form.county does not contain ","
	and newTypeList neq "" and newTypeList does not contain ","
	and form.alpha neq "" and form.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, County, unitName">
	<cfset sequence =11>
	
<!--- SEQUENCE 12 - one COUNTY, multiple TYPE, one ALPHA (type then alpha) --->
<CFELSEIF form.county neq "" and form.county does not contain ","
	and newTypeList neq "" and newTypeList contains ","
	and form.alpha neq "" and form.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, unitName">
	<cfset sequence =12>
	
<!--- SEQUENCE 13 - one COUNTY, multiple TYPE, multiple ALPHA (type then alpha) --->
<CFELSEIF form.county neq "" and form.county does not contain ","
	and newTypeList neq "" and newTypeList contains ","
	and form.alpha neq "" and form.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, unitName">
	<cfset sequence =13>
	
<!--- SEQUENCE 14 - multiple COUNTY, one TYPE, no ALPHA (alpha) --->
<CFELSEIF form.county neq "" and form.county contains ","
	and newTypeList neq "" and newTypeList does not contain ","
	and form.alpha eq "">
	<CFSET sortBy = "ORDER BY county, b.Description, unitName">
	<cfset sequence =14>
	
<!--- SEQUENCE 15 - multiple COUNTY, multiple TYPE, no ALPHA (county, type then alpha) --->
<CFELSEIF form.county neq "" and form.county contains ","
	and newTypeList neq "" and newTypeList contains ","
	and form.alpha eq "">
	<CFSET sortBy = "ORDER BY county, b.Description, unitName">
	<cfset sequence =15>
	
<!--- SEQUENCE 16 - multiple COUNTY, one TYPE, one ALPHA (county then alpha) --->
<CFELSEIF form.county neq "" and form.county contains ","
	and newTypeList neq "" and newTypeList does not contain ","
	and form.alpha neq "" and form.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY county, b.Description, unitName">
	<cfset sequence =16>
	
<!--- SEQUENCE 17 - multiple COUNTY, one TYPE, multiple ALPHA (type, county then alpha) --->
<CFELSEIF form.county neq "" and form.county contains ","
	and newTypeList neq "" and newTypeList does not contain ","
	and form.alpha neq "" and form.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, county, unitName">
	<cfset sequence =17>
	
<!--- SEQUENCE 18 - multiple COUNTY, multiple TYPE, one ALPHA (county, type then alpha) --->
<CFELSEIF form.county neq "" and form.county contains ","
	and newTypeList neq "" and newTypeList contains ","
	and form.alpha neq "" and form.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY county, b.Description, unitName">
	<cfset sequence =18>
	
<!--- SEQUENCE 19 - multiple COUNTY, multiple TYPE, multiple ALPHA (type, county then alpha) --->
<CFELSEIF form.county neq "" and form.county contains ","
	and newTypeList neq "" and newTypeList contains ","
	and form.alpha neq "" and form.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, county, unitName">
	<cfset sequence =19>
	
<!--- SEQUENCE 20 - one COUNTY, no TYPE, one ALPHA (type then alpha) --->
<CFELSEIF form.county neq "" and form.county does not contain ","
	and newTypeList eq ""
	and form.alpha neq "" and form.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, unitName">
	<cfset sequence =20>
	
<!--- SEQUENCE 21 - one COUNTY, no TYPE, multiple ALPHA (type then alpha) --->
<CFELSEIF form.county neq "" and form.county does not contain ","
	and newTypeList eq ""
	and form.alpha neq "" and form.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, unitName">
	<cfset sequence =21>
	
<!--- SEQUENCE 22 - multiple COUNTY, no TYPE, one ALPHA (type, county then alpha) --->
<CFELSEIF form.county neq "" and form.county contains ","
	and newTypeList eq ""
	and form.alpha neq "" and form.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, county, unitName">
	<cfset sequence =22>
	
<!--- SEQUENCE 23 - multiple COUNTY, no TYPE, multiple ALPHA (type, county then alpha) --->
<CFELSEIF form.county neq "" and form.county contains ","
	and newTypeList eq ""
	and form.alpha neq "" and form.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, county, unitName">
	<cfset sequence =23>
	
<!--- SEQUENCE 24 - no COUNTY, one TYPE, one ALPHA (alpha) --->
<CFELSEIF form.county eq ""
	and newTypeList neq "" and newTypeList does not contain ","
	and form.alpha neq "" and form.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY county, b.Description, unitName ">
	<cfset sequence =24>
	
<!--- SEQUENCE 25 - no COUNTY, one TYPE, multiple ALPHA (county then alpha) --->
<CFELSEIF form.county eq ""
	and newTypeList neq "" and newTypeList does not contain ","
	and form.alpha neq "" and form.alpha contains ",">
	<CFSET sortBy = "ORDER BY County, b.Description, unitName">
	<cfset sequence =25>
	
<!--- SEQUENCE 26 - no COUNTY, multiple TYPE, one ALPHA (Type then county) --->
<CFELSEIF form.county eq ""
	and newTypeList neq "" and newTypeList contains ","
	and form.alpha neq "" and form.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, County">
	<cfset sequence =26>
	
<!--- SEQUENCE 27 - no COUNTY, multiple TYPE, multiple ALPHA (Type, county then alpha ) --->
<CFELSEIF form.county eq ""
	and newTypeList neq "" and newTypeList contains ","
	and form.alpha neq "" and form.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, County, unitName">
	<cfset sequence =27>
<CFELSE>
	<cfset sortBy = "ORDER BY County">
	<cfoutput>#form.County#</cfoutput>
    <cfset sequence =28>
</cfif>

<cfStoredProc datasource="AFRSQLPROD" Procedure="Get_CurrentFY">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCurrentFYRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCurrentFYRetMsg">
	<cfprocresult name="GetCurrentFY">
</cfstoredproc>

<cfStoredProc datasource="AFRSQLPROD" Procedure="Reg_Select">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@FY" value="#GetCurrentFY.FY#">
	<cfif isDefined("url.county") and trim(url.county) neq "" >
		<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@County" value="#trim(url.county)#">
    <cfelse>
    	<cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@County" null="yes">
	</CFIF>
    <cfif isDefined("url.govType") and trim(url.govType) neq "" >
    	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@govType" value="#trim(url.govType)#">
    <cfelse>
    	<cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@govType" null="yes">
    </cfif>
    <cfif isDefined("url.alpha") and trim(url.alpha) neq "" >
    	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@alpha" value="#trim(url.alpha)#">
    <cfelse>
    	<cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@alpha" null="yes">
    </cfif>
    <cfprocparam type="In"  cfsqltype="cf_sql_integer" dbvarname="@sequence" value="#sequence#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="RegSelectRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="RegSelectRetMsg">
	<cfprocresult name="Select">
</cfstoredproc>

<!---
<CFQUERY DATASOURCE="AFRSQLProd" NAME="select">
	Select  a.UnitName
	, a.Code
	, a.County
	, b.description 
	 FROM UnitData as a inner join tblC4 as b on a.C4 = b.C4
	WHERE 1=1
	<cfif isDefined("form.county") and form.county neq "">
	AND a.County IN (#Trim(PreserveSingleQuotes(form.county))#)
	</cfif>
	<cfif isDefined("form.govType") and form.govType neq "">	
	AND a.C4 IN (#form.govType#)
	</cfif> 
	<cfif isDefined("form.alpha") and form.alpha neq "">
	AND Left(a.UnitName,1) IN (#PreserveSingleQuotes(form.alpha)#)
	</cfif> 
	group by a.unitName, a.Code, b.description, a.county
	#sortBy#
	
</CFQUERY>
--->
 <CFOUTPUT><BR>
<table>

<tr>
<td>
 
 <!--- alpha sort table --->
<cfif select.recordcount>

 <cfif not isDefined("form.drill")> 
	<cfset alphabet="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z">
	<cfset myAlphaList = "">
	<cfloop QUERY="select">
		<cfset myAlpha = left(unitName, 1)>
		<cfif not listFind(myAlphaList,myAlpha)>
			<cfset myAlphaList = listAppend(myAlphaList,myAlpha)>
		</cfif>
	</cfloop>
	<span STYLE="text-align:center; " width="100%">
			<cfif newtypelist contains "Township">
			<cfset form.govType = replace(form.govType,"1,2","1,2T","Once")>
		</cfif>
	Skip to Unit Starting With:<br><br> <br><cfloop LIST="#alphabet#" INDEX="ii">
	<cfif listFind(myAlphaList,ii)>
		<form STYLE="display:inline;background-color:##F7F7F8; " ACTION="doDrilldown.cfm" METHOD="POST">
		<input TYPE="hidden" NAME="alpha" VALUE="'#ii#'">
		<input TYPE="hidden" NAME="county" VALUE="#form.county#">
		<input TYPE="hidden" NAME="drill" VALUE="yes">
		<input TYPE="hidden" NAME="govType" VALUE="#form.govType#">
		<input TYPE="SUBMIT" NAME="go" VALUE="#ii#">
		</form>
	<cfelse>
		<span STYLE="color;silver;">| #ii# |</span>
	</cfif> 
	</cfloop>
	</span>

 <cfelse>
		<span STYLE="text-align:center;"><a HREF="javascript:history.back();">Go Back</a></span>
	</cfif> 
	</cfif>

<h1>#select.recordcount# Results <cfif isdefined("form.drill")>for Units beginning with <cfoutput>#form.alpha#</cfoutput></cfif></h1>

<p>
<span CLASS="style1" style="nowarp">You have selected to look in 
	<cfif form.county neq "">
	 <b>#capFirst(variables.newCountyList)# County</b>
	</cfif>
	<cfif form.county neq "" AND form.govType neq ""><!---  AND form.alpha eq "" --->
	for 
	</cfif> 
	<cfif form.govType neq "">
	<cfset orTypes = replace(newtypelist,',',' or ', 'all')>
	<!--- <b>#newTypeList#</b>  --->
	<b>#orTypes#</b> 
	<!--- as your Type(s) of Government ---></cfif>
	<cfif form.govType neq "" AND form.alpha neq ""><!--- , and  --->
	</cfif>
	<cfif form.alpha neq "">
	<cfset orAlpha = rePlace(form.alpha,',',' or ','all')>
	<!--- that begin with the letter <b>#form.alpha#</b>. --->
	that begin with the letter <b>#oralpha#</b>.
	</cfif>
</cfoutput></span>
  <font COLOR="black">To go back to the previous screen click </font><a HREF="javascript:history.back()">here.</a>
<!--- <CFOUTPUT>	
<p>You have selected
	<cfif form.county neq "">
	 the following counties to search: #capFirst(variables.newCountyList)# County as your County(ies), 
	<!--- this could work if the user ever wanted the text below to show<CFELSE>
	 not to sort by county,  --->
	</cfif>
	<cfif form.govType neq "">
	#CapFirst(newTypeList)# as your Type(s) of Government, and
	</cfif>
	<cfif form.alpha neq "">
	 Local Governments beginning with the letter #form.alpha#.
	</cfif>
	
</cfoutput> --->
<p>
<!---<cfoutput>#sequence#</cfoutput>  --->
<!--- list selections --->
<cfparam NAME="sequence" DEFAULT="">
<cfif sequence eq 2>
<FORM Name="mon_formulaire" action="ButtonAction.cfm" style="background-color:##F7F7F8;" METHOD="GET" id="list">
<!--- <form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET"> --->

<INPUT TYPE="submit" NAME="btnView"VALUE="View Results"> -<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
<cfoutput QUERY="select" GROUP="Description"><!---  STARTROW="#startrow#" MAXROWS="#maxrows#" --->
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#" id="list">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#unitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 3>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" style="background-color:##F7F7F8;" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView" VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
<ul>
		<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#unitName# - #Description#</a>
		</cfoutput>
</ul>
	</cfoutput>
</form>	

<cfelseif sequence eq 4>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3>
		 	<ul>
		<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#unitName#</a>
		</cfoutput>
</ul>
	</cfoutput>
</cfoutput>
</form>
<cfelseif sequence eq 5>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County# County</h3><!---  - #UnitName# --->
<ul>
		<cfoutput GROUP="Description">
		<h3 STYLE="font-size:13px; text-indent:5px; ">#Description#</h3>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#unitName#</a>
			</cfoutput>
			<hr> 
		</cfoutput>
</ul>
	</cfoutput>
</form>
<cfelseif sequence eq 6>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3>
		 	<ul>
		<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#unitName#</a>
		</cfoutput>
</ul>
	</cfoutput>
</cfoutput>
</form>
<cfelseif sequence eq 7>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#unitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>	
<cfelseif sequence eq 8>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>

	<cfoutput QUERY="select" GROUP="Description">
	<h3>#County#</h3> <!--- --->
		<cfoutput GROUP="Description">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(Description))#</h3> 
		 	<ul> <!------>
			<cfoutput GROUP="unitName">
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#unitName# - #Description#</a>
			</cfoutput>
			</ul>
		</cfoutput><!---  --->
	</cfoutput>
</form>
<cfelseif sequence eq 9>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<!--- <cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3> --->
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#unitName#</a>
			</cfoutput>
			</ul>
		<!--- </cfoutput> --->
	</cfoutput>
</form>	
<cfelseif sequence eq 10>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3><!---  --->
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName# - #Description#</a>
			</cfoutput>
			</ul>
		</cfoutput> <!--- --->
	</cfoutput>
</form>
<cfelseif sequence eq 11>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<!--- <cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3> --->
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		<!--- </cfoutput> --->
	</cfoutput>
</form>		
<cfelseif sequence eq 12>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<!--- <cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3> --->
		 	<ul>
			<cfoutput>
			<li>
			<input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		<!--- </cfoutput> --->
	</cfoutput>
</form>		
<cfelseif sequence eq 13> 
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<!--- <cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3> --->
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		<!--- </cfoutput> --->
	</cfoutput>
</form>		
<cfelseif sequence eq 14>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(Description))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName# - #Description#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>	
<cfelseif sequence eq 15>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(Description))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>	
<cfelseif sequence eq 16>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(Description))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>	
<cfelseif sequence eq 17>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="county">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(select.County))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>	
<cfelseif sequence eq 18>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(Description))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 19>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description"><!---  STARTROW="#startrow#" maxrows="#max#" --->
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
	&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form> 

<cfelseif sequence eq 20>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 21>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 22>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 23>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 24>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description"> 
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(Description))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 25>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(Description))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 26>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)"><A HREF="javascript:popUp('test.cfm')">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 27>
<form NAME="mon_formulaire" ACTION="ButtonAction.cfm" METHOD="GET">
<INPUT TYPE="submit" NAME="btnView"VALUE="View Results">-<INPUT TYPE="submit" NAME="ViewPDF" VALUE="View PDF">-<input TYPE="button" VALUE="Select all" onClick="selectAll(this.form.list,true)">-<INPUT TYPE=button VALUE="Clear All" onClick="selectAll(this.form.list,false)">-<input TYPE="button" VALUE="Help" onClick="javascript:popUp('Help.cfm')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> <hr>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))#</h3>
		 	<ul>
			<cfoutput>
			<li><input TYPE="checkbox" NAME="list" VALUE="#code#">
			&nbsp;<a HREF="contact1.cfm?SelUnitCode=#code#">#UnitName#</a>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput> <!--- --->
	</form>
<!--- <cfelse>
Doesn't match! --->
</cfif> 
</td></tr></table>
<!---
</cf_layout>
--->
<!--- link to adobe reader download --->
<a HREF="http://www.adobe.com/acrobat/readstep.html"><img SRC="/iwgraph/getacro.gif"></a>