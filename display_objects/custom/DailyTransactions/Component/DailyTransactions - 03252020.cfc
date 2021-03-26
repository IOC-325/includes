
<!---
Date Created: 11-7-12
Created By: Gary Ashbaugh

Description: The component contains 3 functions:

	GetDailyCashBalance: Get list of the General Funds
	GetBondRating: Get the 3 bond ratings from General Database, BondRating table
	GetBacklogs: Get the current backlogs
	GetVoucherBacklogs: Get the current voucher backlogs

--->

<cfcomponent hint="Daily Transactions">

<cffunction name="GetSSISDt" ACCESS="Public" output="False" hint="Get SSIS Update Date" returntype="any" >
	<cfargument name="Srce" type="string" required="Yes">

<!--- 	<cftry> --->
	<cfoutput>


	<cfquery DATASOURCE="#Srce#" NAME="GetSSISDt">
		SELECT Date,TimeStamp
		FROM SSISPackageLog
		order by Date desc
	</cfquery>

	<cfif GetSSISDt.recordcount>
		<cfreturn "#GetSSISDt#">
	</cfif>
	</cfoutput>
<!---
	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry> --->

</cffunction>

<cffunction name="GetLastUpdt" ACCESS="Public" output="False" hint="Get last Update Date" returntype="any" >
	<cfargument name="Srce" type="string" required="Yes">

<!--- 	<cftry> --->
	<cfoutput>

	<cfinvoke component = "/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
			method = "GetSSISDt"
			srce="LedgerDB2"
			returnVariable = "GetSSISDt">

	<cfif DateFormat(GetSSISDt.Date,"mm/dd/yyyy") is Dateformat(now(),"mm/dd/yyyy")>

		<cfquery DATASOURCE="#Srce#" NAME="GetLastUpdt" cachedAfter="#Dateformat(now(),"mm-dd-yyyy")#">
		SELECT distinct BALANCE_DATE
		FROM WH_SUMM_DAILY_CASH
		<!---
		WHERE (((FUND)='0001' Or (FUND)='0005'
			Or (FUND)='0007' Or (FUND)='0412'))
			--->
		order by BALANCE_DATE desc
		</cfquery>
	<cfelse>
		<cfquery DATASOURCE="#Srce#" NAME="GetLastUpdt">
		SELECT distinct BALANCE_DATE
		FROM WH_SUMM_DAILY_CASH
		<!---
		WHERE (((FUND)='0001' Or (FUND)='0005'
			Or (FUND)='0007' Or (FUND)='0412'))
			--->
		order by BALANCE_DATE desc
		</cfquery>
	</cfif>

	<cfif GetLastUpdt.recordcount>
		<cfreturn "#GetLastUpdt.BALANCE_DATE#">
	</cfif>
	</cfoutput>

<!--- 	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry> --->

</cffunction>

<cffunction name="GetDailyCashBalance" ACCESS="Public" output="False" hint="Get list of General Funds" returntype="any">
	<cfargument name="LastUpdt" type="date" required="Yes">
	<cfargument name="Srce" type="string" required="Yes">

	<cfquery DATASOURCE="DB2PRD" NAME="getDailyCashBalance" cachedwithin="#createTimeSpan(8,0,0,0)#">
		SELECT WH.SUMM_DAILY_CASH.BALANCE_DATE
		, Sum(WH.SUMM_DAILY_CASH.BEGIN_DAILY_AMT) AS SumOfBEGIN_DAILY_AMT
		, Sum(WH.SUMM_DAILY_CASH.END_DAILY_AMT) AS SumOfEND_DAILY_AMT
		, Sum((RECEIPT_AMT)) AS SumOfRECEIPT_AMT
		, Sum(WH.SUMM_DAILY_CASH.TRANS_IN_AMT) AS SumOfTRANS_IN_AMT
		, Sum(WH.SUMM_DAILY_CASH.TRANS_OUT_AMT) AS SumOfTRANS_OUT_AMT
		, Sum((WARR_ISSUED_AMT+MISCELLANEOUS_AMT+WARR_VOIDED_AMT+REFUND_AMT)) AS NET_WARRANTS
		FROM WH.SUMM_DAILY_CASH INNER JOIN WH.FUND ON WH.SUMM_DAILY_CASH.FUND = WH.FUND.FUND
		GROUP BY WH.SUMM_DAILY_CASH.BALANCE_DATE, WH.FUND.CATEGORY, WH.FUND.FISCAL_YEAR
		HAVING (((WH.SUMM_DAILY_CASH.BALANCE_DATE)=<cfqueryparam value="#LastUpdt#" cfsqltype="cf_sql_date">) 
			AND ((WH.FUND.CATEGORY)=<cfqueryparam value="A" cfsqltype="cf_sql_varchar">) 
			AND ((WH.FUND.FISCAL_YEAR)=<cfqueryparam value="20#application.cfy#" cfsqltype="cf_sql_integer">))
	</cfquery>

	 <cfif getDailyCashBalance.recordcount>
		<cfreturn "#getDailyCashBalance#">
	</cfif>

</cffunction>

<cffunction name="GetBondRating" ACCESS="Public" output="False" hint="Get the current Bond Ratings" returntype="any">
	<cfargument name="Srce" type="string" required="Yes">


<!--- 	<cftry>	 --->

	<cfoutput>
	<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
			method = "GetSSISDt"
			srce="LedgerDB2"
			returnVariable = "GetSSISDt">

	<cfif DateFormat(GetSSISDt.Date,"mm/dd/yyyy") is Dateformat(now(),"mm/dd/yyyy")>
		<cfquery DATASOURCE="General_P1" NAME="getBondRating" cachedAfter="#Dateformat(now(),"mm-dd-yyyy")#">
		select Moodys, SandP, Fitch, Updt_Date
		from BondRatings
		</cfquery>

	<cfelse>

		<cfquery DATASOURCE="General_P1" NAME="getBondRating">
		select Moodys, SandP, Fitch, Updt_Date
		from BondRatings
		</cfquery>

	</cfif>

	<cfif getBondRating.recordcount>
		<cfreturn "#getBondRating#">
	</cfif>
	</cfoutput>

<!--- 	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry> --->


</cffunction>

<cffunction name="GetBacklogs" ACCESS="Public" output="False" hint="Get the current backlog of unpaid bills" returntype="any">
	<cfargument name="LastUpdt" type="Date" required="Yes">
	<cfargument name="Srce" type="string" required="Yes">

<!--- 	<cftry>	 --->

	<cfoutput>
	<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
			method = "GetSSISDt"
			srce="LedgerDB2"
			returnVariable = "GetSSISDt">

	<!---<cfif DateFormat(GetSSISDt.Date,"mm/dd/yyyy") is Dateformat(now(),"mm/dd/yyyy")>--->
		<cfquery DATASOURCE="#Srce#" NAME="getBacklogs" cachedAfter="#Dateformat(now(),"mm-dd-yyyy")#">
		SELECT Sum(END_OF_DAY_BALANCE) AS SumOfEND_OF_DAY_BALANCE
		FROM WH_BLNCESHT_ENDNG_BAL
		<!---WHERE (((FUND)='001' Or (FUND)='0005'
		Or (FUND)='0007' Or (FUND)='0412') AND
		((BS_ACCOUNT)='2030' Or (BS_ACCOUNT)='2150'))--->
		GROUP BY BALANCE_DATE
		HAVING (((BALANCE_DATE)= '#LastUpdt#'))

		</cfquery>

<!---	<cfelse>

		<cfquery DATASOURCE="#Srce#" NAME="getBacklogs">
		SELECT Sum(END_OF_DAY_BALANCE) AS SumOfEND_OF_DAY_BALANCE
		FROM WH_BLNCESHT_ENDNG_BAL
		<!---WHERE (((FUND)='001' Or (FUND)='0005'
		Or (FUND)='0007' Or (FUND)='0412') AND
		((BS_ACCOUNT)='2030' Or (BS_ACCOUNT)='2150'))--->
		GROUP BY BALANCE_DATE
		HAVING (((BALANCE_DATE)= '#LastUpdt#'))

		</cfquery>

	</cfif>--->

	<cfif getBacklogs.recordcount>
		<cfreturn "#getBacklogs#">
	</cfif>
	</cfoutput>

<!--- 	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry> --->

</cffunction>

<cffunction name="GetVoucherBacklogs" ACCESS="Public" output="False" hint="Get list of backlogs for vouchers" returntype="any">
	<cfargument name="Srce" type="string" required="Yes">


	<!--- <cftry> --->

	<cfoutput>
	<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
			method = "GetSSISDt"
			srce="LedgerDB2"
			returnVariable = "GetSSISDt">

	<cfif DateFormat(GetSSISDt.Date,"mm/dd/yyyy") is Dateformat(now(),"mm/dd/yyyy")>
		<cfquery DATASOURCE="#Srce#" NAME="GetVoucherBacklogs" cachedAfter="#Dateformat(now(),"mm-dd-yyyy")#">
		SELECT VOUCHER_LINE, Count(*) AS TotVoucherBacklog
		FROM CM_CASH_MGMT
		GROUP BY VOUCHER_LINE
		HAVING (((VOUCHER_LINE)='01'))

		</cfquery>

	<cfelse>

		<cfquery DATASOURCE="#Srce#" NAME="GetVoucherBacklogs">
		SELECT VOUCHER_LINE, Count(*) AS TotVoucherBacklog
		FROM CM_CASH_MGMT
		<!---
		WHERE (((FUND)='0001' Or (FUND)='0005'
		 Or (FUND)='0007' Or (FUND)='0412'))
		 --->
		GROUP BY VOUCHER_LINE
		HAVING (((VOUCHER_LINE)='01'))

		</cfquery>

	</cfif>

	<cfif GetVoucherBacklogs.recordcount>
		<cfreturn "#GetVoucherBacklogs#">
	</cfif>
	</cfoutput>

<!--- 	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry> --->

</cffunction>


</cfcomponent>