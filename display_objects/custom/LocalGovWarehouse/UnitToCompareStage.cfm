
<!---<cfstoredproc datasource="#application.SQLSource#" procedure="Get_WH_LandingPageContactInfo" result="Landing_Page_Header">
      <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="Code" value="#attributes.code#">
      <cfprocresult name="LandingPageContactInfo">
</cfstoredproc>--->

<!--- First, check to see if we get a hit. --->


<cfif isDefined("form.DisplayMode")>
  <cfset attributes.DisplayMode = form.DisplayMode>
<cfelseif isDefined("URL.DisplayMode")>
  <cfset attributes.DisplayMode = URL.DisplayMode>
</cfif>

<cfif isDefined("form.ShowHeader")>
  <cfset attributes.ShowHeader = form.ShowHeader>
<cfelseif isDefined("URL.ShowHeader")>
  <cfset attributes.ShowHeader = URL.ShowHeader>
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
</cfif>

<cfif isDefined("form.OriginalSearchString")>
  <cfset attributes.OriginalSearchString = form.OriginalSearchString>
<cfelseif isDefined("URL.OriginalSearchString")>
  <cfset attributes.OriginalSearchString = URL.OriginalSearchString>
</cfif>

<cfstoredproc datasource="#application.SQLSource#" procedure="Get_WH_LandingPageContactInfo" result="Landing_Page_Header">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#attributes.code#">
      <cfprocresult name="LandingPageContactInfo">
</cfstoredproc>
          
<cfif not LandingPageContactInfo.RecordCount>
  <!---<cfdump var="#attributes.OriginalSearchString#"><cfabort>--->
   <cflocation url="ProcessSearchResults.cfm?DisplayMode=Drilldown&Showheader=No&Code=#attributes.code#&DestinationPage=ComparePage&SearchType=AllUnits&CFY=&OriginalSearchString=#attributes.OriginalSearchString#">
                  
<cfelse>

<cfoutput>
<!---<h2 class="form-signin-heading">--->
        <div class="gray-div myjumbotron">
        <h1 class="pageTitle"><span>#LandingPageContactInfo.UnitNAme# - A #LandingPageContactInfo.Description# in #LandingPageContactInfo.County# County</span></h1>
    </div>
</cfoutput>
<!---govUnit--->
      <form class="form-horizontal" action="/financial-data/local-government-division/local-government-data/processsearchresult/" method="post" name="View_AFR" id="View_AFR">
      	<input type="hidden" name="DisplayMode" value="GetAFRSummary">
        <cfoutput>
        	<input type="hidden" name="Code" value="#attributes.code#">
            <cfparam name="attributes.showheader" default="No">
            <input type="hidden" name="ShowHeader" value="#attributes.ShowHeader#">
            <input type="hidden" name="OriginalSearchString" value="#attributes.OriginalSearchString#">
       </cfoutput>

        <cfStoredProc datasource="#application.SQLSource#" PROCEDURE="Get_UnitScreensLastThreeFiscalYears">
        	<cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(attributes.Code)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#attributes.CFY#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@PageTYpe" VALUE="AFRSummary">
            <cfprocresult NAME="GetUnitScreens2">
        </cfstoredproc>

        <div class="row">
        <div class="col-sm-offset-1 col-sm-10">
        <div class="form-group">
        <label class="col-sm-5 control-label">Select Fiscal Year</label>

    <cfset Attributes.Query="GetUnitScreens2">
            <cfset Attributes.NAME1="CFY">
            <cfset Attributes.NAME2="AFRDesiredData">
            <cfset Attributes.DISPLAY1="FY">
            <cfset Attributes.DISPLAY2="PAGENAME">     
            <cfset Attributes.VALUE1="FY">                   
            <cfset Attributes.VALUE2="PAGENAME">
            <cfset Attributes.SIZE1="1">
            <cfset Attributes.SIZE2="1">
            <cfset Attributes.AUTOSELECTFIRST="No">
            <cfset Attributes.FORMNAME="View_AFR">
            <cfset Attributes.HTMLBETWEEN="Select Desired Data">

            <cfinclude template="TwoSelectsRelated.cfm">

          <!--- <CF_TwoSelectsRelated
            QUERY="GetUnitScreens2"
            NAME1="CFY"
            NAME2="AFRDesiredData"
            DISPLAY1="FY"
            DISPLAY2="PAGENAME"
            VALUE1="FY"
            VALUE2="PAGENAME"
            SIZE1="1"
            SIZE2="1"
            AUTOSELECTFIRST="No"
            FORMNAME="View_AFR"
            HTMLBETWEEN="<br /> Select Desired Data &nbsp;"> --->
    </div>
    </div>
    <div class="text-center">
        <button class="btn btn-primary" style="" type="submit">Show Me the Data</button>
    </div>

      </form>

<!---

<form class="Landing-Page-Form" action="ProcessSearchResults.cfm" method="post" name="View_AFR" id="View_AFR">
             <input type="hidden" name="DisplayMode" value="GetAFR">
          	<cfoutput><input type="text" name="Code" value="#attributes.code#"></cfoutput>
                                           
         <cfStoredProc datasource="#application.SQLSource#" PROCEDURE="Get_UnitScreensLastThreeFiscalYears">
        	<cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@Code" VALUE="#trim(attributes.Code)#">
            <cfprocparam TYPE="in" CFSQLTYPE="cf_sql_char" DBVARNAME="@FY" VALUE="#application.CFY#">
            <cfprocresult NAME="GetUnitScreens">
        </cfstoredproc>          
          
          <p>Select Fiscal Year&nbsp; &nbsp; &nbsp; 
          <CF_TwoSelectsRelated
            QUERY="GetUnitScreens"
            NAME1="CFY"
            NAME2="AFRDesiredData"
            DISPLAY1="FY"
            DISPLAY2="PAGENAME"
            VALUE1="FY"
            VALUE2="PAGENAME"
            SIZE1="1"
            SIZE2="1"
            AUTOSELECTFIRST="No"
            FORMNAME="View_AFR"
            HTMLBETWEEN="<br /> Select Desired Data &nbsp;">   
            
            <br /><button class="btn btn-lg btn-primary" style="margin-left:100px;" type="submit">Show Me the Data</button>
           
           <!--- <label class="selectBox">Select Fiscal Year<select autofocus class="form-control" name="AFRCFY" id="AFRCFY">
            	<cfloop list="#yearsSubmitted#" index="ii">
                <cfoutput><option value="#ii#">#ii#</option></cfoutput>
                </cfloop>
                </select></label>
     
          	<label class="selectBox">Select Desired Data<select class="form-control" name="AFRDesiredData" id="AFRDesiredData">
            	<cfloop query="#ScreensAvailable#">
                	 <cfoutput><option value="#pagename#">#pagename#</option></cfoutput>
                </cfloop>
                <option value="All">All</option>             
            </select></label>--->
        
          </form>
		  --->
		  </cfif>
