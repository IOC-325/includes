<cfcomponent hint="Prevailing Wage Information">
   <cffunction name="getCountyList" ACCESS="Public" output="False" hint="Get list of counties" returntype="query">	
		<cfquery name="qryCountyList" DATASOURCE="DB2PRD">
		    SELECT WH.DESC_CNTY.NAME
				,WH.DESC_CNTY.CODE
				FROM WH.DESC_CNTY
				ORDER BY WH.DESC_CNTY.NAME
		</cfquery>
		<cfreturn qryCountyList>
	</cffunction>
	
 <cffunction name="getCountyTotal"	 access="remote" returntype="query">
 		<cfquery name="qryCountyTotal" datasource="General_P1">
		SELECT Count(County) as totCounty from tblCounties
		</cfquery>
		<cfreturn qryCountytotal>
 </cffunction>
	
<cffunction name="vendorList" access="remote" returntype="query" hint="This function will return result of vendor search">
	<!--- MerchID argument (required) --->    
    <CFARGUMENT default=""      NAME="Vendor_Name"      TYPE="String"      REQUIRED="Yes"      HINT="The vendor Name that is being searched on.">
	
	<CFSET strVendor_Name = UCase(ARGUMENTS.Vendor_Name)>
	<CFSET NewLength = Len(strVendor_Name) - 1>
	<CFIF NewLength gt 0>
		<CFSET BeginStr = Left(strVendor_Name, NewLength)>
	<CFELSE>
		<CFSET BeginStr = "">
	</CFIF>

	<CFSET EndChar = Asc(Right(Vendor_Name,1)) + 1> 
	<CFSET LastStr = "#BeginStr##Chr(EndChar)#"> 

		<!-- Vendor Name Search Query -->
		<CFQUERY NAME="qryVendorSearchResults" DATASOURCE="DB2PRDSQL">
			SELECT VENDOR_NAME, VENDOR_TIN
			FROM WH_VENDOR
			WHERE WH_VENDOR.Vendor_Name BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#strVendor_Name#" />
			  AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#LastStr#" />
			ORDER BY VENDOR_NAME
		</CFQUERY>
	
	<cfreturn qryVendorSearchResults>
</cffunction>
	
<cffunction name="vendorSummary" access="remote" returntype="query" hint="Returns the contract summary listing for a given vendor">
	<!--- <cfargument name="Vendor_TIN" type="String" required="True" hint=""> --->
	<cfquery name="qryVendorSummary" DATASOURCE="DBTwo">
	SELECT 
	Vendor

	FROM wh_pw_CONTRACT
	</cfquery>
	<cfreturn qryVendorSummary>
</cffunction>
	
</cfcomponent>
