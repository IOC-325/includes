<CFIF NOT IsDefined ("URL.ID")>
 <cfabort>
</CFIF>
 <cfinvoke component="ledger.includes.display_objects.custom.StateContractsSQL.Component.StateContract_SQL"
	method="VendorWarrantListingDatesAmounts"
	returnvariable="results" >
	<cfinvokeargument name="Agency" value="#URL.ID3#"/>
	<cfinvokeargument name="ContractNum" value="#URL.ID#"/>
	<cfinvokeargument name="ClassCode" value="#URL.varClassCode#"/>
	<cfinvokeargument name="VendorName" value="#URL.VName#"/>
	<cfinvokeargument name="Fiscal_Year" value="#URL.ID2#"/>
</cfinvoke>
<CFSET Total1 = 0>
<CFSET Total2 = 0>
<CFIF IsDefined ("cookie.StateContracts")  AND ListLen(cookie.StateContracts) IS 6>
	<CFSET variables.FindVendor = TRIM(ListGetAt(cookie.StateContracts,1))>
	<CFSET variables.FY = TRIM(ListGetAt(cookie.StateContracts,2))>
	<CFSET variables.AgencyName = TRIM(ListGetAt(cookie.StateContracts,3))>
	<CFSET variables.AwardDescription = TRIM(ListGetAt(cookie.StateContracts,4))>
	<CFSET variables.TypeDescription = TRIM(ListGetAt(cookie.StateContracts,5))>
	<CFSET variables.contractClass = TRIM(ListGetAt(cookie.StateContracts,6))>
	<CFSET variables.ContractVendor = "">
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
	width: 50% !important;  /*Custom your width*/
 }

</style>
<cfoutput>
	<table width="80%" align="center">
		<tr>
			<td><h3>Contract Number: <B>#URL.ID#</B></h3> </td>
			<td style="padding:0px 50px 0px 20px" align="right"><a href="/financial-data/state-expenditures/contracts/contract-details?ID=#URL.ID#&ID2=#URL.ID2#&ID3=#URL.ID3#&ID4=#URL.ID4#&varClassCode=#URL.varClassCode#&VNAME=#URLEncodedFormat(URL.VName)#">Show Contract Detail</a></td>
			<td style="padding:0px 50px 0px 20px" align="right">
			<CFIF IsDefined ("cookie.StateContracts")  AND ListLen(cookie.StateContracts) IS 6>
				 <a href="/financial-data/state-expenditures/contracts?contractFY=#variables.FY#&contractAgency=#variables.AgencyName#&contractClass=#variables.contractClass#&contractType=#variables.TypeDescription#&ContractAward=#variables.AwardDescription#&FindVendor=#variables.FindVendor#&ContractVendor=#variables.ContractVendor#">Return to State Contracts</a>             
			<cfelse>
				<a href="/financial-data/state-expenditures/contracts?ID=#URL.ID#&ID2=#URL.ID2#&ID3=#URL.ID3#&ID4=#URL.ID4#">Return to State Contracts</a>
			</cfif>
			</td>
		</tr>
		<tr>
		    <td><cfif ArrayLen(Results) GT 0>Agency: <B>#Results[1].AGENCY_NAME#</B></cfif> </td>
		</tr>
        <tr>
		    <td><cfif ArrayLen(Results) GT 0>Vendor: <B>#Results[1].VENDOR_NAME#</B></cfif></td>
		</tr>        
	</table>
	<cfif URL.ID2 EQ 2015>
	   <br/> <div class="alert alert-info col-sm-offset-2 col-sm-9">We're sorry, but payment information for Fiscal Year 2015 is not available on our web site.</div>
	<cfelse>
		<table id="tblVendWarrantList" class="table smallTable table-sorting table-striped" style="font-size:18px;"  align="center">
			<thead>
				<tr>
					<th>Issue Date</th>
					<th>Voucher Number</th>
					<!--- <th>Vendor Name</th> --->
					<th class="text-center">Payment Amount</th>
					<!--- <th>Total</th> --->
					<th></th>
				</tr>
			</thead>
			<tbody>
				<cfloop index="i" from="1" to="#ArrayLen(Results)#">
				<CFSET Total1 = Total1 + ReReplace(Results[i].Expended_Amt, "[^\d.]", "","ALL") >
				<CFSET Total2 = Total2 + ReReplace(Results[i].Total_Amt, "[^\d.]", "","ALL") >
				 <tr>
					<td>#DateFormat(Results[i].Acceptance_Date, "mm/dd/yyyy")#</td>
					<td>#Results[i].VOUCHER_NUMBER#</td>
					<!--- <td>#Results[i].VENDOR_NAME#</td> --->
					<td align="right">#TRIM(Results[i].Expended_Amt)#</td>
					<!--- <td>#Results[i].Total_Amt#</td> --->
					<td></td>
				 </tr>
				</cfloop>
			</tbody>
			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td align="right">TOTAL PAYMENTS: <b>#DOLLARFORMAT(Total1)#</b></td>
					<!--- <td>#DOLLARFORMAT(Total2)#</td> --->
					<td></td>
				</tr>
			</tfoot>
		 </table>
	</cfif>

</cfoutput>    

