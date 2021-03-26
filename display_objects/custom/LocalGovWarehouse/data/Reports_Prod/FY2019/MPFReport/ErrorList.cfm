<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--- 
Author: Gary Ashbaugh
Date Created: 5-28-2018

LOGIC: Pulls off a list of Error(s) still needing to be resolved

 --->
 <link rel="stylesheet" type="text/css" href="afr.css">
 

 
 
 <!--- Pull of the unit's name --->
<CFLOCK SCOPE="Session" timeout="100">
<cfoutput>
<cfStoredProc Datasource="#application.SQLSource#" Procedure="Get_AFRRptPg1">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAFRRptPg1RetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAFRRptPg1RetMsg">
	<cfprocresult name="GetAFRRptPg1">
</cfstoredproc>

<cfinclude template="../CheckErrors.cfm">

<cfStoredProc Datasource="#application.SQLSource#" Procedure="Get_ListErrors">
	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#url.code#">
	<cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#url.CFY#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetListErrorsRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListErrorsRetMsg">
	<cfprocresult name="GetListErrors">
</cfstoredproc>
</cfoutput>
 
<cfset url.PageType="AFR">
<cfset url.PageName="List of Errors">
<div class="jumbotron">
<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/heading.cfm">
<!---<cfinclude template="/comptroller/includes/display_objects/custom/LocalGovWarehouse/Data/Reports/AvailableAFR.cfm">--->
</div>
<h3>
<cfoutput><cfif url.PrintIt is "no"> 
<span class="pull-right"> 
	<a href="/data/reports/PdfReport.cfm?FileName=/data/reports/FY2019/MPFReport/ErrorList.cfm&Code=#url.Code#&CFY=#url.CFY#&PrintIt=Yes&AFRDesiredData=#url.AFRDesiredData#&Format=Multi-Purpose Form&Page=F13" class="btn btn-primary btn-lg">
    <span class="glyphicon glyphicon-print"></span>
     Print This Page</a></span>

</cfif>
</cfoutput>
</h3>
<cfset TmpErrorHeader=" ">
<cfset ShowHeader = " ">
		<h1><b><center>List of Error(s) still needing to be resolved</center></b></h1>
		<table bgcolor="White" cellspacing="0" cellpadding="2" border="1" frame="box">
		<cfoutput query="GetListErrors">
        	<cfif trim(GetListErrors.ShowStopper) is "Y">
                <cfif trim(TmpErrorHeader) is "">
                	<cfset TmpErrorHeader = "Critical">
                	<cfset ShowHeader = "Yes">
                <cfelseif trim(TmpErrorHeader) is "Non-Critical">
                	<tr><td>&nbsp;</td></tr>
                	<cfset TmpErrorHeader = "Critical">
                	<cfset ShowHeader = "Yes">
                <cfelse>
                	<cfset ShowHeader = "No">
               	</cfif>
            <cfelse>
                <cfif trim(TmpErrorHeader) is "">
                	<cfset TmpErrorHeader = "Non-Critical">
                	<cfset ShowHeader = "Yes">
                <cfelseif trim(TmpErrorHeader) is "Critical">
                	<tr><td>&nbsp;</td></tr>
                	<cfset TmpErrorHeader = "Non-Critical">
                	<cfset ShowHeader = "Yes">
                <cfelse>
                	<cfset ShowHeader = "No">
               	</cfif>
             </cfif>
             <cfif ShowHeader is "Yes">
             <tr><td><h1><b>#TmpErrorHeader#</b></h1></td></tr>
             <tr><td>&nbsp;</td></tr>
             </cfif>
			<tr><td>#Heading#</td></tr>
		</cfoutput>
		</table>
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
        <td width="20%">#url.CFY# Multi-Purpose Form - F13</td>
         </tr>
        </table>
         </div>
         </cfoutput>
	</cfif>
</html>
</cflock>
