<!---
	SR 8103
	Date Migrated : 12/16/08
	Migrated By : ASP

	Modified Date: 09-03-19
	Modified By: Raghu Bhonnam
	Description: SR19115 Updated Vendor Name for Payments Issued Page. 
--->

<cfif not isdefined("session.TheVendTin")>
	<cflocation url="/vendors?TimedOut=True" addtoken="No">
	<!---<CFLOCATION URL="#application.SecureWHWebRoot#/QuickTake/Vend/">--->
</cfif>


<cfif isDefined("session.TheVendTin")>
 <cfset vendTIN = Decrypt(session.TheVendTin,"ITBG111")>
</cfif>

 <!--- Code change by RK for SR 17070 starts here --->
<CFIF IsDefined ("form.Agency")>
 <CFSET Agency = form.Agency>
<cfelseif IsDefined ("URL.Agency")>
 <CFSET Agency = URL.Agency>
</CFIF>

<CFIF IsDefined ("form.Contsel")>
 <CFSET Contsel = form.Contsel>
<cfelseif IsDefined ("URL.Contsel")>
 <CFSET Contsel = URL.Contsel>
</CFIF>

<CFIF IsDefined ("form.INVSEL")>
 <CFSET INVSEL = form.INVSEL>
<cfelseif IsDefined ("URL.INVSEL")>
 <CFSET INVSEL = URL.INVSEL>
 <cfelse>
 <CFSET INVSEL = "">
</CFIF>

<CFIF IsDefined ("form.FY")>
 <CFSET FY = form.FY>
<cfelseif IsDefined ("URL.FY")>
 <CFSET FY = URL.FY>
</CFIF>

<CFIF IsDefined ("form.Status")>
 <CFSET Status = form.Status>
<cfelseif IsDefined ("URL.Status")>
 <CFSET Status = URL.Status>
 <cfelse>
 <CFSET Status = "All">
</CFIF>

<CFIF IsDefined ("form.SortBy")>
 <CFSET SortBy = form.SortBy>
<cfelseif IsDefined ("URL.SortBy")>
 <CFSET SortBy = URL.SortBy>
</CFIF>

<CFIF IsDefined ("form.AscDesc")>
 <CFSET AscDesc = form.AscDesc>
<cfelseif IsDefined ("URL.AscDesc")>
 <CFSET AscDesc = URL.AscDesc>
</CFIF>

<CFIF IsDefined ("form.PVTX")>
 <CFSET PVTX = form.PVTX>
<cfelseif IsDefined ("URL.PVTX")>
 <CFSET PVTX = URL.PVTX>
</CFIF>

<CFIF IsDefined ("form.LineDetails")>
 <CFSET LineDetails = form.LineDetails>
<cfelseif IsDefined ("URL.LineDetails")>
 <CFSET LineDetails = URL.LineDetails>
</CFIF>

<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->
<CFIF IsDefined ("form.vendorName")>
 <CFSET vendorName = form.vendorName>
<cfelseif IsDefined ("URL.vendorName")>
 <CFSET vendorName = URL.vendorName>
</CFIF>
<!--- Code change on 9/3/19 by Raghu Bhonnam for SR19115 --->

 <!--- Code change by RK for SR 17070 ends here --->

<!--- <cfif isDefined("sVendTIN")>
	<cfoutput>
 <cfset vendTIN = Decrypt(URLDecode(SVendTIN),"ITBG111")>
	</cfoutput>
</cfif> --->

<cfif len(VendTiN) eq 8>
	<cfSet VendTin="0#VendTIN#">
<cfelseif len(VendTiN) eq 7>
	<cfSet VendTin="00#VendTIN#">
<cfelse>
	<cfSet VendTin="#VendTIN#">
</cfif>

<cf_FormURL2Attributes>

<cfinclude template="vendorSQL.cfm">

	<!--- <TABLE border="1">
	     <TR>
         <TD ALIGN=CENTER CLASS="groupTitleNoBG">#TRANSACTION_NUMBER#</TD>
		<TD ALIGN=CENTER CLASS="groupTitleNoBG">#Addr_Ind#</TD>
		<TD ALIGN=CENTER CLASS="groupTitleNoBG">#ZIP_CODE#</TD>
		<TD ALIGN=CENTER CLASS="groupTitleNoBG">#DateFormat(RECORD_DATE,"mm/dd/yy")#</TD>
		<TD ALIGN=right CLASS="groupTitleNoBG">DollarFormat(TOT_WARRANT_AMT)</TD>
		<TD ALIGN=right CLASS="groupTitleNoBG">VNumber</TD>
        <TD>TEXT</TD>
        </TR>
    <cfloop query="Results">

    	<TR>
		<CFOUTPUT>
        <TD ALIGN=CENTER CLASS="groupTitleNoBG">#TRANSACTION_NUMBER#</TD>
		<TD ALIGN=CENTER CLASS="groupTitleNoBG">#Addr_Ind#</TD>
		<TD ALIGN=CENTER CLASS="groupTitleNoBG">#ZIP_CODE#</TD>
		<TD ALIGN=CENTER CLASS="groupTitleNoBG">#DateFormat(RECORD_DATE,"mm/dd/yy")#</TD>
		<TD ALIGN=right CLASS="groupTitleNoBG">#DollarFormat(TOT_WARRANT_AMT)#</TD>
		<TD ALIGN=right CLASS="groupTitleNoBG">#VNumber#</TD>

		</CFOUTPUT>
			<cfif isDefined("PVTX")>
                <!--- <CFINCLUDE template="qryPVTX.cfm"> --->

                <cfquery datasource="#application.whdsn#" name="PVTX">
                SELECT TEXT
                FROM WH.PVTX_NON_CNFDTL
                WHERE
                voucher_agency='#results.voucher_agency#'
                and voucher_number = '#results.VNUMBER#'
                ORDER BY LINE
                </cfquery>
                <TD>
                <CFOUTPUT query="PVTX">
                #TEXT#
                </CFOUTPUT>
                </TD>

            </cfif>

          </TR>

    </cfloop>

</TABLE> --->

<!--- <cfdump var="#results#"> --->

<!--- <cfinclude template="toExcel2.cfm">  --->

<!--- <cfinclude template="toExcelViaCFReport.cfm"> --->

<!--- <cfinclude template="toCSV.cfm"> --->
<!--- <cfabort> --->
<!--- <cfinclude template="toExcel3.cfm"> --->
<cfinclude template="toExcel.cfm">