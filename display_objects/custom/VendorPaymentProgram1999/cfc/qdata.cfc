
<cfcomponent> 
 <!--- <CFSET application.datasource = "General">   --->

  

   <!---  Get Fiscal year data from table    --->
   <cffunction  name="GetFYData"  output="no" returntype="query" access="remote" >
    <cfset var qFYdata = "FY">          
        <cfquery name="qFYdata" datasource="#application.datasource#">
            SELECT distinct FY
            FROM dbo.Financial_report
            where active = 'Y'            
            ORDER BY FY    
        </cfquery>
    
        <cfreturn qFYdata>
    </cffunction>

  
    <!---  Get QualifiedPurchaser data from table information --->   
   <cffunction  name="getQPByGroup" access="remote" output="false" returntype="query"> 
   <cfargument name="FY"  type="any" required="no">      
    <cfset var qQPByGroup = "Unitname">   
        <cfquery name="qQPByGroup" datasource="#application.datasource#">
            SELECT distinct FY, QualifiedPurchaser
            FROM dbo.Financial_report 
             where FY =  <cfqueryparam cfsqltype="cf_sql_varchar" value='#arguments.FY#'>                
            ORDER BY QualifiedPurchaser
        </cfquery>
    
        <cfreturn qQPByGroup>
    </cffunction> 

     <!---  Get Entity data table information --->   
   <cffunction  name="getEntityNameByGroup" access="remote" output="false" returntype="query"> 
   <cfargument name="FY"  type="any" required="no" default="">
   <cfargument name="QualifiedPurchaser" type="any" required="no" default="">      
    <cfset var qEntityNameByGroup = "County">   
        <cfquery name="qEntityNameByGroup" datasource="#application.datasource#">
            SELECT  Entity
            FROM dbo.Financial_report 
             where 1=1
             <cfif arguments.FY neq "">
            AND FY =  <cfqueryparam cfsqltype="cf_sql_varchar" value='#arguments.FY#'> </cfif>
             <cfif arguments.QualifiedPurchaser neq "">
            AND QualifiedPurchaser =  <cfqueryparam cfsqltype="cf_sql_varchar" value='#arguments.QualifiedPurchaser#'>
               </cfif> 
            ORDER BY Entity
        </cfquery>
    
        <cfreturn qEntityNameByGroup>
    </cffunction> 
   
</cfcomponent>