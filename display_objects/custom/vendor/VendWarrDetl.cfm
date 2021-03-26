<cfscript>
if (cgi.http_host eq "www.ioc.state.il.us") {
 application.whwebroot = "http://ioc-web-dev2";
 application.securewhwebroot = "http://ioc-web-dev2";
 application.webroot = "http://www.ioc.state.il.us";
} else {
 application.whwebroot = "http://www.wh1.ioc.state.il.us";
 application.securewhwebroot = "https://www.wh1.ioc.state.il.us";
 application.webroot = "http://www.ioc.state.il.us";
}
</cfscript>

<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

    <link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">

<!---
	WH036 - 10/14/97
	WH038 - 10/21/97

	Log Number 125  8/6/99 ASP
		USE THE APPROPRIATE FISCAL YEAR FOR APPROPRIATION NAMES,
		WHICH IS DEPENDENT UPON THE FIRST DIGIT OF THE VOUCHER

	WH00178
	Developer: ASP
	Date Completed: 7/11/00

	WH00203
	Developer: ASP:
	Date: 8/14/00

   	Modification : 01286
   	Modification By : Andrew Peterson
   	Modification Date : 12/21/01
   	Mod Description : Include Detail objects that were charged as the result of a payment being made.
   	This information is needed for transaction processing that roles EFT or archived payments.


   	Modification By : Andrew Peterson
   	Modification Date : 10/26/05
   	Mod Description : Auto Email showed that sometimes an acceptance date was not provided - wrote conditional.

   	Modified Date: 10-14-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

	Description:  Allows the users to view the detail information on a particular Vendor Warrants
--->

<!--- Code change by RK for SR 17070 starts here --->
<cfoutput>

<CFIF IsDefined ("form.warrant")>
 <CFSET warrant = form.FY>
<cfelseif IsDefined ("URL.warrant")>
 <CFSET warrant = URL.warrant>
</CFIF>

<CFIF IsDefined ("form.FY")>
 <CFSET FY = form.FY>
<cfelseif IsDefined ("URL.FY")>
 <CFSET FY = URL.FY>
</CFIF>

<CFIF IsDefined ("form.Accept_date")>
 <CFSET Accept_date  = form.Accept_date >
<cfelseif IsDefined ("URL.Accept_date")>
 <CFSET Accept_date  = URL.Accept_date >
</CFIF>

<CFIF IsDefined ("form.Agency")>
 <CFSET Agency = form.Agency>
<cfelseif IsDefined ("URL.Agency")>
 <CFSET Agency = URL.Agency>
</CFIF>

<CFIF IsDefined ("form.Status")>
 <CFSET Status = form.Status>
<cfelseif IsDefined ("URL.Status")>
 <CFSET Status = URL.Status>
 <cfelse>
 <CFSET Status = "All">
</CFIF>

<CFIF IsDefined ("form.Startdate")>
 <CFSET Startdate = form.Startdate>
<cfelseif IsDefined ("URL.INVSEL")>
 <CFSET Startdate = URL.Startdate>
 <cfelse>
 <CFSET Startdate = "">
</CFIF>

<CFIF IsDefined ("form.EndDate")>
 <CFSET EndDate = form.EndDate>
<cfelseif IsDefined ("URL.INVSEL")>
 <CFSET EndDate = URL.EndDate>
 <cfelse>
 <CFSET EndDate = "">
</CFIF>
<CFIF IsDefined ("form.SortBy")>
 <CFSET SortBy = form.SortBy>
<cfelseif IsDefined ("URL.SortBy")>
 <CFSET SortBy = URL.SortBy>
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

<CFIF IsDefined ("form.CONTAGCYSEL")>
 <CFSET CONTAGCYSEL = form.CONTAGCYSEL>
<cfelseif IsDefined ("URL.CONTAGCYSEL")>
 <CFSET CONTAGCYSEL = URL.CONTAGCYSEL>
</CFIF>

<CFIF IsDefined ("form.INVSEL")>
 <CFSET INVSEL = form.INVSEL>
<cfelseif IsDefined ("URL.INVSEL")>
 <CFSET INVSEL = URL.INVSEL>
 <cfelse>
 <CFSET INVSEL = "">
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

</cfoutput>
<!--- Code change by RK for SR 17070 ends here. I hadd also Startdate and Enddate with attributes.Startdate and attributes.Enddate--->

<cfif not isdefined("warrant")>
	<cflocation url="/vendors?TimedOut=True" addtoken="No">
 	<!---<cflocation URL="/quicktake/vend/">--->
</cfif>

<!---<cfif not isDate(Accept_Date)>
	<P>Sorry, The Date <B><cfoutput>#accept_Date#</cfoutput></B> is not an acceptable date.
		<cfif cgi.HTTP_REFERER eq "">
		<P>Please visit our <A HREF="http://www.ioc.state.il.us">home</A> page go back and try again. If you have any questions, <A HREF="mailto:webmaster@IllinoisComptroller.Gov">email</A> the webmaster.</P>
		</cfif>
	</p>
<cfabort>
</cfif>--->


<cfif isDefined("session.TheVendTin")>
 <cfset vendTIN = Decrypt(session.TheVendTin,"ITBG111")>
</cfif>

<cfif len(VendTiN) eq 8>
	<cfSet VendTin="0#VendTIN#">
<cfelseif len(VendTiN) eq 7>
	<cfSet VendTin="00#VendTIN#">
<cfelse>
	<cfSet VendTin="#VendTIN#">
</cfif>

<!--- First, dtermine if PVTx exists--->
<cfoutput>
<!---<cftry>--->

<CFQUERY NAME="RESULTS" DATASOURCE="DB2PRD" CACHEDWITHIN="#CreateTimeSpan(0,0,30,0)#">
	SELECT LINE, TEXT
	FROM WH.PVTX_NON_CNFDTL	A
	, WH.TRANS_WARR_LINE_#FY#	B
	WHERE
	B.VOUCHER_NUMBER = A.VOUCHER_NUMBER
	AND B.VOUCHER_AGENCY=A.VOUCHER_AGENCY
	AND B.TRANSACTION_LINE = <cfqueryparam cfsqltype="cf_sql_varchar" value="01" />
	AND B.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Warrant#" />
	AND B.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Accept_date)#" />
	AND A.VENDOR_TIN = B.VENDOR_TIN
	AND A.VENDOR_ADDR_IND = B.VENDOR_ADDR_IND
	ORDER BY LINE
	</CFQUERY>
	<!---<cfcatch type="database">
	<cfinclude template="/warehouseOfflineMessage.htm">
	<cfmail to="webmaster@IllinoisComptroller.Gov" from="webmaster@IllinoisComptroller.Gov" subject="VendWarrDetl CFTRy Worked" type="html">
		Eventually, you will want to replace this with writing to a log file, or nothing at all.
	</cfmail>
	<cfabort>
	</cfcatch>

</cftry>--->
</cfoutput>

<cfoutput>
<CFQUERY NAME="WarrHeader" DATASOURCE="DB2PRD">
	SELECT 	wh.TRANS_WARR_HDR_#FY#.FISCAL_YEAR,
			wh.TRANS_WARR_HDR_#FY#.RECORD_DATE,
			wh.TRANS_WARR_HDR_#FY#.LAST_ACTION_DATE,
			wh.TRANS_WARR_HDR_#FY#.TRANSACTION_CODE,
			wh.TRANS_WARR_HDR_#FY#.TRANSACTION_NUMBER,
			wh.TRANS_WARR_HDR_#FY#.TOT_WARRANT_AMT,
			wh.TRANS_WARR_HDR_#FY#.WARRANT_STATUS
	FROM 	wh.TRANS_WARR_HDR_#FY#
	WHERE 	wh.TRANS_WARR_HDR_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Warrant#" />
      AND 	wh.TRANS_WARR_HDR_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTin#" />
	  AND 	wh.TRANS_WARR_HDR_#FY#.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Accept_date)#" />
</CFQUERY>

<CFQUERY NAME="WarrLines" DATASOURCE="DB2PRD">
	SELECT	wh.TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE,
			wh.TRANS_WARR_LINE_#FY#.FUND,
			wh.TRANS_WARR_LINE_#FY#.AGENCY,
			wh.TRANS_WARR_LINE_#FY#.ORGANIZATION,
			wh.TRANS_WARR_LINE_#FY#.APPROPRIATION,
			wh.TRANS_WARR_LINE_#FY#.OBJECT,
			wh.TRANS_WARR_LINE_#FY#.WARRANT_AMT,
			wh.TRANS_WARR_LINE_#FY#.CONTRACT_CODE,
			wh.TRANS_WARR_LINE_#FY#.CONTRACT_NUMBER,
			wh.TRANS_WARR_LINE_#FY#.VOUCHER_CODE,
			wh.TRANS_WARR_LINE_#FY#.VOUCHER_NUMBER,
			wh.TRANS_WARR_LINE_#FY#.VENDOR_INVOICE,
			wh.AGENCY_#FY#.NAME
			, wh.AGENCY_#FY#.CONTACT_INFO
	FROM 	wh.TRANS_WARR_LINE_#FY#, wh.AGENCY_#FY#
	WHERE 	wh.TRANS_WARR_LINE_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Warrant#" /> AND
			wh.TRANS_WARR_LINE_#FY#.AGENCY = wh.AGENCY_#FY#.AGENCY AND
            wh.TRANS_WARR_LINE_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTin#" /> AND
			wh.TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Accept_date)#" />
</CFQUERY>
</cfoutput>

<CFSET Area="Warrants">
<CFINCLUDE TEMPLATE="VendHeader.cfm">
<!---<div class="col-sm-12"><h2><center>Warrant Detail</center></h2></div>--->
<div class="marginb20"><cfoutput><a href="/vendors/vendor-payments-new/vendor-warrant-list?SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&VendTINName=#VendTINName#&Mode=WarrDetl&Agency=#Agency#&Status=#Status#&FY=#FY#&startDate=#startDate#&EndDate=#EndDate#&Sortby=#Sortby#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcySel=#ContAgcySel#&InvSel=#InvSel#&Max=#URLEncodedFormat(Max)#&StartRow=#StartRow#" id="ReturnBack"><i class="glyphicon glyphicon-share-alt"></i> Return Back</a></cfoutput></div>


<div name="FormWrapper" id="FormWrapper" class="table-responsive">
<TABLE class="table table-striped table-bordered vendor-table">

	<CFOUTPUT QUERY="WarrHeader">
        <thead>
	<TR id="darkcolor">
		<TH ALIGN="LEFT" COLSPAN="5" id="WarrantNo">Warrant/EFT##: #TRANSACTION_CODE#  #Warrant#</TH>
	</TR>
    </thead>
	<TR id="lightcolor">
		<TD ALIGN="RIGHT" id="FY3"><!---<A HREF="javascript:;" onclick="window.open('#application.whWebroot#/quicktake/vend/vendguide.cfm','Vendor','toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=yes, resizable=no, width=660, height=500'); return false " STYLE="cursor:help" id="FY3">---><b>Fiscal Year</b><!---</a>---> </TD>
		<TD ALIGN="RIGHT" id="FY4">#Fiscal_Year#</TD>
		<TD ALIGN="RIGHT" id="IssueDate3"><b>Issue Date</b></TD>
		<TD ALIGN="RIGHT" id="IssueDate4">#DateFormat(RECORD_DATE,"mm/dd/yy")#</TD>
		<TD>&nbsp;</TD>
	</TR>
	<TR id="lightcolor">
		<TD ALIGN="RIGHT" id="WarrantTotal3"><b>Warrant Total</b></TD>
		<TD ALIGN="RIGHT" id="WarrantTotal4">#DollarFormat(TOT_WARRANT_AMT)#</TD>
		<TD ALIGN="RIGHT" id="WarrantStatus3"><b>Warrant Status</b></TD>
		<TD ALIGN="RIGHT" id="WarrantStatus4">
		<cfif findNoCase(Warrant_Status, "")>N/A<cfelse>#WARRANT_STATUS#
			<cfswitch EXPRESSION="#Warrant_Status#">
                <cfcase VALUE="A">(Requested Agency Stop)</cfcase>
                <cfcase VALUE="B">(Requested Payee Stop)</cfcase>
                <cfcase VALUE="D">(Confirmed Agency Stop)</cfcase>
                <cfcase VALUE="E">(Escheated)</cfcase>
                <cfcase VALUE="F">(Confirmed Payee Stop)</cfcase>
                <cfcase VALUE="G">(Escheatable)</cfcase>
                <cfcase VALUE="H">(Held)</cfcase>
                <cfcase VALUE="I">(Voided & Replaced - Offset)</cfcase>
                <cfcase VALUE="J">(Undeliverable)</cfcase>
                <cfcase VALUE="K">(Request Payee Rescind Stop)</cfcase>
                <cfcase VALUE="O">(Issued & Outstanding)</cfcase>
                <cfcase VALUE="P">(Paid)</cfcase>
                <cfcase VALUE="Q">(Cancelled for Redeposit)</cfcase>
                <cfcase VALUE="T">(Cancelled for Redeposit - Undel)</cfcase>
                <cfcase VALUE="V">(Voided & Replaced - Lost)</cfcase>
                <cfcase VALUE="W">(Request Agency Rescind Stop)</cfcase>
         	</cfswitch>
         </cfif>
		</TD>
            <TD>&nbsp;</TD>
	</TR>
	</CFOUTPUT>
	<TR id="lightcolor"><TD HEIGHT="20" colspan="5">&nbsp;</TD></TR>
	<TR id="darkcolor">
		<Td ALIGN="center" id="Agency3"><b>Agency</b></Td>
		<TD ALIGN="center" id="Contract3"><b>Contract</b></TD>
		<TD ALIGN="center" id="Invoice3"><b>Invoice</b></TD>
		<TD ALIGN="center" id="Voucher3"><b>Voucher</b></TD>
		<TD ALIGN="right" id="Amount3"><b>Agency Amount</b></TD>
	</TR>
	<CFLOOP QUERY="WarrLines">
		<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
      		<CFOUTPUT>
				<TD ALIGN="CENTER" id="Agency4">#AGENCY# - #NAME#</TD>
				<TD ALIGN="CENTER" id="Contract4">#CONTRACT_NUMBER#</TD>
				<TD ALIGN="CENTER" id="Invoice4">#VENDOR_INVOICE#</TD>
				<TD ALIGN="CENTER" id="Voucher4">#VOUCHER_NUMBER#</TD>
				<TD ALIGN="RIGHT" id="Amount4">#DollarFormat(WARRANT_AMT)#</TD>
			</CFOUTPUT>
		</TR>

<cfoutput>
<CFQUERY NAME="BudgetFY" DATASOURCE="DB2PRD">
	SELECT WH.TRANS_WARR_HDR.Budget_FY
	FROM 	WH.TRANS_WARR_HDR
	WHERE 	WH.TRANS_WARR_HDR.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Warrant#">
      AND 	WH.TRANS_WARR_HDR.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTin#">
	  AND 	WH.TRANS_WARR_HDR.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Accept_date)#">
</CFQUERY>
</cfoutput>

<cfset AppropFY = "#mid(BudgetFY.Budget_FY,3,2)#">
<cfif AppropFY eq "">
	<cfabort>
</cfif>
<!--- ---------------- END OF LOG 125 -------------------- --->
</CFLOOP>
<cfif not isDefined("AppropFY")>
<cfabort>
</cfif>

<cfoutput>
<CFQUERY NAME="Approp" DATASOURCE="DB2PRD" CACHEDWITHIN="#CreateTimeSpan(0,1,0,0)#">
    SELECT 	wh.APPROP_#AppropFY#.NAME
    FROM 	wh.APPROP_#AppropFY#
    WHERE 	wh.APPROP_#AppropFY#.FUND = <cfqueryparam cfsqltype="cf_sql_varchar" value="#warrlines.FUND#" /> AND
            wh.APPROP_#AppropFY#.AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#warrlines.AGENCY#" /> AND
            wh.APPROP_#AppropFY#.ORGANIZATION = <cfqueryparam cfsqltype="cf_sql_varchar" value="#warrlines.ORGANIZATION#" /> AND
            wh.APPROP_#AppropFY#.APPROPRIATION = <cfqueryparam cfsqltype="cf_sql_varchar" value="#warrlines.APPROPRIATION#" />
</CFQUERY>
</cfoutput>
</TABLE>
</div>

<div name="FormWrapper" id="FormWrapper"  class="table-responsive margintop30">
  <TABLE class="table table-striped table-bordered vendor-table">
<thead>
  	<TR>
  		<TH ALIGN="LEFT" COLSPAN="7" id="IOCDetails">IOC Accounting Line Details</TH>
  	</TR>
</thead>
  	<TR id="darkcolor">
  		<TD ALIGN="center" id="Fund3"><b>Fund</b></TD>
  		<TD ALIGN="center" id="Agency5"><b>Agency</b></TD>
  		<TD ALIGN="center" id="Organization3"><b>Organization</b></TD>
  		<TD ALIGN="center" id="Appropriation3"><b>Appropriation</b></TD>
       	<TD ALIGN="center" id="Object3"><b>Object</b></TD>
  		<TD ALIGN="right" id="Amount5"><b>Amount</b></TD>
  		<TD ALIGN="center" id="AppropName3"><b>Appropriation Name</b></TD>
  	</TR>
  	<CFLOOP QUERY="WarrLines">
	  	<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
  			<CFOUTPUT>
            <TD ALIGN="CENTER" id="Fund4">#FUND#</TD>
            <TD ALIGN="CENTER" id="Agency4">#AGENCY#</TD>
            <TD ALIGN="CENTER" id="Organization4">#ORGANIZATION#</TD>
            <TD ALIGN="CENTER" id="Appropriation4">#APPROPRIATION#</TD>
            <TD ALIGN="CENTER" id="Object4">#OBJECT#</TD>
            <TD ALIGN="right" id="Amount4">#dOLLarFormat(WARRANT_AMT)#</TD>
			</CFOUTPUT>
  	<CFOUTPUT QUERY="Approp">
  		<TD ALIGN="CENTER" id="AppropName4">#NAME#</TD>
  	</CFOUTPUT> </TR>
	</CFLOOP>

  </TABLE>
</div>
<div name="FormWrapper" id="FormWrapper" class="margintop30">
      <div class="table-responsive">
<cfif Results.Recordcount>
    <TABLE class="table table-striped table-bordered vendor-table">
    <thead>
    <TR>
    <Th COLSPAN="2" id="PaymentDesc">Payment Voucher Description</Th>
    </TR>
    </thead>
    <TR id="darkcolor">
        <TD ALIGN="center" id="Line3"><b>Line</b></TD>
        <TD id="Text3"><b>Text</b></TD></TR>
    <CFOUTPUT QUERY="RESULTS">
     <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
     <TD ALIGN="center" id="Line3">#LINE#</TD>
        <TD id="Text3">#TEXT#</TD>
    </TR>
    </CFOUTPUT>
    </TABLE>
<cfelse>

    <TABLE class="table table-striped table-bordered vendor-table">
    <thead>
    <TR>
    <Th id="AgencyInfo">Agency Contact Information</TH>
    </TR>
    </thead>
    <CFOUTPUT QUERY="WARRLINES" MAXROWS="1">
     <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
     <TD>#contact_info#</TD>
    </TR>
    </CFOUTPUT>
    </TABLE>
</CFIF>
</div>
<div class="text-center"><p>Click <cfoutput><A HREF="javascript:;" onclick="window.open('#application.SecureWHWebRoot#/quicktake/vend/vendguide.cfm','Vendor','toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=yes, resizable=no, width=660, height=500'); return false">
here</A></cfoutput> for assistance with this screen.</p></div>

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
</script>
<!---
<script>
	$('#WarrantNo').tooltip({
		'show': false,
			'placement':  'top',
			'title': "This is the Comptroller's internal numbering system for warrants. An EFT Payment is a seven digit incremental number."
	});
	$('#FY3').tooltip({
            'show': false,
                'placement': 'top',
                'title': "The Fiscal Year for the contract."
        });
	$('#IssueDate3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the date the Comptroller's Office processed the payment."
	});
	$('#WarrantTotal3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the total payment amount."
	});
	$('#WarrantStatus3').tooltip({
            'show': false,
                'placement': 'top',
                'title': "This is the status of the warrant."
        });
	$('#Agency3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the Agency which the encumbered the warrant."
	});
	$('#Contract3').tooltip({
            'show': false,
                'placement': 'top',
                'title': "This is the contract number assoicated with the warrant."
        });
	$('#Invoice3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the invoice number assoicated with the warrant."
	});
	$('#Voucher3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the voucher number assoicated with the warrant."
	});
	$('#Amount3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the amount of the warrant."
	});
	$('#IOCDetails').tooltip({
            'show': false,
                'placement': 'top',
                'title': "This section shows the individual details associated with the warrant."
        });
	$('#Fund3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the fund under which the warrant was paid."
	});
	$('#Agency5').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the Agency which the encumbered the warrant."
	});
	$('#Contract3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the contract number of the warrant."
	});
	$('#Organization3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The organization number which encumbered the warrant."
	});
	$('#Appropriation3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the appropriation associated with the warrant."
	});
	$('#Object3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the object number associated with the warrant."
	});
	$('#Amount5').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the amount of the warrant."
	});
	$('#AppropName3').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the name of the appropriation associated with the warrant."
	});
	$('#PaymentDesc').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This area shows the voucher descriptions of the warrant lines."
	});

</script>
--->


