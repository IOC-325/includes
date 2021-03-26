<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!---
Date Modified: 6-12-12
Modified By: Gary Ashbaugh
Modifications Made: Removed Export to History Feature
--->
<!---<html>
<head>
	<title>Verification of Appropriation</title>
</head>

<body>--->
<br><br>
<cfset url.PageType="AFR">
<cfset url.PageName="Component Units and Appropriations">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm"><br />
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
      <p align="center"><font face="Candara" size="+2" color="Black">STATE OF ILLINOIS</font><br>
      <font face="Candara" size="+2" color="Black">COMPTROLLER</font><br><hr color="#D3BB78" width="27%">
      <font face="Candara" size="+2" color="Black"><b><center>JUDY BAAR TOPINKA</center></b></font></p></td>
      <td width="15%">&nbsp;</td>
    </tr>
    </table>--->
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="95%" id="AutoNumber1">
  	<tr>
      <td width="97%" height="19" colspan="7">
      <center><cfoutput><font size="+2">FY #url.cfy#</font></cfoutput></center></td>
    </tr>
    <tr>
      <td width="97%" height="19" colspan="7">
      <center><font size="+2">Verification of Appropriation Form</font></center></td>
    </tr>
    <tr><td width="100%" height="19" colspan="7">
    <h5>
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2013/VFrm/AppropVerification.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Verification Form&Page=1" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>
    </td></tr>
    <tr>
      <td width="100%" height="19" colspan="7">
      <hr color="#000000" size="1" align="left"></td>
    </tr>
    <tr>
      <td width="13%" height="19">&nbsp;</td>
      <td width="84%" height="19" colspan="6"><font size="2">Unit of Government:&nbsp;<cfoutput><b>#TmpUnitName#</b></cfoutput>
      </font> </td>
    </tr>
    <tr>
      <td width="13%" height="19">&nbsp;</td>
      <td width="84%" height="19" colspan="6"><font size="2">Unit Code: <cfoutput><b>#url.code#</b></cfoutput></font> </td>
    </tr>
    <tr>
      <td width="13%" height="19">&nbsp;</td>
      <td width="84%" height="19" colspan="6"><font size="2">Fiscal Year End Date: <cfoutput><b>#DateFormat(GetAuditInfo.FYEnd,"mm/dd")#</b></cfoutput></font> </td>
    </tr>
    <br><Br>
    <center>
    <table border="1" cellpadding="0" cellspacing="0" bordercolor="#111111" width="65%"> 
    <tr><td colspan="3" valign="top"><Font color="#666666">Please complete the following information (please make changes if necessary):</Font></td></tr>
    <tr><td width="30%">First Name:</td><td valign="top" colspan="2"><font size="2"><cfoutput>#GetUnitInfo.FirstName#</cfoutput></font></td></tr>
    <tr><td width="30%">Last Name:</td><td valign="top" colspan="2"><font size="2"><cfoutput>#GetUnitInfo.LastName#</cfoutput></font></td></tr>
    <tr><td width="30%">Title:</td><td valign="top" colspan="2"><font size="2"><cfoutput>#GetUnitInfo.Title#</cfoutput></font></td></tr>
    <tr><td width="30%">Address:</td><td valign="top" colspan="2"><font size="2"><cfoutput>#GetUnitInfo.Address#</cfoutput></font></td></tr>
    <tr><td width="30%">City:</td><td valign="top" colspan="2"><font size="2"><cfoutput>#GetUnitInfo.City#</cfoutput></font></td></tr>
    <tr><td width="30%">State / ZIP:</td><td valign="top" width="20%"><font size="2">IL</font></td><td valign="top"><font size="2"><cfoutput>#GetUnitInfo.ZIP#</cfoutput></font></td></tr>
    <tr><td width="30%">Best Way to<br>Contact:</td><td valign="top" colspan="2"><Cfif GetUnitInfo.NotificationType is "EMail"><font size="2"><u>&nbsp;&nbsp;x&nbsp;&nbsp;</u></font><cfelse><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></Cfif>Email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<Cfif GetUnitInfo.NotificationType is "Mobile"><font size="2"><u>&nbsp;&nbsp;x&nbsp;&nbsp;</u></font><cfelse><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></Cfif>Mobile<br><Cfif GetUnitInfo.NotificationType is "Phone"><font size="2"><u>&nbsp;&nbsp;x&nbsp;&nbsp;</u></font><cfelse><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></Cfif>Phone&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<Cfif GetUnitInfo.NotificationType is "Mail"><font size="2"><u>&nbsp;&nbsp;x&nbsp;&nbsp;</u></font><cfelse><u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></Cfif>Mail</td></tr>
    <tr><td width="30%">Phone / Ext:</td><td valign="top" width="20%"><font size="2"><cfoutput>#GetUnitInfo.Phone#</cfoutput></font></td><td valign="top"><font size="2"><cfoutput>#GetUnitInfo.Ext#</cfoutput></font></td></tr>
    <tr><td width="30%">Fax:</td><td valign="top" colspan="2"><font size="2"><cfoutput>#GetUnitInfo.Fax#</cfoutput></font></td></tr>
    <tr><td width="30%">E-mail:</td><td valign="top" colspan="2"><font size="2"><cfoutput>#GetUnitInfo.Email_Gov#</cfoutput></font></td></tr>
	</table>
    </center>
    <table border="0" cellpadding="0" cellspacing="0" bordercolor="#111111" width="95%"> 
	<tr width="100%">
      <td width="6%" height="19">&nbsp;</td>
      <td width="1%" height="19">&nbsp;</td>
      <td width="43%" height="19">&nbsp;</td>
      <td width="43%" height="19">&nbsp;</td>
      <td width="1%" height="19">&nbsp;</td>
      <td width="6%" height="19">&nbsp;</td>
    </tr>
    <!---
    <tr width="100%">
      <td width="6%" height="19">&nbsp;</td>
      <td width="88%" colspan="4">
      <table border="0" cellpadding="0" cellspacing="0" bordercolor="##111111" width="100%">
		 <tr>
	  
      <td colspan="3"><hr color="#000000" size="1" align="left" width="100%"></td>
	 
      </tr>
	  --->
	  <tr height="38">
		<td width="1%" height="38"  valign="top" align="right">&nbsp;</td>
     	<td width="98%" width="38">The Government Audit Act exempts special purpose governments that appropriate or budget less than <cfoutput>#NumberFormat(GetExemptApprop.CheckAppropriation,"$99,999")#</cfoutput> in FY <cfoutput>#url.cfy#</cfoutput> from filing an Annual Financial Report with the Office of the Comptroller.</td>
		<td width="1%" height="38"  valign="top" align="right">&nbsp;</td>
      </tr>
	   <tr height="1">
      <td colspan="3">&nbsp;</td>
      </tr>
	   <tr height="38">
	<td width="1%" height="38"  valign="top" align="right">&nbsp;</td>
     <td width="98%" width="38">This document shall serve as official notice to the Office of the Comptroller that <cfoutput>#TmpUnitName#</cfoutput> appropriated^ or budgeted <cfoutput>#NumberFormat(GetUnitStatInfo.TotalAppropriations,"$99,999")#</cfoutput> in FY <cfoutput>#url.cfy#</cfoutput>.<br><font color="red" size="-1">^If the Primary Government does NOT budget or levy taxes, please enter the unit's TOTAL EXPENDITURES.</td>
		<td width="1%" height="38"  valign="top" align="right">&nbsp;</td>
      </tr>
	   <tr height="1">
      <td colspan="3">&nbsp;</td>
      </tr>
      <tr height="1">
      <table border="0" cellpadding="0" cellspacing="0" bordercolor="##111111" width="100%">
       <tr>
	  
      <td colspan="3"><hr color="#000000" size="1" align="left" width="100%"></td>
	 
      </tr>
      <!---<tr>
      <td height="1" width="100%" align="left" valign="bottom" colspan="3"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="100%" height="1" align="left" valign="bottom" hspace="0"></cfoutput></td>
      </tr>--->
      <tr height="1">
      <!---<td width="1%" height="38" valign="top"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="1" height="100%" align="left" valign="top" hspace="0"></cfoutput></td>--->
    	<td width="1%" height="38" valign="top">&nbsp;</td>
    	<td width="98%" height="38" valign="top" colspan="3"><font size="2">I attest that, to the best of my knowledge, this document represents the financial position of the government as of the end of this fiscal year.</font></td>
      <!---<td width="1%" height="38"  valign="top" align="right"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="1" height="100%" align="right" valign="top" hspace="0"></cfoutput></td>--->
      <td width="1%" height="38"  valign="top" align="right">&nbsp;</td>
      </tr>
       <tr height="1">
      <!---<td width="1%" height="19" valign="top"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="1" height="100%" align="left" valign="top" hspace="0"></cfoutput></td>--->
     <td width="1%" height="19" valign="top">&nbsp;</td>
     <td width="98%" height="19" valign="top" colspan="2">&nbsp;</td>
      <!---<td width="1%" height="19"  valign="top" align="right"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="1" height="100%" align="right" valign="top" hspace="0"></cfoutput></td>--->
    <td width="1%" height="19"  valign="top" align="right">&nbsp;</td>
    </tr>
       <tr height="1">
      <!---<td width="1%" height="19" valign="top"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="1" height="100%" align="left" valign="top" hspace="0"></cfoutput></td>--->
     <td width="1%" height="19" valign="top">&nbsp;</td>
     <td width="98%" height="19" valign="top" colspan="2"><font size="2">________________________________________________________      Date ________________</font></td>
      <!---<td width="1%" height="19"  valign="top" align="right"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="1" height="100%" align="right" valign="top" hspace="0"></cfoutput></td>--->
     <td width="1%" height="19"  valign="top" align="right">&nbsp;</td>
     </tr>
       <tr height="1">
      <!---<td width="1%" height="19" valign="top"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="1" height="100%" align="left" valign="top" hspace="0"></cfoutput></td>--->
      <td width="1%" height="19" valign="top">&nbsp;</td>
      <td width="98%" height="19" valign="top" colspan="2"><font size="2"><b>Signature of <cfoutput>#TmpGovOfficial#</cfoutput></b></font></td>
      <!---<td width="1%" height="19"  valign="top" align="right"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="1" height="100%" align="right" valign="top" hspace="0"></cfoutput></td>--->
      <td width="1%" height="19"  valign="top" align="right">&nbsp;</td>
      </tr>
      <tr height="1">
      <!---<td width="1%" height="19" valign="top"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="1" height="100%" align="left" valign="top" hspace="0"></cfoutput></td>--->
      <td width="1%" height="19" valign="top">&nbsp;</td>
      <td width="98%" height="19" valign="top" colspan="2"><font size="2"><cfoutput><b>#TmpUnitName#</b></cfoutput></font></td>
      <!---<td width="1%" height="19"  valign="top" align="right"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="1" height="100%" align="right" valign="top" hspace="0"></cfoutput></td>--->
      <td width="1%" height="19"  valign="top" align="right">&nbsp;</td>
      </tr>
      <tr>
	  
      <td colspan="3"><hr color="#000000" size="1" align="left" width="100%"></td>
	 
      </tr>
      <tr height="1">
      <!---<td height="1" width="100%" align="left" valign="bottom" colspan="3"><cfoutput><img border="0" src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/VBlueLine.gif" width="100%" height="1" align="left" valign="bottom" hspace="0"></cfoutput></td>--->
      <td height="1" width="100%" align="left" valign="bottom" colspan="3">&nbsp;</td>
      </tr>
	   <tr width="100%"><td colspan="6">&nbsp;</td></tr>
	  	<tr width="100%"><td colspan="6">Confirmation of FY <cfoutput>#url.cfy#</cfoutput> Verification Form</td></tr>
		<tr width="100%"><td colspan="6">&nbsp;</td></tr>
		 <tr width="100%"><td colspan="6"><cfoutput>#TmpUnitName# (#url.code#) has successfully submitted their FY #url.cfy# Verification Form to the Office of the State Comptroller on #DateFormat(GetUnitStatInfo.Date_Finished,"mm/dd/yyyy")# <cfif GetUnitStatInfo.Date_Resubmitted is not ""> and re-submitted on #DateFormat(GetUnitStatInfo.Date_Resubmitted,"mm/dd/yyyy")#</cfif>.  Please print and keep a copy of this screen for your records.</cfoutput></td></tr>
      </td>
      <td width="6%" height="19">&nbsp;</td>
    </tr>
</table>
</cflock>
<!---</body>
</html>--->
