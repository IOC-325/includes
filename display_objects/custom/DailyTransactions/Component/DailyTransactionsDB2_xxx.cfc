
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
	
<cffunction name="GetLastUpdt" ACCESS="Public" output="False" hint="Get last Update Date" returntype="date" >
	<cfargument name="Srce" type="string" required="Yes">

	<cftry>
	<cfoutput>
	
	<cfquery DATASOURCE="#Srce#" NAME="GetLastUpdt" cachedwithin="#createtimespan(1,0,0,0)#">
		SELECT BALANCE_DATE
		FROM WH.SUMM_DAILY_CASH
        <!---
		WHERE (((WH.SUMM_DAILY_CASH.FUND)='0001' Or (WH.SUMM_DAILY_CASH.FUND)='0005' 
			Or (WH.SUMM_DAILY_CASH.FUND)='0007' Or (WH.SUMM_DAILY_CASH.FUND)='0412'))--->
        WHERE (((WH.SUMM_DAILY_CASH.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0001"> Or (WH.SUMM_DAILY_CASH.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0005"> 
			Or (WH.SUMM_DAILY_CASH.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0007"> Or (WH.SUMM_DAILY_CASH.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0412">))
            
		order by BALANCE_DATE desc
	</cfquery>		
	
	<cfreturn "#GetLastUpdt.BALANCE_DATE#">
	
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>

</cffunction>

<cffunction name="GetDailyCashBalance" ACCESS="Public" output="False" hint="Get list of General Funds" returntype="query">
	<cfargument name="LastUpdt" type="date" required="Yes">
	<cfargument name="Srce" type="string" required="Yes">

	<cftry>

	<cfoutput>
	
	<cfquery DATASOURCE="#Srce#" NAME="getDailyCashBalance" cachedwithin="#createtimespan(1,0,0,0)#">
		SELECT WH.SUMM_DAILY_CASH.BALANCE_DATE, Sum(WH.SUMM_DAILY_CASH.BEGIN_DAILY_AMT) AS SumOfBEGIN_DAILY_AMT, 
			Sum(WH.SUMM_DAILY_CASH.END_DAILY_AMT) AS SumOfEND_DAILY_AMT, Sum(WH.SUMM_DAILY_CASH.RECEIPT_AMT) AS SumOfRECEIPT_AMT, 
			Sum(WH.SUMM_DAILY_CASH.TRANS_IN_AMT) AS SumOfTRANS_IN_AMT, Sum(WH.SUMM_DAILY_CASH.TRANS_OUT_AMT) AS SumOfTRANS_OUT_AMT 
			,Sum((WH.SUMM_DAILY_CASH.WARR_ISSUED_AMT+WH.SUMM_DAILY_CASH.WARR_VOIDED_AMT+WH.SUMM_DAILY_CASH.MISCELLANEOUS_AMT+WH.SUMM_DAILY_CASH.REFUND_AMT)) AS NET_WARRANTS
		FROM WH.SUMM_DAILY_CASH
		<!---WHERE (((WH.SUMM_DAILY_CASH.FUND)='0001' Or (WH.SUMM_DAILY_CASH.FUND)='0005' 
			Or (WH.SUMM_DAILY_CASH.FUND)='0007' Or (WH.SUMM_DAILY_CASH.FUND)='0412'))--->
        WHERE (((WH.SUMM_DAILY_CASH.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0001"> Or (WH.SUMM_DAILY_CASH.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0005"> 
         Or (WH.SUMM_DAILY_CASH.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0007"> Or (WH.SUMM_DAILY_CASH.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0412">))
		GROUP BY WH.SUMM_DAILY_CASH.BALANCE_DATE
		<!---HAVING (((WH.SUMM_DAILY_CASH.BALANCE_DATE)= '#LastUpdt#'))--->
        HAVING (((WH.SUMM_DAILY_CASH.BALANCE_DATE)=<cfqueryparam cfsqltype="cf_sql_date" value="#LastUpdt#">))

	</cfquery>		
	
	<cfreturn "#getDailyCashBalance#">
	
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>

</cffunction>

<cffunction name="GetBondRating" ACCESS="Public" output="False" hint="Get the current Bond Ratings" returntype="query">
	<cfargument name="Srce" type="string" required="Yes">


	<cftry>		

	<cfoutput>
		
	<cfquery DATASOURCE="#Srce#" NAME="getBondRating" cachedwithin="#createtimespan(1,0,0,0)#">
		select Moodys, SandP, Fitch, Updt_Date
		from BondRatings
	</cfquery>	
	
	<cfreturn "#getBondRating#">
	
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>


</cffunction>

<cffunction name="GetBacklogs" ACCESS="Public" output="False" hint="Get the current backlog of unpaid bills" returntype="query">
	<cfargument name="LastUpdt" type="Date" required="Yes">
	<cfargument name="Srce" type="string" required="Yes">

	<cftry>		

	<cfoutput>	
	<cfquery DATASOURCE="#Srce#" NAME="getBacklogs" cachedwithin="#createtimespan(1,0,0,0)#">
		SELECT Sum(WH.BLNCESHT_ENDNG_BAL.END_OF_DAY_BALANCE) AS SumOfEND_OF_DAY_BALANCE 
		FROM WH.BLNCESHT_ENDNG_BAL
		<!---WHERE (((WH.BLNCESHT_ENDNG_BAL.FUND)='001' Or (WH.BLNCESHT_ENDNG_BAL.FUND)='0005' 
		Or (WH.BLNCESHT_ENDNG_BAL.FUND)='0007' Or (WH.BLNCESHT_ENDNG_BAL.FUND)='0412') AND 
		((WH.BLNCESHT_ENDNG_BAL.BS_ACCOUNT)='2030' Or (WH.BLNCESHT_ENDNG_BAL.BS_ACCOUNT)='2150'))--->
        WHERE (((WH.BLNCESHT_ENDNG_BAL.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0001"> Or (WH.BLNCESHT_ENDNG_BAL.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0005">  
		Or (WH.BLNCESHT_ENDNG_BAL.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0007"> Or (WH.BLNCESHT_ENDNG_BAL.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0412">) AND 
		((WH.BLNCESHT_ENDNG_BAL.BS_ACCOUNT)=<cfqueryparam cfsqltype="cf_sql_Char" value="2030"> Or (WH.BLNCESHT_ENDNG_BAL.BS_ACCOUNT)=<cfqueryparam cfsqltype="cf_sql_Char" value="2150">))
		GROUP BY WH.BLNCESHT_ENDNG_BAL.BALANCE_DATE
		<!---HAVING (((WH.BLNCESHT_ENDNG_BAL.BALANCE_DATE)= '#LastUpdt#'))--->
			HAVING (((WH.BLNCESHT_ENDNG_BAL.BALANCE_DATE)= <cfqueryparam cfsqltype="cf_sql_date" value="#LastUpdt#">))
	</cfquery>	
	
	<cfreturn "#getBacklogs#">
	
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>

</cffunction>

<cffunction name="GetVoucherBacklogs" ACCESS="Public" output="False" hint="Get list of backlogs for vouchers" returntype="query">
	<cfargument name="Srce" type="string" required="Yes">


	<cftry>

	<cfoutput>	
	<cfquery DATASOURCE="#Srce#" NAME="GetVoucherBacklogs" cachedwithin="#createtimespan(1,0,0,0)#">
		SELECT CM.CASH_MGMT.VOUCHER_LINE, Count(*) AS TotVoucherBacklog
		FROM CM.CASH_MGMT
		<!---WHERE (((CM.CASH_MGMT.FUND)='0001' Or (CM.CASH_MGMT.FUND)='0005'
		 Or (CM.CASH_MGMT.FUND)='0007' Or (CM.CASH_MGMT.FUND)='0412'))--->
         WHERE (((CM.CASH_MGMT.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0001"> Or (CM.CASH_MGMT.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0005">
		 Or (CM.CASH_MGMT.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0007"> Or (CM.CASH_MGMT.FUND)=<cfqueryparam cfsqltype="cf_sql_Char" value="0412">))
		GROUP BY CM.CASH_MGMT.VOUCHER_LINE
		<!---HAVING (((CM.CASH_MGMT.VOUCHER_LINE)='01'))--->
        HAVING (((CM.CASH_MGMT.VOUCHER_LINE)=<cfqueryparam cfsqltype="cf_sql_char" value="01">))

	</cfquery>
	
	<cfreturn "#GetVoucherBacklogs#">
	
	</cfoutput>

	<cfcatch type="Database">
	<b>Sorry, we could not process your request, please try again later!</b><cfabort>
	</cfcatch>
	</cftry>

</cffunction>


</cfcomponent>