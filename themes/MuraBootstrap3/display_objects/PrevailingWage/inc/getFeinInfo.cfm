<cfif IsDefined("form")> 
  <cfif IsDefined("form.FEIN") AND trim(form.FEIN) NEQ "">
    <cfset StructDelete(Session, "VENDOR_TIN")>    
    <cfset Session.VENDOR_TIN = trim(form.FEIN)>
  </cfif>
  <cfif IsDefined("form.VENDOR_TIN") AND trim(form.VENDOR_TIN) NEQ "">
    <cfset StructDelete(Session, "VENDOR_TIN")>    
    <cfset Session.VENDOR_TIN = trim(form.VENDOR_TIN)>
  </cfif>  
</cfif>


<cfif isDefined("Session.VENDOR_TIN")>

<CFQUERY NAME="qryGetContractList" DATASOURCE="DB2PRD">
SELECT 
WH.PW_CONTRACT.AGENCY
, WH.PW_CONTRACT.CONTRACT_NUMBER
, WH.PW_CONTRACT.CONTRACT_FROM_DATE
, WH.PW_CONTRACT.END_YR_TO_DATE
, WH.PW_CONTRACT.MAX_CONTRACT_AMT
, WH.PW_COUNTY.COUNTY_CODE
, WH.DESC_CNTY.NAME AS COUNTYNAME
, WH.AGENCY.NAME AS AGENCYNAME
FROM WH.PW_CONTRACT ,WH.PW_COUNTY  ,WH.DESC_CNTY ,WH.AGENCY
WHERE WH.PW_CONTRACT.VENDOR=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(Session.VENDOR_TIN)#" />
     AND WH.PW_CONTRACT.CONTRACT_NUMBER = WH.PW_COUNTY.CONTRACT_NUMBER
     AND WH.DESC_CNTY.CODE              = WH.PW_COUNTY.COUNTY_CODE   
     AND WH.AGENCY.AGENCY       = WH.PW_CONTRACT.AGENCY
     AND     WH.AGENCY.FISCAL_YEAR = 2017
GROUP BY WH.PW_CONTRACT.AGENCY
, WH.PW_CONTRACT.CONTRACT_NUMBER
, WH.PW_CONTRACT.CONTRACT_FROM_DATE
, WH.PW_CONTRACT.END_YR_TO_DATE
, WH.PW_CONTRACT.MAX_CONTRACT_AMT
, WH.PW_COUNTY.COUNTY_CODE
, WH.DESC_CNTY.NAME 
, WH.AGENCY.NAME 
</CFQUERY>

<CFQUERY NAME="qryGetVendorName_2" DATASOURCE="DB2PRD">
  SELECT VENDOR_NAME
  FROM WH.VENDOR
  WHERE WH.VENDOR.Vendor_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.VENDOR_TIN#" />
</CFQUERY>

<CFIF qryGetContractList.RecordCount>
<DIV ID="summary"><P>Here is a list of Prevailing Wage contracts for <CFOUTPUT><STRONG>#qryGetVendorName_2.Vendor_Name#</STRONG></CFOUTPUT>.</P></DIV>
<CFSET variables.vendor_Name=qryGetVendorName_2.Vendor_Name>
<DIV ID="content">
  <TABLE CELLPADDING="5" CELLSPACING="0" BORDER="1" BORDERCOLOR="#000000" WIDTH="100%" class="table-responsive">
  <TR>
  <TH>Agency</TH><TH>Contract</TH><TH>County</TH><TH>Amount</TH><TH>Date</TH><TH></TH>
  </TR>
  <CFOUTPUT QUERY="qryGetContractList">
  <TR <cfif currentrow mod 2 is 0>bgcolor="lightgray" color="black"</cfif>>
  <TD>#agencyname#</TD><TD ALIGN="right">#contract_number#</TD><TD ALIGN="right">#countyname#</TD><TD ALIGN="right">#DOLLARFORMAT(MAX_CONTRACT_AMT)#</TD><TD>#DATEFORMAT(CONTRACT_FROM_DATE,'m/d/yy')# - #dateFormat(END_YR_TO_DATE,'m/d/yy')#</TD><TD ALIGN="center">
    <CFSET newVendorName=Replace(variables.vendor_name, "&", "AND", "ALL")> 
  <a HREF="#$.content().getURL()#?mcaction=getDetailInfo&contract_NUMBER=#CONTRACT_NUMBER#&county_code=#county_code#&vendor_Name=#newVendorName#&agency=#agency#">Detail</a>
</TD>
  
  
  </tr></CFOUTPUT>
  
  </TABLE></DIV>
<CFELSE>
<DIV ID="notFound"><p>Sorry, no prevailing wage contracts have been reported to our Office for that FEIN Number.</p></DIV>
</CFIF>

</cfif>  

