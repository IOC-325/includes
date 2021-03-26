<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->

<!--- 
Author: Gary Ashbaugh
Date Created: 6-19-12



LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Page 1 - Contact Information

 --->
 
 
 

 
 <!--- Pull of the unit's name --->
 <CFLOCK SCOPE="Session" timeout="100">
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
	<title>AFR - Page 1</title>
</head>

<body <!---ONLOAD="javascript: makeRemoteAFR()"--->>--->
<cfset url.PageType="AFR">
<cfset url.PageName="Contact Information">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm"><br />
<h3>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2019/RegOnlyReport/RegOnlyPg1.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Registration Form&Page=1" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h3>
<font size="-1">Please be sure to fill out this section accurately.  The information you provide below is (1) our primary way of contacting your government, (2) the information we supply to external agencies, and (3) is the name and title we will list on our website.  This section should NOT contain ANY of your Accounting Professional's information</font>
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span> <font size="-1" color="black">STEP 1:  ENTER CONTACT INFORMATION</font></h5>
<br>
<font size="-1">Is the following information correct and complete?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;______ Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;______ No</font><BR>
<br>
<table bgcolor="white" cellspacing="0" cellpadding="2" border="1"  bordercolor="black" width="100%">
<cfoutput query="GetAFRRptPg1">
<tr><td colspan="2" valign="top" align="top" width="25%"><font size="-1">A. <b>Contact Person</b> (elected or appointed official responsible for filling out this form)</font></td><td colspan="2" valign="top"  align="top" width="25%"><font size="-1">B. <b>Chief Executive Officer</b> (Enter your name here ONLY if you are the elected or appointed official <u>responsible</u> for the EXECUTIVE ADMINISTRATION, i.e. mayor, supervisor, or chairman.  Your name will be listed with this responsibility on our website.)</font></td><td colspan="2" valign="top"  align="top" width="25%"><font size="-1">C. <b>Chief Financial Officer</b> (Enter your name here ONLY if you are the elected or appointed official <u>responsible</u> for MAINTAINING THE GOVERNMENT'S FINANCIAL RECORDS.  Your name will be listed with this responsibility on our website.)</font></td><td colspan="2" valign="top"  align="top" width="25%"><font size="-1">D. <b>Purchasing Agent</b> (Enter the Purchasing Agent or if there is no Purchasing Agent, the name of the person responsible for oversight of all competitively bid contracts should be listed)</font></td></tr>
<tr><td><font size="-1">#FirstName#&nbsp;</font></td><td><font size="-1">#LastName#&nbsp;</font></td><td><font size="-1">#CEOFName#&nbsp;</font></td><td><font size="-1">#CEOLName#&nbsp;</font></td><td><font size="-1">#CFOFName#&nbsp;</font></td><td><font size="-1">#CFOLName#&nbsp;</font></td><td><font size="-1">#PAFName#&nbsp;</font></td><td><font size="-1">#PALName#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">#Title#&nbsp;</font></td><td colspan="2"><font size="-1">#CEOTitle#&nbsp;</font></td><td colspan="2"><font size="-1">#CFOTitle#&nbsp;</font></td><td colspan="2"><font size="-1">#PATitle#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">#Address#&nbsp;</font></td><td colspan="2"><font size="-1">#CEOAddr#&nbsp;</font></td><td colspan="2"><font size="-1">#CFOAddr#&nbsp;</font></td><td colspan="2"><font size="-1">#PAAddr#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">#City#&nbsp;</font></td><td colspan="2"><font size="-1">#CEOCity#&nbsp;</font></td><td colspan="2"><font size="-1">#CFOCity#&nbsp;</font></td><td colspan="2"><font size="-1">#PACity#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">#State#&nbsp;&nbsp;&nbsp;<font size="-1">#Zip#&nbsp;</font></td><td colspan="2"><font size="-1">#CEOState#&nbsp;</font>&nbsp;&nbsp;<font size="-1">#CEOZip#&nbsp;</font></td><td colspan="2"><font size="-1">#CFOState#&nbsp;</font>&nbsp;&nbsp;<font size="-1">#CFOZip#&nbsp;</font></td><td colspan="2"><font size="-1">#PAState#&nbsp;</font>&nbsp;&nbsp;<font size="-1">#PAZIP#&nbsp;</font></td></tr>
<tr><td colspan="2"><font size="-1">Phone: #Phone#&nbsp;&nbsp;&nbsp;<cfif ext is not "">Ext: #Ext#</cfif></font></td><td colspan="2"><font size="-1">Phone: #CEOPhone#&nbsp;&nbsp;&nbsp;<cfif CEOext is not "">Ext: #CEOExt#</cfif></font></td><td colspan="2"><font size="-1">Phone: #CFOPhone#&nbsp;&nbsp;&nbsp;<cfif CFOext is not "">Ext: #CFOExt#</cfif></font></td><td colspan="2"><font size="-1">Phone: #PAPhone#&nbsp;&nbsp;&nbsp;<cfif PAext is not "">Ext: #PAExt#</cfif></font></td></tr>
<tr><td colspan="2"><font size="-1">Fax: #Fax#</font></td><td colspan="2"><font size="-1">Fax: #CEOFax#</font></td><td colspan="2"><font size="-1">Fax: #CFOFax#</font></td><td colspan="2"><font size="-1">Fax: #PAFax#</font></td></tr>
<tr><td colspan="2"><font size="-1">E-mail: #Email_Gov#</font></td><td colspan="2"><font size="-1">E-mail: #CEOEmail#</font></td><td colspan="2"><font size="-1">E-mail: #CFOEmail#</font></td><td colspan="2"><font size="-1">E-mail: #PAEmail#</font></td></tr>
</table>
<br>
<table <!---bgcolor="white" cellspacing="0" cellpadding="2" border="0" width="100%"--->>
<tr><td width="30"><cfif ((CEOFName is CFOFName) and (CEOLName is CFOLName) and (CEOFName is not "" and CEOLName is not ""))><img src="#application.LocGovWarehouse#images/Checked.jpg" width=24 height=24 border=0 alt=""><cfelse><img src="#application.LocGovWarehouse#images/UnChecked.jpg" width=24 height=24 border=0 alt=""></cfif></td><td colspan="6"><font size="-1">If the Chief Executive Officer and the Chief Financial Officer are the same person as the Contact Person, please check this box and skip to Step 2.  If not, please <u>do not</u> leave columns B and C blank.</font></td></tr>
</cfoutput>
</table>
<br>
<!---
<center><font size="-1">2<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
Registration Form</font></center><br>
	<p><cfoutput><a href="RegOnlyPg2.cfm?Code=#url.Code#&CFY=#url.CFY#"></cfoutput><img src="/images/orangebullet.gif" width=16 height=16 border=0 alt="" align="Center"><b>Proceed to Steps 2 - 3</p></b></a>
	--->
	<p><font color="red" size="-2"><b>*The contact person listed on the AFRs is for the current Fiscal Year.  Previous fiscal years may have a different contact person.  Please contact the Local Government Division at 877-304-3899 if you need the contact person for previous years.</b></font><br>
	<br><p><font color="red" size="-2"><b>*The Annual Financial Reports downloaded from this site may vary from the original report.  Total on the downloaded form reflect the total of all sub accounts.  Other changes may include the reported method of accounting.</b></font>
	 <br><br>
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "RegOnly">
    	<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>

<!---</body>
</html>--->
</cflock>
