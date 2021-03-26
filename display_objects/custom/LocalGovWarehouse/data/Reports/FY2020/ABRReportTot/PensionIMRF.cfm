<!--- 
Date Created: 4-3-13
Created By: Gary Ashbaugh

Description:  Allows the users to enter their pension information for the type of pensions he/she stated that he/she has on the registration side

 ---> 

<a name="IMRF"></a>

<ul class="arrow-list">
    <li><span class="glyphicon glyphicon-play"></span>
        <a href="#IMRF">IMRF</a></li>
    <li><span class="glyphicon glyphicon-play"></span>
        <a href="#Police">Police</a></li>
    <li><span class="glyphicon glyphicon-play"></span>
        <a href="#Fire">Fire</a></li>
    <li><span class="glyphicon glyphicon-play"></span>
        <a href="#SLEP">SLEP</a></li>
    <li><span class="glyphicon glyphicon-play"></span>
        <a href="#Other">Other</a></li>
    <li><span class="glyphicon glyphicon-play"></span>
        <a href="#OPEB">OPEB</a></li>
</ul>

<table class="table table-bordered margintop10">
<cfoutput>
<!--- IMRF, Police Pension, or Fire Pension --->
<tr>
<td><b>Field Description (Code)</b></td>
<td  colspan="3"><center><b>IMRF</b></center></td>
</tr>
<tr>
<td colspan="4"  align="center">Report in Whole Numbers</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><center><cfif trim(IMRF_t500_1) is not "">#ltrim(rtrim(DateFormat(IMRF_t500_1,"yyyy")))#<cfelse>Year 1</cfif></center></td>
<td><center><cfif trim(IMRF_t500_2) is not "">#ltrim(rtrim(DateFormat(IMRF_t500_2,"yyyy")))#<cfelse>Year 2</cfif></center></td>
<td><center><cfif trim(IMRF_t500_3) is not "">#ltrim(rtrim(DateFormat(IMRF_t500_3,"yyyy")))#<cfelse>Year 3</cfif></center></td>
</tr>
<tr>
<td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Actuarial Valuation Date (VD) (500)<cfif url.PrintIt is "No"></a></cfif></td>
<td align="right">#ltrim(rtrim(DateFormat(IMRF_t500_1,"mm/dd/yyyy")))#</td>
<td align="right">#ltrim(rtrim(DateFormat(IMRF_t500_2,"mm/dd/yyyy")))#</td>
<td align="right">#ltrim(rtrim(DateFormat(IMRF_t500_3,"mm/dd/yyyy")))#</td>
</tr>
<tr>
<td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Reporting Date (RD) (500a)<cfif url.PrintIt is "No"></a></cfif></td>
<td align="right">#ltrim(rtrim(DateFormat(IMRF_t500a_1,"mm/dd/yyyy")))#</td>
<td align="right">#ltrim(rtrim(DateFormat(IMRF_t500a_2,"mm/dd/yyyy")))#</td>
<td align="right">#ltrim(rtrim(DateFormat(IMRF_t500a_3,"mm/dd/yyyy")))#</td>
</tr>
<tr>
<td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Measurement Date (MD) (500b)<cfif url.PrintIt is "No"></a></cfif></td>
<td align="right">#ltrim(rtrim(DateFormat(IMRF_t500b_1,"mm/dd/yyyy")))#</td>
<td align="right">#ltrim(rtrim(DateFormat(IMRF_t500b_2,"mm/dd/yyyy")))#</td>
<td align="right">#ltrim(rtrim(DateFormat(IMRF_t500b_3,"mm/dd/yyyy")))#</td>
</tr> 
<tr>
<td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Total Pension Liability (TPL) (501)<cfif url.PrintIt is "No"></a></cfif></td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t501_1,"L999,999,999,999,999")))#</td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t501_2,"L999,999,999,999,999")))#</td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t501_3,"L999,999,999,999,999")))#</td>
</tr>
<tr>
<td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Plan Fiduciary Net Position (FNP) (502)<cfif url.PrintIt is "No"></a></cfif></td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t502_1,"L999,999,999,999,999")))#</td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t502_2,"L999,999,999,999,999")))#</td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t502_3,"L999,999,999,999,999")))#</td>
</tr>
<!--- Calculated field (501-502) - User should NOT be able to change values. --->
<tr>
<td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Net Pension Liability (NPL) (503)<cfif url.PrintIt is "No"></a></cfif></td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t503_1,"L999,999,999,999,999")))#</td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t503_2,"L999,999,999,999,999")))#</td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t503_3,"L999,999,999,999,999")))#</td>
</tr>	
<!--- Calculated field (502/501*100) - User should NOT be able to change values. --->
<tr>
<td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Plan Fiduciary Net Position as a Percentage of Total Pension Liability (504)<cfif url.PrintIt is "No"></a></cfif></td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t504_1,"L9,999,999,999,999.9")))#</td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t504_2,"L9,999,999,999,999.9")))#</td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t504_3,"L9,999,999,999,999.9")))#</td>
</tr>	
<tr>
<td><cfif url.PrintIt is "No"><a href="/financial-data/local-government-division/local-government-data/processsearchresults/?DisplayMode=GetAFR&AFRDesiredData=#url.AFRDesiredData#&Code=#url.Code#&CFY=#url.CFY#&Menu=No" target="_New"></cfif>Net Pension Obligation / Net OPEB Obligation (505)<cfif url.PrintIt is "No"></a></cfif></td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t505_1,"L999,999,999,999,999")))#</td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t505_2,"L999,999,999,999,999")))#</td>
<td align="right">#ltrim(rtrim(NumberFormat(IMRF_t505_3,"L999,999,999,999,999")))#</td>
</tr>
</cfoutput>
</table>	
