<!---
Author: Gary Ashbaugh
Date Created: 5-12-10

LOGIC: Pulls off the Auditor information
 --->

 <!---
 <cfinclude template="/AFR/AFR2013/CheckPassExpired.cfm">
 --->
 
 <!--- Pull of the unit's name --->
<CFLOCK SCOPE="Session" timeout="100">
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Check_IfFinished">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckIfFinishedRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckIfFinishedRetMsg">
	<cfprocresult name="CheckIfFinished">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>
</cfoutput>

<cfset url.PageType="AFR">
<cfset url.PageName="Audit Requirement and CPA Validation Check">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h3 class="clearfix">
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2013/SPFReport/AFRSPPgF7.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Special Purpose Form&Page=F10" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<p class="text-center marginb15"><b>Audit Requirement and CPA Validation Check</b></p>
<p>According to the Governmental Account Audit Act [50 ILCS 310], an Annual Audit submitted to the IL Office of the Comptroller shall be performed by a licensed public accountant, with a valid certificate as a public accountant under the Illinois Public Accounting Act [225 ILCS450]. Please access the website of the Illinois General Assembly (<a href="https://www.ilga.gov/legislation/ilcs/ilcs.asp">www.ilga.gov/legislation/ilcs/ilcs.asp</a>) to view these Acts</p>
<p>Is the Licensed Certified Public Accountant performing your audit working as an individual licensed in Illinois, or are they working in association with a Public Accounting Firm or a Professional Service Corporation licensed in Illinois,  or are they licensed in another state? Please use a checkmark to select <u>one</u> choice:</p>

<table class="table table-bordered">
<tr>
    <cfoutput>
        <td><cfif GetAFRRptPg1.LicenseeType is "Individual">
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/CheckedBox.jpg"  align="middle"
                                                                           alt="Individual Checked"><cfelse>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnCheckBox.jpg"  align="middle"></cfif>
            &nbsp;Individual Licensed Certified Public Accountant</td>
        <td><cfif GetAFRRptPg1.LicenseeType is "Public"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/CheckedBox.jpg"
            align="middle" alt="Public Checked"><cfelse><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnCheckBox.jpg"
            align="middle"></cfif>&nbsp;Public Accounting Firm (IL License)</td>
    <td><cfif GetAFRRptPg1.LicenseeType is "Professional"><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/CheckedBox.jpg"
            align="middle" alt="Professional Checked"><cfelse>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnCheckBox.jpg"  align="middle"></cfif>
            &nbsp;Professional Service Corporation (IL License)</td>
    </cfoutput></tr>
<tr>
    <cfoutput>
        <td colspan="3"><cfif GetAFRRptPg1.LicenseeType is "Out_Of_State">
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/CheckedBox.jpg"  align="middle"
                                                                           alt="Out-Of-State Checked"><cfelse>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnCheckBox.jpg"  align="middle"></cfif>
            &nbsp;Out-of-State (Individual / Public Accounting Firm / Professional
                Service Corporation)</td>
    </cfoutput></tr>
</table>

<cfif GetAFRRptPg1.LicenseeType is "Individual">

	<b>If you selected Individual Licensed Certified Public Accountant (IL), please complete the licensee information below:<br>
	Please provide the following information for the Licensed Certified Public Accountant performing the Annual Audit for your government.  </b>
    <div class="table-responsive">
    <table class="table table-bordered">
    <cfoutput query="GetAFRRptPg1">
        <tr>
        <td colspan="2">Enter the active 9-digit License No: #LicenseeNumber# </td>
    <td>License Status: #LicenseeStatus# </td>
    </tr>
    <tr>
    <td>Last Name: #CPA_Contact_LName# </td>
    <td>First Name: #CPA_Contact_FName#</td>
    <td>Title: #CPA_Contact_Title#</td>
    </tr>
    <tr>
    <td>Address: #CPA_Contact_Address#</td>
    <td colspan="2">Address 2: #CPA_Contact_Address2#</td>
    </tr>
    <tr>
    <td>City: #CPA_Contact_City#</td>
    <td>State: #CPA_Contact_State#</td><td>ZIP: #CPA_Contact_ZIP#</td>
    </tr>
    <tr>
    <td>Phone Number: #CPA_Contact_Phone#&nbsp;&nbsp;&nbsp;Ext: #CPA_Contact_Ext#</td>
    <td>Fax: #CPA_Contact_Fax#</td>
    <td>E-mail: #CPA_Contact_EMail#</td>
    </tr>
    </cfoutput>
    </table>
    </div>
<cfelseif GetAFRRptPg1.LicenseeType is "Public">

	<b>If you selected Public Accounting Firm (IL), please complete the licensee information below:<br>
	Please provide the following information for the Public Accounting Firm performing the Annual Audit for your government.</b>
    <div class="table-responsive">
    <table class="table table-bordered">
    <cfoutput query="GetAFRRptPg1">
        <tr>
        <td colspan="2">Enter the active 9-digit License No: #LicenseeNumber# </td>
    <td>License Status: #LicenseeStatus#</td>
    </tr>
    <tr>
    <td colspan="3">Business Name: #BusinessName# </td>
    </tr>
    <tr>
    <td>Address: #BusinessAddress#</td>
    <td colspan="2">Address 2: #BusinessAddress2#</td>
    </tr>
    <tr>
    <td>City: #BusinessCity#</td>
    <td>State: #BusinessState#</td><td>ZIP: #BusinessZIP#</td>
    </tr>
    <tr>
    <td>Phone Number: #BusinessPhone#&nbsp;&nbsp;&nbsp;Ext: #BusinessExt#</td>
    <td>Fax: #BusinessFax#</td>
    <td>E-mail: #BusinessEMail#</td>
    </tr>
    <tr>
    <td>Contact Last Name: #Contact_LName#</td>
    <td>Contact First Name: #Contact_FName#</td>
    <td>Contact Title: #Contact_Title#</td>
    </tr>
    <tr>
    <td>Contact Phone: #Contact_Phone#&nbsp;&nbsp;&nbsp;Ext: #Contact_Ext#</td>
    <td>Fax: #Contact_Fax#</td>
    <td>E-mail: #Contact_EMail#</td>
    </tr>
    </cfoutput>
    </table>
    </div>

<cfelseif GetAFRRptPg1.LicenseeType is "Professional" or trim(GetAFRRptPg1.LicenseeType) is "">

	<b>If you selected Professional Service Corporation (IL), please complete the licensee information below:<br>
	Please provide the following information for the Professional Service Corporation performing the Annual Audit for your government.</b>
    <div class="table-responsive">
    <table class="table table-bordered">
    <cfoutput query="GetAFRRptPg1">
        <tr>
        <td colspan="2">Enter the active 9-digit License No: #LicenseeNumber# </td>
    <td>License Status: #LicenseeStatus# </td>
    </tr>
    <tr>
    <td colspan="3">Business Name: #BusinessName#</td>
    </tr>
    <tr>
    <td>Address: #BusinessAddress#</td><td colspan="2">Address 2: #BusinessAddress2#</td>
    </tr>
    <tr>
    <td>City: #BusinessCity#</td>
    <td>State: #BusinessState#</td><td>ZIP: #BusinessZIP#</td>
    </tr>
    <tr>
    <td>Phone Number: #BusinessPhone#&nbsp;&nbsp;&nbsp;Ext: #BusinessExt#</td>
    <td>Fax: #BusinessFax#</td>
    <td>E-mail: #BusinessEMail#</td>
    </tr>
    </cfoutput>
    </table>
    </div>

    <b>If you selected Professional Service Corporation (IL), please complete the licensee
        information below:<br>   Please provide the following information for the Professional Service Corporation performing
        the Annual Audit for your government.</b>
    <div class="table-responsive">
    <table class="table table-bordered">
    <cfoutput query="GetAFRRptPg1">
        <tr>
        <td colspan="2">Enter the active 9-digit License No: #Prof_CPALicenseeNumber#</td>
    <td>License Status: #Prof_LicenseeStatus#</td>
    </tr>
    <tr>
    <td>Last Name: #CPA_Contact_LName#</td>
    <td>First Name: #CPA_Contact_FName#</td>
    <td>Title: #CPA_Contact_Title#</td>
    </tr>
    <tr>
    <td>Address: #CPA_Contact_Address#</td>
    <td>Address 2: #CPA_Contact_Address2#</td>
    </tr>
    <tr>
    <td>City: #CPA_Contact_City#</td>
    <td>State: #CPA_Contact_State#</td><td>ZIP: #CPA_Contact_ZIP#</td>
    </tr>
    <tr>
    <td>Phone: #CPA_Contact_Phone#&nbsp;&nbsp;&nbsp;Ext: #CPA_Contact_Ext#</td>
    <td>Fax: #CPA_Contact_Fax#</td>
    <td>E-mail: #CPA_Contact_EMail#</td>
    </tr>
    </cfoutput>
    </table>
    </div>
			
<cfelseif GetAFRRptPg1.LicenseeType is "Out_Of_State">
	<b>If you selected Out of State Individual Licensed Certified Public Accountant/ Public Accounting Firm /Professional Service Corp, please complete the licensee information below.</b>
    <div class="table-responsive">
    <table class="table table-bordered">
    <cfoutput query="GetAFRRptPg1">
        <tr>
        <td>Enter the <u>Complete</u> active License No: #GetAFRRptPg1.LicenseeNumber#</td>
        <td>State License Issued: #GetAFRRptPg1.LicenseeState#</td>
            <td>License Status: #GetAFRRptPg1.LicenseeStatus#
        </tr>
            <tr>
                <td colspan="3">License Type (Please select one. If 'Other', enter type information)</td>
            </tr>
        <tr>
        <td><cfif GetAFRRptPg1.OutOfState_LicenseeType is "Individual">
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/CheckedBox.jpg"  align="middle"
                                                                           alt="Individual Checked"><cfelse>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnCheckBox.jpg"  align="middle"></cfif>
            &nbsp;Individual Licensed Certified Public Accountant</td>
            <td><cfif GetAFRRptPg1.OutOfState_LicenseeType is "Public">
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/CheckedBox.jpg"  align="middle" alt="Public Checked"><cfelse>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnCheckBox.jpg"  align="middle" ></cfif>
            &nbsp;Public Accounting Firm</td>
            <td><cfif GetAFRRptPg1.OutOfState_LicenseeType is "Professional">
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/CheckedBox.jpg"  align="middle"
                                                                           alt="Professional Checked"><cfelse>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnCheckBox.jpg"  align="middle"></cfif>
            &nbsp;Professional Service Corporation</td>
        </tr>
        <tr>
        <td colspan="3"><cfif ((GetAFRRptPg1.OutOfState_LicenseeType is not "Individual") and (GetAFRRptPg1.OutOfState_LicenseeType is not "Public") and (GetAFRRptPg1.OutOfState_LicenseeType is not "Professional") and (trim(GetAFRRptPg1.OutOfState_LicenseeType) is not ""))>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/CheckedBox.jpg"  align="middle" alt="Other Checked"><cfelse>
            <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnCheckBox.jpg"  align="middle"></cfif>
            &nbsp;Other Business Type&nbsp;&nbsp;&nbsp;<u>#GetAFRRptPg1.OutOfState_LicenseeType#</u></td>
    </tr>
        <tr>
            <td colspan="3">Provide information for the business entity performing the audit for your government.</td>
        </tr>
    <tr>
    <td colspan="3">Business Name: #GetAFRRptPg1.BusinessName#</td>
    </tr>
    <tr>
    <td>Address: #GetAFRRptPg1.BusinessAddress#</td>
        <td colspan="2">Address 2: #GetAFRRptPg1.BusinessAddress2#</td>
    </tr>
    <tr>
    <td>City: #GetAFRRptPg1.BusinessCity#</td>
    <td>State: #GetAFRRptPg1.BusinessState#</td><td>ZIP: #GetAFRRptPg1.BusinessZIP#</td>
    </tr>
    <tr>
    <td>Phone Number: #GetAFRRptPg1.BusinessPhone#
            &nbsp;&nbsp;&nbsp;Ext: #GetAFRRptPg1.BusinessExt#</td>
        <td>Fax: #GetAFRRptPg1.BusinessFax#</td>
            <td>E-mail: #GetAFRRptPg1.BusinessEMail#</td>
    </tr>
    <tr>
    <td>Contact Last Name: #GetAFRRptPg1.Contact_LName#</td>
        <td>Contact First Name: #GetAFRRptPg1.Contact_FName#</td>
            <td>Contact Title: #GetAFRRptPg1.Contact_Title#</td>
    </tr>
    <tr>
    <td>Contact Phone: #GetAFRRptPg1.Contact_Phone#
            &nbsp;&nbsp;&nbsp;Ext: #GetAFRRptPg1.Contact_Ext#</td>
        <td>Fax: #GetAFRRptPg1.Contact_Fax#</td>
            <td>E-mail: #GetAFRRptPg1.Contact_EMail#</td>
    </tr>
        <tr>
            <td colspan="3">Provide information for the Licensed Certified Public Accountant performing the audit for
                your government.
            </td>
        </tr>
    <tr>
    <td>Enter the <u>Complete</u> active License No: #GetAFRRptPg1.Prof_CPALicenseeNumber#</td>
        <td>State License Issued: #GetAFRRptPg1.Prof_CPAState#</td>
            <td>License Status: #GetAFRRptPg1.Prof_LicenseeStatus#</td>
    </tr>
    <tr>
    <td>CPA Last Name: #GetAFRRptPg1.CPA_Contact_LName#</td>
        <td>CPA First Name: #GetAFRRptPg1.CPA_Contact_FName#</td>
        <td>CPA Title: #GetAFRRptPg1.CPA_Contact_Title#</td>
    </tr>
    <tr>
    <td>Address: #GetAFRRptPg1.CPA_Contact_Address#</td>
    <td colspan="2">Address 2: #GetAFRRptPg1.CPA_Contact_Address2#</td>
    </tr>
    <tr>
    <td>City: #GetAFRRptPg1.CPA_Contact_City#</td>
    <td>State: #GetAFRRptPg1.CPA_Contact_State#</td><td>ZIP: #GetAFRRptPg1.CPA_Contact_ZIP#</td>
    </tr>
    <tr>
    <td>Phone: #GetAFRRptPg1.CPA_Contact_Phone#
            &nbsp;&nbsp;&nbsp;Ext: #GetAFRRptPg1.CPA_Contact_Ext#</td>
        <td>Fax: #GetAFRRptPg1.CPA_Contact_Fax#</td>
            <td>E-mail: #GetAFRRptPg1.CPA_Contact_EMail#</td>
    </tr>
    </cfoutput>
    </table>
    </div>
</cfif>	

<!---<br><p align="right"><font size="-1">F7&nbsp;</right>
		<br><center>
<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
Special Purpose Form&nbsp;</center><br><br>--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "SP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
    <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Special Purpose Form - F10</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
