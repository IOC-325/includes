<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

    <link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">
<!---

	WH023 - 10/03/97
 	WH012 - 10/14/97
 	WH038 - 10/21/97
 	WH039 - 10/27/97
 	WH00196 - 7/18/00

	Modified Date: 5-30-00
	Modified By: Andrew Peterson
	Modifications made: Filter by date range if date filter invoked per 01052

 	WH00178
	Developer: ASP
	Date Completed: 7/11/00

	Modified Date: 11-21-00
	Modified By: Gary Ashbaugh
	Modifications Made: Add redirect when VendTIN is not defined

	Modified Date : 12-13-01
	Modified By : Andrew Peterson
	Modification Number : 01341
	Modifications Made : If statement added to filter by date - fix for 01052

   	Modified Date : 12/18/01
   	Modified By : Andrew Peterson
   	Modification Number : 01284
   	Modifications Made : Modify Query to include new fields

   	Modified Date : 12/11/02
   	Modified By : Andrew Peterson
   	Modification Number : n/a
   	Modifications Made : Modify Query to exclude duplicates. Carl had suggested a modification in the code in late November but the elimination of the group by clause caused duplicates. Added a DISTINCT statment in first conditional of query to eliminate this. Tested on the tins found in tins.cfm and moved to production.

   	Modified Date : 5/3/07
   	Modified By : Andrew Peterson
   	Modification Number : n/a
   	Modifications Made : Changed link to IssueDate.cfm to be on wh server.

   	Modified Date : 6/27/07
   	Modified By : Andrew Peterson
   	Modification Number : n/a
   	Modifications Made : Changed where clause to point to line table's vendor tin instead of header table's

	SR 8103
	Date Migrated : 12/16/08
	Migrated By : ASP

	Modified Date: 10-14-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

	Description:  Allows the users to view their Vendor Warrants

	Modified Date: 08-23-19
	Modified By: Raghu Bhonnam
	Description: SR19115 Updated Vendor Name for Payments Issued Page.  
--->

<SCRIPT LANGUAGE="Javascript">
<!--
function makeRemote(fileName) {
         remote = window.open("","remotewin","width=300,height=110,scrollbars=1");
         remote.location.href = "http://www.ioc.state.il.us/Vendor/"+fileName+".cfm";
             if (remote.opener == null) remote.opener = window;
         remote.opener.name = "opener";
         }

<cfoutput>
function ADOWindow(parms) {
	//remote = window.open("PaidDate.cfm","remotewin","width=460,height=200,scrollbars=1,addressbar=yes");
       remote = window.open("/vendors/vendor-payments-new/advanced-download-option/?"+parms,"remotewin","width=460,height=200,scrollbars=1,addressbar=yes");
         if (remote.opener == null) remote.opener = window;
         remote.opener.name = "opener";
         }
</cfoutput>


function makeNewRemote(fileName) {
         remote = window.open("","remotewin","width=300,height=110,scrollbars=1");
         remote.location.href = "http://www.ioc.state.il.us/Vendor/"+fileName+".cfm";
             if (remote.opener == null) remote.opener = window;
         remote.opener.name = "opener";
         }

         //-->

</SCRIPT>

<cf_formURL2attributes>

<!--- Code change by RK for SR 17070 starts here --->
<cfoutput>

<CFIF IsDefined ("form.FY")>
 <CFSET FY = form.FY>
<cfelseif IsDefined ("URL.FY")>
 <CFSET FY = URL.FY>
</CFIF>

<CFIF IsDefined ("form.Contsel")>
 <CFSET Contsel = form.Contsel>
<cfelseif IsDefined ("URL.Contsel")>
 <CFSET Contsel = URL.Contsel>
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

<CFIF IsDefined ("form.INVSEL")>
 <CFSET INVSEL = form.INVSEL>
<cfelseif IsDefined ("URL.INVSEL")>
 <CFSET INVSEL = URL.INVSEL>
 <cfelse>
 <CFSET INVSEL = "">
</CFIF>

<CFIF IsDefined ("form.Startdate")>
 <CFSET attributes.Startdate = form.Startdate>
<cfelseif IsDefined ("URL.INVSEL")>
 <CFSET attributes.Startdate = URL.Startdate>
 <cfelse>
 <CFSET attributes.Startdate = "">
</CFIF>

<CFIF IsDefined ("form.EndDate")>
 <CFSET attributes.EndDate = form.EndDate>
<cfelseif IsDefined ("URL.INVSEL")>
 <CFSET attributes.EndDate = URL.EndDate>
 <cfelse>
 <CFSET attributes.EndDate = "">
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



<cfif not isDefined("Agency") or not isdefined("Status") or not IsDefined ("session.TheVendTin")>
	<cflocation url="/vendors?TimedOut=True" addtoken="No">
</cfif>

<cfif isDefined("session.TheVendTin")>
 <cfset vendTIN = Decrypt(session.TheVendTin,"ITBG111")>
</cfif>
<CFSET VendTin = NUMBERFORMAT(VendTin, '000000000')>
<!--- <cfif len(VendTiN) eq 8>
	<cfSet VendTin="0#VendTIN#">
<cfelseif len(VendTiN) eq 7>
	<cfSet VendTin="00#VendTIN#">
<cfelse>
	<cfSet VendTin="#VendTIN#">
</cfif>
 --->
<cfinclude template="vendorSQL.cfm">

<CFHeader name="Cache-control" value="public">

<CFSET Area="Warrants">
<CFINCLUDE TEMPLATE="VendHeader.cfm">
<!---<div class="col-sm-12"><h2><center>Warrant List</center></h2></div>--->
<cfparam name="max" default="">

<cfparam NAME="attributes.StartDate" DEFAULT="">
<cfparam NAME="attributes.EndDate" DEFAULT="">
<cfoutput>

<cfset vendorNameset = #vendorName#>
<cfset vendorName = #REPLACE(vendorName,"&", " ","All")#>  
<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115  --->
<!--- Per SR14163 use Agency instead ContAgcySel except for All then use nothing --->
<cfif Agency is not "All"><!---&ContAgcySel=#ContAgcySel#--->
	<CFSET Query = "/vendors/vendor-payments-new/vendor-warrant-list?startDate=#attributes.Startdate#&endDate=#attributes.endDate#&Agency=#Agency#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcySel=#Agency#&Mode=WarrList&InvSel=#InvSel#&FY=#FY#&Status=#Status#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&vendorName=#vendorName#&Max=#Max#&VENDTINNAME=#REPLACE(VENDTINNAME,"&", " ","All")#&">
<cfelse><!---&ContAgcySel=#ContAgcySel#--->
	<CFSET Query = "/vendors/vendor-payments-new/vendor-warrant-list?startDate=#attributes.Startdate#&endDate=#attributes.endDate#&Agency=#Agency#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcySel=&Mode=WarrList&InvSel=#InvSel#&FY=#FY#&Status=#Status#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&vendorName=#vendorName#&Max=#Max#&VENDTINNAME=#REPLACE(VENDTINNAME,"&", " ","All")#&">
</cfif>
    <!---<CFSET QueryParams = "startDate=#startDate#&endDate=#endDate#&Agency=#Agency#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcySel=#ContAgcySel#&InvSel=#InvSel#&FY=#FY#&Status=#Status#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&VENDTINNAME=#VENDTINNAME#&Mode=#Mode#">
--->

<!--- Per SR14163 use Agency instead ContAgcySel except for All then use nothing --->

<Cfif Agency is not "All"><!---&ContAgcySel=#ContAgcySel#--->
	<CFSET QueryParams = "startDate=#attributes.startDate#&endDate=#attributes.endDate#&Agency=#Agency#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcySel=#Agency#&InvSel=#InvSel#&FY=#FY#&Status=#Status#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Mode=WarrList&vendorName=#vendorName#&VENDTINNAME=#REPLACE(VENDTINNAME,"&", " ","All")#&">
<cfelse><!---&ContAgcySel=#ContAgcySel#--->
	<CFSET QueryParams = "startDate=#attributes.startDate#&endDate=#attributes.endDate#&Agency=#Agency#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcySel=&InvSel=#InvSel#&FY=#FY#&Status=#Status#&Mode=WarrList&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&vendorName=#vendorName#&VENDTINNAME=#REPLACE(VENDTINNAME,"&", " ","All")#&">
</Cfif>
<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115  --->
</cfoutput>
<div class="clearfix marginb5">
	<div class="pull-left">
	<CFINCLUDE TEMPLATE="PrevNext.cfm">
	</div>
	<div class="pull-right text-center">
        <cfform method="post" action="/vendors/vendor-payments-new/download/?Mode=WarrList&ValUser=True">

            <cfinput type="hidden" name="query" value="#query#">
            <cfinput type="hidden" name="startDate" value="#attributes.Startdate#">
            <cfinput type="hidden" name="endDate" value="#attributes.endDate#">
            <cfinput type="hidden" name="Agency" value="#Agency#">
            <cfinput type="hidden" name="SortBy" value="#UrlEncodedFormat('#Sortby#')#">
            <cfinput type="hidden" name="AscDesc" value="#AscDesc#">
            <cfinput type="hidden" name="ContSel" value="#ContSel#">
            <cfinput type="hidden" name="max" value="#max#">
            <!--- Removed per SR14163 use Agency instead ContAgcySel except for All then use nothing --->
            <!---<cfinput type="hidden" name="ContAgcySel" value="#ContAgcySel#">--->
            <cfif Agency is not "All">
            	<cfinput type="hidden" name="ContAgcySel" value="#Agency#">
            <cfelse>
            	<cfinput type="hidden" name="ContAgcySel" value="">
           	</cfif>
            <cfinput type="hidden" name="InvSel" value="#InvSel#">
            <cfinput type="hidden" name="FY" value="#FY#">
            <cfinput type="hidden" name="Status" value="#Status#">
            <cfinput type="hidden" name="SVendTin" value="#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#">
            <cfinput type="hidden" name="vendTinName" value="#VendTinName#">
			<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115  --->
			<cfinput type="hidden" name="vendorName" value="#vendorNameset#">   
		<!---	<cfinput type="hidden" name="vendorName" value="#REPLACE(vendorName,"&", " ","All")#">  --->
			<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115  --->
            <cfinput type="hidden" name="Mode" value="WarrList">
            <!---<button name="submit" class="btn btn-danger btn-lg btn-block" id="Download" tabindex="10"> Download to Excel</button>--->
            <input type="submit" name="submit" value="Download to Excel" class="small-btn" id="Download"> <a style="cursor:help;" href="javascript:makeRemote('DownloadHelp');"><img src="/Comptroller/images/button_question.gif" alt="Help" border="0" /></a>
            <cfoutput><!--- This change is not part of any SR 2019-09-03 ASP --->
            <br /><a href="javascript:ADOWindow('#UrlEncodedFOrmat(QueryParams)#');" ><!---<a href="javascript:ADOWindow('1');" >--->Advanced Download Options</a>
            </cfoutput>
            </cfform>
	</div>

</div>

<cfparam NAME="form.StartDate" DEFAULT="">
<cfif not findNoCase(attributes.Startdate, "")>
	<cfoutput>
    <cfif isDate(attributes.StartDate) and isDate(attributes.EndDate)>
       <div class="text-center"><p id="instructions2">Warrants listed have Record Dates between <B>#DateFormat(attributes.StartDate, 'mm-dd-yy')# </B>and <B>#Dateformat(attributes.EndDate, 'mm-dd-yy')#</B>.</p></div>
    </cfif>
    </cfoutput>
</cfif>

<div name="FormWrapper" id="FormWrapper">
<div class="table-responsive">
<table class="table table-striped vendor-table">
    <thead>
<tr>
    <th class="text-center" id="WarrantNo"><A HREF="javascript: makeNewRemote('Warrant')"
                                         TITLE="This is the Comptroller's internal numbering system for warrants. An EFT Payment is a seven digit incremental number "
                                         STYLE="cursor:help">Warrant/EFT#</A></th>
    <th class="text-center" id="AddrInd"><A HREF="javascript:makeNewRemote('AddrInd')" style="cursor:help" CLASS="hotsub"
                                       title="The Address Indicator represents the address provided by the vouchering Agency for this payment."
                                       style="cursor:help">Addr Ind</A></th>
    <th class="text-center" id="ZipCode"><A HREF="javascript: makeNewRemote('ZipCode')"
                                       TITLE="This is the location of the mailing address the warrant was sent."
                                       STYLE="cursor:help">Zip Code</A></th>
    <th class="text-center" id="IssueDate"><A HREF="javascript: makeRemote('IssueDate')"
                                         TITLE="This is the date the Comptroller's Office processed the payment."
                                         STYLE="cursor:help">Issue Date</A></th>
    <th class="text-right" id="Amount"><A HREF="javascript: makeNewRemote('Amount')" TITLE="This is the total payment amount"
                                     STYLE="cursor:help">Payment Amount</A></th>
    <th class="text-right" id="VNum"><A HREF="javascript: makeNewRemote('VNum')"
                                   TITLE="This is the document number assigned by the agency requesting payment."
                                   STYLE="cursor:help">Voucher Number</A></th>
<!---<Td ALIGN="CENTER" id="PaidDate"><A HREF="javascript: makeNewRemote('PaidDate')" TITLE="The Paid Date represents the date that the warrant cleared the bank." STYLE="cursor:help">Paid Date</A></Td>--->
    <th class="text-center" id="PaidDate"><A HREF="javascript: makeNewRemote('PaidDate')"
                                        TITLE="When a payment is issued electronically, the Paid Date is the calendar day the funds are expected to be deposited into the receiving bank account. When a payment is issued as a printed warrant, the Paid Date is the calendar day the payment was cashed and cleared by the Illinois State Treasurer."
                                        STYLE="cursor:help">Paid Date</A></th>
</tr>
</thead>
    <tbody>

	<CFOUTPUT QUERY="Results" STARTROW="#StartRow#" MAXROWS="#max#">
	<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
		<TD ALIGN="CENTER" id="WarrantNo2">
        <!--- Per SR14163 use Agency instead ContAgcySel except for All then use nothing --->
        <cfif Agency is not "All"><!---&ContAgcySel=#ContAgcySel#--->
			<A HREF="/vendors/vendor-payments-new/vendor-warrant-detail?Warrant=#URLEncodedFormat(TRANSACTION_NUMBER)#&FY=#FY#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Accept_date=#RECORD_DATE#&Mode=WarrList&VendTinName=#UrlEncodedFormat(VendTinName)#&Agency=#Agency#&Status=#Status#&startDate=#attributes.startDate#&EndDate=#attributes.EndDate#&Sortby=#Sortby#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcySel=#Agency#&InvSel=#InvSel#&StartRow=#StartRow#&Max=#URLEncodedFormat(max)#" CLASS="hotsub" id="WarrantDetail"> #TRANSACTION_NUMBER#</A>
        <cfelse>
        	<A HREF="/vendors/vendor-payments-new/vendor-warrant-detail?Warrant=#URLEncodedFormat(TRANSACTION_NUMBER)#&FY=#FY#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Accept_date=#RECORD_DATE#&Mode=WarrList&VendTinName=#UrlEncodedFormat(VendTinName)#&Agency=#Agency#&Status=#Status#&startDate=#attributes.startDate#&EndDate=#attributes.EndDate#&Sortby=#Sortby#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcySel=&InvSel=#InvSel#&StartRow=#StartRow#&Max=#URLEncodedFormat(max)#" CLASS="hotsub" id="WarrantDetail"> #TRANSACTION_NUMBER#</A>
        </cfif>
		</TD>
		<TD ALIGN="CENTER" id="AddrInd2">#Addr_Ind#</TD>
		<TD ALIGN="CENTER" id="ZipCode2">#ZIP_CODE#</TD>
		<TD ALIGN="CENTER" id="IssueDate2">#DateFormat(RECORD_DATE,"mm/dd/yy")#</TD>
		<TD ALIGN="right" id="Amount2">#DollarFormat(TOT_WARRANT_AMT)#</TD>
		<TD ALIGN="right" id="VNum2">#VNumber#</TD>
      	<TD ALIGN="CENTER" id="PaidDate2">
      	<!--- Per SR14163 add "Anticipated Direct Deposit Date for "EFT" --->
	  	<cfif results.TRANSACTION_CODE is not "EF">
			<cfif findNoCase(warrant_Status, "p")>
		  		#DateFormat(PAID_DATE,"mm/dd/yy")#
		  	<cfelse>
		  		&nbsp;
		  	</cfif>
       	<cfelse>
       		<!--- Calculate Anticipated Date --->
			<cfset FndAnticipatedDt = "False">
            <cfset NoDays = 0>
            <!--- Add first day --->
			<cfset CalcAnticipatedDt = DateFormat(DateAdd("d",1,Record_Date),"mm/dd/yyyy")>

            <cfloop condition = "FndAnticipatedDt equal False">

                <cfquery name="CheckHoliday" datasource="Common" dbtype="ODBC">
                    SELECT     Holiday
                    FROM         StateHoliday
                    <!---WHERE       Holiday = '#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#'--->
                    WHERE Holiday =<cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateFormat(CalcAnticipatedDt,'mm/dd/yyyy')#">
                </cfquery>

				<cfif DayofWeek(CalcAnticipatedDt) is 7>
                    <!--- Saturday....move to next --->
                    <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                <cfelseif DayofWeek(CalcAnticipatedDt) is 1>
                    <!--- Sunday....re-calculate date to Tuesday --->
                    <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                <cfelseif CheckHoliday.recordcount>
                	<!--- Holiday move to next --->
                	<cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                <cfelse>
                	<cfset NoDays = #NoDays#+1>
                    <cfif NoDays eq 2>
                	<cfset FndAnticipatedDt = "True">
                	<cfelse>
                		<!--- Add another Day --->
                	<cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                	</cfif>
                </cfif>

            </cfloop>

        	#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#
       </cfif>

      </TD>
	</TR>
	</CFOUTPUT>
</tbody>
</table>
</div>
<div class="text-center"><p>Click <cfoutput><a href="/vendors/vendor-payments-new/vendor-guide/" target="_new">
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


