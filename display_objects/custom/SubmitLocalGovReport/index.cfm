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
                    <option val="">Select Report Name</option>
                    <option value="https://comptrollerconnect.ioc.state.il.us/Office/LocalGovt/CircuitClerkReports/CircuitClerkLogin.cfm">Circuit Clerk Reporting Portal (CCRP)</option>
                   <option value="https://comptrollerconnect.illinoiscomptroller.gov/login/index1.cfm">Comptroller Connect Internet Filing (CCIF)</option>            
                    <option value="https://apps.ioc.state.il.us/Office/LocalGovt/TIFReports/UpldTIFRptLogStp1.cfm">TIF Reporting (TIF)</option>          
                </select>
              </div>

              <div class="col-xs-12 col-sm-2 text-center">
                <input class="btn btn-success nomargin" id="btnSearch" name="submit" type="button" value="Search" 
                onclick='if($("##reportName").val() != "") window.open ($("##reportName").val(), "_blank")' />
                <!--- onclick='window.location.href = $("##reportName").val();'  --->
              </div>
            </div>
          </form>  
    </div>

  </div> <!--- end payment ---> <br><br><br>           
</cfoutput>
<script type="text/javascript">
$(document).ready(function(){

  $(".select2").select2();
});  
</script>