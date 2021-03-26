<!---
Created By: Gary Ashbaugh
Date Created: 2-26-2010

Description:  This component is called by the Site Map program
--->


<cfcomponent>

	<cffunction name="getListReports" access="remote" returntype="query" hint="This function is called to supply the initial values of the By Code selection box">
   		<cfoutput>
        <cfStoredProc datasource="SAMSMonthlyRpt" Procedure="Get_LstReportsbyNo">
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLstReportsByNoRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLstReportsByNoRetMsg">
		<cfprocresult name="GetListReportsByNo">
		</cfstoredproc>
        </cfoutput>

		<cfreturn GetListReportsByNo>
        
	</cffunction> 
	    
    <cffunction name="getListFY" access="remote" returntype="query" hint="This function is called to supply the default list of the FYs">
    	<cfargument name="SelectMonth" type="string" required="No">
    	
    	<cfoutput>
       	<cfStoredProc datasource="SAMSMonthlyRpt" Procedure="Get_SM_ListFY">
         	<cfif trim(SelectMonth) is not "">
        		<cfprocparam type="in"  cfsqltype="cf_sql_varchar" dbvarname="@Month"  value="#trim(SelectMonth)#">
            <cfelse>
            	<cfprocparam type="in"  cfsqltype="cf_sql_varchar" dbvarname="@Month" null="Yes">
            </cfif>
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetlistRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListRetMsg">
			<cfprocresult name="GetListFY">
		</cfstoredproc>
        </cfoutput>

		<cfreturn "#GetListFY#">
        
	</cffunction> 
	
	 <cffunction name="getListMonths" access="remote" returntype="query" hint="This function is called to supply the default list of the Months">
    	<cfargument name="SelectFY" type="string" required="No">
    	
    	<cfoutput>
       	<cfStoredProc datasource="SAMSMonthlyRpt" Procedure="Get_SM_ListMonths">
         	<cfif trim(SelectFY) is not "">
        		<cfprocparam type="in"  cfsqltype="cf_sql_char" dbvarname="@FY"  value="#trim(SelectFY)#">
            <cfelse>
            	<cfprocparam type="in"  cfsqltype="cf_sql_varchar" dbvarname="@FY" null="Yes">
            </cfif>
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetlistRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListRetMsg">
			<cfprocresult name="GetListMonths">
		</cfstoredproc>
        </cfoutput>

		<cfreturn "#GetListMonths#">
        
	</cffunction> 
	
	<cffunction name="Get_ListAvailSiteReports" access="remote" returntype="query" hint="This function is called to supply the list of reports available based upon the selection criteris the user has selected">
    	<cfargument name="ReportNo" type="string" required="Yes">
        <cfargument name="FY" type="string" required="Yes">
        <cfargument name="Accounting_Period" type="string" required="No">

   		<cfoutput>
        <cfStoredProc datasource="SAMSMonthlyRpt" Procedure="Get_LstAvailSiteReports">
        	<cfif trim(ReportNo) is not "">
        		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@ReportNo"  value="#trim(ReportNo)#">
            <cfelse>
            	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@ReportNo" null="Yes">
            </cfif>
           	<cfif trim(FY) is not "">
            	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY"  value="#trim(FY)#">
            <cfelse>
            	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" null="Yes">
            </cfif>
            <cfif trim(Accounting_Period) is not "">
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Accounting_Period"  value="#trim(Accounting_Period)#">
            <cfelse>
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Accounting_Period" null="yes">
             </cfif>
             <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetListAvailReportsRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListAvailReportsRetMsg">
			<cfprocresult name="GetListAvailReports">
		</cfstoredproc>
        </cfoutput>

       	<cfreturn GetListAvailReports >

	</cffunction>   

</cfcomponent>