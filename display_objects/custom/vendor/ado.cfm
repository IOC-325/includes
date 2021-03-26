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

<CFIF IsDefined ("form.Agency")>
 <CFSET Agency = form.Agency>
<cfelseif IsDefined ("URL.Agency")>
 <CFSET Agency = URL.Agency>
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

<CFIF IsDefined ("form.FY")>
 <CFSET FY = form.FY>
<cfelseif IsDefined ("URL.FY")>
 <CFSET FY = URL.FY>
</CFIF>

<CFIF IsDefined ("form.Status")>
 <CFSET Status = form.Status>
<cfelseif IsDefined ("URL.Status")>
 <CFSET Status = URL.Status>
 <cfelse>
 <CFSET Status = "All">
</CFIF>

<CFIF IsDefined ("URL.VendTinName")>
	<CFSET VendTinName = URL.VendTinName>
<cfelseif IsDefined ("form.VendTinName")>
	<CFSET VendTinName = form.VendTinName>
<cfelseif IsDefined ("VendTinName")>
	<CFSET VendTinName = VendTinName>
</CFIF>
<CFIF IsDefined ("URL.mode")>
	<CFSET mode = URL.mode>
<cfelseif IsDefined ("form.mode")>
	<CFSET mode = form.mode>
</CFIF>

<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->
<CFIF IsDefined ("form.vendorName")>
 <CFSET vendorName = form.vendorName>
<cfelseif IsDefined ("URL.vendorName")>
 <CFSET vendorName = URL.vendorName>
</CFIF>
<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->

<cfif isDefined("session.TheVendTin")>
 <cfset vendTIN = Decrypt(session.TheVendTin,"ITBG111")>
</cfif>
<CFSET VendTin = NUMBERFORMAT(VendTin, '000000000')>


<p>Download Options</p>
<div name="FormWrapper" id="FormWrapper">
<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->
<cfform action="/vendors/vendor-payments-new/download/?startDate=#startDate#&endDate=#endDate#&Agency=#Agency#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgcySel=#ContAgcySel#&InvSel=#InvSel#&FY=#FY#&Status=#Status#&SVendTin=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Mode=#Mode#&vendorName=#vendorName#&requesttimeout=999999" method="post" name="download_form" id="download_form">
<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->
<p id="Instructions">In addition to downloading the data found on this screen, also download:</p>

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
	<input type="submit" name="btn_download" value="Download to Excel" style="color: #FFFFFF;
    background-color: #145089;
    border: 1px solid #145089;"
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