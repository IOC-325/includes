<CFQUERY name="qryGetContractDetail" DATASOURCE="DB2PRD">
SELECT 
  WH.PW_CONTRACT.AGENCY
, WH.PW_CONTRACT.CONTRACT_NUMBER
, WH.PW_CONTRACT.CONTRACT_FROM_DATE
, WH.PW_CONTRACT.END_YR_TO_DATE
, WH.PW_CONTRACT.MAX_CONTRACT_AMT
, WH.PW_COUNTY.COUNTY_CODE
, WH.DESC_CNTY.NAME AS COUNTYNAME
, WH.AGENCY.NAME AS AGENCYNAME
, WH.AGENCY.FISCAL_YEAR AS FISCAL_YEAR
FROM WH.PW_CONTRACT
  , WH.PW_COUNTY
  , WH.DESC_CNTY
    , WH.AGENCY
WHERE WH.PW_CONTRACT.CONTRACT_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.CONTRACT_NUMBER#" />
AND WH.DESC_CNTY.CODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.county_code#" />
and WH.PW_CONTRACT.AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.agency#" />
AND       WH.PW_CONTRACT.CONTRACT_NUMBER = WH.PW_COUNTY.CONTRACT_NUMBER
AND   WH.DESC_CNTY.CODE                     = WH.PW_COUNTY.COUNTY_CODE
AND   WH.AGENCY.AGENCY    =     WH.PW_CONTRACT.AGENCY
AND     WH.AGENCY.FISCAL_YEAR = 2017
 </CFQUERY>

<CFQUERY name="qryGetDescription" DATASOURCE="DB2PRD">
SELECT a.PW_description
FROM WH.PW_description as a
WHERE a.TEXT_LINE BETWEEN <cfqueryparam cfsqltype="cf_sql_integer" value="921"/> AND <cfqueryparam cfsqltype="cf_sql_integer" value="930"/>
AND a.CONTRACT_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.CONTRACT_NUMBER#" />
and a.AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.agency#" />
ORDER BY a.TEXT_LINE
</CFQUERY>

<CFQUERY name="qryGetLocation" DATASOURCE="DB2PRD">
SELECT a.PW_LOCATION
FROM WH.PW_LOcation as a
WHERE a.TEXT_LINE BETWEEN <cfqueryparam cfsqltype="cf_sql_integer" value="911"/> and <cfqueryparam cfsqltype="cf_sql_integer" value="920"/><!--- 901 AND 910 --->
AND a.CONTRACT_NUMBER = '#URL.CONTRACT_NUMBER#'
AND a.county_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.county_code#" />
and a.AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.agency#" />
ORDER BY a.TEXT_LINE
</CFQUERY>

<CFQUERY name="qryGetContract" DATASOURCE="DB2PRD">
  SELECT DISTINCT a.FUND, a.ORGANIZATION, a.APPROPRIATION, b.NAME
    FROM WH.TRANS_CONT_LINE a, WH.APPROP_NOXTND_NAME b
  WHERE TRANSACTION_AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.agency#" />
    AND TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.CONTRACT_NUMBER#" />
    AND a.APPROPRIATION = B.APPROPRIATION
    AND a.FUND = b.FUND
    AND a.ORGANIZATION = b.ORGANIZATION
    AND b.AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.agency#" />
    AND a.FISCAL_YEAR = b.FISCAL_YEAR
</CFQUERY>

<cfquery name="qryGetCounty" DATASOURCE="DB2PRD">
    SELECT WH.DESC_CNTY.NAME
    ,WH.DESC_CNTY.CODE
    FROM WH.DESC_CNTY
    where WH.desc_cnty.code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URL.county_code#" />
    ORDER BY WH.DESC_CNTY.NAME
</cfquery>


<DIV id="contractDetailContent" align="center">
  <CFOUTPUT><p>Here is the detail record for <STRONG>#URL.vendor_name#'s</STRONG> contract number <STRONG>#qryGetContractDetail.Contract_Number#</STRONG><CFIF isdefined("URL.county")> in <STRONG>#qryGetCounty.name#</STRONG> County</CFIF>.</CFOUTPUT><p><br />

  <TABLE rules="groups" cellpadding="5" cellspacing="0" border="1" bordercolor="#000000" WIDTH="100%" class="table-responsive">
  <CFOUTPUT query="qryGetContractDetail">
  <TR>
    <TH>Agency</TH><TD bgcolor="white">#AgencyNAME#</TD>
  </TR>
  <TR>
    <TH>Contract</TH><TD bgcolor="white">#CONTRACT_NUMBER#</TD>
  </TR>
  <TR valign="top">
    <TH>Amount</TH><TD bgcolor="white">#DollarFormat(MAX_CONTRACT_AMT)#</TD>
  </TR>
  <TR valign="top">
    <TH>Contract Term</TH><TD bgcolor="white">#DateFormat(CONTRACT_FROM_DATE,'mm/dd/yy')# - #dateFormat(END_YR_TO_DATE,'mm/dd/yy')#</TD>
  </TR>
  <TR valign="top">
    <TH>County</TH><TD bgcolor="white">#COUNTYName#</TD>
  </TR> 
  </CFOUTPUT>
<TR valign="top">
    <TH>Location</TH><TD bgcolor="white"><CFOUTPUT query="qryGetLocation">#PW_Location#<BR></CFOUTPUT> </Th>
  </TR>
<TR valign="top">
    <TH>Description</TH><TD bgcolor="white"><CFOUTPUT query="qryGetdESCRIPTION">
    <cfset ctyList = "001,003,005,007,009,011,013,015,017,019,021,023,025,027,029,031,033,035,037,039,041,043,045,047,049,051,053,055,057,059,061,063,065,067,069,071,073,075,077,079,081,083,085,087,089,091,093,095,097,099,101,103,105,107,109,111,113,115,117,119,121,123,125,127,129,131,133,135,137,139,141,143,145,147,149,151,153,155,157,159,161,163,165,167,169,171,173,175,177,179,181,183,185,187,189,191,193,195,197,199,201,203">
  <cfset myLeft = left(PW_Description, 3)>
  <cfif listcontains(ctyList, myLeft)>
  <cfset variables.myDescription = Right(PW_Description, len(PW_Description) - 4)>
  <cfelse>
  <cfset variables.myDescription = PW_Description>
  </cfif>
   #variables.myDescription#<BR></CFOUTPUT> </Th>
  </TR>
  </TABLE>
  
  <TABLE width="60%"  rules="groups" cellpadding="5" cellspacing="0" border="1" bordercolor="#000000">
    <tr>
    <th>Fund</th>
    <th>Agency</th>
    <th>Organization</th>
    <th>Appropriation</th>
    <th>Appropriation Name</th>
    </tr>
    <cfif qryGetContract.recordCount EQ "0">
      <cfoutput><tr><td align="center" colspan="5"> Appropriation information is not available.</td></tr></cfoutput>
    <cfelse>
      <cfoutput query="qryGetContract">
        <tr>
        <td>#FUND#</td>
        <td>#URL.agency#</td>
        <td>#ORGANIZATION#</td>
        <td>#APPROPRIATION#</td>
        <td>#NAME#</td>
         </tr>  
        </cfoutput>      
    </cfif>      
    
  </TABLE>
  <br/>
  <p> <a href="<cfoutput>#$.content().getURL()#</cfoutput>"> Click here to return <a> </p>
  
</DIV>  