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
    remote = window.open("https://illinoiscomptroller.gov/vendors/enhanced-vendor-remittance/about-download-options?"+parms,"remotewin","width=460,height=200,scrollbars=1,addressbar=yes");
    
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
<cfparam name="SpreadsheetMax" default="2000">
<cfparam name="ErrorNo" default="">
<cfset ErrorStruct = StructNew()>
<cfset ErrorNo = "">
<cfparam name="SpreadsheetMax" default="2000">
<cfparam NAME="url.SpreadsheetStartRow" DEFAULT="1">
<cfparam NAME="url.SpreadsheetNewRow" DEFAULT="2000">


<CFIF IsDefined ("url.SpreadsheetStartRow")>
 <CFSET SpreadsheetStartRow = URL.SpreadsheetStartRow>
<cfelse>
 <cfset SpreadsheetStartRow="1"> 
</CFIF>

<CFIF IsDefined ("url.SpreadsheetNewRow")>
 <CFSET SpreadsheetNewRow = URL.SpreadsheetNewRow>
<cfelse>
 <cfset SpreadsheetNewRow="2000">  
</CFIF>

<cfif isDefined("session.VendTIN")>
 <cfset vendTIN = decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)>
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

<CFINCLUDE TEMPLATE="VendHeader.cfm">
<cfparam name="Max" default="20">

<cfif isDefined("session.VendTIN")>
 <cfset vendTIN = decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)>
</cfif>

<CFSET QueryParams = "SVendTin=#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#">  
<CFSET Query = "/vendors/enhanced-vendor-remittance/pending-payments/?"> 
<cfinclude template="vendorPendingSQL.cfm">

<div class="clearfix marginb5">

    <cfif Results.recordcount gt 2000>  
            <div class="alert alert-warning">Please note that if there are over 2000 rows of data in your download, it is possible that the file size is too large do download, and your file may timeout. We are working on a solution to reduce the downloads to a more manageable size. For more help, <a style="cursor:help;" href="javascript:makeRemote('DownloadHelp');"> click here.</a> </div>
    </cfif>
      
	<div class="pull-left">
	    <CFINCLUDE TEMPLATE="PrevNext.cfm">
	</div>
	<div class="pull-right text-center">
        <cfform method="post" action="/vendors/enhanced-vendor-remittance/download-pending-payments/?SpreadsheetStartRow=#SpreadsheetStartRow#&SpreadsheetNewRow=#SpreadsheetNewRow#">

            <cfinput type="hidden" name="query" value="#query#">
            <cfinput type="hidden" name="max" value="#max#">

            <!---<CFINCLUDE TEMPLATE="PrevNext.cfm">--->

            <cfinput type="submit" name="submit"  id="Download" value="Download to Excel" class="small-btn"> <a style="cursor:help;" href="javascript:makeRemote('EnhancedDownloadHelp');"><img src="/Comptroller/images/button_question.gif" alt="Help" border="0" /></a>
            </cfform>
	</div>
</div>


<div name="FormWrapper" id="FormWrapper">
    <div class="table-responsive">
  <TABLE class="table table-striped vendor-table">
    <thead>
   <TR id="darkcolor">
    <th class="text-center" id="Fund3">Voucher Number</th>
    <th class="text-center" id="Agency5">Agency</th>
    <th class="text-right" id="Agency5">Voucher Date</th>
    <th class="text-right" id="Agency5">Voucher Amount</th>
<!---     <TD ALIGN="RIGHT" COLSPAN="1" id="Agency5">Scheduled Payment Date</TD> --->
   </TR>
   </thead>
   <CFOUTPUT QUERY="Results" STARTROW="#StartRow#" MAXROWS="#Max#">
    <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
            <TD ALIGN="CENTER" id="Fund4">
            	<a HREF="/vendors/enhanced-vendor-remittance/pending-payment-details/?Agency=#Agency#&TranNum=#Voucher_Number#&StartRow=#StartRow#&Max=#URLEncodedFormat(Max)#" id="PendingPaymentsDetails">
            	#Voucher_Number#</a></TD>
            <TD ALIGN="center" id="Amount4">#Agency# - #Name#</TD>
            <TD ALIGN="RIGHT" id="ToDate4">#DateFormat(Voucher_Date,"mm/dd/yyyy")#&nbsp;</TD>
            <TD ALIGN="RIGHT" id="Amount4">#dOLLarFormat(Voucher_Amt)#</TD>
            <!--- <TD COLSPAN="1" ALIGN="RIGHT" id="ToDate4">#DateFormat(SCHED_PYMNT_DATE,"mm/dd/yyyy")#&nbsp;</TD> --->
    </TR>
   </CFOUTPUT>
  </TABLE>
  </div>
<div class="text-center"><p>Click <cfoutput><a href="http://illinoiscomptroller.gov/vendors/enhanced-vendor-remittance/instructions/" target="_new">
here</A></cfoutput> for assistance with this screen.</p></div>
</div> 


