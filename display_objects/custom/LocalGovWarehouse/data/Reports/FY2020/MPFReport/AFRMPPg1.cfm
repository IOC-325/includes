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

<cfset url.PageType="AFR">
<cfset url.PageName="Contact Information">
     <div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
     </div>
<h5 class="clearfix">
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2020/MPFReport/AFRMPPg1.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=1" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>
Please be sure to fill out this section accurately.  The information you provide below is (1) our primary way of contacting your government, (2) the information we supply to external agencies, and (3) is the name and title we will list on our website.  This section should NOT contain ANY of your Accounting Professional's information
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 1:  ENTER CONTACT INFORMATION</h5>

Is the following information correct and complete?______ Yes ______ No<BR>
<br>
<div class="table-responsive-new">
<table class="table table-bordered">
     <cfoutput query="GetAFRRptPg1">
     <tr>
         <td colspan="2" valign="top" align="top">A. <b>Contact Person</b> (elected or appointed
             official responsible for filling out this form)
         </td>
         <td colspan="2" valign="top" align="top">B. <b>Chief Executive Officer</b> (Enter your name
             here ONLY if you are the elected or appointed official <u>responsible</u> for the EXECUTIVE
             ADMINISTRATION, i.e. mayor, supervisor, or chairman. Your name will be listed with this
             responsibility on our website.)
         </td>
         <td colspan="2" valign="top" align="top">C. <b>Chief Financial Officer</b> (Enter your name
             here ONLY if you are the elected or appointed official <u>responsible</u> for MAINTAINING THE
             GOVERNMENT'S FINANCIAL RECORDS. Your name will be listed with this responsibility on our website.)
         </td>
         <td colspan="2" valign="top" align="top">D. <b>Purchasing Agent</b> (Enter the Purchasing
             Agent or if there is no Purchasing Agent, the name of the person responsible for oversight of all
             competitively bid contracts should be listed)
         </td>
     </tr>
     <tr>
         <td>#FirstName#</td>
         <td>#LastName#</td>
         <td>#CEOFName#</td>
         <td>#CEOLName#</td>
         <td>#CFOFName#</td>
         <td>#CFOLName#</td>
         <td>#PAFName#</td>
         <td>#PALName#</td></tr>
         <tr>
         <td colspan="2">#Title#</td>
         <td colspan="2">#CEOTitle#</td>
         <td colspan="2">#CFOTitle#</td>
         <td colspan="2">#PATitle#</td></tr>
         <tr>
         <td colspan="2">#Address#</td>
         <td colspan="2">#CEOAddr#</td>
         <td colspan="2">#CFOAddr#</td>
         <td colspan="2">#PAAddr#</td></tr>
         <tr>
         <td colspan="2">#City#</td>
         <td colspan="2">#CEOCity#</td>
         <td colspan="2">#CFOCity#</td>
         <td colspan="2">#PACity#</td></tr>
         <tr>
         <td colspan="2">#State##Zip#</td>
         <td colspan="2">#CEOState##CEOZip#</td>
         <td colspan="2">#CFOState##CFOZip#</td>
         <td colspan="2">#PAState##PAZIP#</td></tr>
         <tr>
         <td colspan="2">Phone: #Phone#
             <cfif ext is not "">Ext: #Ext#</cfif></td>
         <td colspan="2">Phone: #CEOPhone#
             <cfif CEOext is not "">Ext: #CEOExt#</cfif></td>
         <td colspan="2">Phone: #CFOPhone#
             <cfif CFOext is not "">Ext: #CFOExt#</cfif></td>
         <td colspan="2">Phone: #PAPhone#
             <cfif PAext is not "">Ext: #PAExt#</cfif></td></tr>
         <tr>
         <td colspan="2">Fax: #Fax#</td>
         <td colspan="2">Fax: #CEOFax#</td>
         <td colspan="2">Fax: #CFOFax#</td>
         <td colspan="2">Fax: #PAFax#</td></tr>
         <tr>
         <td colspan="2">E-mail: <span class="emailid-wrap">#Email_Gov#</span></td>
         <td colspan="2">E-mail: <span class="emailid-wrap">#CEOEmail#</span></td>
         <td colspan="2">E-mail: <span class="emailid-wrap">#CFOEmail#</span></td>
         <td colspan="2">E-mail: <span class="emailid-wrap">#PAEmail#</span></td></tr>
         </table>
    </div>
     <table class="table noborder-table">
     <tr>
     <td width="40">
         <cfif ((CEOFName is CFOFName) and (CEOLName is CFOLName) and (CEOFName is not "" and CEOLName is not ""))>
                 <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg" width="24" height="24" border="0" alt=""><cfelse>
                 <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg" width="24" height="24" border="0" alt=""></cfif>
         </td>
             <td>If the Chief Executive Officer and the Chief Financial Officer are the same person as the
                 Contact Person, please check this box and skip to Step 2. If not, please <u>do not</u> leave columns B
                 and C blank.
             </td></tr>
     </cfoutput>
     </table>
<!---
<center>2<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
Multi-Purpose Form</center><br>
--->
	<div class="text-danger margintop">*The contact person listed on the AFRs is for the current Fiscal Year.  Previous fiscal years may have a different contact person.  Please contact the Local Government Division at 877-304-3899 if you need the contact person for previous years.</div>
        <div class="text-danger margintop">*The Annual Financial Reports downloaded from this site may vary from the original report.  Total on the downloaded form reflect the total of all sub accounts.  Other changes may include the reported method of accounting.</div>

	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "MP">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
     <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Multi-Purpose Form - 1</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>
