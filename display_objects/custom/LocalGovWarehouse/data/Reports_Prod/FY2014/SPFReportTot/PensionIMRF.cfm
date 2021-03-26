<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--->

<!---<html>
<head>
	<title>Pension Funds / Retirement Benefits</title>
</head>--->

<!--- 
Date Created: 4-3-13
Created By: Gary Ashbaugh

Description:  Allows the users to enter their pension information for the type of pensions he/she stated that he/she has on the registration side

 --->
 
 
 

<a name="IMRF"><br><br></a>      
     
<cfoutput><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/tri.gif"></cfoutput><a href="#IMRF">IMRF</a>&nbsp;&nbsp;&nbsp;<cfoutput><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/tri.gif"></cfoutput><a href="#Police">Police</a>&nbsp;&nbsp;&nbsp;<cfoutput><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/tri.gif"></cfoutput><a href="#Fire">Fire</a>
&nbsp;&nbsp;&nbsp;<cfoutput><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/tri.gif"></cfoutput><a href="#SLEP">SLEP</a>&nbsp;&nbsp;&nbsp;<cfoutput><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/tri.gif"></cfoutput><a href="#Other">Other</a>&nbsp;&nbsp;&nbsp;<cfoutput><img src="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/images/tri.gif"></cfoutput><a href="#OPEB">OPEB</a><br />



<table bgcolor="white" cellspacing="0" cellpadding="2" border="1" frame="box" width="100%">
<cfoutput>
<!--- IMRF, Police Pension, or Fire Pension --->
<tr>
<td  width="14%"><b><font size="-1">Field Description (Code)</font></b></td>
<td  colspan="3"><center><b><font size="-1">IMRF</font></b></center></td>
</tr>
<tr>
<td colspan="4"  align="center"><font size="-1">Report in Whole Numbers</font></td>
</tr>
<tr>
<td  width="14%">&nbsp;&nbsp;&nbsp;</td>
<td  width="8%"><center><font size="-1"><cfif trim(IMRF_t500_1) is not "">#ltrim(rtrim(DateFormat(IMRF_t500_1,"yyyy")))#<cfelse>Year 1</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(IMRF_t500_2) is not "">#ltrim(rtrim(DateFormat(IMRF_t500_2,"yyyy")))#<cfelse>Year 2</cfif></font></center></td>
<td  width="8%"><center><font size="-1"><cfif trim(IMRF_t500_3) is not "">#ltrim(rtrim(DateFormat(IMRF_t500_3,"yyyy")))#<cfelse>Year 3</cfif></font></center></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Actuarial Valuation Date (500)<cfif url.PrintIt is "No"></a></cfif></font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500_1,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500_2,"mm/dd/yyyy")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(DateFormat(IMRF_t500_3,"mm/dd/yyyy")))#</font></p></td></td>
</tr> 
<tr>
<td  width="14%"><p><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Pension Liability / Actuarial Accrued Liability (501)<cfif url.PrintIt is "No"></a></cfif></font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t501_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t501_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t501_3,"L999,999,999,999,999")))#</font></p></td></td>
</tr>
<tr>
<td  width="14%"><p><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Funded Pension / Actuarial Value of Assets (502)<cfif url.PrintIt is "No"></a></cfif></font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t502_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t502_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t502_3,"L999,999,999,999,999")))#</font></p></td></td>
</tr>
<!--- Calculated field (501-502) - User should NOT be able to change values. --->
<tr>
<td  width="14%"><p><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Unfunded Pension Liability (503)<cfif url.PrintIt is "No"></a></cfif></font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t503_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t503_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t503_3,"L999,999,999,999,999")))#</font></p></td></td>
</tr>	
<!--- Calculated field (502/501*100) - User should NOT be able to change values. --->
<tr>
<td  width="14%"><p><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Funded Ratio (504)<cfif url.PrintIt is "No"></a></cfif></font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t504_1,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t504_2,"L9,999,999,999,999.9")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t504_3,"L9,999,999,999,999.9")))#</font></p></td></td>
</tr>	
<tr>
<td  width="14%"><p><font size="-1"><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Net Pension Obligation / Net OPEB Obligation (505)<cfif url.PrintIt is "No"></a></cfif></font></p></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t505_1,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t505_2,"L999,999,999,999,999")))#</font></p></td></td>
<td width="8%" align="right"><p><font size="-1">#ltrim(rtrim(NumberFormat(IMRF_t505_3,"L999,999,999,999,999")))#</font></p></td></td>
</tr>
</cfoutput>
</table>	
<br />
<br />

<!---</body>
</html>--->
