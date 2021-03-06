<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css" />
<cfparam name="FY" default="#DATEFORMAT(NOW(), 'yyyy')#">
<cfparam name="variables.FindVendor" default="">
<cfparam name="Sendto" default="FOIA@illinoiscomptroller.gov">
<cfparam name="variables.FiscalYear" default="">
<cfparam name="variables.AgencyName" default="">
<cfparam name="variables.ClassDescription" default="">
<cfparam name="variables.TypeDescription" default="">
<cfparam name="variables.AwardDescription" default="">
<cfparam name="variables.vendorName" default="">
<cfparam name="variables.contractClass" default="">
<cfparam name="variables.ContractVendor" default="">
<cfparam name="variables.SortColumn" default="Agency_Name">
<cfparam name="variables.SortDirection" default="0">
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

<CFIF IsDefined ("FORM.SortColumn")>
 	<CFSET variables.SortColumn = FORM.SortColumn>
    <CFIF IsDefined ("FORM.Header")>
    	<!--- The Header Sort are selected --->
		<CFIF FORM.SortDirection IS 0>
            <CFSET variables.SortDirection = 1>
            <CFSET FORM.SortDirection = 1>
        <cfelse>
            <CFSET variables.SortDirection = 0>
            <CFSET FORM.SortDirection = 0>
        </CFIF>
     <cfelse>
     	<CFSET variables.SortDirection = FORM.SortDirection>
    </CFIF>
 </CFIF>

<cfelseif IsDefined ("URL.contractFY")>
  <CFSET variables.FY = TRIM(URLDecode(URL.contractFY, 'utf-8'))>
  <cfset variables.AgencyName = TRIM(URLDecode(URL.contractAgency, 'utf-8'))>
  <cfset variables.FiscalYear = TRIM(URLDecode(URL.contractFY, 'utf-8'))>
  <cfset variables.ClassDescription = TRIM(URLDecode(URL.contractClass, 'utf-8'))>
  <cfset variables.contractClass = TRIM(URLDecode(URL.contractClass, 'utf-8'))>
  <cfset variables.TypeDescription = TRIM(URLDecode(URL.contractType, 'utf-8'))>
  <cfset variables.AwardDescription = TRIM(URLDecode(URL.contractAward, 'utf-8'))>
  <CFSET variables.FindVendor = TRIM(URLDecode(URL.FindVendor, 'utf-8'))>
  <CFIF IsDefined ("URL.ContractVendor")>
  	<cfset variables.vendorName = TRIM(URLDecode(URL.contractVendor, 'utf-8'))>
  </CFIF>
  <CFIF IsDefined ("URL.SortColumn")>
 	<CFSET variables.SortColumn = URL.SortColumn>
    <CFIF IsDefined ("URL.Header")>
    	<!--- The Header Sort are selected --->
		<CFIF URL.SortDirection IS 0>
            <CFSET variables.SortDirection = 1>
            <CFSET URL.SortDirection = 1>
        <cfelse>
            <CFSET variables.SortDirection = 0>
            <CFSET URL.SortDirection = 0>
        </CFIF>
     <cfelse>
     	<CFSET variables.SortDirection = URL.SortDirection>
    </CFIF>
 </CFIF>
<CFSET form.SortDirection = variables.SortDirection>
<CFSET form.SortColumn = variables.SortColumn>
<CFSET form.contractFY = TRIM(URLDecode(URL.contractFY, 'utf-8'))>
  <cfset form.contractAgency = TRIM(URLDecode(URL.contractAgency, 'utf-8'))>
  <cfset form.contractClass = TRIM(URLDecode(URL.contractClass, 'utf-8'))>
  <cfset form.contractClass = TRIM(URLDecode(URL.contractClass, 'utf-8'))>
  <cfset form.contractType = TRIM(URLDecode(URL.contractType, 'utf-8'))>
  <cfset form.contractAward = TRIM(URLDecode(URL.contractAward, 'utf-8'))>
  <CFSET form.FindVendor = TRIM(URLDecode(URL.FindVendor, 'utf-8'))>
  <CFIF IsDefined ("URL.ContractVendor")>
  	<cfset form.contractVendor = TRIM(URLDecode(URL.contractVendor, 'utf-8'))>
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
<!--- Set Pagination metrics  --->
<cfparam name="URL.PageIndex" default="0">
<CFSET RecordsPerPage = 10>
<CFSET TotalPages = Ceiling((GetContractInfo.recordcount / RecordsPerPage) - 1)>
<CFSET StartRow = (URL.PageIndex * RecordsPerPage) + 1>
<CFSET EndRow = StartRow + RecordsPerPage - 1>

<cfoutput>
  <!-- START PAYMENT -->
  <div id="payment" class="contract">
    <div class="main2">
      <div class="row">
        <div class="col-sm-10 col-sm-offset-1">
          <h1>#$.getTitle()#</h1>
          #$.getSummary()#
           <div class="example alert alert-danger hidden" id="errorMsg"> Please Enter Search Criteria.</div>
          <div class="row">
            <cfform method="post" enctype="application/x-www-form-urlencoded" name="DisplayValue" preloader="no">
                                          <fieldset>
                                            <div class="col-sm-8 col-sm-offset-2">
                                              <label>Search by Vendor Name</label>
                                              <input type="text" id="FindVendor" name="FindVendor" size="32" maxlength="32" value="#variables.FindVendor#" class="form-control">
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

                                                    <cfselect name="contractClass"
                                                    id="contractClass"
                                                    query="qCD"
                                                    value="ClassDescription"
                                                    display="ClassDescription"
                                                    selected="#variables.ContractClass#"
                                                    queryPosition="below">
                                                     <option value="0" selected="selected">All Class Descriptions</option>
                                                    </cfselect>
                                                  </div>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="text-center col-sm-12">
                                            <cfinput type="submit" id="btnSearch" name="submitted" class="btn btn-success" value="Search">
                                            </div>

                                          </fieldset>
            </cfform>

          </div> <!--- end row --->
        </div> <!--- end col-sm-10 col-sm-offset-1 --->
      </div> <!--- end row --->
      <!--- new row for bulk download --->
      <div class="row">
        <div class="col-sm-10 col-sm-offset-1">
              <cfif isDefined("GetContractInfo") && GetContractInfo.recordcount GT 5000><br>
                 <cfset ExportFile = "SC_CFY_VendorName.csv">
                 <div class="alert alert-info small"><span class="small">CSV download is unavailable for a search result greater than 5,000 records.
                  <cftry>
                     <cffile action = "read" variable="TestAgency"
                     file = "\\ioc-webvm-cf1.iocweb.net\Downloads$\#ExportFile#">
                     
                        <a href="http://ledger.illinoiscomptroller.gov/downloads/#exportfile#">Download Entire Contracts Database</a>
                     <cfcatch>
                     </cfcatch>
                     </cftry>
                  </span>
                  </div>
                </cfif>
          </div>
        </div>
      <!--- end new row for bulk download --->
    </div> <!--- end main2 --->


    <div class="col-sm-12">
    <p class="RecordCountLabel">Records found: <B>#NUMBERFORMAT(GetContractInfo.recordcount)#</B> Total Pages: <B>#NUMBERFORMAT(TotalPages)#</B></p>
      <div class="result">
        <div class="table-responsive">
          <table class="ManualTable table table-striped">
            <thead>
              <tr>
                <th class="bg-info"><br><br><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=1&SortDirection=#variables.SortDirection#&header=true">Agency</a><br></th>
                <th class="bg-info"><br><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=2&SortDirection=#variables.SortDirection#&header=true">Contract<br>Number</a><br></th>
                <th class="bg-info"><br><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=3&SortDirection=#variables.SortDirection#&header=true">Award<br>Description</a><br></th>
                <th class="bg-info"><br><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=4&SortDirection=#variables.SortDirection#&header=true">Type<br>Description</a><br></th>
                <th class="bg-info"><br><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=5&SortDirection=#variables.SortDirection#&header=true">Class<br>Description</a><br></th>
                <th class="bg-info"><br><br><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=6&SortDirection=#variables.SortDirection#&header=true">Vendor</a><br></th>
                <th class="bg-info"><br><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=7&SortDirection=#variables.SortDirection#&header=true">Vendor<br>Line 2</a><br></th>
                <th class="cldate bg-info"><br><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=8&SortDirection=#variables.SortDirection#&header=true">From<br>Date</a><br></th>
                <th class="cldate bg-info"><br><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=9&SortDirection=#variables.SortDirection#&header=true">To<br>Date</a><br></th>
                <th class="sum bg-info"><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=10&SortDirection=#variables.SortDirection#&header=true">Current<br>Contract</a><br>Amount<br></th>
                <th class="sum bg-info"><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=11&SortDirection=#variables.SortDirection#&header=true">Planned<br>Contract</a><br>Amount<br></th>
                <th class="sum bg-info"><a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=12&SortDirection=#variables.SortDirection#&header=true">Current<br>Expended<br>Amount</a><br></th>
              </tr>
            </thead>
            <tbody id="content">
     <cfloop query="GetContractInfo">
     <CFIF CurrentRow GTE StartRow>
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
                  </cfif>
				<CFIF CurrentRow IS EndRow>
                	<cfbreak>
                </CFIF>
                </cfloop>
            </tbody>
          </table>
          <!--- Page numbers  --->
               <div id="pg">
                <ul class="pagination">
                <CFSET MiddlePageNumberNextSwitch = false>
                 <!--- Display First Page link only if the page number being viewed is greater than 1 and there is more than 3 pages of records --->
                    <CFIF VAL(URL.PageIndex) IS NOT 1 AND TotalPages GTE 3>
                    	 <li><a href="?PageIndex=0&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=#variables.SortColumn# &SortDirection=#variables.SortDirection#"><< First</a></li>
                    </CFIF>
                    <!--- Display the middle 7 page numbers central around the page number being viewed--->
                    <cfloop index="Pages" from="0" to="#TotalPages#">
						<CFSET DisplayPgNo = Pages + 1>
                        <CFIF DisplayPgNo GTE (URL.PageIndex - 3) AND DisplayPgNo LTE (URL.PageIndex + 3)>
							<CFIF URL.PageIndex IS pages>
                               <li><a href="?PageIndex=#pages#&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=#variables.SortColumn#&SortDirection=#variables.SortDirection#"><strong>#DisplayPgNo#</strong></a></li>
                            <cfelse>
                                <li><a href="?PageIndex=#pages#&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=#variables.SortColumn#&SortDirection=#variables.SortDirection#">#DisplayPgNo#</a>  </li>
                            </CFIF>
                          <cfelseif MiddlePageNumberNextSwitch IS false AND DisplayPgNo GT (URL.PageIndex - 4) AND URL.PageIndex LT TotalPages>
                          	<!--- Goto Next Page only --->
                             <li><a href="?PageIndex=#pages+1#&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=#variables.SortColumn#&SortDirection=#variables.SortDirection#">Next</a></li>
                            <CFSET MiddlePageNumberNextSwitch = true>
                        </CFIF>
                    </cfloop>

                                <!--- Last Page  --->
                	<CFIF URL.PageIndex IS NOT TotalPages AND TotalPages GTE 3>
                    	 <li><a href="?PageIndex=#TotalPages#&contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.ClassDescription#&contractType=#variables.TypeDescription#&contractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#&SortColumn=#variables.SortColumn#&SortDirection=#variables.SortDirection#">Last >> [#TotalPages#]</a></li>
                    </CFIF>
                    </ul>
                </div>

        </div>
      </div>
    </div>
    
    <div class="col-sm-12 text-center">  
            <cftry>
              <a href="http://ledger.illinoiscomptroller.gov/downloads/#exportfile#" class="btn btn-info" role="button" style="margin-bottom:10px;">Download Entire Contracts Database</a>
            <cfcatch type="any" >
            </cfcatch>
            </cftry>
      <!--- File Download Code End --->
    </div>


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

<script src="/ledger/includes/themes/TheLedger/js/dataTables.dateFormat.js"></script>
<script>
$(document).ready(function(){

   $("#btnSearch").click(function(event){
	   
      if($("#FindVendor").val() === "" && $("#contractAgency").val() === "0" && $("#contractAward").val() === "0" && $("#contractType").val() === "0" && $("#contractClass").val() === "0")
      {
        $("#errorMsg").toggleClass('hidden show');
        event.preventDefault();
      }
      else{
        $("#errorMsg").toggle();
	    $('#DisplayValue').submit();
      }
   });

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