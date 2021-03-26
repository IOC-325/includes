<!--- 
    SR:        19198
    Date:      01/22/20
    Author:    Zac Ely
    Changes:   Updated auditPDFLoc and added target set to _blank to open in new tab
--->
<!---<cfparam name="url.BetaSel" default="">--->
<cfparam name="url.CFY" default="">
<cfparam name="url.Code" default="">

<cflock scope="session" TIMEOUT="1000">

<cfif url.Code is "">
	<b>You must supply a unit of government</b>
</cfif>

<cfoutput>
<cftry>
<!---
<cfStoredProc datasource="#application.LocGovWarehouse#" Procedure="Get_FY">
	<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="Get_FYRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="Get_FYRetMsg">
	<cfprocresult name="GetCFY">
</cfstoredproc>
--->


<!--- Per 19168 Change datasource below to #application.LocGovWarehouse# and replace stored procedure call  --->
<cfStoredProc datasource="AFRUAT" Procedure="Get_FYReleased">
	<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="Get_FYRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="Get_FYRetMsg">
	<cfprocresult name="GetCFY">
</cfstoredproc>

<Cfset TmpPFY2 = #GetCFY.FY#-2>

<cfcatch type="any">
<b>Sorry, Could not get available FY Information</b><cfabort>
</cfcatch>
</cftry>

</cfoutput>
<!---<cfinclude template="Heading.cfm">--->
<cfoutput query="GetCFY">
	<cfset TmpFY = "#GetCFY.FY#">
	<cfif GetCFY.FY ge TmpPFY2>

        <p class="files-years">FY: #GetCFY.FY#</p>
        <cftry>
        <cfStoredProc datasource="#application.LocGovWarehouse#" Procedure="Check_IfFinished">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(url.Code)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" value="#TmpFY#">
            <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckIfFinishedRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckIfFinishedRetMsg">
            <cfprocresult name="CheckIfFinished">
        </cfstoredproc>
        <cfcatch type="any">
        <b>Sorry, Could not get Audit Information for FY #TmpFY#</b>
        </cfcatch>
        </cftry>
        
       	<cfset TmpFinished = "#CheckIfFinished.Finished#">
        
         <cftry>
        <cfStoredProc datasource="#application.LocGovWarehouse#" Procedure="Get_AuditInfo">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(url.Code)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" value="#TmpFY#">
            <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Instrument" value="Annual Audit">
            <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAuditInfoRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAuditInfoRetMsg">
            <cfprocresult name="GetAuditInfo">
        </cfstoredproc>
        
        <cfStoredProc datasource="#application.LocGovWarehouse#" Procedure="Get_AuditInfo">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(url.Code)#">
            <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" value="#TmpFY#">
            <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@Instrument" value="Annual Report">
            <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAnnualReporttInfoRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAnnualReportInfoRetMsg">
            <cfprocresult name="GetAnnualReportInfo">
        </cfstoredproc>
        <cfcatch type="any">
        <b>Sorry, Could not get Audit Information for FY #TmpFY#</b>
        </cfcatch>
        </cftry>
        
        <cfset TmpAuthResubmit = "#trim(GetAuditInfo.AuthResubmit)#">
        <cfif GetAuditInfo.Extension is "Y">
            <cfset TmpDueDate = "#DateFormat(DateAdd("D",60,GetAuditInfo.DueDate),"mm/dd/YYYY")#">
        <cfelse>
            <cfset TmpDueDate = "#DateFormat(GetAuditInfo.DueDate,"MM/DD/YYYY")#">
        </cfif>

        <cfif TmpFinished is not "Y" or (TmpFinished is "Y" and trim(TmpAuthResubmit) is not "")>
            <ul class="list-files">
            <li>
        <span class="glyphicon glyphicon-question-sign"></span>The Annual Audit is not available.  This local government's Annual Financial Report (AFR) <cfif TmpDueDate ge DateFOrmat(now(),"mm/dd/yyyy")>is<cfelse>was</cfif> due on <cfif TmpDueDate is "">#DateFormat(GetAnnualReportInfo.DueDate,"mm/dd/yyyy")#<cfelse>#TmpDueDate#</cfif>.  Please check back.
            </li>
            </ul>
        <cfelse>
        
            <cftry>
            <cfStoredProc datasource="#application.LocGovWarehouse#" Procedure="Get_AnnualAuditWHInfo">
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(url.Code)#">
                <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" value="#TmpFY#">
                <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAnnualAuditRecInfoRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAnnualAuditRecInfoRetMsg">
                <cfprocresult name="CheckRecordLoc">
            </cfstoredproc>
            <cfcatch type="any">
            <b>Sorry, Could not get Audit Information for FY #GetCFY.FY#</b>
            </cfcatch>
            </cftry>
        
            <cfif CheckRecordLoc.recordcount>
            
                <cfloop query="CheckRecordLoc">
                    <cfif trim(FileName) is "" or trim(GetAuditInfo.RecDate) is "">
                        <cfinvoke component = "#application.configbean.getContext()#/#application.settingsmanager.getSite(request.siteid).getDisplayPoolID()#/includes/display_objects/custom/LocalGovWarehouse/cfcs/LocGovWarehouse" 
                            method = "CheckAuditDue" 
                            Code = "#trim(url.Code)#" 
                            CFY = "#trim(GetCFY.FY)#"  
                            returnVariable = "AuditDue">
                        <cfif AuditDue is "Y">
                            <cfif GetCFY.FY is "2011">
                                <cfset TmpDesc = "(No Annual Audit Available Online)">
                             <cfelse>
                                <cfset TmpDesc = "(No Annual Audit Available)">
                             </cfif>
                            <cfset TmpButton = "Not Available">
                        <cfelse>
                            <cfset TmpDesc = "(No Annual Audit Required)">
                            <cfset TmpButton = "Not Required">
                        </cfif>
                        <!---<cfset TmpDesc = " (No Annual Audit Available)">--->
                    <cfelseif trim(CheckRecordLoc.Approved) is "">
                       <!--- <cfset TmpDesc= "#CheckRecordLoc.FileName# (Annual Audit Awaiting Approval)">--->
                        <cfset TmpDesc= "Audit file #right(CheckRecordLoc.FileName,2)# (Annual Audit Awaiting Approval)">
                        <cfset TmpButton = "Not Approval">
                    <cfelse>
                        <!---<cfset TmpDesc="#CheckRecordLoc.FileName#">--->
                        <cfif trim(CheckRecordLoc.Addendum) is "Y">
                        	<cfset TmpDesc="Click here to view Supplemental file No. #right(CheckRecordLoc.FileName,2)#">
                        <cfelse>
                        	<cfset TmpDesc="Click here to view Audit file No. #right(CheckRecordLoc.FileName,2)#">
                        </cfif>
                        <cfset TmpButton = "Report Available">
                    </cfif>
                    <ul class="list-files"><li>

                    <!--- SR 19198: Updated auditPDFLoc and added target set to _blank to open in new tab --->
					<cfif trim(CheckRecordLoc.Approved) is not "">
                    	<cfif TmpButton is "Report Available">
                                <a target="_blank" href="#application.AuditpdfLoc#FY#GetCFY.FY#/#left(url.Code,3)##mid(url.Code,5,3)##right(url.Code,2)#/<cfif trim(folderpath) is not "">#folderpath#/</cfif>#FileName#.pdf"></cfif><span class="glyphicon glyphicon-check"></span>#TmpDesc#</a>
                        <cfelseif TmpButton is "Not Required">
                        	<span class="glyphicon glyphicon-remove"></span>#TmpDesc#
                        <cfelseif TmpButton is "Not Available">
                        	<span class="glyphicon glyphicon-ban-circle"></span>#TmpDesc#
                        <cfelseif TmpButton is "Not Approved">
                        	<span class="glyphicon glyphicon-check"></span>#TmpDesc#
                       </cfif>
                    </li></ul>
                </cfloop>
            </cfif>
        </cfif>
    </cfif>
</cfoutput>

<p class="margintop">** Adobe Reader is required to view the Annual Audits.  <a href="http://www.adobe.com">You can click here to Download Adobe Reader.</a></p>
<!---
<tr><td><a href="http://www.adobe.com"><img src="/images/get_adobe_reader.png" alt="Adobe Reader is required to use this application!" align="absmiddle" width="145" height="36"></a></td></tr>
--->

</cflock>

