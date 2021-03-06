<!---
Modified Date: 4-27-12
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Enhanced Vendor Remittance Site per SR11108 based on the regular site but requiring a UserID/Password
--->

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
<cfif (not isdefined("Session.VendTIN"))>
	<!--- Calls Index from VendorEnhanced --->
    <!--- Development & Production --->
    <cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>
<cfinclude template="TmpVendorapplicationSettings.cfm">
</cfLock>

<!---
<cftry>
---> <!--- Removed   cachedwithin="#CreateTimeSpan(0,12,0,0)#" from the below query. --->
<cfset TmpDt = "20" & "#FY#">
<CFQUERY NAME="Results"  DATASOURCE="VendorDB2">

<CFIF Agency eq "All" AND NOT Len(ContSel) <!---AND NOT Len(ContAgcySel)---> AND NOT Len(InvSel)>

            <!--- Replace above query with new IOC_WARR_HDR and IOC_Warr_Line views below per SR11108 --->
            SELECT 	DISTINCT #application.whOwner#IOC_WARR_HDR.RECORD_DATE
				,#application.whOwner#IOC_WARR_HDR.VENDOR_ADDR_IND AS Addr_Ind
                ,#application.whOwner#IOC_WARR_HDR.TRANSACTION_CODE 
				,#application.whOwner#IOC_WARR_HDR.TRANSACTION_NUMBER
				,#application.whOwner#IOC_WARR_HDR.TOT_WARRANT_AMT 				
            	,#application.whOwner#IOC_WARR_HDR.ZIP_CODE
            	,#application.whOwner#IOC_WARR_HDR.PAID_DATE				
				,#application.whOwner#ioc_WARR_LINE.VOUCHER_AGENCY
				,#application.whOwner#ioc_WARR_LINE.VOUCHER_NUMBER AS VNUMBER				
				,#application.whOwner#IOC_WARR_HDR.VENDOR_TIN
                ,#application.whOwner#IOC_WARR_HDR.NAME1 
            	,#application.whOwner#IOC_WARR_HDR.NAME2 
            	,#application.whOwner#IOC_WARR_HDR.Address
            	,#application.whOwner#IOC_WARR_HDR.City
            	,#application.whOwner#IOC_WARR_HDR.State
            	,#application.whOwner#IOC_WARR_HDR.ZIP_Code
				,#application.whOwner#IOC_WARR_HDR.WARRANT_STATUS 
                ,#application.whOwner#IOC_WARR_HDR.Invoice_Date
                ,#application.whOwner#IOC_WARR_HDR.Tot_Voucher_Amt
                ,#application.whOwner#ioc_WARR_LINE.CONTRACT_NUMBER
                ,#application.whOwner#ioc_WARR_LINE.Vendor_Invoice   
				,#application.whOwner#ioc_WARR_LINE.Acceptance_Date
				,#application.whOwner#ioc_WARR_LINE.FISCAL_YEAR

		FROM 	#application.whOwner#IOC_WARR_HDR
				, #application.whOwner#ioc_WARR_LINE
		<!---WHERE	<CFLOCK SCOPE="Session" timeout="120"  type="readonly">#application.whOwner#IOC_WARR_HDR.VENDOR_TIN =  '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#' </CFLOCK>
				 and 
                  #application.whOwner#ioc_WARR_LINE.TRANSACTION_NUMBER = 
				 	#application.whOwner#IOC_WARR_HDR.TRANSACTION_NUMBER and  
                    #application.whOwner#ioc_WARR_HDR.Fiscal_Year = #TmpDt# 
				AND #application.whOwner#ioc_WARR_LINE.ACCEPTANCE_DATE = #application.whOwner#IOC_WARR_HDR.ACCEPTANCE_DATE
				 <CFIF STATUS IS NOT 'ALL'>
				 	and #application.whOwner#IOC_WARR_HDR.WARRANT_STATUS = '#STATUS#'
				 </CFIF>
		
				 <cfif not findNoCase(attributes.StartDate, "") and not findNoCase(attributes.EndDate, "")>
				 	and #application.whOwner#IOC_WARR_HDR.Record_Date between #createODBCDate(attributes.StartDate)# and #createODBCDate(attributes.EndDate)#
					
				</cfif>--->
                
        where <CFLOCK SCOPE="Session" timeout="120" type="readonly">#application.whOwner#IOC_WARR_HDR.VENDOR_TIN =<cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"></CFLOCK>
			and #application.whOwner#ioc_WARR_LINE.TRANSACTION_NUMBER = #application.whOwner#IOC_WARR_HDR.TRANSACTION_NUMBER 
            and #application.whOwner#ioc_WARR_HDR.Fiscal_Year = <cfqueryparam cfsqltype="cf_sql_smallint" value="#TmpDt#"> 
			AND #application.whOwner#ioc_WARR_LINE.ACCEPTANCE_DATE = #application.whOwner#IOC_WARR_HDR.ACCEPTANCE_DATE
			<!--- SR 18003 --->
			AND VOUCHER_LINE = '01'
			<CFIF STATUS IS NOT 'ALL'>
				and #application.whOwner#IOC_WARR_HDR.WARRANT_STATUS = <cfqueryparam cfsqltype="cf_sql_char" value="#STATUS#">
			</CFIF>
			<cfif not findNoCase(attributes.StartDate, "") and not findNoCase(attributes.EndDate, "")>
				 <cfif isDate(attributes.StartDate) and isDate(attributes.EndDate)>
				 and #application.whOwner#IOC_WARR_HDR.Record_Date between <cfqueryparam cfsqltype="cf_sql_date" value="#createODBCDate(attributes.StartDate)#"> and <cfqueryparam cfsqltype="cf_sql_date" value="#createODBCDate(attributes.EndDate)#">
				 <cfelse>
			 		<p>Either your start date or your end date is not a valid date.</p>
			 		<cflog file="Andys_Custom_Error_Traps" text="Bad Start or End Date - in #GetCurrentTemplatePath()#, via   #cgi.cf_template_path# with query string #cgi.query_string#." >

			 		<cfabort>
			 	</cfif>
					
			</cfif>
		ORDER BY
			<CFIF FindNoCase(SortBy, "Warrant Number")>
				#application.whOwner#IOC_WARR_HDR.TRANSACTION_NUMBER
			<CFELSEIF FindNoCase(Sortby, "Total Warrant Amount")>
				#application.whOwner#IOC_WARR_HDR.TOT_WARRANT_AMT 
            <!--- Added to replace "Last Action Date" to be "Paid Date" --->
			<CFELSEIF FindNoCase(Sortby, "Paid Date")>
				#application.whOwner#IOC_WARR_HDR.PAID_DATE
            <!--- Added to match Sort on Warrant Form --->
            <Cfelseif FindNoCase(Sortby,"Status")>
            	#application.whOwner#IOC_WARR_HDR.WARRANT_STATUS 
			<cfelse>
				#application.whOwner#IOC_WARR_HDR.RECORD_DATE
			</CFIF>
			<CFIF FindNoCase(AscDesc, "Asc")>
				ASC
			<CFELSE>
				DESC
			</CFIF>
            
         
            
	<CFELSE>
            
            <!--- Replace above query with new IOC_WARR_HDR and IOC_Warr_Line views below per SR11108 --->
			
			SELECT 	                
                
                DISTINCT #application.whOwner#IOC_WARR_HDR.RECORD_DATE
				,#application.whOwner#IOC_WARR_HDR.VENDOR_ADDR_IND AS Addr_Ind
                ,#application.whOwner#IOC_WARR_HDR.TRANSACTION_CODE 
				,#application.whOwner#IOC_WARR_HDR.TRANSACTION_NUMBER
				,#application.whOwner#IOC_WARR_HDR.TOT_WARRANT_AMT 				
            	,#application.whOwner#IOC_WARR_HDR.ZIP_CODE
            	,#application.whOwner#IOC_WARR_HDR.PAID_DATE				
				,#application.whOwner#ioc_WARR_LINE.VOUCHER_AGENCY
				,#application.whOwner#ioc_WARR_LINE.VOUCHER_NUMBER AS VNUMBER				
				,#application.whOwner#IOC_WARR_HDR.VENDOR_TIN
                ,#application.whOwner#IOC_WARR_HDR.NAME1 
            	,#application.whOwner#IOC_WARR_HDR.NAME2 
            	,#application.whOwner#IOC_WARR_HDR.Address
            	,#application.whOwner#IOC_WARR_HDR.City
            	,#application.whOwner#IOC_WARR_HDR.State
            	,#application.whOwner#IOC_WARR_HDR.ZIP_Code
				,#application.whOwner#IOC_WARR_HDR.WARRANT_STATUS 
                ,#application.whOwner#IOC_WARR_HDR.Invoice_Date
                ,#application.whOwner#IOC_WARR_HDR.Tot_Voucher_Amt
                ,#application.whOwner#ioc_WARR_LINE.CONTRACT_NUMBER
                ,#application.whOwner#ioc_WARR_LINE.Vendor_Invoice   
				,#application.whOwner#ioc_WARR_LINE.Acceptance_Date
				,#application.whOwner#ioc_WARR_LINE.FISCAL_YEAR		
                             

		FROM 	#application.whOwner#IOC_WARR_HDR
				, #application.whOwner#ioc_WARR_LINE
		<!---WHERE	<CFLOCK SCOPE="Session" timeout="120" type="readonly">#application.whOwner#ioc_WARR_LINE.VENDOR_TIN =  '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#'</CFLOCK>
				 and #application.whOwner#ioc_WARR_LINE.TRANSACTION_NUMBER = 
				 	#application.whOwner#IOC_WARR_HDR.TRANSACTION_NUMBER and   
                    #application.whOwner#ioc_WARR_HDR.Fiscal_Year = #TmpDt# 
				AND #application.whOwner#ioc_WARR_LINE.ACCEPTANCE_DATE = #application.whOwner#IOC_WARR_HDR.ACCEPTANCE_DATE

				 <CFIF STATUS IS NOT 'ALL'>
				 	and #application.whOwner#IOC_WARR_HDR.WARRANT_STATUS = '#STATUS#'
				 </CFIF>
				<CFIF Agency is not "All">
					AND #application.whOwner#IOC_WARR_LINE.AGENCY = '#Agency#'
				</CFIF>
				<CFIF ContAgcySel is not "">
					AND	#application.whOwner#IOC_WARR_LINE.CONTRACT_AGENCY = '#ContAgcySel#' 
				</CFIF>
				<CFIF ContSel is not "">
					AND	#application.whOwner#IOC_WARR_LINE.CONTRACT_NUMBER = '#ContSel#' 
				</CFIF>
				<CFIF InvSel is not "">
					AND	#application.whOwner#IOC_WARR_LINE.VENDOR_INVOICE = '#InvSel#'
				</CFIF>
            <!--- 01341 --->			
				 <cfif not findNoCase(attributes.StartDate, "") and not findNoCase(attributes.EndDate, "")>
				 	and #application.whOwner#IOC_WARR_HDR.Record_Date between #createODBCDate(attributes.StartDate)# and #createODBCDate(attributes.EndDate)#
				 </cfif>--->
        where <CFLOCK SCOPE="Session" timeout="120" type="readonly">#application.whOwner#ioc_WARR_LINE.VENDOR_TIN =<cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"></CFLOCK>
        	and #application.whOwner#ioc_WARR_LINE.TRANSACTION_NUMBER = #application.whOwner#IOC_WARR_HDR.TRANSACTION_NUMBER 
            and #application.whOwner#ioc_WARR_HDR.Fiscal_Year = <cfqueryparam cfsqltype="cf_sql_smallint" value="#TmpDt#"> 
			AND #application.whOwner#ioc_WARR_LINE.ACCEPTANCE_DATE = #application.whOwner#IOC_WARR_HDR.ACCEPTANCE_DATE
			<CFIF STATUS IS NOT 'ALL'>
				and #application.whOwner#IOC_WARR_HDR.WARRANT_STATUS = <cfqueryparam cfsqltype="cf_sql_char" value="#STATUS#"> 
			</CFIF>
			<CFIF Agency is not "All">
				AND (#application.whOwner#IOC_WARR_LINE.Voucher_AGENCY = <cfqueryparam cfsqltype="cf_sql_char" value="#Agency#">
			<!---</CFIF>
			<CFIF ContAgcySel is not "">--->
				or #application.whOwner#IOC_WARR_LINE.CONTRACT_AGENCY = <cfqueryparam cfsqltype="cf_sql_char" value="#Agency#"> )
			</CFIF>
			<CFIF ContSel is not "">
				AND	#application.whOwner#IOC_WARR_LINE.CONTRACT_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#ContSel#"> 
			</CFIF>
			<CFIF InvSel is not "">
				AND	#application.whOwner#IOC_WARR_LINE.VENDOR_INVOICE = <cfqueryparam cfsqltype="cf_sql_char" value="#InvSel#"> 
			</CFIF>
            <!--- 01341 --->			
			<cfif not findNoCase(attributes.StartDate, "") and not findNoCase(attributes.EndDate, "")>
				and #application.whOwner#IOC_WARR_HDR.Record_Date between <cfqueryparam cfsqltype="cf_sql_date" value="#createODBCDate(attributes.StartDate)#"> and <cfqueryparam cfsqltype="cf_sql_date" value="#createODBCDate(attributes.EndDate)#">
			</cfif>
 		GROUP BY #application.whOwner#IOC_WARR_HDR.Record_Date,
				#application.whOwner#IOC_WARR_HDR.VENDOR_ADDR_IND,
                #application.whOwner#IOC_WARR_HDR.TRANSACTION_CODE,		
				#application.whOwner#IOC_WARR_HDR.TRANSACTION_NUMBER,
				#application.whOwner#IOC_WARR_HDR.TOT_WARRANT_AMT,
               	#application.whOwner#IOC_WARR_HDR.ZIP_CODE,				
             	#application.whOwner#IOC_WARR_HDR.PAID_DATE,
				#application.whOwner#ioc_WARR_LINE.voucher_AGENCY,	
                  
				#application.whOwner#ioc_WARR_LINE.VOUCHER_NUMBER,
				#application.whOwner#IOC_WARR_HDR.VENDOR_TIN, 
                
                <!--- Added on 7-12-12 --->
				#application.whOwner#IOC_WARR_HDR.NAME1, 
            	#application.whOwner#IOC_WARR_HDR.NAME2, 
            	#application.whOwner#IOC_WARR_HDR.Address,
            	#application.whOwner#IOC_WARR_HDR.City,
            	#application.whOwner#IOC_WARR_HDR.State,
            	#application.whOwner#IOC_WARR_HDR.ZIP_Code,
				
				#application.whOwner#IOC_WARR_HDR.WARRANT_STATUS,  
  
                #application.whOwner#IOC_WARR_HDR.Invoice_Date,
                <!--- added --->
                #application.whOwner#IOC_WARR_HDR.Tot_Voucher_Amt,
				 
                #application.whOwner#ioc_WARR_LINE.CONTRACT_NUMBER,
                #application.whOwner#ioc_WARR_LINE.Vendor_Invoice,   
                #application.whOwner#ioc_WARR_LINE.Acceptance_Date,   
						  
                #application.whOwner#ioc_WARR_LINE.FISCAL_YEAR                          
		ORDER BY
			<CFIF Sortby is "Warrant Number">
				#application.whOwner#ioc_WARR_LINE.TRANSACTION_NUMBER
			<CFELSEIF Sortby is "Total Warrant Amount">
				#application.whOwner#IOC_WARR_HDR.TOT_WARRANT_AMT 
			 <!--- Added to replace "Last Action Date" to be "Paid Date" --->
			<CFELSEIF FindNoCase(Sortby, "Paid Date")>
				#application.whOwner#IOC_WARR_HDR.PAID_DATE
            <!--- Added to match Sort on Warrant Form --->
            <Cfelseif FindNoCase(Sortby,"Status")>
            	#application.whOwner#IOC_WARR_HDR.WARRANT_STATUS 
			<CFELSE>
				#application.whOwner#IOC_WARR_HDR.RECORD_DATE
			</CFIF>
			<CFIF AscDesc is "Asc">
				ASC
			<CFELSE>
				DESC
			</CFIF>
	</CFIF>
</CFQUERY> 

<cfoutput>
<cfset Session.Acceptance_Date="#DateFormat(Results.Acceptance_Date,"mm/dd/yyyy")#"> 
<cfset Session.TotRecCnt = #Results.Recordcount#>
<cfset i=1>
<cfloop query="Results">
	<cfset Session.MyTRANSACTION_NUMBER[i] = "#TRANSACTION_NUMBER#">
	<cfset i=i+1>
</cfloop>
</cfoutput>

<!---
<cfcatch type="any">
	<b><font color="Red">Sorry, but it appears that either the site is not available at this time or the criteria that you have selected has resulted in no payments being selected!</font></b>
</cfcatch>
</cftry>
--->
<!---</CFLOCK>--->