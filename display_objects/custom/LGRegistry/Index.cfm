<cfStoredProc datasource="AFRSQLPROD" Procedure="Reg_getCounties">
    <cfif ISDefined("FORM.county")>
        <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@County" value="#FORM.county#">
    <cfelse>
        <cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@County" null="yes">
    </CFIF>
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="ReggetCountiesRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="ReggetCountiesRetMsg">
    <cfprocresult name="getCounties">
</cfstoredproc>
 
 	<cfStoredProc datasource="AFRSQLPROD" Procedure="Get_CurrentFY">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCurrentFYRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCurrentFYRetMsg">
        <cfprocresult name="GetCurrentFY">
    </cfstoredproc>
    
    <cfStoredProc datasource="AFRSQLPROD" Procedure="Get_tblC4">
    	 <cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@FY" Value="#GetCurrentFY.FY#">
        <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GettblC4RetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GettblC4RetMsg">
        <cfprocresult name="getTypes">
    </cfstoredproc>
    
	<p>This page enables you to search and view the self-reported contact information from the most recently submitted Annual Financial Reports and Registration Reports of local governments in Illinois. Select one or more of the three criteria below to facilitate your search.</p>
	
	<cfform METHOD="get" ACTION="contact-information-2" id="searchform">
		<div class="row">
		  <div class="col-sm-4 col-sm-offset-1 label-div">
		      <div class="btn-label">County Name</div>
		  </div>

		  <div class="col-xs-12 col-sm-5">
		      <select name="county" class="select2" multiple="true">
		          <option value="">All</option>
		          <cfoutput QUERY="getCounties"> 
		          	<option VALUE="#County#">#County#</option>
		          </cfoutput>
		      </select>
		  </div>
		</div>

		<div class="row">
		  <div class="col-sm-4 col-sm-offset-1 label-div">
		      <div class="btn-label">Type</div>
		  </div>

		  <div class="col-xs-12 col-sm-5">
		      <select name="govtype" class="select2" multiple="true">
	          <option value="">All</option>
	          <option VALUE="1,2T">Townships</option>
	          <option VALUE="30,31,32">Municipalities</option>
	          <option VALUE="3,4,5,7,8,9,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,33,37,38,39,40,41,42,45,46,50,51,53,54,55">All Other Specials</option>
	          <option VALUE="0">Counties</option>
	          <option VALUE="12">Park Districts</option>
	          <option VALUE="10">Public Library Districts</option>
	          <option VALUE="6">Fire Protection Districts</option>
		      </select>
		  </div>
		</div>

		<div class="row">
			  <div class="col-sm-4 col-sm-offset-1 label-div">
			      <div class="btn-label">Starts With</div>
			  </div>

			  <div class="col-xs-12 col-sm-5">
			      <select name="alpha" class="select2" multiple="true">
			      	<option VALUE="A">A</option>
			      	<option VALUE="B">B</option>
			      	<option VALUE="C">C</option>
			      	<option VALUE="D">D</option>
			      	<option VALUE="E">E</option>
			      	<option VALUE="F">F</option>
	      			<option VALUE="G">G</option>
	      			<option VALUE="H">H</option>
	      			<option VALUE="I">I</option>
	      			<option VALUE="J">J</option>
	      			<option VALUE="K">K</option>
	      			<option VALUE="L">L</option>
	      			<option VALUE="M">M</option>
	      			<option VALUE="N">N</option>
	      			<option VALUE="O">O</option>
	      			<option VALUE="P">P</option>
	      			<option VALUE="Q">Q</option>
	      			<option VALUE="R">R</option>
	      			<option VALUE="S">S</option>
	      			<option VALUE="T">T</option>
	      			<option VALUE="U">U</option>
	      			<option VALUE="V">V</option>
	      			<option VALUE="W">W</option>
	      			<option VALUE="X">X</option>
	      			<option VALUE="Y">Y</option>
	      			<option VALUE="Z">Z</option>
			      </select>
			  </div>

		</div>
		  <div class="text-center">
			  <button class="btn btn-primary" name="submitted" type="submit">SEARCH</button>
		  </div>

	</cfform>