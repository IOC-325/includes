<cfparam name="variables.db2dsn" default="DB2PRD" />

<cfparam name="FY" default="">
<cfparam name="Vendor" default="">
<cfparam name="Sendto" default="">


<cfif isDefined("form.contractFY")>
 <cfset variables.FiscalYear = form.contractFY>
<cfelse>
 <cfset variables.FiscalYear = "">
</cfif>

<cfif isDefined("form.contractAgency")>
 <cfset variables.AgencyName = form.contractAgency>
<cfelse>
 <cfset variables.AgencyName = "">
</cfif>

<cfif isDefined("form.contractClass")>
 <cfset variables.ClassDescription = form.contractClass>
<cfelse>
 <cfset variables.ClassDescription = "">
</cfif>

<cfif isDefined("form.contractType")>
 <cfset variables.TypeDescription = form.contractType>
<cfelse>
 <cfset variables.TypeDescription = "">
</cfif>

<cfif isDefined("form.contractAward")>
 <cfset variables.AwardDescription = form.contractAward>
<cfelse>
 <cfset variables.AwardDescription = "">
</cfif>

<cfif isDefined("form.contractVendor")>
 <cfset variables.vendorName = form.contractVendor>
<cfelse>
 <cfset variables.vendorName = "">
</cfif>



<cfif not isdefined("GetDefaultYear")>

 <cfinvoke component = "/ledger/includes/display_objects/custom/StateContractsSQL/Component/StateContract_DB2"
   method = "GetDefaultYear"
   srce="#variables.db2dsn#"
   returnVariable = "GetDefaultYear">

 <cfif isdefined("GetDefaultYear")>

  <cfif trim(FY) is "">
   <cfset FY = GetDefaultYear.Fiscal_Year>
  </cfif>
  <cfset CFY = GetDefaultYear.Fiscal_Year>
  <cfset PFY = GetDefaultYear.Fiscal_Year-1>
  <cfset PFY2 = GetDefaultYear.Fiscal_Year-2>
 </cfif>

</cfif>

<cfif isDefined("form.FindVendor")>
 <cfset Vendor="#trim(form.FindVendor)#">
</cfif>

<cfif isdefined("SetFY")>
 <cfset FY = "#Form.FindFY#">
 <cfset Vendor="#trim(FindVendor)#">
</cfif>


<cfif isdefined("ClearFY")>
 <cfset FY = "#CFY#">
 <cfset Vendor="">
</cfif>

<cfif not isdefined("GetContractInfo")>
 <cfif trim(Vendor) is not "">
  <cfset VendorName = "%#trim(Vendor)#%">
 <cfelse>
  <cfset VendorName = "">
 </cfif>



 <cfif trim(FY) is not "">
  <cfinvoke component = "/ledger/includes/display_objects/custom/StateContractsSQL/Component/StateContract_DB2"
   method = "GetContractInfo"
   FY = "#FY#"
   Vendor = "#UCase(VendorName)#"
   <!---srce="LedgerDB2" ---> srce="#variables.db2dsn#"
   returnVariable = "GetContractInfo">
 </cfif>
</cfif>


<cfoutput>


<!-- START PAYMENT -->
	<div id="payment" class="contract">
		<div class="container">
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1">
					<h1>#$.getTitle()#</h1>
					#$.getSummary()#
					<div class="row">

						<cfform name="DisplayValue" action="/Ledger/?LinkServID=9189969B-A18B-217C-CDD5409621DE44CC" method="Post">
							<fieldset>
								<div class="col-sm-8 col-sm-offset-2">
									<label>Search by Vendor Name</label>
									<input type="text"  name="FindVendor" size="32" maxlength="32" value="#Vendor#" class="form-control">
								</div>
								<div class="text-center col-sm-12">
									<button class="btn btn-success" type="submit">Search</button>
								</div>

								<div class="col-sm-12">
									<div class="row">
										<div class="dropdown">
           <cfquery name="qryFYs" dbtype="query">
             Select Distinct Fiscal_Year AS FiscalYear From GetContractInfo Group By Fiscal_Year ORDER BY Fiscal_Year DESC
           </cfquery>
           <cfquery name="qryAgency" dbtype="query">
              Select Distinct Agency_Name AS AgencyName From GetContractInfo Group By Agency_Name ORDER BY Agency_Name DESC
           </cfquery>
           <cfquery name="qryAward" dbtype="query">
              Select Distinct Award_Description AS AwardDescription From GetContractInfo Group By Award_Description ORDER BY Award_Description DESC
           </cfquery>
           <cfquery name="qryType" dbtype="query">
              Select Distinct Type_Description AS TypeDescription From GetContractInfo Group By Type_Description ORDER BY Type_Description DESC
           </cfquery>
           <cfquery name="qryClass" dbtype="query">
              Select Distinct Class_Description AS ClassDescription From GetContractInfo Group By Class_Description ORDER BY Class_Description DESC
           </cfquery>
           <cfquery name="qryVendorName" dbtype="query">
              Select Distinct Name AS vendorName From GetContractInfo Group By Name ORDER BY Name DESC
           </cfquery>

											<div class="col-sm-4">
												<select  id="contractVendor" name="contractVendor">
              <option value="0">All Vendor Names</option>
              <cfloop query = "qryVendorName">
               <option value="#qryVendorName.vendorName#" <cfif variables.vendorName eq qryVendorName.vendorName> selected </cfif>>#qryVendorName.vendorName#</option>
              </cfloop>
												</select>
											</div>
											<div class="col-sm-3">
												<select id="contractFY" name="contractFY">
              <option value="0">All Fiscal Years</option>
              <cfloop query = "qryFYs">
               <option value="#qryFYs.FiscalYear#" <cfif variables.FiscalYear eq qryFYs.FiscalYear> selected </cfif>>#qryFYs.FiscalYear#</option>
              </cfloop>
												</select>
											</div>
											<div class="col-sm-5">
												<select  id="contractAgency" name="contractAgency" >
              <option value="0">All Agencies</option>
               <cfloop query = "qryAgency">
                <option value="#qryAgency.AgencyName#" <cfif variables.AgencyName eq qryAgency.AgencyName> selected </cfif>>#qryAgency.AgencyName#</option>
               </cfloop>
												</select>
											</div>
											<div class="col-sm-4">
            <select  id="contractAward" name="contractAward" >
              <option value="0">All Award Descriptions</option>
               <cfloop query = "qryAward">
                <option value="#qryAward.AwardDescription#" <cfif variables.AwardDescription eq qryAward.AwardDescription> selected </cfif>>#qryAward.AwardDescription#</option>
               </cfloop>
            </select>
											</div>
											<div class="col-sm-4">
            <select  id="contractType" name="contractType" >
              <option value="0">All Type Descriptions</option>
               <cfloop query = "qryType">
                <option value="#qryType.TypeDescription#" <cfif variables.TypeDescription eq qryType.TypeDescription> selected </cfif>>#qryType.TypeDescription#</option>
               </cfloop>
            </select>
											</div>
											<div class="col-sm-4">
            <select  id="contractClass" name="contractClass" >
              <option value="0">All Class Descriptions</option>
               <cfloop query = "qryClass">
                <option value="#qryClass.ClassDescription#" <cfif variables.ClassDescription eq qryClass.ClassDescription> selected </cfif>>#qryClass.ClassDescription#</option>
               </cfloop>
            </select>
											</div>

										</div>
									</div>
								</div>
							</fieldset>
						</cfform>
						<div class="clearfix"></div>
						<div class="col-sm-12">
							<div class="result">
<!--- 								<table class="main">
									<tr>
										<td valign="top" class="col">
											<table>
												<tr><th class="bg-info">Vendor Name</th></tr>
												<tr><td><strong>Human Services Dept of</strong></td></tr>
												<tr><td><strong>Hearland Human Care Services INC</strong></td></tr>
												<tr><td><strong>Featherfist</strong></td></tr>
												<tr><td><strong>Access Living of Metropolitan Chicago</strong></td></tr>
												<tr><td><strong>Hearland Human Care Services INC</strong></td></tr>
											</table>
										</td>
										<td valign="top" class="col">
											<table>
												<tr><th class="bg-info">Agency</th></tr>
												<tr><td><strong>Aging</strong></td></tr>
												<tr><td><strong>Aging</strong></td></tr>
												<tr><td><strong>Aging</strong></td></tr>
												<tr><td><strong>Aging</strong></td></tr>
												<tr><td><strong>Aging</strong></td></tr>
											</table>
										</td>
										<td valign="top" class="col">
											<table>
												<tr><th class="bg-info">Current Amount</th></tr>
												<tr><td>$1,500,000.00</td></tr>
												<tr><td>$107,200.00</td></tr>
												<tr><td>$135,600.00</td></tr>
												<tr><td>$103,920.00</td></tr>
												<tr><td>$207,120.00</td></tr>
											</table>
										</td>
										<td valign="top" class="col">
											<table>
												<tr><th class="bg-info">Expended </th></tr>
												<tr><td>$1,500,000.00</td></tr>
												<tr><td>$14,400.00</td></tr>
												<tr><td>$12,400.00</td></tr>
												<tr><td>$36,000.00</td></tr>
												<tr><td>$10,800.00</td></tr>
											</table>
										</td>
										<td valign="top" class="col">
											<table>
												<tr><th class="bg-info">Contract ##</th></tr>
												<tr><td>6COLMONITOR</td></tr>
												<tr><td>6COL1512001</td></tr>
												<tr><td>6COL1512002</td></tr>
												<tr><td>6COL1512003</td></tr>
												<tr><td>6COL1513001</td></tr>
											</table>
										</td>
									</tr>
								</table> --->
         <table class="main">
                <tr>
                  <th class="bg-info"><br><br>Agency<br></th>
                  <th class="bg-info"><br>Contract<br>Number<br></th>
                  <th class="bg-info"><br>Award<br>Description<br></th>
                  <th class="bg-info"><br>Type<br>Description<br></th>
                  <th class="bg-info"><br>Class<br>Description<br></th>
                  <th class="bg-info"><br><br>Vendor<br></th>
                  <th class="bg-info"><br>Vendor<br>Line 2<br></th>
                  <th class="bg-info"><br>From<br>Date<br></th>
                  <th class="bg-info"><br>To<br>Date<br></th>
                  <th class="bg-info">Current<br>Contract<br>Amount<br></th>
                  <th class="bg-info">Planned<br>Contract<br>Amount<br></th>
                  <th class="bg-info">Current<br>Expended<br>Amount<br></th>
                </tr>
                <cfloop query="GetContractInfo">
                 <cfset TmpSubject="FOIA%20Request%20for%20Contract Number%20" & #trim(Contract_Number)#>
                 <cfset TmpBody="My%20name%20is%20[Replace%20this%20text%20with%20your%20First%20and%20Last%20Name]%20and%20I%20represent%20[Please%20replace%20this%20text%20with%20your%20employer%20if%20this%20request%20pertains%20to%20your%20job%20responsibilities;%20otherwise,%20just%20delete%20this%20text.].  Pursuant%20to%20the%20Illinois%20Freedom%20of%20Information%20Act%20(5%20ILCS%20140/1%20et%20seq.),%20I%20respectfully%20request%20a%20copy%20of%20contract%20number%20" & #trim(Contract_Number)# & ",%20an%20agreement%20between%20" & #trim(Agency_Name)# & "%20and%20" & #trim(Name)# & ".%20%20I%20understand%20the%20Office%20of%20the%20Comptroller%20will%20not%20impose%20a%20fee%20for%20processing%20non-commercial%20requests%20but%20reserves%20its%20statutory%20right%20to%20impose%20such%20fees%20in%20the%20future.%20%20I%20further%20understand%20that%20a%20representative%20from%20the%20Office%20of%20the%20Comptroller%20will%20contact%20me%20at%20the%20e-mail%20address%20provided%20to%20establish%20a%20delivery%20method%20that%20best%20fits%20my%20needs.">
                 <tr>
                   <td>#trim(Agency_Name)#</td>
                   <td><a href="mailto:#Sendto#?Subject=#TmpSubject#&Body=#TmpBody#">#trim(Contract_Number)#</a></td>
                   <td>#trim(Award_Description)#</td>
                   <td>#trim(Type_Description)#</td>
                   <td>#trim(Class_Description)#</td>
                   <td>#trim(Name)#</td>
                   <td>&nbsp;#trim(NameII)#</td>
                   <td>#DateFormat(From_Date,"mm/dd/yyyy")#</td>
                   <td>#DateFormat(To_Date,"mm/dd/yyyy")#</td>
                   <td>#NumberFormat(Contract_Amt,"999,999,999.99")#</td>
                   <td>#NumberFormat(Max_Contract_Amt,"999,999,999.99")#</td>
                   <td> <!--- <a href="javascript:void();" onClick="window.open('/get/Enhanced_Ledger_By_vendor/Vendor_Warrant_Listing_Dates_Amounts.cfm?Vendor_Name=#trim(UrlEncodedFormat(Name[i]))#&Agency=#URLEncodedFormat(Agency)#&Contract_Number=#contract_number#&Fiscal_Year=#Fiscal_Year#','Window1of1','width=400,height=805,0,status=0,scrollbars=1,location=no,toolbar=no').focus();">#NumberFormat(Expended_Amt[i],"999,999,999.99")#</A> ---> </td>
                 </tr>
                </cfloop>
         </table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END PAYMENT -->
	</cfoutput>