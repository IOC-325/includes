<cfif isDefined("form.VendorName")>
  <cfset StructDelete(Session, "VendorName")>
  <cfset Session.VendorName = trim(form.VendorName)>
</cfif>


<cfif isDefined("Session.VendorName")>

  <CFSET variables.strVendor_Name = UCase(Session.VendorName)>
  <CFSET variables.NewLength = Len(variables.strVendor_Name) - 1>
  <CFIF variables.NewLength gt 0>
    <CFSET variables.BeginStr = Left(variables.strVendor_Name, variables.NewLength)>
  <CFELSE>
    <CFSET variables.BeginStr = "">
  </CFIF>

  <CFSET variables.EndChar = Asc(Right(Session.VendorName,1)) + 1> 
  <CFSET variables.LastStr = "#variables.BeginStr##Chr(variables.EndChar)#"> 
  <CFSET variables.LastStr = UCase(variables.LastStr)> 



  <!-- Vendor Name Search Query -->
  <CFQUERY NAME="qryVendorSearchResults" DATASOURCE="DB2PRD">
  SELECT a.VENDOR_NAME, a.VENDOR_TIN
  FROM wh.VENDOR as a inner join wh.pw_contract as b on a.Vendor_TIn = b.vendor
  WHERE a.Vendor_Name BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.strVendor_Name#" />
   AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.LastStr#" />
  GROUP BY VENDOR_NAME, VENDOR_TIN
  ORDER BY VENDOR_NAME    
  </CFQUERY>

<cfif qryVendorSearchResults.recordCount>

  <div id="content"><p>Records have been found. Please look below and click the Contract Listing button next to the Vendor whose information you seek.</p>

  <cfparam name="StartRow" default="1">
  <cfParam name="variables.MaxRows" default="20">
  <TABLE CELLPADDING="5" CELLSPACING="0" BORDER="1" BORDERCOLOR="#000000" WIDTH="100%" class="table-responsive">
  <tr><th>Vendor</th><th>Command</th></tr>
  <cfoutput query="qryVendorSearchResults" startrow="#StartRow#" maxrows="20">
     <tr>
        <td>#Vendor_Name#</td>      
        <td>
          <form role="form" name="prevailingWageVenForm" method="Post">
            <input type="Hidden" name="Vendor_Name" value="#Vendor_Name#">
            <input type="Hidden" name="Vendor_TIN" value="#vendor_TIN#">       
            <input type="submit" value="Contract Listing">
          </form>            
        </td>
     </tr>        

  </cfoutput>
  </table>
  <cfset variables.totRows = startRow + variables.MaxRows>

  <cfif StartRow gt 20>
  <cfoutput><a href="#$.content().getURL()#?mcaction=getVendorInfo&StartRow=1&Vendor_Name=#Session.VendorName#">First 20</a></cfoutput> |||
  <cfset variables.Prev20 = variables.totRows - 40>
  <cfoutput><a href="#$.content().getURL()#?mcaction=getVendorInfo&StartRow=#variables.prev20#&Vendor_Name=#Session.VendorName#">Prev 20</a></cfoutput> |||
  </cfif>

  <cfif qryVendorSearchResults.recordCount gt variables.totRows>
  <cfoutput>
  <a href="#$.content().getURL()#?mcaction=getVendorInfo&StartRow=#variables.totRows#&Vendor_Name=#Session.VendorName#">Next 20</a> ||| 
  <cfset variables.startRow=qryVendorSearchREsults.recordCount-20>
  <a href="#$.content().getURL()#?mcaction=getVendorInfo&StartRow=#variables.startRow#&Vendor_Name=#Session.VendorName#">End of list</a></cfoutput>
  <cfelse>

  </cfif>

  <cfelse>

  <div id="notFound"><p>Sorry, no prevailing wage contracts have been reported to our Office for that Vendor.</p></div>

</cfif>
</div>


</cfif>  

