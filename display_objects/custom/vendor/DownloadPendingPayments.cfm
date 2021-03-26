<!---
  Modified Date: 08-23-19
	Modified By: Raghu Bhonnam
	Description: SR19115 Updated Vendor Name for Payments Issued Page.  
--->

<cfif not isdefined("session.TheVendTin")>
  <cflocation url="/vendors?TimedOut=True" addtoken="No">
</cfif>

<cfif isDefined("session.TheVendTin")>
 <cfset vendTIN = Decrypt(session.TheVendTin,"ITBG111")>
</cfif>

<CFIF IsDefined ("form.PVTX")>
 <CFSET PVTX = form.PVTX>
<cfelseif IsDefined ("URL.PVTX")>
 <CFSET PVTX = URL.PVTX>
</CFIF>

<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->
<CFIF IsDefined ("form.vendorName")>
 <CFSET vendorName = form.vendorName>
<cfelseif IsDefined ("URL.vendorName")>
 <CFSET vendorName = URL.vendorName>
</CFIF>
<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->

<CFIF IsDefined ("form.LineDetails")>
 <CFSET LineDetails = form.LineDetails>
<cfelseif IsDefined ("URL.LineDetails")>
 <CFSET LineDetails = URL.LineDetails>
</CFIF>

<cfinclude template="vendorPendingSQL.cfm">


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
   <!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 ---> 
   <TR>
    <cfoutput><TH ALIGN="center" COLSPAN="8">#vendorName#</TH></cfoutput>
   </TR>	
   <!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->
   <TR>
    <TH ALIGN="center" COLSPAN="8" id="IOCDetails">Pending Payments</TH>
   </TR>
   <TR id="darkcolor">
    <TD ALIGN="center" COLSPAN="1" id="Fund3">Voucher Number</TD>
    <TD ALIGN="center" COLSPAN="1" id="Agency5">Agency</TD>    
    <TD ALIGN="RIGHT" COLSPAN="1" id="Agency5">Voucher Date</TD>
    <TD ALIGN="RIGHT" COLSPAN="1" id="Agency5">Voucher Amount</TD>
    <!--- <TD ALIGN="RIGHT" COLSPAN="1" id="Agency5">Scheduled Payment Date</TD> --->
      <cfif isDefined("PVTX")>
      <TD class="header" align="center">Description</TD>
      </CFIF>
      <CFIF ISDEFINED("LineDetails")>
            <TD class="header" align="center">Accounting Line Details</TD> 
      </cfif>               
   </TR>


   <CFLOOP QUERY="Results">
    <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
     <CFOUTPUT>
            <TD COLSPAN="1" ALIGN="CENTER" id="Fund4">#Voucher_Number#</TD>
            <TD COLSPAN="1" ALIGN="center" id="Amount4">#Agency# - #Name#</TD>              
             <TD COLSPAN="1" ALIGN="RIGHT" id="ToDate4">#DateFormat(Voucher_Date,"mm/dd/yyyy")#&nbsp;</TD>
             <TD COLSPAN="1" ALIGN="RIGHT" id="Amount4">#dOLLarFormat(Voucher_Amt)#</TD>             
             <!--- <TD COLSPAN="1" ALIGN="RIGHT" id="ToDate4">#DateFormat(SCHED_PYMNT_DATE,"mm/dd/yyyy")#&nbsp;</TD> --->
            <cfset tempAGENCY = #AGENCY#>
            <cfset tempVoucher_Number = #Voucher_Number#>
   </CFOUTPUT>
  <cfif isDefined("PVTX")>
                              
          <CFQUERY NAME="PVTX" DATASOURCE="DB2PRD" CACHEDWITHIN="#CreateTimeSpan(0,12,0,0)#">
            SELECT wh.IOC_PVTX.Text_LINE AS LINE , wh.IOC_PVTX.PV_TEXT AS TEXT
            FROM wh.IOC_PVTX
            WHERE 
                wh.IOC_PVTX.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTin#" />
              AND   wh.IOC_PVTX.VOUCHER_AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tempAGENCY#" />
                AND   wh.IOC_PVTX.VOUCHER_NUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tempVoucher_Number#" />
                AND   wh.IOC_PVTX.CNFIDENTAL_SWITCH = 'N'
            ORDER BY Text_LINE
            </CFQUERY>                              
            <TD>
            <cfif pvtx.recordcount>
            <CFOUTPUT query="PVTX">
                #TEXT#                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </CFOUTPUT>
            </cfif>
            </TD>    
    
  </cfif>
    
        <cfif isDefined("LineDetails")> 



            <td>
              <cfset myListNum = "1">

                  <CFQUERY DATASOURCE="DB2PRD" name="AppropNameDetails" cachedwithin="#CreateTimeSpan(0,12,0,0)#" >
                    SELECT  wh.TRANS_EXP.Fiscal_Year, wh.TRANS_EXP.ACCEPTANCE_DATE , wh.TRANS_EXP.Agency, wh.AGENCY.Name AS AgencyName
                    , wh.TRANS_EXP.AGENCY, wh.TRANS_EXP.fund, wh.TRANS_EXP.Invoice_Number, wh.TRANS_EXP.organization, wh.TRANS_EXP.Appropriation
                    , wh.TRANS_EXP.object, wh.Approp.Name AS AppropName, wh.TRANS_EXP.EXPENDED_AMT, wh.TRANS_EXP.REF_CONTRACT_NUM 
                    FROM  wh.TRANS_EXP , wh.AGENCY , wh.Approp
                    WHERE 
                        wh.TRANS_EXP.AGENCY = wh.AGENCY.AGENCY 
                      AND   wh.TRANS_EXP.FISCAL_YEAR = wh.AGENCY.FISCAL_YEAR 
                      AND   wh.TRANS_EXP.AGENCY = wh.Approp.AGENCY 
                      AND   wh.TRANS_EXP.FISCAL_YEAR = wh.Approp.FISCAL_YEAR    
                      AND   wh.TRANS_EXP.APPROPRIATION = wh.Approp.APPROPRIATION    
                      AND   wh.TRANS_EXP.FUND = wh.Approp.FUND    
                      AND   wh.TRANS_EXP.ORGANIZATION = wh.Approp.ORGANIZATION  
                      AND   wh.TRANS_EXP.OBJECT <> '9999'   
                      AND wh.TRANS_EXP.AGENCY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tempAGENCY#" />
                      AND   wh.TRANS_EXP.VENDOR_TIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#VendTin#" />
                      AND   wh.TRANS_EXP.Transaction_Number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tempVoucher_Number#" />
                  </CFQUERY>
                  <cfoutput query="AppropNameDetails">
                
                    (#MyListNum#) Fund #fund#, Agency #Agency# / #AgencyName#, Org #Organization#, Approp #Appropriation#, Obj #Object#, Amt #EXPENDED_AMT#, <em>#AppropName#</em>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfset myListNum = myListNum + 1>
        </cfoutput>
              
            </td>            
            
    </cfif>     
    </TR>
 </CFLOOP>

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