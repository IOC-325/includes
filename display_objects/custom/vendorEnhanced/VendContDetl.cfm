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

	Modified Date: 10-14-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

	Description:  Allows the users to view the detail information on a particular Vendor Contract
--->

<CFIF IsDefined ("form.Contract")>
 <CFSET Contract = form.Contract>
<cfelseif IsDefined ("URL.Contract")>
 <CFSET Contract = URL.Contract>
</CFIF>

<CFIF IsDefined ("URL.ContAgcy")>
 <CFSET ContAgcy = URL.ContAgcy>
<cfelseif IsDefined ("form.ContAgcy")>
 <CFSET ContAgcy = form.ContAgcy>
<cfelseif IsDefined ("ContAgcy")>
 <CFSET ContAgcy = ContAgcy>
</CFIF>

<CFIF IsDefined ("URL.ContSel")>
 <CFSET ContSel = URL.ContSel>
<cfelseif IsDefined ("form.ContSel")>
 <CFSET ContSel = form.ContSel>
<cfelseif IsDefined ("ContSel")>
 <CFSET ContSel = ContSel>
</CFIF>

<CFIF IsDefined ("URL.POType")>
 <CFSET POType = URL.POType>
<cfelseif IsDefined ("form.POType")>
 <CFSET POType = form.POType>
<cfelseif IsDefined ("POType")>
 <CFSET POType = POType>
</CFIF>

<CFIF IsDefined ("URL.FY")>
 <CFSET FY = URL.FY>
<cfelseif IsDefined ("form.FY")>
 <CFSET FY = form.FY>
</CFIF>

<CFIF IsDefined ("form.Mode")>
 <CFSET Mode = form.Mode>
<cfelseif IsDefined ("URL.Mode")>
 <CFSET Mode = URL.Mode>
</CFIF>

<CFIF IsDefined ("URL.Agency")>
 <CFSET Agency = URL.Agency>
<cfelseif IsDefined ("form.Agency")>
 <CFSET Agency = form.Agency>
<cfelseif IsDefined ("Agency")>
 <CFSET Agency = Agency>
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
<cfelse>
 <CFSET StartRow = 1> 
</CFIF>

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
<cfif (not isdefined("Session.VendTIN")) <!---or (not isdefined("ContAgcy"))---> or (not isdefined("Contract"))>
	<!--- Calls Index from VendorEnhanced --->
	<cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>
<cfinclude template="TmpVendorapplicationSettings.cfm">
</cfLock>

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<CFINCLUDE TEMPLATE="VendHeader.cfm">
<div class="col-sm-12">&nbsp;</div>
<div class="col-sm-12 pull-right"><cfoutput><a href="/vendors/enhanced-vendor-remittance/vendor-contract-list/?CONTAGCY=#URLEncodedFormat(ContAgcy)#&Contract=#URLEncodedFormat(ContSel)#&Agency=#URLEncodedFormat(Agency)#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#URLEncodedFormat(AscDesc)#&ContSel=#URLEncodedFormat(ContSel)#&POType=#URLEncodedFormat(POType)#&FY=#URLEncodedFormat(FY)#&Max=#URLEncodedFormat(Max)#&Mode=#URLEncodedFormat(Mode)#&StartRow=#StartRow#" id="ReturnBack"><span class="input-group-addon pull-left"><i class="glyphicon glyphicon-share-alt"></i></span>Return Back</a></cfoutput></div>

<CFSET Area="Contracts">
<cfoutput>
<CFQUERY NAME="ContHeader" DATASOURCE="#application.whDSN#">
	SELECT 	#application.whOwner#TRANS_CONT_HDR_#FY#.FISCAL_YEAR,
			#application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE,
			#application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE,
			#application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_AMT,
			#application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE,
			#application.whOwner#TRANS_CONT_HDR_#FY#.CLASS_CODE,
            WH.TRANS_CONT_HDR_#FY#.Transaction_Agency
	FROM #application.whOwner#TRANS_CONT_HDR_#FY#
	<!---WHERE 	
			#application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_AGENCY = '#ContAgcy#' AND
			#application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_NUMBER = '#Contract#' AND
			<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">#application.whOwner#TRANS_CONT_HDR_#FY#.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#' </cfLock> and
			#application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE IS NOT null and
			#application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE IS NOT null--->
     WHERE 	
     	<cfif left(ltrim(rtrim(Agency)),3) is not "All">
		wh.TRANS_CONT_HDR_#FY#.TRANSACTION_AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Agency#" /> AND
        </cfif>
        <cfif trim(ContAgcy) is "999">
        	wh.TRANS_CONT_HDR_#FY#.Transaction_Agency = <cfqueryparam cfsqltype="cf_sql_varchar" value="999" /> AND
        </cfif>
        #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#Contract#"> AND 
		<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
        	#application.whOwner#TRANS_CONT_HDR_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"> 
       	</cfLock> 
        and #application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE IS NOT null 
        and #application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE IS NOT null
</CFQUERY>

<CFQUERY NAME="ContLines" DATASOURCE="#application.whDSN#">
	SELECT 	#application.whOwner#TRANS_CONT_LINE_#FY#.AGENCY,
			#application.whOwner#TRANS_CONT_LINE_#FY#.CONTRACT_ENC_AMT,
			#application.whOwner#AGENCY_#FY#.NAME,
            wh.TRANS_CONT_LINE_#FY#.Transaction_AGENCY
	FROM #application.whOwner#TRANS_CONT_LINE_#FY#, #application.whOwner#AGENCY_#FY#
	<!---WHERE 	
			#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY = '#ContAgcy#' AND
			#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER = '#Contract#' AND
			<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">#application.whOwner#TRANS_CONT_LINE_#FY#.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#' </cfLock> AND
			#application.whOwner#TRANS_CONT_LINE_#FY#.AGENCY = #application.whOwner#AGENCY_#FY#.AGENCY--->
     WHERE 	
     	<cfif left(ltrim(rtrim(Agency)),3) is not "All">
		wh.TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Agency#" /> AND
        </cfif>
            #application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#Contract#">
			<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">And #application.whOwner#TRANS_CONT_LINE_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"> </cfLock> 
            AND #application.whOwner#TRANS_CONT_LINE_#FY#.AGENCY = #application.whOwner#AGENCY_#FY#.AGENCY
</CFQUERY>
</cfoutput>

<div name="FormWrapper" id="FormWrapper" class="col-sm-12">
<TABLE WIDTH="100%" BORDER="1">
	<CFOUTPUT QUERY="ContHeader">
    <cfif ContAgcy is not "999" and Transaction_Agency is "999">
    <cfelse>
	<TR id="darkcolor">
		<TH ALIGN="LEFT" id="Contract4" COLSPAN="8">Contract: <cfif left(trim(ContAgcy),3) is "All">#AGENCY#<cfelse><!---#ContAgcy#--->#TRANSACTION_AGENCY#</cfif> #Contract#</TH>
	</TR>
	<TR id="lightcolor">
		<TD ALIGN="RIGHT" id="FY4">Fiscal Year: </TD>
		<TD ALIGN="RIGHT" id="FY4">#Fiscal_Year#</TD>
		<TD WIDTH="50">&nbsp;</TD>
		<TD ALIGN="RIGHT" id="FromDate4">From Date: </TD>
		<TD ALIGN="RIGHT" id="FromDate4">#DateFormat(FROM_DATE,"mm/dd/yy")#</TD>
		<TD WIDTH="50"></TD>
		<TD ALIGN="RIGHT" id="ToDate4">To Date: </TD>
		<TD ALIGN="RIGHT" id="ToDate4">#DateFormat(TO_DATE,"mm/dd/yy")#</TD>
	</TR>
	<TR id="lightcolor">
		<TD ALIGN="RIGHT" id="ContractTotal4">Contract Total: </TD>
		<TD ALIGN="RIGHT" id="ContractTotal4"><cfif trim(ContAgcy) is not "999">#DollarFormat(CONTRACT_AMT)#<cfelse>#DollarFormat(0)#</cfif> </TD>
		<TD WIDTH="50"></TD>
		<TD ALIGN="RIGHT" id="ContractType4">Contract Type: </TD>
		<TD ALIGN="RIGHT" id="ContractType4">#CONTRACT_TYPE#</TD>
		<TD WIDTH="50"></TD>
		<TD ALIGN="RIGHT" id="ClassCode4">Class: </TD>
		<TD ALIGN="RIGHT" id="ClassCode4">#CLASS_CODE#</TD>
	</TR>
    </cfif>
	</CFOUTPUT>
	<TR id="lightcolor"><TD Height="20" colspan="8"></TD></TR>
	<TR id="darkcolor">
		<TD ALIGN="center" COLSPAN="5" id="Agency4">Agency</TD>
		<TD ALIGN="right" COLSPAN="3" id="Agency4">Obligated Amount</TD>
	</TR>
	<CFOUTPUT QUERY="ContLines">
    <cfif trim(ContAgcy) is not "999">
	<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
		<TD COLSPAN="5" ALIGN="LEFT">#AGENCY# - #NAME#</TD>
		<TD COLSPAN="3" ALIGN="RIGHT">#DollarFormat(CONTRACT_ENC_AMT)# </TD>
	</TR>
    </cfif>
	</CFOUTPUT>
</TABLE>
</div>
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    

<!---</BODY>
</HTML>--->

