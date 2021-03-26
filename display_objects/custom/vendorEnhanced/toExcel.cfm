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
</cfLock>

<Cfif isdefined("CSV")>
	<cfabort>
    <cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</Cfif>

<cffunction name="getSchedulePaymentDate" output="false" returnType="string">
     <cfargument name="RECORD_DATE" type="string" required="true" default="" />

            <!--- Calculate Anticipated Date --->
                <cfset FndAnticipatedDt = "False">
                <cfset NoDays = 0>
                <!--- Add first day --->
                <cfset CalcAnticipatedDt = DateFormat(RECORD_DATE,"mm/dd/yyyy")>
                <cfloop condition = "FndAnticipatedDt equal False">

                    <cfquery name="CheckHoliday" datasource="Common" dbtype="ODBC">
                        SELECT     Holiday
                        FROM         StateHoliday
                        <!---WHERE       Holiday = '#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#'--->
                        WHERE Holiday =<cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#">
                    </cfquery>
                    <cfif DayofWeek(CalcAnticipatedDt) is 7>
                        <!--- Saturday....move to next --->
                        <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                    <cfelseif DayofWeek(CalcAnticipatedDt) is 1>
                        <!--- Sunday....re-calculate date to Monday --->
                        <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                    <cfelseif CheckHoliday.recordcount>
                          <!--- Holiday move to next --->
                          <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                    <cfelse> <!--- Add another Day --->
                                  
                        <cfif NoDays eq 2>
                            <cfset FndAnticipatedDt = "True">
                        <cfelse>                              
                            <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                        </cfif>
                        <cfset NoDays = #NoDays#+1>
                    </cfif>
                </cfloop> 
<cfreturn CalcAnticipatedDt />

</cffunction>

<!---
<cftry>
--->
<cfset TmpDt = "20" & "#FY#">
<cfif isdefined("Results")>
<cfsavecontent variable="strExcelData">
<cfsetting enablecfoutputonly="true">
    
<cfoutput>
 
    <table border="1">	
       	
	    <TR>
            <TD class="header" align="center">Warrant/EFT</TD>
            <TD class="header" align="center">Addr Ind</TD>
            <TD class="header" align="center">Zip Code</TD>		
            <TD class="header" align="center">Issue Date</TD>
            <TD class="header" align="center">Anticipated Direct Deposit Date</TD>
            <TD class="header" align="center">Total Voucher Amount</TD>
            <TD class="header" align="center">Total Offset</TD>
            <TD class="header" align="center">Total Fee</TD>
            <TD class="header" align="center">Payment Amount</TD>
            <TD class="header" align="center">Voucher Number</TD>
            <TD class="header" align="center">Paid Date</TD>        	
            <TD class="header" align="center">Contract Number</TD>
            <TD class="header" align="center">Vendor Invoice</TD>
            <TD class="header" align="center">Fiscal Year</TD>
            <TD class="header" align="center">Warrant Status</TD>
            <TD class="header" align="center">Invoice Date</TD>
            <TD class="header" align="center">Vendor Name</TD>
            <TD class="header" align="center">Vendor Name 2</TD>
            <TD class="header" align="center">Vendor Address</TD>
			<!---<cfif isDefined("PVTX")>--->
				<TD class="header" align="center">Description</TD>
                <TD class="header" align="center">Agency Contact Information</TD>
			<!---</CFIF>--->
			<!---<CFIF ISDEFINED("LineDetails")>--->
            	<!---
            	<TD class="header" align="center">Accounting Line Details</TD> 
				--->
			
                <TD class="header" align="center">Fund</TD> 
            	<TD class="header" align="center">Agency</TD> 
            	<TD class="header" align="center">Organization</TD> 
            	<TD class="header" align="center">Appropriation</TD> 
            	<TD class="header" align="center">Object</TD> 
            	<TD class="header" align="center">Amount</TD> 
            	<TD class="header" align="center">Appropriation Name</TD>
				<TD class="header" align="center">Beginning Date of Service</TD>
				<TD class="header" align="center">End Date of Service</TD>
				 
			<!---</cfif>--->           
		</TR> </cfoutput>
    <cfif SpreadsheetStartRow+1999 gt Session.TotRecCnt>
    	<cfset TmpEnd = "#Session.TotRecCnt#">
    <cfelse>
    	<cfset TmpEnd = #SpreadsheetStartRow#+1999>
    </cfif>
    <cfloop query="Results" startrow="#SpreadsheetStartRow#" endrow="#TmpEnd#">	
    	<!--- Carl's New View for SR11108_Phase 2 --->
        <CFQUERY NAME="OffsetInfo" DATASOURCE="VendorDB2" CACHEDWITHIN="#CreateTimeSpan(0,0,10,0)#">
            
            SELECT Tot_Offset_Amt, Tot_Fee_Amt
            FROM WH.IOC_WARR_OFFST_FEE
            WHERE 
           <!--- TRANSACTION_NUMBER = '#Transaction_Number#' 
            AND ACCEPTANCE_DATE = #CreateODBCDate(Acceptance_date)#--->
            TRANSACTION_NUMBER =<cfqueryparam cfsqltype="cf_sql_char" value="#Transaction_Number#">
            AND ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Acceptance_date)#">
        </CFQUERY>
        
    	<TR>
		<CFOUTPUT>
        <TD align="center">#TRANSACTION_NUMBER#</TD>
		<TD  align="center">#Addr_Ind#</TD>
		<TD align="center">#ZIP_CODE#</TD>		
		<TD align="center">#DateFormat(RECORD_DATE,"m/d/yyyy")#</TD>
        <cfif Transaction_Code is not "EF">
        	<td>&nbsp;</td>
        <cfelse>
        	
			<!--- Calculate Anticipated Date --->
            <cfoutput>
			<cfset FndAnticipatedDt = "False">
            <cfset NoDays = 0>
            <!--- Add first day --->
			<cfset CalcAnticipatedDt = DateFormat(DateAdd("d",1,Record_Date),"mm/dd/yyyy")>
           
            <cfloop condition = "FndAnticipatedDt equal False">

                <cfquery name="CheckHoliday" datasource="Common" dbtype="ODBC">
                    SELECT     Holiday
                    FROM         StateHoliday
                    <!---WHERE       Holiday = '#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#'--->
                    where Holiday = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#">
                </cfquery>

				<cfif DayofWeek(CalcAnticipatedDt) is 7>
                    <!--- Saturday....move to next --->
                    <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                <cfelseif DayofWeek(CalcAnticipatedDt) is 1>
                    <!--- Sunday....re-calculate date to Tuesday --->
                    <cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                <cfelseif CheckHoliday.recordcount>
                	<!--- Holiday move to next --->
                	<cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                <cfelse>
                	<cfset NoDays = #NoDays#+1>
                    <cfif NoDays eq 2>
                	<cfset FndAnticipatedDt = "True">
                	<cfelse>
                		<!--- Add another Day --->
                	<cfset CalcAnticipatedDt = DateFormat(DateAdd("D",1,CalcAnticipatedDt),"mm/dd/yyyy")>
                	</cfif>
                </cfif>
                
            </cfloop>
			
        	<td>#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#</td>
           	</cfoutput>
        </cfif>
        <TD align="center">#DollarFormat(Tot_Voucher_Amt)#</TD>
        <TD align="center">#DollarFormat(OffsetInfo.Tot_Offset_Amt)#</TD>
        <TD align="center">#DollarFormat(OffsetInfo.Tot_Fee_Amt)#</TD>
		<TD align="right">#DollarFormat(TOT_WARRANT_AMT)#</TD>
		<TD align="center">&nbsp;#VNumber#</TD>	
        <!--- <TD align="center">#Dateformat(Paid_Date,'m/d/yyyy')#</TD> --->
        <TD align="center">
         <cfif  mid(TRANSACTION_NUMBER,1,1) EQ "A">
            #DateFormat(PAID_DATE,"mm/dd/yy")#
          <cfelseif findNoCase(warrant_Status, "p")>
           #DateFormat(PAID_DATE,"mm/dd/yy")#
          <cfelse>
            #DateFormat(getSchedulePaymentDate(RECORD_DATE),"mm/dd/yyyy")#
          </cfif>
        </TD>   
        <TD align="center">&nbsp;#contract_number#</TD>
        <TD align="center">&nbsp;#vendor_invoice#</TD>
		<TD align="center">#fiscal_year#</TD>
        <TD align="center">#warrant_status#</TD>
        <TD align="center">#DateFormat(Invoice_Date, "mm/dd/yyyy")#</TD>
        <TD align="center">#Name1#</TD>
		<TD align="center">#Name2#</TD>
        <TD align="center">#trim(Address)#<cfif trim(City) is not "">;  </cfif>#trim(City)#<cfif trim(City) is not "">,  </cfif>#State#  #ZIP_Code#</TD>
		</CFOUTPUT>
		<!---<cfif isDefined("PVTX")>--->
                              
            <cfquery <!---datasource="#application.whdsn#"---> DATASOURCE="VendorDB2"  <!---DATASOURCE="DB2Dev"---> name="PVTX" cachedwithin="#CreateTimeSpan(0,12,0,0)#">
            SELECT text_line as LINE, pv_text as TEXT
			FROM WH.IOC_PVTX
            WHERE 
            <!---voucher_agency='#results.voucher_agency#'
            and voucher_number = '#results.VNUMBER#'--->
            voucher_agency=<cfqueryparam cfsqltype="cf_sql_char" value="#results.voucher_agency#">
            and voucher_number =<cfqueryparam cfsqltype="cf_sql_char" value="#results.VNUMBER#">
            ORDER BY LINE 
            </cfquery>  
            
            <cfif pvtx.recordcount>
				<TD><CFOUTPUT query="PVTX">
                #replace(replace(trim(TEXT),"'","","all"),'"','','all')#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	</CFOUTPUT></TD>
			<Cfelse>
            	<td>&nbsp;</td>
            </cfif>
			
			<cfquery <!---datasource="#application.whdsn#"---> DATASOURCE="VendorDB2"  <!---datasource="DB2Dev"---> name="ContactInfo" cachedwithin="#CreateTimeSpan(0,12,0,0)#">
            SELECT	
			 WH.AGENCY_#FY#.CONTACT_INFO 
			FROM 	WH.TRANS_WARR_LINE_#FY# , WH.AGENCY_#FY#
			<!---WHERE 	WH.TRANS_WARR_LINE_#FY#.TRANSACTION_NUMBER = '#transaction_number#' 
    		 AND
			WH.TRANS_WARR_LINE_#FY#.AGENCY = WH.AGENCY_#FY#.AGENCY  
            AND
           <CFLOCK SCOPE="Session" timeout="120" type="readonly"> WH.TRANS_WARR_LINE_#FY#.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#'</CFLOCK> 
			AND
			WH.TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE = #CreateODBCDate(results.acceptance_date)# --->
            
            WHERE 	WH.TRANS_WARR_LINE_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_char" value="#transaction_number#"> 
    		 AND
			WH.TRANS_WARR_LINE_#FY#.AGENCY = WH.AGENCY_#FY#.AGENCY  
            AND
           <CFLOCK SCOPE="Session" timeout="120" type="readonly"> WH.TRANS_WARR_LINE_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"></CFLOCK> 
			AND
			WH.TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(results.acceptance_date)#">
            </cfquery>
			
			<CFOUTPUT QUERY="ContactInfo" MAXROWS="1">
			 <td>#contact_info#</TD>
			
			</CFOUTPUT>
		
		<!---</cfif> 
        
        <cfif isDefined("LineDetails")>--->
        	<cfquery <!---datasource="#application.whdsn#"---> DATASOURCE="VendorDB2"  <!---datasource="DB2Dev"---> name="LineDetails" cachedwithin="#CreateTimeSpan(0,12,0,0)#">
            <!---
            SELECT	
			WH.TRANS_WARR_LINE_#FY#.FUND,
			WH.TRANS_WARR_LINE_#FY#.AGENCY,
			WH.TRANS_WARR_LINE_#FY#.ORGANIZATION,
			WH.TRANS_WARR_LINE_#FY#.APPROPRIATION,
			WH.TRANS_WARR_LINE_#FY#.OBJECT,
			WH.TRANS_WARR_LINE_#FY#.WARRANT_AMT, 
			WH.TRANS_WARR_LINE_#FY#.CONTRACT_CODE,
			WH.TRANS_WARR_LINE_#FY#.VOUCHER_CODE,
			WH.TRANS_WARR_LINE_#FY#.VOUCHER_NUMBER
			, WH.AGENCY_#FY#.NAME
			, WH.AGENCY_#FY#.CONTACT_INFO 
	FROM 	WH.TRANS_WARR_LINE_#FY# , WH.AGENCY_#FY#
	WHERE 	WH.TRANS_WARR_LINE_#FY#.TRANSACTION_NUMBER = '#transaction_number#' 
    		 AND
			WH.TRANS_WARR_LINE_#FY#.AGENCY = WH.AGENCY_#FY#.AGENCY  
            AND
            WH.TRANS_WARR_LINE_#FY#.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#'
			AND
			WH.TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE = #CreateODBCDate(results.acceptance_date)# 
			--->
            SELECT	#application.whOwner#ioc_WARR_LINE.ACCEPTANCE_DATE, 
				#application.whOwner#ioc_WARR_LINE.FUND, 
				#application.whOwner#ioc_WARR_LINE.AGENCY, 
				#application.whOwner#ioc_WARR_LINE.ORGANIZATION, 
				#application.whOwner#ioc_WARR_LINE.APPROPRIATION, 
				#application.whOwner#ioc_WARR_LINE.OBJECT, 
				#application.whOwner#ioc_WARR_LINE.WARRANT_AMT, 
				#application.whOwner#ioc_WARR_LINE.CONTRACT_CODE, 
                #application.whOwner#ioc_WARR_LINE.CONTRACT_NUMBER, 
                #application.whOwner#ioc_WARR_LINE.VOUCHER_CODE, 
                #application.whOwner#ioc_WARR_LINE.VOUCHER_NUMBER, 
                #application.whOwner#ioc_WARR_LINE.VENDOR_INVOICE, 
                #application.whOwner#ioc_WARR_LINE.BEGIN_SERV_DATE, 
                #application.whOwner#ioc_WARR_LINE.END_SERV_DATE, 
                #application.whOwner#AGENCY.NAME, 
                #application.whOwner#AGENCY.CONTACT_INFO
        FROM 	#application.whOwner#ioc_WARR_LINE, #application.whOwner#AGENCY
       <!--- WHERE 	#application.whOwner#ioc_WARR_LINE.TRANSACTION_NUMBER = '#transaction_number#' AND
                #application.whOwner#ioc_WARR_LINE.AGENCY = #application.whOwner#AGENCY.AGENCY AND
                #application.whOwner#ioc_WARR_LINE.FISCAL_YEAR = #application.whOwner#AGENCY.FISCAL_YEAR AND
                <CFLOCK SCOPE="Session" timeout="120" type="readonly"> #application.whOwner#ioc_WARR_LINE.VENDOR_TIN = '#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#' </CFLOCK> AND
                #application.whOwner#ioc_WARR_LINE.ACCEPTANCE_DATE = #CreateODBCDate(acceptance_date)# and 
                #application.whOwner#ioc_WARR_LINE.Fiscal_Year = #TMpDt#---> 
                
        WHERE 	#application.whOwner#ioc_WARR_LINE.TRANSACTION_NUMBER =  <cfqueryparam cfsqltype="cf_sql_char" value="#transaction_number#"> AND
                #application.whOwner#ioc_WARR_LINE.AGENCY = #application.whOwner#AGENCY.AGENCY AND
                #application.whOwner#ioc_WARR_LINE.FISCAL_YEAR = #application.whOwner#AGENCY.FISCAL_YEAR AND
                <CFLOCK SCOPE="Session" timeout="120" type="readonly"> #application.whOwner#ioc_WARR_LINE.VENDOR_TIN =  <cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"> </CFLOCK> AND
                #application.whOwner#ioc_WARR_LINE.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(results.acceptance_date)#"> and 
                #application.whOwner#ioc_WARR_LINE.Fiscal_Year = <cfqueryparam cfsqltype="cf_sql_smallint" value="#TMpDt#">
        </cfquery>

           <!---
           <td>
					
			--->
            	<cfset myListNum = "1">
                <cfset TmpFund= "">
				<cfset TmpAgency= "">
				<cfset TmpName= "">
				<cfset TmpOrganization= "">
				<cfset TmpAppropriation= "">
				<cfset TmpObject= "">
				<cfset TmpAmount= "">
				<cfset TmpAppropriation_Name= "">
                <cfset TmpBegDtService= "">
                <cfset TmpEndDtService= "">
                <cfset x=1>
		
				<cfloop query="LineDetails">
                <cfoutput>
                    <cfquery <!---datasource="#application.whdsn#"---> DATASOURCE="VendorDB2"  <!---datasource="DB2Dev"---> cachedwithin="#CreateTimeSpan(0,12,0,0)#" name="AppropNameDetails">
                    SELECT 	WH.APPROP_#FY#.NAME 
                    FROM 	WH.APPROP_#FY# 
                   <!--- WHERE 	WH.APPROP_#FY#.FUND = '#linedetails.fund#' AND 
                        WH.APPROP_#FY#.AGENCY = '#linedetails.Agency#' AND 
                        WH.APPROP_#FY#.ORGANIZATION = '#linedetails.organization#' AND 
                        WH.APPROP_#FY#.APPROPRIATION = '#linedetails.appropriation#' --->
                  
                  WHERE 	WH.APPROP_#FY#.FUND = <cfqueryparam cfsqltype="cf_sql_char" value="#linedetails.fund#"> AND 
                        WH.APPROP_#FY#.AGENCY = <cfqueryparam cfsqltype="cf_sql_char" value="#linedetails.Agency#"> AND 
                        WH.APPROP_#FY#.ORGANIZATION = <cfqueryparam cfsqltype="cf_sql_char" value="#linedetails.organization#"> AND 
                        WH.APPROP_#FY#.APPROPRIATION = <cfqueryparam cfsqltype="cf_sql_char" value="#linedetails.appropriation#">      
                        
                    </cfquery>
                    
		
					<cfif trim(TmpFund) is not "">
						<cfif not TmpFund contains "#NumberFormat(Fund,"0999")#">
                        	<cfif x eq 2>
								<cfset TmpFund= "(1) " & TmpFund & "  (#x#) " & "#NumberFormat(Fund,"0999")#">
                             <cfelse>
                             	<cfset TmpFund= TmpFund & "  (#x#) " & "#NumberFormat(Fund,"0999")#">
                             </cfif>
						</cfif>
					<cfelse>
						<cfset TmpFund="#NumberFormat(Fund,"0999")#">
					</cfif>
					<cfif trim(TmpAgency) is not "">
						<cfif not TmpAgency contains "#Agency#">
                        	<cfif x eq 2>
								<cfset TmpAgency= "(1) " & TmpAgency & "  (#x#) " & "#Agency#">
                            <cfelse>
                            	<cfset TmpAgency=  TmpAgency & "  (#x#) " & "#Agency#">
                            </cfif>
						</cfif>
					<cfelse>
						<cfset TmpAgency="#Agency#">
					</cfif>
					<cfif trim(TmpName) is not "">
						<cfif not TmpName contains "#TmpName#">
                        	<cfif x eq 2>
								<cfset TmpName= "(1) " & TmpName & "  (#x#) " & "#Name#">
                            <cfelse>
                            	<cfset TmpName=  TmpName & "  (#x#) " & "#Name#">
                            </cfif>
						</cfif>
					<cfelse>
						<cfset TmpName="#Name#">
					</cfif>
					<cfif trim(TmpOrganization) is not "">
						<cfif not TmpOrganization contains "#Organization#">
                        	<cfif x eq 2>
								<cfset TmpOrganization= "(1) " & TmpOrganization & "  (#x#) " & "#Organization#">
                            <cfelse>
                            	<cfset TmpOrganization=  TmpOrganization & "  (#x#) " & "#Organization#">
                            </cfif>
						</cfif>
					<cfelse>
						<cfset TmpOrganization="#Organization#">
					</cfif>
					<cfif trim(TmpAppropriation) is not "">
						<cfif not TmpAppropriation contains "#Appropriation#">
                        	<cfif x eq 2>
								<cfset TmpAppropriation= "(1) " & TmpAppropriation & "  (#x#) " & "#Appropriation#">
                            <cfelse>
                            	<cfset TmpAppropriation=  TmpAppropriation & "  (#x#) " & "#Appropriation#">
                            </cfif>
						</cfif>
					<cfelse>
						<cfset TmpAppropriation="#Appropriation#">
					</cfif>
					<cfif trim(TmpObject) is not "">
						<cfif not TmpObject contains "#NumberFormat(Object,"0999")#">
                        	<cfif x eq 2>
								<cfset TmpObject= "(1) " & TmpObject & "  (#x#) " & "#NumberFormat(Object,"0999")#">
                             <cfelse>
                             	<cfset TmpObject=  TmpObject & "  (#x#) " & "#NumberFormat(Object,"0999")#">
                             </cfif>
						</cfif>
					<cfelse>
						<cfset TmpObject= "#NumberFormat(Object,"0999")#">
					</cfif>
					<cfif trim(TmpAmount) is not "">
                    	<cfif not TmpAmount contains "#Warrant_Amt#">
                        	<cfif x eq 2>
								<cfset TmpAmount= "(1) " & TmpAmount & "  (#x#) " & "#Warrant_Amt#">
                            <cfelse>
                            	<cfset TmpAmount=  TmpAmount & "  (#x#) " & "#Warrant_Amt#">
                            </cfif>
                        </cfif>
					<cfelse>
						<cfset TmpAmount = "#Warrant_Amt#">
					</cfif>
					<cfif trim(TmpAppropriation_Name) is not "">
                    	<cfif not TmpAppropriation_Name contains "#appropNameDetails.name#">
                        	<cfif x eq 2>
								<cfset TmpAppropriation_Name= "(1) " & TmpAppropriation_Name & "  (#x#) " & "#appropNameDetails.name#">
                            <cfelse>
                            	<cfset TmpAppropriation_Name=  TmpAppropriation_Name & "  (#x#) " & "#appropNameDetails.name#">
                            </cfif>
                         </cfif>
					<cfelse>
						<cfset TmpAppropriation_Name= "#appropNameDetails.name#">
					</cfif>
					<cfif trim(TmpBegDtService) is not "">
                    	<cfif not TmpBegDtService contains "#DateFormat(Begin_Serv_Date,"mm/dd/yyyy")#">
                        	<cfif x eq 2>
								<cfset TmpBegDtService= "(1) " & TmpBegDtService & "  (#x#) " & "#DateFormat(Begin_Serv_Date,"mm/dd/yyyy")#">
                            <cfelse>
                            	<cfset TmpBegDtService=  TmpBegDtService & "  (#x#) " & "#DateFormat(Begin_Serv_Date,"mm/dd/yyyy")#">
                            </cfif>
                         </cfif>
					<cfelse>
						<cfset TmpBegDtService= "#DateFormat(Begin_Serv_Date,"mm/dd/yyyy")#">
					</cfif>
                    <cfif trim(TmpEndDtService) is not "">
                    	<cfif not TmpEndDtService contains "#DateFormat(End_Serv_Date,"mm/dd/yyyy")#">
                        	<cfif x eq 2>
								<cfset TmpEndDtService= "(1) " & TmpEndDtService & "  (#x#) " & "#DateFormat(End_Serv_Date,"mm/dd/yyyy")#">
                            <cfelse>
                            	<cfset TmpEndDtService=  TmpEndDtService & "  (#x#) " & "#DateFormat(End_Serv_Date,"mm/dd/yyyy")#">
                            </cfif>
                         </cfif>
					<cfelse>
						<cfset TmpEndDtService= "#DateFormat(End_Serv_Date,"mm/dd/yyyy")#">
					</cfif>
					<cfset x=x+1>
					
					</cfoutput>
                </cfloop>
                
                <cfoutput>
            	<td>#Tmpfund#</td>
				<td>#TmpAgency# / #Tmpname#</td>
				<td>#TmpOrganization#</td>
				<td>#TmpAppropriation#</td>
				<td>#TmpObject#</td>
				<td>#TmpAmount#</td>
				<td><em>#TmpAppropriation_Name#</em></td>
                <td>#TmpBegDtService#</td>
                <td>#TmpEndDtService#</td>
                </cfoutput>
                
            <!---	
             </td>    
			 --->  
            
		<!---</cfif> ---> 
        
      </TR>
    
    </cfloop>

</TABLE>
 
</cfsavecontent>

<!--- <cfoutput>
#strexceldata#
</cfoutput>
 --->
<cfheader
 name="content-disposition"
 value="attachment; filename=data.xls"
 />  
        
<cfcontent
 type="application/msexcel"
 reset="true" />

 <!--- Write the output. --->

 <cfset WriteOutput( strExcelData.Trim() )/> 

 <!---
 <cfcatch type="any">
 <b>We are sorry but we could NOT create the Excel Spreadsheet for you.  Try selecting a Smaller ranger of Vendor Payments before trying to download them to Excel.</b>
 </cfcatch>
 </cftry>
 --->
 <!---</cflock>--->

 <!---
 Exit out of template to prevent unexpected data
 streaming to the browser (on request end??).
 --->
 <cfabort>
<cfexit /> 

</cfif>

<cfsetting enablecfoutputonly="false">