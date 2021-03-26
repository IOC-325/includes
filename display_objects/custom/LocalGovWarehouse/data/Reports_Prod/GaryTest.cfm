<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body><!--- 
<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
    method = "GeneralUnitInfo" 
    Code = "999/999/00" 
    returnVariable = "GeneralInfo">
    
    <cfdump var="#GeneralInfo#">
 
<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
    method = "FYSubmitted" 
    Code = "072/010/33" 
    returnVariable = "FYSubmitted">
    
  <cfdump var="#FYSubmitted#"><cfabort>
  --->                                  
<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
    method = "FormSubmitted" 
    Code = "083/710/51" 
    CFY = "2011" 
    returnVariable = "FormSubmitted">
                                                                
<cfdump var="#FormSubmitted#">

<!---
<cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
    method = "Screens4Unit" 
    Code = "999/999/00" 
    CFY="2011"
    returnVariable = "AvailableScreens">
    
    <cfdump var="#AvailableScreens#">
--->
<!---</body>
</html>--->