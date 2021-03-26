<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->
<!--- 
Application: SR# 10098 - Public Viewing of the TIF Annual Financial Reports
Author: Gary Ashbaugh
Date Created: 8-13-10

Description:The program will allow the user to select the First Character of the Municipality, and Fiscal Year from drop-down select boxes.

 --->
 
 <html>
<head>
	<title>Annual Tax Increment Finance Report</title>
</head>

<cfparam name="url.BetaSel" default="">
<cfparam name="url.CFY" default="">
<cfparam name="url.Code" default="">


<body>
<cflock scope="session" TIMEOUT="1000">

<cfif url.Code is "">
	<b>You must supply a unit of government</b>
</cfif>

<cfoutput>
<cftry>
<cfStoredProc datasource="#application.SQLSource#" Procedure="Get_FY">
	<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="Get_FYRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="Get_FYRetMsg">
	<cfprocresult name="GetCFY">
</cfstoredproc>
<cfcatch type="any">
<b>Sorry, Could not get available FY Information</b>
</cfcatch>
</cftry>
</cfoutput>

<cfoutput query="GetCFY">
<cfif GetCFY.FY gt '2010'>
	<cfset TMpFY="#GetCFY.FY#">
    <table border="0"  width="45%">
    
    <cftry>
    <cfStoredProc datasource="#application.SQLSource#" Procedure="Get_UnitStatInfo">
        <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(url.Code)#">
        <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" value="#TmpFY#">
        <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitStatInfoRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitStatInfoRetMsg">
        <cfprocresult name="GetUnitStatInfo">
    </cfstoredproc>
    <cfcatch type="any">
    <b>Sorry, we could not get AFR Information for FY #GetCFY.FY#</b>
    </cfcatch>
    </cftry>
    
    <cfif GetUnitStatInfo.recordcount>
        <cfloop query="GetUnitStatInfo">
        	 <cftry>
            <cfStoredProc datasource="#application.SQLSource#" Procedure="Get_UnitInfo">
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(url.Code)#">
                <cfprocparam type="in" cfsqltype="cf_sql_tinyint" dbvarname="@C4" null="yes">
                <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetUnitInfoRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetUnitInfoRetMsg">
                <cfprocresult name="GetUnitInfo">
            </cfstoredproc>
            <cfcatch type="any">
            <b>Sorry, we could not get AFR Information for FY #GetCFY.FY#</b>
            </cfcatch>
            </cftry>
            
        	<cftry>
        	<cfStoredProc datasource="#application.SQLSource#" Procedure="Check_TblC4">
                <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@FY" value="#TmpFY#">
                <cfprocparam type="In"  cfsqltype="cf_sql_char" dbvarname="@C4" value="#GetUnitInfo.C4#">
                <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckTblC4RetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckTblC4RetMsg">
            <cfprocresult name="CheckTblC4">
            </cfstoredproc>
            <cfcatch type="any">
            <b>Sorry, we could not get AFR Information for FY #GetCFY.FY#</b>
            </cfcatch>
            </cftry>
            
            <cfif trim(GetUnitStatInfo.Finished) is "N">
                <cfset TmpDesc= "(No #GetCFY.FY# AFR Available)">
            <cfelse>
                <cfset TmpDesc="#GetCFY.FY# AFR" >
                <cfif CheckTblC4.CompConn is "Y">
                    <cfif GetUnitInfo.C1 is "SP" and GetUnitStatInfo.AbbrFrmFlag is "Y">
                		<cfset TmpFolder="ABRReport">
                    	<cfset TmpFile="ABRSPCoverPg.cfm">
					<cfelseif GetUnitInfo.C1 is "SP" and GetUnitStatInfo.AbbrFrmFlag is "N">
                        <cfset TmpFolder="SPFReport">
                        <cfset TmpFile="AFRSPCoverPg.cfm">
                    <cfelse>
                        <cfset TmpFolder="MPFReport">
                        <cfset TmpFile="AFRMPCoverPg.cfm">
                    </cfif>
                <cfelseif CheckTblC4.Registration is "Y">
					<cfset TmpFolder="RegOnlyReport">
                	<cfset TmpFile="RegOnlyCoverPg.cfm">
               
                </cfif>                       
            </cfif>
            <tr><td><cfif trim(Finished) is "Y"><a href="#application.WAREHOUSEREPORTPATH#/FY#TmpFY#/#TmpFolder#/#TmpFile#?Code=#url.Code#&CFY=#TMpFY#"></cfif><img src="/images/report.gif" align="absmiddle" border=0 alt="#TmpDesc#"> #TmpDesc#<cfif trim(Finished) is "Y"></a></cfif></td></tr>
        </cfloop>
         <tr><td>&nbsp;</tr></tr>
    </cfif>
</cfif>
</cfoutput>
</table>

</cflock>
<!---</body>
</html>--->
