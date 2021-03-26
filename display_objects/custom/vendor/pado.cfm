<!---
  	Modified Date: 09-03-19
	Modified By: Raghu Bhonnam
	Description: SR19115 Updated Vendor Name for Payments Issued Page.  
--->

<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">


<cfif isDefined("session.TheVendTin")>
 <cfset vendTIN = Decrypt(session.TheVendTin,"ITBG111")>
</cfif>
<CFSET VendTin = NUMBERFORMAT(VendTin, '000000000')>

<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->
<CFIF IsDefined ("form.vendorName")>
 <CFSET vendorName = form.vendorName>
<cfelseif IsDefined ("URL.vendorName")>
 <CFSET vendorName = URL.vendorName>
</CFIF>

<div class="col-sm-12">Download Options</div>
<div name="FormWrapper" id="FormWrapper" class="col-sm-12">
<cfform action="/vendors/vendor-payments-new/download-pending-payments/?vendorName=#vendorName#" method="post" name="download_form" id="download_form">
<div class="col-sm-12"><p id="Instructions">In addition to downloading the data found on this screen, also download:</p></div>
<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->

<ul style="list-style-type: none;">
    <li><cfinput type="checkbox" name="PVTX"> Payment Voucher Text</li>
    <li><cfinput type="checkbox" name="LineDetails"> Accounting Line Details</li>
</ul>

<!--- Blowing up at this loop...removed since I don't know what it does anyways....must have been added by consultants --->
<!---
<cfloop list="#structKeyList(URL)#" index="key">
	<cfoutput>
    <cfinput type="hidden" name="#key#" value="#url[key]#">
    </cfoutput>
</cfloop>
--->
<input type="hidden" name="mode" value="mode" />
<div align="center">
	<input type="submit" name="btn_download" value="Download to Excel" style="color: ##FFFFFF;
		background-color: #D2322D; <!---##647BA8;--->"
		onclick="
			document.download_form.btn_download.disabled=true;
			document.download_form.mode.name = 'post';
			document.download_form.btn_download.value='Downloading - Please Wait';
			document.download_form.onsubmit();
			document.download_form.submit();
			">
</div>

</cfform>
</div>
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!---<script src="/comptroller/jquery/jquery.js"></script>--->
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>

<!---</body></html>--->