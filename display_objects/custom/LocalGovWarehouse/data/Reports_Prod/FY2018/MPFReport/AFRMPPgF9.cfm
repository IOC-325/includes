<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 5-12-10

LOGIC: Pulls off the Auditor information
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
<cfStoredProc  datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>
</cfoutput>
  
<!---<html>
<head>
	<title>Audit Requirement and CPA Validation Check</title>
</head>

<body>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Audit Requirement and CPA Validation Check">
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h3>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2017/MPFReport/AFRMPPgF9.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F12" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>

<p><center>Audit Requirement and CPA Validation Check</center></p>
<p>According to the Governmental Account Audit Act [50 ILCS 310], an Annual Audit submitted to the IL Office of the Comptroller shall be performed by a licensed public accountant, with a valid certificate as a public accountant under the Illinois Public Accounting Act [225 ILCS450]. Please access the website of the Illinois General Assembly (<a href="http://www.ilga.gov/legislation/ilcs/ilcs.asp">www.ilga.gov/legislation/ilcs/ilcs.asp</a>) to view these Acts</p>
<p>Is the Licensed Certified Public Accountant performing your audit working as an individual licensed in Illinois, or are they working in association with a Public Accounting Firm or a Professional Service Corporation licensed in Illinois,  or are they licensed in another state? Please use a checkmark to select <u>one</u> choice:

<table cellspacing="2" cellpadding="2" border="1" frame="box"rules="groups" width="100%">
<tr><cfoutput>
<td><cfif GetAFRRptPg1.LicenseeType is "Individual"><img src="#application.LocGovWarehouse#images/CheckedBox.jpg"  align="middle" alt="Individual Checked"><cfelse><img src="#application.LocGovWarehouse#images/UnCheckBox.jpg"  align="middle"></cfif><font face="Verdana" size="-1">&nbsp;Individual Licensed Certified Public Accountant</font></td><td width="2%">&nbsp;</td><td><cfif GetAFRRptPg1.LicenseeType is "Public"><img src="#application.LocGovWarehouse#images/CheckedBox.jpg"  align="middle" alt="Public Checked"><cfelse><img src="#application.LocGovWarehouse#images/UnCheckBox.jpg"  align="middle"></cfif><font face="Verdana" size="-1">&nbsp;Public Accounting Firm (IL License)</font></td><td width="2%">&nbsp;</td><td><cfif GetAFRRptPg1.LicenseeType is "Professional"><img src="#application.LocGovWarehouse#images/CheckedBox.jpg"  align="middle" alt="Professional Checked"><cfelse><img src="#application.LocGovWarehouse#images/UnCheckBox.jpg"  align="middle"></cfif><font face="Verdana" size="-1">&nbsp;Professional Service Corporation (IL License)</font></td>
</cfoutput></tr>
<tr>
<td colspan="5"><cfoutput><cfif GetAFRRptPg1.LicenseeType is "Out_Of_State"><img src="#application.LocGovWarehouse#images/CheckedBox.jpg"  align="middle" alt="Out-Of-State Checked"><cfelse><img src="#application.LocGovWarehouse#images/UnCheckBox.jpg"  align="middle"></cfif><font face="Verdana" size="-1">&nbsp;Out-of-State (Individual / Public Accounting Firm / Professional Service Corporation)</font></cfoutput></td>
</tr>
</table>
<br>
<cfif GetAFRRptPg1.LicenseeType is "Individual">

	<b>If you selected Individual Licensed Certified Public Accountant (IL), please complete the licensee information below:<br>
	Please provide the following information for the Licensed Certified Public Accountant performing the Annual Audit for your government.  </b>
	<table cellspacing="2" cellpadding="2" border="1" frame="box"rules="groups" width="100%">
	<cfoutput query="GetAFRRptPg1">
	<tr>
	<td colspan="3">Enter the active 9-digit License No: #LicenseeNumber# </td><td>&nbsp;</td><td>License Status: #LicenseeStatus# </td>
	</tr>
	<tr>
	<td >Last Name: #CPA_Contact_LName# </td><td>&nbsp;</td><td>First Name: #CPA_Contact_FName#</td><td>&nbsp;</td><td>Title: #CPA_Contact_Title#</td>
	</tr>
	<tr>
	<td >Address: #CPA_Contact_Address#</td><td>&nbsp;</td><td>Address 2: #CPA_Contact_Address2#</td>
	</tr>
	<tr>
	<td >City: #CPA_Contact_City#</td><td>&nbsp;</td><td>State: #CPA_Contact_State#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ZIP: #CPA_Contact_ZIP#</td>
	</tr>
	<tr>
	<td >Phone Number: #CPA_Contact_Phone#&nbsp;&nbsp;&nbsp;Ext: #CPA_Contact_Ext#</td><td>&nbsp;</td><td>Fax: #CPA_Contact_Fax#</td><td>&nbsp;</td><td>E-mail: #CPA_Contact_EMail#</td>
	</tr>
	</cfoutput>
	</table>
<cfelseif GetAFRRptPg1.LicenseeType is "Public">

	<b>If you selected Public Accounting Firm (IL), please complete the licensee information below:<br>
	Please provide the following information for the Public Accounting Firm performing the Annual Audit for your government.</b>
	<table cellspacing="2" cellpadding="2" border="1" frame="box"rules="groups" width="100%">
	<cfoutput query="GetAFRRptPg1">
	<tr>
	<td colspan="3">Enter the active 9-digit License No: #LicenseeNumber# </td><td>&nbsp;</td><td>License Status: #LicenseeStatus#</td>
	</tr>
	<tr>
	<td colspan="5">Business Name: #BusinessName# </td>
	</tr>
	<tr>
	<td colspan="5">Address: #BusinessAddress#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Address 2: #BusinessAddress2#</td>
	</tr>
	<tr>
	<td >City: #BusinessCity#</td><td>&nbsp;</td><td>State: #BusinessState#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ZIP: #BusinessZIP#</td>
	</tr>
	<tr>
	<td >Phone Number: #BusinessPhone#&nbsp;&nbsp;&nbsp;Ext: #BusinessExt#</td><td>&nbsp;</td><td>Fax: #BusinessFax#</td><td>&nbsp;</td><td>E-mail: #BusinessEMail#</td>
	</tr>
	<tr>
	<td >Contact Last Name: #Contact_LName#</td><td>&nbsp;</td><td>Contact First Name: #Contact_FName#</td><td>&nbsp;</td><td>Contact Title: #Contact_Title#</td>
	</tr>
	<tr>
	<td >Contact Phone: #Contact_Phone#&nbsp;&nbsp;&nbsp;Ext: #Contact_Ext#</td><td>&nbsp;</td><td>Fax: #Contact_Fax#</td><td>&nbsp;</td><td>E-mail: #Contact_EMail#</td>
	</tr>
	</cfoutput>
	</table>

<cfelseif GetAFRRptPg1.LicenseeType is "Professional" or trim(GetAFRRptPg1.LicenseeType) is "">

	<b>If you selected Professional Service Corporation (IL), please complete the licensee information below:<br>
	Please provide the following information for the Professional Service Corporation performing the Annual Audit for your govenrment.</b>
	<table cellspacing="2" cellpadding="2" border="1" frame="box"rules="groups"  width="100%">
	<cfoutput query="GetAFRRptPg1">
	<tr>
	<td colspan="3">Enter the active 9-digit License No: #LicenseeNumber# </td><td>&nbsp;</td><td>License Status: #LicenseeStatus# </td>
	</tr>
	<tr>
	<td colspan="5">Business Name: #BusinessName#</td>
	</tr>
	<tr>
	<td colspan="5">Address: #BusinessAddress#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Address 2: #BusinessAddress2#</td>
	</tr>
	<tr>
	<td >City: #BusinessCity#</td><td>&nbsp;</td><td>State: #BusinessState#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ZIP: #BusinessZIP#</td>
	</tr>
	<tr>
	<td >Phone Number: #BusinessPhone#&nbsp;&nbsp;&nbsp;Ext: #BusinessExt#</td><td>&nbsp;</td><td>Fax: #BusinessFax#</td><td>&nbsp;</td><td>E-mail: #BusinessEMail#</td>
	</tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5"><b>If you selected Professional Service Corporation (IL), please complete the licensee information below:</td></tr>
	<tr><td colspan="5">Please provide the following information for the Professional Service Corporation performing the Annual Audit for your govenrment.</b></td></tr>
	<tr>
	<td colspan="3">Enter the active 9-digit License No: #Prof_CPALicenseeNumber#</td><td>&nbsp;</td><td>License Status: #Prof_LicenseeStatus#</td>
	</tr>
	<tr>
	<td>Last Name: #CPA_Contact_LName#</td><td>&nbsp;</td><td>First Name: #CPA_Contact_FName#</td><td>&nbsp;</td><td>Title: #CPA_Contact_Title#</td>
	</tr>
	<tr>
	<td>Address: #CPA_Contact_Address#</td><td>&nbsp;</td><td>Address 2: #CPA_Contact_Address2#</td>
	</tr>
	<tr>
	<td >City: #CPA_Contact_City#</td><td>&nbsp;</td><td>State: #CPA_Contact_State#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ZIP: #CPA_Contact_ZIP#</td>
	</tr>
	<tr>
	<td >Phone: #CPA_Contact_Phone#&nbsp;&nbsp;&nbsp;Ext: #CPA_Contact_Ext#</td><td>&nbsp;</td><td>Fax: #CPA_Contact_Fax#</td><td>&nbsp;</td><td>E-mail: #CPA_Contact_EMail#</td>
	</tr>
	</cfoutput>
	</table>
			
<cfelseif GetAFRRptPg1.LicenseeType is "Out_Of_State">
	<b>If you selected Out of State Individual Licensed Certified Public Accountant/ Public Accounting Firm /Professional Service Corp, please complete the licensee information below.</b>
	<table  cellspacing="2" cellpadding="2" border="1" frame="box"rules="groups"  width="100%">
	<cfoutput query="GetAFRRptPg1">
	<tr>
	<td colspan="5">Enter the <u>Complete</u> active License No: #GetAFRRptPg1.LicenseeNumber#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;State License Issued: #GetAFRRptPg1.LicenseeState#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;License Status: #GetAFRRptPg1.LicenseeStatus#
	</tr>
	<tr>
	<td colspan="5">License Type (Please select one.  If 'Other', enter type information)</td>
	</tr>
	<tr>
	<td colspan="5"><cfif GetAFRRptPg1.OutOfState_LicenseeType is "Individual"><img src="#application.LocGovWarehouse#images/CheckedBox.jpg"  align="middle" alt="Individual Checked"><cfelse><img src="#application.LocGovWarehouse#images/UnCheckBox.jpg"  align="middle"></cfif><font face="Verdana" size="-1">&nbsp;Individual Licensed Certified Public Accountant</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfif GetAFRRptPg1.OutOfState_LicenseeType is "Public"><img src="#application.LocGovWarehouse#images/CheckedBox.jpg"  align="middle" alt="Public Checked"><cfelse><img src="#application.LocGovWarehouse#images/UnCheckBox.jpg"  align="middle" ></cfif><font face="Verdana" size="-1">&nbsp;Public Accounting Firm</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfif GetAFRRptPg1.OutOfState_LicenseeType is "Professional"><img src="#application.LocGovWarehouse#images/CheckedBox.jpg"  align="middle" alt="Professional Checked"><cfelse><img src="#application.LocGovWarehouse#images/UnCheckBox.jpg"  align="middle"></cfif><font face="Verdana" size="-1">&nbsp;Professional Service Corporation</font></td>
	</tr>
	<tr>
	<td colspan="5"><cfif ((GetAFRRptPg1.OutOfState_LicenseeType is not "Individual") and (GetAFRRptPg1.OutOfState_LicenseeType is not "Public") and (GetAFRRptPg1.OutOfState_LicenseeType is not "Professional") and (trim(GetAFRRptPg1.OutOfState_LicenseeType) is not ""))><img src="#application.LocGovWarehouse#images/CheckedBox.jpg"  align="middle" alt="Other Checked"><cfelse><img src="#application.LocGovWarehouse#images/UnCheckBox.jpg"  align="middle"></cfif><font face="Verdana" size="-1">&nbsp;Other Business Type&nbsp;&nbsp;&nbsp;<u>#GetAFRRptPg1.OutOfState_LicenseeType#</u></font></td>
	</tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr>
	<td colspan="5">Provide information for the business entity performing the audit for your government.</td>
	</tr>
	<tr>
	<td colspan="5">Business Name: #GetAFRRptPg1.BusinessName#</td>
	</tr>
	<tr>
	<td colspan="5">Address: #GetAFRRptPg1.BusinessAddress#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Address 2: #GetAFRRptPg1.BusinessAddress2#</td>
	</tr>
	<tr>
	<td >City: #GetAFRRptPg1.BusinessCity#</td><td>&nbsp;</td><td>State: #GetAFRRptPg1.BusinessState#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ZIP: #GetAFRRptPg1.BusinessZIP#</td>
	</tr>
	<tr>
	<td colspan="5">Phone Number: #GetAFRRptPg1.BusinessPhone#&nbsp;&nbsp;&nbsp;Ext: #GetAFRRptPg1.BusinessExt#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax: #GetAFRRptPg1.BusinessFax#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-mail: #GetAFRRptPg1.BusinessEMail#</td>
	</tr>
	<tr>
	<td colspan="5">Contact Last Name: #GetAFRRptPg1.Contact_LName#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Contact First Name: #GetAFRRptPg1.Contact_FName#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Contact Title: #GetAFRRptPg1.Contact_Title#</td>
	</tr>
	<tr>
	<td colspan="5">Contact Phone: #GetAFRRptPg1.Contact_Phone#&nbsp;&nbsp;&nbsp;Ext: #GetAFRRptPg1.Contact_Ext#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax: #GetAFRRptPg1.Contact_Fax#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-mail: #GetAFRRptPg1.Contact_EMail#</td>
	</tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr>
	<td colspan="5">Provide information for the Licensed Certified Public Accountant performing the audit for your government.</td>
	</tr>
	<tr>
	<td colspan="5">Enter the <u>Complete</u> active License No: #GetAFRRptPg1.Prof_CPALicenseeNumber#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;State License Issued: #GetAFRRptPg1.Prof_CPAState#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;License Status: #GetAFRRptPg1.Prof_LicenseeStatus#</td>
	</tr>
	<tr>
	<td colspan="5">CPA Last Name: #GetAFRRptPg1.CPA_Contact_LName#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPA First Name: #GetAFRRptPg1.CPA_Contact_FName#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPA Title: #GetAFRRptPg1.CPA_Contact_Title#</td>
	</tr>
	<tr>
	<td width="40%">Address: #GetAFRRptPg1.CPA_Contact_Address#</td><td>&nbsp;</td><td width="40%">Address 2: #GetAFRRptPg1.CPA_Contact_Address2#</td>
	</tr>
	<tr>
	<td >City: #GetAFRRptPg1.CPA_Contact_City#</td><td>&nbsp;</td><td>State: #GetAFRRptPg1.CPA_Contact_State#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ZIP: #GetAFRRptPg1.CPA_Contact_ZIP#</td>
	</tr>
	<tr>
	<td colspan="5">Phone: #GetAFRRptPg1.CPA_Contact_Phone#&nbsp;&nbsp;&nbsp;Ext: #GetAFRRptPg1.CPA_Contact_Ext#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax: #GetAFRRptPg1.CPA_Contact_Fax#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-mail: #GetAFRRptPg1.CPA_Contact_EMail#</td>
	</tr>
	</cfoutput>
	</table>
</cfif>	
<br>
<!---<br><p align="right"><font size="-1">F9&nbsp;</font></right>
		<br><center>
<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput> AFR<br>
Multi-Purpose Form&nbsp;</font></center><br><br>--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "MP">
    	<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
     <cfif url.PrintIt is "No">
    	<cfoutput>
        <div align="center">
        <table bgcolor="white" cellspacing="0" cellpadding="2" border="0" bordercolor="black" width="90%">
        <tr><Td width="30%">&nbsp;</Td>
        <td width="5%">&nbsp;</td>
        <td width="30%"><center>#url.AFRDesiredData#</center></td>
        <td width="5%">&nbsp;</td>
        <td width="20%">#url.CFY# Multi-Purpose Form - F12</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
