<cfcomponent output="false">

<CFSET this.sessionManagement = true>
    <!--- NOTE: Timespan specs: CreatetimeSpan(days, hours, minutes, seconds) --->
    <CFSET this.sessiontimeout = createtimespan(0,3,0,90)>   
    <CFSET this.ApplicationTimeout = createtimespan(0,3,0,90)>
    <!--- Do not use Client Cookies. No need since we are not doing cross site transfers.---> 
    <CFSET This.SetClientCookies = false>    
    <cfsetting requesttimeout="0">
    <cfset executionStartTime = getTickCount() />
    
   <!--- OnRequest Start --->
	<cffunction access="public" name="onRequestStart">

        <cfif IsDefined("URL.reload")>
            <cfset OnApplicationStart()>
        </cfif>
    
    <!---Turn on Session Variables--->
    <cfif cgi.server_name CONTAINS 'dev'> 
        <CFSET this.name="APPLICATION_DEV">
        <CFSET application.datasource = "General">
    <cfelseif cgi.server_name CONTAINS 'uat'>
        <CFSET this.name="APPLICATION_UAT">
        <CFSET application.datasource = "General">
    <cfelse>
        <CFSET this.name="APPLICATION">
        <CFSET application.datasource = "General">
    </cfif>
</cffunction>
  
<!--- Initialize application variables --->       
<cffunction name="onApplicationStart" returnType="any">
    <CFSET application.Domain = "ioc\">
    <CFSET application.ADUserName = "SQLAdmin">
    <CFSET application.ADPWord = "WebGroup2005">
    <CFSET application.ADServer = "ioc.com">
    <CFSET application.ADIOCGroup = "IOCstaff">       
<cfif cgi.server_name CONTAINS 'dev'> 
        <CFSET application.homewww =  "http://gt.ioc-dev.ioc.com"> 
        <CFSET application.memberhomewww =  "http://gt.ioc-dev.ioc.com/Main">
        <CFSET application.WebSiteName = "DEV - Financal Report">        
        <CFSET application.RDAPath = "#expandPath('\RDA\')#">
<cfELSEIF cgi.server_name CONTAINS 'uat'> 
        <CFSET session.homewww = "https://2018-uat.illinoiscomptroller.gov">
        <CFSET Session.memberwww =  "https://2018-uat.illinoiscomptroller.gov/main">     
        <CFSET application.WebSiteName = "UAT - Financal Report">        
        <CFSET application.RDAPath = "#expandPath('\RDA\')#">
<cfelse>
<cfdump var="#application#" abort="true">        
<!--- <cfELSEIF cgi.server_name CONTAINS 'PROD'> 
        <CFSET application.homewww =  "http://gt.ioc-dev.ioc.com"> 
        <CFSET application.memberhomewww =  "http://gt.ioc-dev.ioc.com/Main">
        <CFSET application.WebSiteName = "PROD - Local Govt">
        <CFSET application.datasource = "AFRUAT">
        <CFSET application.RDAPath = "#expandPath('\RDA\')#">   --->      
</cfif>

</cffunction>  
  
	 <!--- Error Handler ---> 
    <cffunction name="onError">
	<cfargument name="exception" required="yes">
    <cfargument name="EventName" type="string" required="yes">
    
    <cfmail to="andy.peterson@IllinoisComptroller.Gov"  from="automessages@smtp.illinoiscomptroller.com" subject="IOC - prod.illinoiscomptroller.com - Error Notice" type="html">
          Event Name: #Arguments.Eventname# <BR><BR>
          Message:  #Arguments.Exception.message# <BR><BR>
         <CFIF IsDefined ("Arguments.Exception.rootcause")> 
           Root Cause Message: #Arguments.Exception.rootcause.message# <BR><BR>
 		 </CFIF>
         <CFIF IsDefined ("Session")> 
           <cfdump var="#Session#" label="Session">
 		 </CFIF> 
        <cfdump var="#cookie#" label="Cookies">
    	<cfdump var="#exception#" label="Exception">
        <cfdump var="#cgi#" label="cgi">
        <Cfdump var="#variables#" label="variables">
    </cfmail>   
<!--- INCASE YOUR WANT TO CREATE A PAGE THAT NOTIFIES THE USER AN ERROR WAS DETECTED .<cflocation url="AndyErrorPage.cfm"> --->
</cffunction>     
</cfcomponent>