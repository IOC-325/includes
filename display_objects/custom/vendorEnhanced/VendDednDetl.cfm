<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">
    

<!---
	Created Date: 10-14-14
	Created By: Gary Ashbaugh
	
	Description: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

--->


<SCRIPT LANGUAGE="Javascript">
              
function makeNewRemote(fileName) {
         remote = window.open("","remotewin","width=300,height=110,scrollbars=1");
		 
		 // Development
		 //remote.location.href = "http://iw.ioc-sql-dev1.ioc.com/Vendor/"+fileName+".cfm";
		 
		 // Production 
		 remote.location.href = "https://illinoiscomptroller.gov/Vendor/"+fileName+".cfm";
         if (remote.opener == null) remote.opener = window; 
         	remote.opener.name = "opener";
         }
		 
         //-->

</SCRIPT>

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<CFIF IsDefined ("form.Work_Date")>
 <CFSET Work_Date = form.Work_Date>
<cfelseif IsDefined ("URL.Work_Date")>
 <CFSET Work_Date = URL.Work_Date>
</CFIF>

<CFIF IsDefined ("form.Run_No")>
 <CFSET Run_No = form.Run_No>
<cfelseif IsDefined ("URL.Run_No")>
 <CFSET Run_No = URL.Run_No>
</CFIF>

<CFIF IsDefined ("form.MOSTRECENT")>
 <CFSET MOSTRECENT = form.MOSTRECENT>
<cfelseif IsDefined ("URL.MOSTRECENT")>
 <CFSET MOSTRECENT = URL.MOSTRECENT>
</CFIF>

<CFIF IsDefined ("form.MOSTRECENTDATE")>
 <CFSET MOSTRECENTDATE = form.MOSTRECENTDATE>
<cfelseif IsDefined ("URL.MOSTRECENTDATE")>
 <CFSET MOSTRECENTDATE = URL.MOSTRECENTDATE>
</CFIF> 

<CFIF IsDefined ("form.LASTRECENTDATE")>
 <CFSET LASTRECENTDATE = form.LASTRECENTDATE>
<cfelseif IsDefined ("URL.LASTRECENTDATE")>
 <CFSET LASTRECENTDATE = URL.LASTRECENTDATE>
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
<CFIF IsDefined ("URL.StartRow")>
 <CFSET StartRow = URL.StartRow>
</CFIF>
<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">

<cfinclude template="TmpVendorapplicationSettings.cfm">
<cfif not isdefined("Run_No") or not isdefined("Work_Date") or (not isdefined("Session.VendTIN"))>
	<!--- Calls Index from VendorEnhanced --->
    <!--- Development & Production --->
    <cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif> 
</cfLock>


<cftry>
<cfStoredProc  datasource="Deductions" Procedure="Get_Deduction_Details">
    <cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@Comp_Code" value="#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Actual_Code" value="#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_integer" dbvarname="@Run_No" value="#Run_No#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_date" dbvarname="@Work_Date" value="#DateFormat(Work_Date,"mm/dd/yyyy")#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetDeductionDetailsRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetDeductionDetailsRetMsg">
    <cfprocresult name="GetDeductionDetails">
</cfstoredproc>

<cfcatch type="any">
    <div class="alert alert-danger" align="left"><b>Sorry, but it appears that the site is not available at this time...please try back later!</b></div>
</cfcatch>
</cftry>

<cfset TryAntDt = "True">
<CFSET Area="Warrants">

<CFINCLUDE TEMPLATE="VendHeader.cfm">
<div class="marginb20"><cfoutput><a href="/vendors/enhanced-vendor-remittance/deduction-list/?Run_No=#URLEncodedFormat(Run_No)#&MostRecent=#MostRecent#&MostRecentDate=#DateFormat(MostRecentDate,"mm/dd/yyyy")#&LastRecentDate=#DateFormat(LastRecentDate,"mm/dd/yyyy")#&startDate=#startDate#&endDate=#endDate#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&Work_Date=#URLEncodedFormat(DateFOrmat(Work_Date,"mm/dd/yyyy"))#&StartRow=#StartRow#" id="ReturnBack"><i class="glyphicon glyphicon-share-alt"></i> Return Back</a></cfoutput></div>

<div name="FormWrapper" id="FormWrapper">
<div  class="table-responsive">
    <TABLE class="table table-striped table-bordered vendor-table">
	<CFOUTPUT QUERY="GetDeductionDetails">
        <thead>
	<TR id="darkcolor">
		<TH ALIGN="LEFT" COLSPAN="6" id="SocSecNo2">Soc Sec Number: XXX-XX-#Id#</TH>
	</TR>
    </thead>
	<TR id="lightcolor">
		<!---<TD ALIGN="RIGHT" id="Contract4"><A HREF="javascript: makeNewRemote('GeneratedDate')" TITLE="The Generatd Date is the date..." STYLE="cursor:help">Generated Date: </TD>--->
        <TD ALIGN="RIGHT" id="Contract4"><b>Generated Date</b></TD>
		<TD ALIGN="RIGHT" id="Contract4">#DateFormat(Work_Date, "mm/dd/yyyy")#</TD>
		<!---<TD ALIGN="RIGHT" id="Contract4"><A HREF="javascript: makeNewRemote('AnticipatedDirDepDate')" TITLE="The Anticipated Direct Deposit Date is the date ..." STYLE="cursor:help">Anticipated Direct Deposit Date:</A></TD>--->
        <TD ALIGN="RIGHT" id="Contract4"><b>Anticipated Direct Deposit Date</b></TD>
		<TD ALIGN="RIGHT" width="10" id="Contract4">#DateFormat(Issue_DATE,"mm/dd/yy")#</TD>
        <td colspan="2">&nbsp;</td>
	</TR>
    <!--- Here the section I changed --->
    <TR id="lightcolor">
		<TD ALIGN="RIGHT" id="Contract4"><b>Name</b></TD>
		<TD ALIGN="RIGHT" id="Contract4">#Employee_Name#</TD>
		<TD ALIGN="RIGHT" id="Contract4"><b>Pay Period Beginning Date</b></TD>
		<TD ALIGN="RIGHT" id="Contract4">#DateFormat(PP_Beginning_Date,"mm/dd/yyyy")#</TD>
		<TD ALIGN="RIGHT" id="Contract4"><b>Pay Period Ending Date</b></TD>
        <td id="Contract4">#DateFormat(PP_Ending_Date,"mm/dd/yyyy")#</td>
	</TR>
    <TR id="lightcolor">
		<TD ALIGN="RIGHT" id="Contract4"><b>Pay Period Number</b></TD>
		<TD ALIGN="RIGHT" id="Contract4">#Pay_Period#</TD>
		<TD ALIGN="RIGHT" id="Contract4"><b>Deduction Amount</b></TD>
		<TD ALIGN="RIGHT" id="Contract4"><cfif Deduction_Amount lt 0><p class="text-danger" align="left"><b>$#NumberFormat(Deduction_Amount,"9,999,999.99")#</b></p><cfelse><p class="bold nomargin">$#NumberFormat(Deduction_Amount,"9,999,999.99")#</p></cfif></TD>
		<TD ALIGN="RIGHT" id="Contract4"><b>Payroll Code</b></TD>
        <td id="Contract4">#Pay_Code#</td>
	</TR>
    <TR id="lightcolor">
		<TD ALIGN="RIGHT" id="Contract4"><b>Deduction Type</b></TD>
		<TD ALIGN="RIGHT" id="Contract4">#Deduction_Type#</TD>
		<TD ALIGN="RIGHT" id="Contract4"><b>Law Code</b></TD>
		<TD ALIGN="RIGHT" id="Contract4">#Law_Code#</TD>
		<TD ALIGN="RIGHT" id="Contract4"><b>Fund</b></TD>
        <td id="Contract4">#Fund#</td>
	</TR>
    <TR id="lightcolor">
		<TD ALIGN="RIGHT" id="Contract4"><b>Deposit Warrant/Trace</b></TD>
		<TD ALIGN="RIGHT" id="Warrant"><cfif trim(Trailer_Warrant_Number) is not "" and trim(Trailer_Warrant_Trace) is not ""><a href="/vendors/enhanced-vendor-remittance/deduction-list-by-warrant-no/?startDate=#startDate#&endDate=#endDate#&MostRecent=#MostRecent#&MostRecentDate=#DateFormat(MostRecentDate,"mm/dd/yyyy")#&LastRecentDate=#DateFormat(LastRecentDate,"mm/dd/yyyy")#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&Warrant=#Trailer_Warrant_Number#&Trace=#Trailer_Warrant_Trace#" TITLE="Click here to see the list of deductions associated with this warrant/trace number."><b>#Trailer_Warrant_Number#-#Trailer_Warrant_Trace#</b></a><cfelse>#Trailer_Warrant_Number#-#Trailer_Warrant_Trace#</cfif></TD>
		<TD ALIGN="RIGHT" id="Contract4"><b>Total Deposit Amount</b></TD>
		<TD ALIGN="RIGHT" valign="middle" id="Contract4"><cfif Trailer_Warrant_Amount lt 0><p class="text-danger" align="left"><b>$#NumberFormat(Trailer_Warrant_Amount,"999,999,999,999,999.99")#</b></p><cfelse><p class="bold nomargin">$#NumberFormat(Trailer_Warrant_Amount,"999,999,999,999,999.99")#</p></cfif></TD>
		<TD id="Contract4" ALIGN="RIGHT"><b>Voucher Number</b></TD>
        <td id="Contract4">#Voucher_Number#</td>
	</TR>
	</CFOUTPUT>
</TABLE>
</div>
    <!--- Production --->
    <div class="text-center"><p>Click <cfoutput><a href="https://IllinoisComptroller.Gov/vendors/enhanced-vendor-remittance/instructions/" target="_new">
    here</A></cfoutput> for assistance with this screen.</p></div>

</div>
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    
 <script>
	$('#ReturnBack').tooltip({
		'show': false,
			'placement':  'top',
			'title': "Click here to return back to the previous deduction listing."
	});<!---
	$('#Warrant').tooltip({
		'show': false,
			'placement':  'top',
			'title': "Click here to see a listing of all deductions associated with this Warrant/Trace number."
	});
 


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
--->	
</script>
<!---</BODY>
</HTML>--->

