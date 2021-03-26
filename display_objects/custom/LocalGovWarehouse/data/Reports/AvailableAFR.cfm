<!---* For the original code, see commented out code below --->
<cfoutput>
<cfparam name="url.PageName" default="Assets">
<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
	method = "FYSubmitted" 
	Code = "#url.Code#" 
	returnVariable = "YearsSubmitted">
</cfoutput>

<cfset PFY=application.LocGovWarehouseCFY-1>
<cfset PFY2=application.LocGovWarehouseCFY-2>
<cfset Years="#application.LocGovWarehouseCFY#,#PFY#,#PFY2#">

<div class="years-display text-center">
<ul>
<!--- Show all years but only hyperlink the ones submitted and not the current year user is viewing --->
<cfloop index="i" list="#Years#">
<cfoutput>
<cfif listcontains('#YearsSubmitted#','#I#') and (i is not url.CFY)>
    <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
        method = "FormSubmitted" 
        Code = "#url.Code#" 
        CFY = "#i#" 
        returnVariable = "FormSubmitted">
        <cfif trim(FormSubmitted) is not "">
             <li><a class="small-btn" href="/financial-data/local-government-division/local-government-data/processsearchresult/?AFRDesiredData=#url.PageName#&Code=#url.Code#&CFY=#i#&Menu=Yes&PrintIt=No"><span class="glyphicon glyphicon-search"></span>#i#</a></li>
        </cfif>
<cfelse>
    	<cfif i is url.CFY>
        	<li><span class="glyphicon glyphicon-check"></span>#i#</li>
        <cfelse>
            <li><span class="glyphicon glyphicon-ban-circle"></span><a title="The #i# AFR has either NOT been submitted or an amendment is currently being filed on it.">#i#</a></li>
        </cfif>

</cfif>
</cfoutput>
</cfloop>
    </ul>
</div>
<!---*

<!--- <!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->

Date Created 9-4-13
Created By: Gary Ashbaugh
Description:  SHows the available FYs for a particular unit of government and page
--->
<!---
<html>
<head>
	<title>Error</title>
</head>

<body>
--->
<!---
<script src="/assets/js/bootstrap.min.js"></script>
--->
<cfoutput>
<cfparam name="url.PageName" default="Assets">
<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
	method = "FYSubmitted" 
	Code = "#url.Code#" 
	returnVariable = "YearsSubmitted">
</cfoutput>

<cfset PFY=application.LocGovWarehouseCFY-1>
<cfset PFY2=application.LocGovWarehouseCFY-2>
<cfset Years="#application.LocGovWarehouseCFY#,#PFY#,#PFY2#">

<!---*<table bgcolor="White" cellspacing="0" cellpadding="2" border="0" frame="box" width="100%">
<tr><td valign="middle" align="center"><center>--->
<!--- Show all years but only hyperlink the ones submitted and not the current year user is viewing --->
<cfloop index="i" list="#Years#">
<cfoutput>
<cfif listcontains('#YearsSubmitted#','#I#') and (i is not url.CFY)>
    <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
        method = "FormSubmitted" 
        Code = "#url.Code#" 
        CFY = "#i#" 
        returnVariable = "FormSubmitted">
        
        
        <cfif trim(FormSubmitted) is not "">
          
          	<!---
            <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
            method = "PageInfo" 
            CFY = "#i#" 
            PageName = "#url.PageName#" 
            FormType = "#FormSubmitted#" 
            PageType = "AFR" 
            returnVariable = "SummaryPageInfo"> SummaryPageInfo=#SummaryPageInfo#
			
            
            <Font size="-1"><b><a href="/data/#SummaryPageInfo#?Code=#url.Code#&CFY=#i#&Menu=No">#i#</a></b></Font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             --->
             <Font size="-1"><b><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?AFRDesiredData=#url.PageName#&Code=#url.Code#&CFY=#i#&Menu=Yes&PrintIt=No">#i#</a></b></Font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             
        </cfif>
<cfelse>
    	<cfif i is url.CFY>
        	<img src="/images/tri.gif" alt="Viewing #i# FY"  align="middle"><Font size="-1"><b>&nbsp;#i#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></Font>
        <cfelse>
    		<Font size="-1"><b><a style="text-decoration:none; color:black;" title="The #i# AFR has either NOT been submitted or an amendment is currently being filed on it.">#i#</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></Font>
            <!---<a href="##" style="text-decoration:none; color:black; cursor:help;" data-toggle="tooltip" title="The #i# AFR has either NOT been submitted or an amendment is currently being filed on it.">#i#</a>--->


</div>
        </cfif><!---data-toggle="tooltip"--->

</cfif>
</cfoutput>
</cfloop>


<!--- Show and hyperlink only ones submitted and not the current year user is viewing --->
<!---
<cfloop index="i" list="#YearsSubmitted#">
<cfoutput>
<cfif url.CFY is not #i#>
    <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
        method = "FormSubmitted" 
        Code = "#url.Code#" 
        CFY = "#i#" 
        returnVariable = "FormSubmitted">
        
        
        <cfif trim(FormSubmitted) is not "">
          
            <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
            method = "PageInfo" 
            CFY = "#i#" 
            PageName = "#url.PageName#" 
            FormType = "#FormSubmitted#" 
            PageType = "AFR" 
            returnVariable = "SummaryPageInfo"> 
            
            <Font size="-1"><b><cfif url.PrintIt is "No"><a href="/data/#SummaryPageInfo#?Code=#url.Code#&CFY=#i#&Menu=No">#i#</a><cfelse>#i#</cfif></b></Font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             
        </cfif>

</cfif>
</cfoutput>
</cfloop>
--->
<!---</center>
</td></tr>
</table>--->
<br><br>

<!---
<!---</body>
</html>--->
--->
--->