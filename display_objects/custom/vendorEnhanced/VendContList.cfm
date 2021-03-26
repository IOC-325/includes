<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

<!---
Modified Date: 4-27-12
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Enhanced Vendor Remittance Site per SR11108 based on the regular site but requiring a UserID/Password

Modified Date: 10-14-14
	Modified By: Gary Ashbaugh
	Modifications Made: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

	Description:  Allows the users to view their Vendor Contracts
--->

<SCRIPT LANGUAGE="Javascript">
<!--           
function makeNewRemote(fileName) {
         remote = window.open("","remotewin","width=300,height=110,scrollbars=1");
		// remote.location.href = "http://dev.ioc-dev.ioc.com/Vendor/"+fileName+".cfm";
         remote.location.href = "http://illinoiscomptroller.gov/Vendor/"+fileName+".cfm";
             if (remote.opener == null) remote.opener = window; 
         remote.opener.name = "opener";
         }
         //-->

</SCRIPT>

<CFIF IsDefined ("URL.Agency")>
 <CFSET Agency = URL.Agency>
<cfelseif IsDefined ("form.Agency")>
 <CFSET Agency = form.Agency>
<!--- <cfelseif IsDefined ("Agency")>
 <CFSET Agency = Agency> --->
</CFIF>

<CFIF IsDefined ("URL.FY")>
 <CFSET FY = URL.FY>
<cfelseif IsDefined ("form.FY")>
 <CFSET FY = form.FY>
</CFIF>

<CFIF IsDefined ("form.Contsel")>
 <CFSET Contsel = form.Contsel>
<cfelseif IsDefined ("URL.Contsel")>
 <CFSET Contsel = URL.Contsel>
</CFIF>

<CFIF IsDefined ("form.POType")>
 <CFSET POType = form.POType>
<cfelseif IsDefined ("URL.POType")>
 <CFSET POType = URL.POType>
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

<CFIF IsDefined ("form.Mode")>
 <CFSET Mode = form.Mode>
<cfelseif IsDefined ("URL.Mode")>
 <CFSET Mode = URL.Mode>
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

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">
<CFSET Area="Contracts">
<cfparam NAME="url.StartRow" DEFAULT="1">
<cfparam name="Max" default="20">

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
<cfif (not isdefined("Session.VendTIN"))>
	<!--- Calls Index from VendorEnhanced --->
    <!--- Development & Production --->
	<cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>
</cfLock>

<CFHeader name="Cache-control" value="public">

<CFINCLUDE TEMPLATE="VendHeader.cfm">

<CFQUERY NAME="Results" DATASOURCE="#application.whDSN#" <!---cachedwithin="#CreateTImeSpan(0,1,0,0)#"--->>
<cfif left(ltrim(rtrim(Agency)),3) is "All" or left(ltrim(rtrim(Agency)),3) is "ACC" or left(ltrim(rtrim(Agency)),3) is "IPS">

		SELECT
        #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN
        , #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY
        , #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER
        , #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE
        , #application.whOwner#DESC_PO_TYPE.DESCRIPTION
        , #application.whOwner#SUMM_VEND_CONT_#FY#.CONTRACT_AMT as CONTRACT_SUM
        , Sum(#application.whOwner#SUMM_VEND_CONT_#FY#.CONTRACT_ENC_AMT) as CONTRACT_ENC_SUM
        , Sum(#application.whOwner#SUMM_VEND_CONT_#FY#.CONTRACT_EXP_AMT) as CONTRACT_EXP_SUM
        , #application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE
        , #application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE
        , #application.whOwner#TRANS_CONT_HDR_#FY#.ACCEPTANCE_DATE
        FROM
        #application.whOwner#SUMM_VEND_CONT_#FY#,
        #application.whOwner#TRANS_CONT_HDR_#FY#,
        #application.whOwner#DESC_PO_TYPE
        <!---WHERE
        #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY = #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_AGENCY AND
        #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER = #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_NUMBER AND
        #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN = #application.whOwner#TRANS_CONT_HDR_#FY#.VENDOR_TIN AND
        #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = #application.whOwner#DESC_PO_TYPE.TYPE_OF_ORDER AND

        <CFIF #ContAgy# is not "" and #ContSel# is not "">
            #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY = '#ContAgy#' AND
            #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER = '#UCase(ContSel)#' AND
        </CFIF>

        <CFIF #POType# is not "All">
            #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = '#POType#' AND
        </CFIF>

       <cfLock Scope="SESSION" TIMEOUT="120" type="readonly"> #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#' </cfLock> and
        #application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE IS NOT null and
        #application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE IS NOT null--->

        WHERE #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY = #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_AGENCY
        AND #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER = #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_NUMBER
        AND #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN = #application.whOwner#TRANS_CONT_HDR_#FY#.VENDOR_TIN
        AND #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = #application.whOwner#DESC_PO_TYPE.TYPE_OF_ORDER
        <cfif #ContSel# is not "">
           and #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#UCase(ContSel)#">
        </CFIF>

        <CFIF #POType# is not "All">
            And #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = <cfqueryparam cfsqltype="cf_sql_char" value="#POType#">
        </CFIF>

       <cfLock Scope="SESSION" TIMEOUT="120" type="readonly"> And #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"> </cfLock>
       and #application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE IS NOT null
       and #application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE IS NOT null

        GROUP BY #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN,
            #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY,
            #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER,
            #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE,
            #application.whOwner#DESC_PO_TYPE.DESCRIPTION,
            #application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE,
            #application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE,
            #application.whOwner#TRANS_CONT_HDR_#FY#.ACCEPTANCE_DATE,
            #application.whOwner#SUMM_VEND_CONT_#FY#.CONTRACT_AMT

        ORDER BY
        <CFIF #Sortby# is "Contract Number">
            #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER
            <CFIF #AscDesc# is "Asc">
            ASC
        	<CFELSE>
            DESC
        	</CFIF>
            ,FROM_DATE, ACCEPTANCE_DATE
        <CFELSEIF #Sortby# is "Total Contract Amount">
            CONTRACT_SUM
            <CFIF #AscDesc# is "Asc">
            ASC
        	<CFELSE>
            DESC
        	</CFIF>
            ,FROM_DATE, ACCEPTANCE_DATE
        <CFELSEIF #Sortby# is "Obligated Amount">
            CONTRACT_ENC_SUM
            <CFIF #AscDesc# is "Asc">
            ASC
        	<CFELSE>
            DESC
        	</CFIF>
            , FROM_DATE, ACCEPTANCE_DATE
        <CFELSEIF #Sortby# is "Expended Amount">
            CONTRACT_EXP_SUM
            <CFIF #AscDesc# is "Asc">
            ASC
        	<CFELSE>
            DESC
        	</CFIF>
            ,FROM_DATE, ACCEPTANCE_DATE
        <cfelse>
        	FROM_DATE, ACCEPTANCE_DATE
        </CFIF>
<CFELSE>
		<!--- Sort order doesn't match up...this even appears to pull different data --->
		<!---
		SELECT 	#application.whOwner#TRANS_CONT_LINE_#FY#.VENDOR_TIN,
				#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY,
				#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER,
				#application.whOwner#TRANS_CONT_LINE_#FY#.AGENCY,
				#application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE,
				#application.whOwner#DESC_PO_TYPE.DESCRIPTION,
				#application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE,
				<!--- ASP 4-6-01--->
				#application.whOwner#TRANS_CONT_HDR_#FY#.ACCEPTANCE_DATE,
				#application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE,
				#application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_AMT AS CONTRACT_SUM,
				Sum(#application.whOwner#TRANS_CONT_LINE_#FY#.CONTRACT_ENC_AMT) AS CONTRACT_ENC_SUM
		FROM 	#application.whOwner#TRANS_CONT_LINE_#FY#, #application.whOwner#TRANS_CONT_HDR_#FY#, #application.whOwner#DESC_PO_TYPE
		WHERE
				#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY = #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_AGENCY
				AND #application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER = #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_NUMBER
				AND #application.whOwner#TRANS_CONT_LINE_#FY#.VENDOR_TIN = #application.whOwner#TRANS_CONT_HDR_#FY#.VENDOR_TIN
				AND #application.whOwner#TRANS_CONT_LINE_#FY#.VENDOR_TIN = '#Variables.VendorTin#'
				AND	#application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = #application.whOwner#DESC_PO_TYPE.TYPE_OF_ORDER
				AND
				<CFIF #ContAgy# is not "" and #ContSel# is not "">
				#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY = '#ContAgy#' AND
				#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER = '#UCase(ContSel)#' AND
				</CFIF>
				<CFIF #POType# is not "All">
				#application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = '#POType#' AND
				</CFIF>
				#application.whOwner#TRANS_CONT_LINE_#FY#.AGENCY = '#Agency#'
<!--- modified on Thursday, May 08, 2003 9:37:50 AM --->
and #application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE IS NOT null
AND #application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE IS NOT null

		GROUP BY #application.whOwner#TRANS_CONT_LINE_#FY#.VENDOR_TIN
		,				#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY
		,			#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER
		,				#application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE
		,				#application.whOwner#DESC_PO_TYPE.DESCRIPTION
		,				#application.whOwner#TRANS_CONT_LINE_#FY#.AGENCY
		,				#application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE
		,				#application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE
		,				<!--- ASP 4-6-01--->
				#application.whOwner#TRANS_CONT_HDR_#FY#.ACCEPTANCE_DATE
		,		#application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_AMT
		ORDER
		BY
		<!--- ASP 4-6-01--->
		FROM_DATE, ACCEPTANCE_DATE
			<CFIF #Sortby# is "Contract Number">
				<!--- #application.whOwner#TRANS_CONT_LINE_#FY#. --->
				, TRANSACTION_NUMBER
			<CFELSEIF #Sortby# is "Total Contract Amount">
				, CONTRACT_SUM
			<CFELSEIF #Sortby# is "Obligated Amount">
				, CONTRACT_ENC_SUM
			<CFELSEIF #Sortby# is "Expended Amount">
				, CONTRACT_ENC_SUM
			</CFIF>
			<CFIF #AscDesc# is "Asc">
				ASC
			<CFELSE>
				DESC
			</CFIF>

		--->

        SELECT
        #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN
        , #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY
        , #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER
        , #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE
        , #application.whOwner#DESC_PO_TYPE.DESCRIPTION
        , #application.whOwner#SUMM_VEND_CONT_#FY#.CONTRACT_AMT as CONTRACT_SUM
        , Sum(#application.whOwner#SUMM_VEND_CONT_#FY#.CONTRACT_ENC_AMT) as CONTRACT_ENC_SUM
        , Sum(#application.whOwner#SUMM_VEND_CONT_#FY#.CONTRACT_EXP_AMT) as CONTRACT_EXP_SUM
        , #application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE
        , #application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE
        , #application.whOwner#TRANS_CONT_HDR_#FY#.ACCEPTANCE_DATE

        FROM
        #application.whOwner#SUMM_VEND_CONT_#FY#,
        #application.whOwner#TRANS_CONT_HDR_#FY#,
        #application.whOwner#DESC_PO_TYPE


        <!---WHERE
        #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY = #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_AGENCY AND
        #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER = #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_NUMBER AND
        #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN = #application.whOwner#TRANS_CONT_HDR_#FY#.VENDOR_TIN AND
        #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = #application.whOwner#DESC_PO_TYPE.TYPE_OF_ORDER AND

        <CFIF #ContAgy# is not "" and #ContSel# is not "">
			#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_AGENCY = '#ContAgy#' AND
			#application.whOwner#TRANS_CONT_LINE_#FY#.TRANSACTION_NUMBER = '#UCase(ContSel)#' AND
		</CFIF>
		<CFIF #POType# is not "All">
			#application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = '#POType#' AND
		</CFIF>
        #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY = '#Agency#' and
       <cfLock Scope="SESSION" TIMEOUT="120" type="readonly"> #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#' </cfLock> and
        #application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE IS NOT null and
        #application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE IS NOT null--->

        WHERE	#application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY = #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_AGENCY
        	AND #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER = #application.whOwner#TRANS_CONT_HDR_#FY#.TRANSACTION_NUMBER
            AND #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN = #application.whOwner#TRANS_CONT_HDR_#FY#.VENDOR_TIN
            AND #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = #application.whOwner#DESC_PO_TYPE.TYPE_OF_ORDER
            AND
			#application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY = <cfqueryparam cfsqltype="cf_sql_CHAR" value="#left(ltrim(rtrim(Agency)),3)#"> and
            <cfif #ContSel# is not "">
                #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_Number = <cfqueryparam cfsqltype="cf_sql_CHAR" value="#UCase(ContSel)#"> AND
            </CFIF>
            <CFIF #POType# is not "All">
                #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE = <cfqueryparam cfsqltype="cf_sql_CHAR" value="#POType#"> AND
            </CFIF>
       		<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">#application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"> </cfLock>
       		and #application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE IS NOT null
            and #application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE IS NOT null
        GROUP BY #application.whOwner#SUMM_VEND_CONT_#FY#.VENDOR_TIN,
            #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_AGENCY,
            #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER,
            #application.whOwner#TRANS_CONT_HDR_#FY#.CONTRACT_TYPE,
            #application.whOwner#DESC_PO_TYPE.DESCRIPTION,
            #application.whOwner#TRANS_CONT_HDR_#FY#.FROM_DATE,
            #application.whOwner#TRANS_CONT_HDR_#FY#.TO_DATE,
            #application.whOwner#TRANS_CONT_HDR_#FY#.ACCEPTANCE_DATE,
            #application.whOwner#SUMM_VEND_CONT_#FY#.CONTRACT_AMT

        ORDER BY
        <CFIF #Sortby# is "Contract Number">
            #application.whOwner#SUMM_VEND_CONT_#FY#.TRANSACTION_NUMBER
            <CFIF #AscDesc# is "Asc">
            ASC
        	<CFELSE>
            DESC
        	</CFIF>
            ,FROM_DATE, ACCEPTANCE_DATE
        <CFELSEIF #Sortby# is "Total Contract Amount">
            CONTRACT_SUM
            <CFIF #AscDesc# is "Asc">
            ASC
        	<CFELSE>
            DESC
        	</CFIF>
            ,FROM_DATE, ACCEPTANCE_DATE
        <CFELSEIF #Sortby# is "Obligated Amount">
            CONTRACT_ENC_SUM
            <CFIF #AscDesc# is "Asc">
            ASC
        	<CFELSE>
            DESC
        	</CFIF>
            , FROM_DATE, ACCEPTANCE_DATE
        <CFELSEIF #Sortby# is "Expended Amount">
            CONTRACT_EXP_SUM
            <CFIF #AscDesc# is "Asc">
            ASC
        	<CFELSE>
            DESC
        	</CFIF>
            ,FROM_DATE, ACCEPTANCE_DATE
        <cfelse>
        	FROM_DATE, ACCEPTANCE_DATE
        </CFIF>
	</CFIF>
</CFQUERY>


<CFSET #Max# = #max#>

<!--- Calls VendContList from VendorEnhanced --->
<!--- Development & Production --->
<CFSET #Query# = "/vendors/enhanced-vendor-remittance/vendor-contract-list/?Agency=#Agency#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#ContSel#&ContAgy=#Agency#&POType=#POType#&FY=#FY#&Mode=#Mode#&Max=#Max#&">

<cfif isdefined("Results")>
    <div class="marginb5">
<CFINCLUDE TEMPLATE="PrevNext.cfm">
    </div>
</cfif>

<div name="FormWrapper" id="FormWrapper" class="table-responsive">
<TABLE class="table table-striped vendor-table">
<thead>
<TR>
<TH class="text-center" id="ContractAgency"><A HREF="javascript: makeNewRemote('ContractAgency')"  TITLE="The Contract Agency is the Agency creating the contract." STYLE="cursor:help">Contract Agency</A></TH>
<TH class="text-center" id="Contract"><A HREF="javascript: makeNewRemote('ContractNumber')"  TITLE="The Contract Number is the identification number associated with the contract." STYLE="cursor:help">Contract</A></TH>
<TH class="text-center" id="Type"><A HREF="javascript: makeNewRemote('ContractType')"  TITLE="Type is the type of contract." STYLE="cursor:help">Type</A></TH>
<TH class="text-center" id="FromDate"><A HREF="javascript: makeNewRemote('ContractFromDate')"  TITLE="The From Date is when the contract started.">From Date</A></TH>
<TH class="text-center" id="ToDate"><A HREF="javascript: makeNewRemote('ContractToDate')"  TITLE="The To Date is when the contract ends.">To Date</A></TH>
<TH class="text-right" id="Amount"><A HREF="javascript: makeNewRemote('ContractAmount')"  TITLE="The Contract Amount is the total amount paid.">Contract Amount</A></TH>
<TH class="text-right" id="Obligated"><A HREF="javascript: makeNewRemote('Obligated')"  TITLE="The Obligated is the total amount of the contract.">Obligated</A></TH>
<!---<CFIF #Agency# is "All">---><TH ALIGN="right" id="Expended"><A HREF="javascript: makeNewRemote('Expended')"  TITLE="The Expended is the total amount accumulated for the contract.">Expended</A></TH><!---</CFIF>--->
</TR>
</thead>
<CFOUTPUT QUERY="Results" STARTROW="#StartRow#" MAXROWS="#Max#">
<TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>

	<TD ALIGN="CENTER" id="ContractAgency2">
		<cfif left(ltrim(rtrim(Agency)),3) is "All" or left(ltrim(rtrim(Agency)),3) is "ACC" or left(ltrim(rtrim(Agency)),3) is "IPS">

		 <A HREF="/vendors/enhanced-vendor-remittance/vendor-contact-detail/?Agency=#URLEncodedFormat(AGENCY)#&Contract=#URLEncodedFormat(TRANSACTION_NUMBER)#&ContAgcy=#TRANSACTION_AGENCY#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#URLEncodedFormat(ContSel)#&POType=#URLEncodedFormat(POType)#&FY=#URLEncodedFormat(FY)#&Max=#URLEncodedFormat(Max)#&Mode=#URLEncodedFormat(Mode)#" id="ContractDetail">#TRANSACTION_AGENCY#</a>
     	<Cfelse>
        	<A HREF="/vendors/enhanced-vendor-remittance/vendor-contact-detail/?Agency=#left(ltrim(rtrim(Agency)),3)#&Contract=#URLEncodedFormat(TRANSACTION_NUMBER)#&ContAgcy=#left(ltrim(rtrim(Agency)),3)#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#URLEncodedFormat(ContSel)#&POType=#URLEncodedFormat(POType)#&FY=#URLEncodedFormat(FY)#&Max=#URLEncodedFormat(Max)#&Mode=#URLEncodedFormat(Mode)#" id="ContractDetail">#TRANSACTION_AGENCY#</a>
        </cfif>
	</TD>
	<TD ALIGN="LEFT">
		<cfif left(ltrim(rtrim(Agency)),3) is "All" or left(ltrim(rtrim(Agency)),3) is "ACC" or left(ltrim(rtrim(Agency)),3) is "IPS">

		 <A HREF="/vendors/enhanced-vendor-remittance/vendor-contact-detail/?Agency=#URLEncodedFormat(AGENCY)#&Contract=#URLEncodedFormat(TRANSACTION_NUMBER)#&ContAgcy=#TRANSACTION_AGENCY#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#URLEncodedFormat(ContSel)#&POType=#URLEncodedFormat(POType)#&FY=#URLEncodedFormat(FY)#&Max=#URLEncodedFormat(Max)#&Mode=#URLEncodedFormat(Mode)#&StartRow=#StartRow#" id="ContractDetail">#TRANSACTION_Number#</a>
     	<Cfelse>
        	<A HREF="/vendors/enhanced-vendor-remittance/vendor-contact-detail/?Agency=#left(ltrim(rtrim(Agency)),3)#&Contract=#URLEncodedFormat(TRANSACTION_NUMBER)#&ContAgcy=#left(ltrim(rtrim(Agency)),3)#&Sortby=#URLEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&ContSel=#URLEncodedFormat(ContSel)#&POType=#URLEncodedFormat(POType)#&FY=#URLEncodedFormat(FY)#&Max=#URLEncodedFormat(Max)#&Mode=#URLEncodedFormat(Mode)#&StartRow=#StartRow#" id="ContractDetail">#TRANSACTION_Number#</a>
        </cfif>
	</TD>
	<TD ALIGN="LEFT" id="Type2">#DESCRIPTION#</TD>
	<TD ALIGN="CENTER" id="FromDate2">#DateFormat(FROM_DATE,"mm/dd/yy")#</TD>
	<TD ALIGN="CENTER" id="ToDate2">#DateFormat(TO_DATE,"mm/dd/yy")#</TD>
	<TD ALIGN="right" id="Amount2"><cfif TRANSACTION_AGENCY is not "999">#DollarFormat(CONTRACT_SUM)#<cfelse>#DollarFormat(0)#</cfif> </TD>
	<TD ALIGN="right" id="Obligated2"><cfif TRANSACTION_AGENCY is not "999">#DollarFormat(CONTRACT_ENC_SUM)#<cfelse>#DollarFormat(0)#</cfif> </TD>
	<TD ALIGN="right" id="Expended2"><cfif TRANSACTION_AGENCY is not "999">#DollarFormat(CONTRACT_EXP_SUM)#<cfelse>#DollarFormat(0)#</cfif> </TD>
</TR>
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
<script>

$('#First').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the first set of contract records."
	});
$('#Next').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the next set of contract records."
	});
$('#Previous').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the previous set of contract records."
	});
$('#Last').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the last set of contract records."
	});


<!---
	$('#ContractAgency').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the Agency who initiated the contract."
	});
	$('#Contract').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the contract number."
	});
	$('#Type').tooltip({
            'show': false,
                'placement': 'top',
                'title': "This is the contract type."
        });
	$('#FromDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the contract starting date."
	});
	$('#ToDate').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the contract ending date."
	});
	$('#Amount').tooltip({
		'show': false,
			'placement': 'top',
			'title': "This is the amount of the contract."
	});
	$('#Obligated').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The amount of the contract obligation."
	});
	$('#Expended').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The amount of the contract already spent."
	});
	$('#id="ContractDetail"').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to see the detail information regarding the Contract."
	});
	--->
</script>
<!---</BODY>
</HTML>--->

