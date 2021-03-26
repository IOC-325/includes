<!-- CR0008 - 08/26/97 -->
<!-- Give default values for all parameters -->
<!-- CFPARAMs are required when you wish to assign -->
<!-- a value (DEFAULT) to the name of a control in a form -->
<!-- that receives a value from a user -->
<!--- have new application variables that need to be inserted (maxrecs and cfy) --->
<CFPARAM NAME="Control" DEFAULT="Main">
<CFPARAM NAME="Max" DEFAULT=application.maxrecs>
<CFPARAM NAME="FY" DEFAULT=application.CFY>
<CFPARAM NAME="Type" DEFAULT="A">
<CFPARAM NAME="View" DEFAULT="Budg">
<CFPARAM NAME="ShowBudg" DEFAULT="No">
<CFPARAM NAME="ShowExp" DEFAULT="No">
<CFPARAM NAME="ShowMo" DEFAULT="No">
<CFPARAM NAME="ShowLapse" DEFAULT="No">
<CFPARAM NAME="FundSel" DEFAULT="">
<CFPARAM NAME="AgcySel" DEFAULT="">
<CFPARAM NAME="ApprSel" Default="">
<CFPARAM NAME="OrgSel" Default="">
<CFPARAM NAME="SortName" Default="No">

<!-- If The reset button has been in use, then the -->
<!-- Parameter does exist, and the values, FundSel, AgencySel -->
<!-- etc. are reset, and sort becomes yes -->
<!--- <CFIF #ParameterExists(Reset)# is "Yes"> --->
<cfif isDefined("Reset")>
  <CFSET FundSel = "">
  <CFSET AgcySel = "">
  <CFSET ApprSel = "">
  <CFSET SortName = "Yes">
</CFIF>

<div class="container">
  <h2>Appropriation Inquiries</h2>

<!-- Instructions -->
<p>Select the Fund and Agency that you are interested in.  You will then be prompted for the Organization (division/program) of the Agency you selected.  The first screen will display a summary of appropriation or expenditure total amounts for each appropriation depending on the display option chosen.  Each line in the summary is also a link to detailed appropriation and expenditure amounts for a given appropriation.  If you know the appropriation, you can enter it.  Inserting an appropriation will display detailed appropriation and expenditure information for that account.  </p>

<!--CFOUTPUT actually incorporates the POST command from the form, opening AIOrgform.-->

<form role="form" method="post" action="/?LinkServID=2DAC1EB1-A4F6-E353-3901EBCA2CFCFC92">
<!---<form method="post" action="#application.whwebroot#/iw/index.cfm/warehouse-inquiries/appropriation-inquiries/choose-org/?sortName=#sortName#">--->
<!--- </CFOUTPUT> --->

<!-- Hidden parameter used by EEQuery to determine if the request -->
<!-- came by form or drill down -->

 <INPUT TYPE=hidden NAME="FormInput">

<!-- Beginning of Appropriation Inquiry -->
<cfinvoke component="Queries.warehouse" method="getFunds" returnvariable="FundList" sortname="No">
<!--- <cftry> --->
<!---   <CFQUERY NAME="FundList" DATASOURCE="DB2PRD">
  SELECT Fund,Name FROM WH.FUND_#FY#

    <CFIF SortName is "No">
      ORDER BY Fund
    <CFELSE>
      ORDER BY Name
    </CFIF>

</CFQUERY> --->
<!---   <cfcatch type="database">
  <cfinclude template="/warehouseOfflineMessage.htm">
  <cfabort>
</cfcatch>
</cftry> --->
  <!-- Agency and Name are actual names in the table -->
  <!-- Getting the list of agencies - their code and name-->

  <cfinvoke component="Queries.warehouse" method="getAgencies" returnvariable="AgcyList" control="" sortname="No">
  <!--- <CFQUERY NAME="AgcyList" DATASOURCE="#application.whDSN#" CACHEDWITHIN="#cREATETIMESPAN(1,0,0,0)#">
      SELECT Agency,Name FROM #application.whOwner#AGENCY_#FY#
      WHERE ((agency = <cfqueryparam cfsqltype="cf_sql_varchar" value="799" />) OR (AGENCY < <cfqueryparam cfsqltype="cf_sql_varchar" value="699" />)) and agency<><cfqueryparam cfsqltype="cf_sql_varchar" value="ACC" /> and agency<><cfqueryparam cfsqltype="cf_sql_varchar" value="IPS" />

      <CFIF SortName is "No">
        ORDER BY Agency
      <CFELSE>
        ORDER BY Name
      </CFIF>
  </CFQUERY> --->



<div class="form-group">
  <label>Select a fund</label>
   <SELECT class="form-control" NAME="FundSel" id="FundSel">
     <CFOUTPUT QUERY="FundList">
       <OPTION VALUE="#Fund#">#Fund# - #Name#</option>
     </CFOUTPUT>
   </SELECT>
</div>
<div class="form-group">
  <label>Select Agency</label>
    <SELECT class="form-control" NAME="AgcySel">
      <OPTION VALUE="" SELECTED>SELECT AN AGENCY  </option>
      <CFOUTPUT QUERY="AgcyList">
        <!--- <CFIF #AgcySel# is #Agency#>
          <OPTION VALUE="#Agency#"SELECTED>#Agency# - #Name#
        <CFELSE> --->
          <OPTION VALUE="#Agency#">#Agency# - #Name#</option>
        <!--- </CFIF> --->
      </CFOUTPUT>
    </SELECT>
</div>

<div class="form-group">
   <label>
      Fill in an Appropriation, if desired (object of expenditure, sequence and type):</label>
      <CFOUTPUT>
        <INPUT class="form-control" TYPE="text" NAME="ApprSel" SIZE=8 MAXLENGTH=8 VALUE="#ApprSel#" placeholder="Enter an Appropriation, if desired">
      </CFOUTPUT>
</div>
<!-- End  -->


<!-- Fiscal Year Selection Control -->
<div class="form-group">
    <label>Fiscal Year</label>
    <CFOUTPUT>
    <select class="form-control" name="FY">
      <option value="#application.CFY#" selected="selected">#application.CFY#</option>
      <option value="#application.PFY#">#application.PFY#</option>
      <option value="#application.PPFY#">#application.PPFY#</option>
    </select>
    </CFOUTPUT>
</div>
<div class="form-group">
<CFOUTPUT>
  <label>Choose a fiscal year.  Note that the State's fiscal year starts July 1(e.g., FY #application.CFY# is July 1, 20#application.PFY# through June 30, 20#application.CFY#).</label>
</CFOUTPUT>

<!-- End of Fiscal Year Selection Control -->


<div class="col-sm-5">
    <label>Display Options</label>
</div>
<!-- Display Options Control -->
<div class="col-sm-7">
<div class="radio"><label><input type="radio" name="view" value="Budg" checked="true">Appropriation Details</label></div>
<div class="radio"><label><input type="radio" name="view" value="Exp">Appropriation Expenditures</label></div>
</div>
</div>
<div class="form-group">

<div class="col-sm-5">
    <label>Lapse / Monthly Options</label>
</div>
<div class="col-sm-7">
    <!-- why are the CFIF and CFElse options both going to yes???-->
   <CFIF ShowMo is "Yes">
       <div class="checkbox"><label><input type="checkbox" name="ShowMo" checked="true" value="Yes">Monthly Amounts</label></div>
     <CFELSE>
        <div class="checkbox"><label><input type="checkbox" name="ShowMo" value="Yes">Monthly Amounts</label></div>
      </CFIF>

      <CFIF ShowLapse is "Yes">
       <div class="checkbox"><label><input type="checkbox" checked="true" name="ShowLapse" value="Yes">Lapse Amounts</label></div>
     <CFELSE>
        <div class="checkbox"><label><input type="checkbox" name="ShowLapse" value="Yes">Lapse Amounts</label></div>
      </CFIF>
</div>




</div>

<div class="form-group">
  <div class="col-sm-12">
    <p>The year-to-date expended amount will be displayed by default.  You can also choose
  to include the budgeted dollars and/or monthly totals. </p>
  </div>
 </div>
<!-- End of Display Options Control -->


<!-- Max Entries Control -->
<!--- Disable Max Entries
<TR>
  <TD>
  Max Entries
  <SELECT NAME="Max">
    <CFIF Max is "10">
      <OPTION VALUE="10" SELECTED>10
    <CFELSE>
      <OPTION VALUE="10">10
    </CFIF>

    <CFIF #Max# is "25">
      <OPTION VALUE="25" SELECTED>25
    <CFELSE>
      <OPTION VALUE="25">25
    </CFIF>

    <CFIF #Max# is "50">
      <OPTION VALUE="50" SELECTED>50
    <CFELSE>
      <OPTION VALUE="50">50
    </CFIF>

    <CFIF #Max# is "100">
      <OPTION VALUE="100" SELECTED>100
    <CFELSE>
      <OPTION VALUE="100">100
    </CFIF>

  </SELECT>
  </TD>

  <TD>
  The maximum number of records returned is limited to ensure a timely response.
  </TD>
</TR>
     End of Disable --->
<!-- End of Max Entries Control -->
<CFOUTPUT>
<INPUT TYPE="hidden" NAME="Max" VALUE="20">
</CFOUTPUT>
<div class="form-group">
 <div class="col-sm-offset-5 col-sm-7">
   <INPUT class="btn btn-primary" TYPE="submit" VALUE="Continue">
</div>
</div>
</FORM>

</div>

