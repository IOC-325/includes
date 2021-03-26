
<!---<cfparam name="url.BetaSel" default="">--->
<cfparam name="url.CFY" default="">
<cfparam name="url.Code" default="">
<cfparam name="TmpNFY" default="">
<cfparam name="TmpCFY" default="">
<cfparam name="TmpPFY" default="">
<cfparam name="TmpPFY2" default="">

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

<Cfset TmpCFY = "2017">
<Cfset TmpPFY = "2016">
<Cfset TmpPFY2 = "2015">
--->

<cfStoredProc datasource="#application.LocGovWarehouse#" Procedure="Get_TIFFYNotReleased">
	<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="Get_FYRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="Get_FYRetMsg">
	<cfprocresult name="GetNFY">
</cfstoredproc>

<cfStoredProc datasource="#application.LocGovWarehouse#" Procedure="Get_TIFFYReleased">
	<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="Get_FYRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="Get_FYRetMsg">
	<cfprocresult name="GetCFY">
</cfstoredproc>

<cfif trim(GetNFY.Date_Released) is "">
	<cfset TMPNFY=#GetNFY.FY#>
</cfif>

<Cfset TmpCFY = #GetCFY.FY#>
<Cfset TmpPFY = #GetCFY.FY#-1>
<Cfset TmpPFY2 = #GetCFY.FY#-2>


<cfcatch type="any">
<b>Sorry, Could not get available FY Information</b>
</cfcatch>
</cftry>
</cfoutput>

<cfif trim(TmpNFY) is not "">
<div class="alert alert-info"><b>The Upload TIF Reports application has NOT been released for FY <cfoutput>#TmpNFY#</cfoutput>.</b></div>
</cfif>

<cfloop index="x" list="#TmpCFY#,#TmpPFY#,#TmpPFY2#">

<cfoutput>
<cfif TmpCFY ge TmpPFY2>

    <cftry>
    <cfStoredProc datasource="#application.LocGovWarehouse#" Procedure="Get_TIFRecInfo">
        <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Code" value="#trim(url.Code)#">
        <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@FY" value="#x#">
        <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@instrument" null="true" >
        <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="Get_TIFRecInfoRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="Get_TIFRecInfoRetMsg">
        <cfprocresult name="CheckRecordLoc">
    </cfstoredproc>
    <cfcatch type="any">
    <b>Sorry, we could not get TIF Information for FY #x#</b>
    </cfcatch>
    </cftry>
 
    <cfif CheckRecordLoc.recordcount>
        <p class="files-years">TIF Districts for FY #x#</p>
        <cfloop query="CheckRecordLoc"> 

            <cfif trim(FileName) is "">
                <cfset TmpDesc="#CheckRecordLoc.Instrument#" & " (No TIF Report Available)">
                <cfset TmpButton = "Not Available">
            <cfelseif trim(CheckRecordLoc.Approved) is "">
                <cfset TmpDesc="#CheckRecordLoc.Instrument#" & " (TIF Report Awaiting Approval)">
                <cfset TmpButton = "Not Approved">
            <cfelse>
            	<cfif trim(CheckRecordLoc.TIFTermDate) is not "" and trim(CheckRecordLoc.TIFFundBalance) is "Y">
                	<cfset TmpDesc="#CheckRecordLoc.Instrument#">
                <cfelseif trim(CheckRecordLoc.TIFTermDate) is not "" and trim(CheckRecordLoc.TIFFundBalance) is "N">
                	<cfset TmpDesc="#CheckRecordLoc.Instrument#" & "(Final TIF Report-Zero Fund Balance Reported)">
                <cfelse>
                	<cfset TmpDesc="#CheckRecordLoc.Instrument#">
                </cfif>
                <cfset TmpButton = "Report Available">
            </cfif>
            <ul class="list-files">
            <li>
			<cfif trim(CheckRecordLoc.Approved) is not "">
            	<a href="#application.TIFpdfLoc#FY#x#/#left(url.Code,3)##mid(url.Code,5,3)##right(url.Code,2)#/<cfif trim(folderpath) is not "">#folderpath#/</cfif>#FileName#.pdf"></cfif>
			<cfif TmpButton is "Report Available">
                <span class="glyphicon glyphicon-check"></span>
            <cfelseif TmpButton is "Not Required">
                <span class="glyphicon glyphicon-remove"></span>
            <cfelseif TmpButton is "Not Available">
                <span class="glyphicon glyphicon-ban-circle"></span>
            <cfelseif TmpButton is "Not Approved">
                <span class="glyphicon glyphicon-check"></span>
            </cfif>
            #TmpDesc#
            <cfif trim(CheckRecordLoc.Approved) is not ""></a></cfif>
            </li></ul>
        </cfloop>

    <cfelse>
        <p class="files-years">TIF Districts for FY #x#</p>
        <ul class="list-files">
        <li><span class="glyphicon glyphicon-ban-circle"></span> (No TIF Report Available)</li></ul>
    </cfif>
</cfif>
</cfoutput>
</cfloop>

<p class="margintop">** Adobe Reader is required to view the TIF Reports.  <a href="http://www.adobe.com">You can click here to Download Adobe Reader.</a></p>

</cflock>

