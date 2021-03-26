<!---
Application: SR# 599071 - AFR Data Entry System
Author: Gary Ashbaugh
Date Created: 3-13-00
Date Modified: 4-19-00
Modifications Made:  Changed to reflect new AFR
Modified By: Gary Ashbaugh
Date Modified: 6-1-00
Modified By: Gary Ashbaugh
Modifications Made: Added Unit Name and Code to the top of form
Date Modified: 8-27-01
Modified By: Gary Ashbaugh
Modifications Made: Changed program as specified in SR#01153 and SR#01107 Detail Design
Date Modified: 1-14-02
Modified By: Gary Ashbaugh
Modifications Made:  Removed reference to FY from all UnitData queries.
Date Modified: 2-1-03
	Modified By: Gary Ashbaugh
	Modifications Made: Changed all internal SQL statements to SQL Stored Procedure Calls

LOGIC: Pulls off data from the Indebtedness table to show a unformatted view of the Page F5 of the AFR

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
 
<cfset url.PageType="Summary">
<cfset url.PageName="Debt Limitations and Future Debt">
<div class="gray-div myjumbotron">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/SummaryHeading.cfm">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableSumAFR.cfm">
</div>
<h3 class="clearfix">
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/financial-data/local-government-division/local-government-data/pdfreport/?FileName=/data/reports/FY2019/SPFReporttot/DebtServ.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData# Summary&Format=Special Purpose Form&Page=F6" class="btn btn-primary nomargin">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>
</cfif>
</cfoutput>
</h3>

<div class="text-center marginb15"><b>Debt Limitations and Future Debt</b></div>

	<cfoutput>
	<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_AFRNotes">
		<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.Code#">
		<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
		<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@Category" value="AuthDebtLimit">
		<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRNotesRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRNotesRetMsg">
		<cfprocresult name="GetAFRNotes">
	</cfstoredproc>
	</cfoutput>

    <table class="table table-bordered">
        <tr><td colspan="3"><input type="checkbox" name="NoLegalDebtLimit" <cfif trim(GetAFRRptPg1.NoDebtLimitReason) is not "">checked</cfif> value="Y" disabled>&nbsp;I certify that <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> does not have Legal Debt Limitation</td></tr>
        <tr><td>&nbsp;</td><td><input type="radio" name="LimitBased" value="Statute" disabled <cfif trim(GetAFRRptPg1.NoDebtLimitReason) is "Statute">checked</cfif>>&nbsp;Based on Statute</td><td>Explain: <cfif trim(GetAFRRptPg1.NoDebtLimitReason) is "Statute"><cfoutput>#GetAFRRptPg1.DebtLimitReason#</cfoutput></cfif></td></tr>
        <tr><td>&nbsp;</td><td><input type="radio" name="LimitBased" value="Other" <cfif trim(GetAFRRptPg1.NoDebtLimitReason) is "Other">checked</cfif> disabled>&nbsp;Based on Other Reasons</td><td>Explain: <cfif trim(GetAFRRptPg1.NoDebtLimitReason) is "Other"><cfoutput>#GetAFRRptPg1.DebtLimitReason#</cfoutput></cfif></td></tr>
        </table>
      <cfif GetAFRRptPg1.HomeRule is "N">
          <table class="table table-bordered margintop30">
        <cfoutput>
        <tr>
        <td><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Legal Debt Limitation<cfif url.PrintIt is "no"></a></cfif></td>
        <td align="right">#ltrim(rtrim(NumberFormat(GetAFRRptPg1.TotLegalDbtLimit,"$999,999,999,999,999")))#</td>
        <td>Please provide a summary of the authorized debt limitations, including any statutory references.</td>
        </tr>
        <tr>
        <td colspan="3">
        #GetAFRNotes.Explanation#</td>
        </tr>
        <tr>
        <td><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Debt Applicable to the Limit<cfif url.PrintIt is "no"></a></cfif></td>
        <td align="right">#ltrim(rtrim(NumberFormat(GetAFRRptPg1.TotDebtAppToLimit,"$999,999,999,999,999")))#</td>
        <td>&nbsp;</td>
        </tr>
        <tr>
        <td><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Legal Debt Margin<cfif url.PrintIt is "no"></a></cfif></td>
        <td align="right">#ltrim(rtrim(NumberFormat(GetAFRRptPg1.LegalDbtMargin,"$999,999,999,999,999")))#</td>
        <td>&nbsp;</td>
        </tr>
        <tr>
        <td><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Legal Debt Margin (%)<cfif url.PrintIt is "no"></a></cfif></td>
        <td align="right">#ltrim(rtrim(NumberFormat(GetAFRRptPg1.LegalDbtMarginPercent,"999,999,999,999.99")))#%</td>
        <td>&nbsp;</td>
        </tr>
        </cfoutput>
        </table>
    <cfelse>
          <table class="table table-bordered">
        <tr><td>Please provide a summary of the authorized debt limitations, including any statutory references.</td></tr>
        <cfoutput>
        <tr><td>#GetAFRNotes.Explanation#</td></tr>
        </cfoutput>
        </table>
    </cfif>
    <table class="table table-bordered margintop30">
    <cfset Year1=#url.CFY#+1>
	<cfset Year2=#url.CFY#+2>
	<cfset Year3=#url.CFY#+3>
	<cfset Year4=#url.CFY#+4>
	<cfset Year5=#url.CFY#+5>
	<cfset Year6=#url.CFY# + 6  &  #url.CFY# + 10>
	<cfset Year7=#url.CFY# + 11  &  #url.CFY# +15>
	<Cfset Year8=#url.CFY# + 15  &  #url.CFY# +20>
	<cfoutput>
    <tr><td colspan="4">Future Debt Service Requirements for Bond Debt listed above</td></tr>
    <tr><td><b>Years Ending</b></td><td><b>Principal</b></td><td><b>Interest</b></td><td><b>Total</b></td></tr>
    <cfloop index="i" list="#Year1#,#Year2#,#Year3#,#Year4#,#Year5#,#Year6#,#Year7#,#Year8#">
    
        <cfStoredProc datasource="#application.SQLSource#" Procedure="Get_FutureDebtService">
        	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.Code#">
           	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
            <cfif len(trim(i)) gt 4>
            	<cfset TmpYearEnding="#mid(i,1,4)#"&"-"&"#mid(i,5,4)#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@YearEnding" value="#TmpYearEnding#">
            <cfelse>
            	<cfprocparam type="In"  cfsqltype="CF_SQL_varChar" dbvarname="@YearEnding" value="#i#">
            </cfif>
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFutureDebtServiceRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFutureDebtServiceRetMsg">
            <cfprocresult name="GetFutureDebtService">
        </cfstoredproc>
        <tr><td><cfif url.PrintIt is "no"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif><cfif len(trim(i)) gt 4>#left(i,4)#-#mid(i,5,4)#<cfelse>#trim(i)#</cfif><cfif url.PrintIt is "no"></a></cfif></td><td align="right"><cfif trim(GetFutureDebtService.principle) is "">#ltrim(rtrim(NumberFormat(0,"$999,999,999,999,999")))#<cfelse>#ltrim(rtrim(NumberFormat(GetFutureDebtService.Principle,"$999,999,999,999,999")))#</cfif></td><td align="right"><cfif trim(GetFutureDebtService.Interest) is "">#ltrim(rtrim(NumberFormat(0,"$999,999,999,999,999")))#<cfelse>#ltrim(rtrim(NumberFormat(GetFutureDebtService.Interest,"$999,999,999,999,999")))#</cfif></td><td align="right"><cfset TmpTotal = iif(GetFutureDebtService.Principle is "",0,GetFutureDebtService.Principle) + iif(GetFutureDebtService.Interest is "",0,GetFutureDebtService.Interest)>#NumberFormat(TmpTotal,"$999,999,999,999,999")#</td></tr>
    </cfloop>
    </cfoutput>
    </table>
</cflock>
