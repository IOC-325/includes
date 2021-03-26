<!---
Date Modified: 6-12-12
Modified By: Gary Ashbaugh
Modifications Made: Removed Export to History Feature
--->
<cfset url.PageType="AFR">
<cfset url.PageName="Component Units and Appropriations">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<cflock SCOPE="SESSION" TYPE="EXCLUSIVE" TIMEOUT="100">
<cfoutput>
<cfStoredProc  datasource="#application.SQLSource#" Procedure="Get_UnitInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_SMALLINT" dbvarname="@C4" null="yes">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitInfoRetMsg">
	<cfprocresult name="GetUnitInfo">
</cfstoredproc>

<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AppropCheckInfo">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.cfy#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExemptAppropRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExemptAppropRetMsg">
	<cfprocresult name="GetExemptApprop">
</cfstoredproc>

<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AuditInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.cfy#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@Instrument" value="Annual Report">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAuditInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAuditInfoRetMsg">
	<cfprocresult name="GetAuditInfo">
</cfstoredproc>

<cfset TmpUnitName = trim(GetUnitInfo.UnitName) & " " & trim(GetUnitInfo.Description)>

<cfif GetUnitInfo.Title is not "">
	<cfset TmpGovOfficial = trim(GetUnitInfo.FirstName) & ' ' & trim(GetUnitInfo.LastName) & ', ' & trim(GetUnitInfo.Title)>
<cfelse>
	<cfset TmpGovOfficial = trim(GetUnitInfo.FirstName) & ' ' & trim(GetUnitInfo.LastName)>
</cfif>

<cfStoredProc  datasource="#application.SQLSource#" Procedure="Get_UnitStatInfo">
    <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@FY" value="#url.cfy#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitStatInfoRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitInfoRetMsg">
    <cfprocresult name="GetUnitStatInfo">
</cfstoredproc>
</cfoutput>
    
<!---
  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
    <tr>
    	<td width="10%">&nbsp;</td>
      <td width="1%" height="268" rowspan="3">
      <cfoutput><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/ComptrollerSealJBT152.jpg" alt="Judy Baar Topinka, Comptroller" width="152" height="101" border="0" align="top"></CFOUTPUT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
      <td width="7%" height="268" rowspan="3" colspan="2">
      <p align="center"><font face="Candara" size="+2" color="Black">STATE OF ILLINOIS<br>
      <font face="Candara" size="+2" color="Black">COMPTROLLER<br><hr color="#D3BB78" width="27%">
      <font face="Candara" size="+2" color="Black"><b><center>JUDY BAAR TOPINKA</center></b></p></td>
      <td width="15%">&nbsp;</td>
    </tr>
    </table>--->

    <h3 class="text-center">
        <cfoutput>FY #url.cfy#</cfoutput><br>
        Verification of Appropriation Form
    </h3>
    <h5 class="clearfix">
    <span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2016/VFrm/AppropVerification.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Verification Form&Page=1" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
    </h5>

    Unit of Government:&nbsp;<cfoutput><b>#TmpUnitName#</b></cfoutput><br>
Unit Code: <cfoutput><b>#url.code#</b></cfoutput><br>
Fiscal Year End Date: <cfoutput><b>#DateFormat(GetAuditInfo.FYEnd,"mm/dd")#</b></cfoutput>

    <div class="table-responsive margintop">
    <table class="table table-bordered">
        <tr>
            <td colspan="3" valign="top">Please complete the following information (please make changes if necessary):
            </td>
        </tr>
    <tr>
        <td>First Name:</td>
    <td valign="top" colspan="2">
    <cfoutput>#GetUnitInfo.FirstName#</cfoutput></td></tr>
<tr>
    <td>Last Name:</td>
<td valign="top" colspan="2">
    <cfoutput>#GetUnitInfo.LastName#</cfoutput></td></tr>
<tr>
    <td>Title:</td>
<td valign="top" colspan="2">
    <cfoutput>#GetUnitInfo.Title#</cfoutput></td></tr>
<tr>
    <td>Address:</td>
<td valign="top" colspan="2">
    <cfoutput>#GetUnitInfo.Address#</cfoutput></td></tr>
<tr>
    <td>City:</td>
<td valign="top" colspan="2">
    <cfoutput>#GetUnitInfo.City#</cfoutput></td></tr>
<tr>
    <td>State / ZIP:</td>
    <td valign="top">IL</td>
<td valign="top">
    <cfoutput>#GetUnitInfo.ZIP#</cfoutput></td></tr>
<tr>
    <td>Best Way to<br>Contact:</td>
<td valign="top" colspan="2">
    <Cfif GetUnitInfo.NotificationType is "EMail"><u>&nbsp;&nbsp;x&nbsp;&nbsp;</u>
        <cfelse><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></Cfif>Email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <Cfif GetUnitInfo.NotificationType is "Mobile"><u>&nbsp;&nbsp;x&nbsp;&nbsp;</u>
        <cfelse><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></Cfif>Mobile<br>
    <Cfif GetUnitInfo.NotificationType is "Phone"><u>&nbsp;&nbsp;x&nbsp;&nbsp;</u>
        <cfelse><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></Cfif>Phone&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <Cfif GetUnitInfo.NotificationType is "Mail"><u>&nbsp;&nbsp;x&nbsp;&nbsp;</u>
        <cfelse><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></Cfif>Mail</td></tr>
<tr>
    <td>Phone / Ext:</td>
<td valign="top">
    <cfoutput>#GetUnitInfo.Phone#</cfoutput></td>
<td valign="top">
    <cfoutput>#GetUnitInfo.Ext#</cfoutput></td></tr>
<tr>
    <td>Fax:</td>
<td valign="top" colspan="2">
    <cfoutput>#GetUnitInfo.Fax#</cfoutput></td></tr>
<tr>
    <td>E-mail:</td>
<td valign="top" colspan="2">
    <cfoutput>#GetUnitInfo.Email_Gov#</cfoutput></td></tr>
</table>
</div>
<div>The Government Audit Act exempts special purpose governments that appropriate or budget less than <cfoutput>#NumberFormat(GetExemptApprop.CheckAppropriation,"$99,999")#</cfoutput> in FY <cfoutput>#url.cfy#</cfoutput> from filing an Annual Financial Report with the Office of the Comptroller.</div>
<div class="margintop">This document shall serve as official notice to the Office of the Comptroller that <cfoutput>#TmpUnitName#</cfoutput> appropriated^ or budgeted <cfoutput>#NumberFormat(GetUnitStatInfo.TotalAppropriations,"$99,999")#</cfoutput> in FY <cfoutput>#url.cfy#</cfoutput>.</div>
<div class="text-danger">^If the Primary Government does NOT budget or levy taxes, please enter the unit's TOTAL EXPENDITURES.</div>

<div class="divider margintop30">I attest that, to the best of my knowledge, this document represents the financial position of the government as of the end of this fiscal year.<br><br>
      ________________________________________________________      Date ________________<br>
      <b>Signature of <cfoutput>#TmpGovOfficial#</cfoutput></b><br>
      <cfoutput><b>#TmpUnitName#</b></cfoutput></div>

<div class="margintop">Confirmation of FY <cfoutput>#url.cfy#</cfoutput> Verification Form</div>
<div class="margintop marginb20"><cfoutput>#TmpUnitName# (#url.code#) has successfully submitted their FY #url.cfy# Verification Form to the Office of the State Comptroller on #DateFormat(GetUnitStatInfo.Date_Finished,"mm/dd/yyyy")# <cfif GetUnitStatInfo.Date_Resubmitted is not ""> and re-submitted on #DateFormat(GetUnitStatInfo.Date_Resubmitted,"mm/dd/yyyy")#</cfif>.  Please print and keep a copy of this screen for your records.</cfoutput></div>

</cflock>

