<cfif isDefined("form.Page")>
    <cfset Page = form.Page>
<cfelseif isDefined("URL.Page")>
    <cfset Page = URL.Page>
</cfif>

<cfdocument format="pdf" orientation="landscape" pagewidth="8.5" <!---scale="80"---> pageheight="11" marginleft=".5" marginright=".5" margintop=".5" marginbottom=".5">
<cfparam name="attributes.SHOWHEADER" default="N">
<cfinclude template="#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/#url.FileName#">

<cfdocumentitem type="footer"> 
    <cfoutput>
        <div align="center">
            <table cellspacing="0" cellpadding="2" border="0" width="90%">
                <tr>
                    <td width="30%"><font color="navy" size="1" face="Times New Roman, Times, serif"><a href="#application.LocGovWarehouse#">Local Government Warehouse</a> document printed on <cfoutput>#DateFormat(now(),"mm/dd/yyyy")#</cfoutput>.</font></td>
                    <td width="5%">&nbsp;</td>
                    <td width="30%"><font color="navy" size="1" face="Times New Roman, Times, serif"><center>#url.AFRDesiredData#</center></font></td>
                    <td width="5%">&nbsp;</td>
                    <td width="20%"><font color="navy" size="1" face="Times New Roman, Times, serif">#url.CFY# #url.Format# - #Page# - #cfdocument.currentPageNumber# of #cfdocument.totalPageCount#</font></td>
                </tr>
            </table>
        </div>
    </cfoutput>
</cfdocumentitem >

</cfdocument>