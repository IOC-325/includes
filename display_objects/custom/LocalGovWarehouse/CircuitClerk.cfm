<!--- 
  Axosoft Bug: 1140
  Author:      Zac Ely
  Update date: 3/3/2020
  Description: Generate a link for the current fiscal year's fund report 
---> 

<cfif cgi.server_name contains "UAT">
  <cfset variables.comptrollerConnectURL = "https://lgafr-uat.illinoiscomptroller.gov">
<cfelse>
  <cfset variables.comptrollerConnectURL = "https://comptrollerconnect.illinoiscomptroller.gov">
</cfif>

<!--- Used inline query in order to avoid complications with permissions for stored procedures --->
<cfquery name="ccrpCurrentFY" datasource="#application.LocalGovernmentDatasource#">
  SELECT TOP (2) FY
    FROM CircuitClerkFYSetup
    ORDER BY FY DESC
</cfquery>

<div class="bs-docs-section">
 	<div class="page-header">
    	<h1 id="jbt-letter" style="text-shadow: 1px 1px 1px #ffffff;">Circuit Clerk Reports</h1>
    </div>

<cfoutput>
 	<p class="col-12">
    <!--- Circuit Clerks throughout Illinois are required to charge additional fees to various offenders, then turn over the money to the Illinois State Treasurer so that it may be deposited into special state funds. In some instances, the Circuit Clerks are required to inform the Comptroller of the amounts they turned over to the Treasurer and the funds that received the money. The report provided below is a compilation of those figures as reported by the Circuit Clerks for calendar year #variables.ccrpCurrentFY.FY#. --->
    Per Illinois Compiled Statute The Clerks of Courts Act - 705 ILCS 105/27.8(d), an audit is to be completed 6 months after the county's fiscal year end (unless an extension has been granted), and is due to the Illinois Office of Comptroller one month after completion.  
Effective 7-1-2019, the Clerk of the Circuit Court is no longer required to file reports for the following funds with the Illinois Office of Comptroller: </p>

<p style="margin-left:2rem">Drivers Education Fund, Violent Crime Victims Assistance Fund, Domestic Violence Shelter and Service Fund, Domestic Violence Abuser Services Fund, and Sex Offender Investigation Fund.</span>

<p>The portal to submit the above listed funds reports will still be operational, and local entities may elect to file these reports at their own discretion.

The report provided below is a compilation of those figures as reported by the Circuit Clerks.</p>
  <br><br>

  <!--- <a target="_blank" style="text-shadow: 1px 1px 1px ##ffffff;" href="#variables.comptrollerConnectURL#/CircuitClerk/Reports/CircuitClerk/CircuitClerkReport.cfm?url.CFY=#variables.ccrpCurrentFY.FY#">Click here for the Circuit Clerk Funds Report</a> --->
  <div class="col-xs-12 col-sm-3 label-div">
    <div class="btn-label-grey btn-label label-gray">Fiscal Year</div>
  </div>

  <div class="col-xs-12 col-sm-7 default-select">
    <select id="fiscalYear" class="select2" name="fiscalYear">
      <cfloop query="ccrpCurrentFY">
        <option value="#variables.comptrollerConnectURL#/CircuitClerk/Reports/CircuitClerk/CircuitClerkReport.cfm?url.CFY=#ccrpCurrentFY.FY#">#ccrpCurrentFY.FY#</option>
      </cfloop>
    </select>
  </div>

  <div class="col-xs-12 col-sm-2 text-center">
    <input class="btn btn-success nomargin" id="btnSearch" name="submit" type="button" value="Search" />
  </div>
</cfoutput>
</div>




<!--- Analytics
================================================== --->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-23314189-4', 'illinoiscomptroller.com');
  ga('send', 'pageview');

  $(document).ready(function(){
    $(".select2").select2();

    $('#btnSearch').on( "click", function() {
      if($("#fiscalYear").val() == ""){
        return false;
      }

      if($("#fiscalYear").val().indexOf("/") != -1){
        window.open($("#fiscalYear").val(), '_blank');
        return false;
      }
    });
});  

</script>

