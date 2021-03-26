<!--- <cfoutput>Hello</cfoutput>
<cfabort> --->

<cfparam name="form.captcha" default="">
<cfparam name="form.captchaAnswer" default="">
<cfparam name="form.VendTIN" default="">
<cfparam name="Error" default="">

<cfparam name="variables.FY" default="">
<cfparam name="variables.TIN" default="">
<cfparam name="variables.VendTINName" default="">

<cfset ErrorStruct = StructNew()>
<cfset Error = "">
<cfset ErrorNo = "">

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">
<style>
    .result .active {
      border: none;
    }
    .bs-example{
        margin: 20px;        
    }
    @media print {
      #myFooter{
        display: none;
      }
      .screen {
        display: none;
      }
	  .mura-object-content {
		display: none;
	  }
	  #pdfreport {
		display: none;
	  }
    }
    table tr td{
      padding: 10Px;
    }    
    .bstyle{
       border-top: 1px solid #dddddd; 
       border-left: 1px solid #dddddd;
    }
    .lstyle{
      border-left: 1px solid #dddddd;
    }
    .tstyle{
      border-top: 1px solid #dddddd;
    }
     .bdstyle{
       border-top: 1px dashed #dddddd; 
       border-left: 1px solid #dddddd;
    }     
</style>

<cfif isdefined("form.Mode") AND (form.Mode is "Login")>
    <!--- <cfdump var="#form#"><br/> --->
        <!--- Must have supplied part of a Vendor Name --->
        <cfif trim(form.VendTINName) is "">
          <cfset ErrorNo = ListAppend(ErrorNo, "02A")>
          <cfif Error EQ "">
            <cfset Error = "Please enter Business Name or your Last and First Name (Last, First).">
          <cfelse>
            <cfset Error = Error & "<br/>" & "Please enter Business Name or your Last and First Name (Last, First).">
          </cfif>
        </cfif>    
    <!--- Must have supplied part of a TIN --->
    <cfif trim(form.VendTIN) is "">
            <cfif len(form.VendTIN) neq "9">
              <cfset ErrorNo = ListAppend(ErrorNo, "01A")>
            <cfelse>
              <cfset ErrorNo = ListAppend(ErrorNo, "01B")>
            </cfif>      
        <cfif Error EQ "">
          <cfset Error = "Please enter TIN number.">
        <cfelse>
          <cfset Error = Error & "<br/>" & "Please enter TIN number.">
        </cfif>
    </cfif>

    <!--- captcha Check --->
    <cfif not isdefined("form.Captcha")>
      <cfset ErrorNo = ListAppend(ErrorNo, "07A")>
        <cfif Error EQ "">
          <cfset Error = "Please select CAPTCHA.">
        <cfelse>
          <cfset ErrorNo = ListAppend(ErrorNo, "07B")>
          <cfset Error = Error & "<br/>" & "Please select CAPTCHA.">
        </cfif>      
    <cfelseif form.Captcha is not hash(form.captchaAnswer)>
        <cfif Error EQ "">
          <cfset Error = "Please select valid CAPTCHA.">
        <cfelse>
          <cfset Error = Error & "<br/>" & "Please select valid CAPTCHA.">
        </cfif>        
    </cfif>
    <cfif trim(ERROR) EQ "">
      <cfset variables.TIN = form.VendTIN>
      <cfset variables.VendTINName = form.VendTINName>
      <cfif IsDefined("form.FY") AND form.FY NEQ ''>
        <cfset variables.FY = form.FY>
      </cfif> 

       <cfquery name="qryMisc" datasource="TSPData">
          SELECT ROW_NUMBER() OVER (ORDER BY CONVERT(DATE,RecordCreatedDate)) AS RowNumber
              ,[TINNumber]
              ,[RecipientName1]
              ,[RecipientName2]
              ,[RecipientAddress]
              ,[RecipientCity]
              ,[RecipientState]
              ,[Filler1]
              ,[RecipientZip1-5] AS Zip1
              ,[RecipientZip6-10] AS Zip2
              ,[ForeignIndicator]
              ,CAST(CAST([Rents] as numeric(14,2))/100 as numeric(14,2)) As [Rents]
              ,CAST(CAST([Royalties] as numeric(14,2))/100 as numeric(14,2)) As [Royalties]
              ,CAST(CAST([PrizeAwards] as numeric(14,2))/100 as numeric(14,2)) As [PrizeAwards]
              ,CAST(CAST([FederalWithholding] as numeric(14,2))/100 as numeric(14,2)) As [FederalWithholding]
              ,CAST(CAST([FishingProceeds] as numeric(14,2))/100 as numeric(14,2)) As [FishingProceeds]
              ,CAST(CAST([Medical] as numeric(14,2))/100 as numeric(14,2)) As [Medical]
              ,CAST(CAST([NEC] as numeric(14,2))/100 as numeric(14,2)) As [NEC]
              ,CAST(CAST([SubstitutePayments] as numeric(14,2))/100 as numeric(14,2)) As [SubstitutePayments]
              ,[DirectSales] AS DirectSales
              ,CAST(CAST([CropProceeds] as numeric(14,2))/100 as numeric(14,2)) As [CropProceeds]
              ,CAST(CAST([StateWithholding] as numeric(14,2))/100 as numeric(14,2)) As [StateWithholding] 
              ,[FormSequenceNumber]
              ,[CorrectionIndicator]
              ,[SecondTinNotification]
              ,[DuplicateMessage]
              ,[ReportingYear]
              ,[Filler2]
              ,CONVERT(DATE,RecordCreatedDate) As RecDate
          FROM [dbo].[1099MISC]
          WHERE [TINNumber] = <cfqueryparam cfsqltype="CF_SQL_CHAR" maxlength="255" value="#form.VendTIN#">  
          AND ReportingYear = <cfqueryparam cfsqltype="CF_SQL_CHAR" maxlength="4" value="#form.FY#"> 
          AND ([RecipientName1] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255"> 
          OR [RecipientName2] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255"> 
          OR [RecipientName1] + ', ' + [RecipientName2] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255">)
          Order BY CONVERT(DATE,RecordCreatedDate) ASC
       </cfquery>

       <cfquery name="qryINT" datasource="TSPData">
          SELECT ROW_NUMBER() OVER (ORDER BY CONVERT(DATE,RecordCreatedDate)) AS RowNumber
              ,[TINNumber]
              ,[RecipientName1]
              ,[RecipientName2]
              ,[RecipientAddress]
              ,[RecipientCity]
              ,[RecipientState]
              ,[Filler1]
              ,[RecipientZip1-5] AS Zip1
              ,[RecipientZip6-10] AS Zip2
              ,[ForeignIndicator]
              ,CAST(CAST([InterestIncome] as numeric(14,2))/100 as numeric(14,2)) As [InterestIncome]
              ,CAST(CAST([WithdrawalPenalty] as numeric(14,2))/100 as numeric(14,2)) As [WithdrawalPenalty]
              ,CAST(CAST([Bond-TreasInterest] as numeric(14,2))/100 as numeric(14,2)) As [BondTreasInterest]
              ,CAST(CAST([FederalWithholding] as numeric(14,2))/100 as numeric(14,2)) As [FederalWithholding]
              ,CAST(CAST([ForeignTaxPaid] as numeric(14,2))/100 as numeric(14,2)) As [ForeignTaxPaid]
              ,[ForeignCountry]
              ,[FormSequenceNumber]
              ,[CorrectionIndicator]
              ,[SecondTinNotification]
              ,[DuplicateMessage]
              ,[ReportingYear]
              ,[Filler2]
              ,CONVERT(DATE,RecordCreatedDate) As RecDate
          FROM [dbo].[1099INT]
          WHERE [TINNumber] = <cfqueryparam cfsqltype="CF_SQL_CHAR" maxlength="255" value="#form.VendTIN#">
          AND ReportingYear = <cfqueryparam cfsqltype="CF_SQL_CHAR" maxlength="4" value="#form.FY#"> 
          AND ([RecipientName1] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255"> 
          OR [RecipientName2] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255"> 
          OR [RecipientName1] + ', ' + [RecipientName2] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255">)                     
          Order BY CONVERT(DATE,RecordCreatedDate) ASC
       </cfquery> 


       <cfquery name="qryNEC" datasource="TSPData">
          SELECT ROW_NUMBER() OVER (ORDER BY CONVERT(DATE,RecordCreatedDate)) AS RowNumber
              ,[TINNumber]
              ,[RecipientName1]
              ,[RecipientName2]
              ,[RecipientAddress]
              ,[RecipientCity]
              ,[RecipientState]
              ,[Filler1]
              ,[RecipientZip1-5] AS Zip1
              ,[RecipientZip6-10] AS Zip2
              ,[ForeignIndicator]
              ,CAST(CAST([Rents] as numeric(14,2))/100 as numeric(14,2)) As [Rents]
              ,CAST(CAST([Royalties] as numeric(14,2))/100 as numeric(14,2)) As [Royalties]
              ,CAST(CAST([PrizeAwards] as numeric(14,2))/100 as numeric(14,2)) As [PrizeAwards]
              ,CAST(CAST([FederalWithholding] as numeric(14,2))/100 as numeric(14,2)) As [FederalWithholding]
              ,CAST(CAST([FishingProceeds] as numeric(14,2))/100 as numeric(14,2)) As [FishingProceeds]
              ,CAST(CAST([Medical] as numeric(14,2))/100 as numeric(14,2)) As [Medical]
              ,CAST(CAST([NEC] as numeric(14,2))/100 as numeric(14,2)) As [NEC]
              ,CAST(CAST([SubstitutePayments] as numeric(14,2))/100 as numeric(14,2)) As [SubstitutePayments]
              ,[DirectSales] AS DirectSales
              ,CAST(CAST([CropProceeds] as numeric(14,2))/100 as numeric(14,2)) As [CropProceeds]
              ,CAST(CAST([StateWithholding] as numeric(14,2))/100 as numeric(14,2)) As [StateWithholding] 
              ,[FormSequenceNumber]
              ,[CorrectionIndicator]
              ,[SecondTinNotification]
              ,[DuplicateMessage]
              ,[ReportingYear]
              ,[Filler2]
              ,CONVERT(DATE,RecordCreatedDate) As RecDate
          FROM [dbo].[1099NEC]
          WHERE [TINNumber] = <cfqueryparam cfsqltype="CF_SQL_CHAR" maxlength="255" value="#form.VendTIN#"> 
          AND ReportingYear = <cfqueryparam cfsqltype="CF_SQL_CHAR" maxlength="4" value="#form.FY#"> 
          AND ([RecipientName1] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255"> 
          OR [RecipientName2] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255"> 
          OR [RecipientName1] + ', ' + [RecipientName2] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255">)                     
          Order BY CONVERT(DATE,RecordCreatedDate) ASC
       </cfquery> 

       <cfquery name="qryFormG" datasource="TSPData">
          SELECT ROW_NUMBER() OVER (ORDER BY CONVERT(DATE,RecordCreatedDate)) AS RowNumber
              ,[TINNumber]
              ,[RecipientName1]
              ,[RecipientName2]
              ,[RecipientAddress]
              ,[RecipientCity]
              ,[RecipientState]
              ,[Filler1]
              ,[RecipientZip1-5] AS Zip1
              ,[RecipientZip6-10] AS Zip2
              ,[ForeignIndicator]
              ,CAST(CAST([UnemploymentComp] as numeric(14,2))/100 as numeric(14,2)) As [UnemploymentComp]
              ,CAST(CAST([StateLocalTaxRefund] as numeric(14,2))/100 as numeric(14,2)) As [StateLocalTaxRefund]
              ,[RefundTaxYear] AS RefundTaxYear
              ,CAST(CAST([FederalWithholding ] as numeric(14,2))/100 as numeric(14,2)) As [FederalWithholding]
              ,[Filler2]
              ,CAST(CAST([TaxableGrants] as numeric(14,2))/100 as numeric(14,2)) As [TaxableGrants]
              ,CAST(CAST([AgriculturPayments] as numeric(14,2))/100 as numeric(14,2)) As [AgriculturPayments]
              ,[Box2AmtIndicator]
              ,[FormSequenceNumber]
              ,[CorrectionIndicator]
              ,[SecondTinNotification]
              ,[DuplicateMessage]
              ,[ReportingYear]
              ,[Filler3]
              ,CONVERT(DATE,RecordCreatedDate) As RecDate
          FROM [dbo].[1099G]
          WHERE [TINNumber] = <cfqueryparam cfsqltype="CF_SQL_CHAR" maxlength="255" value="#form.VendTIN#">
          AND ReportingYear = <cfqueryparam cfsqltype="CF_SQL_CHAR" maxlength="4" value="#form.FY#">   
          AND ([RecipientName1] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255"> 
          OR [RecipientName2] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255"> 
          OR [RecipientName1] + ', ' + [RecipientName2] LIKE <cfqueryparam value="#form.VENDTINNAME#%" cfsqltype="CF_SQL_VARCHAR" maxlength="255">)                   
          Order BY CONVERT(DATE,RecordCreatedDate) ASC
       </cfquery>
    </cfif>


</CFIF>

<cfset ListSorted = "">
<cfStoredProc datasource="VendorPayment" Procedure="Get_ListofGlyphiconCatcha">
    <cfprocparam type="Out"  cfsqltype="cf_sql_varchar" dbvarname="@ListofGlyphicons" variable="ListofGlyphicons">
    <cfprocparam type="Out"  cfsqltype="cf_sql_varchar" dbvarname="@TargetGlyphicons" variable="TargetGlyphicons">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetListofGlyphiconCatchaRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListofGlyphiconCatchaRetMsg">
    <cfprocresult name="GetListofGlyphiconCatcha">
</cfstoredproc>

<cfquery name="qfy" datasource="TSPData">
  SELECT DISTINCT [ReportingYear] FROM [dbo].[1099MISC]
</cfquery>
<div class="container screen">
  <div class="home-panel panel panel-default">
  <div class="panel-heading text-center"><h4 class="text-uppercase">Search Form</h4></div>
  <div class="panel-body">
    <p class="home-form-property-desc">
    This page allows State of Illinois vendors to view and print copies of 1099 Forms issued by the State of Illinois Comptroller's Office.  The following forms are available: 1099-MISC, 1099-NEC, 1099-INT, and 1099-G.  Please provide your Taxpayer Identification Number (TIN) and either the Business Name or your Last and First Name (Last, First) to display your forms.  All forms issued to the TIN provided will be displayed.  If you have questions, please contact our Vendor Unit at 217/785-4422.</p>

    <cfset ListSorted = "#ListSort("#ListofGlyphicons#","numeric","asc")#">

    <CFIF isDefined("NotFound")>
      <div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
        <b>Sorry, but no vendors were found for that TIN / Vendor Name combination.</B>  Please verify the TIN and try again.
      </div>

    <cfelseif trim(ERROR) is not "">
      <div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
        <b><u>Issue(s) with Form Submission</u></b><br/>
        <cfoutput>#Error#</cfoutput>
            </div>

    <cfelseif isdefined("url.Unsubscribe")>
      <div class="alert alert-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
        <b>You have been unsubscribed!</b>
      </div>
    </cfif>

                <cfform id="VendorForm" role="form" class="form-horizontal" name="Vendor" action="/taxforms/vendor-1099-forms/" method="post">
                  <cfoutput>
                  <INPUT TYPE="hidden" NAME="Mode" VALUE="Login">

                  <div class="form-group row">
                      <div class="col-sm-5 col-md-4">
                         <label for="inputFY" class="control-label">Calendar Year</label>
                      </div>
                      <div class="col-sm-7 col-md-8" <cfif listfind(Error,"02A")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                        <cfselect enabled="No" id="FY" name="FY" class="form-control" multiple="no">
                         <Cfloop query="qfy">
                                <CFIF variables.FY IS qfy.ReportingYear>
                                 <cfoutput> <option value="#qfy.ReportingYear#" selected="selected">#qfy.ReportingYear#</option> </cfoutput>
                                <cfelse>
                                 <cfoutput> <option value="#qfy.ReportingYear#">#qfy.ReportingYear#</option> </cfoutput>
                               </CFIF>
                         </Cfloop>
                        </cfselect>
                      </div>

                  </div>

                  <div class="form-group row">
                      <div class="col-sm-5 col-md-4">
                          <label for="inputPassword3" class="control-label">TIN:</label>
                      </div>
                      <div class="col-sm-7 col-md-8">
                          <div <cfif listfind(ErrorNo,"01A") or listfind(ErrorNo,"01B")>class="has-error"<cfelse>class=""</cfif>>
                              <input placeholder="999999999" name="VendTIN" autocomplete="off" id="VendTIN2" class="form-control text-input" tabindex="1" data-original-title="" title="" type="password" style="display: inline-block;" <!--- <cfif trim(variables.TIN) is not "">value="#variables.TIN#"</cfif> ---> >
                              &nbsp;<input id="toggle" onchange="togglePassword(this,document.getElementById('VendTIN2'),document.getElementById('toggleTextPwd'));" type="checkbox" value="0" style="vertical-align: middle;" /><span id="toggleTextPwd" style="display: inline-block;margin: 5px 0 0 5px;vertical-align: middle;
    font-size: 12px;">Show</span>
                          </div>
                      </div>
                  </div>
                  <div class="form-group row">
                      <div class="col-sm-5 col-md-4">
                          <label for="Vendor_TIN_Name" id="Vendor_TIN_Namelbl" class="control-label">Business Name or your Last and First Name (Last, First): </label>
                      </div>
                      <div class="col-sm-7 col-md-8">
                        <div <cfif listfind(ErrorNo,"02A")>class="input-group has-error"<cfelse>class="input-group"</cfif>>
                              <input <cfif not listfind(ErrorNo,"02A")>id="VendorTINName"<cfelse>id="VendorTINNameRed"</cfif> name="VendTINName" autocomplete="off" class="form-control text-input" tabindex="2" data-original-title="" <!--- <cfif trim(variables.VendTINName) is not "">value="#variables.VendTINName#"</cfif> ---> title="" type="text">
                        </div>
                      </div>

                  </div>                 



                  <div class="text-center">
                   <cfStoredProc datasource="VendorPayment" Procedure="Get_GlyphiconsByNumber">
                          <cfprocparam type="In"  cfsqltype="cf_sql_integer" dbvarname="@GlyphiconNumber" value="#TargetGlyphicons#">
                          <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetGlyphiconsByNumberRetVal">
                          <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetGlyphiconsByNumberRetMsg">
                          <cfprocresult name="GetGlyphiconsByNumber">
                      </cfstoredproc>
                      Security Verification!: Select the <b>#GetGlyphiconsByNumber.GlyphiconsDescription#</b> . <a href="/vendors/enhanced-vendor-remittance1/captcha-help/" target="_new"><b>(What is this?)</b></a>
                  </div>

                    <cfset TmpCaptcha="#GetGlyphiconsByNumber.GlyphiconsDescription#">
                    <input type="hidden" name="CaptchaAnswer" value="#GetGlyphiconsByNumber.GlyphiconsDescription#">
                    <cfset CaptchaNo=1>
                    <cfset tbIndex=4>
                    <div <cfif listfind(ErrorNo,"01A") or listfind(ErrorNo,"01B") or listfind(ErrorNo,"02A") or listfind(ErrorNo,"03A") or listfind(ErrorNo,"03B") or listfind(ErrorNo,"04A") or listfind(ErrorNo,"05A") or listfind(ErrorNo,"05B") or listfind(ErrorNo,"06A") or listfind(ErrorNo,"06B") or listfind(ErrorNo,"07A") or listfind(ErrorNo,"07B")>class="input-group has-error margintop10"<cfelse>class="input-group margintop10"</cfif>>
                      <cfloop index="i" list="#ListSorted#">
                        <cfStoredProc datasource="VendorPayment" Procedure="Get_GlyphiconsByNumber">
                            <cfprocparam type="In"  cfsqltype="cf_sql_integer" dbvarname="@GlyphiconNumber" value="#i#">
                            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetGlyphiconsByNumberRetVal">
                            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetGlyphiconsByNumberRetMsg">
                            <cfprocresult name="GetGlyphiconsByNumber">
                        </cfstoredproc>

                       <span class="input-group-addon pull-center text-center"><input type="radio" tabindex="#tbIndex#"  name="Captcha" id="AddCaptcha#CaptchaNo#" value="#Hash(trim(GetGlyphiconsByNumber.GlyphiconsDescription))#">&nbsp;<i class="#GetGlyphiconsByNumber.GlyphiconsName#"></i></span><cfset CaptchaNo=CaptchaNo+1>
                       <cfset tbIndex=tbIndex + 1>
                      </cfloop>
                    </div>
                    <!-- TAGS INPUT -->

                <div class="text-center">
                  <button name="Login" class="btn btn-label btn-sm btn-login" id="Submitbtn2" tabindex="8" data-original-title="" title="">Submit</button>
                </div>

             </cfoutput>

            </cfform>
    </div>
    </div>
</div>

    <div class="margintop container" style="width: 100% !important;">
      <cfif isdefined("form.Mode") AND (form.Mode is "Login") AND ERROR EQ "">
            <ul class="nav nav-tabs screen" role="tablist">   
              <cfif IsDefined("qryMisc") AND qryMisc.RecordCount NEQ "0">
                <li class="active">
                    <a href="#misc" role="tab" data-toggle="tab">
                        1099-MISC Form Data
                    </a>
                </li>
                </cfif>
                <cfif IsDefined("qryINT") AND qryINT.RecordCount NEQ "0">
                  <li><a href="#int" role="tab" data-toggle="tab">
                         1099-INT FORM Data
                      </a>
                  </li>
                </cfif>
                <cfif IsDefined("qryNEC") AND qryNEC.RecordCount NEQ "0">
                  <li><a href="#nec" role="tab" data-toggle="tab">
                         1099-NEC FORM Data
                      </a>
                  </li>
                </cfif>
                <cfif IsDefined("qryFormG") AND qryFormG.RecordCount NEQ "0">
                  <li><a href="#formg" role="tab" data-toggle="tab">
                         1099-G FORM Data
                      </a>
                  </li>
                </cfif>                            
            </ul>
          </cfif>

      <div class="result">

          <!-- Tab panes -->
          <cfif isdefined("form.Mode") AND (form.Mode is "Login") AND ERROR EQ "">
            <div class="tab-content">
              <div class="tab-pane fade active in" id="misc">
                <cfif IsDefined("qryMisc") AND qryMisc.RecordCount NEQ 0>
                  <!--- <cfdump var="#CorrectionQry#"><br/>  --->
                    <cfoutput>
                      <cfsavecontent variable="reportdata">
                        <div class="alert alert-info screen margintop">
                          1099-MISC Form #qryMisc.RowNumber# - #qryMisc.RecDate# - #qryMisc.ReportingYear#
                        </div>
                        <cfif qryMisc.ReportingYear EQ "2019">
                          <table class="tableX" cellpadding="0" cellspacing="0">
                            <tr>
                              <td colspan="8" align="center"><input type="checkbox" <cfif Rtrim(Ltrim(qryMisc.CorrectionIndicator)) NEQ ""> checked</cfif> id="corrected" disabled="true" name="corrected" value="corrected">
                              CORRECTED (if checked)
                             </td>
                            </tr>
                            <tr>
                              <td colspan="4" class="bstyle">PAYER'S name, street address, city or town, state or province, country, ZIP or foreign postal code, and telephone no.</td>
                              <td class="bstyle">1 Rents <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.RENTS,",9.99")# </b></p></td>
                              <td class="tstyle lstyle">OMB No. 1545-0115 </td>
                              <td colspan="2" class="bstyle"><b>Miscellaneous<br/>Income</b></td>
                            </tr>         
                            <tr>
                              <td colspan="4" class="lstyle"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>STATE OF ILLINOIS 69-0330001 37-6002057 <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPTROLLER - WITHHOLDING AGENT <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;325 WEST ADAMS STREET <br/></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>SPRINGFIELD, ILLINOIS 62704-1871</b><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>(217) 785-4422</b></td>
                              <td class="bstyle">2 Royalties <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.Royalties,",9.99")# </b></p></td>
                              <td class="lstyle"><b><p align="Center"> #variables.FY# </p></b> <br/>Form <b>1099-MISC</b></td>
                              <td colspan="2" class="bstyle"></td>
                            </tr>         
                            <tr>
                              <td colspan="4" class="lstyle"></td>
                              <td class="bstyle lstyle">3 Other income<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.PrizeAwards,",9.99")# </b></p></td>
                              <td colspan="2" class="bstyle">4 Federal income tax withheld<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.FederalWithholding,",9.99")# </b></p></td>
                              <td class="bstyle"><b>Copy B<br/>For Recipient</b></td>
                            </tr>         
                            <tr>
                              <td class="bstyle">PAYER'S TIN<br>&nbsp;&nbsp;&nbsp;&nbsp;<b>37-6002057<b></td>
                              <td colspan="3" class="bstyle">RECIPIENT'S TIN <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*****#right(qryMisc.TINNumber,4)#</b></td>
                              <td class="bstyle">5 Fishing boat proceeds<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> 0.00 </b></p></td>
                              <td colspan="2" class="bstyle">6 Medical and health care payments<br><br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.Medical,",9.99")# </b></p></td>
                              <td class="bstyle"></td>
                            </tr>        
                            <tr>
                              <td colspan="4" class="bstyle">RECIPIENT'S name <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>#qryMisc.RecipientName1# </b></td>
                              <td class="bstyle">7 Nonemployee compensation<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.NEC,",9.99")# </b></p></td>
                              <td colspan="2" class="bstyle">8 Substitute payments in lieu of dividends or interest<br><br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.SubstitutePayments,",9.99")# </b></p></td>
                              <td class="bstyle">This is important tax information and is being furnished to the IRS. If you are required to file a return, a negligence penalty or other sanction may be imposed on you if this income is taxable and the IRS determines that it has not been reported.</td>
                            </tr>        
                            <tr>
                              <td colspan="4" class="bstyle">Street address (including apt. no.) <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                              <td class="bstyle">9 Payer made direct sales of $5,000 or more of consumer products to a buyer (recipient) for resale <br/><input type="checkbox" <cfif Rtrim(Ltrim(qryMisc.DirectSales)) NEQ ""> checked</cfif> disabled="true" id="directsales" name="directsales" value="directsales"></td>
                              <td colspan="2" class="bstyle">10 Crop insurance proceeds<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.CropProceeds,",9.99")# </b></p></td>
                              <td class="bstyle"></td>
                            </tr>               
                            <tr>
                              <td colspan="4" class="bstyle">City or town, state or province, country, and ZIP or foreign postal code <br/> </td>
                              <td class="bstyle">11</td>
                              <td colspan="2" class="bstyle">12</td>
                              <td class="bstyle"></td>
                            </tr>        
                            <tr>
                              <td colspan="2" class="bstyle">Account number (see instructions)</td>
                              <td class="bstyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FATCA filing requirement &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" disabled="true" id="FATCAfilingRequirements" name="FATCAfilingRequirements" disabled="true" value="FATCAfilingRequirements"></td>
                              <td class="bstyle"></td>
                              <td class="bstyle">13 Excess golden parachute payments<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b>0.00</b></p></td>
                              <td colspan="2" class="bstyle">14 Gross proceeds paid to an attorney<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b>#numberFormat(qryMisc.FishingProceeds,",9.99")#</b></p></td>
                              <td class="bstyle"></td>
                            </tr>         
                            <tr>
                              <td class="bstyle">15a Section 409A deferrals</td>
                              <td colspan="3" class="bstyle">15b Section 409A income</td>
                              <td class="bstyle">16 State tax withheld</td>
                              <td colspan="2" class="bstyle">17 State/Payer's state no.<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;37-600 2057</b></td>
                              <td class="bstyle">18 State income </td>
                            </tr>         
                            <tr>
                              <td class="lstyle"></td>
                              <td colspan="3" class="lstyle"></td>
                              <td class="bdstyle lstyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.StateWithholding,",9.99")# </b></p></td>
                              <td colspan="2" class="bdstyle"></td>
                              <td class="bdstyle"></td>
                            </tr>         
                            <tr>
                              <td class="tstyle" colspan="4">Form &nbsp;&nbsp;&nbsp;&nbsp;<b>1099-MISC</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(keep for your records)</td>
                              <td class="tstyle">www.irs.gov/form1099misc</td>
                              <td colspan="3" class="tstyle">Department of the Treasury - Internal Revenue Service</td>
                            </tr>  
                          </table>
                        <cfelseif qryMisc.ReportingYear EQ "2020">
                           <table class="tableX" cellpadding="0" cellspacing="0">
                              <tr>
                                <td colspan="8" align="center"><input type="checkbox" <cfif Rtrim(Ltrim(qryMisc.CorrectionIndicator)) NEQ ""> checked</cfif> id="corrected" disabled="true" name="corrected" value="corrected">
                                CORRECTED (if checked)
                               </td>
                              </tr>
                              <tr>
                                <td colspan="4" class="bstyle">PAYER'S name, street address, city or town, state or province, country, ZIP or foreign postal code, and telephone no.</td>
                                <td class="bstyle">1 Rents <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.RENTS,",9.99")# </b></p></td>
                                <td class="tstyle lstyle">OMB No. 1545-0115 </td>
                                <td colspan="2" class="bstyle"><b>Miscellaneous<br/>Income</b></td>
                              </tr>         
                              <tr>
                                <td colspan="4" class="lstyle"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>STATE OF ILLINOIS 69-0330001 37-6002057 <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPTROLLER - WITHHOLDING AGENT <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;325 WEST ADAMS STREET <br/></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>SPRINGFIELD, ILLINOIS 62704-1871</b><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>(217) 785-4422</b></td>
                                <td class="bstyle">2 Royalties <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.Royalties,",9.99")# </b></p></td>
                                <td class="lstyle"><b><p align="Center"> #variables.FY# </p></b> <br/>Form <b>1099-MISC</b></td>
                                <td colspan="2" class="bstyle"></td>
                              </tr>         
                              <tr>
                                <td colspan="4" class="lstyle"></td>
                                <td class="bstyle lstyle">3 Other income<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.PrizeAwards,",9.99")# </b></p></td>
                                <td colspan="2" class="bstyle">4 Federal income tax withheld<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.FederalWithholding,",9.99")# </b></p></td>
                                <td class="bstyle"><b>Copy B<br/>For Recipient</b></td>
                              </tr>         
                              <tr>
                                <td class="bstyle">PAYER'S TIN<br>&nbsp;&nbsp;&nbsp;&nbsp;<b>37-6002057<b></td>
                                <td colspan="3" class="bstyle">RECIPIENT'S TIN <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*****#right(qryMisc.TINNumber,4)#</b></td>
                                <td class="bstyle">5 Fishing boat proceeds<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> 0.00 </b></p></td>
                                <td colspan="2" class="bstyle">6 Medical and health care payments<br><br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.Medical,",9.99")# </b></p></td>
                                <td class="bstyle"></td>
                              </tr>        
                              <tr>
                                <td colspan="4" class="bstyle">RECIPIENT'S name <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>#qryMisc.RecipientName1# </b></td>
                                <td class="bstyle"> 7 Payer made direct sales of $5,000 or more of consumer products to a buyer (recipient) for resale <input type="checkbox" <cfif Rtrim(Ltrim(qryMisc.DirectSales)) NEQ ""> checked</cfif> disabled="true" id="payermadedirectsales" name="payermadedirectsales" value="payermadedirectsales"></td>
                                <td colspan="2" class="bstyle">8 Substitute payments in lieu of dividends or interest<br><br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.SubstitutePayments,",9.99")# </b></p></td>
                                <td class="bstyle">This is important tax information and is being furnished to the IRS. If you are required to file a return, a negligence penalty or other sanction may be imposed on you if this income is taxable and the IRS determines that it has not been reported.</td>
                              </tr>        
                              <tr>
                                <td colspan="4" class="bstyle">Street address (including apt. no.) <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b> </td>
                                <td class="bstyle">9  Crop insurance proceeds </br>  <p style="float: left;"><b>$</b></p><p style="float: right;"><b> </b></p></td>
                                <td colspan="2" class="bstyle">10 Gross proceeds paid to an attorney<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.FishingProceeds,",9.99")# </b></p></td>
                                <td class="bstyle"></td>
                              </tr>               
                              <tr>
                                <td colspan="4" class="bstyle">City or town, state or province, country, and ZIP or foreign postal code <br/> </td>
                                <td class="bstyle">11 <br/></td>
                                <td colspan="2" class="bstyle">12 Section 409A deferrals <br/>  <p style="float: left;"><b>$</b></p><p style="float: right;"><b> </b></p></td>
                                <td class="bstyle"></td>
                              </tr>        
                              <tr>
                                <td colspan="2" class="bstyle">Account number (see instructions)</td>
                                <td class="bstyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FATCA filing requirement &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" disabled="true" id="FATCAfilingRequirements" name="FATCAfilingRequirements" disabled="true" value="FATCAfilingRequirements"></td>
                                <td class="bstyle"></td>
                                <td class="bstyle">13 Excess golden parachute payments<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b>0.00</b></p></td>
                                <td colspan="2" class="bstyle">14  Nonqualified deferred compensation<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b>0.00</b></p></td>
                                <td class="bstyle"></td>
                              </tr>         
                              <tr>
                                <td colspan="4" class="bstyle"></td>
                                <td class="bstyle">15 State tax withheld</td>
                                <td colspan="2" class="bstyle">16 State/Payer's state no.<br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;37-600 2057</b></td>
                                <td class="bstyle">17 State income </td>
                              </tr>         
                              <tr>
                                <td colspan="4" class="lstyle"></td>
                                <td class="bdstyle lstyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryMisc.StateWithholding,",9.99")# </b></p></td>
                                <td colspan="2" class="bdstyle"></td>
                                <td class="bdstyle"> <p style="float: left;"><b>$</b></p><p style="float: right;"><b> </b></p></td>
                              </tr>         
                              <tr>
                                <td class="tstyle" colspan="4">Form &nbsp;&nbsp;&nbsp;&nbsp;<b>1099-MISC</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(keep for your records)</td>
                                <td class="tstyle">www.irs.gov/form1099misc</td>
                                <td colspan="3" class="tstyle">Department of the Treasury - Internal Revenue Service</td>
                              </tr>  
                          </table>             
                        </cfif>

                      </cfsavecontent>
                    <CFSET session.MISCTaxReportData = reportdata>
                    <cfoutput>#reportdata#</cfoutput>
                    <cfform id="pdfreport" class="screen" name ="pdfreport" target="_blank" action="/taxforms/pdfreportMISC/" method="post">
                      <button type="submit" name="PrintReport" class="btn btn-info margintop">Print Report</button>
                    </cfform> 
                    </cfoutput>
                </cfif>               
                <!--- <cfif IsDefined("qryMisc") AND qryMisc.RecordCount EQ "0">
                  <div class="alert alert-danger screen margintop">
                    No records found.
                  </div>
                </cfif> --->
              </div>
              <div <cfif qryMisc.RecordCount NEQ 0> class="tab-pane fade" <cfelse> class="tab-pane fade active in"</cfif> id="int">

                <cfif IsDefined("qryINT") AND qryINT.RecordCount NEQ 0>
                  
                    <cfoutput>
                      <cfsavecontent variable="reportdata">
                        <div class="alert alert-info screen margintop">
                          1099-INT Form #qryINT.RowNumber# - #qryINT.RecDate#
                        </div>
                        <table class="tableX" cellpadding="0" cellspacing="0">
                          <tr>
                            <td colspan="9" align="center"><input type="checkbox" <cfif Rtrim(Ltrim(qryINT.CorrectionIndicator)) NEQ ""> checked</cfif> id="corrected" disabled="true" name="corrected" value="corrected">
                            CORRECTED (if checked)
                           </td>
                          </tr>        
                          <tr>
                            <td colspan="4" class="bstyle">PAYER'S name, street address, city or town, state or province, country, ZIP or foreign postal code, and telephone no.</td>
                            <td class="bstyle">Payer's RTN (optional)<br/></td>
                            <td colspan="2" class="tstyle lstyle"  style="white-space: nowrap;">OMB No. 1545-0112</td>
                            <td colspan="2" class="lstyle"></td>
                          </tr>          
                          <tr>
                            <td colspan="4" class="lstyle"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>STATE OF ILLINOIS  69-0330001  37-6002057</b> <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>COMPTROLLER - WITHHOLDING AGENT <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;325 WEST ADAMS STREET</b><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>SPRINGFIELD, ILLINOIS 62704-1871 <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (217) 785-4422 </b></td>
                            <td class="bstyle">1 Interest income <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryINT.InterestIncome,",9.99")# </b></p></td>
                            <td colspan="2" class="lstyle"><b><p align="Center"> #variables.FY# </p></b></td>
                            <td colspan="2" align="center" class="lstyle"><b>Interest Income</b></td>
                          </tr>         
                          <tr>
                            <td colspan="4" class="lstyle"></td>
                            <td class="bstyle">2 Early withdrawal penalty <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryINT.WithdrawalPenalty,",9.99")# </b></p></td>
                            <td colspan="2" class="lstyle"> Form <b>1099-INT</b></td>
                            <td colspan="2" class="lstyle"></td>
                          </tr>                
                          <tr>
                            <td class="bstyle">PAYER'S TIN <br/>&nbsp;&nbsp;&nbsp;&nbsp;<b>37-6002057</b></td>
                            <td colspan="3" class="bstyle">RECIPIENT'S TIN <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*****#right(qryINT.TINNumber,4)#</b></td>
                            <td colspan="4" class="bstyle">3 Interest on U.S. Savings Bonds and Treas. obligations <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryINT.BondTreasInterest,",9.99")# </b></p></td>
                            <td class="bstyle" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Copy B<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For Recipient</b></td>
                          </tr>       
                          <tr>
                            <td colspan="4" class="lstyle tstyle">RECIPIENT'S name <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>#qryINT.RecipientName1#  </b></td>
                            <td class="bstyle">4 Federal income tax withheld <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryINT.FederalWithholding,",9.99")# </b></p></td>
                            <td colspan="3" class="bstyle">5 Investment Expenses <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p align="right"><b>  </b></p></td>
                            <td class="lstyle" align="left">This is important tax information and is being furnished to the IRS. If you are required to file a return, a negligence penalty or other sanction may be imposed on you if this income is taxable and the IRS determines that it has not been reported.</td>
                          </tr>         
                          <tr>
                            <td colspan="4" class="lstyle"></td>
                            <td class="bstyle">6 Foreign tax paid <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryINT.ForeignTaxPaid,",9.99")# </b></p></td>
                            <td colspan="3" class="bstyle">7 Foreign country or U.S. possession <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p align="right"><b>  </b></p></td>
                            <td class="lstyle"></td>
                          </tr>        
                          <tr>
                            <td colspan="4" class="lstyle"></td>
                            <td class="bstyle">8 Tax-exempt interest <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p align="right"><b>  </b></p></td>
                            <td colspan="3" class="bstyle">9 Specified private activity bond interest <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p align="right"><b>  </b></p></td>
                            <td class="lstyle"></td>
                          </tr>         
                          <tr>
                            <td colspan="4" class="lstyle">Street address (including apt. no.) <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td class="bstyle">10 Market discount <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p align="right"><b>  </b></p></td>
                            <td colspan="3" class="bstyle">11 Bond premium <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p align="right"><b>  </b></p></td>
                            <td class="lstyle"></td>
                          </tr>       
                          <tr>
                            <td colspan="4" class="lstyle">City or town, state or province, country, and ZIP or foreign postal code <br/> </td>
                            <td class="bstyle">12 Bond premium on Treasury obligations <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p align="right"><b>  </b></p></td>
                            <td colspan="3" class="bstyle">13 Bond premium on tax-exempt bond <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p align="right"><b>  </b></p></td>
                            <td class="lstyle"></td>
                          </tr>
                          <tr>
                            <td colspan="2" class="bstyle">Account number (see instructions)</td>
                            <td class="bstyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FATCA filing requirement &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" disabled="true" id="FATCAfilingRequirements" name="FATCAfilingRequirements" disabled="true" value="FATCAfilingRequirements"></td>
                            <td class="bstyle"></td>
                            <td class="bstyle">14 Tax-exempt and tax credit bond CUSIP no.<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p align="right"><b> </b></p></td>
                            <td class="bstyle">15 State</td>
                            <td colspan="2" class="bstyle">16 State Identification no.<br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>37-600 2057</b></td>
                            <td class="bstyle">17 State tax withheld <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p align="right"><b>  </b></p></td>
                          </tr>
                          <tr>
                            <td class="tstyle" colspan="2"><p align="left">Form <b>1099-INT</b></p> </td>
                            <td align="right" class="tstyle">(keep for your records)</td>
                            <td colspan="3" align="right" class="tstyle">www.irs.gov/form1099int</td>
                            <td colspan="3" align="right" class="tstyle">Department of the Treasury - Internal Revenue Service</td>
                          </tr>        
                        </table>

                      </cfsavecontent>
                      <CFSET session.INTTaxReportData = reportdata>
                      <cfoutput>#reportdata#</cfoutput>
                      <cfform id="pdfreport" name ="pdfreport" target="_blank" action="/taxforms/pdfreportINT/" method="post">
                        <button type="submit" name="PrintReport" class="btn btn-info margintop">Print Report</button>
                      </cfform> 
                    </cfoutput>
                </cfif>
                <!--- <cfif IsDefined("qryINT") AND qryINT.RecordCount EQ "0">
                  <div class="alert alert-danger screen margintop">
                    No records found.
                  </div>
                </cfif>  --->               
              </div>   
              <div <cfif qryMisc.RecordCount NEQ 0 AND qryINT.RecordCount NEQ 0> class="tab-pane fade" <cfelse> class="tab-pane fade active in"</cfif> id="nec">
                <cfif IsDefined("qryNEC") AND qryNEC.RecordCount NEQ 0>
                    <cfoutput>
                      <cfsavecontent variable="reportdata">
                        <div class="alert alert-info screen margintop">
                          1099-NEC Form #qryNEC.RowNumber# - #qryNEC.RecDate#
                        </div>
                        <table class="tableX" cellpadding="0" cellspacing="0">
                          <tr>
                            <td colspan="8" align="center"><input type="checkbox" <cfif Rtrim(Ltrim(qryNEC.CorrectionIndicator)) NEQ ""> checked</cfif> id="corrected" disabled="true" name="corrected" value="corrected">
                            CORRECTED (if checked)
                           </td>
                          </tr>
                          <tr>
                            <td colspan="4" class="bstyle">PAYER'S name, street address, city or town, state or province, country, ZIP or foreign postal code, and telephone no.</td>
                            <td class="tstyle lstyle"></td>
                            <td class="tstyle lstyle" style="white-space: nowrap;">OMB No. 1545-0116 </td>
                            <td colspan="2" class="bstyle" align="right"><b>Nonemployee<br/>Compensation</b></td>
                          </tr>         
                          <tr>
                            <td colspan="4" class="lstyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>STATE OF ILLINOIS 69-0330001 37-6002057 <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPTROLLER - WITHHOLDING AGENT <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;325 WEST ADAMS STREET <br/></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>SPRINGFIELD, ILLINOIS 62704-1871</b><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>(217) 785-4422</b></td>
                            <td class="lstyle"></td>
                            <td class="lstyle"><b><p align="Center"> #variables.FY# </p></b> <br/>Form <b>1099-NEC</b></td>
                            <td colspan="2" class="bstyle"></td>
                          </tr>         
                          <tr>
                            <td colspan="4" class="lstyle"></td>
                            <td class="lstyle"></td>
                            <td colspan="2" class="bstyle"></td>
                            <td class="tstyle lstyle" align="right"><b>Copy B<br/>For Recipient</b></td>
                          </tr>         
                          <tr>
                            <td class="bstyle">PAYER'S TIN<br>&nbsp;&nbsp;&nbsp;&nbsp;<b>37-6002057<b></td>
                            <td colspan="3" class="bstyle">RECIPIENT'S TIN <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*****#right(qryNEC.TINNumber,4)#</b></td>
                            <td class="bstyle" colspan="3">1 Nonemployee compensation<br>  <p style="float: left;"><b>$</b></p><p style="float: right;"><b>#numberFormat(qryNEC.NEC,",9.99")# </b></p></td>
                            <td class="lstyle"></td>
                          </tr>        
                          <tr>
                            <td colspan="4" class="bstyle">RECIPIENT'S name <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>#qryNEC.RecipientName1# </b></td>
                            <td class="bstyle" colspan="3">2</td>
                            <td class="lstyle" style="padding-left: 80px;">This is important tax information and is being furnished to the IRS. If you are required to file a return, a negligence penalty or other sanction may be imposed on you if this income is taxable and the IRS determines that it has not been reported.</td>
                          </tr>        
                          <tr>
                            <td colspan="4" class="bstyle">Street address (including apt. no.) <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td class="bstyle" colspan="3">3</td>
                            <td class="lstyle"></td>
                          </tr>               
                          <tr>
                            <td colspan="4" class="bstyle">City or town, state or province, country, and ZIP or foreign postal code <br/> </td>
                            <td class="bstyle" colspan="3">4 Federal income tax withheld <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;">#numberFormat(qryNEC.FederalWithholding,",9.99")# </b></p></td>
                            <td class="lstyle"></td>
                          </tr>        
                          <tr>
                            <td colspan="2" class="bstyle"></td>
                            <td class="bstyle" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FATCA filing requirement &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" disabled="true" id="FATCAfilingRequirements" name="FATCAfilingRequirements" disabled="true" value="FATCAfilingRequirements"></td>
                            <td class="bstyle"  colspan="3"></td>
                            <td class="lstyle"></td>
                          </tr>         
                          <tr>
                            <td colspan="4" class="bstyle">Account number (see instructions)</td>
                            <td class="bstyle">5 State tax withheld <br/> $</td>
                            <td colspan="2" class="bstyle">6 State/Payer's state no.<br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>37-600 2057</b></td>
                            <td class="bstyle">7 State income <br/> $</td>
                          </tr>
                          <tr>
                            <td class="tstyle" colspan="4">Form &nbsp;&nbsp;&nbsp;&nbsp;<b>1099-NEC</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(keep for your records)</td>
                            <td class="tstyle">www.irs.gov/form1099nec</td>
                            <td class="tstyle" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td class="tstyle">Department of the Treasury - Internal Revenue Service</td>
                          </tr>  
                        </table>
                      </cfsavecontent>
                      <CFSET session.NECTaxReportData = reportdata>
                      <cfoutput>#reportdata#</cfoutput>
                      <cfform id="pdfreport" class="screen" name ="pdfreport" target="_blank" action="/taxforms/pdfreportNEC/" method="post">
                        <button type="submit" name="PrintReport" class="btn btn-info margintop">Print Report</button>
                      </cfform> 
                    </cfoutput>
              </cfif>
              <!--- <cfif IsDefined("qryNEC") AND qryNEC.RecordCount EQ "0">
                <div class="alert alert-danger screen margintop">
                  No records found.
                </div>
              </cfif> --->               
              </div> 
              <div <cfif qryMisc.RecordCount NEQ 0 AND qryINT.RecordCount NEQ 0 AND qryNEC.RecordCount NEQ 0> class="tab-pane fade" <cfelse> class="tab-pane fade active in"</cfif> class="tab-pane fade" id="formg">
                <cfif IsDefined("qryFormG") AND qryFormG.RecordCount NEQ 0>
                    <cfoutput>
                      <cfsavecontent variable="reportdata">
                        <div class="alert alert-info screen margintop">
                          1099-G Form #qryFormG.RowNumber# - #qryFormG.RecDate#
                        </div>
                        <table class="tableX" cellpadding="0" cellspacing="0">
                          <tr>
                            <td colspan="8" align="center"><input <cfif Rtrim(Ltrim(qryFormG.CorrectionIndicator)) NEQ ""> checked</cfif> type="checkbox" id="corrected" name="corrected" disabled="true" value="corrected">
                            CORRECTED (if checked)
                           </td>
                          </tr>
                          <tr>
                            <td colspan="4" class="bstyle">PAYER'S name, street address, city or town, state or province, country, ZIP or foreign postal code, and telephone no.</td>
                            <td class="bstyle">1 Unemployment compensation <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryFormG.UnemploymentComp,",9.99")# </b></p></td>
                            <td class="bstyle"  style="white-space: nowrap;">OMB No. 1545-0120</td>
                            <td colspan="2" class="bstyle"><b>Certain<br/>Government<br/>Payments</b></td>
                          </tr>         
                          <tr>
                            <td colspan="4" class="lstyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>STATE OF ILLINOIS 69-0330001 37-6002057 <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; COMPTROLLER - WITHHOLDING AGENT <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 325 WEST ADAMS STREET <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SPRINGFIELD, ILLINOIS 62704-1871</b><br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>(217) 785-4422</b></td>
                            <td class="bstyle">2 State or local income tax <br/>refunds, credits, or offsets <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryFormG.StateLocalTaxRefund,",9.99")# </b></p></td>
                            <td class="lstyle"><b><p align="Center"> #variables.FY# </p></b> <br/>Form <b>1099-G</b></td>
                            <td colspan="2" class="bstyle"></td>
                          </tr>         
                          <tr>
                            <td class="bstyle">PAYER'S TIN<br>&nbsp;&nbsp;&nbsp;&nbsp;<b>37-6002057<b></td>
                            <td colspan="3" class="bstyle">RECIPIENT'S TIN <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*****#right(qryFormG.TINNumber,4)#</b></td>
                            <td class="bstyle">3 Box 2 amount is for tax year <br/><br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!--- <p style="float: left;"><b>$</b></p><p style="float: right;"></p> ---></td>
                            <td colspan="2" class="bstyle">4 Federal income tax withheld <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryFormG.FederalWithholding,",9.99")# </b></p></td>
                            <td class="bstyle"><b> Copy B<br/> For Recipient</b></td>
                          </tr>        
                          <tr>
                            <td colspan="4" class="bstyle">RECIPIENT'S name <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>#qryFormG.RecipientName1# </b></td>
                            <td class="bstyle">5 RTAA payments <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!--- <p style="float: left;"><b>$</b></p><p style="float: right;"></p> ---></td>
                            <td colspan="2" class="bstyle">6 Taxable grants <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryFormG.TaxableGrants,",9.99")# </b></p></td>
                            <td class="bstyle">This is important tax information and is being furnished to the IRS. If you are required to file a return, a negligence penalty or other sanction may be imposed on you if this income is taxable and the IRS determines that it has not been reported.</td>
                          </tr>        
                          <tr>
                            <td colspan="4" class="bstyle">Street address (including apt. no.)  <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td class="bstyle">7 Agriculture payments <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"><b> #numberFormat(qryFormG.AgriculturPayments,",9.99")# </b></p></td>
                            <td colspan="2" class="bstyle">8 If checked, box 2 is trade <br/>or business income &nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" disabled="true" id="businessIncome" name="businessIncome" value="businessIncome"></td>
                            <td class="bstyle"></td>
                          </tr>               
                          <tr>
                            <td colspan="4" class="bstyle">City or town, state or province, country, and ZIP or foreign postal code <br/> </td>
                            <td class="bstyle">9 Market gain <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"></p></td>
                            <td colspan="2" class="bstyle"></td>
                            <td class="bstyle"></td>
                          </tr>        
                          <tr>
                            <td colspan="2" class="bstyle">Account number (see instructions)</td>
                            <td class="bstyle">10 a State</td>
                            <td class="bstyle">10 b State identification no.<br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>37-600 2057</b> </td>
                            <td colspan="3" class="bstyle">11 Satte income tax withheld <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p style="float: left;"><b>$</b></p><p style="float: right;"></p></td>
                            <td class="bstyle"></td>
                          </tr>         
                          <tr>
                            <td class="tstyle">Form &nbsp;&nbsp;&nbsp;&nbsp;<b>1099-G</b></td>
                            <td class="tstyle" colspan="4">(keep for your records)  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;www.irs.gov/form1099g</td>
                            <td colspan="5" class="tstyle">Department of the Treasury - Internal Revenue Service</td>
                          </tr>  
                        </table>            

                      </cfsavecontent>
                      <CFSET session.GTaxReportData = reportdata>
                      <cfoutput>#reportdata#</cfoutput>
                      <cfform id="pdfreport" class="screen" name ="pdfreport" target="_blank" action="/taxforms/pdfreportg/" method="post">
                        <button type="submit" name="PrintReport" class="btn btn-info margintop">Print Report</button>
                      </cfform> 
                    </cfoutput>
                </cfif>
                <!--- <cfif IsDefined("qryFormG") AND qryFormG.RecordCount EQ "0">
                  <div class="alert alert-danger screen margintop">
                    No records found.
                  </div>
                </cfif>  --->               
              </div> 
            </div>
          </cfif>            
          <cfif IsDefined("qryMisc") AND IsDefined("qryINT") AND IsDefined("qryNEC") AND IsDefined("qryFormG") AND 
          qryMisc.RecordCount EQ 0 AND qryINT.RecordCount EQ 0 AND qryNEC.RecordCount EQ 0 AND qryFormG.RecordCount EQ 0>
                  <div class="alert alert-danger screen margintop">
                    No records found.
                  </div>
          </cfif> 


 
      </div>
    </div>    
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>

<script>
  $(document).ready(function(){
    var divs = document.querySelectorAll(".office-box>a"), i;
  var arrURLLink, linkToCheck;
  var currentURL = window.location.href;//window.location.href.split("?")[0];
  
    for (i = 0; i < divs.length; ++i) {
      //console.log(currentURL);
      console.log(divs[i].href);
      //if(divs[i].href.split("?")[0] == currentURL){
      if(divs[i].href == currentURL){       
        divs[i].parentElement.parentElement.classList.add("hovered");
      }
    }

   // $('#VendTIN2').attr('autocomplete', 'off');
   // setTimeout('$("#VendTIN2").val("");', 1000);
  });
  </script>
