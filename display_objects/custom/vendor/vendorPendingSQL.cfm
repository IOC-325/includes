<cfinclude template="TmpVendorapplicationSettings.cfm">
<cftry> 
<!--- 	<CFQUERY NAME="Results" DATASOURCE="DB2PRD" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
	 SELECT * FROM wh.PENDING_PAYMENTS, wh.AGENCY
	 WHERE
	  wh.PENDING_PAYMENTS.AGENCY = wh.AGENCY.AGENCY
	  AND VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#vendTIN#" />
	 ORDER BY Voucher_Date, Voucher_Amt
	</CFQUERY> --->
	<CFQUERY NAME="Results" DATASOURCE="DB2PRD" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
	 SELECT wh.PENDING_PAYMENTS.*, (select Distinct Name From wh.AGENCY where wh.AGENCY.AGENCY = wh.PENDING_PAYMENTS.AGENCY) Name
	 FROM wh.PENDING_PAYMENTS
	 WHERE
	  VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#vendTIN#" />
	 ORDER BY Voucher_Date, Voucher_Amt
	</CFQUERY>

<cfcatch type="database">
	 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
	</cfcatch>
</cftry>