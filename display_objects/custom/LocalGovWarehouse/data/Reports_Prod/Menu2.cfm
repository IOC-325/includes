<cfoutput>
<cfparam name="url.PageName" default="Assets">
<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
	method = "ListofPages" 
	CFY = "#url.CFY#" 
    FormType = "#url.FormType#" 
	returnVariable = "ListOfPages"></cfinvoke>
</cfoutput>
<ul class="smallmenu">
    <li><span>Choose from the following:</span></li><cfoutput query="ListOfPages"><li><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GETAFR&AFRDesiredData=#PageName#&Code=#url.Code#&CFY=#url.CFY#&Menu=Yes&PrintIt=No">#AFRDropDOwn#</a></li></cfoutput>
</ul>
