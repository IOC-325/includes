<!---
	SR 8103
	Date Migrated : 12/16/08
	Migrated By : ASP
--->
<!--- SR #20008 Remove the tmpVendorApplicationSettings.cfm --->
<!--- <cfinclude template="TmpVendorapplicationSettings.cfm">---> 


<!---
<cfdump var="#variables.VendTin#">...t
--->

<cfquery name="UpOrDown" datasource="IOCReference" cachedwithin="#CreateTimeSpan(0,0,5,0)#">
    SELECT strValue 
    , dateLastUpdated
    FROM tblParams 
    WHERE strItem = 'WHOnlineStatus'
</cfquery>

<cfif UpOrDown.strValue eq "OFFLINE">
	<cfoutput>
 <P>The information warehouse went offline today at #Timeformat(UpOrDown.DateLastUpdated,'h:mm tt')# for updates. This update generally takes less than an hour to complete. Please check back around #TimeFormat(dateAdd('h', 1, UpOrDown.DateLastUpdated), 'h:mm tt')#, at which time it should be back online. Thank you for your patience.</P>

 <p>For more information on nightly warehouse cycles, visit the <a href="https://illinoiscomptroller.gov/Stats/StatsSummary.cfm">System Monitoring page</a>. </p>
 	</cfoutput>
 <CFABORT>
<CFELSE>
<cftry> 
<CFQUERY NAME="Results" DATASOURCE="#application.whdsn#" cachedwithin="#CreateTimeSpan(0,0,30,0)#">

<!--- Per SR14163 Removed contAgcySel use Agency instead ContAgcySel except for All then use nothing --->
<CFIF Agency eq "All" AND NOT Len(ContSel)  AND NOT Len(InvSel)><!---AND NOT Len(ContAgcySel)--->
		SELECT 	DISTINCT wh.TRANS_WARR_HDR_#FY#.RECORD_DATE
				,wh.TRANS_WARR_HDR_#FY#.VENDOR_ADDR_IND AS Addr_Ind
				,wh.TRANS_WARR_HDR_#FY#.TRANSACTION_NUMBER
                ,wh.Trans_WARR_HDR_#FY#.TRANSACTION_CODE 
				,wh.TRANS_WARR_HDR_#FY#.TOT_WARRANT_AMT 				
            	,wh.TRANS_WARR_HDR_#fy#.ZIP_CODE
            	,wh.TRANS_WARR_HDR_#fy#.PAID_DATE				
				,wh.TRANS_WARR_LINE_#FY#.VOUCHER_AGENCY
				,wh.TRANS_WARR_LINE_#FY#.VOUCHER_NUMBER AS VNUMBER				
				,wh.TRANS_WARR_HDR_#FY#.VENDOR_TIN
				,wh.TRANS_WARR_HDR_#FY#.WARRANT_STATUS 
                ,wh.TRANS_WARR_LINE_#FY#.CONTRACT_NUMBER
                ,wh.TRANS_WARR_LINE_#FY#.Vendor_Invoice   
				,wh.TRANS_WARR_LINE_#FY#.Acceptance_Date
				,wh.TRANS_WARR_LINE_#FY#.FISCAL_YEAR
 
		FROM 	wh.TRANS_WARR_HDR_#FY#
				, wh.TRANS_WARR_LINE_#FY#
		WHERE	wh.TRANS_WARR_HDR_#FY#.VENDOR_TIN =  '#Variables.VendTin#'
				 and wh.TRANS_WARR_LINE_#FY#.TRANSACTION_NUMBER = 
				 	wh.TRANS_WARR_HDR_#FY#.TRANSACTION_NUMBER
				AND wh.TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE = wh.TRANS_WARR_HDR_#FY#.ACCEPTANCE_DATE
				<!--- SR 18003 --->
				AND WH.TRANS_WARR_LINE_#FY#.VOUCHER_LINE = '01' 
				 <CFIF STATUS IS NOT 'ALL'>
				 	and wh.TRANS_WARR_HDR_#FY#.WARRANT_STATUS = '#STATUS#'
				 </CFIF>
		
				 <cfif not findNoCase(attributes.StartDate, "") and not findNoCase(attributes.EndDate, "")>
				 	<cfif isDate(attributes.StartDate) and isDate(attributes.EndDate)>		 		
				 	and wh.TRANS_WARR_HDR_#FY#.Record_Date between #createODBCDate(attributes.StartDate)# and #createODBCDate(attributes.EndDate)#
					</cfif>
				</cfif>

		ORDER BY
			<CFIF FindNoCase(SortBy, "Warrant Number")>
				wh.TRANS_WARR_HDR_#FY#.TRANSACTION_NUMBER
			<CFELSEIF FindNoCase(Sortby, "Total Warrant Amount")>
				wh.TRANS_WARR_HDR_#FY#.TOT_WARRANT_AMT 
			<CFELSEIF FindNoCase(Sortby, "Record Date")>
				wh.TRANS_WARR_HDR_#FY#.RECORD_DATE
			<cfelse>
				wh.TRANS_WARR_HDR_#FY#.RECORD_DATE
			</CFIF>
			<CFIF FindNoCase(AscDesc, "Asc")>
				ASC
			<CFELSE>
				DESC
			</CFIF>
<CFELSE>
		SELECT 	wh.TRANS_WARR_HDR_#FY#.RECORD_DATE
				,wh.TRANS_WARR_HDR_#FY#.VENDOR_ADDR_IND AS Addr_Ind
				,wh.TRANS_WARR_HDR_#FY#.TRANSACTION_NUMBER
                ,wh.Trans_WARR_HDR_#FY#.TRANSACTION_CODE 
				,wh.TRANS_WARR_HDR_#FY#.TOT_WARRANT_AMT 				
            	,wh.TRANS_WARR_HDR_#fy#.ZIP_CODE
            	,wh.TRANS_WARR_HDR_#fy#.PAID_DATE				
				,wh.TRANS_WARR_LINE_#FY#.VOUCHER_AGENCY <!--- AS AGENCY --->
				,wh.TRANS_WARR_LINE_#FY#.VOUCHER_NUMBER AS VNUMBER				
				,wh.TRANS_WARR_HDR_#FY#.VENDOR_TIN
				,wh.TRANS_WARR_HDR_#FY#.WARRANT_STATUS 
                ,wh.TRANS_WARR_LINE_#FY#.CONTRACT_NUMBER
                ,wh.TRANS_WARR_LINE_#FY#.Vendor_Invoice
				,wh.TRANS_WARR_LINE_#FY#.Acceptance_Date 
				,wh.TRANS_WARR_LINE_#FY#.FISCAL_YEAR				               

		FROM 	wh.TRANS_WARR_HDR_#FY#
				, wh.TRANS_WARR_LINE_#FY#
		WHERE	wh.TRANS_WARR_LINE_#FY#.VENDOR_TIN =  '#Variables.VendTin#'
				 and wh.TRANS_WARR_LINE_#FY#.TRANSACTION_NUMBER = 
				 	wh.TRANS_WARR_HDR_#FY#.TRANSACTION_NUMBER
				AND wh.TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE = wh.TRANS_WARR_HDR_#FY#.ACCEPTANCE_DATE

				<CFIF STATUS IS NOT 'ALL'>
                    and wh.TRANS_WARR_HDR_#FY#.WARRANT_STATUS = '#STATUS#'
                </CFIF>
                <!--- Per SR14163 use Agency instead ContAgcySel except for All then use nothing--->
				<CFIF Agency is not "All">
                   AND (wh.TRANS_WARR_LINE_#FY#.VOUCHER_AGENCY  = '#TRIM(Agency)#'
                   OR wh.TRANS_WARR_LINE_#FY#.Contract_AGENCY = '#TRIM(Agency)#')
				</CFIF>
                <!--- Per SR14163 use Agency instead ContAgcySel except for All then use nothing --->
				<!---<CFIF ContAgcySel is not "">
					AND	wh.TRANS_WARR_LINE_#FY#.CONTRACT_AGENCY = '#ContAgcySel#' 
				</CFIF>--->
				<CFIF ContSel is not "">
					AND	wh.TRANS_WARR_LINE_#FY#.CONTRACT_NUMBER = '#ContSel#' 
				</CFIF>
				<CFIF InvSel is not "">
					AND	wh.TRANS_WARR_LINE_#FY#.VENDOR_INVOICE = '#InvSel#'
				</CFIF>
            <!--- 01341 --->			
				 <cfif not findNoCase(attributes.StartDate, "") and not findNoCase(attributes.EndDate, "")>
				 	<cfif isDate(attributes.StartDate) and isDate(attributes.EndDate)>	
				 		and wh.TRANS_WARR_HDR_#FY#.Record_Date between #createODBCDate(attributes.StartDate)# and #createODBCDate(attributes.EndDate)#
				 	<cfelse>
				 		<p>Either your start date or your end date is not a valid date.</p>

	<!---<cflog file="Andys_Custom_Error_Traps" text="Bad Start or End Date - in #GetCurrentTemplatePath()#, via   #cgi.cf_template_path# with query string #cgi.query_string#." >--->
				 		<cfabort>
				 	</cfif>
				 	
				 </cfif>
 		GROUP BY wh.TRANS_WARR_HDR_#FY#.Record_Date,
				wh.TRANS_WARR_HDR_#FY#.VENDOR_ADDR_IND,		
				wh.TRANS_WARR_HDR_#FY#.TRANSACTION_NUMBER,
				wh.TRANS_WARR_HDR_#FY#.TOT_WARRANT_AMT,
               	wh.TRANS_WARR_HDR_#fy#.ZIP_CODE,				
             	wh.TRANS_WARR_HDR_#fy#.PAID_DATE ,
				wh.TRANS_WARR_LINE_#FY#.voucher_AGENCY,		   
				wh.TRANS_WARR_LINE_#FY#.VOUCHER_NUMBER,
				wh.TRANS_WARR_HDR_#FY#.VENDOR_TIN, 
				wh.TRANS_WARR_HDR_#FY#.WARRANT_STATUS  
                ,wh.TRANS_WARR_LINE_#FY#.CONTRACT_NUMBER
                ,wh.TRANS_WARR_LINE_#FY#.Vendor_Invoice  
				,wh.TRANS_WARR_LINE_#FY#.Acceptance_Date  
				,wh.TRANS_WARR_LINE_#FY#.Acceptance_Date 
				,wh.TRANS_WARR_LINE_#FY#.FISCAL_YEAR		                            
                ,wh.Trans_WARR_HDR_#FY#.TRANSACTION_CODE
		ORDER BY
			<CFIF Sortby is "Warrant Number">
				wh.TRANS_WARR_LINE_#FY#.TRANSACTION_NUMBER
			<CFELSEIF Sortby is "Total Warrant Amount">
				wh.TRANS_WARR_HDR_#FY#.TOT_WARRANT_AMT 
			<CFELSEIF Sortby is "Record Date">
				wh.TRANS_WARR_HDR_#FY#.RECORD_DATE
			<CFELSE>
				wh.TRANS_WARR_HDR_#FY#.RECORD_DATE
			</CFIF>
			<CFIF AscDesc is "Asc">
				ASC
			<CFELSE>
				DESC
			</CFIF>
	</CFIF>
</CFQUERY>

<cfcatch type="database">
	 <b>Sorry, but the Vendor application is not available at this time.  Please try again later!</b><cfabort>
	</cfcatch>
</cftry>

</CFIF>

<CFOUTPUT>#UpOrDown.strValue#</CFOUTPUT>