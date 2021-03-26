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


<cfif not isdefined("session.TheVendTin")>
	<cflocation url="/vendors?TimedOut=True" addtoken="No">
 	<!---<cflocation URL="/quicktake/vend/">--->
</cfif>

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

<CFIF IsDefined ("form.Agency")>
 <CFSET Agency = form.Agency>
<cfelseif IsDefined ("URL.Agency")>
 <CFSET Agency = URL.Agency>
</CFIF>

<CFIF IsDefined ("form.TranNum")>
 <CFSET Transaction_Number = form.TranNum>
<cfelseif IsDefined ("URL.TranNum")>
 <CFSET Transaction_Number = URL.TranNum>
</CFIF>

<CFIF IsDefined ("URL.VendTinName")>
	<CFSET VendTinName = URL.VendTinName>
<cfelseif IsDefined ("form.VendTinName")>
	<CFSET VendTinName = form.VendTinName>
<cfelseif IsDefined ("VendTinName")>
	<CFSET VendTinName = VendTinName>
<cfelse>
	<CFSET VendTinName = "">	
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

<cfoutput>

<CFQUERY NAME="RESULTS" DATASOURCE="DB2PRD" CACHEDWITHIN="#CreateTimeSpan(0,0,30,0)#">
	SELECT wh.IOC_PVTX.Text_LINE AS LINE , wh.IOC_PVTX.PV_TEXT AS TEXT
	FROM wh.IOC_PVTX
	WHERE 
			wh.IOC_PVTX.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTin#" />
	  AND   wh.IOC_PVTX.VOUCHER_AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#AGENCY#" />
      AND   wh.IOC_PVTX.VOUCHER_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Transaction_Number#" />
      AND   wh.IOC_PVTX.CNFIDENTAL_SWITCH = 'N'
	ORDER BY Text_LINE
	</CFQUERY>
</cfoutput>

<cfoutput>

<CFQUERY NAME="WarrLines" DATASOURCE="DB2PRD">
	SELECT 	wh.TRANS_EXP.Fiscal_Year, wh.TRANS_EXP.ACCEPTANCE_DATE , wh.TRANS_EXP.Agency, wh.AGENCY.Name AS AgencyName
	, wh.TRANS_EXP.AGENCY, wh.TRANS_EXP.fund, wh.TRANS_EXP.Invoice_Number, wh.TRANS_EXP.organization, wh.TRANS_EXP.Appropriation
	, wh.TRANS_EXP.object, wh.Approp.Name AS AppropName, wh.TRANS_EXP.EXPENDED_AMT, wh.TRANS_EXP.REF_CONTRACT_NUM , wh.AGENCY.CONTACT_INFO
	FROM 	wh.TRANS_EXP , wh.AGENCY , wh.Approp
	WHERE 
			wh.TRANS_EXP.AGENCY = wh.AGENCY.AGENCY 
	  AND   wh.TRANS_EXP.FISCAL_YEAR = wh.AGENCY.FISCAL_YEAR 
	  AND   wh.TRANS_EXP.AGENCY = wh.Approp.AGENCY 
	  AND   wh.TRANS_EXP.FISCAL_YEAR = wh.Approp.FISCAL_YEAR 	  
	  AND   wh.TRANS_EXP.APPROPRIATION = wh.Approp.APPROPRIATION	  
	  AND   wh.TRANS_EXP.FUND = wh.Approp.FUND	  
	  AND   wh.TRANS_EXP.ORGANIZATION = wh.Approp.ORGANIZATION	 
	  AND   wh.TRANS_EXP.OBJECT <> '9999'	   
	  AND	wh.TRANS_EXP.AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#AGENCY#" />
      AND 	wh.TRANS_EXP.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTin#" />
      AND   wh.TRANS_EXP.Transaction_Number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Transaction_Number#" />
</CFQUERY>

</cfoutput>

<CFSET Area="Warrants">
<CFINCLUDE TEMPLATE="VendHeader.cfm">
<div class="marginb20"><cfoutput><a href="/vendors/vendor-payments-new/pending-payments/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Mode=Warrants&VendTINName=#VendTINName#&Max=#URLEncodedFormat(Max)#&StartRow=#StartRow#" id="ReturnBack"><i class="glyphicon glyphicon-share-alt"  ></i> Return Back</a></cfoutput></div>

<div name="FormWrapper" id="FormWrapper" class="table-responsive">
<TABLE class="table table-striped table-bordered vendor-table">
<thead>
    <tr>
    <th colspan="5">Voucher Number: <cfoutput>#Transaction_Number#</cfoutput></th></tr>
</thead>
    <cfset columnSum = ArraySum(WarrLines['EXPENDED_AMT'])>
	<CFOUTPUT QUERY="WarrLines">
	<TR id="lightcolor">
		<TD ALIGN="RIGHT" id="FY3"><b>Fiscal Year</b></TD>
		<TD ALIGN="RIGHT" id="FY4">#Fiscal_Year#</TD>
		<TD ALIGN="RIGHT" id="IssueDate3"><b>Voucher Date</b></TD>
		<TD ALIGN="RIGHT" id="IssueDate4">#DateFormat(ACCEPTANCE_DATE,"mm/dd/yy")#</TD>
        <td>&nbsp;</td>
	</TR>
	<TR id="lightcolor">
		<TD ALIGN="RIGHT" id="WarrantTotal3"><b>Voucher Total</b></TD>
		<TD ALIGN="RIGHT" id="WarrantTotal4">#DollarFormat(columnSum)#</TD>
		<TD COLSPAN="3">&nbsp;</TD>
	</TR>

	</CFOUTPUT>
	<TR id="lightcolor"><TD HEIGHT="20" colspan="5">&nbsp;</TD></TR>
	<TR id="darkcolor">
		<TD ALIGN="center" id="Agency3"><b>Agency</b></TD>
		<TD ALIGN="center" id="Contract3"><b>Contract</b></TD>
		<TD ALIGN="center" id="Invoice3"><b>Invoice</b></TD>
		<TD ALIGN="center" id="Voucher3"><b>Voucher</b></TD>
		<TD ALIGN="right" id="Amount3"><b>Agency Amount</b></TD>
	</TR>

	<CFLOOP QUERY="WarrLines">
		<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
      		<CFOUTPUT>
				<TD ALIGN="CENTER" id="Agency4">#AGENCY# - #AgencyName#</TD>
				<TD ALIGN="CENTER" id="Contract4">#REF_CONTRACT_NUM#</TD>
				<TD ALIGN="CENTER" id="Invoice4">#Invoice_Number#</TD>
				<TD ALIGN="CENTER" id="Voucher4">#Transaction_Number#</TD><!--- #VOUCHER_NUMBER# --->
				<TD ALIGN="RIGHT" id="Amount4">#DollarFormat(EXPENDED_AMT)#</TD>
			</CFOUTPUT>
		</TR>
</CFLOOP>
</TABLE>
</div>

<div name="FormWrapper" id="FormWrapper" class="table-responsive margintop30">
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
            <TD ALIGN="right" id="Amount4">#DollarFormat(EXPENDED_AMT)#</TD><!--- #dOLLarFormat(WARRANT_AMT)# --->
    		<TD ALIGN="CENTER" id="AppropName4">#AppropName#</TD>
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
    <TR id="darkcolor"><TD ALIGN="center" id="Line3"><b>Line</b></TD>
    <TD id="Text3"><b>Text</b></TD></TR>
    <CFOUTPUT QUERY="RESULTS">
     <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
     <TD ALIGN="center" id="Line3">#LINE#</TD><TD id="Text3">#TEXT#</TD>
    </TR>
    </CFOUTPUT>
    </TABLE>
<cfelse>
    </div>
    <div class="table-responsive">
    <TABLE class="table table-striped table-bordered vendor-table">
    <thead>
    <TR>
    <Th id="AgencyInfo">Agency Contact Information</TH>
    </TR>
    </thead>
    <CFOUTPUT QUERY="WARRLINES" MAXROWS="1">
     <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
     <TD><cfif isdefined("WarrLines.CONTACT_INFO")>#WarrLines.CONTACT_INFO#</cfif></TD>
    </TR>
    </CFOUTPUT>
    </TABLE>
</CFIF>
</div>
    <div class="text-center"><P>Click <cfoutput><A HREF="javascript:;" onclick="window.open('/vendors/vendor-payments-new/vendor-guide/','Vendor','toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=yes, resizable=no, width=660, height=500'); return false">
here</A></cfoutput> for assistance with this screen.</p></div>

</div>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>

 <script>
	$('#ReturnBack').tooltip({
		'show': false,
			'placement':  'top',
			'title': "Click here to return back to the previous Pending payments listing."
	});
</script>


