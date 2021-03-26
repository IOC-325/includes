<cfif isDefined("form")>
  <cfset StructDelete(Session, "county_code")>
  <cfset Session.county_code = form.county_code>
</cfif>

<cfif isDefined("Session.county_code")>

<!---  
<CFQUERY NAME="qryGetCountyList" DATASOURCE="DB2PRD">
  SELECT A.NAME, B.VENDOR_NAME, C.COUNTY_CODE, D.AGENCY, D.CONTRACT_NUMBER
  ,D.MAX_CONTRACT_AMT, D.CONTRACT_FROM_DATE, D.END_YR_TO_DATE
  FROM WH.AGENCY A ,WH.VENDOR B ,WH.PW_COUNTY C ,WH.PW_CONTRACT D
  WHERE C.COUNTY_CODE     = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.county_code#" />                                 
  AND D.AGENCY          = C.AGENCY                                    
  AND D.CONTRACT_NUMBER = C.CONTRACT_NUMBER                           
  AND B.VENDOR_TIN      = D.VENDOR       
  AND A.AGENCY          = C.AGENCY                                    
  AND A.FISCAL_YEAR     = (SELECT MAX(FISCAL_YEAR) FROM WH.AGENCY E WHERE E.AGENCY  = C.AGENCY)     
</CFQUERY>--->
  
<CFQUERY NAME="qryGetCountyList" DATASOURCE="DB2TST">
  SELECT A.NAME, B.VENDOR_NAME, C.COUNTY_CODE, D.AGENCY, D.CONTRACT_NUMBER
  ,D.MAX_CONTRACT_AMT, D.CONTRACT_FROM_DATE, D.END_YR_TO_DATE
  FROM WH.AGENCY A ,WH.VENDOR B ,WH.PW_COUNTY C ,WH.PW_CONTRACT D
  WHERE C.COUNTY_CODE     = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.county_code#" />                                 
  AND D.AGENCY          = C.AGENCY                                    
  AND D.CONTRACT_NUMBER = C.CONTRACT_NUMBER                           
  AND B.VENDOR_TIN      = D.VENDOR       
  AND A.AGENCY          = C.AGENCY                                    
  AND A.FISCAL_YEAR     = (SELECT MAX(FISCAL_YEAR) FROM WH.AGENCY E WHERE E.AGENCY  = C.AGENCY)     
</CFQUERY>

<cfquery name="qryGetCounty" DATASOURCE="DB2PRD">
    SELECT WH.DESC_CNTY.NAME
    ,WH.DESC_CNTY.CODE
    FROM WH.DESC_CNTY
    where WH.desc_cnty.code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Session.county_code#" />
    ORDER BY WH.DESC_CNTY.NAME
</cfquery>

  <CFIF qryGetCountyList.recordcount><DIV align="center" ID="content">
    <CFSET variables.countyName = qryGetCounty.name>
    <TABLE CELLPADDING="5" CELLSPACING="0" BORDER="1" BORDERCOLOR="#000000" WIDTH="100%" class="table-responsive">
    <TR>
    <TH>Agency</TH><TH>Contract</TH><TH>Vendor</TH><TH>Amount</TH><TH>Date</TH><TH></TH>
    </TR>
    <CFOUTPUT QUERY="qryGetCountyList">
      <TR <cfif currentrow mod 2 is 0>bgcolor="lightgray" color="black"</cfif>>
        <TD>#Name#<!---  - #agency# ---></TD>
        <TD>#contract_number#</TD>
        <TD>#vendor_name#</TD>
        <TD>#DOLLARFORMAT(MAX_CONTRACT_AMT)#</TD>
        <TD>#DATEFORMAT(CONTRACT_FROM_DATE,'mm/dd/yy')# - #dateFormat(END_YR_TO_DATE,'mm/dd/yy')#</TD>
        <TD>
          <CFSET newVendorName=Replace(vendor_name, "&", "AND", "ALL")> 
          <a HREF="#$.content().getURL()#?mcaction=getDetailInfo&contract_NUMBER=#CONTRACT_NUMBER#&county_code=#county_code#&vendor_Name=#newVendorName#&County=#county_code#&CountyName=#variables.CountyName#&name=#name#&Agency=#agency#">Detail</a>
        </TD>
      </tr>
    </CFOUTPUT>  
    </TABLE>
    </div>
  <CFELSE>
    <cfoutput><div ID="summary"><p>Sorry, no prevailing wage contracts have been reported to our Office for that County.</p></div></cfoutput>
  </CFIF>

</cfif>  

