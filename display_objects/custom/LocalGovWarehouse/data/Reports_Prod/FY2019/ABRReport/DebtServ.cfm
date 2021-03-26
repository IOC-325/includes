<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Author: Gary Ashbaugh
Date Created: 4-9-03

LOGIC: Pulls off data from the Indebtedness table to show a unformatted view of the Page F4 of the AFR

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
 
<cfset url.PageType="AFR">
<cfset url.PageName="Debt Limitations and Future Debt">
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<!---<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">--->
</div>
<h5>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2019/ABRReport/DebtServ.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Abbreviated Form&Page=F5" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h5>

<center><font size="-1"><b>Debt Limitations and Future Debt</b>&nbsp;</font></center>	
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
         
    <br><br>
    
    <table bgcolor="white" cellspacing="0" cellpadding="2" border="1" frame="box" width="75%">
        <tr><Td colspan="4"><input type="checkbox" name="NoLegalDebtLimit" <cfif trim(GetAFRRptPg1.NoDebtLimitReason) is not "">checked</cfif> value="Y" disabled>&nbsp;I certify that <cfoutput>#GetAFRRptPg1.UnitName# #GetAFRRptPg1.Description#</cfoutput> does not have Legal Debt Limitation</Td></tr>
        <tr><td>&nbsp;</td><td colspan="2"><input type="radio" name="LimitBased" value="Statute" disabled <cfif trim(GetAFRRptPg1.NoDebtLimitReason) is "Statute">checked</cfif>>&nbsp;Based on Statute</td><td>Explain: <cfif trim(GetAFRRptPg1.NoDebtLimitReason) is "Statute"><cfoutput>#GetAFRRptPg1.DebtLimitReason#</cfoutput></cfif></td></tr>
        <tr><td>&nbsp;</td><td colspan="2"><input type="radio" name="LimitBased" value="Other" <cfif trim(GetAFRRptPg1.NoDebtLimitReason) is "Other">checked</cfif> disabled>&nbsp;Based on Other Reasons</td><td>Explain: <cfif trim(GetAFRRptPg1.NoDebtLimitReason) is "Other"><cfoutput>#GetAFRRptPg1.DebtLimitReason#</cfoutput></cfif></td></tr>
        </table><br>
    <cfif GetAFRRptPg1.HomeRule is "N">    
		<br>
        <table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box" width="75%">
        <cfoutput>
        <tr>
        <td colspan="4" width="50%">Total Legal Debt Limitation</td>
        <td colspan="2" align="right">#ltrim(rtrim(NumberFormat(GetAFRRptPg1.TotLegalDbtLimit,"$999,999,999,999,999")))#</td>
        <td colspan="2">&nbsp;</td>
        <td colspan="5" width="30%">Please provide a summary of the authorized debt limitations, including any statutory references.</td>
        </tr>
        <tr>
        <td colspan="6">&nbsp;</td>
        <td colspan="2" width="5%">&nbsp;</td>
        <td colspan="5" rowspan="5"  >
        #GetAFRNotes.Explanation#</td>
        </tr>
        <tr>
        <td colspan="4">Total Debt Applicable to the Limit</td>
        <td colspan="2" align="right">#ltrim(rtrim(NumberFormat(GetAFRRptPg1.TotDebtAppToLimit,"$999,999,999,999,999")))#</td>
        <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
        <td colspan="6">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
        <td colspan="4">Legal Debt Margin</td>
        <td colspan="2" align="right">#ltrim(rtrim(NumberFormat(GetAFRRptPg1.LegalDbtMargin,"$999,999,999,999,999")))#</td>
        <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
        <td colspan="6">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
        <td colspan="4">Legal Debt Margin (%)</td>
        <td colspan="2" align="right">#ltrim(rtrim(NumberFormat(GetAFRRptPg1.LegalDbtMarginPercent,"999,999,999,999.99")))#%</td>
        <td colspan="7">&nbsp;</td>
        </tr>
        </cfoutput>
        </table>
    <cfelse>
    	<table bgcolor="F8FEAF" cellspacing="0" cellpadding="2" border="1" frame="box" width="60%">
        <tr><td colspan="13">Please provide a summary of the authorized debt limitations, including any statutory references.</td></tr>
        <cfoutput>
        <tr><td colspan="13">&nbsp;</td></tr>
        <tr><td colspan="13" >#GetAFRNotes.Explanation#</td></tr>
        </cfoutput>
        </table>
    </cfif>
    <br><br>
    <table bgcolor="white" cellspacing="0" cellpadding="2" border="1" frame="box" width="45%">
    <cfset Year1=#url.CFY#+1>
	<cfset Year2=#url.CFY#+2>
	<cfset Year3=#url.CFY#+3>
	<cfset Year4=#url.CFY#+4>
	<cfset Year5=#url.CFY#+5>
	<cfset Year6=#url.CFY# + 6  &  #url.CFY# + 10>
	<cfset Year7=#url.CFY# + 11  &  #url.CFY# +15>
	<Cfset Year8=#url.CFY# + 15  &  #url.CFY# +20>
	<cfoutput>
    <tr><td colspan="13">Future Debt Service Requirements for Bond Debt listed above</td></tr>
    <tr><td colspan="13">&nbsp;</td></tr>
    <tr><td colspan="3" width="20%"><b>Years Ending</b></td><td>&nbsp;</td><td colspan="3"><b>Principal</b></td><td>&nbsp;</td><td colspan="3"><b>Interest</b></td><td>&nbsp;</td><td><b>Total</b></td></tr>
    <tr><td colspan="13">&nbsp;</td></tr>
    <cfloop index="i" list="#Year1#,#Year2#,#Year3#,#Year4#,#Year5#,#Year6#,#Year7#,#Year8#">
    
        <cfStoredProc  datasource="#application.SQLSource#" Procedure="Get_FutureDebtService">
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
        <tr><td colspan="3" ><cfif len(trim(i)) gt 4>#left(i,4)#-#mid(i,5,4)#<cfelse>#trim(i)#</cfif></td><td>&nbsp;</td><td colspan="3" align="right"><cfif trim(GetFutureDebtService.principle) is "">#ltrim(rtrim(NumberFormat(0,"$999,999,999,999,999")))#<cfelse>#ltrim(rtrim(NumberFormat(GetFutureDebtService.Principle,"$999,999,999,999,999")))#</cfif></td><td>&nbsp;</td><td colspan="3" align="right"><cfif trim(GetFutureDebtService.Interest) is "">#ltrim(rtrim(NumberFormat(0,"$999,999,999,999,999")))#<cfelse>#ltrim(rtrim(NumberFormat(GetFutureDebtService.Interest,"$999,999,999,999,999")))#</cfif></td><td>&nbsp;</td><td align="right"><cfset TmpTotal = iif(GetFutureDebtService.Principle is "",0,GetFutureDebtService.Principle) + iif(GetFutureDebtService.Interest is "",0,GetFutureDebtService.Interest)>#NumberFormat(TmpTotal,"$999,999,999,999,999")#</td></tr>
    </cfloop>
    </cfoutput>
    </table>
    <br>
    <!---
    <p align="right"><font size="-1">F4&nbsp;</font></right>
	<br><center>
	<font size="-1"><cfoutput>#application.NAMEOFCOMPTROLLER2#</cfoutput><br>
	FY <cfoutput>#url.Cfy#</cfoutput> AFR<br>
	Abbreviated Form&nbsp;</font></center> <br><br>
	--->
	<cfparam name="url.Menu" default="Yes">
    <cfif url.Menu is "Yes" and url.PrintIt is "no">
    	<cfset url.formType = "Abbrev">
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
        <td width="20%">#url.CFY# Abbreviated Form - F5</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
<!---</body>
</html>--->
</cflock>
