<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!--- 
Created By: Gary Ashbaugh
Created Date: 9-18-00
Modified By: Gary Ashbaugh
Modified Date: 9-29-00
Modifications Made:  Removed all SQL queries for the Indicator sections and replaced them with Stored Procedure call to Access queries to solve a problem of 1999 and 1998 data not being pulled off correctly encountered during the test phase on 9-28-00
Modified By: Gary Ashbaugh
Modified Date: 10-4-00
Moodifications Made: Removed the word Distinct for Main SQL statement since the Access driver on the production is an older version than what's on the development server
Modified By: Gary Ashbaugh
Modified Date: 10-12-00
Modifications Made: Added PY2 to Efficiency Benchmark PY2 section reference to ActualNumberType and Actual fields and PY to the PY section reference to the ActualNumberType and Actual Fields.
Modified By: Gary Ashbaugh
Modified Date: 10-16-00
Modifications Made: Changed formatting of Number, Percent, and Dollar throughout report to the following.  Percent to show value entered plus percent sign, Dollar to show 1 decimal position, Number to show no decimal place if 1,000 or greater, or Number to show 2 decimal place if lt 1,000
Modified By: Gary Ashbaugh
Modified Date: 11-02-00
Modifications Made: Changed formatting of Cents throughout report to the following.  Cents to show $99,999,999.99.
Modified By: Gary Ashbaugh
Modified Date: 2-1-02
Modifications Made:  Changed Relative Path to PAP2002 and all references to sql statement to refer instead to a Stored Procedure
Modified Date: 9-19-02
Modifications Made:  Change the Numbertype formatting check for "Dollars/Cents", "$ in Thousands", "$ in Millions", "$ in Billions" to allow for either "N/A", "Yes", or "No" to be intermixed as requested by SR02195
Modified By: Gary Ashbaugh
Modified Date: 9-19-02
Modifications Made:  Change the "Target" heading to be "Target/Projected" as requested by SR02193

Logic: This program will allow the user to select the Agency's Program he/she wished to be printed off.  It will then display the report to the screen.
--->
  
<html>
<head>
	<title>Public Accounting Report - Report</title>
</head>
	 
<cfoutput>
<cfStoredProc datasource="PAPProd" Procedure="GetAgencyInfo">
	<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@AgencyNo" value="#url.AgencyNo#">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@AGCY_NAME" Variable="AGCY_NAME">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@IOC_ContactId" variable="IOC_ContactId">
	<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAgencyInfoRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAgencyInfoRetMsg">
	<cfprocresult name="GetAgencyInfo">
</cfstoredproc>
</cfoutput>

<body style="a.hot">
<!---
	*******************************************************************
		Show Report for the Selected Program
	*******************************************************************
--->

	<cfoutput>
	<cfStoredProc datasource="PAPProd" Procedure="GetPrograms">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@AgencyNo" value="#url.AgencyNo#">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@FY" Value="#url.ReportCFY#">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@ProgramId" Value="#url.ReportProgramId#">	
		<cfprocparam type="in" cfsqltype="cf_sql_tinyint" dbvarname="@InReport" Value="1">	
		<cfprocparam type="in" cfsqltype="cf_sql_tinyint" dbvarname="@DeletionInd" Value="0">
		<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetProgramsRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetProgramsRetMsg">
		<cfprocresult name="ThisYear">
	</cfstoredproc>
	</cfoutput>

	 <!--- 
	 	*******************************************************************
			This Years Program Mission Information 
		*******************************************************************		
	--->
	<table width="95%" bgcolor="White" cellspacing="0" cellpadding="0" border="0" frame="box">
	<tr><td colspan="2">
	<h3><b><center><cfoutput query="ThisYear"><font size="-2">#AGCY_Name# - #MajorFunction#</font></cfoutput></center></b></h3>
	</td width=10%"></tr>
	<tr><td align="left" valign="top">
	<b><font size="-2">Mission Statement:</font></b>
	<td width="85%" valign="top" align="left"><cfoutput query="ThisYear"><font size="-2">#Mission#</font></cfoutput>
	</td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	<!--- 
		*******************************************************************
			Goals
		*******************************************************************
	--->
	<cfoutput>
	<cfStoredProc datasource="PAPProd" Procedure="GetGoals">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@AgencyNo" value="#url.AgencyNo#">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@FY" Value="#url.ReportCFY#">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@ProgramId" Value="#url.ReportProgramId#">		
		<cfprocparam type="in" cfsqltype="cf_sql_tinyint" dbvarname="@DeletionInd" Value="0">
		<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetGoalsRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetGoalsRetMsg">
		<cfprocresult name="ThisYearGoals">
	</cfstoredproc>
	</cfoutput>
	<table width="95%" bgcolor="White" cellspacing="0" cellpadding="0" border="0" frame="box">
	<tr><th colspan="3" align="left"><b><font size="-2">Program Goals:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Objectives:</font></b></th></tr>
	<cfloop query="ThisYearGoals">
	<cfoutput>
	<tr><td valign="Top" width="10%"><font size="-2">#GoalNo#</font></td><td colspan="2" valign="top"><font size="-2">#Goals#</font></td></tr>
	</cfoutput>	
	<!--- 
		*******************************************************************
			Pull off Objectives for this goal 
		*******************************************************************
	---> 
	<cfoutput>
	<cfStoredProc datasource="PAPProd" Procedure="GetObjectives">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@AgencyNo" value="#url.AgencyNo#">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@FY" Value="#url.ReportCFY#">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@ProgramId" Value="#url.ReportProgramId#">		
		<cfprocparam type="in" cfsqltype="cf_sql_integer" dbvarname="@GoalId" Value="#ThisYearGoals.GoalId#">		
		<cfprocparam type="in" cfsqltype="cf_sql_tinyint" dbvarname="@DeletionInd" Value="0">
		<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetObjectivesRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetObjectivesRetMsg">
		<cfprocresult name="ThisYearObjectives">
	</cfstoredproc>
	</cfoutput>

	<cfloop query="ThisYearObjectives"><cfoutput>
	<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td valign="top"><font size="-2">#ObjectiveNo#</font></td><td><font size="-2">#Objective#</font></td></tr>
	</cfoutput>
	</cfloop>
	</cfloop>
	<tr><td colspan="3">&nbsp;</td></tr>
	</table>
	<!--- 
		*******************************************************************
			Funds and Statutory and Administrative Rule
		*******************************************************************
	--->
	<cfoutput>
	<cfStoredProc datasource="PAPProd" Procedure="GetFundNum">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@AgencyNo" value="#url.AgencyNo#">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@FY" Value="#url.ReportCFY#">
		<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@ProgramId" Value="#url.ReportProgramId#">
		<cfprocparam type="in" cfsqltype="cf_sql_tinyint" dbvarname="@DeletionInd" Value="0">
		<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFundNumRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFundNumRetMsg">
		<cfprocresult name="ThisYearFund">
	</cfstoredproc>
	</cfoutput>

	<cfset tmpFund = "">
	<cfloop query="ThisYearFund">
		<cfif (Fund_Name is not "") and (tmpFund is not "")>
			<cfset tmpFund = tmpFund & ", " & #Fund_Name#>
		<cfelseif (Fund_Name is not "") and (tmpFund is "")>
			<cfset tmpFund = #Fund_Name#>
		</cfif>
	</cfloop>
	<table width="95%" bgcolor="White" cellspacing="0" cellpadding="0" border="0" frame="box">
	
	<tr><td align="left"><cfoutput><cfif tmpFund is not ""><b><font size="-2">Funds: #tmpFund#</font></b></cfif></cfoutput></td><td>&nbsp;</td><td align="left"><b><font size="-2"><cfoutput query="ThisYear"><cfif Statutory_Code is not "">Statutory Authority: #Statutory_Code#</cfif></cfoutput></font></b></td></tr>
		
	</table>
	
	<hr color="Black" width="95%" align="left" noshade>
	<!---
		*******************************************************************
			This is Report Performance Measure Headings
		*******************************************************************
	--->
	<table width="95%" bgcolor="White" cellspacing="0" cellpadding="0" border="0" frame="box">
	<tr><th align="left" width="20%">&nbsp;</th><th width="5%" align="right" valign="top">&nbsp;</th><th width="10%" align="right" valign="Top"><b><font size="-2">Fiscal Year<br><u><cfoutput>#url.ReportPFY2#</cfoutput> Actual</font></u><br><br></b></th><th width="10%" align="right" valign="Top" colspan="2"><b><font size="-2">Fiscal Year<br><u><cfoutput>#url.ReportPFY#</cfoutput> Actual</font></u><br><br></b></th><th width="10%" align="right" valign="Top" colspan="2"><b><font size="-2">Fiscal Year<br><u><cfoutput>#url.ReportCFY#</cfoutput> Target<br>/Projected <cfoutput><cfif ThisYear.TargetHeadingFootnote is not "">(#ThisYear.TargetHeadingFootnote#)</cfif></cfoutput></font></u><br><br></b></th><th width="10%" align="right" valign="Top" colspan="2"><b><font size="-2">Fiscal Year<br><u><cfoutput>#url.ReportCFY#</cfoutput> Actual <cfoutput><cfif ThisYear.ActualHeadingFootnote is not "">(#ThisYear.ActualHeadingFootnote#)</cfif></cfoutput></font></u><br><br></b></th><th width="10%" align="right" valign="Top" colspan="2"><b><font size="-2">Fiscal Year<br><u><cfoutput>#url.ReportNFY#</cfoutput> Target<br>/Projected <cfoutput><cfif ThisYear.NextYrHeadingFootnote is not "">(#ThisYear.NextYrHeadingFootnote#)</cfif></cfoutput></font></u><br><br></b></th></tr>
	<!--- 
		*******************************************************************
			Input Indicators 
		*******************************************************************		
	--->	
	<cfloop query="ThisYear">
		<cfoutput>
		<cfStoredProc datasource="PAPProd" Procedure="InputIndRpt">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Agency" value="#url.AgencyNo#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Year" value="#url.ReportCFY#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="ProgramId" value="#url.ReportProgramId#">
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="InputIndRptRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="InputIndRptRetMsg">
			<cfprocresult name="InputIndResult">
		</cfstoredproc>
		</cfoutput>
	</cfloop>	
	<cfif InputIndResult.recordcount>
		<tr><td align="left" colspan="12"><b><br><u><font size="-2">Input Indicators</font></u></b></td></tr>
	</cfif>	
	<cfoutput query="InputIndResult">
		<cfif ((PY2Actual is not 0 or PYActual is not 0 or Target is not 0 or Actual is not 0 or NextYrTarget is not 0) and (IndicatorName is "Total expenditures - all sources" or IndicatorName is "Total expenditures - state appropriated funds" or IndicatorName is "Average monthly full-time employees" or IndicatorName is "Average monthly part-time employees" or IndicatorName is "Average monthly contract employees")) or (IndicatorName is not "Total expenditures - all sources" and IndicatorName is not "Total expenditures - state appropriated funds" and IndicatorName is not "Average monthly full-time employees" and IndicatorName is not "Average monthly part-time employees" and IndicatorName is not "Average monthly contract employees")>
		<tr>
		<td width="15%" align="left" valign="Top"><img src="/iwgraph/greenBullet.gif" width=8 height=8 border=0 valign="middle" alt="#IndicatorName#"><font size="-2">#IndicatorName# <cfif PY2ActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Thousands" or TargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Thousands"> (in thousands)<cfelseif PY2ActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Millions" or ActualNumberType is "$ in Millions" or TargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Millions"> (in millions)<cfelseif PY2ActualNumberType is "$ in Billions" or PYActualNumberType is "$ in Billions" or ActualNumberType is "$ in Billions" or TargetNumberType is "$ in Billions" or NextYrTargetNumberType is "$ in Billions"> (in billions)<cfelseif PY2ActualNumberType is "Dollars/Cents" or PYActualNumberType is "Dollars/Cents" or ActualNumberType is "Dollars/Cents" or TargetNumberType is "Dollars/Cents" or NextYrTargetNumberType is "Dollars/Cents"> (in dollars)</cfif> <cfif IndicatorFootNoteId is not ""> (#IndicatorFootNoteId#)</cfif></font></td>
		<td width="5%" align="right" valign="Top">&nbsp;</td>
		<!--- PFY2 --->
		<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PY2ActualNumberType is "N/A">N/A<cfelseif PY2ActualNumberType is "Yes">Yes<cfelseif PY2ActualNumberType is "No">No<cfelseif PY2ActualNumberType is "$ in Thousands" or PY2ActualNumberType is "$ in Millions" or PY2ActualNumberType is "$ in Billions"><cfif PY2Actual eq 0>0<cfelse>#NumberFormat(PY2Actual,"$__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Number2"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Dollars/Cents"><cfif PY2Actual is 0>0<cfelseif PY2Actual gt 1>#NumberFormat(PY2Actual,"$__,___,___.__")#<cfelse>#NumberFormat(PY2Actual,"$0.__")#</cfif><cfelseif PY2ActualNumberType is "Number" and PY2Actual ge 1000.00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif PY2ActualNumberType is "Number" and PY2Actual LT 1000.00><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"___,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Percent"><cfif PY2Actual is 0>0<cfelseif right(PY2Actual,2) eq 00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif right(PY2Actual,1) eq 0>#NumberFormat(PY2Actual,"___,___,___._")#<cfelse>#NumberFormat(PY2Actual,"___,___,___.__")#</cfif><cfelseif PY2Actual is 0>0<cfelse>#PY2Actual#</cfif></font></td>
		<td width="5%" align="Left" valign="Top"><cfif PY2ActualNumberType is "Percent"><font size="-2">%</cfif></td>
		<!--- PFY --->
		<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PYActualNumberType is "N/A">N/A<cfelseif PYActualNumberType is "Yes">Yes<cfelseif PYActualNumberType is "No">No<cfelseif PYActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Billions"><cfif PYActual eq 0>0<cfelse>#NumberFormat(PYActual,"$__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Number2"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"__,___,___._")#</cfif><cfelseif PYActualNumberType is "Dollars/Cents"><cfif PYActual is 0>0<cfelseif PYActual gt 1>#NumberFormat(PYActual,"$__,___,___.__")#<cfelse>#NumberFormat(PYActual,"$0.__")#</cfif><cfelseif PYActualNumberType is "Number" and PYActual ge 1000.00>#NumberFormat(PYActual,"___,___,___")#<cfelseif PYActualNumberType is "Number" and PYActual LT 1000.00><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"___,___,___._")#</cfif><cfelseif PYActualNumberType is "Percent"><cfif PYActual is 0>0<cfelseif right(PYActual,2) eq 00>#NumberFormat(PYActual,"___,___,___")#<cfelseif right(PYActual,1) eq 0>#NumberFormat(PYActual,"___,___,___._")#<cfelse>#NumberFormat(PYActual,"___,___,___.__")#</cfif><cfelseif PYActual is 0>0<cfelse>#PYActual#</cfif></font></td>
		<td width="5%" align="Left" valign="Top"><cfif PYActualNumberType is "Percent"><font size="-2">%</cfif></td>
		<!--- CFY --->
		<td width="10%" align="Right" valign="Top"><font size="-2"><cfif TargetNumberType is "N/A">N/A<cfelseif TargetNumberType is "Yes">Yes<cfelseif TargetNumberType is "No">No<cfelseif TargetNumberType is "$ in Thousands" or TargetNumberType is "$ in Millions" or TargetNumberType is "$ in Billions"><cfif Target eq 0>0<cfelse>#NumberFormat(Target,"$__,___,___._")#</cfif><cfelseif TargetNumberType is "Number2"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"__,___,___._")#</cfif><cfelseif TargetNumberType is "Dollars/Cents"><cfif Target is 0>0<cfelseif Target gt 1>#NumberFormat(Target,"$__,___,___.__")#<cfelse>#NumberFormat(Target,"$0.__")#</cfif><cfelseif TargetNumberType is "Number" and Target ge 1000.00>#NumberFormat(Target,"___,___,___")#<cfelseif TargetNumberType is "Number" and Target LT 1000.00><cfif Target is 0>0<cfelse>#NumberFormat(Target,"___,___,___._")#</cfif><cfelseif TargetNumberType is "Percent"><cfif Target is 0>0<cfelseif right(Target,2) eq 00>#NumberFormat(Target,"___,___,___")#<cfelseif right(Target,1) eq 0>#NumberFormat(Target,"___,___,___._")#<cfelse>#NumberFormat(Target,"___,___,___.__")#</cfif><cfelseif Target is 0>0<cfelse>#Target#</cfif></font></td>
		<td width="5%" align="Left" valign="Top"><cfif TargetNumberType is "Percent"><font size="-2">%</font></cfif></td>
		<td width="10%" align="Right" valign="Top"><font size="-2"><cfif ActualNumberType is "N/A">N/A<cfelseif ActualNumberType is "Yes">Yes<cfelseif ActualNumberType is "No">No<cfelseif ActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Millions" or ActualNumberType is "$ in Billions"><cfif Actual eq 0>0<cfelse>#NumberFormat(Actual,"$__,___,___._")#</cfif><cfelseif ActualNumberType is "Number2"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"__,___,___._")#</cfif><cfelseif ActualNumberType is "Dollars/Cents"><cfif Actual is 0>0<cfelseif Actual gt 1>#NumberFormat(Actual,"$__,___,___.__")#<cfelse>#NumberFormat(Actual,"$0.__")#</cfif><cfelseif ActualNumberType is "Number" and Actual ge 1000.00>#NumberFormat(Actual,"___,___,___")#<cfelseif ActualNumberType is "Number" and Actual LT 1000.00><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"___,___,___._")#</cfif><cfelseif ActualNumberType is "Percent"><cfif Actual is 0>0<cfelseif right(Actual,2) eq 00>#NumberFormat(Actual,"___,___,___")#<cfelseif right(Actual,1) eq 0>#NumberFormat(Actual,"___,___,___._")#<cfelse>#NumberFormat(Actual,"___,___,___.__")#</cfif><cfelseif Actual is 0>0<cfelse>#Actual#</cfif></font></td>
		<td width="5%" align="Left" valign="Top"><cfif ActualNumberType is "Percent"><font size="-2">%</font></cfif></td>
		<td width="10%" align="Right" valign="Top"><font size="-2"><cfif NextYrTargetNumberType is "N/A">N/A<cfelseif NextYrTargetNumberType is "Yes">Yes<cfelseif NextYrTargetNumberType is "No">No<cfelseif NextYrTargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Billions"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"$__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Number2"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Dollars/Cents"><cfif NextYrTarget is 0>0<cfelseif NextYrTarget gt 1>#NumberFormat(NextYrTarget,"$__,___,___.__")#<cfelse>#NumberFormat(NextYrTarget,"$0.__")#</cfif><cfelseif NextYrTargetNumberType is "Number" and NextYrTarget ge 1000.00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif NextYrTargetNumberType is "Number" and NextYrTarget LT 1000.00><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"___,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Percent"><cfif NextYrTarget is 0>0<cfelseif right(NextYrTarget,2) eq 00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif right(NextYrTarget,1) eq 0>#NumberFormat(NextYrTarget,"___,___,___._")#<cfelse>#NumberFormat(NextYrTarget,"___,___,___.__")#</cfif><cfelseif NextYrTarget is 0>0<cfelse>#NextYrTarget#</cfif></font></td>
		<td width="5%" align="Left" valign="Top"><cfif NextYrTargetNumberType is "Percent"><font size="-2">%</font></cfif></td>
		</tr>
		</cfif>
	</cfoutput>
	
	<!--- 
		*******************************************************************
			Output Indicators 
		*******************************************************************
	--->
	<cfloop query="ThisYear">
		<cfoutput>
		<cfStoredProc datasource="PAPProd" Procedure="OutputIndRpt">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Agency" value="#url.AgencyNo#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Year" value="#url.ReportCFY#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="ProgramId" value="#url.ReportProgramId#">
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="OutputIndRptRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="OutputIndRptRetMsg">
			<cfprocresult name="OutputIndResult">
		</cfstoredproc>
		</cfoutput>
	</cfloop>	
	<cfif OutputIndResult.recordcount>
		<tr><td align="left" colspan="12"><b><br><u><font size="-2">Output Indicators</font></u></b></td></tr>
	</cfif>
	<cfoutput query="OutputIndResult">
	<tr>
	<td width="15%" align="left" valign="Top"><img src="/iwgraph/greenBullet.gif" width=8 height=8 border=0 valign="middle" alt="#IndicatorName#"><font size="-2">#IndicatorName# <cfif PY2ActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Thousands" or TargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Thousands"> (in thousands)<cfelseif PY2ActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Millions" or ActualNumberType is "$ in Millions" or TargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Millions"> (in millions)<cfelseif PY2ActualNumberType is "$ in Billions" or PYActualNumberType is "$ in Billions" or ActualNumberType is "$ in Billions" or TargetNumberType is "$ in Billions" or NextYrTargetNumberType is "$ in Billions"> (in billions)<cfelseif PY2ActualNumberType is "Dollars/Cents" or PYActualNumberType is "Dollars/Cents" or ActualNumberType is "Dollars/Cents" or TargetNumberType is "Dollars/Cents" or NextYrTargetNumberType is "Dollars/Cents"> (in dollars)</cfif> <cfif IndicatorFootNoteId is not ""> (#IndicatorFootNoteId#)</cfif></font></td>
	<td width="5%" align="right" valign="Top">&nbsp;</td>
	<!--- PFY2 --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PY2ActualNumberType is "N/A">N/A<cfelseif PY2ActualNumberType is "Yes">Yes<cfelseif PY2ActualNumberType is "No">No<cfelseif PY2ActualNumberType is "$ in Thousands" or PY2ActualNumberType is "$ in Millions" or PY2ActualNumberType is "$ in Billions"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"$__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Number2"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Dollars/Cents"><cfif PY2Actual is 0>0<cfelseif PY2Actual gt 1>#NumberFormat(PY2Actual,"$__,___,___.__")#<cfelse>#NumberFormat(PY2Actual,"$0.__")#</cfif><cfelseif PY2ActualNumberType is "Number" and PY2Actual ge 1000.00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif PY2ActualNumberType is "Number" and PY2Actual LT 1000.00><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"___,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Percent"><cfif PY2Actual is 0>0<cfelseif right(PY2Actual,2) eq 00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif right(PY2Actual,1) eq 0>#NumberFormat(PY2Actual,"___,___,___._")#<cfelse>#NumberFormat(PY2Actual,"___,___,___.__")#</cfif><cfelseif PY2Actual is 0>0<cfelse>#PY2Actual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif PY2ActualNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<!--- PFY --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PYActualNumberType is "N/A">N/A<cfelseif PYActualNumberType is "Yes">Yes<cfelseif PYActualNumberType is "No">No<cfelseif PYActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Billions"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"$__,___,___._")#</cfif><cfelseif PYActualNumberType is "Number2"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"__,___,___._")#</cfif><cfelseif PYActualNumberType is "Dollars/Cents"><cfif PYActual is 0>0<cfelseif PYActual gt 1>#NumberFormat(PYActual,"$__,___,___.__")#<cfelse>#NumberFormat(PYActual,"$0.__")#</cfif><cfelseif PYActualNumberType is "Number" and PYActual ge 1000.00>#NumberFormat(PYActual,"___,___,___")#<cfelseif PYActualNumberType is "Number" and PYActual LT 1000.00><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"___,___,___._")#</cfif><cfelseif PYActualNumberType is "Percent"><cfif PYActual is 0>0<cfelseif right(PYActual,2) eq 00>#NumberFormat(PYActual,"___,___,___")#<cfelseif right(PYActual,1) eq 0>#NumberFormat(PYActual,"___,___,___._")#<cfelse>#NumberFormat(PYActual,"___,___,___.__")#</cfif><cfelseif PYActual is 0>0<cfelse>#PYActual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif PYActualNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<!--- CFY --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif TargetNumberType is "N/A">N/A<cfelseif TargetNumberType is "Yes">Yes<cfelseif TargetNumberType is "No">No<cfelseif TargetNumberType is "$ in Thousands" or TargetNumberType is "$ in Millions" or TargetNumberType is "$ in Billions"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"$__,___,___._")#</cfif><cfelseif TargetNumberType is "Number2"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"__,___,___._")#</cfif><cfelseif TargetNumberType is "Dollars/Cents"><cfif Target is 0>0<cfelseif Target gt 1>#NumberFormat(Target,"$__,___,___.__")#<cfelse>#NumberFormat(Target,"$0.__")#</cfif><cfelseif TargetNumberType is "Number" and Target ge 1000.00>#NumberFormat(Target,"___,___,___")#<cfelseif TargetNumberType is "Number" and Target LT 1000.00><cfif Target is 0>0<cfelse>#NumberFormat(Target,"___,___,___._")#</cfif><cfelseif TargetNumberType is "Percent"><cfif Target is 0>0<cfelseif right(Target,2) eq 00>#NumberFormat(Target,"___,___,___")#<cfelseif right(Target,1) eq 0>#NumberFormat(Target,"___,___,___._")#<cfelse>#NumberFormat(Target,"___,___,___.__")#</cfif><cfelseif Target is 0>0<cfelse>#Target#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif TargetNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif ActualNumberType is "N/A">N/A<cfelseif ActualNumberType is "Yes">Yes<cfelseif ActualNumberType is "No">No<cfelseif ActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Millions" or ActualNumberType is "$ in Billions"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"$__,___,___._")#</cfif><cfelseif ActualNumberType is "Number2"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"__,___,___._")#</cfif><cfelseif ActualNumberType is "Dollars/Cents"><cfif Actual is 0>0<cfelseif Actual gt 1>#NumberFormat(Actual,"$__,___,___.__")#<cfelse>#NumberFormat(Actual,"$0.__")#</cfif><cfelseif ActualNumberType is "Number" and Actual ge 1000.00>#NumberFormat(Actual,"___,___,___")#<cfelseif ActualNumberType is "Number" and Actual LT 1000.00><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"___,___,___._")#</cfif><cfelseif ActualNumberType is "Percent"><cfif Actual is 0>0<cfelseif right(Actual,2) eq 00>#NumberFormat(Actual,"___,___,___")#<cfelseif right(Actual,1) eq 0>#NumberFormat(Actual,"___,___,___._")#<cfelse>#NumberFormat(Actual,"___,___,___.__")#</cfif><cfelseif Actual is 0>0<cfelse>#Actual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif ActualNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif NextYrTargetNumberType is "N/A">N/A<cfelseif NextYrTargetNumberType is "Yes">Yes<cfelseif NextYrTargetNumberType is "No">No<cfelseif NextYrTargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Billions"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"$__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Number2"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Dollars/Cents"><cfif NextYrTarget is 0>0<cfelseif NextYrTarget gt 1>#NumberFormat(NextYrTarget,"$__,___,___.__")#<cfelse>#NumberFormat(NextYrTarget,"$0.__")#</cfif><cfelseif NextYrTargetNumberType is "Number" and NextYrTarget ge 1000.00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif NextYrTargetNumberType is "Number" and NextYrTarget LT 1000.00><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"___,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Percent"><cfif NextYrTarget is 0>0<cfelseif right(NextYrTarget,2) eq 00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif right(NextYrTarget,1) eq 0>#NumberFormat(NextYrTarget,"___,___,___._")#<cfelse>#NumberFormat(NextYrTarget,"___,___,___.__")#</cfif><cfelseif NextYrTarget is 0>0<cfelse>#NextYrTarget#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif NextYrTargetNumberType is "Percent"><font size="-2">%</font></cfif></td>
	</tr>
	</cfoutput>
	
	<!--- 
		*******************************************************************
			Pull off Outcome Indicator Information for this SubFunction 
		*******************************************************************
	--->
	<cfloop query="ThisYear">
		<cfoutput>
		<cfStoredProc datasource="PAPProd" Procedure="OutcomeIndRpt">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Agency" value="#url.AgencyNo#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Year" value="#url.ReportCFY#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="ProgramId" value="#url.ReportProgramId#">
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="OutcomeIndRptRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="OutcomeIndRptRetMsg">
			<cfprocresult name="OutcomeIndResult">
		</cfstoredproc>
		</cfoutput>
	</cfloop>
	<cfif OutcomeIndResult.RecordCount>
		<tr><td colspan="12">&nbsp;</td></tr>
		<tr bgcolor="silver"><td align="left" colspan="12"><b><u><font size="-2">Outcome Indicators</font></u></b></td></tr>
	</cfif>
	<cfoutput query="OutcomeIndResult">
	<tr bgcolor="silver">
	<td width="15%" align="left" valign="Top"><img src="/iwgraph/greenBullet.gif" width=8 height=8 border=0 valign="middle" alt="#IndicatorName#"><font size="-2">#IndicatorName# <cfif PY2ActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Thousands" or TargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Thousands"> (in thousands)<cfelseif PY2ActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Millions" or ActualNumberType is "$ in Millions" or TargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Millions"> (in millions)<cfelseif PY2ActualNumberType is "$ in Billions" or PYActualNumberType is "$ in Billions" or ActualNumberType is "$ in Billions" or TargetNumberType is "$ in Billions" or NextYrTargetNumberType is "$ in Billions"> (in billions)<cfelseif PY2ActualNumberType is "Dollars/Cents" or PYActualNumberType is "Dollars/Cents" or ActualNumberType is "Dollars/Cents" or TargetNumberType is "Dollars/Cents" or NextYrTargetNumberType is "Dollars/Cents"> (in dollars)</cfif> <cfif IndicatorFootNoteId is not ""> (#IndicatorFootNoteId#)</cfif></font></td>
	<td width="5%" align="right" valign="Top">&nbsp;</td>
	<!--- PFY2 --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PY2ActualNumberType is "N/A">N/A<cfelseif PY2ActualNumberType is "Yes">Yes<cfelseif PY2ActualNumberType is "No">No<cfelseif PY2ActualNumberType is "$ in Thousands" or PY2ActualNumberType is "$ in Millions" or PY2ActualNumberType is "$ in Billions"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"$__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Number2"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Dollars/Cents"><cfif PY2Actual is 0>0<cfelseif PY2Actual ge 1>#NumberFormat(PY2Actual,"$__,___,___.__")#<cfelse>#NumberFormat(PY2Actual,"$0.__")#</cfif><cfelseif PY2ActualNumberType is "Number" and PY2Actual ge 1000.00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif PY2ActualNumberType is "Number" and PY2Actual LT 1000.00><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"___,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Percent"><cfif PY2Actual is 0>0<cfelseif right(PY2Actual,2) eq 00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif right(PY2Actual,1) eq 0>#NumberFormat(PY2Actual,"___,___,___._")#<cfelse>#NumberFormat(PY2Actual,"___,___,___.__")#</cfif><cfelseif PY2Actual is 0>0<cfelse>#PY2Actual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif PY2ActualNumberType is "Percent"><font size="-2">%</font><cfelse>&nbsp;</cfif></td>
	<!--- PFY --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PYActualNumberType is "N/A">N/A<cfelseif PYActualNumberType is "Yes">Yes<cfelseif PYActualNumberType is "No">No<cfelseif PYActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Billions"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"$__,___,___._")#</cfif><cfelseif PYActualNumberType is "Number2"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"__,___,___._")#</cfif><cfelseif PYActualNumberType is "Dollars/Cents"><cfif PYActual is 0>0<cfelseif PYActual ge 1>#NumberFormat(PYActual,"$__,___,___.__")#<cfelse>#NumberFormat(PYActual,"$0.__")#</cfif><cfelseif PYActualNumberType is "Number" and PYActual ge 1000.00>#NumberFormat(PYActual,"___,___,___")#<cfelseif PYActualNumberType is "Number" and PYActual LT 1000.00><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"___,___,___._")#</cfif><cfelseif PYActualNumberType is "Percent"><cfif PYActual is 0>0<cfelseif right(PYActual,2) eq 00>#NumberFormat(PYActual,"___,___,___")#<cfelseif right(PYActual,1) eq 0>#NumberFormat(PYActual,"___,___,___._")#<cfelse>#NumberFormat(PYActual,"___,___,___.__")#</cfif><cfelseif PYActual is 0>0<cfelse>#PYActual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif OutcomeIndResult.PYActualNumberType is "Percent"><font size="-2">%</font><cfelse>&nbsp;</cfif></td>
	<!--- CFY --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif TargetNumberType is "N/A">N/A<cfelseif TargetNumberType is "Yes">Yes<cfelseif TargetNumberType is "No">No<cfelseif TargetNumberType is "$ in Thousands" or TargetNumberType is "$ in Millions" or TargetNumberType is "$ in Billions"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"$__,___,___._")#</cfif><cfelseif TargetNumberType is "Number2"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"__,___,___._")#</cfif><cfelseif TargetNumberType is "Dollars/Cents"><cfif Target is 0>0<cfelseif Target ge 1>#NumberFormat(Target,"$__,___,___.__")#<cfelse>#NumberFormat(Target,"$0.__")#</cfif><cfelseif TargetNumberType is "Number" and Target ge 1000.00>#NumberFormat(Target,"___,___,___")#<cfelseif TargetNumberType is "Number" and Target LT 1000.00><cfif Target is 0>0<cfelse>#NumberFormat(Target,"___,___,___._")#</cfif><cfelseif TargetNumberType is "Percent"><cfif Target is 0>0<cfelseif right(Target,2) eq 00>#NumberFormat(Target,"___,___,___")#<cfelseif right(Target,1) eq 0>#NumberFormat(Target,"___,___,___._")#<cfelse>#NumberFormat(Target,"___,___,___.__")#</cfif><cfelseif Target is 0>0<cfelse>#Target#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif TargetNumberType is "Percent"><font size="-2">%</font><cfelse>&nbsp;</cfif></td>
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif ActualNumberType is "N/A">N/A<cfelseif ActualNumberType is "Yes">Yes<cfelseif ActualNumberType is "No">No<cfelseif ActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Millions" or ActualNumberType is "$ in Billions"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"$__,___,___._")#</cfif><cfelseif ActualNumberType is "Number2"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"__,___,___._")#</cfif><cfelseif ActualNumberType is "Dollars/Cents"><cfif Actual is 0>0<cfelseif Actual ge 1>#NumberFormat(Actual,"$__,___,___.__")#<cfelse>#NumberFormat(Actual,"$0.__")#</cfif><cfelseif ActualNumberType is "Number" and Actual ge 1000.00>#NumberFormat(Actual,"___,___,___")#<cfelseif ActualNumberType is "Number" and Actual LT 1000.00><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"___,___,___._")#</cfif><cfelseif ActualNumberType is "Percent"><cfif Actual is 0>0<cfelseif right(Actual,2) eq 00>#NumberFormat(Actual,"___,___,___")#<cfelseif right(Actual,1) eq 0>#NumberFormat(Actual,"___,___,___._")#<cfelse>#NumberFormat(Actual,"___,___,___.__")#</cfif><cfelseif Actual is 0>0<cfelse>#Actual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif ActualNumberType is "Percent"><font size="-2">%</font><cfelse>&nbsp;</cfif></td>
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif NextYrTargetNumberType is "N/A">N/A<cfelseif NextYrTargetNumberType is "Yes">Yes<cfelseif NextYrTargetNumberType is "No">No<cfelseif NextYrTargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Billions"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"$__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Number2"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Dollars/Cents"><cfif NextYrTarget is 0>0<cfelseif NextYrTarget ge 1>#NumberFormat(NextYrTarget,"$__,___,___.__")#<cfelse>#NumberFormat(NextYrTarget,"$0.__")#</cfif><cfelseif NextYrTargetNumberType is "Number" and NextYrTarget ge 1000.00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif NextYrTargetNumberType is "Number" and NextYrTarget LT 1000.00><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"___,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Percent"><cfif NextYrTarget is 0>0<cfelseif right(NextYrTarget,2) eq 00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif right(NextYrTarget,1) eq 0>#NumberFormat(NextYrTarget,"___,___,___._")#<cfelse>#NumberFormat(NextYrTarget,"___,___,___.__")#</cfif><cfelseif NextYrTarget is 0>0<cfelse>#NextYrTarget#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif NextYrTargetNumberType is "Percent"><font size="-2">%</font><cfelse>&nbsp;</cfif></td>
	</tr>
	</cfoutput> 
	<!--- 
		*******************************************************************
			Outcome Indicator External Benchmarks 
		*******************************************************************
	--->
	<cfloop query="ThisYear">
		<cfoutput>
		<cfStoredProc datasource="PAPProd" Procedure="OutcBnchMrkRPt">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Agency" value="#url.AgencyNo#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Year" value="#url.ReportCFY#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="ProgramId" value="#url.ReportProgramId#">
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="OutcoBnchMrkRptRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="OutcBnchMrkRptRetMsg">
			<cfprocresult name="OutcomeBnchMrkResult">
		</cfstoredproc>
		</cfoutput>
	</cfloop>	
	<cfif OutcomeBnchMrkResult.recordcount>
		<tr><td align="left" colspan="12"><b><br><u><font size="-2">External Benchmarks</font></u></b></td></tr>
	</cfif>	
	<cfoutput query="OutcomeBnchMrkResult">	
	<tr>
	<td width="15%" align="left" valign="Top"><img src="/iwgraph/greenBullet.gif" width=8 height=8 border=0 valign="middle" alt="#IndicatorName#"><font size="-2">#IndicatorName# <cfif PY2ActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Thousands" or TargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Thousands"> (in thousands)<cfelseif PY2ActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Millions" or ActualNumberType is "$ in Millions" or TargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Millions"> (in millions)<cfelseif PY2ActualNumberType is "$ in Billions" or PYActualNumberType is "$ in Billions" or ActualNumberType is "$ in Billions" or TargetNumberType is "$ in Billions" or NextYrTargetNumberType is "$ in Billions"> (in billions)<cfelseif PY2ActualNumberType is "Dollars/Cents" or PYActualNumberType is "Dollars/Cents" or ActualNumberType is "Dollars/Cents" or TargetNumberType is "Dollars/Cents" or NextYrTargetNumberType is "Dollars/Cents"> (in dollars)</cfif> <cfif IndicatorFootNoteId is not ""> (#IndicatorFootNoteId#)</cfif></font></td>
	<td width="5%" align="right" valign="Top">&nbsp;</td>
	<!--- PFY2 --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PY2ActualNumberType is "N/A">N/A<cfelseif PY2ActualNumberType is "Yes">Yes<cfelseif PY2ActualNumberType is "No">No<cfelseif PY2ActualNumberType is "$ in Thousands" or PY2ActualNumberType is "$ in Millions" or PY2ActualNumberType is "$ in Billions"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"$__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Number2"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Dollars/Cents"><cfif PY2Actual is 0>0<cfelseif PY2Actual ge 1>#NumberFormat(PY2Actual,"$__,___,___.__")#<cfelse>#NumberFormat(PY2Actual,"$0.__")#</cfif><cfelseif PY2ActualNumberType is "Number" and PY2Actual ge 1000.00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif PY2ActualNumberType is "Number" and PY2Actual LT 1000.00><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"___,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Percent"><cfif PY2Actual is 0>0<cfelseif right(PY2Actual,2) eq 00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif right(PY2Actual,1) eq 0>#NumberFormat(PY2Actual,"___,___,___._")#<cfelse>#NumberFormat(PY2Actual,"___,___,___.__")#</cfif><cfelseif PY2Actual is 0>0<cfelse>#PY2Actual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif PY2ActualNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<!--- PFY --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PYActualNumberType is "N/A">N/A<cfelseif PYActualNumberType is "Yes">Yes<cfelseif PYActualNumberType is "No">No<cfelseif PYActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Billions"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"$__,___,___._")#</cfif><cfelseif PYActualNumberType is "Number2"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"__,___,___._")#</cfif><cfelseif PYActualNumberType is "Dollars/Cents"><cfif PYActual is 0>0<cfelseif PYActual ge 1>#NumberFormat(PYActual,"$__,___,___.__")#<cfelse>#NumberFormat(PYActual,"$0.__")#</cfif><cfelseif PYActualNumberType is "Number" and PYActual ge 1000.00>#NumberFormat(PYActual,"___,___,___")#<cfelseif PYActualNumberType is "Number" and PYActual LT 1000.00><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"___,___,___._")#</cfif><cfelseif PYActualNumberType is "Percent"><cfif PYActual is 0>0<cfelseif right(PYActual,2) eq 00>#NumberFormat(PYActual,"___,___,___")#<cfelseif right(PYActual,1) eq 0>#NumberFormat(PYActual,"___,___,___._")#<cfelse>#NumberFormat(PYActual,"___,___,___.__")#</cfif><cfelseif PYActual is 0>0<cfelse>#PYActual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif PYActualNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<!--- CFY --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif TargetNumberType is "N/A">N/A<cfelseif TargetNumberType is "Yes">Yes<cfelseif TargetNumberType is "No">No<cfelseif TargetNumberType is "$ in Thousands" or TargetNumberType is "$ in Millions" or TargetNumberType is "$ in Billions"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"$__,___,___._")#</cfif><cfelseif TargetNumberType is "Number2"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"__,___,___._")#</cfif><cfelseif TargetNumberType is "Dollars/Cents"><cfif Target is 0>0<cfelseif Target ge 1>#NumberFormat(Target,"$__,___,___.__")#<cfelse>#NumberFormat(Target,"$0.__")#</cfif><cfelseif TargetNumberType is "Number" and Target ge 1000.00>#NumberFormat(Target,"___,___,___")#<cfelseif TargetNumberType is "Number" and Target LT 1000.00><cfif Target is 0>0<cfelse>#NumberFormat(Target,"___,___,___._")#</cfif><cfelseif TargetNumberType is "Percent"><cfif Target is 0>0<cfelseif right(Target,2) eq 00>#NumberFormat(Target,"___,___,___")#<cfelseif right(Target,1) eq 0>#NumberFormat(Target,"___,___,___._")#<cfelse>#NumberFormat(Target,"___,___,___.__")#</cfif><cfelseif Target is 0>0<cfelse>#Target#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif TargetNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif ActualNumberType is "N/A">N/A<cfelseif ActualNumberType is "Yes">Yes<cfelseif ActualNumberType is "No">No<cfelseif ActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Millions" or ActualNumberType is "$ in Billions"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"$__,___,___._")#</cfif><cfelseif ActualNumberType is "Number2"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"__,___,___._")#</cfif><cfelseif ActualNumberType is "Dollars/Cents"><cfif Actual is 0>0<cfelseif Actual ge 1>#NumberFormat(Actual,"$__,___,___.__")#<cfelse>#NumberFormat(Actual,"$0.__")#</cfif><cfelseif ActualNumberType is "Number" and Actual ge 1000.00>#NumberFormat(Actual,"___,___,___")#<cfelseif ActualNumberType is "Number" and Actual LT 1000.00><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"___,___,___._")#</cfif><cfelseif ActualNumberType is "Percent"><cfif Actual is 0>0<cfelseif right(Actual,2) eq 00>#NumberFormat(Actual,"___,___,___")#<cfelseif right(Actual,1) eq 0>#NumberFormat(Actual,"___,___,___._")#<cfelse>#NumberFormat(Actual,"___,___,___.__")#</cfif><cfelseif Actual is 0>0<cfelse>#Actual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif ActualNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif NextYrTargetNumberType is "N/A">N/A<cfelseif NextYrTargetNumberType is "Yes">Yes<cfelseif NextYrTargetNumberType is "No">No<cfelseif NextYrTargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Billions"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"$__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Number2"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Dollars/Cents"><cfif NextYrTarget is 0>0<cfelseif NextYrTarget ge 1>#NumberFormat(NextYrTarget,"$__,___,___.__")#<cfelse>#NumberFormat(NextYrTarget,"$0.__")#</cfif><cfelseif NextYrTargetNumberType is "Number" and NextYrTarget ge 1000.00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif NextYrTargetNumberType is "Number" and NextYrTarget LT 1000.00><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"___,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Percent"><cfif NextYrTarget is 0>0<cfelseif right(NextYrTarget,2) eq 00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif right(NextYrTarget,1) eq 0>#NumberFormat(NextYrTarget,"___,___,___._")#<cfelse>#NumberFormat(NextYrTarget,"___,___,___.__")#</cfif><cfelseif NextYrTarget is 0>0<cfelse>#NextYrTarget#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif NextYrTargetNumberType is "Percent"><font size="-2">%</font></cfif></td>
	</tr>
	</cfoutput>

	<!--- 
		*******************************************************************
			Efficiency Indicators 
		*******************************************************************
	--->
	<cfloop query="ThisYear">
		<cfoutput>
		<cfStoredProc datasource="PAPProd" Procedure="EfficiencyIndRpt">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Agency" value="#url.AgencyNo#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Year" value="#url.ReportCFY#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="ProgramId" value="#url.ReportProgramId#">
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="EfficiencyIndRptRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="EfficiencyIndRptRetMsg">		
			<cfprocresult name="EfficIndResult">
		</cfstoredproc>
		</cfoutput>
	</cfloop>	
	<cfif EfficIndResult.recordcount>
	<tr><td align="left" colspan="12"><b><br><u><font size="-2">Efficiency/Cost-Effectiveness</font></u></b></td></tr>
	</cfif>	
	<cfoutput query="EfficIndResult">	
	<tr>
	<td width="15%" align="left" valign="Top"><img src="/iwgraph/greenBullet.gif" width=8 height=8 border=0 valign="middle" alt="#IndicatorName#"><font size="-2">#IndicatorName# <cfif PY2ActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Thousands" or TargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Thousands"> (in thousands)<cfelseif PY2ActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Millions" or ActualNumberType is "$ in Millions" or TargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Millions"> (in millions)<cfelseif PY2ActualNumberType is "$ in Billions" or PYActualNumberType is "$ in Billions" or ActualNumberType is "$ in Billions" or TargetNumberType is "$ in Billions" or NextYrTargetNumberType is "$ in Billions"> (in billions)<cfelseif PY2ActualNumberType is "Dollars/Cents" or PYActualNumberType is "Dollars/Cents" or ActualNumberType is "Dollars/Cents" or TargetNumberType is "Dollars/Cents" or NextYrTargetNumberType is "Dollars/Cents"> (in dollars)</cfif> <cfif IndicatorFootNoteId is not ""> (#IndicatorFootNoteId#)</cfif></font></td>
	<td width="5%" align="right" valign="Top">&nbsp;</td>
	<!--- PFY2 --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PY2ActualNumberType is "N/A">N/A<cfelseif PY2ActualNumberType is "Yes">Yes<cfelseif PY2ActualNumberType is "No">No<cfelseif PY2ActualNumberType is "$ in Thousands" or PY2ActualNumberType is "$ in Millions" or PY2ActualNumberType is "$ in Billions"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"$__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Number2"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Dollars/Cents"><cfif PY2Actual is 0>0<cfelseif PY2Actual gt 1>#NumberFormat(PY2Actual,"$__,___,___.__")#<cfelse>#NumberFormat(PY2Actual,"$0.__")#</cfif><cfelseif PY2ActualNumberType is "Number" and PY2Actual ge 1000.00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif PY2ActualNumberType is "Number" and PY2Actual LT 1000.00><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"___,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Percent"><cfif PY2Actual is 0>0<cfelseif right(PY2Actual,2) eq 00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif right(PY2Actual,1) eq 0>#NumberFormat(PY2Actual,"___,___,___._")#<cfelse>#NumberFormat(PY2Actual,"___,___,___.__")#</cfif><cfelseif PY2Actual is 0>0<cfelse>#PY2Actual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif PY2ActualNumberType is "Percent"><font size="-2">%</cfif></td>
	<!--- PFY --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PYActualNumberType is "N/A">N/A<cfelseif PYActualNumberType is "Yes">Yes<cfelseif PYActualNumberType is "No">No<cfelseif PYActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Billions"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"$__,___,___._")#</cfif><cfelseif PYActualNumberType is "Number2"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"__,___,___._")#</cfif><cfelseif PYActualNumberType is "Dollars/Cents"><cfif PYActual is 0>0<cfelseif PYActual>#NumberFormat(PYActual,"$__,___,___.__")#<cfelse>#NumberFormat(PYActual,"$0.__")#</cfif><cfelseif PYActualNumberType is "Number" and PYActual ge 1000.00>#NumberFormat(PYActual,"___,___,___")#<cfelseif PYActualNumberType is "Number" and PYActual LT 1000.00><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"___,___,___._")#</cfif><cfelseif PYActualNumberType is "Percent"><cfif PYActual is 0>0<cfelseif right(PYActual,2) eq 00>#NumberFormat(PYActual,"___,___,___")#<cfelseif right(PYActual,1) eq 0>#NumberFormat(PYActual,"___,___,___._")#<cfelse>#NumberFormat(PYActual,"___,___,___.__")#</cfif><cfelseif PYActual is 0>0<cfelse>#PYActual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif PYActualNumberType is "Percent"><font size="-2">%</cfif></td>
	<!--- CFY --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif TargetNumberType is "N/A">N/A<cfelseif TargetNumberType is "Yes">Yes<cfelseif TargetNumberType is "No">No<cfelseif TargetNumberType is "$ in Thousands" or TargetNumberType is "$ in Millions" or TargetNumberType is "$ in Billions"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"$__,___,___._")#</cfif><cfelseif TargetNumberType is "Number2"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"__,___,___._")#</cfif><cfelseif TargetNumberType is "Dollars/Cents"><cfif Target is 0>0<cfelseif Target gt 1>#NumberFormat(Target,"$__,___,___.__")#<cfelse>#NumberFormat(Target,"$0.__")#</cfif><cfelseif TargetNumberType is "Number" and Target ge 1000.00>#NumberFormat(Target,"___,___,___")#<cfelseif TargetNumberType is "Number" and Target LT 1000.00><cfif Target is 0>0<cfelse>#NumberFormat(Target,"___,___,___._")#</cfif><cfelseif TargetNumberType is "Percent"><cfif Target is 0>0<cfelseif right(Target,2) eq 00>#NumberFormat(Target,"___,___,___")#<cfelseif right(Target,1) eq 0>#NumberFormat(Target,"___,___,___._")#<cfelse>#NumberFormat(Target,"___,___,___.__")#</cfif><cfelseif Target is 0>0<cfelse>#Target#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif TargetNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif ActualNumberType is "N/A">N/A<cfelseif ActualNumberType is "Yes">Yes<cfelseif ActualNumberType is "No">No<cfelseif ActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Millions" or ActualNumberType is "$ in Billions"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"$__,___,___._")#</cfif><cfelseif ActualNumberType is "Number2"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"__,___,___._")#</cfif><cfelseif ActualNumberType is "Dollars/Cents"><cfif Actual is 0>0<cfelseif Actual gt 1>#NumberFormat(Actual,"$__,___,___.__")#<cfelse>#NumberFormat(Actual,"$0.__")#</cfif><cfelseif ActualNumberType is "Number" and Actual ge 1000.00>#NumberFormat(Actual,"___,___,___")#<cfelseif ActualNumberType is "Number" and Actual LT 1000.00><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"___,___,___._")#</cfif><cfelseif ActualNumberType is "Percent"><cfif Actual is 0>0<cfelseif right(Actual,2) eq 00>#NumberFormat(Actual,"___,___,___")#<cfelseif right(Actual,1) eq 0>#NumberFormat(Actual,"___,___,___._")#<cfelse>#NumberFormat(Actual,"___,___,___.__")#</cfif><cfelseif Actual is 0>0<cfelse>#Actual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif ActualNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif NextYrTargetNumberType is "N/A">N/A<cfelseif NextYrTargetNumberType is "Yes">Yes<cfelseif NextYrTargetNumberType is "No">No<cfelseif NextYrTargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Billions"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"$__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Number2"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Dollars/Cents"><cfif NextYrTarget is 0>0<cfelseif NextYrTarget gt 1>#NumberFormat(NextYrTarget,"$__,___,___.__")#<cfelse>#NumberFormat(NextYrTarget,"$0.__")#</cfif><cfelseif NextYrTargetNumberType is "Number" and NextYrTarget ge 1000.00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif NextYrTargetNumberType is "Number" and NextYrTarget LT 1000.00><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"___,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Percent"><cfif NextYrTarget is 0>0<cfelseif right(NextYrTarget,2) eq 00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif right(NextYrTarget,1) eq 0>#NumberFormat(NextYrTarget,"___,___,___._")#<cfelse>#NumberFormat(NextYrTarget,"___,___,___.__")#</cfif><cfelseif NextYrTarget is 0>0<cfelse>#NextYrTarget#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif NextYrTargetNumberType is "Percent"><font size="-2">%</font></cfif></td>
	</tr>
	</cfoutput>
	<!--- 
		*******************************************************************
			Efficiency Benchmarks 
		*******************************************************************		
	--->
	<cfloop query="ThisYear">
		<cfoutput>
		<cfStoredProc datasource="PAPProd" Procedure="EfficBnchMrkRPt">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Agency" value="#url.AgencyNo#">
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Year" value="#url.ReportCFY#">		
			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="ProgramId" value="#url.ReportProgramId#">
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="EfficiencyBnchRptRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="EfficiencyBnchRptRetMsg">
		<cfprocresult name="EfficBnchResult">
		</cfstoredproc>
		</cfoutput>
	</cfloop>	
	<cfif EfficBnchResult.recordcount>
	<tr><td align="left" colspan="12"><b><br><u><font size="-2">External Benchmarks</font></u></b></td></tr>
	</cfif>	
	<cfoutput query="EfficBnchResult">	
	<tr>
	<td width="15%" align="left" valign="Top"><img src="/iwgraph/greenBullet.gif" width=8 height=8 border=0 valign="middle" alt="#IndicatorName#"><font size="-2">#IndicatorName# <cfif PY2ActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Thousands" or TargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Thousands"> (in thousands)<cfelseif PY2ActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Millions" or ActualNumberType is "$ in Millions" or TargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Millions"> (in millions)<cfelseif PY2ActualNumberType is "$ in Billions" or PYActualNumberType is "$ in Billions" or ActualNumberType is "$ in Billions" or TargetNumberType is "$ in Billions" or NextYrTargetNumberType is "$ in Billions"> (in billions)<cfelseif PY2ActualNumberType is "Dollars/Cents" or PYActualNumberType is "Dollars/Cents" or ActualNumberType is "Dollars/Cents" or TargetNumberType is "Dollars/Cents" or NextYrTargetNumberType is "Dollars/Cents"> (in dollars)</cfif> <cfif IndicatorFootNoteId is not ""> (#IndicatorFootNoteId#)</cfif></font></td>
	<td width="5%" align="right" valign="Top">&nbsp;</td>
	<!--- PFY2 --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PY2ActualNumberType is "N/A">N/A<cfelseif PY2ActualNumberType is "Yes">Yes<cfelseif PY2ActualNumberType is "No">No<cfelseif PY2ActualNumberType is "$ in Thousands" or PY2ActualNumberType is "$ in Millions" or PY2ActualNumberType is "$ in Billions"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"$__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Number2"><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"__,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Dollars/Cents"><cfif PY2Actual is 0>0<cfelseif PY2Actual gt 1>#NumberFormat(PY2Actual,"$__,___,___.__")#<cfelse>#NumberFormat(PY2Actual,"$0.__")#</cfif><cfelseif PY2ActualNumberType is "Number" and PY2Actual ge 1000.00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif PY2ActualNumberType is "Number" and PY2Actual LT 1000.00><cfif PY2Actual is 0>0<cfelse>#NumberFormat(PY2Actual,"___,___,___._")#</cfif><cfelseif PY2ActualNumberType is "Percent"><cfif PY2Actual is 0>0<cfelseif right(PY2Actual,2) eq 00>#NumberFormat(PY2Actual,"___,___,___")#<cfelseif right(PY2Actual,1) eq 0>#NumberFormat(PY2Actual,"___,___,___._")#<cfelse>#NumberFormat(PY2Actual,"___,___,___.__")#</cfif><cfelseif PY2Actual is 0>0<cfelse>#PY2Actual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif PY2ActualNumberType is "Percent"><font size="-2">%</cfif></td>
	<!--- PFY --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif PYActualNumberType is "N/A">N/A<cfelseif PYActualNumberType is "Yes">Yes<cfelseif PYActualNumberType is "No">No<cfelseif PYActualNumberType is "$ in Thousands" or PYActualNumberType is "$ in Millions" or PYActualNumberType is "$ in Billions"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"$__,___,___._")#</cfif><cfelseif PYActualNumberType is "Number2"><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"__,___,___._")#</cfif><cfelseif PYActualNumberType is "Dollars/Cents"><cfif PYActual is 0>0<cfelseif PYActual gt 1>#NumberFormat(PYActual,"$__,___,___.__")#<cfelse>#NumberFormat(PYActual,"$0.__")#</cfif><cfelseif PYActualNumberType is "Number" and PYActual ge 1000.00>#NumberFormat(PYActual,"___,___,___")#<cfelseif PYActualNumberType is "Number" and PYActual LT 1000.00><cfif PYActual is 0>0<cfelse>#NumberFormat(PYActual,"___,___,___._")#</cfif><cfelseif PYActualNumberType is "Percent"><cfif PYActual is 0>0<cfelseif right(PYActual,2) eq 00>#NumberFormat(PYActual,"___,___,___")#<cfelseif right(PYActual,1) eq 0>#NumberFormat(PYActual,"___,___,___._")#<cfelse>#NumberFormat(PYActual,"___,___,___.__")#</cfif><cfelseif PYActual is 0>0<cfelse>#PYActual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif PYActualNumberType is "Percent"><font size="-2">%</cfif></td>
	<!--- CFY --->
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif TargetNumberType is "N/A">N/A<cfelseif TargetNumberType is "Yes">Yes<cfelseif TargetNumberType is "No">No<cfelseif TargetNumberType is "$ in Thousands" or TargetNumberType is "$ in Millions" or TargetNumberType is "$ in Billions"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"$__,___,___._")#</cfif><cfelseif TargetNumberType is "Number2"><cfif Target is 0>0<cfelse>#NumberFormat(Target,"__,___,___._")#</cfif><cfelseif TargetNumberType is "Dollars/Cents"><cfif Target is 0>0<cfelseif Target gt 1>#NumberFormat(Target,"$__,___,___.__")#<cfelse>#NumberFormat(Target,"$0.__")#</cfif><cfelseif TargetNumberType is "Number" and Target ge 1000.00>#NumberFormat(Target,"___,___,___")#<cfelseif TargetNumberType is "Number" and Target LT 1000.00><cfif Target is 0>0<cfelse>#NumberFormat(Target,"___,___,___._")#</cfif><cfelseif TargetNumberType is "Percent"><cfif Target is 0>0<cfelseif right(Target,2) eq 00>#NumberFormat(Target,"___,___,___")#<cfelseif right(Target,1) eq 0>#NumberFormat(Target,"___,___,___._")#<cfelse>#NumberFormat(Target,"___,___,___.__")#</cfif><cfelseif Target is 0>0<cfelse>#Target#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif TargetNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif ActualNumberType is "N/A">N/A<cfelseif ActualNumberType is "Yes">Yes<cfelseif ActualNumberType is "No">No<cfelseif ActualNumberType is "$ in Thousands" or ActualNumberType is "$ in Millions" or ActualNumberType is "$ in Billions"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"$__,___,___._")#</cfif><cfelseif ActualNumberType is "Number2"><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"__,___,___._")#</cfif><cfelseif ActualNumberType is "Dollars/Cents"><cfif Actual is 0>0<cfelseif Actual gt 1>#NumberFormat(Actual,"$__,___,___.__")#<cfelse>#NumberFormat(Actual,"$0.__")#</cfif><cfelseif ActualNumberType is "Number" and Actual ge 1000.00>#NumberFormat(round(Actual),"___,___,___")#<cfelseif ActualNumberType is "Number" and Actual LT 1000.00><cfif Actual is 0>0<cfelse>#NumberFormat(Actual,"___,___,___._")#</cfif><cfelseif ActualNumberType is "Percent"><cfif Actual is 0>0<cfelseif right(Actual,2) eq 00>#NumberFormat(Actual,"___,___,___")#<cfelseif right(Actual,1) eq 0>#NumberFormat(Actual,"___,___,___._")#<cfelse>#NumberFormat(Actual,"___,___,___.__")#</cfif><cfelseif Actual is 0>0<cfelse>#Actual#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif ActualNumberType is "Percent"><font size="-2">%</font></cfif></td>
	<td width="10%" align="Right" valign="Top"><font size="-2"><cfif NextYrTargetNumberType is "N/A">N/A<cfelseif NextYrTargetNumberType is "Yes">Yes<cfelseif NextYrTargetNumberType is "No">No<cfelseif NextYrTargetNumberType is "$ in Thousands" or NextYrTargetNumberType is "$ in Millions" or NextYrTargetNumberType is "$ in Billions"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"$__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Number2"><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"__,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Dollars/Cents"><cfif NextYrTarget is 0>0<cfelseif NextYrTarget gt 1>#NumberFormat(NextYrTarget,"$__,___,___.__")#<cfelse>#NumberFormat(NextYrTarget,"$0.__")#</cfif><cfelseif NextYrTargetNumberType is "Number" and NextYrTarget ge 1000.00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif NextYrTargetNumberType is "Number" and NextYrTarget LT 1000.00><cfif NextYrTarget is 0>0<cfelse>#NumberFormat(NextYrTarget,"___,___,___._")#</cfif><cfelseif NextYrTargetNumberType is "Percent"><cfif NextYrTarget is 0>0<cfelseif right(NextYrTarget,2) eq 00>#NumberFormat(NextYrTarget,"___,___,___")#<cfelseif right(NextYrTarget,1) eq 0>#NumberFormat(NextYrTarget,"___,___,___._")#<cfelse>#NumberFormat(NextYrTarget,"___,___,___.__")#</cfif><cfelseif NextYrTarget is 0>0<cfelse>#NextYrTarget#</cfif></font></td>
	<td width="5%" align="Left" valign="Top"><cfif NextYrTargetNumberType is "Percent"><font size="-2">%</font></cfif></td>
	</tr>
	</cfoutput>
	</table>
	<!---
		******************************************************************* 
			Explanatory Information 
		*******************************************************************
	--->
	<hr color="Black" width="95%" align="left" noshade>
	<table width="95%" bgcolor="White" cellspacing="0" cellpadding="0" border="0" frame="box">
	<cfoutput>
	<cfStoredProc datasource="PAPProd" Procedure="GetFootnote">
		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Agency" value="#url.AgencyNo#">
		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Year" value="#url.ReportCFY#">
		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="ProgramId" value="#url.ReportProgramId#">
		<cfprocparam type="in" cfsqltype="cf_sql_tinyint" dbvarname="@DeletionInd" Value="0">		
		<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFootnoteRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFootnoteRetMsg">
		<cfprocresult name="ThisYearFootnotes">
	</cfstoredproc>
	</cfoutput>
	
	<cfoutput>
	<cfStoredProc datasource="PAPProd" Procedure="GetPriorYrInfo">
		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Agency" value="#url.AgencyNo#">
		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Year" value="#url.ReportCFY#">
		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="ProgramId" value="#url.ReportProgramId#">	
		<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetPriorYrInfoRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetPriorYrInfoRetMsg">
		<cfprocresult name="GetPriorYrInfo">
	</cfstoredproc>
	</cfoutput>
	
	<cfoutput>
	<cfStoredProc datasource="PAPProd" Procedure="GetVarianceRptInfo">
		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Agency" value="#url.AgencyNo#">
		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Year" value="#url.ReportCFY#">
		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="ProgramId" value="#url.ReportProgramId#">	
		<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetVarianceInfoRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetVarianceInfoRetMsg">
		<cfprocresult name="GetVarianceRptInfo">
	</cfstoredproc>
	</cfoutput>
	
	<cfoutput query="ThisYear">
	<!---
	<tr><td colspan="2"><hr color="Black" width="95%" size="2" align="left" noshade></td></tr>
	--->
	<cfif Explanation is not "" or GetPriorYrInfo.Recordcount or GetVarianceRptInfo.Recordcount>
	<tr><td colspan="3" align="left" width="90%"><b><br><font style="a.Report" size="-2">Explanatory Information</font></b></td></tr>
	</cfif>
	<tr><td colspan="3" width="90%"><font style="a.Report" size="-2">#ParagraphFormat(trim(Explanation))#</font></td></tr>

	</cfoutput>
	<cfif GetPriorYrInfo.Recordcount>
	<tr><td width="5%">&nbsp;</td><td align="left" colspan="2" width="90%"><b><br><font style="a.Report" size="-2">Explanation of Changes to Prior Year Data</font></b></td></tr>
	</cfif>
	<cfoutput query="GetPriorYrInfo"><cfset TmpPriorYrChange= #trim(PriorYrChangeNo)# & ") " & #trim(PriorYrChange)#>
	<tr><td width="5%">&nbsp;</td><td colspan="2" width="90%"><font style="a.Report" size="-2">#ParagraphFormat(trim(TmpPriorYrChange))#</font></td></tr>
	</cfoutput>
	<cfif GetVarianceRptInfo.Recordcount>
	<tr><td width="5%">&nbsp;</td><td align="left" colspan="2" width="90%"><b><br><font style="a.Report" size="-2">Explanation of Marked Differences in Indicators between Fiscal Years/Targets</font></b></td></tr>
	</cfif>
	<cfoutput query="GetVarianceRptInfo"><cfset TmpVarianceExplan = #trim(VarianceNo)# & ") " & #trim(VarianceExplan)#>
	<tr><td width="5%">&nbsp;</td><td colspan="2" width="90%"><font style="a.Report" size="-2">#ParagraphFormat(trim(TmpVarianceExplan))#</font></td></tr>
	</cfoutput>
	<cfif ThisYearFootnotes.recordcount>
	<tr><td align="left" colspan="3" width="90%"><b><br><font style="a.Report" size="-2">Footnotes</font></b></td></tr>
	</cfif>
	<cfoutput query="ThisYearFootnotes">
	<tr valign="top"><td width="5%" valign="top" colspan="3"><font style="a.Report" size="-2">#trim(FootnoteNo)#</font>&nbsp;&nbsp;&nbsp;<font style="a.Report" size="-2">#ParagraphFormat(Footnote)#</font></td></tr>
	</cfoutput>
	</table>
	
	<br><br><br>
	<!--- 
		*******************************************************************
			Select New Program 
		*******************************************************************
	--->
	<h3><b>Select a Different Program</b></h3>
	To select a different program to view the Report, click the button below.
	<table width="95%" bgcolor="#DDEEFF" cellspacing="0" cellpadding="0" border="1" frame="box" rules="groups">
	<CFFORM ACTION="http://www.ioc.state.il.us/comptroller/?LinkServID=988B110E-FCD1-4DEB-93025AE46B9CD704&AgencyNo=#url.AgencyNo#&ReportFY=#url.ReportCFY#&ReportProgramId=#url.ReportProgramId#&##ViewReports" METHOD="Post" name="List">
	<tr>
	<td><center><input type="Submit" Name = "DoSelect" value="Select a Different Program"></center></td>
	</tr>
	</cfform>
	</table>
	<br><br><br>
	<cfinclude template="/comptroller/includes/display_objects/custom/par/copyright.cfm">

</body>
</html>
