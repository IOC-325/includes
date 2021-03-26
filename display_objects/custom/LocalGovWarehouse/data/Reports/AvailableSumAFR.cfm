<!--- <!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->


Date Created 9-4-13
Created By: Gary Ashbaugh
Description:  SHows the available FYs for a particular unit of government and page
--->

<!---<html>
<head>
	<title>Error</title>
</head>

<body>--->

<cfparam name="url.PageName" default="Assets">
<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
	method = "FYSubmitted" 
	Code = "#url.Code#" 
    returnVariable = "YearsSubmitted">
    

<cfset PFY = #Application.LocGovWarehouseCFY#-1>
<cfset PFY2 = #Application.LocGovWarehouseCFY#-2>
<cfset Years="#application.LocGovWarehouseCFY#,#PFY#,#PFY2#">


<div class="years-display text-center">
    <ul>
<!--- Show all years but only hyperlink the ones submitted and not the current year user is viewing --->
<cfloop index="i" list="#Years#">
<cfoutput>
	<cfif listcontains('#YearsSubmitted#','#I#') and i is not url.CFY>
    	<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
        method = "FormSubmitted" 
        Code = "#url.Code#" 
        CFY = "#i#" 
        returnVariable = "FormSubmitted">       

        <cfif trim(FormSubmitted) is not "">
           <li><a class="small-btn" href="/financial-data/local-government-division/local-government-data/processsearchresult/?ShowHeader=#attributes.showheader#&DisplayMode=GetAFRSummary&AFRDesiredData=#url.PageName#&Code=#url.Code#&CFY=#i#&Menu=No&PrintIt=No"><span class="glyphicon glyphicon-search"></span>#i#</a></li>
        </cfif>
    <cfelse>
    	<cfif i is url.CFY>
            <li><span class="glyphicon glyphicon-arrow-right"></span><span>#i#</span></li>
        <cfelse>
            <li><span class="glyphicon glyphicon-ban-circle"></span><a title="The #i# AFR has either NOT been submitted or an amendment is currently being filed on it.">#i#</a></li>
		<!---data-toggle="tooltip"--->
        
        </cfif>
	</cfif>
</cfoutput>
</cfloop>
</ul>
</div>
<!---<!---</body>
</html>--->--->
