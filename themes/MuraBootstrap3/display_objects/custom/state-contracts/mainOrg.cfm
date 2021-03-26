<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css" />
<cfparam name="FY" default="#DATEFORMAT(NOW(), 'yyyy')#">

<cfparam name="variables.FindVendor" default="">
<cfparam name="Sendto" default="">
<cfparam name="variables.FiscalYear" default="">
<cfparam name="variables.AgencyName" default="">
<cfparam name="variables.ClassDescription" default="">
<cfparam name="variables.TypeDescription" default="">
<cfparam name="variables.AwardDescription" default="">
<cfparam name="variables.vendorName" default="">
<cfparam name="variables.contractClass" default="">
<CFIF IsDefined ("form.contractFY")>
  <CFSET variables.FY = form.contractFY>
  <cfset variables.AgencyName = form.contractAgency>
  <cfset variables.FiscalYear = form.contractFY>
  <cfset variables.ClassDescription = form.contractClass>
  <cfset variables.contractClass = form.contractClass>
  <cfset variables.TypeDescription = form.contractType>
  <cfset variables.AwardDescription = form.contractAward>
  <CFSET variables.FindVendor = form.FindVendor>
  <CFIF IsDefined ("form.ContractVendor")>
  <cfset variables.vendorName = form.contractVendor>
</CFIF>

<cfelseif IsDefined ("URL.Issue_Year")>

  <cfinvoke
    component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2_v2"
    method = "decodeHtmlEntity"
    returnVariable = "arguments.str">

    <cfinvokeargument name="str" value="#URL.Agency#">
  </cfinvoke>

  <CFSET variables.FY = URL.Issue_Year>
  <CFSET variables.AgencyName = TRIM(arguments.str)>

<cfelse>
  <!--- Get Most Previous Fiscal Year that has stats --->
  <cfinvoke
    component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2_v2"
    method = "GetDefaultYear"
    returnVariable = "GetFY">
  </cfinvoke>

  <CFIF GetFY.recordcount GT 0>
    <CFSET FY = GetFY.Fiscal_Year>
  </CFIF>

</CFIF>

<CFIF isDefined("form.contractFY")>
  <!--- Get Submitted form results --->
  <cfinvoke
    component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2_v2"
    method = "GetContractInfo"
    returnVariable = "GetContractInfo">
    <cfinvokeargument name="formData" value="#form#">
  </cfinvoke>
<cfelse>
  <!--- Get Default Results --->
  <cfinvoke
    component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2_v2"
    method = "GetContractInfoDefault"
    returnVariable = "GetContractInfo">
    <cfinvokeargument name="FY" value="#FY#">
  </cfinvoke>
</CFIF>

<!--- Get all Fiscal Years --->
<cfinvoke
  component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2"
  method = "GetAllFiscalYears"
  returnVariable = "qFY">
</cfinvoke>

<!--- Get all Agency Names --->
<cfinvoke
  component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2"
  method = "GetAgencyNames"
  returnVariable = "qAN">
</cfinvoke>

<!--- Get all award descriptions --->
<cfinvoke
  component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2"
  method = "GetAwardDescriptions"
  returnVariable = "qAD">
</cfinvoke>

<!--- Get all Type Description --->
<cfinvoke
  component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2"
  method = "GetAllTypeDescriptions"
  returnVariable = "qATD">
</cfinvoke>

<!--- Get all class descriptions --->
<cfinvoke
  component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2"
  method = "GetAllClassDescriptions"
  returnVariable = "qCD">
</cfinvoke>

<!--- Get all Vendor Names --->
<cfinvoke
  component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2"
  method = "GetAllVendorNames"
  returnVariable = "qAVN">
</cfinvoke>

<cfoutput>
  <!-- START PAYMENT -->
  <div id="payment" class="contract">
    <div class="main2">
      <div class="row">
        <div class="col-sm-10 col-sm-offset-1">
          <h1>#$.getTitle()#</h1>
          #$.getSummary()#
          <div class="row">
            <cfform name="DisplayValue" action="/Ledger/?LinkServID=9189969B-A18B-217C-CDD5409621DE44CC" method="Post">
                                          <fieldset>
                                            <div class="col-sm-8 col-sm-offset-2">
                                              <label>Search by Vendor Name</label>
                                              <input type="text"  name="FindVendor" size="32" maxlength="32" value="#variables.FindVendor#" class="form-control">
                                            </div>
                                            <div class="col-sm-12 custom-pad-around">
                                              <div class="row">
                                                  <div class="col-sm-3">
                                                    <select id="contractFY" name="contractFY">
                                                      <option value="0">All Fiscal Years</option>
                                                      <cfloop query = "qFY">
                                                        <option value="#qFY.FiscalYear#"
                                                        <cfif variables.FiscalYear eq qFY.FiscalYear> selected </cfif>
                                                        >#qFY.FiscalYear#</option>
                                                      </cfloop>
                                                    </select>
                                                  </div>
                                                  <div class="col-sm-9">
                                                    <select  id="contractAgency" name="contractAgency" >
                                                      <option value="0">All Agencies</option>
                                                      <cfloop query = "qAN">
                                      <option value="#qAN.AgencyName#"
                          <cfif TRIM(variables.AgencyName) eq TRIM(qAN.AgencyName)> selected</cfif>>#qAN.AgencyName#</option>
                                                      </cfloop>
                                                    </select>
                                                  </div>
                                                  <div class="col-sm-4">
                                                    <select  id="contractAward" name="contractAward" >
                                                      <option value="0">All Award Descriptions</option>
                                                      <cfloop query = "qAD">
                                                        <option value="#qAD.AwardDescription#"
                                                        <cfif variables.AwardDescription eq qAD.AwardDescription> selected </cfif>
                                                        >#qAD.AwardDescription#</option>
                                                      </cfloop>
                                                    </select>
                                                  </div>
                                                  <div class="col-sm-4">
                                                    <select  id="contractType" name="contractType" >
                                                      <option value="0">All Type Descriptions</option>
                                                      <cfloop query = "qATD">
                                                        <option value="#qATD.TypeDescription#"
                                                        <cfif variables.TypeDescription eq qATD.TypeDescription> selected </cfif>
                                                        >#qATD.TypeDescription#</option>
                                                      </cfloop>
                                                    </select>
                                                  </div>
                                                  <div class="col-sm-4">
                                                    <!--- <select  id="contractClass" name="contractClass" >
                                                      <option value="0">All Class Descriptions</option>
                                                      <cfloop query = "qCD">
                                                        <option value="#TRIM(qCD.ClassDescription)#" <cfif IsDefined ("form.contractClass") AND form.contractClass IS TRIM(qCD.ClassDescription)> selected </cfif>>
                                      #qCD.ClassDescription#</option>
                                                      </cfloop>
                                                    </select> --->
                                                    <cfselect name="contractClass"
                                                    id="contractClass"
                                                    query="qCD"
                                                    value="ClassDescription"
                                                    display="ClassDescription"
                                                    selected="#variables.ContractClass#">
                                                     <option value="0" selected="selected">All Class Descriptions</option>
                                                    </cfselect>
                                                  </div>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="text-center col-sm-12">
                                            <cfinput type="submit" name="submitted" class="btn btn-success" value="Search">
                                            </div>

                                          </fieldset>
            </cfform>

          </div> <!--- end row --->
        </div> <!--- end col-sm-10 col-sm-offset-1 --->
      </div> <!--- end row --->
    </div> <!--- end main2 --->

    <!--- start table --->
<!---     <BR /><BR /> --->

    <div class="col-sm-12">
      <div class="result">
        <div class="table-responsive">
          <table class="datatable table-striped datatable-primary">
            <thead>
              <tr>
                <th class="bg-info"><br><br>Agency<br></th>
                <th class="bg-info"><br>Contract<br>Number<br></th>
                <th class="bg-info"><br>Award<br>Description<br></th>
                <th class="bg-info"><br>Type<br>Description<br></th>
                <th class="bg-info"><br>Class<br>Description<br></th>
                <th class="bg-info"><br><br>Vendor<br></th>
                <th class="bg-info"><br>Vendor<br>Line 2<br></th>
                <th class="cldate bg-info"><br>From<br>Date<br></th>
                <th class="cldate bg-info"><br>To<br>Date<br></th>
                <th class="sum bg-info">Current<br>Contract<br>Amount<br></th>
                <th class="sum bg-info">Planned<br>Contract<br>Amount<br></th>
                <th class="sum bg-info">Current<br>Expended<br>Amount<br></th>
              </tr>
            </thead>
            <tfoot>
              <tr>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
              </tr>
            </tfoot>
            <tbody id="content">
<!---                 <cfloop query="GetContractInfo">
                  <cfset TmpSubject="FOIA%20Request%20for%20Contract Number%20" & #trim(Contract_Number)#>
                  <cfset TmpBody="My%20name%20is%20[Replace%20this%20text%20with%20your%20First%20and%20Last%20Name]%20and%20I%20represent%20[Please%20replace%20this%20text%20with%20your%20employer%20if%20this%20request%20pertains%20to%20your%20job%20responsibilities;%20otherwise,%20just%20delete%20this%20text.].  Pursuant%20to%20the%20Illinois%20Freedom%20of%20Information%20Act%20(5%20ILCS%20140/1%20et%20seq.),%20I%20respectfully%20request%20a%20copy%20of%20contract%20number%20" & #trim(Contract_Number)# & ",%20an%20agreement%20between%20" & #trim(Agency_Name)# & "%20and%20" & #trim(Name)# & ".%20%20I%20understand%20the%20Office%20of%20the%20Comptroller%20will%20not%20impose%20a%20fee%20for%20processing%20non-commercial%20requests%20but%20reserves%20its%20statutory%20right%20to%20impose%20such%20fees%20in%20the%20future.%20%20I%20further%20understand%20that%20a%20representative%20from%20the%20Office%20of%20the%20Comptroller%20will%20contact%20me%20at%20the%20e-mail%20address%20provided%20to%20establish%20a%20delivery%20method%20that%20best%20fits%20my%20needs.">
                  <tr>
                    <td>#trim(Agency_Name)#</td>
                    <td><a href="mailto:#Sendto#?Subject=#TmpSubject#&Body=#TmpBody#">#trim(Contract_Number)#</a></td>
                    <td>#trim(Award_Description)#</td>
                    <td>#trim(Type_Description)#</td>
                    <td>#trim(Class_Description)#</td>
                    <td>#trim(Name)#</td>
                    <td>&nbsp;#trim(NameII)#</td>
                    <td>#DateFormat(From_Date,"mm/dd/yyyy")#</td>
                    <td>#DateFormat(To_Date,"mm/dd/yyyy")#</td>
                    <td>#DollarFormat(Contract_Amt)#</td>
                    <td>#DollarFormat(Max_Contract_Amt)#</td>
                    <td data-toggle="modal" href="##myModal" class="modalInfo" data-vname="#trim(Name)#" data-contractnumber="#trim(Contract_Number)#" data-agencyname="#trim(Agency)#">
                     #dollarformat(Expended_Amt)#</td>
                  </tr>
                </cfloop> --->
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <!--- end table --->

  </div> <!--- end payment --->

  <!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog" style="width: 50%">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" align="center">Vendor Warrant List for <strong><span id="headerVendorName"</span></strong> </h4>
      </div>
      <div class="modal-body">
        <div id="VendWarrantList" class="table-responsive" style="width:100%">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
  <!-- END modal -->
</cfoutput>

<script>
$(document).ready(function(){
 $(".modalInfo").click(function(event) {
  //get the vendor name and Fy
  $('#myModal').find("#headerVendorName").text($(this).data("vname"));
  //$('#myModal').find("#VendorNameInfo").text($(this).data("name"));
  //$('#myModal').find("#FYValue").text($(this).data("fy"));
  if($(this).data("agencyname") !== "" || $(this).data("contractnumber") !== ""){
   $("#myModal").show();
         $.ajax({
            url: "/Queries/autosuggest.cfc?method=VendorWarrantListingDatesAmounts&returnformat=json",
            type: "GET",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data:{
            Agency: $(this).data("agencyname"),
            ContractNum: $(this).data("contractnumber")
            },
            success: function (data) {
             //initialize the table
             var trHTML = '<table id="tblVendWarrantList" class="datatable table-striped" align="center" style="font-size:18px;"><thead><tr><th>Issue Date</th><th>&nbsp;</th><th>Payment Amount</th><th>&nbsp;</th></tr></thead><tbody>';
             if(data.length >=1){
               $.each(data, function (i, item) {
                //for each element form tr
                 trHTML += '<tr><td>' + item.ACCEPTANCE_DATE + '</td><td>&nbsp;</td><td>' + item.EXPENDED_AMT + '</a></td><td>&nbsp;</td></tr>';
                 //get contract Info
               });
             }
             else{
              trHTML = '<div align="center">No records</div>';
             }

             trHTML += '</tbody></table>'
             //apped to the div
             $('#VendWarrantList').html(trHTML);
             },
             error: function (msg) {
                 alert(msg.responseText);
             }
         });
     }
  //console.log($(this).data("fy"));
 });

});
</script>
<script src="/ledger/includes/themes/TheLedger/js/dataTables.dateFormat.js"></script>
