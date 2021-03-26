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
<script type="text/javascript" SRC="http://www.shawnolson.net/scripts/public_smo_scripts.js"></script>
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

<CFPARAM name="url.county" DEFAULT="">
<CFPARAM name="url.govtype" DEFAULT="">
<CFPARAM name="url.alpha" DEFAULT="">
<CFPARAM name="newtypeList" DEFAULT="">

<!--- Set text from param tags --->
<cfoutput>
 <cfif url.county eq "" and url.govtype eq "" and url.alpha eq ""><p><span class="red">You must make a selection!!</span><br> To go back to the previous screen click <a href="javascript:history.back()">here.</a></p><cfabort></cfif>
</cfoutput>
	<cfif ISDEFINED("url.county") and url.county neq "">
		<cfset variables.newCountyList = Replace(url.county,","," County, ","All")>
		<cfset variables.newCountyList = Replace(variables.newCountyList, "'","","All")>
		<cfset variables.newCountyList = lCase(variables.newCountyList)>
	</cfif>
	
	<cfset newtypeList ="">	

	<cfif url.govtype neq "">

		<cfif url.govtype contains "1,2T"><!---  contains ",1,2" or url.govtype eq "1,2" --->
			<!--- <cfset newtypeList = newtypeList & "Townships"> --->
			<cfset newtypeList = listAppend(newtypeList, "Township")>
			<!--- <cfset multiGov=multiGov&"True,"> --->
			<cfset url.govtype=Replace(url.govtype,"T","","ALL")>
			<cfset request.twpchange = "true">
		</cfif>	
		<cfif url.govtype contains "30,31,32">
			<!--- <cfset newtypeList = newtypeList & ", Municipalities"> --->
			<cfset newtypeList = listAppend(newtypeList, "Municipalities")>
			<!--- <cfset multiGov=multiGov&"True,"> --->
		</cfif>	
        <!---	
		<cfif url.govtype contains "3,4,5,7,8,9,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,33,34,40,38,29,75,36,53,51,54">
		--->
       <cfif url.govtype contains "3,4,5,7,8,9,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,33,37,38,39,40,41,42,45,46,50,51,53,54,55">
			<!--- <cfset newtypeList = newtypeList & ", Other Special Districts"> --->
			<cfset newtypeList = listAppend(newtypeList, "Other Special Districts")>
			<!--- <cfset multiGov=multiGov&"True,"> --->
		</cfif>
		<cfif url.govtype contains ",0" or listFirst(url.govtype) eq "0">
			<!--- <cfset newtypeList = newtypeList & ", Counties"> --->
			<cfset newtypeList = listAppend(newtypeList, "Counties")> 
		</cfif>
		<cfif url.govtype contains "12">
			<!--- <cfset newtypeList = newtypeList & ", Park Districts"> --->
			<cfset newtypeList = listAppend(newtypeList, "Park Districts")>
		</cfif>			
		<cfif url.govtype contains "10">
			<!--- <cfset newtypeList = newtypeList & ", Public Library Districts"> --->
			<cfset newtypeList = listAppend(newtypeList, "Public Library Districts")>
		</cfif>			

		<!---<cfif url.govtype contains "38,6">--->
        <cfif url.govtype contains "6">
			<!--- <cfset multiGov=multiGov&"True,"> --->
			<!--- <cfset newtypeList = newtypeList & ", Fire Protection Districts"> --->
			<cfset newtypeList = listAppend(newtypeList, "Fire Protection Districts")>
		</cfif>
		
	</cfif>
 
<!--- SEQUENCE 2 - 1 COUNTY, NO typeS, NO ALPHA (type then alpha) --->
<CFIF url.county neq "" and url.county does not contain ","
	and url.govtype eq ""
	and url.alpha eq "">
	<CFSET sortBy = "ORDER BY b.Description, unitname">
	<cfset sequence = 2>
	
<!--- SEQUENCE 3 - no COUNTY, 1 type, NO ALPHA (County then alpha) --->
<CFELSEIF url.county eq ""
	and newtypeList neq "" and newtypeList does not contain ","
	and url.alpha eq "">
	<CFSET sortBy = "ORDER BY County, unitname">
	<cfset sequence = 3>
<!--- and url.govtype neq "" and url.govtype does not contain "," --->

<!--- SEQUENCE 4 - no COUNTY, no type, 1 ALPHA (type then County then alpha) --->
<CFELSEIF url.county eq ""
	and url.govtype eq ""
	and url.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, County, unitname">
	<cfset sequence = 4>
	
<!--- SEQUENCE 5 - multiple COUNTY, no type, no ALPHA (County then alpha) --->
<CFELSEIF url.county neq "" and url.county contains ","
	and url.govtype eq ""
	and url.alpha eq "">
	<CFSET sortBy = "ORDER BY county, b.Description, unitname">
	<cfset sequence = 5>	

<!--- SEQUENCE 6 - no COUNTY, multiple type, no ALPHA (County then alpha) --->
<CFELSEIF url.county eq ""
	and newtypeList neq "" and newtypeList contains ","
	and url.alpha eq "">
	<CFSET sortBy = "ORDER BY b.Description, County, unitname">
	<cfset sequence = 6>
	
<!--- SEQUENCE 7 - no COUNTY, no type, multiple ALPHA (County then alpha) --->
<CFELSEIF url.county eq ""
	and url.govtype eq ""
	and url.alpha neq "" and url.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, County, unitname">
	<cfset sequence = 7>
	
<!--- SEQUENCE 8 - one COUNTY, one type, no ALPHA (alpha) --->
<CFELSEIF url.county neq "" and url.county does not contain ","
	and newtypeList neq "" and newtypeList does not contain ","
	and url.alpha eq "">
	<CFSET sortBy = "ORDER BY County, b.Description, unitname">
	<cfset sequence = 8>
	
<!--- SEQUENCE 9 - one COUNTY, multiple type, no ALPHA (type then alpha) --->
<CFELSEIF url.county neq "" and url.county does not contain ","
	and newtypeList neq "" and newtypeList contains ","
	and url.alpha eq "">
	<CFSET sortBy = "ORDER BY b.Description, unitname">
	<cfset sequence = 9>
	
<!--- SEQUENCE 10 - one COUNTY, one type, one ALPHA (alpha) --->
<CFELSEIF url.county neq "" and url.county does not contain ","
	and newtypeList neq "" and newtypeList does not contain ","
	and url.alpha neq "" and url.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, County, unitname">
	<cfset sequence =10>
	
<!--- SEQUENCE 11 - one COUNTY, one type, multiple ALPHA (alpha) --->
<CFELSEIF url.county neq "" and url.county does not contain ","
	and newtypeList neq "" and newtypeList does not contain ","
	and url.alpha neq "" and url.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, County, unitname">
	<cfset sequence =11>
	
<!--- SEQUENCE 12 - one COUNTY, multiple type, one ALPHA (type then alpha) --->
<CFELSEIF url.county neq "" and url.county does not contain ","
	and newtypeList neq "" and newtypeList contains ","
	and url.alpha neq "" and url.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, unitname">
	<cfset sequence =12>
	
<!--- SEQUENCE 13 - one COUNTY, multiple type, multiple ALPHA (type then alpha) --->
<CFELSEIF url.county neq "" and url.county does not contain ","
	and newtypeList neq "" and newtypeList contains ","
	and url.alpha neq "" and url.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, unitname">
	<cfset sequence =13>
	
<!--- SEQUENCE 14 - multiple COUNTY, one type, no ALPHA (alpha) --->
<CFELSEIF url.county neq "" and url.county contains ","
	and newtypeList neq "" and newtypeList does not contain ","
	and url.alpha eq "">
	<CFSET sortBy = "ORDER BY county, b.Description, unitname">
	<cfset sequence =14>
	
<!--- SEQUENCE 15 - multiple COUNTY, multiple type, no ALPHA (county, type then alpha) --->
<CFELSEIF url.county neq "" and url.county contains ","
	and newtypeList neq "" and newtypeList contains ","
	and url.alpha eq "">
	<CFSET sortBy = "ORDER BY county, b.Description, unitname">
	<cfset sequence =15>
	
<!--- SEQUENCE 16 - multiple COUNTY, one type, one ALPHA (county then alpha) --->
<CFELSEIF url.county neq "" and url.county contains ","
	and newtypeList neq "" and newtypeList does not contain ","
	and url.alpha neq "" and url.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY county, b.Description, unitname">
	<cfset sequence =16>
	
<!--- SEQUENCE 17 - multiple COUNTY, one type, multiple ALPHA (type, county then alpha) --->
<CFELSEIF url.county neq "" and url.county contains ","
	and newtypeList neq "" and newtypeList does not contain ","
	and url.alpha neq "" and url.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, county, unitname">
	<cfset sequence =17>
	
<!--- SEQUENCE 18 - multiple COUNTY, multiple type, one ALPHA (county, type then alpha) --->
<CFELSEIF url.county neq "" and url.county contains ","
	and newtypeList neq "" and newtypeList contains ","
	and url.alpha neq "" and url.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY county, b.Description, unitname">
	<cfset sequence =18>
	
<!--- SEQUENCE 19 - multiple COUNTY, multiple type, multiple ALPHA (type, county then alpha) --->
<CFELSEIF url.county neq "" and url.county contains ","
	and newtypeList neq "" and newtypeList contains ","
	and url.alpha neq "" and url.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, county, unitname">
	<cfset sequence =19>
	
<!--- SEQUENCE 20 - one COUNTY, no type, one ALPHA (type then alpha) --->
<CFELSEIF url.county neq "" and url.county does not contain ","
	and newtypeList eq ""
	and url.alpha neq "" and url.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, unitname">
	<cfset sequence =20>
	
<!--- SEQUENCE 21 - one COUNTY, no type, multiple ALPHA (type then alpha) --->
<CFELSEIF url.county neq "" and url.county does not contain ","
	and newtypeList eq ""
	and url.alpha neq "" and url.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, unitname">
	<cfset sequence =21>
	
<!--- SEQUENCE 22 - multiple COUNTY, no type, one ALPHA (type, county then alpha) --->
<CFELSEIF url.county neq "" and url.county contains ","
	and newtypeList eq ""
	and url.alpha neq "" and url.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, county, unitname">
	<cfset sequence =22>
	
<!--- SEQUENCE 23 - multiple COUNTY, no type, multiple ALPHA (type, county then alpha) --->
<CFELSEIF url.county neq "" and url.county contains ","
	and newtypeList eq ""
	and url.alpha neq "" and url.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, county, unitname">
	<cfset sequence =23>
	
<!--- SEQUENCE 24 - no COUNTY, one type, one ALPHA (alpha) --->
<CFELSEIF url.county eq ""
	and newtypeList neq "" and newtypeList does not contain ","
	and url.alpha neq "" and url.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY county, b.Description, unitname ">
	<cfset sequence =24>
	
<!--- SEQUENCE 25 - no COUNTY, one type, multiple ALPHA (county then alpha) --->
<CFELSEIF url.county eq ""
	and newtypeList neq "" and newtypeList does not contain ","
	and url.alpha neq "" and url.alpha contains ",">
	<CFSET sortBy = "ORDER BY County, b.Description, unitname">
	<cfset sequence =25>
	
<!--- SEQUENCE 26 - no COUNTY, multiple type, one ALPHA (type then county) --->
<CFELSEIF url.county eq ""
	and newtypeList neq "" and newtypeList contains ","
	and url.alpha neq "" and url.alpha does not contain ",">
	<CFSET sortBy = "ORDER BY b.Description, County">
	<cfset sequence =26>
	
<!--- SEQUENCE 27 - no COUNTY, multiple type, multiple ALPHA (type, county then alpha ) --->
<CFELSEIF url.county eq ""
	and newtypeList neq "" and newtypeList contains ","
	and url.alpha neq "" and url.alpha contains ",">
	<CFSET sortBy = "ORDER BY b.Description, County, unitname">
	<cfset sequence =26>
<CFELSE>
	<cfset sortBy = "ORDER BY County">
	<cfoutput>#url.county#</cfoutput>
    <cfset sequence =8>
</cfif>

<cfoutput>
<cfStoredProc datasource="#application.LocalGovernmentDatasource#" Procedure="Get_CurrentFY">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCurrentFYRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCurrentFYRetMsg">
	<cfprocresult name="GetCurrentFY">
</cfstoredproc>

<cfStoredProc datasource="#application.LocalGovernmentDatasource#" Procedure="Reg_Select">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@FY" value="#GetCurrentFY.FY#">
	<cfif isDefined("url.county") and trim(url.county) neq "" >
		<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@County" value="#trim(url.county)#">
    <cfelse>
    	<cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@County" null="yes">
	</CFIF>
    <cfif isDefined("url.govtype") and trim(url.govtype) neq "" >
    	<cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@govtype" value="#trim(url.govtype)#">
    <cfelse>
    	<cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@govtype" null="yes">
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

</cfoutput>

<!---
<CFQUERY DATASOURCE="AFRSQLProd" name="select">
	Select  a.Unitname
	, a.Code
	, a.County

	, b.description 
     FROM UnitData as a inner join tblC4 as b on a.C4 = b.C4
	WHERE 1=1
	<cfif isDefined("url.county") and url.county neq "">
	AND a.County IN (#Trim(PreserveSingleQuotes(url.county))#)
	</cfif>
	<cfif isDefined("url.govtype") and url.govtype neq "">	
	AND a.C4 IN (#url.govtype#)
	</cfif> 
	<cfif isDefined("url.alpha") and url.alpha neq "">
	AND Left(a.Unitname,1) IN (#PreserveSingleQuotes(url.alpha)#)
	</cfif> 
	group by a.unitname, a.Code, b.description, a.county
	#sortBy#
	
	</CFQUERY>
	--->
 <CFOUTPUT>

 <!--- alpha sort table --->
<cfif select.recordcount>
 	<cfif not isDefined("form.drill")> 
		<cfset alphabet="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z">
		<cfset myAlphaList = "">
		<cfloop QUERY="select">
			<cfset myAlpha = left(unitname, 1)>
			<cfif not listFind(myAlphaList,myAlpha)>
				<cfset myAlphaList = listAppend(myAlphaList,myAlpha)>
			</cfif>
		</cfloop>
		<!---
		<cfif newtypelist contains "Township">
			<cfset url.govtype = replace(url.govtype,"1,2","1,2T","Once")>
		</cfif>
		--->
		Skip to Unit Starting With:<br> <cfloop LIST="#alphabet#" INDEX="ii">
		<cfif listFind(myAlphaList,ii)>
				<a href="/financial-data/local-government-division/view-local-government-contact-information/contact-information-2/?alpha=#ii#&county=#url.county#&drill=Yes&govtype=#url.govtype#"><b>#ii#</b></a> |
		<cfelse>
		 	#ii# |
		</cfif> 
		</cfloop>
 	<cfelse>
		<span style="text-align:center;"><a href="javascript:history.back();">Go Back</a></span>
	</cfif> 
</cfif>

<p class="margintop"><b>#select.recordcount#</b> Results <cfif isdefined("url.drill")>for Units beginning with <cfoutput>#url.alpha#</cfoutput></cfif></p>

<p class="margintop">
You have selected to look in
	<cfif url.county neq "">
	 <b>#capFirst(variables.newCountyList)# County</b>
	</cfif>
	<cfif url.county neq "" AND url.govtype neq ""><!---  AND url.alpha eq "" --->
	for 
	</cfif> 
	<cfif url.govtype neq "">
	<cfset ortypes = replace(newtypelist,',',' or ', 'all')>
	<!--- <b>#newtypeList#</b>  --->
	<b>#ortypes#</b> 
	<!--- as your type(s) of Government ---></cfif>
	<cfif url.govtype neq "" AND url.alpha neq ""><!--- , and  --->
	</cfif>
	<cfif url.alpha neq "">
	<cfset orAlpha = rePlace(url.alpha,',',' or ','all')>
	<!--- that begin with the letter <b>#url.alpha#</b>. --->
	that begin with the letter <b>#oralpha#</b>.
	</cfif>
  To go back to the previous screen click <a href="/financial-data/local-government-division/view-local-government-contact-information/">here</a>.
</p>
</cfoutput>
<!--- list selections --->

<cfparam name="sequence" DEFAULT="">
<cfif sequence eq 2>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post" id="list">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" onClick="selectAll(this.form.list,true)" class="btn btn-sm btn-primary"><input type="button" value="Clear All"  class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
<cfoutput QUERY="select" GROUP="Description"><!---  STARTROW="#startrow#" MAXROWS="#maxrows#" --->
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))# County</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#" id="list">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 3>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput>
            <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#unitname# - #Description#</a></p>
		</cfoutput>
	</cfoutput>
</form>	

<cfelseif sequence eq 4>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" onClick="selectAll(this.form.list,true)" class="btn btn-sm btn-primary"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
<cfoutput GROUP="County">
		<cfoutput>
            <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#unitname#</a></p>
		</cfoutput>
	</cfoutput>
</cfoutput>
</form>
<cfelseif sequence eq 5>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County# County</h3><!---  #Unitname# --->
		<cfoutput GROUP="Description">
            <p class="margintop10 marginl15 marginb5">#Description#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 6>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
<cfoutput GROUP="County">
    <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))# County</p>
		<cfoutput>
            <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#unitname#</a></p>
		</cfoutput>

	</cfoutput>
</cfoutput>
</form>
<cfelseif sequence eq 7>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><a href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></a>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---></div>

    <cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
		 <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))# County</p>
			<cfoutput>
			<p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>	
<cfelseif sequence eq 8>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>

	<cfoutput QUERY="select" GROUP="Description">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(Description))#</p>
			<cfoutput GROUP="unitname">
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#unitname# - #Description#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 9>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<!--- <cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3> --->
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#unitname#</a></p>
			</cfoutput>
		<!--- </cfoutput> --->
	</cfoutput>
</form>	
<cfelseif sequence eq 10>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))# County</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname# - #Description#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 11>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<!--- <cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3> --->
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		<!--- </cfoutput> --->
	</cfoutput>
</form>		
<cfelseif sequence eq 12>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<!--- <cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3> --->
			<cfoutput>
            <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		<!--- </cfoutput> --->
	</cfoutput>
</form>		
<cfelseif sequence eq 13> 
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<!--- <cfoutput GROUP="County">
		 <h3 STYLE="font-size:13px; text-indent:5px; ">#CapFirst(lcase(County))# County</h3> --->
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		<!--- </cfoutput> --->
	</cfoutput>
</form>		
<cfelseif sequence eq 14>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(Description))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname# - #Description#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>	
<cfelseif sequence eq 15>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(Description))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>	
<cfelseif sequence eq 16>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(Description))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>	
<cfelseif sequence eq 17>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="county">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(select.County))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>	
<cfelseif sequence eq 18>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(Description))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 19>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description"><!---  STARTROW="#startrow#" maxrows="#max#" --->
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
	&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form> 
<cfelseif sequence eq 20>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 21>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 22>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 23>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 24>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(Description))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 25>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="County">
	<h3>#County#</h3>
		<cfoutput GROUP="Description">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(Description))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
			</ul>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 26>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><A href="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
<cfelseif sequence eq 27>
<form name="mon_formulaire" action="/financial-data/local-government-division/view-local-government-contact-information/button-action/" class="gray-div" method="Post">
<div class="more-buttons"><input type="submit" name="btnView" value="View Results" class="btn btn-sm btn-primary"><input type="submit" name="ViewPDF" value="View PDF" class="btn btn-sm btn-primary"><input type="button" value="Select all" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,true)"><input type="button" value="Clear All" class="btn btn-sm btn-primary" onClick="selectAll(this.form.list,false)"><input type="button" value="Help" class="btn btn-sm btn-primary" onClick="javascript:popUp('/financial-data/local-government-division/view-local-government-contact-information/help/')"></A>  <!--- <p><font color="red" size="2.7"><i>You must make a checkbox selection before selecting the Open As PDF and View Contact As WebPage buttons!</i></font>---> </div>
	
	<cfoutput QUERY="select" GROUP="Description">
	<h3>#Description#</h3>
		<cfoutput GROUP="County">
            <p class="margintop10 marginl15 marginb5">#CapFirst(lcase(County))#</p>
			<cfoutput>
                <p class="marginl15 marginb5"><input type="checkbox" name="list" value="#code#">
			&nbsp;<a href="/financial-data/local-government-division/view-local-government-contact-information/specific-contact-information/?SelUnitCode=#code#">#Unitname#</a></p>
			</cfoutput>
		</cfoutput>
	</cfoutput>
</form>
</cfif>