<!--- 
Created By: Gary Ashbaugh
Date Created:9-5-13

Description: This component has several functions:
	
	FYSubmitted function requires 1 parameter (Code) and returns a string containing the FY a unit of government has submitted their AFR and verifies the AFR for the year is not in amendment form

--->

<cfcomponent>

	<cffunction NAME="FYSubmitted" ACCESS="Remote" OUTPUT="False" HINT="Returns the FYs the unit has submitted their AFR and verifies that it is NOT in amendment form">

		<cfargument NAME="Code" TYPE="String" REQUIRED="True" default="2011"/>

		<cfoutput>
        <cfset PFY=application.LocGovWarehouseCFY-1>
        <cfset PFY2=application.LocGovWarehouseCFY-2>
        <cfset SubmittedAFR="">
        
        <cfloop index="i" list="#application.LocGovWarehouseCFY#,#PFY#,#PFY2#">
        
            <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Check_AFRSubmitted">
                <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(arguments.Code)#">
                <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#i#">
                <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="CheckAFRSubmittedRetVal">
                <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="CheckAFRSubmittedRetMsg">
                <cfprocresult NAME="CheckAFRSubmittedCFY">
            </cfstoredproc>       
        
        <cfif CheckAFRSubmittedRetVal is 0>
        
        	<cfif trim(SubmittedAFR) is "">
        
        		<cfset SubmittedAFR = #i#>
            
            <cfelse>
            
				<cfset SubmittedAFR= #SubmittedAFR# & "," & #i#>
                
             </cfif>
             
        </cfif>
		</cfloop>
        	
		<cfreturn "#SubmittedAFR#"/>

		</cfoutput>
	</cffunction>
    
    <cffunction NAME="FormSubmitted" ACCESS="Public" OUTPUT="False" HINT="Returns the Form the unit used for a given FY">

		<cfargument NAME="Code" TYPE="String" REQUIRED="True"/>
        <cfargument NAME="CFY" TYPE="String" REQUIRED="True"/>

		<cfoutput>
        <cfset FormSubmitted = "">
        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_UnitInfo">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(arguments.Code)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_smallint" DBVARNAME="@C4" null="Yes">
            <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="GetUnitInfoRetVal">
            <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="GetUnitInfoRetMsg">
            <cfprocresult NAME="GetUnitInfo">
        </cfstoredproc>
             
        <cfStoredProc datasource="#application.LocGovWarehouse#" Procedure="Get_AppropCheckInfo">
            <cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@FY" value="#arguments.CFY#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetExemptAppropRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetExemptAppropRetMsg">
            <cfprocresult name="GetExemptApprop">
        </cfstoredproc>

        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_UnitStatInfo">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(arguments.Code)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#trim(arguments.CFY)#">
            <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="GetUnitStatInfoRetVal">
            <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="GetUnitStatInfoRetMsg">
            <cfprocresult NAME="GetUnitStatInfo">
        </cfstoredproc>
        
        
        	<cfif GetUnitStatInfoRetVal is 0>
        
				<cfif GetUnitInfo.C1 is "MU" or GetUnitInfo.C1 is "CO" or GetUnitInfo.C1 is "TW">
                	<cfif GetUnitStatInfo.GASB34Flag is "Y">
                    	<cfset FormSubmitted="MPGASB34">
                    <cfelse>
                    	<cfset FormSubmitted="MP">
                    </cfif>
                <cfelseif GetUnitInfo.C1 is "SP" and GetUnitInfo.C4 is "5">
                	<cfset FormSubmitted="RegOnly">
                <cfelseif GetUnitInfo.C1 is "SP" and (GetUnitStatInfo.TotalAppropriations le GetExemptApprop.CheckAppropriation)>
                	<cfset FormSubmitted="VFrm">
                <cfelseif GetUnitStatInfo.AbbrFrmFlag is "N">
                	<cfif GetUnitStatInfo.GASB34Flag is "Y">
                    	<cfset FormSubmitted="SPGASB34">
                    <cfelseif GetUnitInfo.C1 is "SP">
                    	<cfset FormSubmitted="SP">
                    <cfelse>
                    	<cfset FormSubmitted="RegOnly">
                    </cfif>
                <cfelseif GetUnitStatInfo.AbbrFrmFlag is "Y">
                    <cfset FormSubmitted="Abbrev">
                <cfelse>
                	<cfset FormSubmitted="RegOnly">
                </cfif>
             
        	</cfif>
            <!---
		</cfif>
        	--->
		<cfreturn "#FormSubmitted#"/>

		</cfoutput>
	</cffunction>
    
    <cffunction NAME="Screens4Form" ACCESS="Public" OUTPUT="False" HINT="Returns the available screens for a particular data entry type for a certain Year">

        <cfargument NAME="CFY" TYPE="String" REQUIRED="True"/>
		<cfargument NAME="FormType" TYPE="String" REQUIRED="True"/>
        
		<cfoutput>
        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_AFRReports">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#trim(arguments.CFY)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@DataEntryType" value="#trim(arguments.FormType)#">
            <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="GetAFRReportsRetVal">
            <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="GetAFRReportsRetMsg">
            <cfprocresult NAME="GetAFRReports">
        </cfstoredproc>
        
        <cfif GEtAFRReports.recordcount>
			<cfreturn "#GetAFRReports#"/>
        </cfif>
		</cfoutput>
	</cffunction>
    
    <cffunction NAME="Screens4Unit" ACCESS="Remote" OUTPUT="False" HINT="Returns the available screens for a particular unit of government for a certain Year">
		
        <cfargument NAME="Code" TYPE="String" REQUIRED="True"/>
        <cfargument NAME="CFY" TYPE="String" REQUIRED="True"/>
		
        
		<cfoutput>
        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_UnitScreens">
        	<cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(arguments.Code)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#trim(arguments.CFY)#">
            <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="GetUnitScreensRetVal">
            <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="GetUnitScreensRetMsg">
            <cfprocresult NAME="GetUnitScreens">
        </cfstoredproc>
        
        <cfif GetUnitScreens.recordcount>
			<cfreturn "#GetUnitScreens#"/>
        <cfelse>
        	<cfreturn ""/>
        </cfif>
		</cfoutput>
	</cffunction>
    
    <cffunction NAME="PageInfo" ACCESS="Public" OUTPUT="False" HINT="Returns the path and filename for a particular screen">

        <cfargument NAME="CFY" TYPE="String" REQUIRED="True"/>
        <cfargument NAME="PageName" TYPE="String" REQUIRED="True"/>
		<cfargument NAME="FormType" TYPE="String" REQUIRED="True"/>
        <cfargument NAME="PageType" TYPE="String" REQUIRED="True"/>
        
		<cfoutput>
        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_AFRReportsPageInfo">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#trim(arguments.CFY)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@PageName" VALUE="#trim(arguments.PageName)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@DataEntryType" value="#trim(arguments.FormType)#">
            <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="GetPageInfoRetVal">
            <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="GetPageInfoRetMsg">
            <cfprocresult NAME="GetPageInfo">
        </cfstoredproc>

        <cfif isdefined("GetPageInfo")>
			<cfif GetPageInfo.recordcount>
                
                <cfif PageType is "AFR">
                    <cfset TmpFilePath = "#GetPageInfo.AFRLocation#" & "#GetPageInfo.AFRFileName#">
                <cfelse>
                    <cfset TmpFilePath = "#GetPageInfo.SummaryLocation#" & "#GetPageInfo.SummaryFileName#">
                </cfif>
                <cfreturn "#TmpFilePath#"/>
            </cfif>
        
        </cfif>
		</cfoutput>
	</cffunction>
    
     <cffunction NAME="CheckAuditDue" ACCESS="Public" OUTPUT="False" HINT="Returns Y if an Audit is due for a given FY for the unit of government">

		<cfargument NAME="Code" TYPE="String" REQUIRED="True"/>
        <cfargument NAME="CFY" TYPE="String" REQUIRED="True"/>

		<cfoutput>
        <cfset AuditDue = "N">
        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Check_AnnualAuditDue">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(arguments.Code)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#trim(arguments.CFY)#">
            <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="CheckAnnualAuditDueRetVal">
            <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="CheckAnnualAuditDueRetMsg">
            <cfprocresult NAME="CheckAnnualAuditDue">
        </cfstoredproc>

        <cfif CheckAnnualAuditDueRetVal is 0>       
			<cfreturn "#CheckAnnualAuditDue.AuditDue#"/>	
        <cfelse>
        	<cfreturn "N"/>
        </cfif>
		</cfoutput>
	</cffunction>
    
    
    <cffunction NAME="ListofPages" ACCESS="Public" OUTPUT="False" HINT="Returns the path and filename for all screens for a given data entry format">

        <cfargument NAME="CFY" TYPE="String" REQUIRED="True"/>
		<cfargument NAME="FormType" TYPE="String" REQUIRED="True"/>
        
		<cfoutput>
        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_AFRReportsAllPageInfo">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#trim(arguments.CFY)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@DataEntryType" value="#trim(arguments.FormType)#">
            <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="GetPageInfoRetVal">
            <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="GetPageInfoRetMsg">
            <cfprocresult NAME="GetAllPageInfo">
        </cfstoredproc>
       
		<cfreturn "#GetAllPageInfo#"/>
		</cfoutput>
	</cffunction>
    
     <cffunction NAME="GeneralUnitInfo" ACCESS="Public" OUTPUT="False" HINT="Returns the General information about a unit of government for the latest submitted AFR">

        <cfargument NAME="Code" TYPE="String" REQUIRED="True"/>
        
		<cfoutput>
        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_UnitGeneralInfo">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(arguments.Code)#">
            <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="GetGeneralInfoRetVal">
            <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="GetGeneralInfoRetMsg">
            <cfprocresult NAME="GetGeneralInfo" resultset="2">
        </cfstoredproc>
        
 
		<cfreturn "#GetGeneralInfo#"/>

		</cfoutput>
	</cffunction>
    
     <cffunction NAME="FilingAmendment" ACCESS="Public" OUTPUT="False" HINT="Returns the the number of years the unit is filing an amendment">

        <cfargument NAME="Code" TYPE="String" REQUIRED="True"/>
        
		<cfoutput>
        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_UnitAmendmentInfo">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(arguments.Code)#">
            <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="GetUnitAmendmentInfoRetVal">
            <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="GetUnitAmendmentInfoRetMsg">
            <cfprocresult NAME="GetUnitAmendmentInfo">
        </cfstoredproc>

		<cfreturn "#GetUnitAmendmentInfo.NoAmendments#" />
		</cfoutput>
	</cffunction>
    
    <cffunction NAME="IsDissolved" ACCESS="Public" OUTPUT="False" HINT="Returns True if the unit is dissolved or False if it is still active">

        <cfargument NAME="Code" TYPE="String" REQUIRED="True"/>
        
		<cfoutput>
        <cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Check_IfDissolved">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(arguments.Code)#">
            <cfprocparam TYPE="Out"  CFSQLTYPE="cf_sql_integer" DBVARNAME="@RetVal" VARIABLE="CheckIFDissolvedRetVal">
            <cfprocparam TYPE="Out" CFSQLTYPE="cf_sql_varchar" DBVARNAME="@RetMsg" VARIABLE="CheckIFDissolvedRetMsg">
            <cfprocresult NAME="CheckIFDissolved">
        </cfstoredproc>

		<cfreturn "#CheckIfDissolved#">

		</cfoutput>
	</cffunction>

</cfcomponent>
