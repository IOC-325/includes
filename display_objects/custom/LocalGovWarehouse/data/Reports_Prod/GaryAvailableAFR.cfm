<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->

<html>
<head>
	<title>Error</title>
</head>

<body>


<cfoutput>
<cfparam name="url.PageName" default="Assets">
<cfparam name="url.PageType" default="Summary">
<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
	method = "FYSubmitted" 
	Code = "#url.Code#" 
	returnVariable = "YearsSubmitted">
</cfoutput>
<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="55%">
<tr><td>

<cfloop index="i" list="#YearsSubmitted#">
<cfoutput>
<cfif url.CFY is not #i#>
    <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
        method = "FormSubmitted" 
        Code = "#url.Code#" 
        CFY = "#i#" 
        returnVariable = "FormSubmitted">
        
        
        <cfif trim(FormSubmitted) is not "">
        
        <!---
        	<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
            method = "Screens4Form" 
            CFY = "#url.CFY#" 
            FormType = "#FormSubmitted#" 
            returnVariable = "ScreensAvailable">
			
            <cfif isdefined("ScreensAvailable")>
                <cfloop Query="ScreensAvailable">
                  #ScreensAvailable.PageName#<br>
                </cfloop>
                <br>
             </cfif>
			 --->
             
             
            <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
            method = "PageInfo" 
            CFY = "#i#" 
            PageName = "#url.PageName#" 
            FormType = "#FormSubmitted#" 
            PageType = "#url.PageType#" 
            returnVariable = "SummaryPageInfo"> 
            
            <Font size="-1"><b><cfif url.PrintIt is "No"><a href="/data/#SummaryPageInfo#?Code=#url.Code#&CFY=#i#&Menu=No">#i#</a><cfelse>#i#</cfif></b></Font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             
        </cfif>

    <!---
	<cfset FileName = rereplace("#cgi.script_Name#","#url.CFY#","#i#","ALL")>
	<Font size="-1"><b><cfif url.PrintIt is "No"><a href="/data/reports/FY#i#/#FileName#?Code=#url.Code#&CFY=#i#">#i#</a><cfelse>#i#</cfif></b></Font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	--->
</cfif>
</cfoutput>
</cfloop>
</td></tr>
</table>
<br><br>
<!---</body>
</html>--->
