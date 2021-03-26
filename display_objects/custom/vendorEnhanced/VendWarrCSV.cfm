
<!---
Modified Date: 10-14-14
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Deduction site per SR 14136
--->

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">

<cfif not isdefined("Session.VendTIN")>
	<cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>

</cfLock>

<CFSET Area = "VendWarrCSVForm">

<!---<CFINCLUDE TEMPLATE="VendHeader.cfm">--->

<cfinclude template="VendorSQL.cfm">

<!--- ***************************************************************** --->
<!--- *                   CSV File                                    * --->
<!--- ***************************************************************** --->

    <cfset TmpFileName = "VendWarr" & "_" & #right(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),4)#  & "_" & #DateFormat(attributes.StartDate,"mm_dd_yyyy")#  & "_" & #createODBCDate(attributes.EndDate)# & ".xls">

        
    <cfset Counter=0>
    <cfcontent type="application/msexcel">
    <CFSETTING ENABLECFOUTPUTONLY="Yes" SHOWDEBUGOUTPUT="No">
  <!---  <cfsetting enablecfoutputonly="yes">--->
    <!---<cfprocessingdirective suppresswhitespace="yes">--->
    <cfoutput>
    <cfheader name="Content-Disposition" value="filename=#TmpFileName#.csv">

    <cfif isdefined("Results")>
    	 <cfif SpreadsheetStartRow+999 gt Session.TotRecCnt>
    		<cfset TmpEnd = "#Session.TotRecCnt#">
    	<cfelse>
    		<cfset TmpEnd = #SpreadsheetStartRow#+999>
    	</cfif>
        <cfloop query="Results">
            <CFSET Counter = Counter + 1>
            <CFIF Counter IS 1>
               Warrant/EFT,Addr Ind,Zip Code,Issue Date,Anticipated Direct Deposit Date,Total Voucher Amount,Total Offset,Total Fee,Payment Amount,Voucher Number,Paid Date,Contract Number,Vendor Invoice,Fiscal Year,Warrant Status,Invoice Date,Vendor Name,Vendor Name 2,Vendor Address
              <!---,Description,Agency Contact Information,Fund,Agency,Organization,Appropriation,Object,Amount,Appropriation Name,Beginning Date of Service,End Date of Service--->
            </CFIF>
            <CFQUERY NAME="OffsetInfo" DATASOURCE="VendorDB2" CACHEDWITHIN="#CreateTimeSpan(0,0,10,0)#">
            
            SELECT Tot_Offset_Amt, Tot_Fee_Amt
            FROM WH.IOC_WARR_OFFST_FEE
            WHERE 
           <!--- TRANSACTION_NUMBER = '#Transaction_Number#' 
            AND ACCEPTANCE_DATE = #CreateODBCDate(Acceptance_date)#--->
            TRANSACTION_NUMBER =<cfqueryparam cfsqltype="cf_sql_char" value="#Transaction_Number#">
            AND ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(Acceptance_date)#">
        	</CFQUERY>
            
            #TRANSACTION_NUMBER#,#Addr_Ind#,#ZIP_CODE#,#DateFormat(RECORD_DATE,"m/d/yyyy")#
       		<cfif Transaction_Code is not "EF">
        		,&nbsp;
        	<cfelse>
        	
				<!--- Calculate Anticipated Date --->
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
                
                ,#DateFormat(CalcAnticipatedDt,"mm/dd/yyyy")#
            </cfif>
            ,#DollarFormat(Tot_Voucher_Amt)#
            ,#DollarFormat(OffsetInfo.Tot_Offset_Amt)#
            ,#DollarFormat(OffsetInfo.Tot_Fee_Amt)#
            ,#DollarFormat(TOT_WARRANT_AMT)#
            ,&nbsp;#VNumber#	
            ,#Dateformat(Paid_Date,'m/d/yyyy')#
            ,&nbsp;#contract_number#
            ,&nbsp;#vendor_invoice#
            ,#fiscal_year#
            ,#warrant_status#
            ,#DateFormat(Invoice_Date, "mm/dd/yyyy")#
            ,#Name1#
            ,#Name2#
            ,#trim(Address)#<cfif trim(City) is not "">;  </cfif>#trim(City)#<cfif trim(City) is not "">   </cfif>#State#  #ZIP_Code#
            
        </cfloop> 
    <cfelse>
    	No Deductions for selected criteria
    </cfif> 
    </cfoutput>      
    <!---</cfprocessingdirective>--->
	<cfabort>

 
 <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    
