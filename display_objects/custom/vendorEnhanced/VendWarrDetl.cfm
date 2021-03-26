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

	Description:  Allows the users to view the detail information on a particular Vendor Warrants
--->


<SCRIPT LANGUAGE="Javascript">
              
function makeNewRemote(fileName) {
         remote = window.open("","remotewin","width=300,height=110,scrollbars=1");
		 
		 // Development
		 //remote.location.href = "http://iw.ioc-sql-dev1.ioc.com/Vendor/"+fileName+".cfm";
		 
		 // Production 
		 remote.location.href = "http://illinoiscomptroller.gov/Vendor/"+fileName+".cfm";
         if (remote.opener == null) remote.opener = window; 
         	remote.opener.name = "opener";
         }
		 
         //-->

</SCRIPT>

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<CFIF IsDefined ("URL.warrant")>
 <CFSET warrant = URL.warrant>
<cfelseif IsDefined ("form.warrant")>
 <CFSET warrant = form.warrant>
<cfelseif IsDefined ("warrant")>
 <CFSET warrant = warrant>
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

<CFIF IsDefined ("form.Contsel")>
 <CFSET Contsel = form.Contsel>
<cfelseif IsDefined ("URL.Contsel")>
 <CFSET Contsel = URL.Contsel>
</CFIF>

<CFIF IsDefined ("form.INVSEL")>
 <CFSET INVSEL = form.INVSEL>
<cfelseif IsDefined ("URL.INVSEL")>
 <CFSET INVSEL = URL.INVSEL>
</CFIF>

<CFIF IsDefined ("form.Accept_date")>
 <CFSET Accept_date = form.Accept_date>
<cfelseif IsDefined ("URL.Accept_date")>
 <CFSET Accept_date = URL.Accept_date>
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
<cfinclude template="TmpVendorapplicationSettings.cfm">
<cfif not isdefined("warrant") or (not isdefined("Session.VendTIN"))>
	<!--- Calls Index from VendorEnhanced --->
    <!--- Development & Production --->
    <cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
    
	<!---
 	<cflocation URL="/quicktake/vend/">
	--->
</cfif> 
</cfLock>

<cftry>
<!--- Carl's New View for SR11108_Phase 2 --->
<CFQUERY NAME="OffsetInfo" DATASOURCE="VendorDB2" CACHEDWITHIN="#CreateTimeSpan(0,0,10,0)#">
    
    SELECT Tot_Offset_Amt, Tot_Fee_Amt
	FROM WH.IOC_WARR_OFFST_FEE
	WHERE 
	TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#Warrant#"> 
	AND ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Accept_date)#">
</CFQUERY>

<CFQUERY NAME="RESULTS" <!---DATASOURCE="#application.whDSN#"---> DATASOURCE="VendorDB2" <!---datasource="DB2Dev"---> CACHEDWITHIN="#CreateTimeSpan(0,0,10,0)#">

	<!--- Per Carl Lair, Trans_Warr_Line is not needed, and should be using Voucher_No & Voucher_Agency --->
    <!---
	SELECT text_line as LINE, pv_text as TEXT
	FROM WH.IOC_PVTX	A
	, WH.TRANS_WARR_LINE_#FY#	B
	WHERE 
	B.VOUCHER_NUMBER = A.VOUCHER_NUMBER
	AND B.VOUCHER_AGENCY=A.VOUCHER_AGENCY
	AND B.TRANSACTION_LINE = '01'
	AND B.TRANSACTION_NUMBER = '#Warrant#' 
	AND B.ACCEPTANCE_DATE = #CreateODBCDate(Accept_date)#
	AND A.VENDOR_TIN = B.VENDOR_TIN
	AND A.VENDOR_ADDR_IND = B.VENDOR_ADDR_IND
	ORDER BY LINE
	--->
    
    SELECT text_line as LINE, pv_text as TEXT
	FROM WH.IOC_PVTX	A
	, WH.TRANS_WARR_LINE_#FY#	B
	WHERE 
	B.VOUCHER_NUMBER = A.VOUCHER_NUMBER
	AND B.VOUCHER_AGENCY=A.VOUCHER_AGENCY
	AND B.TRANSACTION_LINE = <cfqueryparam cfsqltype="cf_sql_char" value="01">
	AND B.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#Warrant#"> 
	AND B.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Accept_date)#"> 
	<!---AND A.VENDOR_TIN = B.VENDOR_TIN
	AND A.VENDOR_ADDR_IND = B.VENDOR_ADDR_IND--->
	ORDER BY LINE
</CFQUERY>

<!---	
<CFQUERY NAME="WarrHeader" DATASOURCE=#application.whDSN#>
	SELECT 	#application.whOwner#TRANS_WARR_HDR_#FY#.FISCAL_YEAR,
			#application.whOwner#TRANS_WARR_HDR_#FY#.RECORD_DATE,
			#application.whOwner#TRANS_WARR_HDR_#FY#.LAST_ACTION_DATE,
			#application.whOwner#TRANS_WARR_HDR_#FY#.TRANSACTION_CODE,
			#application.whOwner#TRANS_WARR_HDR_#FY#.TRANSACTION_NUMBER,
			#application.whOwner#TRANS_WARR_HDR_#FY#.TOT_WARRANT_AMT,
			#application.whOwner#TRANS_WARR_HDR_#FY#.WARRANT_STATUS
	FROM 	#application.whOwner#TRANS_WARR_HDR_#FY#
	WHERE 	#application.whOwner#TRANS_WARR_HDR_#FY#.TRANSACTION_NUMBER = '#Warrant#'
      AND 	#application.whOwner#TRANS_WARR_HDR_#FY#.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#'
	  AND 	#application.whOwner#TRANS_WARR_HDR_#FY#.ACCEPTANCE_DATE = #CreateODBCDate(Accept_date)#
</CFQUERY>
--->

<!--- Replace above query with new IOC_WARR_HDR view below per SR11108 --->
<cfset TmpDt = "20" & "#FY#">
<CFQUERY NAME="WarrHeader" <!---DATASOURCE=#application.whDSN# ---> DATASOURCE="VendorDB2"  <!---datasource="DB2Dev"--->>
	SELECT 	#application.whOwner#IOC_WARR_HDR.FISCAL_YEAR, 
			#application.whOwner#IOC_WARR_HDR.RECORD_DATE, 
			#application.whOwner#IOC_WARR_HDR.LAST_ACTION_DATE, 
			#application.whOwner#IOC_WARR_HDR.TRANSACTION_CODE, 
			#application.whOwner#IOC_WARR_HDR.TRANSACTION_NUMBER, 
			#application.whOwner#IOC_WARR_HDR.TOT_WARRANT_AMT, 
            #application.whOwner#IOC_WARR_HDR.NAME1, 
            #application.whOwner#IOC_WARR_HDR.NAME2, 
            #application.whOwner#IOC_WARR_HDR.Address,
            #application.whOwner#IOC_WARR_HDR.City,
            #application.whOwner#IOC_WARR_HDR.State,
            #application.whOwner#IOC_WARR_HDR.ZIP_Code,
			#application.whOwner#IOC_WARR_HDR.WARRANT_STATUS,
            #application.whOwner#IOC_WARR_HDR.Invoice_Date,
            #application.whOwner#IOC_WARR_HDR.Tot_Voucher_Amt
	FROM 	#application.whOwner#IOC_WARR_HDR
	WHERE 	#application.whOwner#IOC_WARR_HDR.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#Warrant#"> and 
    		<!---
      		#application.whOwner#IOC_WARR_HDR.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#' and 
			--->
	  		#application.whOwner#IOC_WARR_HDR.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Accept_date)#"> <!---and 
            #application.whOwner#IOC_WARR_HDR.Fiscal_Year = #TmpDt#--->
            

</CFQUERY>


<!---<CFQUERY NAME="WarrLines" DATASOURCE=#application.whDSN#>
	SELECT	#application.whOwner#TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE,
			#application.whOwner#TRANS_WARR_LINE_#FY#.FUND,
			#application.whOwner#TRANS_WARR_LINE_#FY#.AGENCY,
			#application.whOwner#TRANS_WARR_LINE_#FY#.ORGANIZATION,
			#application.whOwner#TRANS_WARR_LINE_#FY#.APPROPRIATION,
			#application.whOwner#TRANS_WARR_LINE_#FY#.OBJECT,
			#application.whOwner#TRANS_WARR_LINE_#FY#.WARRANT_AMT,
			#application.whOwner#TRANS_WARR_LINE_#FY#.CONTRACT_CODE,
			#application.whOwner#TRANS_WARR_LINE_#FY#.CONTRACT_NUMBER,
			#application.whOwner#TRANS_WARR_LINE_#FY#.VOUCHER_CODE,
			#application.whOwner#TRANS_WARR_LINE_#FY#.VOUCHER_NUMBER,
			#application.whOwner#TRANS_WARR_LINE_#FY#.VENDOR_INVOICE,
			#application.whOwner#AGENCY_#FY#.NAME
			, #application.whOwner#AGENCY_#FY#.CONTACT_INFO
	FROM 	#application.whOwner#TRANS_WARR_LINE_#FY#, #application.whOwner#AGENCY_#FY#
	WHERE 	#application.whOwner#TRANS_WARR_LINE_#FY#.TRANSACTION_NUMBER = '#Warrant#' AND
			#application.whOwner#TRANS_WARR_LINE_#FY#.AGENCY = #application.whOwner#AGENCY_#FY#.AGENCY AND
            #application.whOwner#TRANS_WARR_LINE_#FY#.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#' AND
			#application.whOwner#TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE = #CreateODBCDate(Accept_date)#
</CFQUERY>--->


<!--- Replace above query with view below per SR11108 --->
<CFQUERY NAME="WarrLines" <!---DATASOURCE=#application.whDSN#---> DATASOURCE="VendorDB2" <!---datasource="DB2Dev"--->>
	SELECT	 #application.whOwner#ioc_WARR_LINE.ACCEPTANCE_DATE, 
			#application.whOwner#ioc_WARR_LINE.FUND, 
			#application.whOwner#ioc_WARR_LINE.AGENCY, 
			#application.whOwner#ioc_WARR_LINE.ORGANIZATION, 
			#application.whOwner#ioc_WARR_LINE.APPROPRIATION, 
			#application.whOwner#ioc_WARR_LINE.OBJECT, 
			#application.whOwner#ioc_WARR_LINE.WARRANT_AMT, 
			#application.whOwner#ioc_WARR_LINE.CONTRACT_CODE, 
			#application.whOwner#ioc_WARR_LINE.CONTRACT_NUMBER, 
			#application.whOwner#ioc_WARR_LINE.VOUCHER_CODE, 
			#application.whOwner#ioc_WARR_LINE.VOUCHER_NUMBER, 
			#application.whOwner#ioc_WARR_LINE.VENDOR_INVOICE, 
            #application.whOwner#ioc_WARR_LINE.BEGIN_SERV_DATE, 
            #application.whOwner#ioc_WARR_LINE.END_SERV_DATE, 
			#application.whOwner#AGENCY.NAME, 
			#application.whOwner#AGENCY.CONTACT_INFO
	FROM 	#application.whOwner#ioc_WARR_LINE, #application.whOwner#AGENCY
	WHERE 	#application.whOwner#ioc_WARR_LINE.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#Warrant#"> AND
			#application.whOwner#ioc_WARR_LINE.AGENCY = #application.whOwner#AGENCY.AGENCY AND
			#application.whOwner#ioc_WARR_LINE.FISCAL_YEAR = #application.whOwner#AGENCY.FISCAL_YEAR AND
            <!---
            #application.whOwner#ioc_WARR_LINE.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#' AND
			--->
			#application.whOwner#ioc_WARR_LINE.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Accept_date)#"> <!---and 
            #application.whOwner#ioc_WARR_LINE.Fiscal_Year = #TMpDt# --->
            

</CFQUERY>

<cfcatch type="any">
    <p class="text-danger"><b>Sorry, but it appears that the site is not available at this time...please try back later!</b></p>
</cfcatch>
</cftry>

<cfset TryAntDt = "True">
<CFSET Area="Warrants">

<CFINCLUDE TEMPLATE="VendHeader.cfm">


<div class="marginb20"><cfoutput><a href="/vendors/enhanced-vendor-remittance/vendor-warrant-list?Mode=#URLEncodedFormat(Mode)#&Agency=#URLEncodedFormat(Agency)#&Status=#URLEncodedFormat(Status)#&FY=#URLEncodedFormat(FY)#&startDate=#URLEncodedFormat(startDate)#&EndDate=#URLEncodedFormat(EndDate)#&Sortby=#URLEncodedFormat(Sortby)#&AscDesc=#URLEncodedFormat(AscDesc)#&ContSel=#URLEncodedFormat(ContSel)#&ContAgcySel=#URLEncodedFormat(Agency)#&InvSel=#URLEncodedFormat(InvSel)#&max=#max#&StartRow=#StartRow#" id="ReturnBack"><i class="glyphicon glyphicon-share-alt"  ></i> Return Back</a></cfoutput></div>
<div name="FormWrapper" id="FormWrapper" class="table-responsive">
<TABLE class="table table-striped table-bordered vendor-table">
	<CFOUTPUT QUERY="WarrHeader">
        <thead>
	<TR id="darkcolor">
		<TH ALIGN=LEFT COLSPAN="6" id="WarrantNo">Warrant/EFT##: #TRANSACTION_CODE#  #Warrant#</TH>
	</TR>
    </thead>
	<TR id="lightcolor">
		<TD ALIGN="RIGHT" id="FY3"><b>Fiscal Year</b></TD>
		<TD ALIGN="RIGHT" id="FY4">#Fiscal_Year#</TD>
		<TD ALIGN="RIGHT"  id="IssueDate3"><A HREF="javascript: makeNewRemote('IssueDate')" TITLE="The Issue Date is the date the Comptroller's Office processed the payment. It is the date that appears on the hard copy warrant. For payments that went EFT, you can add two days to the issue date to determine the effective date." STYLE="cursor:help"><b>Issue Date</b></A></TD>
		<TD ALIGN="RIGHT" width="10"  id="IssueDate4">#DateFormat(RECORD_DATE,"mm/dd/yy")#</TD>
        <cfif WarrHeader.Transaction_Code is not "EF">
        <cfelse>
        	<!--- WarrHeader.Transacton_Code is "EF" --->
        	<TD  id="IssueDate3" align="Right"><A HREF="javascript: makeNewRemote('AnticipatedDirectDepositDt')" TITLE="This is an estimated date the Comptroller expects the payment to be deposited in the provider's account.  However, due to Bank Holidays, the payment may be a little longer." STYLE="cursor:help"><b>Anticipated Direct Deposit Date</b></A></TD>
            
			<!--- Calculate Anticipated Date --->
            <cfoutput>
			<cfset FndAnticipatedDt = "False">
            <cfset NoDays = 0>
            <!--- Add first day --->
			<cfset CalcAnticipatedDt = DateFormat(Record_Date,"mm/dd/yyyy")>
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
                    <!--- Sunday....re-calculate date to Tuesday --->
                    <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                <cfelseif CheckHoliday.recordcount>
                	<!--- Holiday move to next --->
                	<cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                <cfelse>
					<!--- Add another Day --->
                	
                    <cfif NoDays eq 2>
                		<cfset FndAnticipatedDt = "True">
                	<cfelse>             		
                		<cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                	</cfif>
					<cfset NoDays = #NoDays#+1>
                </cfif>
                
            </cfloop>
			
        	<td id="IssueDate4" ALIGN="RIGHT">#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#</td>
           	</cfoutput>
        </cfif>
		
	</TR>
    <!--- Here the section I changed --->
    <TR  id="lightcolor">
		<TD ALIGN="RIGHT"  id="IssueDate3"><b>Invoice Date</b></TD>
		<TD ALIGN="RIGHT"  id="IssueDate4">#DateFormat(Invoice_Date, "mm/dd/yyyy")#</TD>
		<TD ALIGN="RIGHT"  id="IssueDate3"><b>Total Voucher</b></TD>
		<TD ALIGN="RIGHT"  id="IssueDate4">#DollarFormat(Tot_Voucher_Amt)#</TD>
		<TD  id="IssueDate3" align="right"><b>Total Offset</b></TD>
        <td  id="IssueDate4" ALIGN="RIGHT">#DollarFormat(OffsetInfo.Tot_Offset_Amt)#</td>
	</TR>
    <TR  id="lightcolor">
		<TD ALIGN="RIGHT"  id="IssueDate3"><b>Total Fee</b></TD>
		<TD ALIGN="RIGHT"  id="IssueDate4">#DollarFormat(OffsetInfo.Tot_Fee_Amt)#</TD>
		<TD ALIGN="RIGHT"  id="IssueDate3"><b>Warrant Total</b></TD>
		<TD ALIGN="RIGHT"  id="IssueDate4">#DollarFormat(TOT_WARRANT_AMT)#</TD>
		<TD id="IssueDate3" align="Right"><b>Warrant Status</b></TD>
        <td id="IssueDate4" ALIGN="RIGHT">
			<cfif findNoCase(Warrant_Status, "")>N/A<cfelse>#WARRANT_STATUS#
				<cfswitch EXPRESSION="#Warrant_Status#">
                 	<cfcase VALUE="A">(Requested Agency Stop)</cfcase>
                    <cfcase VALUE="B">(Requested Payee Stop)</cfcase>
                    <cfcase VALUE="D">(Confirmed Agency Stop)</cfcase>
                    <cfcase VALUE="E">(Escheated)</cfcase>
                    <cfcase VALUE="F">(Confirmed Payee Stop)</cfcase>
                    <cfcase VALUE="G">(Escheatable)</cfcase>
                    <cfcase VALUE="H">(Held)</cfcase>
                    <cfcase VALUE="I">(Voided & Replaced - Offset)</cfcase>
                    <cfcase VALUE="J">(Undeliverable)</cfcase>
                    <cfcase VALUE="K">(Request Payee Rescind Stop)</cfcase>
                    <cfcase VALUE="O">(Issued & Outstanding)</cfcase>
                    <cfcase VALUE="P">(Paid)</cfcase>
                    <cfcase VALUE="Q">(Cancelled for Redeposit)</cfcase>
                    <cfcase VALUE="T">(Cancelled for Redeposit - Undel)</cfcase>
                    <cfcase VALUE="V">(Voided & Replaced - Lost)</cfcase>
                    <cfcase VALUE="W">(Request Agency Rescind Stop)</cfcase>
                 </cfswitch>
         	</cfif>
        </td>
		</TR>
    <!--- End of section I changed --->
    <!---
	<TR>
		<TD ALIGN=RIGHT>Warrant Total: </TD>
		<TD ALIGN=RIGHT>#DollarFormat(TOT_WARRANT_AMT)#</TD>
		<TD WIDTH="50"></TD>
		<TD ALIGN=RIGHT>Warrant Status: </TD>
		<TD ALIGN=RIGHT><cfif findNoCase(Warrant_Status, "")>N/A<cfelse>#WARRANT_STATUS#
			<cfswitch EXPRESSION="#Warrant_Status#">
         <cfcase VALUE="A">(Requested Agency Stop)</cfcase>
			<cfcase VALUE="B">(Requested Payee Stop)</cfcase>
			<cfcase VALUE="D">(Confirmed Agency Stop)</cfcase>
			<cfcase VALUE="E">(Escheated)</cfcase>
			<cfcase VALUE="F">(Confirmed Payee Stop)</cfcase>
			<cfcase VALUE="G">(Escheatable)</cfcase>
			<cfcase VALUE="H">(Held)</cfcase>
			<cfcase VALUE="I">(Voided & Replaced - Offset)</cfcase>
			<cfcase VALUE="J">(Undeliverable)</cfcase>
			<cfcase VALUE="K">(Request Payee Rescind Stop)</cfcase>
			<cfcase VALUE="O">(Issued & Outstanding)</cfcase>
			<cfcase VALUE="P">(Paid)</cfcase>
			<cfcase VALUE="Q">(Cancelled for Redeposit)</cfcase>
			<cfcase VALUE="T">(Cancelled for Redeposit - Undel)</cfcase>
			<cfcase VALUE="V">(Voided & Replaced - Lost)</cfcase>
			<cfcase VALUE="W">(Request Agency Rescind Stop)</cfcase>
         </cfswitch>
         </cfif>
		</TD>
       <!--- <TD colspan="3">&nbsp;</TD>--->
        <TD>&nbsp;</TD>
		<TD>Invoice Date:</TD>
        <td>#DateFormat(Invoice_Date, "mm/dd/yyyy")#</td>
	</TR>
    <TR>
		<TD ALIGN=RIGHT>Total Fee: </TD>
		<TD ALIGN=RIGHT>#DollarFormat(OffsetInfo.Tot_Fee_Amt)#</TD>
		<TD WIDTH="50">&nbsp;</TD>
		<TD ALIGN=RIGHT>Total Offset: </TD>
		<TD ALIGN=RIGHT>#DollarFormat(OffsetInfo.Tot_Offset_Amt)#</TD>
        <TD>&nbsp;</TD>
		<TD>Total Voucher:</TD>
        <td>#DollarFormat(Tot_Voucher_Amt)#</td>
	</TR>
	--->
	</CFOUTPUT>
	<TR  id="lightcolor"><TD height="20" colspan="6">&nbsp;</TD></TR>
	<TR  id="darkcolor">
		<TD ALIGN="center" COLSPAN="2"  id="IssueDate3"><B>Agency</B></TD>
		<TD ALIGN="center" id="IssueDate3"><B>Contract</B></TD>
		<TD ALIGN="center" id="IssueDate3"><B>Invoice</B></TD>
		<TD ALIGN="center" id="IssueDate3"><B>Voucher</B></TD>
		<TD ALIGN="right" id="IssueDate3"><B>Agency Amount</B></TD>
	</TR>
<cfset TrybudgetAmt = "True">
	<CFLOOP QUERY="WarrLines">
		<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
      		<CFOUTPUT>
				<TD COLSPAN="2" ALIGN="CENTER"  id="IssueDate3">#AGENCY# - #NAME#</TD>
				<TD ALIGN="CENTER"  id="IssueDate3">#CONTRACT_NUMBER#</TD>
				<TD ALIGN="CENTER"  id="IssueDate3">#VENDOR_INVOICE#</TD>
				<TD ALIGN="CENTER"  id="IssueDate3">#VOUCHER_NUMBER#</TD>
				<TD ALIGN="RIGHT"  id="IssueDate3">#DollarFormat(WARRANT_AMT)#</TD>
			</TR></CFOUTPUT>
    	<cftry>
        <CFQUERY NAME="BudgetFY" <!---DATASOURCE=#application.whDSN#---> DATASOURCE="VendorDB2" <!---datasource="DB2Dev"--->>
            SELECT WH.TRANS_WARR_HDR.Budget_FY
            FROM 	WH.TRANS_WARR_HDR
            WHERE 	WH.TRANS_WARR_HDR.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#Warrant#">
            <!---
              AND 	WH.TRANS_WARR_HDR.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#'
			  --->
              AND 	WH.TRANS_WARR_HDR.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Accept_date)#">
        </CFQUERY>
        
         <cfcatch type="any">
        	<cfset TrybudgetAmt ="False">
         </cfcatch>
        </cftry>
      
      	<cfif TrybudgetAmt  is "True">
			<cfif BudgetFY.recordcount>
                <cfset AppropFY = '#mid(BudgetFY.Budget_FY,3,2)#'>
            <cfelse>
                <cfset AppropFY="#FY#">
            </cfif>
        <cfelse>
        	<cfset AppropFY = "">
        </cfif>

	  </CFLOOP>

       <tr id="lightcolor"><Td colspan="6">&nbsp;</Td></tr>
        <TR  id="darkcolor">
		<TD ALIGN="Center" COLSPAN="2" id="IssueDate3"><b>Vendor</B></TD>
		<TD ALIGN="Center" COLSPAN="2"  id="IssueDate3"><b>Name 2</B></TD>
		<TD ALIGN="Center" COLSPAN="2" id="IssueDate3"><B>Address</B></TD>
        </TR>
        <CFOUTPUT>
        <TR id="lightcolor">
		<TD ALIGN="center" COLSPAN="2" id="IssueDate3">#WarrHeader.Name1#</TD>
		<TD ALIGN="center" COLSPAN="2" id="IssueDate3">#WarrHeader.Name2#</TD>
		<TD ALIGN="center" COLSPAN="2" id="IssueDate3">#trim(WarrHeader.Address)#<cfif trim(Warrheader.City) is not "">;  </cfif>#trim(WarrHeader.City)#<cfif trim(WarrHeader.City) is not "">,  </cfif>#WarrHeader.State#  #WarrHeader.ZIP_Code#</TD>
        </TR>
		</CFOUTPUT>
      	<cfset TryApprop = "True">
      	<cfif TrybudgetAmt  is "True">
            <cftry>
            <CFQUERY NAME="Approp" <!---DATASOURCE=#application.whDSN#---> DATASOURCE="VendorDB2" <!---datasource="DB2Dev"---> CACHEDWITHIN="#CreateTimeSpan(0,0,10,0)#"> 
                    SELECT 	#application.whOwner#APPROP_#AppropFY#.NAME 
                    FROM 	#application.whOwner#APPROP_#AppropFY# 
                    WHERE 	#application.whOwner#APPROP_#AppropFY#.FUND = <cfqueryparam cfsqltype="cf_sql_char" value="#warrlines.FUND#"> AND 
                            #application.whOwner#APPROP_#AppropFY#.AGENCY = <cfqueryparam cfsqltype="cf_sql_char" value="#warrlines.AGENCY#"> AND 
                            #application.whOwner#APPROP_#AppropFY#.ORGANIZATION = <cfqueryparam cfsqltype="cf_sql_char" value="#warrlines.ORGANIZATION#"> AND 
                            #application.whOwner#APPROP_#AppropFY#.APPROPRIATION = <cfqueryparam cfsqltype="cf_sql_char" value="#warrlines.APPROPRIATION#"> 						
            </CFQUERY>
            
            <cfcatch type="any">
                <cfset TryApprop = "False">
            </cfcatch>
            </cftry> 
        
         <cfelse>
            <cfset TryApprop = "False">
         </cfif>
	
</TABLE>
</div>

<div name="FormWrapper" id="FormWrapper" class="table-responsive-new margintop30">
  <TABLE class="table table-striped table-bordered vendor-table">
    <thead>
        <TR>
            <TH ALIGN="LEFT" COLSPAN="9" id="IOCDetails">IOC Accounting Line Details</Th>
        </TR>
    </thead>
  	<TR id="darkcolor"> 
  		<TD ALIGN="center" id="IssueDate3"><b>Fund</b></TD>
  		<TD ALIGN="center" id="IssueDate3"><b>Agency</b></TD>
  		<TD ALIGN="center" id="IssueDate3"><b>Organization</b></TD>
  		<TD ALIGN="center" id="IssueDate3"><b>Appropriation</b></TD>
       	<TD ALIGN="center" id="IssueDate3"><b>Object</b></TD>
  		<TD ALIGN="center" id="IssueDate3"><b>Amount</b></TD>
  		<TD ALIGN="center" id="IssueDate3"><b>Appropriation Name</b></TD>
        <td align="center" id="IssueDate3"><b>Beginning Date of Service</b></td>
        <td align="center" id="IssueDate3"><b>End Date of Service</b></td>
  	</TR> 
	
 	<CFLOOP QUERY="WarrLines">
	  	<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>> 
  			<CFOUTPUT> 
            <TD ALIGN="CENTER" id="IssueDate3">#FUND#</TD>
            <TD ALIGN="CENTER" id="IssueDate3">#AGENCY#</TD>
            <TD ALIGN="CENTER" id="IssueDate3">#ORGANIZATION#</TD>
            <TD ALIGN="CENTER" id="IssueDate3">#APPROPRIATION#</TD>
            <TD ALIGN="CENTER" id="IssueDate3">#OBJECT#</TD>
            <TD ALIGN="right" id="IssueDate3">#dOLLarFormat(WARRANT_AMT)#</TD>
			</CFOUTPUT>

			<cfif TryApprop is "True">
				<cfif Approp.recordcount>
                    <CFOUTPUT>
                    <TD ALIGN="CENTER" id="IssueDate3">#Approp.NAME#</TD>
                    </CFOUTPUT> 
                <cfelse>
                    <!---<td>&nbsp;</td>--->
                </cfif>
            <cfelse>
            	<!---<td>&nbsp;</td>--->
            </cfif>
            <cfoutput>
            <TD ALIGN="CENTER" id="IssueDate3">#DateFormat(Begin_Serv_Date,"mm/dd/yyyy")#</TD>
            <TD ALIGN="CENTER" id="IssueDate3">#DateFormat(End_Serv_Date,"mm/dd/yyyy")#</TD>
            </TR></cfoutput>
        	
            <!---
            <TR><CFOUTPUT> 
            <TD ALIGN="center"  CLASS="groupTitle" colspan="2">Beginning Date of Service</TD>
            <TD ALIGN="left"  CLASS="groupTitle">#DateFormat(Begin_Serv_Date,"mm/dd/yyyy")#</TD> 
            <TD ALIGN="left"  CLASS="groupTitle" colspan="2">&nbsp;</TD> 
            <TD ALIGN="center" CLASS="groupTitle" colspan="2">End Date of Service</TD>
            <TD ALIGN="left"  CLASS="groupTitle">#DateFormat(End_Serv_Date,"mm/dd/yyyy")#</TD>  
            </CFOUTPUT> 
        	</TR>		
			<tr><td colspan="10">&nbsp;</td></tr>
		--->

	</CFLOOP>

  </TABLE> 
</div>

<div name="FormWrapper" id="FormWrapper" class="margintop30">
     <div class="table-responsive">
<cfif Results.Recordcount>
<TABLE class="table table-striped table-bordered vendor-table">
<thead>
<TR>
<Th COLSPAN="2" id="PaymentDesc">Payment Voucher Description</TD>
</TR>
</thead>
<TR id="darkcolor">
    <TD ALIGN="center" id="IssueDate3"><b>Line</b></TD>
    <TD id="IssueDate3"><b>Text</b></TD></TR>
<CFOUTPUT QUERY="RESULTS">
 <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
 <TD ALIGN="center"  id="IssueDate3">#LINE#</TD><TD id="IssueDate3">#TEXT#</TD>
</TR>
</CFOUTPUT>
</TABLE>
</CFIF>
</div>
<TABLE class="table table-striped table-bordered vendor-table">
<thead>
<TR>
<Th id="AgencyInfo">Agency Contact Information</TH>
</TR>
</thead>
<CFOUTPUT QUERY="WARRLINES" MAXROWS="1">
 <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
 <TD id="IssueDate3">#contact_info#</TD>
</TR>
</CFOUTPUT>
</TABLE>

<!--- Production --->
<div class="text-center"><p>Click <cfoutput><a href="http://illinoiscomptroller.gov/vendors/enhanced-vendor-remittance/instructions/" target="_new">
here</A></cfoutput> for assistance with this screen.</p></div>

</div>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
 <script>
	$('#ReturnBack').tooltip({
		'show': false,
			'placement':  'top',
			'title': "Click here to return back to the previous warrant listing."
	});
 
<!---

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
