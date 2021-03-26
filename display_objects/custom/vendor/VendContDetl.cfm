<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

    <link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">

	<!---
	Migrating changes to production: Friday, May 09, 2003 3:24:58 PM
	Change: Add where clauses in query to exclude records without start and end dates
	Modified by: ASP

	Modified Date: 11-21-00
	Modified By: Gary Ashbaugh
	Modifications Made: Add redirect when VendTIN is not defined

	 WH012 - 10/14/97
	CHANGE IN PROGRESS - N PAQUIN
	WH00178
	Developer: ASP
	Date Completed: 7/11/00


	Modification Date : Thursday, May 08, 2003 9:37:09 AM
	Modified By : ASP
	Requester : Matt Ciotti
	Modification : Bug in listing showing multiple records for multiple out years. Adding where clause ensuring to and from dates are not null

	Modified Date: 10-14-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

	Description:  Allows the users to view the detail information on a particular Vendor Contract
	--->

<!--- PEr SR14163 removed ContAgy --->
<!--- <cfif (not isdefined("SVendTIN")) <!---or (not isdefined("ContAgy"))
	or (not isdefined("URL.Contract"))><cfabort>---> 
	<cflocation url="/vendors?TimedOut=True" addtoken="No">
	<!---<CFLOCATION URL="/QuickTake/Vend/">--->
</cfif> --->

<CFSET Area="Contracts">

<!--- Code change by RK for SR 17070 starts here --->
<cfoutput>
<cfinclude template="TmpVendorapplicationSettings.cfm">
<cfif isDefined("URL.sVendTIN")>
 <cfset vendTIN = Decrypt(URLDecode(URL.SVendTIN),"ITBG111")>
<cfelseif isDefined("form.sVendTIN")>
 <cfset vendTIN = Decrypt(URLDecode(form.SVendTIN),"ITBG111")>
</cfif>

<cfif len(VendTiN) eq 8>
	<cfSet VendTin="0#VendTIN#">
<cfelseif len(VendTiN) eq 7>
	<cfSet VendTin="00#VendTIN#">
<cfelse>
	<cfSet VendTin="#VendTIN#">
</cfif>
<CFIF IsDefined ("form.Agency")>
	<CFSET Agency = form.Agency>
<cfelseif IsDefined ("URL.Agency")>
	<CFSET Agency = URL.Agency>
</CFIF>

<CFIF IsDefined ("form.AscDesc")>
	<CFSET AscDesc = form.AscDesc>
<cfelseif IsDefined ("URL.AscDesc")>
	<CFSET AscDesc = URL.AscDesc>
</CFIF>
<CFIF IsDefined ("form.Contsel")>
	<CFSET Contsel = form.Contsel>
<cfelseif IsDefined ("URL.Contsel")>
	<CFSET Contsel = URL.Contsel>
</CFIF>
<CFIF IsDefined ("form.FY")>
	<CFSET FY = form.FY>
<cfelseif IsDefined ("URL.FY")>
	<CFSET FY = URL.FY>
</CFIF>
<CFIF IsDefined ("form.FindContracts")>
	<CFSET FindContracts = form.FindContracts>
<cfelseif IsDefined ("URL.FindContracts")>
	<CFSET FindContracts = URL.FindContracts>
</CFIF>
<CFIF IsDefined ("form.Max")>
	<CFSET Max = form.Max>
<cfelseif IsDefined ("URL.Max")>
	<CFSET Max = URL.Max>
</CFIF>
<CFIF IsDefined ("form.Mode")>
	<CFSET Mode = form.Mode>
<cfelseif IsDefined ("URL.Mode")>
	<CFSET Mode = URL.Mode>
</CFIF>
<CFIF IsDefined ("form.POType")>
	<CFSET POType = form.POType>
<cfelseif IsDefined ("URL.POType")>
	<CFSET POType = URL.POType>
</CFIF>
<CFIF IsDefined ("form.SortBy")>
	<CFSET SortBy = form.SortBy>
<cfelseif IsDefined ("URL.SortBy")>
	<CFSET SortBy = URL.SortBy>
</CFIF>
<CFIF IsDefined ("form.contract")>
	<CFSET contract = form.contract>
<cfelseif IsDefined ("URL.contract")>
	<CFSET contract = URL.contract>
</CFIF>

<CFIF IsDefined ("url.max")>
 <CFSET max = URL.max>
</CFIF>

<CFIF IsDefined ("form.StartRow")>
  <CFSET StartRow = form.StartRow>  
<cfelseif IsDefined ("url.StartRow")>
 <CFSET StartRow = URL.StartRow>
</CFIF>

</cfoutput>


<!---<cftry>--->
	<cfif left(ltrim(rtrim(Agency)),3) is "All" or left(ltrim(rtrim(Agency)),3) is "ACC" or left(ltrim(rtrim(Agency)),3) is "IPS">
<CFQUERY NAME="Results" DATASOURCE="DB2PRD" >


  SELECT
        wh.SUMM_VEND_CONT_#FY#.VENDOR_TIN
        , wh.SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY
        , wh.SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER
        , wh.TRANS_CONT_HDR_#FY#.CONTRACT_TYPE
        , wh.DESC_PO_TYPE.DESCRIPTION
        , wh.SUMM_VEND_CONT_#FY#.CONTRACT_AMT as CONTRACT_SUM
        , Sum(wh.SUMM_VEND_CONT_#FY#.CONTRACT_ENC_AMT) as CONTRACT_ENC_SUM
        , Sum(wh.SUMM_VEND_CONT_#FY#.CONTRACT_EXP_AMT) as CONTRACT_EXP_SUM
        , wh.TRANS_CONT_HDR_#FY#.FROM_DATE
        , wh.TRANS_CONT_HDR_#FY#.TO_DATE
        <!--- ASP 4-6-01--->
        , wh.TRANS_CONT_HDR_#FY#.ACCEPTANCE_DATE
        FROM
        wh.SUMM_VEND_CONT_#FY#,
        wh.TRANS_CONT_HDR_#FY#,
        wh.DESC_PO_TYPE
        WHERE
        wh.SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY = wh.TRANS_CONT_HDR_#FY#.TRANSACTION_AGENCY AND
        wh.SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER = wh.TRANS_CONT_HDR_#FY#.TRANSACTION_NUMBER AND
        wh.SUMM_VEND_CONT_#FY#.VENDOR_TIN = wh.TRANS_CONT_HDR_#FY#.VENDOR_TIN AND
        wh.TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = wh.DESC_PO_TYPE.TYPE_OF_ORDER AND

        <!--- Per SR14163 use Agency instead of ContAgy except when Agency is ALL--->
        <!---
        <CFIF #ContAgy# is not "" and #ContSel# is not "">
        wh.SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY = '#ContAgy#' AND
        wh.SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER = '#UCase(ContSel)#' AND
        </CFIF>
        --->

        <cfif #ContSel# is not "">
            wh.SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#UCase(ContSel)#"> AND
        </cfif>
        <CFIF #POType# is not "All">
        wh.TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = <cfqueryparam cfsqltype="cf_sql_char" value="#POType#"> AND
        </CFIF>

        wh.SUMM_VEND_CONT_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#VendTin#">
        <!--- modified on Thursday, May 08, 2003 9:37:50 AM --->
        and wh.TRANS_CONT_HDR_#FY#.FROM_DATE IS NOT null
        AND wh.TRANS_CONT_HDR_#FY#.TO_DATE IS NOT null
        <!--- wh.TRANS_CONT_LINE_#FY#.VENDOR_TIN = '#VendTIN#' --->

        GROUP BY wh.SUMM_VEND_CONT_#FY#.VENDOR_TIN,
        wh.SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY,
        wh.SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER,
        wh.TRANS_CONT_HDR_#FY#.CONTRACT_TYPE,
        wh.DESC_PO_TYPE.DESCRIPTION,
        wh.TRANS_CONT_HDR_#FY#.FROM_DATE,
        wh.TRANS_CONT_HDR_#FY#.TO_DATE,
        <!--- ASP 4-6-01--->
        wh.TRANS_CONT_HDR_#FY#.ACCEPTANCE_DATE,
        wh.SUMM_VEND_CONT_#FY#.CONTRACT_AMT
        ORDER BY
        <!--- ASP 4-6-01--->
        FROM_DATE, ACCEPTANCE_DATE,
        <CFIF #Sortby# is "Contract Number">
            wh.SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER
        <CFELSEIF #Sortby# is "Total Contract Amount">
            CONTRACT_SUM
        <CFELSEIF #Sortby# is "Obligated Amount">
            CONTRACT_ENC_SUM
        <CFELSEIF #Sortby# is "Expended Amount">
            CONTRACT_EXP_SUM
        </CFIF>
        <CFIF #AscDesc# is "Asc">
            ASC
        <CFELSE>
            DESC
        </CFIF>
</CFQUERY>

<!--- <CFQUERY NAME="Results1" DATASOURCE="DB2PRD" >
</CFQUERY> --->

</CFIF>

<CFIF IsDefined ("form.contract")>
 <CFSET contract = form.contract>
<cfelseif IsDefined ("URL.contract")>
 <CFSET contract = URL.contract>
<cfelseif IsDefined ("Results.TRANSACTION_NUMBER")>
 <CFSET contract = Results.TRANSACTION_NUMBER>
</CFIF>

<CFIF IsDefined ("form.CONTAGCY")>
 <CFSET CONTAGCY = form.CONTAGCY>
<cfelseif IsDefined ("URL.CONTAGCY")>
 <CFSET CONTAGCY = URL.CONTAGCY>
<cfelseif IsDefined ("Results.TRANSACTION_AGENCY")>
 <CFSET CONTAGCY = Results.TRANSACTION_AGENCY>
</CFIF>

<!--- Code change by RK for SR 17070 ends here --->

<CFINCLUDE TEMPLATE="VendHeader.cfm">
<!---<div class="col-sm-12"><h2><center>Contract Detail</center></h2></div>--->

<!--- <div class="col-sm-12 pull-right"><cfoutput><a href="/vendors/vendor-payments-new/vendor-contract-list/?CONTAGCY=#URLEncodedFormat(CONTAGCY)#&Contract=#URLEncodedFormat(ContSel)#&Agency=#Agency#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&POType=#POType#&FY=#FY#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Max=#Max#&Mode=#Mode#&VendTinName=#VendTinName#" id="ReturnBack"><span class="input-group-addon pull-left"><i class="glyphicon glyphicon-share-alt"></i></span>Return Back</a></cfoutput></div> --->
<cfoutput><div class="marginb20"> <a href="/vendors/vendor-payments-new/vendor-contract-list/?Contract=#URLEncodedFormat(ContSel)#&Agency=#Agency#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&POType=#POType#&FY=#FY#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Max=#Max#&Mode=#Mode#&StartRow=#StartRow#&VendTinName=#VendTinName#" id="ReturnBack"><i class="glyphicon glyphicon-share-alt"></i> Return Back</a></div></cfoutput>
<cftry>
<cfoutput>
<CFQUERY NAME="ContHeader" DATASOURCE="db2prd">
	SELECT 	wh.TRANS_CONT_HDR_#FY#.FISCAL_YEAR,
			wh.TRANS_CONT_HDR_#FY#.FROM_DATE,
			wh.TRANS_CONT_HDR_#FY#.TO_DATE,
			wh.TRANS_CONT_HDR_#FY#.CONTRACT_AMT,
			wh.TRANS_CONT_HDR_#FY#.CONTRACT_TYPE,
			wh.TRANS_CONT_HDR_#FY#.CLASS_CODE,
            WH.TRANS_CONT_HDR_#FY#.Transaction_Agency 
	FROM wh.TRANS_CONT_HDR_#FY#
	WHERE
        <cfif left(ltrim(rtrim(Agency)),3) is not "All">
			wh.TRANS_CONT_HDR_#FY#.TRANSACTION_AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Agency#" /> AND
        </cfif>
        <cfif trim(ContAgcy) is "999">
        	wh.TRANS_CONT_HDR_#FY#.Transaction_Agency = <cfqueryparam cfsqltype="cf_sql_varchar" value="999" /> AND
        </cfif> 
		wh.TRANS_CONT_HDR_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Contract#" /> AND
		wh.TRANS_CONT_HDR_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTin#" />
		<!--- modified on Thursday, May 08, 2003 9:37:50 AM --->
		and wh.TRANS_CONT_HDR_#FY#.FROM_DATE IS NOT null
		AND wh.TRANS_CONT_HDR_#FY#.TO_DATE IS NOT null
</CFQUERY>

 <CFQUERY NAME="ContLines" DATASOURCE="db2prd">
	SELECT 	wh.TRANS_CONT_LINE_#FY#.AGENCY,
			wh.TRANS_CONT_LINE_#FY#.CONTRACT_ENC_AMT,
			wh.AGENCY_#FY#.NAME,
            wh.TRANS_CONT_LINE_#FY#.Transaction_AGENCY
	FROM wh.TRANS_CONT_LINE_#FY#, wh.AGENCY_#FY#
	WHERE
    	<cfif left(ltrim(rtrim(Agency)),3) is not "All">
		wh.TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Agency#" /> AND
        </cfif>
		wh.TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Contract#" /> AND
		wh.TRANS_CONT_LINE_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTin#" /> AND
		wh.TRANS_CONT_LINE_#FY#.AGENCY = wh.AGENCY_#FY#.AGENCY
</CFQUERY> 
 <CFQUERY NAME="ContLines1" DATASOURCE="db2prd">
SELECT 
wh.TRANS_EXP.AGENCY,wh.TRANS_EXP.ENCUMBERED_AMT,wh.AGENCY_#FY#.NAME,
wh.TRANS_EXP.TRANSACTION_AGENCY
FROM wh.TRANS_EXP, wh.AGENCY_#FY#
	WHERE
    	<cfif left(ltrim(rtrim(Agency)),3) is not "All">
			wh.TRANS_EXP.TRANSACTION_AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Agency#" /> AND
        </cfif>
		wh.TRANS_EXP.REF_CONTRACT_NUM = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Contract#" /> AND
		wh.TRANS_EXP.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTin#" /> AND
		wh.TRANS_EXP.AGENCY = wh.AGENCY_#FY#.AGENCY
</CFQUERY>


</cfoutput>
<cfcatch type="database">
	 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
	</cfcatch>
</cftry>

<div name="FormWrapper" id="FormWrapper" class="table-responsive">
<TABLE class="table table-striped table-bordered vendor-table">
	<CFOUTPUT QUERY="ContHeader">
    <cfif ContAgcy is not "999" and Transaction_Agency is "999">
    <cfelse>
        <thead>
	<TR id="darkcolor">
    	<!--- PEr 14163 use Agency instead of ContAgy except when Agency is equal to All --->
		<TH ALIGN="LEFT" id="Contract4" COLSPAN="6">Contract: <cfif left(ltrim(rtrim(Agency)),3) is not "All">#Agency# <cfelse><!---#ContAgcy#--->#TRANSACTION_AGENCY#</cfif> #Contract#</TH>
	</TR>
        </thead>
	<TR id="lightcolor">
		<TD ALIGN="RIGHT" id="FY4"><b>Fiscal Year</b></TD>
		<TD ALIGN="RIGHT" id="FY4">#Fiscal_Year#</TD>
		<TD ALIGN="RIGHT" id="FromDate4"><b>From Date</b></TD>
		<TD ALIGN="RIGHT" id="FromDate4">#DateFormat(FROM_DATE,"mm/dd/yy")#</TD>
		<TD ALIGN="RIGHT" id="ToDate4"><b>To Date</b></TD>
		<TD ALIGN="RIGHT" id="ToDate4">#DateFormat(TO_DATE,"mm/dd/yy")#</TD>
	</TR>
	<TR id="lightcolor">
		<TD ALIGN="RIGHT" id="ContractTotal4"><b>Contract Total</b></TD>
		<TD ALIGN="RIGHT" id="ContractTotal4"><cfif trim(ContAgcy) is not "999">#DollarFormat(CONTRACT_AMT)#<cfelse>#DollarFormat(0)#</cfif></TD>
		<TD ALIGN="RIGHT" id="ContractType4"><b>Contract Type</b></TD>
		<TD ALIGN="RIGHT" id="ContractType4">#CONTRACT_TYPE#</TD>
		<TD ALIGN="RIGHT" id="ClassCode4"><b>Class</b></TD>
		<TD ALIGN="RIGHT" id="ClassCode4">#CLASS_CODE#</TD>
	</TR>
    </cfif>
	</CFOUTPUT>
	<TR id="lightcolor"><TD Height="20" colspan="6">&nbsp;</TD></TR>
	<TR id="darkcolor">
		<TD ALIGN="center" COLSPAN="5" id="Agency4"><b>Agency</b></TD>
		<TD ALIGN="right" id="Amount4"><b>Obligated Amount</b></TD>
	</TR>
	<CFOUTPUT QUERY="ContLines">
    <cfif trim(ContAgcy) is not "999">
	<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
		<TD COLSPAN="5" ALIGN="center" id="Agency4">#AGENCY# - #NAME#</TD>
		<TD COLSPAN="3" ALIGN="RIGHT" id="Amount4">#DollarFormat(CONTRACT_ENC_AMT)#</TD>
	</TR>
    </cfif>
	</CFOUTPUT>
	<TR><TD COLSPAN="6">&nbsp;</TD></TR>
	<TR><TD COLSPAN="6">&nbsp;</TD></TR>
		<CFOUTPUT QUERY="ContLines1">
    <cfif trim(ContAgcy) is not "999">
	<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
		<TD COLSPAN="5" ALIGN="LEFT" id="Agency4">#AGENCY# - #NAME#</TD>
		<TD COLSPAN="3" ALIGN="RIGHT" id="Amount4">#DollarFormat(ENCUMBERED_AMT)#</TD>
	</TR>
    </cfif>
	</CFOUTPUT>
</TABLE>
</div>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <!---<script src="/comptroller/jquery/jquery.js"></script>--->
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>


<script>
	$('#ReturnBack').tooltip({
		'show': false,
			'placement':  'top',
			'title': "Click here to return back to the previous warrant listing."
	});
	<!---
	$('#Contract4').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the contract number."
	});
	$('#FY4').tooltip({
            'show': false,
                'placement': 'top',
                'title': "The Fiscal Year for the contract."
        });
	$('#IssueDate4').tooltip({
            'show': false,
                'placement': 'top',
                'title': "This is the date the Comptroller's Office processed the payment."
        });
	$('#FromDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the contract starting date."
	});
	$('#ToDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the contract ending date."
	});
	$('#Amount').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the amount of the contract."
	});
	$('#Obligated').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The amount of the contract obligation."
	});
	$('#Expended').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The amount of the contract already spent."
	});
	--->
</script>
<!---</BODY>
</HTML>--->

