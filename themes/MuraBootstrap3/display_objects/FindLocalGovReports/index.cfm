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
                  <option value="/financial-data/find-a-report/budgetary-reporting/agency-invoice-reports/">Agency Invoice Reports</option>
                  <option value="https://appropreport.illinoiscomptroller.gov/">Appropriations</option>
                  <option value="/financial-data/find-a-report/budgetary-reporting/bond-indebtedness-and-long-term-obligations-report/">Bonded Indebtedness And Long-Term Obligations Report</option>
                  <option value="/financial-data/find-a-report/comprehensive-reporting/comprehensive-annual-financial-report-cafr/">Comprehensive Annual Financial Report (CAFR)</option>
                  <option value="/financial-data/find-a-report/comptrollers-quarterly/">Comptroller's Quarterly</option>
                  <option value="/financial-data/debt-transparency-reports-dtr/">Debt Transparency Reports</option>                    
                  <option value="/financial-data/find-a-report/comprehensive-reporting/detailed-report-of-revenues-and-expenditures-budgetary-basis/">Detailed Report of Revenues and Expenditures (Budgetary Basis)</option>
                  <option value="/financial-data/find-a-report/comprehensive-reporting/detailed-annual-report-of-revenues-and-expenditures/">Detailed Annual Report of Revenues and Expenditures</option>
                  <option value="/financial-data/find-a-report/comprehensive-reporting/executive-summary/">Executive Summary</option>
                  <option value="/financial-data/find-a-report/fee-imposition-report/">Fee Imposition Report</option>
                  <option value="https://it-milestones-uat.illinoiscomptroller.gov/">IT Milestone Report</option>
                  <option value="/financial-data/find-a-report/budgetary-reporting/locally-held-funds-report/">Locally Held Funds Report</option>
                  <option value="/financial-data/local-government-division/local-government-data/searchform/?SearchType=AFRSearch">Local Government: Annual Financial Report</option>
                  <!--- <option value="">Local Government: Economic Development Area Annual Report</option> --->
                  <option value="/financial-data/find-a-report/fundamental-reporting/fiscal-responsibility-report-card/">Local Government: Fiscal Responsibility Report Card</option>                  
                  <option value="/financial-data/local-government-division/local-government-data/searchform/?SearchType=TIFSearch">Local Government: Tax Increment Finance Report</option>
                                    
                  <option value="/financial-data/find-a-report/budgetary-reporting/monitored-bond-report/">Monitored Bond Report</option>
                  <option value="/financial-data/find-a-report/budgetary-reporting/monthly-bond-report/">Monthly Bond Report</option>
                  <option value="/financial-data/find-a-report/budgetary-reporting/monthly-summary-of-general-funds-revenues-expenditures/">Monthly Summary Of General Funds Revenues & Expenditures </option>
                  <option value="/financial-data/find-a-report/public-accountability-report/">Public Accountability Report</option>                   
                  <option value="/financial-data/find-a-report/budgetary-reporting/receivables-report/">Receivables Report</option>
                  <option value="/financial-data/find-a-report/budgetary-reporting/section-25-deferred-liabilities/">Section 25 Deferred Liabilities</option>
                  <option value="/financial-data/find-a-report/special-fiscal/">Special Fiscal Reports</option>
                  <option value="/financial-data/find-a-report/tax-expenditure-report/">Tax Expenditure Report</option>                      
                  <option value="/financial-data/find-a-report/budgetary-reporting/traditional-budgetary-financial-report/">Traditional Budgetary Financial Report</option>        
                  <option value="https://uat.illinoiscomptroller.gov/Office/VendorPaymentProgram">Vendor Payment Program: Financial Backer Disclosure Reports</option>
                  <option value="/financial-data/find-a-report/vendor-payment-program-qualified-purchaser-monthly-reports/">Vendor Payment Program: Qualified Purchaser Monthly Reports</option>
                  <option value="/financial-data/find-a-report/comprehensive-reporting/underwriters-participation-in-credit-default-swaps-report/">Underwriters' Participation in Credit Default Swaps Report</option>
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