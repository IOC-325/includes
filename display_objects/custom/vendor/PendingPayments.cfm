<!---
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
       remote = window.open("/vendors/vendor-payments-new/advanced-pending-payments-download-option/?"+parms,"remotewin","width=460,height=200,scrollbars=1,addressbar=yes");
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

<body onLoad="ChangeCoordinator();">
<cfparam name="form.captcha" default="">
<cfparam name="form.captchaAnswer" default="">
<cfparam name="form.Mode" default="">
<cfparam name="form.Email" default="">
<cfparam name="form.FirstName" default="">
<cfparam name="form.LastName" default="">
<cfparam name="form.NotificationType" default="None">
<cfparam name="form.MobileProvider" default="None">
<cfparam name="form.MobilePhone" default="">
<cfparam name="form.VendTIN" default="">
<cfparam name="form.VendTINName" default="">
<cfparam name="ErrorNo" default="">
<cfset ErrorStruct = StructNew()>
<cfset ErrorNo = "">
<cfparam name="SpreadsheetMax" default="1000">
<cfparam NAME="url.SpreadsheetStartRow" DEFAULT="1">
<cfparam NAME="url.SpreadsheetNewRow" DEFAULT="1000">


<CFIF IsDefined ("url.SpreadsheetStartRow")>
 <CFSET SpreadsheetStartRow = URL.SpreadsheetStartRow>
<cfelse>
 <cfset SpreadsheetStartRow="1"> 
</CFIF>

<CFIF IsDefined ("url.SpreadsheetNewRow")>
 <CFSET SpreadsheetNewRow = URL.SpreadsheetNewRow>
<cfelse>
 <cfset SpreadsheetNewRow="1000">  
</CFIF>


<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">

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

<!--- Code change on 8/23/19 by Raghu Bhonnam for SR19115 --->
<CFIF IsDefined ("form.vendorName")>
 <CFSET vendorName = form.vendorName>
<cfelseif IsDefined ("URL.vendorName")>
 <CFSET vendorName = URL.vendorName>
</CFIF>
<!--- Code change on 8/23/19 by Raghu Bhonnam for SR19115 --->

<CFINCLUDE TEMPLATE="VendHeader.cfm">
<cfparam name="max" default="20">

<cfif isDefined("session.TheVendTin")>
 <cfset vendTIN = Decrypt(session.TheVendTin,"ITBG111")>
</cfif>

<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->
<CFSET QueryParams = "SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&vendorName=#vendorName#&Max=#Max#">  
<CFSET Query = "/vendors/vendor-payments-new/pending-payments/?"> 
<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->

<cfinclude template="vendorPendingSQL.cfm">

<div class="clearfix marginb5">

    <cfif Results.recordcount gt 1000>  
            <div class="alert alert-warning" style="margin-top: 20px;" >Please note that if there are over 1000 rows of data in your download, it is possible that the file size is too large do download, and your file may timeout. We are working on a solution to reduce the downloads to a more manageable size. For more help, <a style="cursor:help;" href="javascript:makeRemote('DownloadHelp');"> click here.</a> </div>
    </cfif>

	<span class="pull-left">
	<CFINCLUDE TEMPLATE="PrevNext.cfm">
	</span>
	<span class="pull-right">
        <cfform method="post" action="/vendors/vendor-payments-new/download-pending-payments/?SpreadsheetStartRow=#SpreadsheetStartRow#&SpreadsheetNewRow=#SpreadsheetNewRow#">

            <cfinput type="hidden" name="query" value="#query#">
            <cfinput type="hidden" name="max" value="#max#">
            <!--- Code change on 8/23/19 by Raghu Bhonnam for SR19115 starts here--->
            <cfinput type="hidden" name="vendorName" value="#VendorName#">
            <!--- Code change on 8/23/19 by Raghu Bhonnam for SR19115 ends here--->

            <input type="submit" name="submit" value="Download to Excel" class="small-btn" id="Download"> <a style="cursor:help;" href="javascript:makeRemote('DownloadHelp');"><img src="/Comptroller/images/button_question.gif" alt="Help" border="0" /></a>
            <cfoutput>
            <br /><a href="javascript:ADOWindow('#UrlEncodedFOrmat(QueryParams)#');" ><!---<a href="javascript:ADOWindow('1');" >--->Advanced Download Options</a><br><cfif results.recordcount gt 1000><a href="javascript:ADOWindow('#UrlEncodedFOrmat(QueryParams)#');">Download Notice!</a></cfif>
            </cfoutput>
            </cfform>
	</span>
</div>


<div name="FormWrapper" id="FormWrapper">
    <div  class="table-responsive">
  <TABLE class="table table-striped vendor-table">
        <thead>
   <tr id="darkcolor">
    <th class="text-center" id="Fund3">Voucher Number</th>
    <th class="text-center" id="Agency5">Agency</th>
    <th class="text-right" id="Agency5">Voucher Date</th>
    <th class="text-right" id="Agency5">Voucher Amount</th>
    <!--- <TD ALIGN="RIGHT" COLSPAN="1" id="Agency5">Scheduled Payment Date</TD> --->
   </tr>
   </thead>
   <CFOUTPUT QUERY="Results" STARTROW="#StartRow#" MAXROWS="#Max#">
    <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
            <TD ALIGN="CENTER" id="Fund4">
            	<a HREF="/vendors/vendor-payments-new/pending-payment-details/?Agency=#Agency#&TranNum=#Voucher_Number#&Max=#URLEncodedFormat(Max)#&StartRow=#StartRow#" id="PendingPaymentsDetails">
            	#Voucher_Number#</a></TD>
            <TD ALIGN="center" id="Amount4">#Agency# - #Name#</TD>
            <TD ALIGN="RIGHT" id="ToDate4">#DateFormat(Voucher_Date,"mm/dd/yyyy")#&nbsp;</TD>
            <TD ALIGN="RIGHT" id="Amount4">#dOLLarFormat(Voucher_Amt)#</TD>
            <!--- <TD COLSPAN="1" ALIGN="RIGHT" id="ToDate4">#DateFormat(SCHED_PYMNT_DATE,"mm/dd/yyyy")#&nbsp;</TD> --->
    </TR>
   </CFOUTPUT>
  </TABLE>
  </div>
    <div class="text-center"><p>Click <cfoutput><a href="/vendors/vendor-payments-new/vendor-guide/" target="_new">
here</A></cfoutput> for assistance with this screen.</p></div>

</div>  


