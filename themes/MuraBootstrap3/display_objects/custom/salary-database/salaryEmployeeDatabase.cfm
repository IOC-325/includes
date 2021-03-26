<!--- salary database --->
<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css" /> 


<cfparam name="variables.Issue_Year" default="0">
<cfparam name="variables.Agency" default="0">
<cfparam name="variables.Position" default="0">
<cfparam name="variables.SalaryRange" default="0,400">
<cfparam name="variables.FindLastName" default="">
<cfparam name="variables.FindFirstName" default="">
<cfparam name="variables.EmpId" default="">

<!--- Get all fiscal years --->
 <cfinvoke component = "ledger.includes.display_objects.custom.EmplSalarySQL.Component.EmployeeSalary"
   method = "GetDefaultYear2"
   returnVariable = "qFiscalYears">
 </cfinvoke>

 <CFSET variables.Issue_Year = qFiscalYears.ISSUE_YEAR>

 <cfset CFY = qFiscalYears.Issue_Year>
 <cfset PFY = qFiscalYears.Issue_Year-1>
 <cfset PFY2 = qFiscalYears.Issue_Year-2>


<!--- <cfif ((DatePart("M",NOW()) eq "12" and DatePart("D",NOW()) gt "15") or (DatePart("M",NOW()) eq "01"))> --->
<cfif DatePart("M",NOW()) eq "01">
  <CFSET variables.Issue_Year = PFY>
 <cfelse>
  <CFSET variables.Issue_Year = qFiscalYears.Issue_Year>
 </cfif>


<CFIF IsDefined ("form.IssueYear")>

   <CFSET variables.Issue_Year = form.IssueYear>
   <CFSET variables.Agency = form.Agency>
   <CFSET variables.Position = form.Position>
   <CFSET variables.SalaryRange = form.SalaryRange>
   <CFSET variables.FindLastName = form.FindLastName>
   <CFSET variables.FindFirstName = "">
   <CFSET variables.EmpId = "">

<cfelseif isDefined("URL.Issue_Year")>

   <cfif url.Issue_Year is "">
    <cfset url.Issue_Year = variables.Issue_Year>
   </cfif>

   <CFSET variables.Issue_Year = URL.Issue_Year>
   <cfif isDefined("url.Agency")>
    <CFSET variables.Agency = TRIM(URLDecode(url.Agency, 'utf-8'))>
   <cfelse>
    <CFSET variables.Agency = "">
   </cfif>
   <cfif isDefined("url.Position")>
    <CFSET variables.Position = TRIM(URLDecode(url.Position, 'utf-8'))>
   <cfelse>
    <CFSET variables.Position = "">
   </cfif>
   <cfset variables.BegRange = "">
   <cfif variables.BegRange eq "">
    <cfset variables.BegRange =  0>
   </cfif>
   <cfset variables.EndRange = "">
   <cfif variables.EndRange eq "">
    <cfset variables.EndRange =  400>
   </cfif>
   <CFSET variables.SalaryRange = "#BegRange#,#EndRange#">
   <cfif isDefined("url.First_Name")>
    <CFSET variables.FindFirstName = TRIM(URLDecode(url.First_Name, 'utf-8'))>
   <cfelse>
    <CFSET variables.FindFirstName = "">
   </cfif>
   <cfif isDefined("url.Last_Name")>
    <CFSET variables.FindLastName = TRIM(URLDecode(url.Last_Name, 'utf-8'))>
   <cfelse>
    <CFSET variables.FindLastName = "">
   </cfif>
   <cfif isDefined("url.EmpId")>
    <CFSET variables.EmpId = TRIM(URLDecode(url.EmpId, 'utf-8'))>
   <cfelse>
    <CFSET variables.EmpId = "">
   </cfif>
</CFIF>

<!---    <cfif variables.Issue_Year EQ 0>
    <cfset variables.Issue_Year = "20#application.cfy#">
   </cfif> --->


<!--- Get all Agencies --->
<cfinvoke component = "ledger.includes.display_objects.custom.EmplSalarySQL.Component.EmployeeSalary"
   method = "GetAgencyList2"
   returnVariable = "qAL">
   <cfinvokeargument name="Issue_Year" value="#variables.Issue_Year#">
 </cfinvoke>

<!--- Get all Employee Positions --->
 <cfinvoke component = "ledger.includes.display_objects.custom.EmplSalarySQL.Component.EmployeeSalary"
   method = "GetAllEmployeePositions"
   returnVariable = "qEPL">
   <cfinvokeargument name="Issue_Year" value="#variables.Issue_Year#">
 </cfinvoke>
 <!--- Get Default Agency Salaries --->
<cfinvoke component = "ledger.includes.display_objects.custom.EmplSalarySQL.Component.EmployeeSalary"
      method = "GetAgencySalary3"
      returnVariable = "GetAgencySalary">
 </cfinvoke>


<cfoutput>
    <p>The Employee Database tracks salary information on state employees from the current year as well as previous years. Search by agency, individual name, position, salary, or even year of service.</p>
<div class="row">
    <div class="col-sm-6 col-sm-offset-2">
      <div class="example alert alert-danger hidden" id="errorMsg"> Please Enter Search Criteria.</div>
    </div>
    <div class="col-sm-12 col-sm-offset-0  col-md-10 col-md-offset-1">
      <cfform role="form" name="FindSalary" action="/financial-data/state-expenditures/employee-salary-database/" method="Post" id="searchform">

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Employee's Last Name</div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
              <input placeholder="Last Name" class="form-control" type="text" id="FindLastName" name="FindLastName" value="#variables.FindLastName#">
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Issue Year</div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
              <cfselect name="IssueYear"
                 query="qFiscalYears"
                     value="ISSUE_YEAR"
                     display="ISSUE_YEAR"
                     selected="#variables.Issue_Year#"
                     queryposition="below" class="select2">
               <CFIF variables.Issue_Year IS 0>
                   <option value="0" selected="selected">All</option>
               <cfelse>
                   <option value="0">All</option>
               </CFIF>
               </cfselect>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Agency</div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
               <cfselect name="Agency"
                 query="qAL"
                     value="Agency"
                     display="Agency"
                     selected="#variables.Agency#"
                     queryposition="below" class="select2">
               <CFIF variables.Agency IS 0>
                   <option value="0" selected="selected">All</option>
               <cfelse>
                   <option value="0">All</option>
               </CFIF>
              </cfselect>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Position</div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
              <cfselect name="Position"
                 query="qEPL"
                     value="Position"
                     display="Position"
                     selected="#variables.Position#"
                     queryposition="below" class="select2">
               <CFIF variables.Position IS 0>
                   <option value="0" selected="selected">All</option>
               <cfelse>
                   <option value="0">All</option>
               </CFIF>
              </cfselect>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Salary Range</div>
            </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
              <div class="rang">
               <cfinput type="text" id="SalaryRange" name="SalaryRange" class="range-slider" value="#variables.SalaryRange#"/>
                 <input type="hidden" name="range-slider-value-max" value="#listlast(variables.SalaryRange)#">
                 <input type="hidden" name="range-slider-value-min" value="#listfirst(variables.SalaryRange)#">
                 <div class="rang-value">
                  <div class="pull-left">$0</div>
                  <div class="pull-right">$400k</div>
                 </div>
              </div>
            </div>
        </div>

        <div class="text-center">
            <button id="btnSearch" class="btn btn-success" type="submit">Search</button>
        </div>

      </cfform>
    </div>
</div>

</cfoutput>
<div class="reset-this"></div>
<div id="payment" class="contract main2" style="margin-top: 30px;">
  <CFIF IsDefined ("variables.Issue_Year") AND (Not IsDefined("URL.Issue_Year")) AND (Not IsDefined ("form.IssueYear"))>
    <!--- <CFIF Not IsDefined ("form.IssueYear")> --->
    <!--- Default results for this page. --->
       <cfinclude template="templates/salaryEmp1.cfm">
    <cfelse>
    <!--- Results based on form selection as submitted by the user. --->
        <cfinclude template="templates/salaryEmp2.cfm">
    </CFIF>
	<p style="font-size: 14px;margin-top: 20px; "><em>Pursuant to Public Act 100-0253, the rate of pay and year to date gross have been rounded.</em></p>
</div>

  <script src="/comptroller/includes/themes/MuraBootstrap3/js/ledger/1.11.3.jquery.min.js"></script>

<script>
$(document).ready(function(){


   $("#btnSearch").click(function(event){
   if($("#FindLastName").val() === "" && $("#Agency").val().trim() === "0" && $("#Position").val().trim() === "0")
   {
     $("#errorMsg").toggleClass('hidden show');
     event.preventDefault();
   }
   else{
     $("#errorMsg").toggle();
   }

   });
});
</script>
