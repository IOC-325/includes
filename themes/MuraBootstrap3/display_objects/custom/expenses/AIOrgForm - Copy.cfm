<cfparam NAME="Sortname" DEFAULT="no">
<cfparam NAME="FY" DEFAULT="#application.cfy#">
<CFPARAM NAME="OrgSel" DEFAULT="">
<cfparam NAME="Max" DEFAULT="">
<cfparam NAME="View" DEFAULT="">
<cfparam NAME="ShowMo" DEFAULT="">
<cfparam NAME="ShowBudg" DEFAULT="">
<cfparam NAME="ShowExp" DEFAULT="">
<cfparam NAME="ShowLapse" DEFAULT="">
<cfparam NAME="FundSel" DEFAULT="">
<cfparam NAME="AgcySel" DEFAULT="">
<cfparam NAME="ApprSel" DEFAULT="">
<cfparam NAME="SortName" DEFAULT="">
<CFIF IsDefined ("form.ShowMo")>
 	<CFSET ShowMo = "Yes">
<cfelse>
	<CFSET ShowMo = "No">
</CFIF>
<CFIF IsDefined ("form.ShowBudg")>
 	<CFSET ShowBudg = "Yes">
<cfelse>
	<CFSET ShowBudg = "No">
</CFIF>
<CFIF IsDefined ("form.ShowLapse")>
 	<CFSET ShowLapse = "Yes">
<cfelse>
	<CFSET ShowLapse = "No">
</CFIF>


<!-- Where Agency = the agency selected in AIControl.cfm-->
<CFQUERY NAME="OrgList" DATASOURCE="#application.whDSN#">
	SELECT 	Organization
			,Name
	FROM #application.whOwner#ORGN_#FY#
	WHERE Agency = <cfqueryparam cfsqltype="cf_sql_varchar" value="#AgcySel#">
</CFQUERY>
<!--- <cfdump var="#orglist.recordcount#" abort="true"> --->

<div class="container" >
     <CFIF OrgList.RecordCount gt 1>
     	<CFOUTPUT>
     	<FORM class="form-inline" role="form" ACTION="?LinkServID=34752E01-94B1-C363-BD152098AC434FCA" METHOD="post">
     	<!-- These must be included here in order to...-->

     	<INPUT TYPE="HIDDEN" NAME="Max" VALUE="#Max#">
     	<INPUT TYPE="HIDDEN" NAME="FY" VALUE="#FY#">
     	<INPUT TYPE="HIDDEN" NAME="View" VALUE="#View#">
     	<INPUT TYPE="HIDDEN" NAME="ShowBudg" VALUE="#ParameterExists(ShowBudg)#">
     	<INPUT TYPE="HIDDEN" NAME="ShowExp" VALUE="#ParameterExists(ShowExp)#">
     	<INPUT TYPE="HIDDEN" NAME="ShowMo" VALUE="#ShowMo#">
     	<INPUT TYPE="HIDDEN" NAME="ShowLapse" VALUE="#ShowLapse#">
     	<INPUT TYPE="HIDDEN" NAME="FundSel" VALUE="#FundSel#">
     	<INPUT TYPE="HIDDEN" NAME="AgcySel" VALUE="#AgcySel#">
     	<INPUT TYPE="HIDDEN" NAME="ApprSel" VALUE="#ApprSel#">
     	<INPUT TYPE="HIDDEN" NAME="SortName" VALUE="#SortName#">
     	<div class="row">
       	<div class="col-sm-offset-3 col-sm-9"><label>Submit the query immediately with the current settings.</label></div>
      </div>
      <div class="row"><div class="col-sm-offset-6 col-sm-6"><p>Fund: #FundSel#</p></div></div>
      <div class="row"><div class="col-sm-offset-6 col-sm-6"><p>Agency: #AgcySel#</p></div></div>
      <!--- <div class="row"><div class="col-sm-offset-6 col-sm-6"><p>Appropriation: </p></div></div> --->
      <div class="row"><div class="col-sm-offset-6 col-sm-6"><p>Fiscal Year: #FY#</p></div></div>
       </cfoutput>
       <div class="row ">
        <div class="col-sm-offset-3 col-sm-9">
       	<label>Select an Organization:</label>
       			<SELECT NAME="OrgSel" class="form-control">
       				<CFOUTPUT QUERY="OrgList">
       						<OPTION VALUE="#Organization#">#Organization# - #Name#</option>
       				</CFOUTPUT>
       			</SELECT>
         </div>
      </div>
   <div class="row">
    <div class="col-sm-offset-6 col-sm-6">
      <INPUT class="btn btn-primary" TYPE="submit" VALUE="Submit Query">
   </div>
   </div>


     	</FORM>
     <CFELSE>
     	<CFLOCATION URL="?LinkServID=34752E01-94B1-C363-BD152098AC434FCA&FY=#FY#&View=#View#&ShowBudg=#ParameterExists(ShowBudg)#&ShowExp=#ParameterExists(ShowExp)#&ShowMo=#ParameterExists(ShowMo)#&ShowLapse=#ParameterExists(ShowLapse)#&FundSel=#FundSel#&AgcySel=#AgcySel#&ApprSel=#ApprSel#&OrgSel=#OrgSel#&SortName=#SortName#" addtoken="false">
     </CFIF>
   </div>

