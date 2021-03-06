<!---
Modified Date: 4-27-12
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Enhanced Vendor Remittance Site per SR11108 based on the regular site but requiring a UserID/Password
--->


<!---
<cfif not isdefined("VendTIN")>
	<CFLOCATION URL="/QuickTake/Vend/">
</cfif>
--->

<!--- Remove when application.cfc gets fixed --->
<cfinclude template="TmpVendorapplicationSettings.cfm">
<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<cfparam name="Session.Deduction" default="">
<!---<cfinclude template="TmpVendorapplicationSettings.cfm">--->

<cfif not isdefined("Session.VendTIN")>
	<!--- Calls index from VendorEnhanced --->
    <!--- Development & Production --->
    <cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>

<!---<cftry>--->
<cfStoredProc  datasource="#application.VendorPayments#" Procedure="Get_ListofAllUserVendors">
    <cfprocparam type="In"  cfsqltype="CF_SQL_varchar"  dbvarname="@EMail" value="#trim(Session.EMail)#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="ValidateUserRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="ValidateUserRetMsg">
    <cfprocresult name="GetListofUserVendors">
</cfstoredproc>
<!---<cfcatch type="any">
    <p class="text-danger" align="left"><b>Sorry, but it appears that the site is not available at this time...please try back later!</b></p><cfabort>
</cfcatch>
</cftry>--->
<cfset ShowCommercial="No">
<!-- Return to Vendor Login screen -->
<div name="FormWrapper" id="FormWrapper">
<cfif GetListofUserVendors.recordcount gt 1>
	<cfif $.content().getURL() is not '/vendors/enhanced-vendor-remittance/change-password'>
        <cfform role="form" name="VendorRemit" action="/vendors/enhanced-vendor-remittance/vendor-summary/"  method="post">
        <input type="Hidden" name="valuser" value="true" />
        <div class="row">
            <div class="col-xs-12 col-sm-4 col-md-3 label-div">
             <div class="btn-label-grey btn-label label-gray"><label for="Vendor" id="SelectVendorlbl">Select Vendor</label></div>
            </div>
            <div class="col-xs-12 col-sm-5 col-md-7 default-select">
            <select name="VendorSelected" class="form-control" id="VendorSelect">
                <option value="">&nbsp;</option>
                <cfoutput query="GetListofUserVendors">
                    <cfif GetListofUserVendors.Status is "A" and GetListofUserVendors.Number_Code is not "4">
                        <cfif Session.VendTIN is "">
                            <cfset ShowCommercial="Yes">
                        </cfif>
                        <CFQUERY NAME="GetVendorNm" DATASOURCE="VendorDB2">
                            SELECT 	Vendor_TIN,
                                    VENDOR_NAME
                            FROM #application.whOwner#VENDOR
                           <CFLOCK SCOPE="Session" timeout="120" type="readonly">	 where VENDOR_TIN =<cfqueryparam cfsqltype="cf_sql_char" value="#GetListofUserVendors.TaxpayerIdNo2#"></CFLOCK>
                        </CFQUERY>
                            <option value="#TaxpayerIdNo2#X" <cfif trim(TaxpayerIdNo2) is decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)>selected</cfif>>******#right(GetListofUserVendors.TaxpayerIdNo2,3)# <cfif GetVendorNm.recordcount>- #GetVendorNm.VENDOR_NAME#</cfif> - Commercial</option>
                     </cfif>
               </cfoutput>
               <cfoutput query="GetListofUserVendors">
                    <cfif GetListofUserVendors.Status is "A" and GetListofUserVendors.Number_Code is "4">
<!---                        	<cfset TmpVendorTIN = "#GetListofUserVendors.TaxpayerIdNo#">--->
                        <option value="#TaxpayerIdNo2##Number_Code#" <cfif GetListofUserVendors.TaxpayerIdNo2 is decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)>selected</cfif>>#left(GetListofUserVendors.TaxpayerIdNo2,5)# - Deduction</option>
                    </cfif>
                </cfoutput>
            </select>
            </div>
            <div class="col-xs-12 col-sm-3 col-md-2 text-center">
            <button name="SelectVendor" id="SelectVendorbtn" VALUE="Select"  class="btn btn-success nomargin" tabindex="60">Search</button>
            </div>
         </div>
        </cfform>
      </cfif>
</cfif>

<cfparam name="Session.Deduction" default="N">

<!--- Deduction --->
<cfif (ShowCommercial is "No" and Session.VendTIN is "") or (Session.Number_Code is "4")>

   		<Cfset GetVendor.SAMS_Delete_Date="">
        <cfset GetVendor.Cert_Ind="">
       <!--- <div class="form-group">
   			<div id="VendorName" class="col-sm-12"><cfoutput><center>#Decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#</center></CFOUTPUT></div>
        </div>--->
        <div class="text-center margintop">
   	 	<div id="VendorName"><cfoutput><p class="bold">Deduction: #left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),5)#</p></CFOUTPUT></div>
    	</div>
    	<!--- Deductions --->
    	<cfif $.content().getURL() is not "/vendors/enhanced-vendor-remittance/change-password"> <!---  "4894CC52-1CC1-DE6E-2F260FBBFE8E9A3B" --->
            <ul class="vendormenu">
            <li>
            <cfoutput>
            <!--- Calls VendSumm from VendorEnhanced --->
            <a HREF="/vendors/enhanced-vendor-remittance/vendor-deduction-form/" id="Deductions"><img style="width: 110px;" src="/iwgraph/Deductions.png">Deductions</a></cfoutput></li>
            <!--- Calls ChangePassword from VendorEnhanced --->
            <li><cfoutput> <a HREF="/vendors/enhanced-vendor-remittance/change-password/?Mode=Summ&ValUser=True" id="ChangePassword"><img style="width: 110px;" src="/iwgraph/ChangePassword.png">Change Password</a></cfoutput></li>
            <li><cfoutput>
            <cfif Session.AdmLevel is "Coordinator">
                <!--- Calls ChangePassword from VendorEnhanced --->
             <a HREF="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?Mode=Summ&ValUser=True" id="ManageUsers"><img style="width: 110px;" src="/iwgraph/ManageUsers.png">Manage Users</a>
            </cfif></cfoutput></li>
            <!--- Log off --->
            <li><cfoutput><a href="/vendors/enhanced-vendor-remittance/log-off/" id="Logoff"><img style="width: 110px;" src="/iwgraph/Logout.png">Log Off</a></cfoutput></li>
            </ul>
   		</cfif>

<cfelse>

    <!---<cftry>	--->
	<CFQUERY NAME="GetVendor"  DATASOURCE="VendorDB2">
		SELECT 	VENDOR_TIN,
				VENDOR_NAME, SAMS_Delete_Date, Cert_Ind
		FROM #application.whOwner#VENDOR
	 <CFLOCK SCOPE="Session" timeout="120" type="readonly">	 where VENDOR_TIN =<cfqueryparam cfsqltype="cf_sql_char" value="#decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode)#"></CFLOCK>
	</CFQUERY>

<!---	 <cfcatch type="any">
	   <p class="text-danger" align="left"><b>Sorry, but it appears that the site is not available at this time...please try back later!</b></p><cfabort>
	 </cfcatch>
	 </cftry>--->
	<cfif isdefined("GetListofUserVendors") and GetListofUserVendors.recordcount eq 1>
	<div class="text-center margintop">
   	 <div id="VendorName"><CFOUTPUT QUERY="GetVendor" MAXROWS="1"><p>#Vendor_Name#</p></CFOUTPUT></div>
    </div>
    </cfif>
    <!--- Development & Production --->
    <cfif $.content().getURL() is not "/vendors/enhanced-vendor-remittance/change-password">  <!--- "4894CC52-1CC1-DE6E-2F260FBBFE8E9A3B" --->
            <ul class="vendormenu">
            <li>
            <cfoutput>
            <!--- Calls VendSumm from VendorEnhanced --->
            <a href="/vendors/enhanced-vendor-remittance/vendor-summary/?Mode=Summ&ValUser=True" id="Summary"><img style="width: 110px;" src="/iwgraph/VendorSummary.png">Summary</a></cfoutput></li>
        <li><cfoutput>
            <!--- Calls VendContForm from VendorEnhanced --->
            <a href="/vendors/enhanced-vendor-remittance/vendor-contract-form/?Mode=Summ&ValUser=True" id="Contracts"><img style="width: 110px;" src="/iwgraph/ContractDetails.png">Contracts</a>
        </cfoutput></li>
        <li><cfoutput>
            <!--- Calls VendWarrForm from VendorEnhanced --->
            <a href="/vendors/enhanced-vendor-remittance/vendor-warrant-form/?Mode=Summ&ValUser=True" id="Payments"><img style="width: 110px;" src="/iwgraph/PaymentSearch.png">Payments</a></cfoutput></li>
            <li><cfoutput>
            <!--- Calls Pending Paymenmts from VendorEnhanced --->
            <a href="/vendors/enhanced-vendor-remittance/pending-payments/?Mode=Summ&ValUser=True" id="PendingPayments"><img style="width: 110px;" src="/iwgraph/FuturePayments.png">Pending Payments</a></cfoutput></li>
            <li><cfoutput>
            <!--- Calls ChangePassword from VendorEnhanced --->
            <a href="/vendors/enhanced-vendor-remittance/change-password/?Mode=Summ&ValUser=True" id="ChangePassword"><img style="width: 110px;" src="/iwgraph/ChangePassword.png">Change Password</a></cfoutput></li>
            <li><cfoutput>
            <cfif Session.AdmLevel is "Coordinator">
            <!--- Calls ChangePassword from VendorEnhanced --->
            <a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?Mode=Summ&ValUser=True" id="ManageUsers"><img style="width: 110px;" src="/iwgraph/ManageUsers.png">Manage Users</a>
            </cfif>
        </cfoutput></li>
                <li><cfoutput>
            <!--- Get the User Manual --->
            <a href="/comptroller/assets/file/vendors/EnhancedVendorInstructions.pdf" target="_new" id="UserGuide2"><img style="width: 110px;" src="/iwgraph/UserGuide.png">User Guide</a>
            <!---<a href="/vendors/enhanced-vendor-remittance/instructions/" target="_new" id="UserGuide2"><img style="width: 110px;" src="/iwgraph/UserGuide.png">User Guide</a>--->
        </cfoutput></li>
            <li><cfoutput>
            <!--- Log off --->
            <a href="/vendors/enhanced-vendor-remittance/log-off/" id="Logoff"><img style="width: 110px;" src="/iwgraph/Logout.png">Log Off</a>
        </cfoutput></li>

        </ul>
    </cfif>

</cfif>
</div>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>


<script>
	$('#VendorSelect').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Select a Commercial Vendor or Deduction from the list which to view its' corresponding information."
	});
	$('#SelectVendorbtn').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here when you have selected the Commercial Vendor or Deduction that you wish to view."
	});
	$('#Summary').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to view the summary page which shows summary information regarding your Vendor's Contract/Payment Information."
	});
	$('#Contracts').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the Vendor Contract form where you can set a filter to limit the contract information displayed."
	});
	$('#Payments').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the Vendor Payment form where you can set a filter to limit the payment Information displayed."
	});
    $('#PendingPayments').tooltip({
        'show': false,
            'placement': 'top',
            'title': "Click here to go to the Vendor Pending Payments Information displayed."
    });    
    
	$('#ChangePassword').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to change your password and Security Question/Answer."
	});
	$('#ManageUsers').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to manage who has access to the selected Vendor or Deduction."
	});
	$('#UserGuide').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to view the Help Guide."
	});
	$('#HelpVideos').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to view one of the Help Videos."
	});
	$('#Logoff').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to Logout of the application."
	});
	$('#Deductions').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the Vendor Deduction form where you can set a filter to limit the deduction information displayed."
	});
</script>
<!---
<HR>
--->