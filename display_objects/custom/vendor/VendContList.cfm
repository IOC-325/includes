<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

    <link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">

<!--- Migrating changes to production: Friday, May 09, 2003 3:24:58 PM
Change: Add where clauses in query to exclude records without start and end dates
Modified By: ASP

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

	Description:  Allows the users to view their Vendor Contracts
--->


<SCRIPT LANGUAGE="Javascript">
<!--
function makeNewRemote(fileName) {
         remote = window.open("","remotewin","width=300,height=110,scrollbars=1");
         remote.location.href = "https://IllinoisComptroller.Gov/Vendor/"+fileName+".cfm";
             if (remote.opener == null) remote.opener = window;
         remote.opener.name = "opener";
         }
         //-->

</SCRIPT>

<CFSET Area="Contracts">
<CFIF IsDefined ("form.SVendTin")>
	<CFSET SVendTin = form.SVendTin>
<cfelseif IsDefined ("URL.SVendTin")>
	<CFSET SVendTin = URL.SVendTin>
<cfelse>
    <cflocation url="/vendors?TimedOut=True" addtoken="No">
</CFIF>
<cfset vendTIN = Decrypt(URLDecode(SVendTIN),"ITBG111")>


<cfif len(VendTiN) eq 8>
	<cfSet VendorTin='0#VendTIN#'>
<cfelseif len(VendTiN) eq 7>
	<cfSet VendorTin='00#VendTIN#'>
<cfelse>
	<cfSet VendorTin='#VendTIN#'>
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

<CFIF IsDefined ("form.max")>
 <CFSET max = form.max>
<cfelseif IsDefined ("url.max")>
 <CFSET max = URL.max>
</CFIF>

<CFIF IsDefined ("form.StartRow")>
  <CFSET StartRow = form.StartRow>  
<cfelseif IsDefined ("url.StartRow")>
 <CFSET StartRow = URL.StartRow>
</CFIF>

<!--- <cfinclude template="TmpVendorapplicationSettings.cfm"> --->
<CFINCLUDE TEMPLATE="VendHeader.cfm">
<!---<div class="col-sm-12"><h2><center>Contract List</center></h2></div>--->


<CFHeader name="Cache-control" value="public">

<!---<cftry>--->
<CFQUERY NAME="Results" DATASOURCE="DB2PRD" >
<cfif left(ltrim(rtrim(Agency)),3) is "All" or left(ltrim(rtrim(Agency)),3) is "ACC" or left(ltrim(rtrim(Agency)),3) is "IPS">

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
            wh.SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#ReReplaceNoCase(UCase(ContSel)," ","",'ALL')#"> AND
        </cfif>
        <CFIF #POType# is not "All">
        wh.TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = <cfqueryparam cfsqltype="cf_sql_char" value="#POType#"> AND
        </CFIF>

        wh.SUMM_VEND_CONT_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#Variables.VendorTin#">
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
<CFELSE>
		SELECT 	wh.TRANS_CONT_LINE_#FY#.VENDOR_TIN,
				wh.TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY,
				wh.TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER,
				wh.TRANS_CONT_LINE_#FY#.AGENCY,
				wh.TRANS_CONT_HDR_#FY#.CONTRACT_TYPE,
				wh.DESC_PO_TYPE.DESCRIPTION,
				wh.TRANS_CONT_HDR_#FY#.FROM_DATE,
				<!--- ASP 4-6-01--->
				wh.TRANS_CONT_HDR_#FY#.ACCEPTANCE_DATE,
				wh.TRANS_CONT_HDR_#FY#.TO_DATE,
				wh.TRANS_CONT_HDR_#FY#.CONTRACT_AMT AS CONTRACT_SUM,
				Sum(wh.TRANS_CONT_LINE_#FY#.CONTRACT_ENC_AMT) AS CONTRACT_ENC_SUM
		FROM 	wh.TRANS_CONT_LINE_#FY#, wh.TRANS_CONT_HDR_#FY#, wh.DESC_PO_TYPE
		WHERE
				wh.TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY = wh.TRANS_CONT_HDR_#FY#.TRANSACTION_AGENCY
				AND wh.TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER = wh.TRANS_CONT_HDR_#FY#.TRANSACTION_NUMBER
				AND wh.TRANS_CONT_LINE_#FY#.VENDOR_TIN = wh.TRANS_CONT_HDR_#FY#.VENDOR_TIN
				AND wh.TRANS_CONT_LINE_#FY#.VENDOR_TIN = '#Variables.VendorTin#'
				AND	wh.TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = wh.DESC_PO_TYPE.TYPE_OF_ORDER AND
                <!--- Per SR14163 Use Agency instead of ContAgy except when Agency is ALL --->
                <!---
				<CFIF #ContAgy# is not "" and #ContSel# is not "">
				wh.TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY = '#ContAgy#' AND
				wh.TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER = '#UCase(ContSel)#' AND
				</CFIF>
				--->
               <!--- <CFIF left(ltrim(rtrim(Agency)),3) is not "All">
                    wh.trans_cont_line_#FY#.transaction_Number = <cfqueryparam cfsqltype="cf_sql_CHAR" value="#left(ltrim(rtrim(Agency)),3)#"> and
                </CFIF>--->
               <!--- #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY = <cfqueryparam cfsqltype="cf_sql_CHAR" value="#Agency#"> And--->
                <cfif #ContSel# is not "">
                	wh.TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_CHAR" value="#ReReplaceNoCase(UCase(ContSel)," ","",'ALL')#"> AND
				</CFIF>
				<CFIF #POType# is not "All">
				wh.TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = <cfqueryparam cfsqltype="cf_sql_CHAR" value="#POType#"> AND
				</CFIF>
				wh.TRANS_CONT_LINE_#FY#.AGENCY = <cfqueryparam cfsqltype="cf_sql_CHAR" value="#left(ltrim(rtrim(Agency)),3)#">
<!--- modified on Thursday, May 08, 2003 9:37:50 AM --->
and wh.TRANS_CONT_HDR_#FY#.FROM_DATE IS NOT null
AND wh.TRANS_CONT_HDR_#FY#.TO_DATE IS NOT null

		GROUP BY wh.TRANS_CONT_LINE_#FY#.VENDOR_TIN
		,				wh.TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY
		,			wh.TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER
		,				wh.TRANS_CONT_HDR_#FY#.CONTRACT_TYPE
		,				wh.DESC_PO_TYPE.DESCRIPTION
		,				wh.TRANS_CONT_LINE_#FY#.AGENCY
		,				wh.TRANS_CONT_HDR_#FY#.FROM_DATE
		,				wh.TRANS_CONT_HDR_#FY#.TO_DATE
		,				<!--- ASP 4-6-01--->
				wh.TRANS_CONT_HDR_#FY#.ACCEPTANCE_DATE
		,		wh.TRANS_CONT_HDR_#FY#.CONTRACT_AMT
		ORDER
		BY
		
			<CFIF #Sortby# is "Contract Number">
				<!--- wh.TRANS_CONT_LINE_#FY#. --->
				TRANSACTION_NUMBER
			<CFELSEIF #Sortby# is "Total Contract Amount">
				CONTRACT_SUM
			<CFELSEIF #Sortby# is "Obligated Amount">
				CONTRACT_ENC_SUM
			<CFELSEIF #Sortby# is "Expended Amount">
				CONTRACT_ENC_SUM
			</CFIF>
			<CFIF #AscDesc# is "Asc">
				ASC
			<CFELSE>
				DESC
			</CFIF>
	</CFIF>
</CFQUERY>

<!---<cfcatch type="database">
	 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
	</cfcatch>
</cftry>--->
<!--- wh.SUMM_VEND_CONT_#FY#.VENDOR_TIN = '#VendTIN#' --->


<!--- Per SR14163 Use Agency instead of ContAgy except when Agency is All --->
	<CFSET Query = "/vendors/vendor-payments-new/vendor-contract-list/?Agency=#Agency#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcy=#Agency#&POType=#POType#&FY=#FY#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&VendTinName=#VendTinName#&Max=#Max#&Mode=ContList&">

<Cfif isdefined("Results")>
    <div class="marginb5">
<CFINCLUDE TEMPLATE="PrevNext.cfm">
    </div>
</Cfif>
<div name="FormWrapper" id="FormWrapper" class="table-responsive-new">
<TABLE class="table table-striped vendor-table">
<thead>
<tr>
<th class="text-center" id="ContractAgency"><A HREF="javascript: makeNewRemote('ContractAgency')"  TITLE="The Contract Agency is the Agency creating the contract." STYLE="cursor:help">Contract Agency</A></th>
<th class="text-center" id="Contract"><A HREF="javascript: makeNewRemote('ContractNumber')"  TITLE="The Contract Number is the identification number associated with the contract." STYLE="cursor:help">Contract</A></th>
<th class="text-center" id="Type"><A HREF="javascript: makeNewRemote('ContractType')"  TITLE="Type is the type of contract." STYLE="cursor:help">Type</A></th>
<th class="text-center" id="FromDate"><A HREF="javascript: makeNewRemote('ContractFromDate')"  TITLE="The From Date is when the contract started.">From Date</A></th>
<th class="text-center" id="ToDate"><A HREF="javascript: makeNewRemote('ContractToDate')"  TITLE="The To Date is when the contract ends.">To Date</A></th>
<th class="text-right" id="Amount"><A HREF="javascript: makeNewRemote('ContractAmount')"  TITLE="The Contract Amount is the total amount paid.">Contract Amount</A></th>
<th class="text-right" id="Obligated"><A HREF="javascript: makeNewRemote('Obligated')"  TITLE="The Obligated is the total amount of the contract.">Obligated</A></th>
<CFIF #Agency# is "All"><Th class="text-right" id="Expended"><A HREF="javascript: makeNewRemote('Expended')"  TITLE="The Expended is the total amount accumulated for the contract.">Expended</A></th></CFIF>
</tr>
</thead>
<CFOUTPUT QUERY="Results" STARTROW="#StartRow#" MAXROWS="#Max#">
<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
<TD ALIGN="CENTER" id="ContractAgency2">
<!--- PEr SR14163 use Agency instead of ContAgy except when Agency is All --->
<cfif left(ltrim(rtrim(Agency)),3) is "All" or left(ltrim(rtrim(Agency)),3) is "ACC" or left(ltrim(rtrim(Agency)),3) is "IPS">

	<A HREF="/vendors/vendor-payments-new/vendor-contract-detail/?Contract=#URLEncodedFormat(TRANSACTION_Number)#&Agency=#Agency#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcy=#Transaction_Agency#&POType=#POType#&FY=#FY#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&VendTinName=#VendTinName#&StartRow=#StartRow#&Max=#Max#&Mode=ContList">#TRANSACTION_AGENCY#</a>
<cfelse>
	<A HREF="/vendors/vendor-payments-new/vendor-contract-detail/?Contract=#URLEncodedFormat(TRANSACTION_Number)#&Agency=#left(ltrim(rtrim(Agency)),3)#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcy=#left(ltrim(rtrim(Agency)),3)#&POType=#POType#&FY=#FY#&SVendTin=#URLEncodedFormat#&VendTinName=#VendTinName#&StartRow=#StartRow#&Max=#Max#&Mode=ContList">#TRANSACTION_AGENCY#</a>
</cfif>
</TD>
<TD ALIGN="LEFT" id="Contract2">
	<!--- Per 14163 use Agency instead of ContAgy except when Agency is All ---><!---&ContAgy=#TRANSACTION_AGENCY#--->
<cfif left(ltrim(rtrim(Agency)),3) is "All" or left(ltrim(rtrim(Agency)),3) is "ACC" or left(ltrim(rtrim(Agency)),3) is "IPS">

    	<A HREF="/vendors/vendor-payments-new/vendor-contract-detail/?Contract=#URLEncodedFormat(TRANSACTION_NUMBER)#&Agency=#Agency#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcy=#Transaction_Agency#&POType=#POType#&FY=#FY#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&VendTinName=#VendTinName#&StartRow=#StartRow#&Max=#Max#&Mode=ContList">#TRANSACTION_NUMBER#</A>
 <cfelse>
    	<A HREF="/vendors/vendor-payments-new/vendor-contract-detail/?Contract=#URLEncodedFormat(TRANSACTION_NUMBER)#&Agency=#Agency#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcy=#Agency#&POType=#POType#&FY=#FY#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&VendTinName=#VendTinName#&StartRow=#StartRow#&Max=#Max#&Mode=ContList">#TRANSACTION_NUMBER#</A>
</cfif>
</TD>
<TD ALIGN="LEFT" id="Type2">#DESCRIPTION#</TD>
<TD ALIGN="CENTER" id="FromDate2">#DateFormat(FROM_DATE,"mm/dd/yy")#</TD>
<TD ALIGN="CENTER" id="ToDate2">#DateFormat(TO_DATE,"mm/dd/yy")#</TD>
<TD ALIGN="right" id="Amount2"><cfif TRANSACTION_AGENCY is not "999">#DollarFormat(CONTRACT_SUM)#<cfelse>#DollarFormat(0)#</cfif></TD>
<TD ALIGN="right" id="Obligated2"><cfif TRANSACTION_AGENCY is not "999">#DollarFormat(CONTRACT_ENC_SUM)#<cfelse>#DollarFormat(0)#</cfif></TD>
<CFIF #Agency# is "All"><TD ALIGN="right" id="Expended2"><cfif TRANSACTION_AGENCY is not "999">#DollarFormat(CONTRACT_EXP_SUM)#<cfelse>#DollarFormat(0)#</cfif></TD></CFIF>
</TR>
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

$('#First').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the first set of contract records."
	});
$('#Next').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the next set of contract records."
	});
$('#Previous').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the previous set of contract records."
	});
$('#Last').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the last set of contract records."
	});

<!---
	$('#ContractAgency').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the Agency who initiated the contract."
	});
	$('#Contract').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the contract number."
	});
	$('#Type').tooltip({
            'show': false,
                'placement': 'top',
                'title': "This is the contract type."
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
	$('#id="ContractDetail"').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to see the detail information regarding the Contract."
	});
	--->
</script>
<!---</BODY>
</HTML>--->

