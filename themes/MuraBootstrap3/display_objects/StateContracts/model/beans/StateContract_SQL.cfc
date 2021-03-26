
<!---
Date Created: 09-26-2017
Created By: Ramesh Kumar
Description: The component contains  functions:
--->

<cfcomponent hint="Contact Information">

<!--- <cffunction name="GetContractInfo" ACCESS="Public" output="False" hint="Get list of State Contracts" returntype="any">
	<cfargument name="FY" type="String" required="Yes">
	<cfargument name="Vendor" type="String" required="Yes">
	<cfargument name="Srce" type="string" required="Yes">

	<cftry>
	<cfoutput>

  	<cfif trim(Vendor) is not "">
    	<cfquery DATASOURCE="#Srce#" NAME="getContractInfo">
        SELECT TOP 100 *
        FROM dbo.IOC_CONTRACTS
        WHERE  Fiscal_Year = #FY# <!--- and Contract_Type <> 'J' --->
            AND ltrim(rtrim(Name)) like <cfqueryparam cfsqltype="cf_sql_varChar" value="#Vendor#">
            AND ltrim(rtrim(CONTRACT_NUMBER)) like <cfqueryparam cfsqltype="cf_sql_varChar" value="#Vendor#">
        ORDER BY Name, Agency_Name ASC
        </cfquery>
    <cfelse>
    	<cfquery DATASOURCE="#Srce#" NAME="getContractInfo" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
        SELECT TOP 100 *
        FROM dbo.IOC_CONTRACTS
        WHERE Fiscal_Year = #FY# <!---nd Contract_Type <> 'J'--->
        ORDER BY Name, Agency_Name ASC
        </cfquery>
    </cfif>
    <cfdump var="#getContractInfo#" abort="true">
	<cfreturn "#getContractInfo#">
	</cfoutput>

	<cfcatch type="database">
	<b>Sorry, we could not process your request!  The most likely reason is because the State Contract Database is currently being updated!  Please try again later!</b><cfabort>
	</cfcatch>
	</cftry>
</cffunction> --->
<cffunction name="GetContractInfo" access="Public" output="False" returntype="any">
    <cfargument name="formData" type="struct" required="yes">


    <CFIF IsDefined ("formData.SortColumn")>
        <!--- Sort Column --->
        <cfswitch expression="#FormData.SortColumn#">
            <cfcase value="1"><CFSET SC = "Agency_Name"></cfcase>
            <cfcase value="2"><CFSET SC = "Contract_Number"></cfcase>
            <cfcase value="3"><CFSET SC = "Award_Description"></cfcase>
            <cfcase value="4"><CFSET SC = "Type_Description"></cfcase>
            <cfcase value="5"><CFSET SC = "Class_Description"></cfcase>
            <cfcase value="6"><CFSET SC = "Name"></cfcase>
            <cfcase value="7"><CFSET SC = "NameII"></cfcase>
            <cfcase value="8"><CFSET SC = "From_Date"></cfcase>
            <cfcase value="9"><CFSET SC = "To_Date"></cfcase>
            <cfcase value="10"><CFSET SC = "Contract_Amt"></cfcase>
            <cfcase value="11"><CFSET SC = "Max_Contract_Amt"></cfcase>
            <cfcase value="12"><CFSET SC = "Expended_Amt"></cfcase>
            <cfcase value="13"><CFSET SC = "CTD_Document"></cfcase>
            <cfdefaultcase><CFSET SC = "Agency_Name"></cfdefaultcase>
        </cfswitch>
        <!--- Sort Direction --->
        <cfswitch expression="#FormData.SortDirection#">
            <cfcase value="0"><CFSET SD = "ASC"></cfcase>
            <cfdefaultcase><CFSET SD = "DESC"></cfdefaultcase>
        </cfswitch>
    <cfelse>
        <CFSET SC = "Agency_Name">
        <CFSET SD = "ASC">
    </CFIF>
 
        <cfquery NAME="getContractInfo" DATASOURCE="ContractsData">
            SELECT *
            FROM dbo.IOC_CONTRACTS
            WHERE  1=1

           <CFIF IsDefined ("formData.contractVendor") AND formData.contractVendor IS NOT 0 AND TRIM(formData.contractVendor) IS NOT "">
                Name = <cfqueryparam cfsqltype="cf_sql_varChar" value="#formData.contractVendor#">
           </CFIF>
           <CFIF formData.contractFY IS NOT 0 AND TRIM(formData.contractFY) IS NOT "">
                AND Fiscal_Year = <cfqueryparam value="#formData.contractFY#" cfsqltype="CF_SQL_VARCHAR" maxlength="4">
            </CFIF>

            <CFIF TRIM(formData.contractAgency) IS NOT 0 AND TRIM(formData.contractAgency) IS NOT "">
                  AND Agency_Name = <cfqueryparam value="#formData.contractAgency#" cfsqltype="cf_sql_varchar" maxlength="255">
            </CFIF>

           <CFIF TRIM(formData.contractAward) IS NOT 0 AND TRIM(formData.contractAward) IS NOT "">
                  AND Award_Description = <cfqueryparam value="#formData.contractAward#" cfsqltype="cf_sql_varchar" maxlength="255">
            </CFIF>
            <CFIF TRIM(formData.contractType) IS NOT 0 AND TRIM(formData.contractType) IS NOT "">
                  AND Type_Description = <cfqueryparam value="#formData.contractType#" cfsqltype="cf_sql_varchar" maxlength="255">
            </CFIF>
            <CFIF TRIM(formData.contractClass) IS NOT 0 AND TRIM(formData.contractClass) IS NOT "">
                AND CLASS_DESCRIPTION = <cfqueryparam value="#formData.contractClass#" cfsqltype="cf_sql_varchar" maxlength="255">
            </CFIF>

            <CFIF TRIM(formData.FindVendor) IS NOT "">
                AND (name LIKE <cfqueryparam value="%#UCASE(formData.FindVendor)#%" cfsqltype="cf_sql_varchar" maxlength="50">
                OR CONTRACT_NUMBER LIKE <cfqueryparam value="%#UCASE(formData.FindVendor)#" cfsqltype="cf_sql_varchar" maxlength="50">)
            </CFIF>
            ORDER BY #SC# #SD#
        </cfquery>
        <!--- <cfdump var="#getContractInfo#" abort="true"> --->
    <cfreturn getContractInfo>
</cffunction>

<cffunction name="GetDefaultYear" ACCESS="Public" output="False" hint="Get Default Year" returntype="Any" >
	<cfargument name="Srce" type="string" required="Yes">

	<cftry>
	<cfoutput>
    <cfquery DATASOURCE="#Srce#" NAME="GetFY" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
        SELECT distinct Fiscal_Year
        FROM dbo.IOC_CONTRACTS
        <!--- where Contract_Type <> 'J' ---> 
        order by Fiscal_Year desc
    </cfquery>
    </cfoutput>

    <cfreturn GetFY>

	<cfcatch type="database">
	<b>Sorry, we could not process your request!  The most likely reason is because the State Contract Database is currently being updated!  Please try again later!</b><cfabort>
	</cfcatch>
	</cftry>

</cffunction>

<!--- Get Fiscal years --->
<cffunction name="GetAllFiscalYears" access="public" returntype="query" >

    <cfquery DATASOURCE="ContractsData" NAME="qFY" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
        SELECT distinct Fiscal_Year AS FISCALYEAR 
        FROM dbo.IOC_CONTRACTS
        <!--- where Contract_Type <> 'J' ---> 
        order by Fiscal_Year desc
    </cfquery>

  <cfreturn qFY>
</cffunction>
<!--- Get all Agency Names --->
<cffunction name="GetAgencyNames" access="public" returntype="query" >

    <cfquery DATASOURCE="ContractsData" NAME="qAN" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
        SELECT Distinct Agency_Name AS AgencyName 
        FROM dbo.IOC_CONTRACTS
        <!--- where Contract_Type <> 'J' ---> 
        Group By Agency_Name 
        ORDER BY Agency_Name ASC

    </cfquery>

  <cfreturn qAN>
</cffunction>

<!--- Get all Award Descriptions --->
<cffunction name="GetAwardDescriptions" access="public" returntype="query" >
    <cfquery DATASOURCE="ContractsData" NAME="qAD" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
        SELECT  Distinct Award_Description AS AwardDescription 
        FROM dbo.IOC_CONTRACTS
        <!---where  Contract_Type <> 'J' ---> 
        Group By Award_Description 
        ORDER BY Award_Description ASC
    </cfquery>

  <cfreturn qAD>
</cffunction>
<!--- Get all Type Descriptions --->
<cffunction name="GetAllTypeDescriptions" access="public" returntype="query" >
    <cfquery DATASOURCE="ContractsData" NAME="qATD" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
        SELECT  Distinct Type_Description AS TypeDescription
        FROM dbo.IOC_CONTRACTS
        WHERE Type_Description  <> 'File Only'
        <!---where  Contract_Type <> 'J' ---> 
       	Group By Type_Description
        ORDER BY Type_Description ASC
    </cfquery>

  <cfreturn qATD>
</cffunction>
<!--- Get all Class Descriptions --->

<cffunction name="GetAllClassDescriptions" access="public" returntype="query" >
   <cfquery DATASOURCE="ContractsData" NAME="qCD" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
       SELECT Distinct Class_Description AS ClassDescription
        FROM dbo.IOC_CONTRACTS
        WHERE Class_Description IS NOT NULL
        AND Class_Description <> 'VENDOR CORR'
        <!--- where Contract_Type <> 'J' ---> 
       	Group By Class_Description
        ORDER BY Class_Description ASC
    </cfquery> 
  <cfreturn qCD>
</cffunction>
<!--- Get All Vendor Names --->
<cffunction name="GetAllVendorNames" access="public" returntype="query" >
    <cfquery DATASOURCE="ContractsData" NAME="qAVN" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
      SELECT Distinct Name AS vendorName
        FROM dbo.IOC_CONTRACTS
        <!--- where Contract_Type <> 'J' ---> 
       	Group By Name
        ORDER BY Name ASC
    </cfquery>

  <cfreturn qAVN>
</cffunction>

<cffunction name="decodeHtmlEntity" returntype="string" output="false">
    <cfargument name="str" type="string" hint="&##<number>; or &<name>;" />
    <cfset var XML = '<xml>#arguments.str#</xml>' />
    <cfset var XMLDoc = '' />

    <!--- ampersands that aren't pre-encoded as entities cause errors --->
    <cfset XML = REReplace(XML, '&(?!(\##\d{1,3}|\w+);)', '&amp;', 'all') />

    <cftry>
        <cfset XMLDoc = XmlParse(XML) />
        <cfreturn XMLDoc.XMLRoot.XMLText />
        <cfcatch>
            <cfreturn arguments.str />
        </cfcatch>
    </cftry>
</cffunction>

<!--- sr 16101 - this is for the CONTRACTS ledger query - when the user clicks on State Contracts, and pulls up the details --->
  <cffunction name="VendorWarrantListingDatesAmounts" ACCESS="remote" hint="Get Vendor Warrant Listing Dates and Amounts" returntype="any">
   <cfargument name="Agency" required="no" type="string">
   <cfargument name="ContractNum" required="no" type="string">
   <cfargument name="ClassCode" required="no" type="string">
   <cfargument name="VendorName" required="no" type="string">
   <cfargument name="Fiscal_Year" type="string" required="yes">

 <!---     <cfquery datasource="ContractsData" name="results">
       SELECT TRANS_WARR_LINE.ACCEPTANCE_DATE
       , TRANS_WARR_LINE.WARRANT_AMT AS EXPENDED_AMT
       ,TRANS_WARR_LINE.VOUCHER_NUMBER
       ,(SELECT DISTINCT AGENCY_NAME FROM [dbo].[IOC_CONTRACTS] WHERE CONTRACT_NUMBER = IOC_PAYMENT_DETAIL.CONTRACT_NUMBER AND  [IOC_CONTRACTS].AGENCY = AGENCY) AS 'AGENCY_NAME'
       FROM dbo.TRANS_WARR_LINE INNER JOIN dbo.IOC_PAYMENT_DETAIL ON 
       TRANS_WARR_LINE.VOUCHER_AGENCY = IOC_PAYMENT_DETAIL.VOUCHER_AGENCY AND TRANS_WARR_LINE.VOUCHER_NUMBER = IOC_PAYMENT_DETAIL.VOUCHER_NUMBER 
       WHERE IOC_PAYMENT_DETAIL.VOUCHER_AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(Agency)#">
       AND IOC_PAYMENT_DETAIL.CONTRACT_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ContractNum#">
       ORDER BY TRANS_WARR_LINE.ACCEPTANCE_DATE DESC,  TRANS_WARR_LINE.WARRANT_AMT DESC
     </cfquery> --->
         <cfquery datasource="ContractsData" name="results">
          EXEC DBO.OPENKEYS
          SELECT 
            TWL.ACCEPTANCE_DATE AS ACCEPTANCE_DATE,
            Sum(VOUCHER_AMT) AS EXPENDED_AMT ,
            VOUCHER_NUMBER ,
            Name AS VENDOR_NAME,
            (SELECT Name From dbo.AGENCY A WHERE A.AGENCY = TWL.AGENCY 
                AND A.FISCAL_YEAR = TCH.FISCAL_YEAR) AS AGENCY_NAME
          From dbo.TRANS_WARR_LINE  TWL INNER JOIN dbo.TRANS_CONTRACT_HEADER TCH ON 
          dbo.Decrypt(TWL.Vendor_Tin) = dbo.Decrypt(TCH.Vendor_Tin)
          AND NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendorName#">
          AND TCH.FISCAL_YEAR = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Fiscal_Year#">

          AND TWL.AGENCY = TCH.TRANSACTION_AGENCY
          AND TWL.CONTRACT_NUMBER = TCH.TRANSACTION_NUMBER          
          GROUP BY TWL.ACCEPTANCE_DATE, TWL.Vendor_Tin, VOUCHER_NUMBER , CONTRACT_NUMBER, TWL.AGENCY, TCH.FISCAL_YEAR, 
            TWL.TRANSACTION_CODE, TCH.NAME
          HAVING CONTRACT_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ContractNum#">
          AND TWL.AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(Agency)#">
          ORDER BY ACCEPTANCE_DATE DESC, EXPENDED_AMT DESC
     </cfquery>
<!---      <cfquery datasource="DB2PRD" name="results">
       SELECT ACCEPTANCE_DATE
       , SUM(EXPENDED_AMT) AS EXPENDED_AMT
       FROM WH.TRANS_EXP
       WHERE REF_CONTRACT_AGNCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(Agency)#">
       AND REF_CONTRACT_NUM =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#ContractNum#">
       AND EXPENDED_AMT <> 0
       GROUP BY ACCEPTANCE_DATE ORDER BY ACCEPTANCE_DATE DESC
     </cfquery> --->
   <cfset returnArray = arrayNew(1)>
   <cfset varTemp = 0>

   <cfloop query="results">
       <cfset resultStruct = StructNew() />
       <cfset resultStruct["ACCEPTANCE_DATE"] = DateFormat(ACCEPTANCE_DATE,'m/d/yy') />
       <cfset resultStruct["VOUCHER_NUMBER"] = VOUCHER_NUMBER />
       <cfset resultStruct["AGENCY_NAME"] = AGENCY_NAME />
       <cfset resultStruct["VENDOR_NAME"] = VENDOR_NAME />
       <cfset resultStruct["EXPENDED_AMT"] = DollarFormat(EXPENDED_AMT) />
       <cfset varTemp = varTemp + EXPENDED_AMT/>
       <cfset resultStruct["TOTAL_AMT"] = DollarFormat(varTemp) />
       <cfset ArrayAppend(returnArray,resultStruct) />
   </cfloop>
        <cfreturn returnArray>

     <cfreturn results>
 </cffunction>

  <!--- Get Contract Details per contract Number --->
    <cffunction name="GetContractDetailsPerCN" access="public" output="no" returntype="query">
    <cfargument name="Contract_Number" type="string" required="yes">
    <cfargument name="Fiscal_Year" type="string" required="yes">
    <cfargument name="Transaction_Agency" type="string" required="yes">
    <cfargument name="Class_Code" type="string" required="yes">


    <cfquery name="qCD" datasource="ContractsData">
    Select
    TRANSACTION_AGENCY + ' ' + TRANSACTION_NUMBER AS CONTRACT_NUMBER
    ,ACCEPTANCE_DATE AS DATE
    ,MASTER_AGENCY AS MASTER
    ,MAX_CONTRACT_AMT
    ,CONTRACT_AMT
    ,(SELECT MAX_CONTRACT_AMT 
        FROM   dbo.trans_contract_header A 
        WHERE  A.fiscal_year = TCH.fiscal_year 
               AND A.TRANSACTION_NUMBER = TCH.master_contract
               AND A.TRANSACTION_AGENCY = '999') AS MASTER_CONTRACT_MAX_AMOUNT
    ,(SELECT Sum(MAX_CONTRACT_AMT)
       FROM  dbo.TRANS_CONTRACT_HEADER A
         WHERE A.FISCAL_YEAR = TCH.FISCAL_YEAR AND
             A.MASTER_CONTRACT = TCH.master_contract) AS REFERNCING_CONTRACT_MAX_AMOUNT
    ,'*****' + RIGHT(VENDOR_TIN,5) + VENDOR_ADDR_IND AS VENDOR
    ,LEGAL_STATUS
    ,NAME
    ,FROM_DATE
    ,TO_DATE
    ,MULT_FY_FROM_DATE
    ,MULT_FY_TO_DATE
    ,VENDOR_ADDR_IND
    ,'' AS ADDRESS
    ,CITY
    ,STATE
    ,CLOSED_DATE
    ,TRAVEL_IND
    ,TRAVEL_AMT
    ,CMPNSATON_PAY_RATE
    ,FISCAL_YEAR
    ,UNIT_OF_TIME
    ,U.DESCRIPTION AS UNIT_DESCRIPTION    
    ,TCH.AWARD_CODE
    ,W.AwardDescription AS AWARD_DESCRIPTION
    ,CONTRACT_TYPE
    ,CT.DESCRIPTION AS CONTRACT_DESCRIPTION
    ,TCH.CLASS_CODE
    ,C.DESCRIPTION AS CLASS_DESCRIPTION
    ,FIXED_PRICE_FLAG
    ,ADVANCE_PYMNT_IND
    ,FEE_FLAG AS FEE_STATUS
    ,FEE_AMT AS CONTRACT_FEE
    ,PUBLICATION_DATE
    ,REF_NUMBER
    ,SUBCONTRACTR_UTIL
    ,SUBCONTRACTR_DISCL AS DISCLOSED
    ,(SELECT DISTINCT AGENCY_NAME FROM [dbo].[IOC_CONTRACTS] WHERE CONTRACT_NUMBER = TCH.TRANSACTION_NUMBER 
        AND  [IOC_CONTRACTS].AGENCY = TCH.TRANSACTION_AGENCY) AS 'AGENCY_NAME'
    ,MASTER_CONTRACT
    ,(SELECT Min(FISCAL_YEAR) FROM dbo.TRANS_CONTRACT_HEADER WHERE TRANSACTION_NUMBER = TCH.TRANSACTION_NUMBER AND TRANSACTION_AGENCY = TCH.TRANSACTION_AGENCY)  AS Begin_FY
    ,(SELECT Max(FISCAL_YEAR) FROM dbo.TRANS_CONTRACT_HEADER WHERE TRANSACTION_NUMBER = TCH.TRANSACTION_NUMBER AND TRANSACTION_AGENCY = TCH.TRANSACTION_AGENCY)  AS End_FY    
    FROM dbo.TRANS_CONTRACT_HEADER TCH 
    LEFT JOIN dbo.UNIT U ON U.UNIT = TCH.UNIT_OF_TIME
    LEFT JOIN dbo.IOC_AWARD W ON W.AWARD_CODE = TCH.AWARD_CODE
    LEFT JOIN dbo.CLASS_CODE C ON C.CLASS_CODE = TCH.CLASS_CODE AND C.PO_TYPE = TCH.CONTRACT_TYPE 
    LEFT JOIN dbo.CONTRACT_TYPE CT ON CT.TYPE_OF_ORDER = TCH.CONTRACT_TYPE
    WHERE FISCAL_YEAR = <cfqueryparam value="#TRIM(Fiscal_Year)#" cfsqltype="cf_sql_varchar" maxlength="4"> AND
    TRANSACTION_NUMBER = <cfqueryparam value="#TRIM(Contract_Number)#" cfsqltype="cf_sql_varchar" maxlength="11"> AND
    TRANSACTION_AGENCY = <cfqueryparam value="#TRIM(Transaction_agency)#" cfsqltype="cf_sql_varchar" maxlength="3"> AND
    TCH.Class_Code =  <cfqueryparam value="#TRIM(Class_Code)#" cfsqltype="cf_sql_varchar" maxlength="3">
    </cfquery>

      <cfreturn qCD>
    </cffunction>
    <!--- Get Fund Information per Contract Number and Fiscal Year --->
   <cffunction name="GetContractFundInfoPerContractNumber" access="public" output="no" returntype="query">
    <cfargument name="Contract_Number" type="string" required="yes">
    <cfargument name="Fiscal_Year" type="string" required="yes">
    <cfargument name="Transaction_Agency" type="string" required="yes">
    <cfargument name="Class_Code" type="string" required="yes">
        <!--- -- Select  Fund,
        --       ORGANIZATION,
        --           OBJECT,
        --           APPROPRIATION,
        --           Sum(CONTRACT_ENC_AMT) AS LINE_AMOUNT
        --           From dbo.TRANS_CONTRACT_LINE
        --           GROUP BY Fund, ORGANIZATION, OBJECT, APPROPRIATION, FISCAL_YEAR, TRANSACTION_NUMBER, TRANSACTION_AGENCY
        --           HAVING FISCAL_YEAR = <cfqueryparam value="#TRIM(Fiscal_Year)#" cfsqltype="cf_sql_varchar" maxlength="4"> AND
        --           TRANSACTION_NUMBER = <cfqueryparam value="#TRIM(Contract_Number)#" cfsqltype="cf_sql_varchar" maxlength="11"> AND
        --           TRANSACTION_AGENCY = <cfqueryparam value="#TRIM(Transaction_agency)#" cfsqltype="cf_sql_varchar" maxlength="3"> --->

    <cfquery name="qCD2" datasource="ContractsData">
          EXEC DBO.OPENKEYS
          SELECT Fund, ORGANIZATION, OBJECT, APPROPRIATION,SUM(CONTRACT_ENC_AMT) AS LINE_AMOUNT
          FROM 
          (
            Select Fund, ORGANIZATION, OBJECT, APPROPRIATION,CONTRACT_ENC_AMT, FISCAL_YEAR, TRANSACTION_NUMBER,TRANSACTION_AGENCY
            From dbo.TRANS_CONTRACT_LINE 
            WHERE FISCAL_YEAR = <cfqueryparam value="#TRIM(Fiscal_Year)#" cfsqltype="cf_sql_varchar" maxlength="4"> AND 
            TRANSACTION_NUMBER = <cfqueryparam value="#TRIM(Contract_Number)#" cfsqltype="cf_sql_varchar" maxlength="11"> AND TRANSACTION_AGENCY = <cfqueryparam value="#TRIM(Transaction_agency)#" cfsqltype="cf_sql_varchar" maxlength="3">
            AND dbo.Decrypt(VENDOR_TIN) IN 
              (SELECT dbo.Decrypt(VENDOR_TIN) FROM dbo.TRANS_CONTRACT_HEADER 
                WHERE TRANSACTION_NUMBER= <cfqueryparam value="#TRIM(Contract_Number)#" cfsqltype="cf_sql_varchar" maxlength="11"> 
                AND FISCAL_YEAR = <cfqueryparam value="#TRIM(Fiscal_Year)#" cfsqltype="cf_sql_varchar" maxlength="4"> AND 
                Class_Code =  <cfqueryparam value="#TRIM(Class_Code)#" cfsqltype="cf_sql_varchar" maxlength="3">)
          ) VT
          GROUP BY Fund, ORGANIZATION, OBJECT, APPROPRIATION, FISCAL_YEAR, TRANSACTION_AGENCY,  TRANSACTION_NUMBER

    </cfquery>

    <cfreturn qCD2>
   </cffunction>

 <!--- Get Friendly Names for State Contracts --->  
 <cffunction name="GetFreindlyName_StateContracts" output="no" access="public" returntype="struct">

    <cfset FN1.val1 = "">
    <cfset FN1.val2 = "">
    <cfset FN1.val3 = "">
    <cfset FN1.val4 = "">
    <cfset FN1.val5 = "">
    <cfset FN1.val6 = "">
          <!--- 
        LEGEND: 
        1) FindVendor
        2) contractFY
        3) contractAgency
        4) contractAward
        5) contractType
        6) contractClass --->
    

    <CFIF ListLen(cookie.StateContracts) IS 6>
    <!--- Get Submitted values --->
  <CFSET C1_FindVendor = ListGetAt(cookie.StateContracts,1)>
    <CFSET C1_contractFY = ListGetAt(cookie.StateContracts,2)>
    <CFSET C1_contractAgency = ListGetAt(cookie.StateContracts,3)>
    <CFSET C1_contractAward = ListGetAt(cookie.StateContracts,4)>
    <CFSET C1_contractType = ListGetAt(cookie.StateContracts,5)>
    <CFSET C1_contractClass = ListGetAt(cookie.StateContracts,6)>
    
      <!--- Get fund name --->
    <CFIF C1_FindVendor IS NOT "Default">
        <!---   <cftry> --->
          
            <CFSET FN1.val1 = C1_FindVendor>
          <!---   <cfcatch type="any"> <CFSET FN1.val1 =  ""></cfcatch>
      </cftry> --->
        </CFIF>
        <!--- Get group name --->
        <CFIF C1_contractFY IS NOT "Default">
      <!---   <cftry> --->
           
          <CFSET FN1.val2 =  C1_contractFY>
         <!---  <cfcatch type="any"> <CFSET FN1.val2 = ""></cfcatch>
           </cftry> --->
        </CFIF>
        <!--- Get category name --->
         <CFIF C1_contractAgency IS NOT "Default">
        <!---  <cftry> --->
            <cfquery datasource="ContractsData" NAME="q3" cachedwithin="#CreateTimeSpan(0,4,0,0)#">
                SELECT Distinct Agency_Name AS AgencyName 
                FROM dbo.IOC_CONTRACTS
     
                WHERE Agency_Name = <cfqueryparam value="#UCASE(C1_contractAgency)#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
            </cfquery>

          <CFSET FN1.val3 = q3.AgencyName>
         <!---  <cfcatch type="any"><CFSET FN1.val3 = ""></cfcatch>
           </cftry> --->
        </CFIF>
        <!--- Get type name --->
         <CFIF C1_contractAward IS NOT "Default">
        <!---  <cftry> --->
           <CFQUERY NAME="q4" datasource="ContractsData">
                SELECT  Distinct Award_Description AS AwardDescription 
                FROM dbo.IOC_CONTRACTS
          WHERE Upper(Award_Description) = <cfqueryparam value="#UCASE(C1_contractAward)#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
            </CFQUERY>
          <CFSET FN1.val4 =  q4.AwardDescription>
        <!---   <cfcatch type="any"> <CFSET FN1.val4 =  ""></cfcatch>
           </cftry> --->
        </CFIF>
        <!--- Get group by name --->
       
        <CFIF C1_contractType IS NOT "Default">
           
          <cfquery name="q5" datasource="ContractsData">
                SELECT  Distinct Type_Description AS TypeDescription
                FROM dbo.IOC_CONTRACTS
                WHERE Type_Description = <cfqueryparam value="#TRIM(C1_contractType)#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">

            </cfquery>
          <CFSET FN1.val5 =  "#TRIM(q5.TypeDescription)#">
        </CFIF>
       
       <CFIF C1_contractClass IS NOT "Default">
           
          <cfquery name="q6" datasource="ContractsData">
                    SELECT Distinct Class_Description AS ClassDescription
                    FROM dbo.IOC_CONTRACTS
                    WHERE Class_Description = <cfqueryparam value="#TRIM(C1_contractClass)#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">

            </cfquery>
          <CFSET FN1.val6 =  "#TRIM(q6.ClassDescription)#">
        </CFIF>
    </CFIF>
    
     <cfreturn FN1>
    </cffunction>       

<!--- User Story 602 - SR 16071 --->
<cffunction access="public" NAME="getFYs" returnType="string">
        <cfargument name="numFYs" type="numeric" required="false" default="5">
        <cfargument name="MaxFY" type="numeric" required="no" default="20#application.cfy#">
            <!--- Check if number of fiscal years is specified, if not set default --->

            <CFIF IsDefined ("numFYs") AND IsNumeric(numFYs)>
              <CFSET FYCount = NumFYs - 1>
            <cfelse>
             <CFSET FYCount = 5>
            </CFIF>
            <!--- Check if Max fiscal year is specified, if not set default --->
            <CFIF IsDefined ("MaxFY") AND IsNumeric(MaxFY)>
              <CFSET MinFY = MaxFY - FYCount>
            <cfelse>
             <CFSET MaxFY = DATEFORMAT(NOW(), "yyyy")>
             <CFSET MinFY = DATEFORMAT(DateAdd('yyyy', -FYCount, NOW()),'yyyy')>
            </CFIF>

            <!--- Create a list to contain the fiscal years --->
            <CFSET qFYList = "">
            <cfloop index = "i" from="#MinFY#" to="#MaxFY#">
              <CFSET qFYList = ListAppend(qFYList,i)>
            </cfloop>
            <!--- Sort the list descending --->
          <CFSET qFYList = ListSort(qFYList,"Numeric", "Desc")>
            <cfreturn qFYList>

</cffunction>

</cfcomponent>