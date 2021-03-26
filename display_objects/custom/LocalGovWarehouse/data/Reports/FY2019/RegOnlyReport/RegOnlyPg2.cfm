<!---
Application: SR# 05059 - Registration Only AFR Unit
Author: Gary Ashbaugh
Date Created: 7-7-05

LOGIC: Pulls off data from the UnitStats and UnitData table to show a unformatted view of the Cover Page of the Registration Only AFR

 --->
 <!--- Pull of the unit's name --->
<CFLOCK SCOPE="Session" timeout="100">
<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AuditInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_VarChar" dbvarname="@Instrument" value="Registration">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAuditInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAuditInfoRetMsg">
	<cfprocresult name="GetAuditInfo">
</cfstoredproc>
</cfoutput>

<cfoutput>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_ComponentUnitInfo">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetComponentUnitInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetComponentUnitInfoRetMsg">
	<cfprocresult name="GetComponentUnitInfo">
</cfstoredproc>
</cfoutput>
  
<cfset SubApprop = 0>
<cfset url.PageType="AFR">
<cfset url.PageName="Fiscal Year End">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">
</div>
<h5 class="clearfix"><span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 2:  VERIFY FISCAL YEAR END
<span class="pull-right"><cfoutput><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2019/RegOnlyReport/RegOnlyPg2.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Registration Form&Page=2" class="btn btn-primary nomargin"><span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span></cfif></cfoutput>
</h5>
<cfoutput>FY END DATE:&nbsp;&nbsp;#DateFormat(GetAFRRptPg1.FYEnd,"MM/DD/YYYY")#</cfoutput>
<br>
<h5><span class="glyphicon glyphicon-circle-arrow-right"></span> STEP 3:  POPULATION SERVED OR SCHOOL ENROLLMENT AND EAV</h5><br>
<br />
<b>P1. Has your government commenced dissolution proceedings?</b>&nbsp;&nbsp;&nbsp;&nbsp;<u>&nbsp;</u><cfif UCase(GetAFRRptPg1.DissolutionProceeding) is "Y"><u>X</u><cfelse><u>&nbsp;</u></cfif><u>&nbsp;</u> Yes&nbsp;&nbsp;&nbsp;&nbsp;<u>&nbsp;</u><cfif UCase(GetAFRRptPg1.DissolutionProceeding) is "N"><u>X</u><cfelse><u>&nbsp;</u></cfif><u>&nbsp;</u> No&nbsp;&nbsp;&nbsp;&nbsp;
<b>Dissolution Filing Date:</b> <cfif trim(GetAFRRptPg1.DissolutionPrelimDate) is not ""> <u><cfoutput>#DateFormat(GetAFRRptPg1.DissolutionPrelimDate,"mm/dd/yyyy")#</cfoutput></u><cfelse><u>          </u></cfif><br>
<br>
<table class="table table-bordered">
<cfoutput query="GetAFRRptPg1">
<tr><td>^What is the total <b>population served or school enrollment</b> of #UnitName# #Description#?</td><td align="right">#NumberFormat(Pop,"999,999,999,999,999")#&nbsp;</td></tr>
<tr><td>What is the total <b>EAV</b> of #UnitName# #Description#?</td><td align="right">#NumberFormat(EAV,"$999,999,999,999,999,999")#&nbsp;</td></tr>
</cfoutput>
</table>
<div class="text-danger margintop marginb30">^Or provide estimated population</div>

<h5><span class="glyphicon glyphicon-circle-arrow-right"></span> STEPS 4 AND 5:  COMPONENT UNITS AND APPROPRIATIONS</h5>
<b>Provide the appropriation for the primary government listed in the first row of the table below.</b><br>
<br>
If you are a primary unit of government, provide your Unit name and appropriation in the first row of the table below and list any component unit(s):<br>
<br>
<table class="table table-bordered">
<tr><td valign="top"><b>Name of Unit/Component*</b><br><u>FUNDS SHOULD NOT BE LISTED HERE</u><font color="red">*</font></td><td valign="top"><b>Appropriation^<font color="Red">^</font></b></td><td valign="top"><b>Fiscal Year End</b></td></tr>
<cfoutput><cfset SubApprop = #GetAFRRptPg1.Appropriations#>
<tr><td>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</td><td align="right">#NumberFormat(GetAFRRptPg1.Appropriations,"$999,999,999,999,999,999")#</td><td>#DateFormat(GetAuditInfo.FYEnd,"MM")#/#DateFormat(GetAuditInfo.FYEnd,"DD")#</td></tr>
</cfoutput>
<cfoutput query="GetComponentUnitInfo">
<cfset SubApprop = #iif(SubApprop is "",0,SubApprop)# + #iif(Amount is "",0,Amount)#>
<tr><td>#ComponentUnit#</td><td align="right">#NumberFormat(Amount,"$999,999,999,999,999")#</td><td>#DateFormat(FYEnd,"MM")#/#DateFormat(FYEnd,"DD")#</td></tr>
</cfoutput>
<cfoutput>
<tr><td><b>Total Appropriations</b></td><td align="right">#NumberFormat(SubApprop,"$9,999,999,999,999,999")#</td><td>&nbsp;</td></tr>
</cfoutput>
</table>
<div class="text-danger margintop">*Do not enter funds such as: Joint Bridge, Permanent Road, Town Fund, Equipment, Water & Sewer, General Assistance, etc.<br>
*Do not enter funds such as: Joint Bridge, Permanent Road, Town Fund, Equipment, Water & Sewer, General Assistance, etc.<br>^If the Primary Government or Component Unit does NOT budget or levy taxes, please enter the unit's TOTAL EXPENDITURES.</div>

<table class="table table-bordered margintop">
<tr>
    <td>Primary Government Unit Name:</td>
<td>
    <cfoutput>#GetAFRRptPg1.PrimaryUnit#</cfoutput></td>
</tr>
<tr>
    <cfoutput>
        <td colspan="2"><CFIF ltrim(rtrim(GetAFRRptPg1.ComponentFile)) is "Separate">
        <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                width="12" height="12" border="0" alt="">&nbsp;
        <cfelse>
        <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                width="12" height="12" border="0" alt="">&nbsp;</cfif>
            Component unit files financial information separately from the primary government</td>
    </cfoutput></tr>
<tr>
    <cfoutput>
        <td colspan="2"><CFIF ltrim(rtrim(GetAFRRptPg1.ComponentFile)) is "Combined">
        <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/Checked.jpg"
                width="12" height="12" border="0" alt="">&nbsp;
        <cfelse>
        <img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/UnChecked.jpg"
                width="12" height="12" border="0" alt="">&nbsp;</cfif>
            Component unit files financial information along with the primary government</td>
    </cfoutput></tr>
</table>
<!---
<center>2<br>
<cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
FY <cfoutput>#url.CFY#</cfoutput><br>
Registration Form</center><br><br>
--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "RegOnly">
    	<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/Menu2.cfm">
    	<!---<cfinclude template="Menu.cfm"><br><br>--->
	</cfif>
    <cfif url.PrintIt is "No">
    	<cfoutput>
            <div class="text-center">
            <table class="table">
            <tr>
            <td class="text-center">#url.AFRDesiredData#</td>
        <td>#url.CFY# Registration Form - 2</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</cflock>