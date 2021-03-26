<style>
@media print {
  table td a[href]:after {
    content: none !important;
  }
}

@media print {
    #Header, #footer { display: none !important; }
}
</style>
<CFIF NOT IsDefined ("URL.ID")>
 <cfabort>
</CFIF>
 <cfinvoke component="#m.getBean('StateContract_SQL')#"
    method="GetContractDetailsPerCN"
    returnvariable="qCD" >
  	<cfinvokeargument name="Contract_Number" value="#URL.ID#"/>
    <cfinvokeargument name="Fiscal_Year" value="#URL.ID2#"/>
    <cfinvokeargument name="Transaction_Agency" value="#URL.ID3#"/>
    <cfinvokeargument name="Class_Code" value="#URL.varClassCode#"/>
    
</cfinvoke>
 <cfinvoke component="#m.getBean('StateContract_SQL')#"
    method="GetContractFundInfoPerContractNumber"
    returnvariable="qCD2" >
  	<cfinvokeargument name="Contract_Number" value="#URL.ID#"/>
    <cfinvokeargument name="Fiscal_Year" value="#URL.ID2#"/>
    <cfinvokeargument name="Transaction_Agency" value="#URL.ID3#"/>
    <cfinvokeargument name="Class_Code" value="#URL.varClassCode#"/>    
</cfinvoke>
<CFIF IsDefined ("cookie.StateContracts")  AND ListLen(cookie.StateContracts) IS 6>
	<CFSET variables.FindVendor = TRIM(ListGetAt(cookie.StateContracts,1))>
    <CFSET variables.FY = TRIM(ListGetAt(cookie.StateContracts,2))>
    <CFSET variables.AgencyName = TRIM(ListGetAt(cookie.StateContracts,3))>
    <CFSET variables.AwardDescription = TRIM(ListGetAt(cookie.StateContracts,4))>
    <CFSET variables.TypeDescription = TRIM(ListGetAt(cookie.StateContracts,5))>
    <CFSET variables.contractClass = TRIM(ListGetAt(cookie.StateContracts,6))>
	<CFSET variables.ContractVendor = "">

</CFIF>


<!--- Determine if contract covers mutlipe years? --->
<CFSET BeginningContractYear = qCD.MULT_FY_FROM_DATE>
<!--- <CFSET EndingContractYear = qCD.End_FY> --->

<CFIF Trim(BeginningContractYear) NEQ ''>
	<CFSET MutliYear = "Yes">
<cfelse>
	<CFSET MutliYear = "NA">
</CFIF>
<style>
/* unvisited link */
a:link {
    color: blue;
}

/* visited link */
a:visited {
    color: purple;
}

/* mouse over link */
a:hover {
    color: red;
}

/* selected link */
a:active {
    color: yellow;
}
.smallTable { 
    width: 78% !important;  /*Custom your width*/
 }
</style>

<cfoutput>
<div style="padding:20px 0px 0px 20px">
<table width="100%" border="0" style="font-size: 20px !important;">
  <tr>
    <td><h1>State Contract Detail</h1></td>
    <td>
     <table width="100%" border="0">
            <tr>
            <td width="30%">&nbsp;</td>
            <td>
            	<table>
                	<tr>
                    	<td><CFIF TRIM(URL.ID4) IS NOT ""><a href="/CTDDocs/#URL.ID4#" target="_blank">Show CTD</a></CFIF></td>
                        <td style="padding:0px 0px 0px 20px"><a href="#$.content().getURL()#?mcaction=paymentDetails&ID=#URL.ID#&ID2=#URL.ID2#&ID3=#URL.ID3#&ID4=#URL.ID4#&varClassCode=#URL.varClassCode#&VName=#URL.VName#">Show Payments</a></td>
                        <td style="padding:0px 0px 0px 20px">
                       <CFIF IsDefined ("cookie.StateContracts")  AND ListLen(cookie.StateContracts) IS 6>
                        
                         <a href="#$.content().getURL()#?contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.contractClass#&contractType=#variables.TypeDescription#&ContractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#">Return to State Contracts</a>
                        
                        <cfelse>
                        <a href="/financial-data/state-expenditures/state-contract-tst?ID=#URL.ID#&ID2=#URL.ID2#&ID3=#URL.ID3#&ID4=#URL.ID4#">Return to State Contracts</a>
                        </CFIF>
                        </td>
                    </tr>
                </table>
            </td>
            </tr>
        </table>
    </td>
  </tr>
 
  <tr>
    <!--- <td colspan="2"><h4>Detailed Informatin on Contract <B>###URL.ID#</B> with <B>VENDOR:</B> #qCD.Name#</h4></td> --->
    <td colspan="2"><h4>For AGENCY: <B>&nbsp;#qCD.AGENCY_NAME#&nbsp;&nbsp;</B> CONTRACT: <B>&nbsp;###URL.ID#&nbsp;</B> with VENDOR: <B>#URL.VName#</B></h4></td>
  </tr>
  <tr>
    <td>
        <table>
            <tr>
                <td align="right">Budget Fiscal Year:</td>
                <td  style="padding:0px 20px 0px 0px" align="left"><b>&nbsp;&nbsp;&nbsp;#qCD.Fiscal_Year#</b></td>
            </tr>          
            <tr>
                <td align="right">Current Year Contract From Date:</td>
                <td style="padding:0px 20px 0px 0px" align="left"><B>&nbsp;&nbsp;&nbsp;#DateFormat(qCD.From_Date, "mm/dd/yyyy")#</B></td>
            </tr>
            <tr>
                <td align="right">Current Year Contract To Date:</td>
                <td style="padding:0px 20px 0px 0px" align="left"><B>&nbsp;&nbsp;&nbsp;#DateFormat(qCD.To_Date, "mm/dd/yyyy")#</B></td>
            </tr>            
            <tr>
                <td align="right">Maximum Contract Amount:</td>
                <td style="padding:0px 20px 0px 20px" align="right"><B>#DollarFormat(qCD.MAX_CONTRACT_AMT)#</B></td>
            </tr>
           <tr>
                <td  align="right">Annual Contract Amount:</td>
                <td style="padding:0px 20px 0px 20px" align="right"><B>#DollarFormat(qCD.Contract_Amt)#</B></td>
            </tr>
        </table>

    
    </td>
    <td>
    <table>
            <tr>
                <td align="left">Master Contract Number: &nbsp;<cfif TRIM(qCD.MASTER_CONTRACT) NEQ ''><B>#qCD.MASTER_CONTRACT#</B><cfelse><B>NA</B></cfif></td>
            </tr>
            <tr>
                <td>Master Contract Maximum Amount:&nbsp;<cfif TRIM(qCD.MASTER_CONTRACT) NEQ ''><B>#DollarFormat(qCD.MASTER_CONTRACT_MAX_AMOUNT)#</B><cfelse><B>NA</B></cfif></td>
            </tr>
            <tr>
                <td>Referencing Contract Maximum Amount:&nbsp;<cfif TRIM(qCD.MASTER_CONTRACT) NEQ ''><B>#DollarFormat(qCD.REFERNCING_CONTRACT_MAX_AMOUNT)#</B><cfelse><B>NA</B></cfif></td>
            </tr>
            <!--- <tr>
                <td>Legal Status:</td>
                <td style="padding:0px 20px 0px 20px"><B>#qCD.LEGAL_STATUS#</B></td>
            </tr> --->
        </table>
    
    </td>
  </tr>
  <tr>
  	<td colspan="2"><BR />&nbsp;</td>
  </tr>
  <tr>
    <td>
        <table>
<!---             <tr>
                <td>Budget Fiscal Year:</td>
                <td style="padding:0px 20px 0px 20px"><b>#qCD.Fiscal_Year#</b></td>
            </tr> --->
            <tr>
                <td>Multiple Year: </td>
                <td style="padding:0px 20px 0px 20px"><b><cfif MutliYear EQ "Yes">Yes<cfelse>NA</cfif></b></td>
            </tr>
            <cfif MutliYear EQ "Yes">
              <tr>
                  <td>Multiple Year From:</td>
                  <td style="padding:0px 20px 0px 20px"><b>#DateFormat(qCD.MULT_FY_FROM_DATE, "mm/dd/yyyy")#</b></td>
              </tr>
              <tr>
                  <td>Multiple Year To:</td>
                  <td style="padding:0px 20px 0px 20px"><b>#DateFormat(qCD.MULT_FY_TO_DATE, "mm/dd/yyyy")#</b></td>
              </tr>
            </cfif>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>

    
    </td>
    <td>
    	<table>
            <tr>
                <td>Compensation Rate:&nbsp;<b>#DollarFormat(qCD.CMPNSATON_PAY_RATE)#</b></td>
            </tr>
            <tr>
                <td>Unit:&nbsp;<b>#qCD.UNIT_DESCRIPTION#</b></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
          
        </table>
    </td>
  </tr>
  <tr>
    <td>
      <table border="0">
        <tr>
            <td>Contract Type:</td>
            <td style="padding:0px 20px 0px 20px"><b>#qCD.CONTRACT_DESCRIPTION#</b></td>
        </tr>
        <tr>
            <td>Award Code:</td>
            <td style="padding:0px 20px 0px 20px"><b>#qCD.AWARD_DESCRIPTION#</b></td>
        </tr>
        </table>
    </td>
    <td>
        <table border="0">
        <tr>
            <td>Fixed Price:</td>
            <td style="padding:0px 20px 0px 20px"><b><cfif UCASE(qCD.FIXED_PRICE_FLAG) EQ 'Y'>Yes<cfelse>No</cfif></b></td>            

        </tr>
        <tr>
            <td>Class Code:</td>
             <td style="padding:0px 20px 0px 20px"><b>#qCD.CLASS_DESCRIPTION#</b></td>
        </tr>
        <!--- <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>Advance Payment:</td>
            <td style="padding:0px 20px 0px 20px"><b>#qCD.ADVANCE_PYMNT_IND#</b></td>
        </tr> --->
        </table>

    
    </td>
  </tr>
  <tr>
  	<td colspan="2"><BR />&nbsp;</td>
  </tr>
  <tr>
    <td valign="top">
        <table width="100%">
            <tr>
                <td>Publication:&nbsp;<b><CFIF IsDate(qCD.Publication_Date)>#DateFormat(qCD.PUBLICATION_DATE, "mm/dd/yyyy")#<cfelse>N/A</CFIF></b></td>
                <td>Ref: ##&nbsp;<b><CFIF TRIM(qCD.Ref_Number) IS "">N/A<cfelse>#qCD.REF_NUMBER#</CFIF></b></td>
            </tr>
            <tr>
                <td>Subcontractor Utilized:&nbsp;<b><cfif UCASE(qCD.SUBCONTRACTR_UTIL) EQ 'Y'>Yes<cfelse>No</cfif></b></td>
                <td>Disclosed:&nbsp;<b><cfif UCASE(qCD.DISCLOSED) EQ 'Y'>Yes<cfelse>No</cfif></b></td>
            </tr>
        </table>

    </td>
    <td style="padding:0px 20px 0px 0px">
    	
     <div class="widget widget-table">
     <div class="widget-content">
      <!--- <table class="table table-sorting datatable table-striped" border="1"> --->
      <table class="table smallTable table-sorting table-striped" border="1">
       <thead>
        <tr>
         <th class="text-center">Fund</th>
         <th class="text-center">Organization</th>
         <!--- <th>Object</th> --->
         <th class="text-center">Appropriation Unit</th>
         <th class="text-center">Amount</th>
        </tr>
       </thead>
       <tbody>
        <cfloop query = "qCD2">
         <tr>
          <td class="text-center">#qCD2.Fund#</td>
          <td class="text-center">#qCD2.ORGANIZATION#</td>
          <!--- <td>#qCD2.OBJECT#</td> --->
          <td class="text-center">#qCD2.APPROPRIATION#</td>
           <td align="right">#DollarFormat(qCD2.LINE_AMOUNT)#</td>
         </tr>
        </cfloop>
        <cfif qCD2.RecordCount EQ 0>
          <tr><td colspan="5" align="center"> No Record Found </td></tr>
        </cfif>
       </tbody>
      </table>
     </div>
    </div>
    </td>
  </tr>
 
</table>
</div>
</cfoutput>
