<!---
	SR 8103
	Date Migrated : 12/16/08
	Migrated By : ASP

	 WH00178
	Developer: ASP
	Date Completed: 7/11/00


	WH 00178 Run a check to determine if any zero's have been cropped


	Modified Date: 11-21-00
	Modified By: Gary Ashbaugh
	Modifications Made: Add redirect when VendTIN is not defined

	Modified Date: 11-18-14
	Modified By: Gary Ashbaugh
		Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

  Modified Date: 08-23-19
	Modified By: Raghu Bhonnam
	Description: SR19115 Updated Vendor Name for Payments Issued Page.  

  Modified Date: 09-03-19
	Modified By: Raghu Bhonnam
	Description: SR19115 Updated Vendor Name for Payments Issued Page. 

  Modified Date: 08-30-20
  Modified By: Andy Peterson
  Desription: SR 20008 Added check for Fiscal Year to fix Payments Issued Page.
--->

<!--- new as of 11/19/13 --->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-45854861-1', 'state.il.us');
  ga('send', 'pageview');

</script>


<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomVendorLayoutFormatting.css">

<CFIF IsDefined ("URL.VendTIN")>
	<CFSET VendTIN = URL.VendTIN>
<cfelseif IsDefined ("form.VendTIN")>
	<CFSET VendTIN = form.VendTIN>
<cfelseif IsDefined ("VendTIN")>
	<CFSET VendTIN = VendTIN>
 <!--- Code change by RK for SR 17070 starts here --->
<cfelseif isDefined("session.TheVendTin")>
 <CFSET VendTIN = session.TheVendTin>
<!--- Code change by RK for SR 17070 ends here --->
<cfelse>
	<cflocation url="/vendors/">
</CFIF>

<CFIF IsDefined ("form.SVendTin")>
	<CFSET SVendTin = form.SVendTin>
<cfelseif  IsDefined ("URL.SVendTin")>
	<CFSET SVendTin = URL.SVendTin>
<cfelseif  IsDefined ("SVendTin")>
	<CFSET SVendTin = SVendTin>
<!--- Code change by RK for SR 17070 starts here --->
<cfelseif isDefined("session.TheVendTin")>
 <CFSET SVendTin = session.TheVendTin>
<!--- Code change by RK for SR 17070 ends here --->
<cfelse>
	<cflocation url="/vendors/">
</cfif>
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

<!--- <cfif (not isdefined("VendTIN")) and (not isdefined("SVendTIN"))>
	<!---<CFLOCATION URL="/QuickTake/Vend/">--->
    <cflocation url="/vendors/">
</cfif>
 --->
<!--- <cfinclude template="TmpVendorapplicationSettings.cfm"> --->

<cfif isDefined("session.TheVendTin")>
 <cfset vendTIN = Decrypt(session.TheVendTin,"ITBG111")>
</cfif>

<cfif len(VendTiN) eq 8>
	<cfSet VendorTin='0#VendTIN#'>
<cfelseif len(VendTiN) eq 7>
	<cfSet VendorTin='00#VendTIN#'>
<cfelse>
	<cfSet VendorTin='#VendTIN#'>
</cfif>


<cfSet VendorTin='#VendTin#'>
<cfset TmpVendor_Name = "#left(rereplace(VendTINName,"[^0-9A-Za-z]","","all"),4)#">

<CFQUERY NAME="GetVendor" DATASOURCE="DB2PRD" CACHEDWITHIN="#CreateTimeSpan(0,0,30,0)#">
SELECT 	VENDOR_TIN,
        VENDOR_NAME, SAMS_Delete_Date, Cert_Ind
FROM wh.VENDOR
WHERE Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTIN#" /> and
    left(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(Vendor_Name,' ',''),'-',''),'*',''),'####',''),'''',''),'!',''),'@',''),'$',''),'%',''),'^',''),'&',''),')',''),'(',''),'_',''),'+',''),'.',''),',',''),'"',''),4) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCase(TmpVendor_Name)#" />

</CFQUERY>

<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->
<cfSet vendorName='#GetVendor.VENDOR_NAME#'>
<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->

<!--- <cfdump var="#VendTIN#"><br/>
<cfdump var="#Encrypt(VendTIN,'ITBG111')#"><br/>
<cfdump var="#UrlEncodedFormat(Encrypt(URL.VendTIN,'ITBG111'))#"><br/>
<cfdump var="#UrlEncodedFormat(Encrypt(form.VendTIN,'ITBG111'))#">
<cfdump var="#URLDecode(UrlEncodedFormat(Encrypt(VendTIN,'ITBG111')))#"><br/>
<cfdump var="#Decrypt(URLDecode(UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))),'ITBG111')#"><br/>
 --->
<!--- <CFSET sVendTIN= UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))> --->
<CFSET sVendTIN= UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))>
<!--- <cfdump var="#sVendTIN#"> --->

<!--- <nav role="navigation" class="navbar"> --->
 <!---   <div class="navbar-header col-offset-sm-2">--->
<!---<div class="col-sm-12">
    <button data-target="#navbar-collapse-2" data-toggle="collapse" class="navbar-toggle navbar-user" type="button">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </button>
    <center><cfoutput QUERY="GetVendor" MAXROWS=1><h1 style="alignment-adjust: center; background-color: ##283D58;"><font color="white">#Vendor_Name#</font></h1></cfoutput></center>
</div>
<div class="navbar-collapse collapse navbar-default" id="navbar-collapse-2" style="height: 1px;">--->

<cfoutput QUERY="GetVendor" MAXROWS=1><h2 class="pageTitle2"><span>#Vendor_Name#</span></h2></cfoutput>

 <ul class="vendormenu">
        <li><cfoutput>
            <a href="/vendors/" id="Logoff">
            <img style="width: 110px;" src="/iwgraph/VendorHome.png">Return Home</a></cfoutput></li>
        <li><cfoutput>
             <a HREF="/vendors/vendor-payments-new/vendor-summary/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Mode=Summ&VendTINName=#VendTINName#"  id="Summary">
             <img style="width: 110px;" src="/iwgraph/VendorSummary.png">Vendor Summary</a></cfoutput></li>
        <li><cfoutput>
           <A HREF="/vendors/vendor-payments-new/vendor-contract-form/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Mode=Contracts&VendTINName=#VendTINName#"  id="Contracts">
           <img style="width: 110px;" src="/iwgraph/ContractDetails.png">Contract Search</a>
         </cfoutput></li>
        <li><cfoutput>
          <a HREF="/vendors/vendor-payments-new/vendor-warrant-form/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Mode=Warrants&VendTINName=#VendTINName#" id="Payments">
          <img style="width: 110px;" src="/iwgraph/PaymentSearch.png">Payments Search</a>
        </cfoutput></li>
        <li><cfoutput>

          <!--SR20008: Fixed issue with Fiscal Year reverting to previous Year -->
          <cfif isdefined("form.fy")>

            <cfset variables.fy = form.fy>
          
          <cfelseif isdefined("url.fy")>

            <cfset variables.fy = url.fy>

          <cfelse>
            
            <cfset variables.fy = application.cfy>

          </cfif>
          <a HREF="/vendors/vendor-payments-new/vendor-warrant-list?Mode=ContForm&NotificationType=None&SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&VENDTINNAME=#VendTINName#&Agency=All&AscDesc=Desc&FindContracts=Find Contracts&FY=#variables.fy#&Max=20&POType=All&SortBy=Contract Number&ContSel=" id="Payments">
          <img style="width: 110px;" src="/iwgraph/PaymentsIssued.png">Payments Issued</a>
        </cfoutput></li>
        <li><cfoutput>
          <a HREF="/vendors/vendor-payments-new/pending-payments/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Mode=Warrants&VendTINName=#VendTINName#" id="Payments">
          <img style="width: 110px;" src="/iwgraph/FuturePayments.png">Pending Payments</a>
        </cfoutput></li>
        <li><cfoutput>
          <a HREF="/vendors/vendor-payments-new/payment-notification/?SVendTIN=#UrlEncodedFormat(Encrypt(VendTIN,'ITBG111'))#&Mode=Warrants&VendTINName=#VendTINName#" id="Payments">
          <img style="width: 110px;" src="/iwgraph/PaymentNotifications.png">Payments Notifications</a>
        </cfoutput></li>
    </ul>
<!---</div>--->
<!--- </nav> --->
<script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery-latest.js"></script>
<script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
<script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>

<script>
$('#Logoff').tooltip({
    'show': false,
        'placement': 'bottom',
        'title': "Click here to Logout of the application."
});
$('#Summary').tooltip({
    'show': false,
        'placement': 'bottom',
        'title': "Click here to view the summary page which shows summary information regarding your Vendor's Contract/Payment Information."
});
$('#Contracts').tooltip({
    'show': false,
        'placement': 'bottom',
        'title': "Click here to go to the Vendor Contract form where you can set a filter to limit the contract information displayed."
});
$('#Payments').tooltip({
    'show': false,
        'placement': 'bottom',
        'title': "Click here to go to the Vendor Payment form where you can set a filter to limit the payment Information displayed."
});



</script>

<script>
$(function(){

// $(':button').on('click', function(e) {
//   console.log(this);
//  console.log($(this).hasClass('collapse'));
//   if($("#navbar-collapse-2").hasClass("collapse")){
//    $("#navbar-collapse-2").removeClass('navbar-collapse collapse navbar-default').addClass('navbar-collapse navbar-default');
//     console.log("true");
//   }
//   else{
//     $("#navbar-collapse-2").removeClass('navbar-collapse navbar-default in').addClass('navbar-collapse collapse navbar-default');
//     console.log("flase");
//   }
//  });

});
</script>