<!---
Created By: Gary Ashbaugh
Date Created: 8-5-08

Description:  This component is called by the AJAX and CFSelect command in the index to supply the values to the select boxes. .
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
    
    <cffunction name="getTitle" access="remote" returntype="string" hint="This function is called to supply the tile of the Agency/Fund No Field">
    
    	<cfargument name="ReportNo" type="string" required="No">
   		
        <cfif trim(mid(ReportNo,1,4)) is "SB05">

			<cfreturn "Fund No:">
        <cfelse>
        	<cfreturn "Agency No:">
        </cfif>
        
	</cffunction> 
	    
    <cffunction name="getCurrentFY" access="remote" returntype="string" hint="This function is called to supply the default value of the FY selection box">
    	<cfargument name="ReportNo" type="string" required="No">
   
   		<cfoutput>
       	<cfStoredProc datasource="SAMSMonthlyRpt" Procedure="Get_CurrentFY">
         	<cfif trim(ReportNo) is not "">
        		<cfprocparam type="in"  cfsqltype="cf_sql_char" dbvarname="@ReportNo"  value="#trim(ReportNo)#">
            <cfelse>
            	<cfprocparam type="in"  cfsqltype="cf_sql_char" dbvarname="@ReportNo" null="Yes">
            </cfif>
            <cfprocparam type="Out"  cfsqltype="cf_sql_char" dbvarname="@CurrentFY" variable="CurrentFY">
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFYRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFYRetMsg">
			<cfprocresult name="GetListFY">
		</cfstoredproc>
        </cfoutput>

		<cfreturn "#CurrentFY#">
        
	</cffunction>  
    
    <cffunction name="getListFY" access="remote" returntype="query" hint="This function is called to supply the initial values of the FY selection box">
    	<cfargument name="ReportNo" type="string" required="No">
   
   		<cfoutput>
       	 <cfStoredProc datasource="SAMSMonthlyRpt" Procedure="Get_LstFY">
         	<cfif trim(ReportNo) is not "">
        		<cfprocparam type="in"  cfsqltype="cf_sql_char" dbvarname="@ReportNo"  value="#trim(ReportNo)#">
            <cfelse>
            	<cfprocparam type="in"  cfsqltype="cf_sql_char" dbvarname="@ReportNo" null="Yes">
            </cfif>
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFYRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFYRetMsg">
			<cfprocresult name="GetListFY">
		</cfstoredproc>
        </cfoutput>

		<cfreturn GetListFY>
        
	</cffunction>  
    
    <cffunction name="getListMonths" access="remote" returntype="query" hint="This function is called to supply the initial values of the Accounting Period selection box">
    	<cfargument name="ReportNo" type="string" required="No">
        <cfargument name="FY" type="string" required="No">
       
   		<cfoutput>
        <cfStoredProc datasource="SAMSMonthlyRpt" Procedure="Get_LstMonths">
        	<cfif trim(ReportNo) is not "">
        		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@ReportNo"  value="#trim(mid(ReportNo,1,5))#">
            <cfelse>
            	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@ReportNo" null="Yes">
            </cfif>
            <cfif trim(FY) is not "">
            	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY"  value="#trim(FY)#">
            <cfelse>
            	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" null="Yes">
            </cfif>
			<cfif isdefined("AgencyNo")>
            	<cfif trim(ReportNo) is "SB05">
             		<cfif trim(mid(AgencyNo,1,4)) is not "0000">
             			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No" value="000">
                		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="#trim(mid(AgencyNo,1,4))#">
             		<cfelse>
                		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No" value="000">
                		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="0000">
                     </cfif>
             	<cfelse>
             		<cfif trim(mid(AgencyNo,1,3)) is not "000">
                		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No"  value="#trim(mid(AgencyNo,1,3))#">
                    	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="0000">
             		<cfelse>
               			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No" value="000">
                    	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="0000">
                	</cfif>
               </cfif>
             <cfelse>
             	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No" value="000">
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="0000">  
             </cfif>
			<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLstMonthsRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLstMonthsRetMsg">
			<cfprocresult name="getListMonths">
		</cfstoredproc>
        </cfoutput>

        <cfreturn getListMonths >

	</cffunction> 
    
    <cffunction name="getListAgencies" access="remote" returntype="query" hint="This function is called to supply the initial values of the Agency selection box">
    	<cfargument name="ReportNo" type="string" required="No">
        <cfargument name="FY" type="string" required="No">
        <cfargument name="Accounting_Period" type="string" required="No">
        
		<cfoutput>
        <cfif trim(mid(ReportNo,1,4)) is not "SB05">
       		
        	<cfStoredProc datasource="SAMSMonthlyRpt" Procedure="Get_LstAgencies">
            	<cfif trim(ReportNo) is not "">
        			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@ReportNo"  value="#trim(mid(ReportNo,1,5))#">
            	<cfelse>
                	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@ReportNo" null="Yes">
            	</cfif>
            	<cfif trim(FY) is not "">
            		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY"  value="#trim(FY)#">
            	<cfelse>
            		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" null="Yes">
            	</cfif>
            	<cfif trim(Accounting_Period) is not "">
                	<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Accounting_Period"  value="#trim(Accounting_Period)#">
            	<cfelse>
                	<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Accounting_Period" null="yes">
            	</cfif>
				<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLstReportsByNoRetVal">
				<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLstReportsByNoRetMsg">
				<cfprocresult name="GetListAgencies">
			</cfstoredproc>
         
         <cfelse>
         	<cfStoredProc datasource="SAMSMonthlyRpt" Procedure="Get_LstFunds">
            	<cfif trim(ReportNo) is not "">
        			<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@ReportNo"  value="#trim(mid(ReportNo,1,5))#">
            	<cfelse>
                	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@ReportNo" null="Yes">
            	</cfif>
            	<cfif trim(FY) is not "">
            		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY"  value="#trim(FY)#">
            	<cfelse>
            		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" null="Yes">
            	</cfif>
            	<cfif trim(Accounting_Period) is not "">
                	<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Accounting_Period"  value="#trim(Accounting_Period)#">
            	<cfelse>
                	<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Accounting_Period" null="yes">
            	</cfif>
				<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetLstFundsRetVal">
				<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetLstFundsRetMsg">
				<cfprocresult name="GetListAgencies">
			</cfstoredproc>       	
            
         </cfif>
      
       	 <cfreturn GetListAgencies>
  		</cfoutput>
	</cffunction> 
    
    <cffunction name="Get_ListAvailReports" access="remote" returntype="query" hint="This function is called to supply the list of reports available based upon the selection criteris the user has selected">
    	<cfargument name="ReportNo" type="string" required="Yes">
        <cfargument name="FY" type="string" required="Yes">
        <cfargument name="Accounting_Period" type="string" required="No">
        <cfargument name="AgencyNo" type="string" required="No">

   		<cfoutput>
        <cfStoredProc datasource="SAMSMonthlyRpt" Procedure="Get_LstAvailReports">
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
             <cfif trim(ReportNo) is "SB05">
             	<cfif mid(trim(AgencyNo),1,4) is not "0000">
             		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No" value="000">
                	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="#mid(trim(AgencyNo),1,4)#">
             	<cfelse>
                	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No" value="000">
                	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="0000">
                </cfif>
             <cfelse>
             	<cfif mid(trim(AgencyNo),1,3) is not "000">
                	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No"  value="#mid(trim(AgencyNo),1,3)#">
                    <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="0000">
             	<cfelse>
               		<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No" value="000">
                    <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="0000">
                </cfif>
             </cfif>
             <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetListAvailReportsRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListAvailReportsRetMsg">
			<cfprocresult name="GetListAvailReports">
		</cfstoredproc>
        </cfoutput>

       	<cfreturn GetListAvailReports >

	</cffunction> 
    
    <cffunction name="Add_ReportInfo" access="remote" returntype="string" hint="This function is called to insert the new SAMS Monthly Report into the table">
    	<cfargument name="ReportNo" type="string" required="Yes">
        <cfargument name="FY" type="string" required="Yes">
        <cfargument name="GeneratedDt" type="string" required="Yes">
        <cfargument name="AgencyNo" type="string" required="No">
        <cfargument name="FundNum" type="string" required="No">

   		<cfoutput>
        <cfStoredProc Procedure="Add_ReportInfo" datasource="SAMSMonthlyLoad">
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
            <cfif trim(GeneratedDt) is not "">
                <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@GeneratedDt"  value="#trim(GeneratedDt)#">
            <cfelse>
                <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@GeneratedDt" null="yes">
             </cfif>
             <cfif (trim(AgencyNo) is not "")>
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No"  value="#trim(AgencyNo)#">
             <cfelse>
               <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No" value="000">
             </cfif>
              <cfif (trim(FundNum) is not "")>
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num"  value="#trim(FundNum)#">
             <cfelse>
               <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="0000">
             </cfif>
             <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="AddReportInfoRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="AddReportInfoRetMsg">
			<cfprocresult name="AddReportInfo">
		</cfstoredproc>
        </cfoutput>

       	<cfreturn "#AddReportInfoRetVal#"/ >

	</cffunction> 
    
    <cffunction name="Check_Report" access="remote" returntype="query" hint="This function is called to check to see if the report exists in the table">
    	<cfargument name="ReportNo" type="string" required="Yes">
        <cfargument name="FY" type="string" required="Yes">
        <cfargument name="GeneratedDt" type="string" required="Yes">
        <cfargument name="AgencyNo" type="string" required="No">
        <cfargument name="FundNum" type="string" required="No">

   		<cfoutput>
        <cfStoredProc Procedure="Check_Report" datasource="SAMSMonthlyLoad">
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
            <cfif trim(GeneratedDt) is not "">
                <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@GeneratedDt"  value="#trim(GeneratedDt)#">
            <cfelse>
                <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@GeneratedDt" null="yes">
             </cfif>
             <cfif (trim(AgencyNo) is not "")>
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No"  value="#trim(AgencyNo)#">
             <cfelse>
               <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No" value="000">
             </cfif>
             <cfif (trim(FundNum) is not "")>
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num"  value="#trim(FundNum)#">
             <cfelse>
               <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num" value="0000">
             </cfif>
             <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckReportRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckReportRetMsg">
			<cfprocresult name="CheckReport">
		</cfstoredproc>
        </cfoutput>

       	<cfreturn CheckReport >

	</cffunction>
    
     <cffunction name="Updt_AgencyInfo" access="remote" returntype="string" hint="This function is called to check the Agency table against SAMS Agency table">
     
     	<cfargument name="AgencyNo" type="string" required="Yes">
        <cfargument name="FY" type="string" required="Yes">
        <cfargument name="Agency_Name" type="string" required="Yes">
        <cfargument name="Class" type="string" required="Yes">
        <cfargument name="Category" type="string" required="Yes">
        <cfargument name="Group_No" type="string" required="Yes">
        <cfargument name="PGvt_CUnit" type="string" required="Yes">
    
   		<cfoutput>
        <cfStoredProc datasource="SAMSMonthlyLoadDev" Procedure="Updt_AgencyNo">
        	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Agency_No"  value="#trim(AgencyNo)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY"  value="#trim(FY)#">
            <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Agency_Name"  value="#trim(Agency_Name)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Class"  value="#trim(Class)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Category"  value="#trim(Category)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Group_No"  value="#trim(Group_No)#">
            <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@PGvt_CUnit"  value="#trim(PGvt_CUnit)#">
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckAgencyNoRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckAgencyNoRetMsg">
		<cfprocresult name="UpdtAgencyNO">
		</cfstoredproc>
        </cfoutput>

		<cfreturn "#CheckAgencyNoRetVal#">
          
	</cffunction>  
    
    <cffunction name="Updt_FundInfo" access="remote" returntype="string" hint="This function is called to check the Fund table against SAMS Fund table">
     
     	<cfargument name="Fund_Num" type="string" required="Yes">
        <cfargument name="FY" type="string" required="Yes">
        <cfargument name="Fund_Name" type="string" required="Yes">
        <cfargument name="Class" type="string" required="Yes">
        <cfargument name="Category" type="string" required="Yes">
        <cfargument name="Fund_Group" type="string" required="Yes">
        <cfargument name="Fund_Type" type="string" required="Yes">
    
   		<cfoutput>
        <cfStoredProc datasource="SAMSMonthlyLoadDev" Procedure="Updt_FundNum">
        	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Num"  value="#trim(Fund_Num)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY"  value="#trim(FY)#">
            <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Fund_Name"  value="#trim(Fund_Name)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Class"  value="#trim(Class)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Category"  value="#trim(Category)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Group"  value="#trim(Fund_Group)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Fund_Type"  value="#trim(Fund_Type)#">
			<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckFundNumRetVal">
			<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckFundNumRetMsg">
		<cfprocresult name="UpdtFundNum">
		</cfstoredproc>
        </cfoutput>

		<cfreturn "#CheckFundNumRetVal#">
        
	</cffunction>  

</cfcomponent>