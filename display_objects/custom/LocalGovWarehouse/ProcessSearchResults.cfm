
<cfparam name="attributes.showheader" default="No">     

<!--- attributes.DisplayMode
attributes.code
attributes.searchtype
attributes.govUnit
attributes.originalsearchstring
attributes.DestinationPage
attributes.CFY
attributes.ShowHeader
attributes.Unit_B_Code
attributes.AFRCFY
attributes.AFRDesiredData
attributes.Unit_B_FY --->

<!--- 
	Expects : DisplayMode - What Display to Show
	Expects : CFY - Fiscal Year to show. If none is selected, page should show most current available.
	Expects : Code - Code will have to be parsed
--->

<cfparam name="attributes.DisplayMode" default="getAFR">     
<cfparam name="attributes.code"  default="002/000/00">

<cfif isDefined("form.DisplayMode")>
  <cfset attributes.DisplayMode = form.DisplayMode>
<cfelseif isDefined("URL.DisplayMode")>
  <cfset attributes.DisplayMode = URL.DisplayMode>
</cfif>

<cfif isDefined("form.code")>
  <cfset attributes.code = form.code>
<cfelseif isDefined("URL.code")>
  <cfset attributes.code = URL.code>
</cfif>

<cfif isDefined("form.CFY")>
  <cfset attributes.CFY = form.CFY>
<cfelseif isDefined("URL.CFY")>
  <cfset attributes.CFY = URL.CFY>
<cfelse>
  <cfset attributes.CFY = "">  
</cfif>

<cfif isDefined("form.AFRDesiredData")>
  <cfset attributes.AFRDesiredData = form.AFRDesiredData>
<cfelseif isDefined("URL.AFRDesiredData")>
  <cfset attributes.AFRDesiredData = URL.AFRDesiredData>
<cfelse>  
  <cfset attributes.AFRDesiredData = "">  
</cfif>

<cfif isDefined("form.OriginalSearchString")>
  <cfset attributes.OriginalSearchString = form.OriginalSearchString>
<cfelseif isDefined("URL.OriginalSearchString")>
  <cfset attributes.OriginalSearchString = URL.OriginalSearchString>
<cfelse>
  <cfset attributes.OriginalSearchString = "">
</cfif>

<cfif isDefined("form.searchtype")>
  <cfset attributes.searchtype = form.searchtype>
<cfelseif isDefined("URL.searchtype")>
  <cfset attributes.searchtype = URL.searchtype>
<cfelse>
  <cfset attributes.searchtype = "">
</cfif>



	 <cfswitch expression="#attributes.DisplayMode#">
        
<cfcase value="GetLandingPage">
            
            <cfscript>param attributes.searchtype="AllUnits";</cfscript>
            
        <!--- hey hey<p><br /><br /><Br /><Br />hithere  <cfdump var="#form.govunit#"><cfabort>--->
            

            <cflocation url="/financial-data/local-government-division/local-government-data/landingpage/?code=#right(form.govUnit,10)#&searchtype=#form.SearchType#&originalSearchString=#form.govunit#" addtoken="false">
        
        </cfcase>
        
<!---- DRILLDOWN ---->
	
<cfcase value="drilldown">
			<!-- Added Error Trap for % --->
			        	
            <!---<cfdump var="#attributes#"><cfdump var="#url#">--->
            <cfparam name="attributes.originalsearchstring" default="#attributes.code#">
            <!---<cfparam name="attributes.originalsearchstring" default="#attributes.GovUnit#">--->
             <div class="jumbotron">
                <h3>Searching for <cfoutput>"#attributes.originalsearchstring#" <cfif attributes.searchtype neq "AllUnits"> in 
                
                <cfswitch expression="#attributes.searchtype#">
                	<cfcase value="AFRSearch">
                    	Annual Financial Reports
                    </cfcase>
                	<cfcase value="AuditSearch">
                    	Annual Audits
                    </cfcase>
                    <cfcase value="TIFSearch">
                    	Tax Increment Financial Reports
                    </cfcase>
                     <cfcase value="SpecialTaxingDistricts">
                    	Special Purpose Districts
                    </cfcase>
                    <cfdefaultcase>
                    	#attributes.SearchType#
                    </cfdefaultcase>
                </cfswitch>
                <!---#attributes.SearchType#---></cfif></cfoutput></h3>
               </div>

               <!---<cfdump var="#attributes.searchtype#">--->
               <cfswitch expression="#attributes.SearchType#">
               
               <cfcase value="AllUnits">
               		<!---
               
                    <cfquery name="getLocalUnits" datasource="#application.LocGovWarehouse#">
                    Select Name as GovernmentName from  FilteredSearchByAll
                    WHERE Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#attributes.originalsearchstring#%">
                    order by GovernmentName
                    </cfquery>   
                    <ul>
                    <cfparam name="attributes.DestinationPage" default="">
                    <cfif attributes.destinationPage eq "ComparePage">
                    	<cfset variables.GoToURL="UnitToCompareStage.cfm?">
                    <cfelse>
                    	<cfset variables.GoToURL = "LandingPage.cfm?">
					</cfif>                        
                    <cfoutput query="getLocalUnits">
                    <li><a href="#variables.GoToURL#Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a></li>
                    </cfoutput>
                    </ul>
					--->
                    
                    
                    <!--- Option A --->
                    <!---
                    <cfstoredproc datasource="LocGovWarehouse" procedure="Get_WHFilterAllUnits">
                      <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#attributes.originalsearchstring#" dbvarname="@SearchCriteria">
                      <!---<cfprocparam type="out" cfsqltype="cf_sql_integer" dbvarname="@RetVal">
                      <cfprocparam type="out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg">--->
                    <cfprocresult name="getLocalUnits" resultset="1">
                    </cfstoredproc>
					--->
                    
                    <!--- Option C --->
                    <!---
                    <cfstoredproc datasource="LocGovWarehouse" procedure="Get_WHFilterAllUnitsOptionC">
                      <cfprocparam type="in" cfsqltype="cf_sql_varchar" value="#attributes.originalsearchstring#" dbvarname="@SearchCriteria">
                    <cfprocresult name="getLocalUnits" resultset="1">
                    </cfstoredproc>
					--->
                    
                    <!---
                    <cfif cgi.http_referer contains "index_option_a">
					<cfscript>
				 	q = new storedProc();
					q.setDatasource("LocGovWarehouse");
					q.setProcedure("Get_WHFilterAllUnitsOptionA");
					q.addParam(cfsqltype="cf_sql_varchar", type="in", value=attributes.originalsearchstring, dbvarname="@SearchCriteria");   
					q.addProcResult(name="rs1",resultset=1); 
					result = q.execute();
					getLocalUnits=result.getProcResultSets().rs1;
					</cfscript>
                    <cfelse>
					--->
                    <cfscript>
				 	q = new storedProc();
					q.setDatasource("LocGovWarehouse");
					q.setProcedure("Get_WHFilterAllUnitsOptionC");
					q.addParam(cfsqltype="cf_sql_varchar", type="in", value=attributes.originalsearchstring, dbvarname="@SearchCriteria");   
					q.addProcResult(name="rs1",resultset=1); 
					result = q.execute();
					getLocalUnits=result.getProcResultSets().rs1;
					</cfscript>
                    <!---
                    </cfif>
					--->
                    
                    <!---<cfscript>
				 	q = new storedProc();
					q.setDatasource("LocGovWarehouse");
					q.setProcedure("Get_WHFilterAllUnitsASP");
					q.addParam(cfsqltype="cf_sql_varchar", type="in", value=attributes.originalsearchstring, dbvarname="@SearchCriteria");   
					q.addProcResult(name="rs1",resultset=1); 
					result = q.execute();
					getLocalUnits=result.getProcResultSets().rs1;
					</cfscript>--->
                    
                    <ul>
                    <cfparam name="attributes.DestinationPage" default="">
                    <cfif attributes.destinationPage eq "ComparePage">
                    	<cfset variables.GoToURL="UnitToCompareStage.cfm?">
                    <cfelse>
                    	<cfset variables.GoToURL = "LandingPage.cfm?">
					</cfif>                        
                    <cfoutput query="getLocalUnits">
                    <li><a href="#variables.GoToURL#Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a></li>
                    </cfoutput>
                    </ul>
               </cfcase>

              
               <cfcase value="SpecialTaxingDistricts">
                    <cfquery name="getLocalUnits" datasource="#application.LocGovWarehouse#">
                    Select Name as GovernmentName from FilteredSearchBySpecialTaxingDistricts	
                    WHERE Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#attributes.originalsearchstring#%">
                    order by GovernmentName
                    </cfquery>       
                    <ul>
                    <cfoutput query="getLocalUnits">
                    <li>
                      <a href="/financial-data/local-government-division/local-government-data/landingpage/?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#"></a>
                      <!--- <a href="LandingPage.cfm?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a> --->
                    </li>
                    </cfoutput>
                    </ul>
               </cfcase>

               <cfcase value="Townships">
                    <cfquery name="getLocalUnits" datasource="#application.LocGovWarehouse#">
                    Select Name as GovernmentName from FilteredSearchByTownships	
                    WHERE Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#attributes.originalsearchstring#%">
                    </cfquery>               
                    <ul>
                    <cfoutput query="getLocalUnits">
                    <li>
                      <!--- <a href="LandingPage.cfm?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a> --->
                      <a href="/financial-data/local-government-division/local-government-data/landingpage/?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a>
                    </li>
                    </cfoutput>
                    </ul>
               </cfcase>
               
               <cfcase value="Municipalities">
                   <cfquery name="getLocalUnits" datasource="#application.LocGovWarehouse#">
                    Select Name as GovernmentName from FilteredSearchByMunicipalities	
                    WHERE Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#attributes.originalsearchstring#%">
                    order by GovernmentName
                    </cfquery>
                   <ul>
                   <cfoutput query="getLocalUnits">
                   <li>
                     <a href="/financial-data/local-government-division/local-government-data/landingpage/?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a>
                    <!--- <a href="LandingPage.cfm?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a> --->
                   </li>
                   </cfoutput>
                   </ul>
               </cfcase>
               <cfcase value="Counties">
				   <!---<cfinvoke component="/includedSearchByName/NameSearch" method="getCounties" returnvariable="getLocalUnits">
                    <cfinvokeargument name="string" value="%#attributes.code#%">
                   </cfinvoke>--->
                    <cfquery name="getLocalUnits" datasource="#application.LocGovWarehouse#">
                    Select Name as GovernmentName 
                    from FilteredSearchByCounties	
                    WHERE Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#attributes.originalsearchstring#%">
                    </cfquery>
                  <ul>
                   <cfoutput query="getLocalUnits">
                   <li>
                    <!--- <a href="LandingPage.cfm?Code=#Right(GovernmentName,10)#">#GovernmentName#</a> --->
                    <a href="/financial-data/local-government-division/local-government-data/landingpage/?Code=#Right(GovernmentName,10)#">#GovernmentName#</a>
                   </li>
                   </cfoutput>
                   </ul>
                  
               </cfcase>
               <cfcase value="AuditSearch">
               		<!---
                   <cfquery name="getLocalUnits" datasource="#application.LocGovWarehouse#">
                    Select Name as GovernmentName from FilteredSearchByAudits	
                    WHERE Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#attributes.originalsearchstring#%">
                    order by GovernmentName
                    </cfquery>               
					--->
                    
                    <cfscript>
				 	q = new storedProc();
					q.setDatasource("LocGovWarehouse");
					q.setProcedure("Get_WHFilterByAuditsOptionC");
					q.addParam(cfsqltype="cf_sql_varchar", type="in", value=attributes.originalsearchstring, dbvarname="@SearchCriteria");   
					q.addProcResult(name="rs1",resultset=1); 
					result = q.execute();
					getLocalUnits=result.getProcResultSets().rs1;
					</cfscript>
					<ul>
                   <cfoutput query="getLocalUnits">
                   <li>
                    <!--- <a href="LandingPage.cfm?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a> --->
                    <a href="/financial-data/local-government-division/local-government-data/landingpage/?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a>
                   </li>
                   </cfoutput>
                   </ul>
               </cfcase>
               <cfcase value="TifSearch">
                   <cfquery name="getLocalUnits" datasource="#application.LocGovWarehouse#">
                    Select Name as GovernmentName from FilteredSearchByTIFs	
                    WHERE Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#attributes.originalsearchstring#%">
                    order by GovernmentName
                    </cfquery>               <ul>
                   <cfoutput query="getLocalUnits">
                   <li>
                    <!--- <a href="LandingPage.cfm?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a> --->
                    <a href="/financial-data/local-government-division/local-government-data/landingpage/?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a>
                   </li>
                   </cfoutput>
                   </ul>
               </cfcase>        
               
               <cfcase value="AFRSearch">
               
               		<cfscript>
				 	q = new storedProc();
					q.setDatasource("LocGovWarehouse");
					q.setProcedure("Get_WHFilterAllUnitsOptionC");
					q.addParam(cfsqltype="cf_sql_varchar", type="in", value=attributes.originalsearchstring, dbvarname="@SearchCriteria");   
					q.addProcResult(name="rs1",resultset=1); 
					result = q.execute();
					getLocalUnits=result.getProcResultSets().rs1;
					</cfscript>
               
               <!---
                   <cfquery name="getLocalUnits" datasource="#application.LocGovWarehouse#">
                    Select Name as GovernmentName from FilteredSearchByAll
                    WHERE Name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#attributes.originalsearchstring#%">
                    order by GovernmentName
                    </cfquery> --->
                    
                   <ul>
                   <cfoutput query="getLocalUnits">
                   <li>
                    <!--- <a href="LandingPage.cfm?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a> --->
                    <a href="/financial-data/local-government-division/local-government-data/landingpage/?Code=#Right(GovernmentName,10)#">#Left(GovernmentName,Len(GovernmentName)-13)#</a>
                   </li>
                   </cfoutput>
                   </ul>
               </cfcase>                                        
               
               </cfswitch>
               
  		<cfif not getLocalUnits.recordcount>
                  <p>Sorry, no results found.</p>
         </cfif>
        </cfcase>
		
		
		<!--- Get an AFR --->
<cfcase value="getAFR">

            <cfset url.code="#trim(attributes.code)#">
            
            <cfset url.CFY = "#trim(attributes.CFY)#">
            
            <cfset url.Menu="Yes">
            <cfset url.PrintIt="No">
            <cfset url.AFRDesiredData="#trim(attributes.AFRDesiredData)#">

            <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
        method = "FormSubmitted" 
        Code = "#trim(attributes.Code)#" 
        pagename="#trim(Attributes.AFRDesiredData)#" 
        CFY="#trim(attributes.CFY)#" 
        returnVariable = "DataEntryType">
        
             <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
        method = "PageInfo" 
        CFY = "#trim(attributes.CFY)#" 
        PageName="#trim(attributes.AFRDesiredData)#"  
        FormType="#trim(DataEntryType)#" 
        PageType="AFR" 
        returnVariable = "AFRPage">

<!---         <cfdump var="#AFRPage#" abort="true"> --->
            <!--- TODO: PROCESS WHICH PAGE TO GIVE THE USER BASED ON THE STORED PROC THAT CALLS THE CROSSWALK TABLE GARY MADE --->
            <!--- <cftry> --->
           <CFinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/data#AFRPage#">
    		<!--- <cfcatch type="any">
            	<cflocation url="FilteredSearching.cfm?SearchType=ErrorMsg">
            </cfcatch>
            </cftry> --->
            
            <!---<cfcatch type="any">
            <p>Unit Name is not given.<cfabort></p>
            </cfcatch>
            </cftry>--->
             <!---</DIV>--->
		</cfcase>

     <!--- Get Summary Pages --->   
     <cfcase value="getAFRSummary">
     	
     	<cfif attributes.code is "">Sorry, no data available. Please try another search!<cfabort></cfif>

        <cfset url.Code="#trim(attributes.code)#">
        <cfset url.CFY = "#trim(attributes.CFY)#">
        
        <cfset url.Menu="No">
        <cfset url.PrintIt="No">
        <cfset url.AFRDesiredData="#trim(attributes.AFRDesiredData)#">

        <!--- Determine the type of form the local unit submitted --->
        <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
        method = "FormSubmitted" 
        Code = "#trim(url.Code)#" 
        pagename="#trim(attributes.AFRDesiredData)#" 
        CFY="#trim(url.CFY)#" 
        returnVariable = "DataEntryType">

        <!--- Determine the name of the .cfm page that should have been filled out --->
        <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
        method = "PageInfo" 
        CFY = "#trim(url.CFY)#" 
        PageName="#trim(Attributes.AFRDesiredData)#"  
        FormType="#trim(DataEntryType)#" 
        PageType="AFRSummary" 
        returnVariable = "AFRPage">

        <!--- TODO: PROCESS WHICH PAGE TO GIVE THE USER BASED ON THE STORED PROC THAT CALLS THE CROSSWALK TABLE GARY MADE --->

		<cfStoredProc datasource="#application.LocGovWarehouse#" PROCEDURE="Get_UnitScreensLastThreeFiscalYears">
        	<cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(attributes.Code)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#attributes.CFY#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@PageTYpe" VALUE="AFRSummary">
            <cfprocresult NAME="GetUnitScreens2">
        </cfstoredproc> 
        
        <!--- check for a match on GetUnitScreens2.FY=attributes.cfy and GetUnitScreens2.SummaryFileName=AFRPage --->
        <cfloop query="GetUnitScreens2">
       
       		<cfif isdefined("AFRPage")>
        		<cfset variables.AFRPageCompare = listlast(afrpage,"/")>
        	<cfelse>
            	<cfset variables.AFRPageCompare = "">
             </cfif>
			 <cfoutput>
            <!--- <p>#GetUnitScreens2.FY# eq #attributes.cfy#) and (#GetUnitScreens2.SummaryFileName# eq #variables.AFRPageCompare#</p>--->
             <cfif (GetUnitScreens2.FY eq attributes.cfy) and (GetUnitScreens2.SummaryFileName eq variables.AFRPageCompare)>
				<CFSET VARIABLES.ProceedToAFRSummaryPage = "Yes"><!---<p>hit</p>--->
             <!---<cfelse>
             	<p>miss</p>--->
             </cfif>
             </cfoutput>
        </cfloop>
        
        <!---<cfif isDefined("variables.proceedtoafrsummarypage")>defined<cfelse>notdefined</cfif>
        
       <cfdump var="#getunitscreens2#">+++<cfdump var="#AFRPage#"><cfdump var="#attributes.CFY#"><cfabort>--->

        		   	<cfif isDefined("variables.proceedtoafrsummarypage")>
				<!---<cftry>--->
           		<CFinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/data#AFRPage#">
                <!---<cfcatch type="any">
                	<cflocation url="FilteredSearching.cfm?SearchType=ErrorMsg">
                </cfcatch>
                </cftry>--->
    
            <cfelse>

            	<!---<p><cflocation url="UnitToCompareStage.cfm?ShowHeader=#attributes.ShowHeader#&DisplayMode=GetAFRSummary&Code=#attributes.code#&CFY=#Unit_A_CFY#"></p><!---&Unit_A_Code=#attributes.code#&Unit_A_FY=#Unit_A_FY#--->--->
              <!---   UnitToCompareStage.cfm
              /financial-data/local-government-division/local-government-data/UnitToCompareStage/ --->              
<!---             <cfdump var="/financial-data/local-government-division/local-government-data/UnitToCompareStage/?ShowHeader=#attributes.ShowHeader#&DisplayMode=GetAFRSummary&Code=#attributes.code#&CFY=#attributes.CFY#&OriginalSearchString=#attributes.OriginalSearchString#" abort="true"> --->

            	<p><cflocation url="/financial-data/local-government-division/local-government-data/UnitToCompareStage/?ShowHeader=#attributes.ShowHeader#&DisplayMode=GetAFRSummary&Code=#attributes.code#&CFY=#attributes.CFY#&OriginalSearchString=#attributes.OriginalSearchString#"></p><!---&Unit_A_Code=#attributes.code#&Unit_A_FY=#Unit_A_FY#--->
            </cfif>
            
            <!---<cfcatch type="any">
            <p>Unit Name is not given.<cfabort></p>
            </cfcatch>
            </cftry>--->

		</cfcase>

	<cfcase value="ComparePrelim">
         
         <cfif Form.govunit eq "">
         	<p style="margin-top:100px;">Please go back and enter your comparative unit.</p>
         </cfif>
         <cfif form.GovUnit does not contain "/" and attributes.GovUnit does not contain "County">
         	<cfset attributes.DestinationPage = "ComparePage">
         <cfelse>
         	<cfset attributes.DestinationPage = "LandingPage">   
         </cfif>

         <p style="margin-top:100px;"></p>
                 
        <cfset Unit_B_Code = Right(form.GovUnit,10)>
        <CFPARAM name="attributes.Unit_B_FY" default="">
        <cfparam name="attributes.ShowHeader" default="yes">
        <cflocation url="/financial-data/local-government-division/local-government-data/compare-prelim/?Unit_A_Code=#form.code#&Unit_B_Code=#Unit_B_Code#&Unit_A_FY=#form.AFRCFY#&AFRDesiredData=#form.AFRDesiredData#&Unit_B_FY=#attributes.Unit_B_FY#&DestinationPage=#attributes.DestinationPage#&ShowHeader=#attributes.ShowHeader#&OriginalSearchString=#URLEncodedFormat(form.GovUnit)#">
        
    </cfcase>

<!---	<cfcase value="CompareAFRs">
         
        <cfset Unit_B_Code = Right(attributes.GovUnit,10)>
        
        <cfdump var="#Unit_B_Code#">
        <!---<cfabort>--->
        <cflocation url="Compare.cfm?Unit_A_Code=#attributes.code#&Unit_B_Code=#Unit_B_Code#&Unit_A_FY=#attributes.Unit_A_FY#&Unit_B_FY=#attributes.Unit_B_FY#">
        
    </cfcase>--->
	
	<cfcase value="getListOnly">
      <!---<div class="hero-unit">
          <h1 style="text-align:center; font-size:2.9em;">AFR for Bartonville Village</h1>
          <h2 style="text-align:center;">Select Year</h2>
      <!---TODO: Loop through a query here to display Fiscal years that the Local Unit has submitted an AFR --->
      <ul class="inline">
      	<li><a>2013</a></li>
        <li><a>2012</a></li>
        <li><a>2011</a></li>
      </ul>          
      </div>	--->	
     </cfcase>
     
	<cfdefaultcase>
    Nothing to see here
    
    </cfdefaultcase>
    </cfswitch>

