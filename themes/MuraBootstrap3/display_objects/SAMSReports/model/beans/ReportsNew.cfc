<cfcomponent>   
    <cffunction name="getListAgencies" access="remote" returntype="query" hint="This function is called to supply the initial values of the Agency selection box">
        <cfargument name="FY" type="string" required="No"><!---DB2DEV_REFUND--->
            <cfquery name="GetListAgencies" datasource="db2prd">
                            SELECT AGENCY,NAME,SHORT_NAME,CLASS,TYPE FROM WH.AGENCY WHERE WH.AGENCY.FISCAL_YEAR = <cfqueryparam value="#FY#" cfsqltype="cf_sql_integer"> AND (AGENCY >= '101' AND AGENCY <= '699') ORDER BY AGENCY ASC
            </cfquery>       
		<cfoutput>      
       	 <cfreturn GetListAgencies>
  		</cfoutput>
	</cffunction> 
</cfcomponent>