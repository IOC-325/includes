<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">


<!---
	Created Date: 4-27-12
	Created By: Gary Ashbaugh

	Modified By : ASP
	Modification: Cosmetic changes involving the removal of the hover.css style sheet and addition of a few embedded elements

	Modified Date: 10-14-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

	Description:  Allows the users to view their Vendor Warrants
--->


<meta name="robots" content="noindex,nofollow">

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<cfinclude template="TmpVendorapplicationSettings.cfm">

<SCRIPT LANGUAGE="Javascript">
 <!--
function makeRemote(fileName) {
        remote = window.open("","remotewin","width=300,height=110,scrollbars=1");
		
		//Production
		remote.location.href = "https://illinoiscomptroller.gov/Vendor/"+fileName+".cfm";
		
        if (remote.opener == null) remote.opener = window; 
         remote.opener.name = "opener";
         }

<cfoutput>
function ADOWindow(parms) {
	//Production
	remote = window.open("http://illinoiscomptroller.gov/vendors/enhanced-vendor-remittance/about-download-options?"+parms,"remotewin","width=460,height=200,scrollbars=1,addressbar=yes");
	
  	if (remote.opener == null) remote.opener = window; 
     	remote.opener.name = "opener";
	}
</cfoutput>

function makeNewRemote(fileName) {
         remote = window.open("","remotewin","width=300,height=110,scrollbars=1");

		 //Production
		 remote.location.href = "http://illinoiscomptroller.gov/Vendor/"+fileName+".cfm";
         
		 if (remote.opener == null) remote.opener = window; 
         	remote.opener.name = "opener";
         }

         //-->

</SCRIPT>

<cf_formURL2attributes>

<cfparam name="Max" default="20">
<cfparam NAME="attributes.StartDate" DEFAULT="">
<cfparam NAME="attributes.EndDate" DEFAULT="">
<cfparam name="SpreadsheetMax" default="2000">
<cfparam NAME="url.SpreadsheetStartRow" DEFAULT="1">
<cfparam NAME="url.SpreadsheetNewRow" DEFAULT="2000">

<CFIF IsDefined ("URL.Agency")>
 <CFSET Agency = URL.Agency>
<cfelseif IsDefined ("form.Agency")>
 <CFSET Agency = form.Agency>
<cfelseif IsDefined ("Agency")>
 <CFSET Agency = Agency>
</CFIF>

<CFIF IsDefined ("URL.Status")>
 <CFSET Status = URL.Status>
<cfelseif IsDefined ("form.Status")>
 <CFSET Status = form.Status>
<cfelseif IsDefined ("Status")>
 <CFSET Status = Status>
</CFIF>

<CFIF IsDefined ("URL.FY")>
 <CFSET FY = URL.FY>
<cfelseif IsDefined ("form.FY")>
 <CFSET FY = form.FY>
</CFIF>

<CFIF IsDefined ("form.Contsel")>
 <CFSET Contsel = form.Contsel>
<cfelseif IsDefined ("URL.Contsel")>
 <CFSET Contsel = URL.Contsel>
</CFIF>

<CFIF IsDefined ("form.INVSEL")>
 <CFSET INVSEL = form.INVSEL>
<cfelseif IsDefined ("URL.INVSEL")>
 <CFSET INVSEL = URL.INVSEL>
 <cfelse>
 <CFSET INVSEL = "">
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

<CFIF IsDefined ("form.Mode")>
 <CFSET Mode = form.Mode>
<cfelseif IsDefined ("URL.Mode")>
 <CFSET Mode = URL.Mode>
</CFIF>

<CFIF IsDefined ("form.SpreadsheetStartRow")>
 <CFSET SpreadsheetStartRow = form.SpreadsheetStartRow>
<cfelseif IsDefined ("URL.SpreadsheetStartRow")>
 <CFSET SpreadsheetStartRow = URL.SpreadsheetStartRow>
</CFIF>

<CFIF IsDefined ("form.SpreadsheetNewRow")>
 <CFSET SpreadsheetNewRow = form.SpreadsheetNewRow>
<cfelseif IsDefined ("URL.SpreadsheetNewRow")>
 <CFSET SpreadsheetNewRow = URL.SpreadsheetNewRow>
</CFIF>

<CFIF IsDefined ("form.StartDate")>
 <CFSET StartDate = form.StartDate>
<cfelseif IsDefined ("URL.StartDate")>
 <CFSET StartDate = URL.StartDate>
<cfelse>
 <CFSET StartDate = "">
</CFIF>

<CFIF IsDefined ("form.EndDate")>
 <CFSET EndDate = form.EndDate>
<cfelseif IsDefined ("URL.EndDate")>
 <CFSET EndDate = URL.EndDate>
<cfelse>
 <CFSET EndDate = "">
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

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
<cfif not isdefined("Session.VendTIN") or not isDefined("Agency") or not isdefined("Status")>
	<!--- Calls Index from VendorEnhanced --->
    <!--- Development & Production --->
    <cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">

	<!---
	<CFLOCATION URL="#application.SecureWHWebRoot#/QuickTake/Vend/">
	--->
</cfif>
</cfLock>

<CFHeader name="Cache-control" value="public">

<CFSET Area="Warrants">
<CFINCLUDE TEMPLATE="VendHeader.cfm">

<cfinclude template="vendorSQL.cfm">

<cffunction name="getSchedulePaymentDate" output="false" returnType="string">
     <cfargument name="RECORD_DATE" type="string" required="true" default="" />

            <!--- Calculate Anticipated Date --->
	            <cfset FndAnticipatedDt = "False">
	            <cfset NoDays = 0>
	            <!--- Add first day --->
	            <cfset CalcAnticipatedDt = DateFormat(RECORD_DATE,"mm/dd/yyyy")>
	            <cfloop condition = "FndAnticipatedDt equal False">

	                <cfquery name="CheckHoliday" datasource="Common" dbtype="ODBC">
	                    SELECT     Holiday
	                    FROM         StateHoliday
	                    <!---WHERE       Holiday = '#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#'--->
	                    WHERE Holiday =<cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#">
	                </cfquery>
	                <cfif DayofWeek(CalcAnticipatedDt) is 7>
		                <!--- Saturday....move to next --->
		                <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
	                <cfelseif DayofWeek(CalcAnticipatedDt) is 1>
	                    <!--- Sunday....re-calculate date to Monday --->
	                    <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
	                <cfelseif CheckHoliday.recordcount>
                          <!--- Holiday move to next --->
                          <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
	                <cfelse> <!--- Add another Day --->
	                              
	                    <cfif NoDays eq 2>
	                        <cfset FndAnticipatedDt = "True">
	                    <cfelse>                              
	                        <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
	                    </cfif>
	                    <cfset NoDays = #NoDays#+1>
	                </cfif>
	            </cfloop> 
<cfreturn CalcAnticipatedDt />

</cffunction>

<!--- Calls VendWarrList from VendorEnhanced --->
<!--- Development & Production --->
<CFSET Query = "/vendors/enhanced-vendor-remittance/vendor-warrant-list?startDate=#URLEncodedFormat(attributes.startDate)#&endDate=#URLEncodedFormat(attributes.endDate)#&Agency=#URLEncodedFormat(Agency)#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#URLEncodedFormat(AscDesc)#&ContSel=#URLEncodedFormat(ContSel)#&ContAgcySel=#URLEncodedFormat(Agency)#&InvSel=#URLEncodedFormat(InvSel)#&FY=#URLEncodedFormat(FY)#&Status=#URLEncodedFormat(Status)#&Mode=#URLEncodedFormat(Mode)#&max=#max#&">
<CFSET QueryParams = "startDate=#URLEncodedFormat(attributes.startDate)#&endDate=#URLEncodedFormat(attributes.endDate)#&Agency=#URLEncodedFormat(Agency)#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#URLEncodedFormat(AscDesc)#&ContSel=#URLEncodedFormat(ContSel)#&ContAgcySel=#URLEncodedFormat(Agency)#&InvSel=#URLEncodedFormat(InvSel)#&FY=#URLEncodedFormat(FY)#&Status=#URLEncodedFormat(Status)#&Mode=#URLEncodedFormat(Mode)#&max=#max#&">
<cfparam NAME="form.StartDate" DEFAULT="">

<cfif not findNoCase(attributes.Startdate, "")>
	<cfoutput>
	<div class="text-center"><p id="instructions2">Warrants listed have Record Dates between <B>#DateFormat(attributes.StartDate, 'mm-dd-yy')# </B>and <B>#Dateformat(attributes.EndDate, 'mm-dd-yy')#</B>.</P></div>
  	</cfoutput>
</cfif>

<div class="clearfix marginb5">
	<div class="pull-left">
	<cfif isdefined("Results")>
	  <CFINCLUDE TEMPLATE="PrevNext.cfm">
	</cfif>
	</div>
	<div class="pull-right text-center">
			<!--- Calls Download in VendorEnhanced --->
            <!--- Development & Production --->
            <cfform method="post" action="/vendors/enhanced-vendor-remittance/download/?Mode=Summ&ValUser=True&SpreadsheetStartRow=#SpreadsheetStartRow#&SpreadsheetNewRow=#SpreadsheetNewRow#">

            <cfinput type="hidden" name="query" value="#query#">
            <cfinput type="hidden" name="startDate" value="#startDate#">
            <cfinput type="hidden" name="endDate" value="#endDate#">
            <cfinput type="hidden" name="Agency" value="#Agency#">
            <cfinput type="hidden" name="SortBy" value="#UrlEncodedFormat('#Sortby#')#">
            <cfinput type="hidden" name="AscDesc" value="#AscDesc#">
            <cfinput type="hidden" name="ContSel" value="#ContSel#">
            <cfinput type="hidden" name="ContAgcySel" value="#Agency#">
            <cfinput type="hidden" name="InvSel" value="#InvSel#">
            <cfinput type="hidden" name="FY" value="#FY#">
            <cfinput type="hidden" name="Status" value="#Status#">
            <cfinput type="hidden" name="max" value="#max#">

            <!---<CFINCLUDE TEMPLATE="PrevNextSpreadsheet.cfm">--->
            <cfinput type="submit" name="submit"  id="Download" value="Download to Excel" class="small-btn"> <a style="cursor:help;" href="javascript:makeRemote('EnhancedDownloadHelp');"><img src="/Comptroller/images/button_question.gif" alt="Help" border="0" /></a>

            </cfform>
	</div>
</div>

<div name="FormWrapper" id="FormWrapper">
    <div class="table-responsive">
<TABLE class="table table-striped vendor-table">
    <thead>
<Tr>
<th class="text-center" id="WarrantNo"><A HREF="javascript: makeNewRemote('Warrant')"  TITLE="This is the Comptroller's internal numbering system for warrants. An EFT Payment is a seven digit incremental number " STYLE="cursor:help">Warrant/EFT#</a></th>
<th class="text-center" id="AddrInd"><A HREF="javascript:makeNewRemote('AddrInd')"  style="cursor:help" CLASS="hotsub" title="The Address Indicator represents the address provided by the vouchering Agency for this payment." style="cursor:help">Addr Ind</a></th>
<th class="text-center" id="ZipCode"><A HREF="javascript: makeNewRemote('ZipCode')" TITLE="This is the location of the mailing address the warrant was sent." STYLE="cursor:help">Zip Code</a></th>
<th class="text-center" id="IssueDate"><A HREF="javascript: makeRemote('IssueDate')" TITLE="This is the date the Comptroller's Office processed the payment." STYLE="cursor:help">Issue Date</A></th>
<th class="text-right" id="Amount"><A HREF="javascript: makeNewRemote('Amount')" TITLE="This is the total payment amount" STYLE="cursor:help">Payment Amount</A></th>
<th class="text-right" id="VNum"><A HREF="javascript: makeNewRemote('VNum')" TITLE="This is the document number assigned by the agency requesting payment." STYLE="cursor:help">Voucher Number</A></th>
<th class="text-center" id="PaidDate"><A HREF="javascript: makeNewRemote('PaidDate')" TITLE="The Paid Date represents the date that the warrant cleared the bank." STYLE="cursor:help">Paid Date</A></th>
</Tr>
</thead>
<cfif isdefined("Results")>
	<CFOUTPUT QUERY="Results" STARTROW="#StartRow#" MAXROWS="#Max#">

    <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
    <TD ALIGN="CENTER" id="WarrantNo2">
		<!--- Calls VendWarrDetl from VendorEnhanced --->
        <A HREF="/vendors/enhanced-vendor-remittance/vendor-warrant-detail?Warrant=#URLEncodedFormat(TRANSACTION_NUMBER)#&FY=#URLEncodedFormat(FY)#&Accept_date=#URLEncodedFormat(RECORD_DATE)#&Agency=#URLEncodedFormat(Agency)#&Status=#URLEncodedFormat(Status)#&startDate=#URLEncodedFormat(startDate)#&EndDate=#URLEncodedFormat(EndDate)#&Sortby=#URLEncodedFormat(Sortby)#&AscDesc=#URLEncodedFormat(AscDesc)#&ContSel=#URLEncodedFormat(ContSel)#&ContAgcySel=#URLEncodedFormat(Agency)#&InvSel=#URLEncodedFormat(InvSel)#&Mode=#URLEncodedFormat(Mode)#&max=#max#&StartRow=#StartRow#" CLASS="hotsub" id="WarrantDetail"> #TRANSACTION_NUMBER#</A>
	</TD>
    <TD ALIGN="CENTER" id="AddrInd2">#Addr_Ind#</TD>
    <TD ALIGN="CENTER" id="ZipCode2">#ZIP_CODE#</TD>
    <TD ALIGN="CENTER" id="IssueDate2">#DateFormat(RECORD_DATE,"mm/dd/yy")#</TD>
    <TD ALIGN="right" id="Amount2">#DollarFormat(TOT_WARRANT_AMT)#</TD>
    <TD ALIGN="right" id="VNum2">#VNumber#</TD>
    <TD ALIGN="CENTER" id="PaidDate2">
     <cfif  mid(TRANSACTION_NUMBER,1,1) EQ "A">
     	#DateFormat(PAID_DATE,"mm/dd/yy")#
      <cfelseif findNoCase(warrant_Status, "p")>
       #DateFormat(PAID_DATE,"mm/dd/yy")#
      <cfelse>
        #DateFormat(getSchedulePaymentDate(RECORD_DATE),"mm/dd/yyyy")#
      </cfif>
     
    </TD>
    </TR>

    </CFOUTPUT>
</cfif>
</TABLE>
</div>
<!--- Production --->
<div class="text-center"><p>Click <cfoutput><a href="http://illinoiscomptroller.gov/vendors/enhanced-vendor-remittance/instructions/" target="_new">
here</A></cfoutput> for assistance with this screen.</p></DIV>
</div>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>


<script>
$('#First').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the first set of warrant records."
	});
$('#Next').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the next set of warrant records."
	});
$('#Previous').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the previous set of warrant records."
	});
$('#Last').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the last set of warrant records."
	});
$('#FirstSpreadsheet').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the first set of warrant records to export to an Excel Spreadsheet."
	});
$('#NextSpreadsheet').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the next set of warrant records to export to an Excel Spreadsheet."
	});
$('#PreviousSpreadsheet').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the previous set of warrant records to export to an Excel Spreadsheet."
	});
$('#LastSpreadsheet').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the last set of warrant records to export to an Excel Spreadsheet."
	});
$('#Download').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to download the warrant records into an Excel Spreadsheet."
	});

	$('#WarrantDetail').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to see the detail information regarding the Warrant."
	});
<!---
	$('#WarrantNo').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the Comptroller's internal numbering system for warrants. An EFT Payment is a seven digit incremental number."
	});
	$('#AddrInd').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The Address Indicator represents the address provided by the vouchering Agency for this payment."
	});
	$('#ZipCode').tooltip({
            'show': false,
                'placement': 'top',
                'title': "This is the location of the mailing address the warrant was sent."
        });
	$('#IssueDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the date the Comptroller's Office processed the payment."
	});
	$('#Amount').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the total payment amount."
	});
	$('#VNum').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the document number assigned by the agency requesting payment."
	});
	$('#PaidDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The Paid Date represents the date that the warrant cleared the bank."
	});

	--->
</script>
<!---
</BODY>
</HTML>
--->
