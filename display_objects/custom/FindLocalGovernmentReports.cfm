<cfscript>
  param name='message' default={};
</cfscript>

<cfoutput>

  <!-- START PAYMENT -->
  <div id="payment" class="contract">
    <div class="main2">
          <form enctype="application/x-www-form-urlencoded" id="searchform" name="submitAReport" preloader="no">
            <div class="row">
              <div class="col-xs-12 col-sm-3 label-div">
                <div class="btn-label-grey btn-label label-gray">report name</div>
              </div>

              <div class="col-xs-12 col-sm-7 default-select">
                <select id="reportName" name="reportName" class="select2">
                  <option value="/financial-data/local-government-division/local-government-data/searchform/?SearchType=AFRSearch">Local Government: Annual Financial Report</option>
                  <!--- <option value="">Local Government: Economic Development Area Annual Report</option> --->
                  <option value="/financial-data/find-a-report/fundamental-reporting/fiscal-responsibility-report-card/">Local Government: Fiscal Responsibility Report Card</option>                  
                  <option value="/financial-data/local-government-division/local-government-data/searchform/?SearchType=TIFSearch">Local Government: Tax Increment Finance Report</option>
                </select>
              </div>

              <div class="col-xs-12 col-sm-2 text-center">
                <input class="btn btn-success nomargin" id="btnSearch" name="submit" type="button" value="Search" 
                onclick='window.open ($("##reportName").val(), "_blank")' />
                <!--- onclick='window.location.href = $("##reportName").val();' --->
              </div>
            </div>
          </form>  
    </div>

  </div> <!--- end payment --->                    
</cfoutput>

<script type="text/javascript">
$(document).ready(function(){

  $(".select2").select2();
});  
</script>