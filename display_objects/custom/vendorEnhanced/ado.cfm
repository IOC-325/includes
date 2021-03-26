<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">


<!---
Modified Date: 4-27-12
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Enhanced Vendor Remittance Site per SR11108 based on the regular site but requiring a UserID/Password
--->


<div class="col-sm-12">Download Options</div>
<div name="FormWrapper" id="FormWrapper" class="col-sm-12">
<cfform action="/vendors/enhanced-vendor-remittance/download/?requesttimeout=999999&SpreadsheetStartRow=#SpreadsheetStartRow#&SpreadsheetNewRow=#SpreadsheetNewRow#" method="post" name="download_form" id="download_form">

<div class="col-sm-12"><p id="Instructions">In addition to downloading the data found on this screen, also download:</p></div>

<ul style="list-style-type: none;">
    <li><cfinput type="checkbox" name="PVTX"> Payment Voucher Text</li>
    <li><cfinput type="checkbox" name="LineDetails"> Accounting Line Details</li>
</ul>

<cfloop list="#structKeyList(URL)#" index="key">
	<cfoutput>
        <!--- (#key#): ---><cfinput type="hidden" name="#key#" value="#url[key]#">
        <!--- <br /> --->
    </cfoutput>
</cfloop>
<input type="hidden" name="mode" value="mode" />
<div align="center">
	<cfinput type="submit" name="btn_download" value="Download to Excel" style="color: ##FFFFFF;
		background-color: ##3333FF;" 
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
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
<!---</body></html>--->