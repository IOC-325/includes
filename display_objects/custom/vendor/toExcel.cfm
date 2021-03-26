<!---
	SR 8103
	Date Migrated : 12/16/08
	Migrated By : ASP
	* Create and store the simple HTML data that you want to treat as an Excel file.

	Modified Date: 08-23-19
	Modified By: Raghu Bhonnam
	Description: SR19115 Updated Vendor Name for Payments Issued Page.  
--->

<hr>

<cfsavecontent variable="strExcelData">
 
	<style type="text/css">
 
		td {
			font-family: verdana ;
			font-size: 11pt ;
			}
 
		td.header {
			background-color: yellow ;
			border-bottom: 0.5pt solid black ;
			font-weight: bold ;
			}
 
	</style>
    

 
    <table border="1">	
	 
	    <!--- Code change on 8/23/19 by Raghu Bhonnam for SR19115 starts here--->
        <TR>
    		<cfoutput><TH ALIGN="center" COLSPAN="8">#vendorName#</TH></cfoutput>
        </TR>  
		<TR>
    		<TH ALIGN="center" COLSPAN="8">Payments Issued</TH>
   		</TR>
		<!--- Code change on 8/23/19 by Raghu Bhonnam for SR19115 ends here--->	
	    <TR>
            <TD class="header" align="center">Warrant/EFT#</TD>
            <TD class="header" align="center">Addr Ind</TD>
            <TD class="header" align="center">Zip Code</TD>		
            <TD class="header" align="center">Issue Date</TD>
            <TD class="header" align="center">Payment Amount</TD>
            <TD class="header" align="center">Voucher Number</TD>
            <TD class="header" align="center">Paid Date</TD>        	
            <TD class="header" align="center">Contract Number</TD>
            <TD class="header" align="center">Vendor Invoice</TD>
            <TD class="header" align="center">Fiscal Year</TD>
            <TD class="header" align="center">Warrant Status</TD>
			<cfif isDefined("PVTX")>
			<TD class="header" align="center">Description</TD>
			</CFIF>
			<CFIF ISDEFINED("LineDetails")>
            <TD class="header" align="center">Accounting Line Details</TD> 
			</cfif>           
		</TR>
    <cfloop query="Results">	
    	<TR>
		<CFOUTPUT>
        <TD align="center">#TRANSACTION_NUMBER#</TD>
		<TD  align="center">#Addr_Ind#</TD>
		<TD align="center">#ZIP_CODE#</TD>		
		<TD align="center">#DateFormat(RECORD_DATE,"m/d/yyyy")#</TD>
		<TD align="right">#DollarFormat(TOT_WARRANT_AMT)#</TD>
		<TD align="center">#VNumber#</TD>	
        <TD align="center">#Dateformat(Paid_Date,'m/d/yyyy')#</TD>
        <TD align="center">#contract_number#</TD>
        <TD align="center">#vendor_invoice#</TD>
		<TD align="center">#fiscal_year#</TD>
        <TD align="center">#warrant_status#</TD>
		</CFOUTPUT>
		<cfif isDefined("PVTX")>
                              
            <cfquery datasource="DB2PRD" name="PVTX" cachedwithin="#CreateTimeSpan(0,12,0,0)#">
            SELECT TEXT
            FROM WH.PVTX_NON_CNFDTL	
            WHERE 
            voucher_agency=<cfqueryparam cfsqltype="cf_sql_varchar" value="#results.voucher_agency#" />
            and voucher_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#results.VNUMBER#" />
            ORDER BY LINE 
            </cfquery>  
            <TD>
            <cfif pvtx.recordcount>
			<CFOUTPUT query="PVTX">
            #TEXT#	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </CFOUTPUT>
			<Cfelse>
			
			<cfquery datasource="DB2PRD" name="ContactInfo" cachedwithin="#CreateTimeSpan(0,12,0,0)#">
            SELECT	
			 WH.AGENCY_#FY#.CONTACT_INFO 
			FROM 	WH.TRANS_WARR_LINE_#FY# , WH.AGENCY_#FY#
			WHERE 	WH.TRANS_WARR_LINE_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#transaction_number#" /> 
    		 AND
			WH.TRANS_WARR_LINE_#FY#.AGENCY = WH.AGENCY_#FY#.AGENCY  
            AND
            WH.TRANS_WARR_LINE_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#vendor_tin#" />
			AND
			WH.TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(results.acceptance_date)#" /> 
            </cfquery>
			<CFOUTPUT QUERY="ContactInfo" MAXROWS="1">
			 
			 #contact_info#
			
			</CFOUTPUT>
			
            </TD>    
		
			</cfif>
		
		</cfif> 
        
        <cfif isDefined("LineDetails")>
        	<cfquery datasource="DB2PRD" name="LineDetails" cachedwithin="#CreateTimeSpan(0,12,0,0)#">
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
	WHERE 	WH.TRANS_WARR_LINE_#FY#.TRANSACTION_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#transaction_number#" /> 
    		 AND
			WH.TRANS_WARR_LINE_#FY#.AGENCY = WH.AGENCY_#FY#.AGENCY  
            AND
            WH.TRANS_WARR_LINE_#FY#.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#vendor_tin#" />
			AND
			WH.TRANS_WARR_LINE_#FY#.ACCEPTANCE_DATE = <cfqueryparam cfsqltype="cf_sql_date" value="#CreateODBCDate(results.acceptance_date)#" /> 
            </cfquery>

            <td>
            	<cfset myListNum = "1">
				<cfoutput query="LineDetails">
                    <cfquery datasource="DB2PRD" cachedwithin="#CreateTimeSpan(0,12,0,0)#" name="AppropNameDetails">
                    SELECT 	WH.APPROP_#FY#.NAME 
                    FROM 	WH.APPROP_#FY# 
                    WHERE 	WH.APPROP_#FY#.FUND = <cfqueryparam cfsqltype="cf_sql_varchar" value="#linedetails.fund#" /> AND 
                        WH.APPROP_#FY#.AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#linedetails.Agency#" /> AND 
                        WH.APPROP_#FY#.ORGANIZATION = <cfqueryparam cfsqltype="cf_sql_varchar" value="#linedetails.organization#" /> AND 
                        WH.APPROP_#FY#.APPROPRIATION = <cfqueryparam cfsqltype="cf_sql_varchar" value="#linedetails.appropriation# " />
                    </cfquery>
                
                    (#MyListNum#) Fund #fund#, Agency #Agency# / #name#, Org #Organization#, Approp #Appropriation#, Obj #Object#, Amt #warrant_Amt#, <em>#appropNameDetails.name#</em>
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfset myListNum = myListNum + 1>
				</cfoutput>
            	
            </td>            
            
		</cfif>  
        
      </TR>
    
    </cfloop>

</TABLE>
    
</cfsavecontent>

<cfoutput>
#strexceldata#
</cfoutput>

<!---uncomment this when you're ready for excel --->

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
 Exit out of template to prevent unexpected data
 streaming to the browser (on request end??).
 --->
<cfexit /> 


