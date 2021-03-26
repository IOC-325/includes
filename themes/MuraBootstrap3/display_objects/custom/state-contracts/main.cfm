<!--- state contracts --->
<link href="/comptroller/includes/themes/MuraBootstrap3/css/pageloading.css" rel="stylesheet" type="text/css"/>

<cfparam name="variables.FY" default="20#application.cfy#">
<cfparam name="variables.FindVendor" default="">
<cfparam name="Sendto" default="FOIA@illinoiscomptroller.gov">
<cfparam name="variables.FiscalYear" default="">
<cfparam name="variables.AgencyName" default="">
<cfparam name="variables.TypeDescription" default="">
<cfparam name="variables.AwardDescription" default="">
<cfparam name="variables.vendorName" default="">
<cfparam name="variables.contractClass" default="">
<cfparam name="variables.ContractVendor" default="">
<cfparam name="variables.SortColumn" default="Agency_Name">
<cfparam name="variables.SortDirection" default="0">
<cfparam name="variables.contractType" default="">
<cfparam name="variables.ContactAward" default="">

<CFIF IsDefined("form.contractFY")>
    <CFSET variables.FY = form.contractFY>
    <cfset variables.AgencyName = form.contractAgency>
    <cfset variables.FiscalYear = form.contractFY>
    <cfset variables.contractClass = form.contractClass>
    <cfset variables.TypeDescription = form.contractType>
    <cfset variables.AwardDescription = form.contractAward>
    <CFSET variables.FindVendor = form.FindVendor>
    <CFIF IsDefined("form.ContractVendor")>
        <cfset variables.vendorName = form.contractVendor>
    </CFIF>
    <CFIF IsDefined("FORM.SortColumn")>
        <CFSET variables.SortColumn = FORM.SortColumn>
        <CFIF IsDefined("FORM.Header")>
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

    <cfelseif IsDefined("URL.contractFY")>

    <CFSET variables.FY = TRIM(DecodeFromURL(URL.contractFY))>
    <cfset variables.AgencyName = TRIM(DecodeFromURL(URL.contractAgency))>
    <cfset variables.FiscalYear = TRIM(DecodeFromURL(URL.contractFY))>
    <cfset variables.contractClass = TRIM(DecodeFromURL(URL.contractClass))>
    <cfset variables.TypeDescription = TRIM(DecodeFromURL(URL.contractType))>
    <cfset variables.AwardDescription = TRIM(DecodeFromURL(URL.contractAward))>
    <CFIF TRIM(DecodeFromURL(URL.FindVendor)) IS "Default">
        <CFSET variables.FindVendor = "">
    <cfelse>
        <CFSET variables.FindVendor = TRIM(DecodeFromURL(URL.FindVendor))>
    </CFIF>
    <CFIF IsDefined("URL.ContractVendor") AND TRIM(URL.ContractVendor) IS NOT "">
        <cfset variables.vendorName = TRIM(DecodeFromURL(URL.contractVendor))>
    </CFIF>
    <CFIF IsDefined("URL.SortColumn")>
        <CFSET variables.SortColumn = URL.SortColumn>
        <CFIF IsDefined("URL.Header")>
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
    <CFSET form.contractFY = TRIM(DecodeFromURL(URL.contractFY))>
    <cfset form.contractAgency = TRIM(DecodeFromURL(URL.contractAgency))>
    <cfset form.contractClass = TRIM(DecodeFromURL(URL.contractClass))>
    <cfset form.contractType = TRIM(DecodeFromURL(URL.contractType))>
    <cfset form.contractAward = TRIM(DecodeFromURL(URL.contractAward))>
    <CFSET form.FindVendor = variables.FindVendor>
    <CFIF IsDefined("URL.ContractVendor") AND TRIM(URL.ContractVendor) IS NOT "">
        <cfset form.contractVendor = TRIM(DecodeFromURL(URL.contractVendor))>
    </CFIF>

    <cfelseif IsDefined("URL.Issue_Year")>

        <cfinvoke
                component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
                method="decodeHtmlEntity"
                returnVariable="arguments.str">
                <cfinvokeargument name="str" value="#URL.Agency#">
        </cfinvoke>

    <CFSET variables.FY = URL.Issue_Year>
    <CFSET variables.AgencyName = TRIM(arguments.str)>

<cfelse>
<!--- Get Most Previous Fiscal Year that has stats --->
<!---  Per SR 16071  <cfinvoke
    component = "ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_DB2_v2"
    method = "GetDefaultYear"
    returnVariable = "GetFY">
  </cfinvoke> --->

<!--- A change per SR 16071 <CFIF GetFY.recordcount GT 0>
  <CFSET FY = GetFY.Fiscal_Year> --->
    <cfset variables.FY = "20#application.cfy#">
<!---   </CFIF> --->

    <CFIF IsDefined("URL.ID2")>
        <CFSET variables.FY = URL.ID2>
    </CFIF>

</CFIF>

<CFIF isDefined("form.contractFY")>

<!--- Create a cookie that will retain the users search results  --->
<!--- Cookie stores the selected values as a CSV string  --->
<!--- Cookie CSV position legend:
            1) FindVendor
            2) contractFY
            3) contractAgency
            4) contractAward
            5) contractType
            6) contractClass
--->
    <CFIF TRIM(variables.FindVendor) IS "">
        <CFSET Postion1 = "Default">
    <cfelse>
        <CFSET Postion1 = variables.FindVendor>
    </CFIF>
    <CFIF TRIM(variables.FY) IS "">
        <CFSET Postion2 = "Default">
    <cfelse>
        <CFSET Postion2 = variables.FY>
    </CFIF>
    <CFIF TRIM(variables.AgencyName) IS "">
        <CFSET Postion3 = "Default">
    <cfelse>
        <CFSET Postion3 = variables.AgencyName>
    </CFIF>
    <CFIF TRIM(variables.AwardDescription) IS "">
        <CFSET Postion4 = "Default">
    <cfelse>
        <CFSET Postion4 = variables.AwardDescription>
    </CFIF>
    <CFIF TRIM(variables.TypeDescription) IS "">
        <CFSET Postion5 = "Default">
    <cfelse>
        <CFSET Postion5 = variables.TypeDescription>
    </CFIF>
    <CFIF TRIM(variables.ContractClass) IS "">
        <CFSET Postion6 = "Default">
    <cfelse>
        <CFSET Postion6 = variables.ContractClass>
    </CFIF>

    <cfcookie name="StateContracts" value="#Postion1#,#Postion2#,#Postion3#,#Postion4#,#Postion5#,#Postion6#" expires="never">
<!--- Get Friendly Names --->
        <cfinvoke component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
                method="GetFreindlyName_StateContracts"
                returnvariable="FN1">
        </cfinvoke>

<!--- Get Submitted form results --->


        <cfinvoke
                component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
                method="GetContractInfo"
                returnVariable="GetContractInfo">
                <cfinvokeargument name="formData" value="#form#">
        </cfinvoke>
</CFIF>

<cfif variables.FY IS 0>
    <!--- Get Fiscal years --->
    <cfinvoke component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
            method="getFYs"
            returnvariable="qFY">
            <cfinvokeargument name="numFYs" value="3"/>
            <cfinvokeargument name="MaxFY" value="20#application.cfy#" />
    </cfinvoke>
<cfelse>
    <!--- Get Fiscal years --->
    <cfinvoke component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
            method="getFYs"
            returnvariable="qFY">
            <cfinvokeargument name="numFYs" value="3"/>
            <cfinvokeargument name="MaxFY" value="#variables.FY#"/>
    </cfinvoke>    

</cfif>
    

<!--- Get all Agency Names --->
<cfinvoke
        component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
        method="GetAgencyNames"
        returnVariable="qAN">
</cfinvoke>

<!--- Get all award descriptions --->
<cfinvoke
        component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
        method="GetAwardDescriptions"
        returnVariable="qAD">
</cfinvoke>

<!--- Get all Type Description --->
<cfinvoke
        component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
        method="GetAllTypeDescriptions"
        returnVariable="qATD">
</cfinvoke>

<!--- Get all class descriptions --->
<cfinvoke
        component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
        method="GetAllClassDescriptions"
        returnVariable="qCD">
</cfinvoke>

<!--- Get all Vendor Names --->
<cfinvoke
        component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
        method="GetAllVendorNames"
        returnVariable="qAVN">
</cfinvoke>

<CFIF IsDefined("cookie.StateContracts") AND ListLen(cookie.StateContracts) IS 6>
    <CFSET C1_FindVendor = TRIM(ListGetAt(cookie.StateContracts, 1))>
    <CFSET C1_contractFY = TRIM(ListGetAt(cookie.StateContracts, 2))>
    <CFSET C1_contractAgency = TRIM(ListGetAt(cookie.StateContracts, 3))>
    <CFSET C1_contractAward = TRIM(ListGetAt(cookie.StateContracts, 4))>
    <CFSET C1_contractType = TRIM(ListGetAt(cookie.StateContracts, 5))>
    <CFSET C1_contractClass = TRIM(ListGetAt(cookie.StateContracts, 6))>
    <CFIF C1_FindVendor IS "Default">
        <CFSET Variables.FindVendor = "">
    <cfelse>
        <CFSET Variables.FindVendor = C1_FindVendor>
    </CFIF>

    <CFSET FY = C1_contractFY>

        <cfinvoke component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
                method="GetFreindlyName_StateContracts"
                returnvariable="FN1">
        </cfinvoke>
</CFIF>


<!--- Set Pagination metrics  --->
<cfparam name="URL.PageIndex" default="0">
<cfif isDefined("GetContractInfo") && GetContractInfo.recordcount GT 5000>
    <CFSET RecordsPerPage = 10>
<cfelse>
    <CFSET RecordsPerPage = 30000>
</cfif>
<CFIF isDefined("GetContractInfo") AND GetContractInfo.recordcount LT RecordsPerPage>
    <CFSET URL.PageIndex = 0>
</cfif>

<cfoutput>
    <!-- START PAYMENT -->
    <div id="payment">
    <div class="container">
        #$.getSummary()#
        <div class="example alert alert-danger hidden" id="errorMsg"> Please Enter Search Criteria.</div>

    <cfform method="post" enctype="application/x-www-form-urlencoded" name="DisplayValue" preloader="no" id="searchform">

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Search by Vendor Name / Contract No.</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
                <input type="text" id="FindVendor" name="FindVendor" maxlength="32" value="#variables.FindVendor#"
                       class="form-control">
    </div>
    </div>

    <div class="row">
        <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
            <div class="btn-label">Fiscal Year</div>
        </div>

    <div class="col-xs-12 col-sm-7 col-md-5">
    <select id="contractFY" name="contractFY" class="select2">
        <option value="0">All Fiscal Years</option>
        <Cfloop index="i" list="#qFY#">
            <CFIF TRIM(FY) IS i>
                    <option value="#i#" selected="selected">Fiscal Year #i#</option>
            <cfelse>
                    <option value="#i#">Fiscal Year #i#</option>
            </CFIF>
        </Cfloop>
        </select>
        </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Agency</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select id="contractAgency" name="contractAgency" class="select2">
            <option value="0">All Agencies</option>
        <cfloop query="qAN">
                <option value="#qAN.AgencyName#"
                <cfif TRIM(variables.AgencyName) eq TRIM(qAN.AgencyName)> selected</cfif>>#qAN.AgencyName#</option>
        </cfloop>
        </select>
        </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Awards</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select id="contractAward" name="contractAward" class="select2">
            <option value="0">All Award Descriptions</option>
        <cfloop query="qAD">
                <option value="#qAD.AwardDescription#"
                <cfif TRIM(variables.AwardDescription) eq TRIM(qAD.AwardDescription)> selected </cfif>
                >#qAD.AwardDescription#</option>
        </cfloop>
        </select>
        </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Type Description</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select id="contractType" name="contractType" class="select2">
            <option value="0">All Type Descriptions</option>
        <cfloop query="qATD">
                <option value="#qATD.TypeDescription#"
                <cfif TRIM(variables.TypeDescription) eq TRIM(qATD.TypeDescription)> selected </cfif>
                >#qATD.TypeDescription#</option>
        </cfloop>
        </select>
        </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Class Description</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select id="contractClass" name="contractClass" class="select2">
            <option value="0">All Class Descriptions</option>
        <cfloop query="qCD">
                <option value="#qCD.ClassDescription#"
                <cfif TRIM(variables.ContractClass) eq TRIM(qCD.ClassDescription)> selected </cfif>
                >#qCD.ClassDescription#</option>
        </cfloop>
        </select>
        </div>
        </div>

        <div class="text-center">
        <cfinput type="submit" id="btnSearch" name="submitted" class="btn btn-success" value="Search">
        </div>

    </cfform>

    <cfif isDefined("GetContractInfo") && GetContractInfo.recordcount GT 5000>
<!--- new row for bulk download --->
            <div class="row">
            <div class="col-xs-12 col-sm-10 col-sm-offset-1">
            <cfset ExportFile = "SC_CFY_VendorName.csv">
                <div class="alert alert-info small">
                <span class="small"> <img src="/ledger/includes/themes/TheLedger/images/infoIcon.png"
                                          style="height:30px">&nbsp;Your search
                    returned #NumberFormat(GetContractInfo.recordcount, ",")#
                    records. The download and sort options are not available for results greater than 5,000 records.
                    Please narrow your search if you wish to use these features.</span></div>
<!--- <cftry>
   <div class="text-center" style="padding-bottom: 15px;"><cffile action = "read" variable="TestAgency" file = "\\ioc-webvm-cf1.iocweb.net\Downloads$\#ExportFile#">
   <a href="http://ledger.illinoiscomptroller.gov/downloads/#exportfile#" class="btn btn-success">
    Click Here to Download Current Fiscal Year Contracts</a></div>

   <cfcatch></cfcatch>
</cftry> --->
            </div>
            </div>
<!--- end new row for bulk download --->
    </cfif>
    </div>

    <div class="container" style="width: 100% !important;">
    <cfif isDefined("GetContractInfo")>
        <CFSET TotalPages = Ceiling((GetContractInfo.recordcount / RecordsPerPage) - 1)>
        <CFIF TotalPages IS 0>
            <CFSET TotalPages = 1>
        </CFIF>
        <CFSET StartRow = (URL.PageIndex * RecordsPerPage) + 1>
<!--- <CFSET StartRow = 0> --->
        <CFSET EndRow = StartRow + RecordsPerPage - 1>
            <div style="width: 98%; margin: 30px auto;display: block;">
<!--- <p class="RecordCountLabel">Records found: <B>#NUMBERFORMAT(GetContractInfo.recordcount)#</B> Total Pages: <B>#NUMBERFORMAT(TotalPages)#</B></p> --->
            <div class="result">

            <cfif isDefined("GetContractInfo") && GetContractInfo.recordcount GT 5000 || GetContractInfo.recordcount EQ 0>
                <table class="ManualTable table table-striped">
            <cfelse>
                <table class="ManualTable datatable-export table table-striped">
            </cfif>

            <thead>
            <tr>
            <th class="bg-info">
                    <a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractClass=#URLEncodedFormat(variables.contractClass)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&ContractVendor=#URLEncodedFormat(variables.ContractVendor)#&SortColumn=6&SortDirection=#variables.SortDirection#&header=true">
            Vendor</a></th>
        <th class="bg-info">
                <a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractClass=#URLEncodedFormat(variables.contractClass)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&ContractVendor=#URLEncodedFormat(variables.ContractVendor)#&SortColumn=1&SortDirection=#variables.SortDirection#&header=true">
            Agency</a></th>
        <th class="bg-info">
                <a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractClass=#URLEncodedFormat(variables.contractClass)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&ContractVendor=#URLEncodedFormat(variables.ContractVendor)#&SortColumn=2&SortDirection=#variables.SortDirection#&header=true">
            Contract Number</a></th>
        <th class="sum bg-info text-center">
                <a href="?PageIndex=1&contractFY=#variables.FY#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractClass=#URLEncodedFormat(variables.contractClass)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&ContractVendor=#URLEncodedFormat(variables.ContractVendor)#&SortColumn=10&SortDirection=#variables.SortDirection#&header=true">
            Current Contract Amount</a></th>

        <th class="bg-info text-center">
                <a href="?PageIndex=1&amp;contractFY=#variables.FY#&amp;contractAgency=#URLEncodedFormat(variables.AgencyName)#&amp;contractClass=#URLEncodedFormat(variables.contractClass)#&amp;contractType=#URLEncodedFormat(variables.TypeDescription)#&amp;contractAward=#URLEncodedFormat(variables.AwardDescription)#&amp;FindVendor=#URLEncodedFormat(variables.FindVendor)#&amp;ContractVendor=#URLEncodedFormat(variables.ContractVendor)#&amp;SortColumn=13&amp;SortDirection=#variables.SortDirection#&amp;header=true">
            Contract Transparency Document</a></th>
            <th class="bg-info no-sort"><a href="">Details</a></th>
            <th class="bg-info no-sort"><a href="">Payments</a></th>
        </tr>
        </thead>

        <tbody id="content">
            <cfloop query="GetContractInfo">
                <CFIF CurrentRow GTE StartRow>
                    <cfset TmpSubject = "FOIA%20Request%20for%20Contract Number%20" & #trim(Contract_Number)#>
                    <cfset TmpBody = "My%20name%20is%20[Replace%20this%20text%20with%20your%20First%20and%20Last%20Name]%20and%20I%20represent%20[Please%20replace%20this%20text%20with%20your%20employer%20if%20this%20request%20pertains%20to%20your%20job%20responsibilities;%20otherwise,%20just%20delete%20this%20text.].Pursuant%20to%20the%20Illinois%20Freedom%20of%20Information%20Act%20(5%20ILCS%20140/1%20et%20seq.),%20I%20respectfully%20request%20a%20copy%20of%20contract%20number%20" & #trim(Contract_Number)# & ",%20an%20agreement%20between%20" & #trim(Agency_Name)# & "%20and%20" & #trim(Name)# & ".%20%20I%20understand%20the%20Office%20of%20the%20Comptroller%20will%20not%20impose%20a%20fee%20for%20processing%20non-commercial%20requests%20but%20reserves%20its%20statutory%20right%20to%20impose%20such%20fees%20in%20the%20future.%20%20I%20further%20understand%20that%20a%20representative%20from%20the%20Office%20of%20the%20Comptroller%20will%20contact%20me%20at%20the%20e-mail%20address%20provided%20to%20establish%20a%20delivery%20method%20that%20best%20fits%20my%20needs.">
                    <tr>
                    <td>#trim(Name)#</td>
                <td>#trim(Agency_Name)#</td>
                <td><a href="mailto:#Sendto#?Subject=#TmpSubject#&Body=#TmpBody#">#trim(Contract_Number)#</a></td>
                <td class="text-right">#DollarFormat(Contract_Amt)#</td>

                <td class="text-center"><CFIF TRIM(getContractInfo.CTD_Document) IS NOT "">
                        <a title="Contract Transparency Document" href="/CTDDocs/#getContractInfo.CTD_Document#"
                           target="_blank">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <img src="/ledger/includes/themes/TheLedger/images/CTDicon.png">
                    </a><cfelse>NA</CFIF></td>
                <td>
                        <a
                        style="text-decoration: underline;" href="/financial-data/state-expenditures/contracts/contract-details?ID=#Contract_Number#&ID2=#GetContractInfo.Fiscal_Year#&ID3=#GetContractInfo.Agency#&ID4=#getContractInfo.CTD_Document#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractClass=#URLEncodedFormat(variables.contractClass)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&contractFY=#GetContractInfo.Fiscal_Year#&varClassCode=#GetContractInfo.Class_Code#&VName=#URLEncodedFormat(trim(GetContractInfo.Name))#">
                    Contract Details</a>
                </td>
                <td>
                        <a
                        style="text-decoration: underline;" href="/financial-data/state-expenditures/contracts/payment-details?ID=#Contract_Number#&ID2=#GetContractInfo.Fiscal_Year#&ID3=#GetContractInfo.Agency#&ID4=#getContractInfo.CTD_Document#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractClass=#URLEncodedFormat(variables.contractClass)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&contractFY=#GetContractInfo.Fiscal_Year#&varClassCode=#GetContractInfo.Class_Code#&VName=#URLEncodedFormat(trim(GetContractInfo.Name))#">
                    Payments</a></td>

                </tr>
                </cfif>
                <CFIF CurrentRow IS EndRow>
                    <cfbreak>
                </CFIF>
            </cfloop>
            </tbody>
            </table>
            <cfif isDefined("GetContractInfo") && GetContractInfo.recordcount GT 5000>
<!--- Page numbers  --->
                <div id="pg">
                <ul class="pagination">
                <CFSET MiddlePageNumberNextSwitch = false>
<!--- Display First Page link only if the page number being viewed is greater than 1 and there is more than 3 pages of records --->
                <CFIF VAL(URL.PageIndex) IS NOT 1 AND TotalPages GTE 3>
                        <li>
                                <a href="?PageIndex=0&contractFY=#variables.FY#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractClass=#URLEncodedFormat(variables.contractClass)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&ContractVendor=#URLEncodedFormat(variables.ContractVendor)#&SortColumn=#variables.SortColumn# &SortDirection=#variables.SortDirection#">
                        << First</a></li>
                </CFIF>
<!--- Display the middle 7 page numbers central around the page number being viewed--->
                <cfloop index="Pages" from="0" to="#TotalPages#">
                    <CFSET DisplayPgNo = Pages + 1>
                    <CFIF DisplayPgNo GTE (URL.PageIndex - 3) AND DisplayPgNo LTE (URL.PageIndex + 3)>
                        <CFIF URL.PageIndex IS pages>
                                <li>
                                        <a href="?PageIndex=#pages#&contractFY=#variables.FY#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractClass=#URLEncodedFormat(variables.contractClass)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&ContractVendor=#URLEncodedFormat(variables.ContractVendor)#&SortColumn=#variables.SortColumn#&SortDirection=#variables.SortDirection#">
                            <strong>#DisplayPgNo#</strong></a></li>
                        <cfelse>
                                <li>
                                        <a href="?PageIndex=#pages#&contractFY=#variables.FY#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractClass=#URLEncodedFormat(variables.contractClass)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&ContractVendor=#URLEncodedFormat(variables.ContractVendor)#&SortColumn=#variables.SortColumn#&SortDirection=#variables.SortDirection#">#DisplayPgNo#</a>
                            </li>
                        </CFIF>
                        <cfelseif MiddlePageNumberNextSwitch IS false AND DisplayPgNo GT (URL.PageIndex - 4) AND URL.PageIndex LT TotalPages>
<!--- Goto Next Page only --->
                            <li>
                                    <a href="?PageIndex=#pages + 1#&contractFY=#variables.FY#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractClass=#URLEncodedFormat(variables.contractClass)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&ContractVendor=#URLEncodedFormat(variables.ContractVendor)#&SortColumn=#variables.SortColumn#&SortDirection=#variables.SortDirection#">
                            Next</a></li>
                        <CFSET MiddlePageNumberNextSwitch = true>
                    </CFIF>
                </cfloop>

<!--- Last Page  --->
                <CFIF URL.PageIndex IS NOT TotalPages AND TotalPages GTE 3>
                        <li>
                                <a href="?PageIndex=#TotalPages#&contractFY=#variables.FY#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractClass=#URLEncodedFormat(variables.contractClass)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&ContractVendor=#URLEncodedFormat(variables.ContractVendor)#&SortColumn=#variables.SortColumn#&SortDirection=#variables.SortDirection#">
                        Last >> [#TotalPages#]</a></li>
                </CFIF>
                </ul>
                </div>
                </table>
            </cfif>

            </div>
            </div>

        <CFIF (IsDefined("Error") AND Error IS 1) OR (GetContractInfo.recordcount EQ 0)>
<!--- Display Query Input error  --->
                <div align="center">
                    <h4>No records found. Please use different search criteria.</h4>
                </div>
        </CFIF>
    </cfif>
    </div>

    <div class="container">
<!--- Display Last search results if cookie exists --->
    <CFIF Not IsDefined("results") AND IsDefined("cookie.StateContracts") AND ListLen(cookie.StateContracts) IS 6>
            <a href="?contractFY=#variables.FY#&contractAgency=#URLEncodedFormat(variables.AgencyName)#&contractClass=#URLEncodedFormat(variables.contractClass)#&contractType=#URLEncodedFormat(variables.TypeDescription)#&contractAward=#URLEncodedFormat(variables.AwardDescription)#&FindVendor=#URLEncodedFormat(variables.FindVendor)#&ContractVendor=#URLEncodedFormat(variables.ContractVendor)#">
        <div class="lastsearch">
            <h2>Last Search</h2>
        <ul>
            <CFIF C1_FindVendor IS NOT "Default" AND TRIM(C1_FindVendor) IS NOT 0>
                    <li>Vendor Name / Contract Number: #FN1.val1#</li>
            </CFIF>
            <CFIF C1_ContractFY IS NOT "Default" AND TRIM(C1_ContractFY) IS NOT "">
                    <li>Fiscal Year:
                    <CFIF FN1.Val2 IS 0>
                            ALL
                    <cfelse>
                        #FN1.val2#
                    </CFIF>
                    </li>
            </cfif>
            <CFIF C1_ContractAgency IS NOT "Default" AND TRIM(C1_ContractAgency) IS NOT 0>
                    <li>Agency: #FN1.val3#</li>
            </CFIF>
            <CFIF C1_ContractAward IS NOT "Default" AND TRIM(C1_ContractAward) IS NOT 0>
                    <li>Award: #FN1.val4#</li>
            </CFIF>
            <CFIF C1_ContractType IS NOT "Default" AND TRIM(C1_ContractType) IS NOT 0>
                    <li>Type: #FN1.val5#</li>
            </CFIF>
            <CFIF C1_ContractClass IS NOT "Default" AND TRIM(C1_ContractClass) IS NOT 0>
                    <li>Class: #FN1.val6#</li>
            </CFIF>
            </ul>
            </div>
            </a>
    </CFIF>

    <cfif isDefined("exportfile")>
            <div class="text-center">
            <cftry>
                    <div class="text-center" style="padding-bottom: 15px;">
                            <a href="http://ledger.illinoiscomptroller.gov/downloads/#exportfile#"
                        class="btn btn-success" role="button" style="margin-bottom:10px;">Click here to Download Current Fiscal Year Contracts</a>
                </div>
                <cfcatch type="any"></cfcatch>
            </cftry>
            </div>
    </cfif>
    </div>

    </div> <!--- end payment --->


</cfoutput>


<script>
    $(document).ready(function () {

        $("#btnSearch").click(function (event) {

            //if($("#FindVendor").val() === "")
            if ($("#FindVendor").val() === "" && $("#contractAgency").val() === "0" && $("#contractAward").val() === "0" && $("#contractType").val() === "0" && $("#contractClass").val() === "0") {
                $("#errorMsg").toggleClass('hidden show');
                event.preventDefault();
            }
            else {
                $("#errorMsg").toggle();
                $('#DisplayValue').submit();
            }
        });

    });
</script>