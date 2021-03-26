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
                    <option>Select</option>
                    <option value="https://depts.illinoiscomptroller.gov/563/login/index.cfm">563</option>
                    <!--- <option value="http://bits.illinoiscomptroller.gov/">Bonded Indebtedness Tracking System</option> --->
                    <option value="https://depts.illinoiscomptroller.gov/office/localgovt/circuitclerkreports/circuitclerklogin.cfm">Circuit Clerk Reporting Portal (CCRP)</option>
                    <option value="https://comptrollerconnect.illinoiscomptroller.gov/login/index1.cfm">Comptroller Connect Internet Filing (CCIF)</option>
                    <option value="https://depts.illinoiscomptroller.gov/office/FeeRptSQL/Login/">Fee Imposition Report</option>
                    <option value="https://lhf.illinoiscomptroller.gov">Locally Held Funds</option>
                    <option value="https://place.illinoiscomptroller.gov">PLACE - eFile</option>                    
                    <option value="https://pareporting.illinoiscomptroller.gov/Login/Index1.cfm">Public Accountability Report</option>
                    <option value="https://depts.illinoiscomptroller.gov/office/TaxExpSQL/Login/">Tax Expenditure Report</option>
                    <option value="https://depts.illinoiscomptroller.gov/Office/LocalGovt/TIFReports/UpldTIFRptLogStp1.cfm">TIF Reporting (TIF)</option>
                    <option value="https://wedge.illinoiscomptroller.gov/">WEDGE</option>
                </select>
              </div>

              <div class="col-xs-12 col-sm-2 text-center">
                <input class="btn btn-success nomargin" id="btnSearch" name="submit" type="button" value="Search" 
                onclick='if($("##reportName").val() != "Select") window.open ($("##reportName").val(), "_blank")' />
                <!--- onclick='window.location.href = $("##reportName").val();'  --->
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