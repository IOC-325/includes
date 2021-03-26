<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. �See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. �If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes
the preparation of a derivative work based on Mura CMS. Thus, the terms and
conditions of the GNU General Public License version 2 (�GPL�) cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission
to combine Mura CMS with programs or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, �the copyright holders of Mura CMS grant you permission
to combine Mura CMS �with independent software modules that communicate with Mura CMS solely
through modules packaged as Mura CMS plugins and deployed through the Mura CMS plugin installation API,
provided that these modules (a) may only modify the �/trunk/www/plugins/ directory through the Mura CMS
plugin installation API, (b) must not alter any default objects in the Mura CMS database
and (c) must not alter any files in the following directories except in cases where the code contains
a separately distributed license.

/trunk/www/admin/
/trunk/www/tasks/
/trunk/www/config/
/trunk/www/requirements/mura/

You may copy and distribute such a combined work under the terms of GPL for Mura CMS, provided that you include
the source code of that other code when and as the GNU GPL requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception
for your modified version; it is your choice whether to do so, or to make such modified version available under
the GNU General Public License version 2 �without this exception. �You may, if you choose, apply this exception
to your own modified versions of Mura CMS.
--->
<cfcomponent extends="mura.cfobject">

<!--- CUSTOM SITE REQUEST START --->
<cffunction name="onSiteRequestStart" output="false">
    <cfargument name="$" hint="mura scope" />

    <!--- CUSTOM handle class URLs --->
    <cfparam name="request.path" default="">
    <cfparam name="request.classpath" default="">
    <cfparam name="request.classnumber" default="">

    <cfif request.path contains "/about-our-office/comptrollers-critters/">
      hah<cfabort>
    </cfif>

    <!--- if /class/ is in the url --->
<!---     <cfif request.path contains '/class/'>
        <!--- if class id is provided --->
        <cfif right(request.path,1) is '/'>
            <cfset request.classpath = left(request.path,len(request.path)-1)>
        <cfelse>
            <cfset request.classpath = request.path>
        </cfif>
        <cfset request.classnumber = listLast(request.classpath,'/')>
    </cfif>      --->
    <!--- attempt to set content bean --->
<!---     <cfif len(trim(request.classnumber))>

        <!--- get content functions --->
        <cfset GWcontent = createObject('component','interactive.GWcontent')>
        <!--- load a feed of the current class --->
        <cfset contentQuery = GWcontent.GWcontentSearch(
            siteid=request.siteid,
            type="Page",
            parentid="B98EA962-155D-8F07-1D7F47530491001B",
            extsearch="classCode=#request.classnumber#"
            )>

    <cfif contentQuery.recordCount>
        <cfset request.contentbean = $.getBean('content').loadBy(siteid=request.siteid,contentid=contentQuery.contentid[1])>
    </cfif>

    </cfif> --->
    <!--- /end class URLs --->

</cffunction>


<cffunction name="onApplicationLoad">
	<cfparam name="application.coreversion" default="6">
	<cfparam name="application.cfversion" default="11">

  <cfsetting showdebugoutput="true">
  <!--- The Fiscal Year variables are needed for Vendor Payments and EVR --->
  <cfset application.cfy="21">
  <cfset application.PopularQueryFY="21">
  <cfset application.pfy="20">
  <cfset application.PPFY="19">

  <cfset application.whOwner="wh.">
  <cfset application.theKey = "Lxp/bIqzt9DlkT1S+Ufwpw==">
  <cfset application.theAlgor = "AES">
  <cfset application.theEncode = "Base64">
  <cfset application.webroot="http://illinoiscomptroller.gov/">
  <cfset application.ledgerurl="http://ledger.illinoiscomptroller.gov/">
  <cfset application.checkForCashDSN="DB2PRD">
  <cfset application.securityDataSource="Security">
  <cfset application.WHDSN="DB2PRD">

  <!--- This is for Local GovWarehouse --->
  <cfset application.LocGovWarehouse = "LocGovWarehouse">
  <cfset application.SQLSource = "LocGovWarehouse">
  <cfset application.LocGovWarehouseCFY = "2020">
  <cfset application.TIFpdfLoc="https://files.illinoiscomptroller.gov/LocGovTIF/"> <!--- SR 19178 Updated to use new ftp domain --->
  <cfset application.AuditpdfLoc="https://files.illinoiscomptroller.gov/LocGovAudits/"> <!--- SR 19178 Updated to use new ftp domain --->
  <cfset application.AgencyReportsUserId = "DataExtract">  
  <cfset application.AgencyReportsUserPassword = "$mokeFree123">
  <cfset application.AgencyReportsFTPServer = "https://files.illinoiscomptroller.gov">  
  <cfset application.AgencyReportsFTPServerURL = "https://files.illinoiscomptroller.gov">  
  <cfset application.AgencyReportsFTPFolder = "AgencyReportsDev">  


<!---   <cfset application.PowerProgram="PowerProgram">
  <cfset application.PowerProgramAppUrl="http://power.illinoiscomptroller.gov">--->
  <cfset application.BudgetVoiceProgram="BudgetVoice">
  <cfset application.BudgetVoiceProgramAppUrl="http://ILBudgetVoices.illinoiscomptroller.gov/login.cfm">
   <!--- not originally here for use with SR #18072 20180615 --->
   <cfset application.AppropriationsSql="AppropriationsSql"> 
  <!--- part of SR 17060 --->
    <cfset application.SmartBusinessIllinois="SmartBusinessIllinois">
  <cfset application.PowerProgramAppUrl="http://sbi.IllinoisComptroller.gov/login.cfm">
  <!--- end SR 17060 --->
  
  <cfset application.localCMS="MuraCMS">
  <cfset application.AgencyContactInfo="DB2PRD_SQL">
  <cfset application.GeneralDSN = "General"> <!--- See ...display_objects/custom/DebtProtest & StateProtest --->

  <!--- UAT ENVIRONMENT VARIABLES --->
<cfif findNoCase("uat",cgi.server_name)>
  <cfset application.LocalGovernmentDatasource = "AFRUAT"> <!--- See ... display_objects/custom/LGRegistery --->
  <cfset application.StateDebtProtestFormEmailTo = "Greg.Winhold@illinoiscomptroller.gov;">
  <cfset application.LocalDebtProtestFormEmailTo = "Greg.Winhold@illinoiscomptroller.gov;">
  <cfelse>
  <cfset application.LocalGovernmentDatasource = "AFRSQLProd"> 
  <cfset application.StateDebtProtestFormEmailTo = "StateProtest@illinoiscomptroller.gov;">
  <cfset application.LocalDebtProtestFormEmailTo = "LDRP-Protest-Responses@illinoiscomptroller.gov;">
</cfif>

  <cfset application.AgencyContactInfo="DB2PRD_SQL">

</cffunction>

<cffunction name="onPageAccountingBulletinBodyRender">

<cfoutput>
<p>This bulletin was posted on #Dateformat($.content('accountingBulletinDate'),'m/d/yyyy')#. You may

<cfset bulletinPDF = $.getURLForFile($.content('accountingBulletinPDF')) />
<cfif len(bulletinPDF)>
	 <a href="#BulletinPDF#">download Bulletin #$.content('accountingBulletinNumber')# in PDF Format</a>
</cfif>

<cfset bulletinDoc = $.getURLForFile($.content('accountingBulletinDoc')) />
<cfif len(bulletinDoc)>
 <a href="#bulletinDoc#">or in Word format</a>.</p>
</cfif>
</cfoutput>

</cffunction>

<cffunction name="onPagePayrollBulletinBodyRender">

<cfoutput>
<p>This bulletin was posted on
#Dateformat($.content('payrollBulletinDate'),'m/d/yyyy')#. You may

<cfset bulletinPDF = $.getURLForFile($.content('payrollBulletinPDF')) />

<cfif len(bulletinPDF)>
	 <a href="#BulletinPDF#">download Bulletin #$.content('payrollBulletinNumber')# in PDF Format</a>
</cfif>

<cfset bulletinDoc = $.getURLForFile($.content('payrollBulletinDoc')) />

<cfif len(bulletinDoc)>
 <a href="#bulletinDoc#">or in Word format</a>.</p>
</cfif>

</cfoutput>

</cffunction>

<cfscript>
public any function onRenderStart($) {
if ( $.event('showMeta') != 2 ) {
$.event('showMeta', 2);
};
}
</cfscript>

</cfcomponent>
