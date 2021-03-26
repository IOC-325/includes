<cfscript>
  param name='message' default={};
</cfscript>

<!--- Copy this condition. It is mandatory for the url action to link (start) --->
<cfif isDefined("url.mcaction")>
   <cfinclude template="inc/#LCase(m.event('mcaction'))#.cfm" />
<cfelse>
<!--- Copy this condition. It is mandatory for the url action to link (end) --->  

<!--- Get all Agencies --->
<cfinvoke component = "model.beans.prevailingWage"
   method = "getCountyList"
   returnVariable = "qryCountyList">
 </cfinvoke>

<!---   <cfset TempUrl = cgi.HTTP_REFERER>
  <cfset TempServer = "https://" & cgi.SERVER_NAME>
  <cfset TempUrl = ListToArray(Replace(TempUrl, TempServer,'', 'All'),'?')[1] > --->


 <cfoutput>
<!--- <cfdump var="#application#"> --->

<div class="row">
    <cfif Not (IsDefined("form.County_Code") || IsDefined("form.VendorName") || IsDefined("form.FEIN") || IsDefined ("form.Vendor_Name") || IsDefined ("form.vendor_TIN"))>
        <!--- <h1>Welcome to Prevailing Wage Inquiries Site</h1> --->
        <div class="col-sm-12">
         <p> Taxpayers can now inquire about Prevailing Wage Act contracts that have been reported to our Office. You can inquire by entering a specific vendor name, vendor FEIN, or a county. The information returned will include the vendor name, contracting agency, contract number, original contract amount, original contract terms, county, location, and general description.</p>

         <!--- <p>Welcome to the Comptroller's Office Prevailing Wage Web Site. This page will provide you with information concerning recipients of state construction contracts and grants subject to the provisions of the Illinois Prevailing Wage Act. To enhance compliance with this Act, the Comptroller issued an Executive Order imposing standards on contracts and grants filed by state agencies. This web page presents information reported to our Office in the hope that it will foster greater public oversight and aid enforcement of the Act. You may search for information by Vendor Name, FEIN Number or by County.</p>
         <p>In order to use this web site most effectively, you will need to keep in mind the following considerations.</p>
          <ul>
              <li>This page does not include all contracts subject to the Illinois Prevailing Wage Act.  Many public works projects receive no state funding, but are still subject to the Illinois Prevailing Wage Act. Further, to a great extent, our Office is dependent on other State agencies to provide us with information about projects that do receive state funding. </li>
              <li>As stated previously, the prevailing wage information that appears on this site is reported to us by other State agencies that enter into contracts with various vendors.  Our Office requires that the agency and the vendor attest to the veracity of the information in the contract with signatures and certifications.   When the contract is received in this Office, it is subjected to various audit procedures.  However, we are not empowered to perform an in depth certification.  The contracting agency and their auditors have that responsibility.</li>
              <li>Currently, our Office requires that activity be reported to us for a maximum of 8 counties with corresponding location and description information. If a contract encompasses more than 8 counties or is Statewide, your area of interest may not be displayed.</li>
              <li>The contractor that you may see doing the actual work may be a subcontractor of the vendor that has the contract with the State agency.</li> 
              <li>The contractor name that you see displayed at the work site may not be the name that appears on the contract and that our Office would consequently have on file.</li>
              <li>If you search by county, only that county will be presented in those instances where the actual contract encompasses multiple counties.</li>
              <li>If you search by vendor name, only vendors with prevailing wage contracts appear on the selection list not the complete State vendor file.</li>
              <li>The available list of contracts begins with those filed with our Office during fiscal year 2006.</li>
              <li>The contracts listed are the original documents filed with our Office.  Any amendments or subsequent modifications are not shown.</li>
          </ul>
          <p>If you have any questions concerning the information on this site, please <a href="/about/contact/our-mailing-addresses-and-phone-numbers/">contact our office</a>.
          </p>      --->
        </div>
    </cfif>        
    <div class="col-sm-offset-2 col-sm-6">
      <div class="example alert alert-danger hidden" id="errorMsg"> Please Enter Search Criteria.</div>
    </div>

    <div class="col-sm-12 col-md-10 col-md-offset-1">
      <form role="form" name="prevailingWageVen" method="Post" id="searchform"> <!--- action="#$.content().getURL()#?mcaction=getVendorInfo" --->
        <div class="row">
            <div class="col-xs-12 col-sm-4 label-div">
                <div class="btn-label">Vendor Name</div>
            </div>

            <div class="col-xs-12 col-sm-5 col-md-6">
              <input placeholder="Enter Vendor Name in whole or in part." class="form-control" type="text" id="VendorName" name="VendorName" 
              <cfif isDefined("form.VendorName")> value="#form.VendorName#" <cfelseif IsDefined ("form.Vendor_Name")> value="#form.Vendor_Name#" <cfelse> value="" </cfif> >
            </div>
            <div class="col-xs-12 col-sm-3 col-md-2 text-center">
              <input type="submit" id="btnSearch" name="submitted" class="btn btn-label form-btn" value="Search">
            </div>
        </div>
      </form>
      <form role="form" name="prevailingWageFein" method="Post" id="searchform">
        <div class="row">
            <div class="col-xs-12 col-sm-4 label-div">
                <div class="btn-label">FEIN Number</div>
            </div>
            <div class="col-xs-12 col-sm-5 col-md-6">
              <input placeholder="Enter 9 digit FEIN number of the Vendor." class="form-control" type="password" id="FEIN" name="FEIN"
                <cfif isDefined("form.FEIN")> value="#form.FEIN#" <cfelseif IsDefined ("form.vendor_TIN")> value="#form.vendor_TIN#" <cfelse> value="" </cfif> >
            </div>
            <div class="col-xs-12 col-sm-3 col-md-2 text-center">
              <input type="submit" id="btnSearch" name="submitted" class="btn btn-label form-btn" value="Search">
            </div>            
        </div>
      </form>
      <form role="form" name="prevailingWageCounty" method="Post" id="searchform">
        <div class="row">
            <div class="col-xs-12 col-sm-4 label-div">
                <div class="btn-label">County</div>
            </div>
            <div class="col-xs-12 col-sm-5 col-md-6">
              <SELECT NAME="county_code" class="form-control select2">
                 <OPTION VALUE="0" SELECTED>Select County</OPTION>
                   <cfloop QUERY="qryCountyList">
                     <OPTION <cfif isDefined("form.county_code") AND form.county_code EQ Code> SELECTED="SELECTED" </cfif> VALUE="#Code#">#Name#</option>
                   </cfloop>
              </SELECT>
            </div>
            <div class="col-xs-12 col-sm-3 col-md-2 text-center">
              <input type="submit" id="btnSearch" name="submitted" class="btn btn-label form-btn" value="Search">
            </div>            
        </div>                
      </form>
    </div>
   </div>
<!--- action="?mcaction=getCountyInfo"  --->

<div class="reset-this"></div>
<div id="results" class="contract main2 margintop">
  <!--- form.County_Code, form.VendorName, form.FEIN  --->
  <CFIF IsDefined ("form.County_Code") AND (Not IsDefined("form.VendorName")) AND (Not IsDefined ("form.FEIN")) AND (form.County_Code NEQ "0")>
      <cfinclude template="inc/getCountyInfo.cfm">
  <cfelseif IsDefined ("form.FEIN") AND (Not IsDefined("form.VendorName")) AND (Not IsDefined ("form.County_Code")) AND (form.FEIN NEQ "")>
      <cfinclude template="inc/getFeinInfo.cfm">    
   <cfelseif IsDefined ("form.VendorName") AND (Not IsDefined("form.FEIN")) AND (Not IsDefined ("form.County_Code")) AND (form.VendorName NEQ "")>
      <cfinclude template="inc/getVendorInfo.cfm">   
   <cfelseif IsDefined ("form.Vendor_Name") AND IsDefined ("form.vendor_TIN") AND (Not IsDefined("form.FEIN")) AND (Not IsDefined ("form.County_Code")) AND (form.Vendor_Name NEQ "" AND form.vendor_TIN NEQ "")>
      <cfinclude template="inc/getContractListInfo.cfm">  
    </CFIF>

</div>

</cfoutput>

</CFIF>
<script type="text/javascript">
$(document).ready(function(){
  $(".select2").select2();
});  
</script>