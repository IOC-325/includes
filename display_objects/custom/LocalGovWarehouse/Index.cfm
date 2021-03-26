<cfparam name="variables.ReportNo" default="">

<cfif isDefined("form.ReportNo")>
  <cfset variables.ReportNo = form.ReportNo>
</cfif>

<p>The Warehouse is your portal to local government finances. Each year, the Comptroller's Office collects more than 9,200 financial reports from counties, municipalities, and special taxing districts across the state. We have taken those records and made them all available for taxpayer review at this site, allowing you to scour our Warehouse from wherever you are located.</p>

    <p>You can search the Warehouse by report type, unit of government or community name. Once you have selected a local government, you will be taken to a landing page where you can review a snapshot of finances, Annual Financial Reports, and Audits. And by clicking on a "compare data" button, you can see how one unit of government stacks up against another.</p>

<div class="text-center">
      <a class="btn btn-primary" href="https://depts-uat.illinoiscomptroller.gov/Office/LocalGovt/LGReportCardVs2/index.cfm">Data Summaries</a>
  	  <a class="btn btn-primary" href="/financial-data/local-government-division/financial-databases/">Financial Databases</a>
  </div>
<cfoutput>
  <form action="/financial-data/local-government-division/local-government-data/searchform" id="localGovWarehouse" method="post" name="localGovWarehouse">
    <div class="row margintop30">
        <div class="col-xs-12 col-sm-3 label-div">
            <div class="btn-label-grey btn-label label-gray">Report Name</div>
        </div>

        <div class="col-xs-12 col-sm-7 default-select">
            <select id="ReportNo" class="select2" name="ReportNo">
                <option value="" <cfif variables.ReportNo EQ ""> selected </cfif>>Select Report Name</option>
                <option value="AFRSearch" <cfif variables.ReportNo EQ "<cfif variables.ReportNo EQ ""> selected </cfif>"> selected </cfif>> Annual Financial Reports</option>
                <option value="AuditSearch" <cfif variables.ReportNo EQ "AuditSearch"> selected </cfif>> Annual Audits</option>
                <option value="TIFSearch" <cfif variables.ReportNo EQ "TIFSearch"> selected </cfif>> Tax Increment Financial Reports (TIF)</option>
                <option value="/office/LocalGovernment/DisplayAllDelinquenciesPDF.cfm/">Delinquent Reports</option>
                <option value="/financial-data/local-government-division/local-government-data/circuit-clerk/">Circuit Clerk Funds Report</option>
                <option value="/financial-data/find-a-report/fundamental-reporting/fiscal-responsibility-report-card/">Fiscal Responsibility Report Card</option>
                <option value="/financial-data/local-government-division/local-government-data/older-local-government-reports/">Older Local Government Reports</option>
            </select>
        </div>

         <div class="col-xs-12 col-sm-2 text-center">
            <input class="btn btn-success nomargin" id="btnSearch" name="submit" type="submit" value="Search" />
            <!--- onclick='window.location.href = $("##reportName").val();' --->
          </div>
    </div>
  </form>
</cfoutput>
<script type="text/javascript">
$(document).ready(function(){
  $(".select2").select2();

  $('#btnSearch').on( "click", function() {
    if($("#ReportNo").val() == ""){
      return false;
    }
    if($("#ReportNo").val().indexOf("/") != -1){
      //alert($("#ReportNo").val());
      window.location.href = $("#ReportNo").val();
      return false;
    }
    else{
      //$( "#localGovWarehouse" ).submit();
      $("#localGovWarehouse").attr("action", "/financial-data/local-government-division/local-government-data/searchform?SearchType=" + $("#ReportNo").val() );
      $( "form" ).submit();
      return true;
    }
  });


});  
</script>      