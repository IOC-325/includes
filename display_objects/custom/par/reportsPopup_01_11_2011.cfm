<cfoutput>
<cfparam name="application.dsn" default="General">
<cfsavecontent variable="script">
<SCRIPT LANGUAGE="JavaScript"><!--
	function SetFY() {
		alert(self.location.href);
		self.location.href='#cgi.SCRIPT_NAME#/departments/public-accountability-reporting/public-accountability-reports/?AgencyNo=' + List.AgencyNo.value + '&ReportFY=' + List.ReportFY.value + '&ReportProgramId=' + List.ReportProgramId.value + '##ViewReports';
			return true;
	}
		
 //--></SCRIPT>
</cfsavecontent>
<cfhtmlhead TEXT="#script#">
</cfoutput>
 
 <Cfoutput>
<cfset ReportDate=DateAdd('y',-1,Now())>
<cfparam name="url.ReportFY" default="#DateFormat(Now(),"yyyy")#">
<cfparam name="url.ReportProgramId" default="None">
<cfparam name="url.AgencyNo" default="None">
</CFOUTPUT>


<cfif ParameterExists(DoListReport)>
	<cfset ReportPFY = form.ReportFY - 1>
	<cfset ReportPFY2 = form.ReportFY - 2>
	<cfset ReportNFY = form.ReportFY + 1>

	<cfif form.ReportProgramId is not "None">
    	<cfif form.ReportFY gt '2007'>
			<cflocation url="/comptroller/includes/display_objects/custom/par/Report/FY2008/ViewReport.cfm?AgencyNo=#form.AgencyNo#&ReportProgramId=#form.ReportProgramId#&ReportCFY=#form.ReportFY#&ReportPFY=#ReportPFY#&ReportPFY2=#ReportPFY2#&ReportNFY=#ReportNFY#">
		<cfelseif form.ReportFY gt '2003'>
			<cflocation url="/comptroller/includes/display_objects/custom/par/Report/FY2004/ViewReport.cfm?AgencyNo=#form.AgencyNo#&ReportProgramId=#form.ReportProgramId#&ReportCFY=#form.ReportFY#&ReportPFY=#ReportPFY#&ReportPFY2=#ReportPFY2#&ReportNFY=#ReportNFY#">
		<cfelse>
			<cflocation url="/comptroller/includes/display_objects/custom/par/Report/FY#form.ReportFY#/ViewReport.cfm?AgencyNo=#form.AgencyNo#&ReportProgramId=#form.ReportProgramId#&ReportCFY=#form.ReportFY#&ReportPFY=#ReportPFY#&ReportPFY2=#ReportPFY2#&ReportNFY=#ReportNFY#">
		</cfif>
	
	</cfif>
</cfif>

    <p>The  <em>Public Accountability Reports</em> attempt to link traditional financial reports of state government with the performance or results of state programs. 
      This type of report is referred to as Service Efforts and Accomplishments 
      (SEA) because it reviews financial and other resources allocated to programs 
      as well as quantifiable measurements of how well programs have realized 
      their objectives. Public accountability reporting can assist state government 
      officials and the public at large by making government programs more results 
      oriented. Furthermore, this is the direction toward which government reporting 
      is headed. National groups such as the Governmental Accounting Standards 
      Board and the Association of Government Accountants have issued suggested 
      guidelines not only for evaluating government programs, but also for writing 
      and distributing SEA reports. </font></font></p>
    <p>The fiscal year 2003 report includes coverage of 69 selected Illinois state agencies, an increase from the 57 agencies reporting in fiscal year 2001 and the 19 agencies in the fiscal year 1999 
      report. This group of agencies contributed a significant part ($41.6 billion or 91.2%) of the $45.6 billion in appropriated expenditures for fiscal year 2003.</p>
    
    
   <!--- Commented out code that gets reports from old database to move to Mura --->   
   <p><a href="/comptroller/?LinkServID=52008217-C6F1-459D-9CDA70AF0CF7D4FA">Click to view reports</a></p>
   <!--- <cfinvoke COMPONENT="get" METHOD="ReportsWhere" ReportType="Public Accountability Report" RETURNVARIABLE="rReports">
    <ul>
    <cfoutput QUERY="rReports">
    <li style="list-style:url('/iwgraph/acrop.gif')"><a href="http://www.apps.ioc.state.il.us/ioc-pdf/#filename#">#Year#</a></li>
    </cfoutput>--->
   	
     </ul>
  <!---  <table WIDTH="500" BORDER="1" BORDERCOLOR="#333333" BGCOLOR="#FFFFFF">
	 <tr VALIGN="top">
		<td WIDTH="250" VALIGN="top"> <div ALIGN="center"><font COLOR="#FFFFFF" SIZE="2"><strong><img src="/iwgraph/acrop.gif" alt="" border="0"><a HREF="http://www.ioc.state.il.us/ioc-pdf/PAR2005Web.pdf">2005 Public 
            Accountability Report</a></strong></font></div></td>
		<td WIDTH="250" VALIGN="top"> <div ALIGN="center"><font COLOR="#FFFFFF" SIZE="2"><strong><img src="/iwgraph/acrop.gif" alt="" border="0"><a HREF="http://www.ioc.state.il.us/ioc-pdf/PAP2004Web.pdf">2004 Public 
            Accountability Report</a></strong></font></div></td>
      </tr>
      <tr VALIGN="top"> 
        <td VALIGN="top" width="250"><div ALIGN="center"><font COLOR="#FFFFFF" SIZE="2"><strong><img src="/iwgraph/acrop.gif" alt="" border="0"><a HREF="http://www.ioc.state.il.us/ioc-pdf/PAP2003Web.pdf">2003 Public 
            Accountability Report</a></strong></font></div></td>
        <td VALIGN="top" width="250"><div ALIGN="center"><font COLOR="#003399" SIZE="2"><strong><img src="/iwgraph/acrop.gif" alt="" border="0"><a HREF="http://www.apps.ioc.state.il.us/ioc-pdf/PAP2002/2002PAP1.cfm">2002 
            Public Accountability Report</a></strong></font></div></td>
      </tr>
      <tr VALIGN="top"> 
        <td VALIGN="top" width="250"><div ALIGN="center"><font COLOR="#003399" SIZE="2"><strong><img src="/iwgraph/acrop.gif" alt="" border="0"><a HREF="http://www.apps.ioc.state.il.us/ioc-pdf/pap2001.cfm">2001 
            Public Accountability Report</a></strong></font></div></td>
        <td VALIGN="top" width="250"><div ALIGN="center"><font COLOR="#003399" SIZE="2"><strong><img src="/iwgraph/acrop.gif" alt="" border="0"><a HREF="http://www.apps.ioc.state.il.us/ioc-pdf/SEAFinalForCAFR_2000.pdf">2000 
            Public Accountability Report</a></strong></font></div></td>
      </tr>
      <tr VALIGN="top"> 
        <td VALIGN="top" width="250"><div ALIGN="center"><font COLOR="#003399" SIZE="2"><strong><img src="/iwgraph/acrop.gif" alt="" border="0"><a HREF="http://www.apps.ioc.state.il.us/ioc-pdf/SEA99/99SEAPartInCAFRForWebPart2.PDF">1999 
            Public Accountability Report</a></strong></font></div></td>
		<td VALIGN="top" width="149"><div ALIGN="center"><font COLOR="#003399" SIZE="2"><strong><img src="/iwgraph/acrop.gif" alt="" border="0"><a HREF="http://www.apps.ioc.state.il.us/ioc-pdf/SEA99/99SEAPartInCAFRForWebPart1.PDF">*1999 
            Citizen Satisfaction Survey</a></strong></font></div></td>
      </tr>
    </table>--->
    

<cfset TmpEffective_Date = DateFormat(("07/01/" & url.ReportFY),"mm/dd/yyyy")>
<cfset TmpDeactivated_Date = DateFormat(("06/30/" & url.ReportFY),"mm/dd/YYYY")>


<cfStoredProc datasource="PAPProd" Procedure="GetAgency">
	<cfprocparam type="in"  cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@Effective_Date" value="#TmpEffective_Date#">
	<cfprocparam type="in"  cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@Deactivated_Date" value="#TmpDeactivated_Date#">
	<cfprocparam type="in"  cfsqltype="cf_sql_Nvarchar" dbvarname="@SortOrder" null="yes">
	<cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="Status" null="yes">
	<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAgencyRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAgencyRetMsg">
	<cfprocresult name="AgencyList">
</cfstoredproc>

<cfStoredProc datasource="PAPProd" Procedure="GetSubmittedPrograms">
	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Agency" value="#url.AgencyNo#">
	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="Year" value="#url.ReportFY#">
	<cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="ProgramId" null="yes">
	<cfprocparam type="in" cfsqltype="cf_sql_tinyint" dbvarname="@InReport" Value="1">
	<cfprocparam type="in" cfsqltype="cf_sql_tinyint" dbvarname="@DeletionInd" Value="0">
	<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFundNumRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFundNumRetMsg">
	<cfprocresult name="AgencyPrograms">
</cfstoredproc>

<cfStoredProc datasource="PAPProd" Procedure="GetFY">
	<cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetFYRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetFYRetMsg">
	<cfprocresult name="GetFY">
</cfstoredproc>
 

<P>You may select a particular Agency, PAR Program, Fiscal Year, and click on "View Submitted PAR" button to view the corresponding Agency's PAR<A NAME="ViewReports">.</A></P>

<TABLE WIDTH="350" BGCOLOR="#DDEEFF" CELLSPACING="0" CELLPADDING="0" BORDER="1" FRAME="box" RULES="groups">
	<!---<cfFORM ACTION="/comptroller/includes/display_objects/custom/par/reports.cfm" METHOD="post" name="List">--->
   <cfform action="/comptroller/?LinkServID=252B32FC-1CC1-DE6E-2F486CD745A1A73E" METHOD="post" NAME="List">
																																		<!---/comptroller/includes/display_objects/custom/par/reportsPopup.cfm?--->
	<TR><TD COLSPAN="3"><B>Agency:</B> <cfselect WIDTH="200" name="AgencyNo" OnChange="self.location.href='/index.cfm/departments/public-accountability-reporting/public-accountability-reports/?AgencyNo=' + List.AgencyNo.value + '&ReportFY=' + List.ReportFY.value + '&ReportProgramId=' + List.ReportProgramId.value + '##ViewReports';">
		<Option Value="None">&nbsp;</Option>
		<cfoutput query="AgencyList">
		<Option Value="#AgencyNo#" <cfif AgencyList.AgencyNo is url.AgencyNo>Selected</cfif>>#AGCY_Name# (#AgencyNo#)</cfoutput></cfselect></TD></TR>

	<TR><TD><B>Program:</B> <cfselect name="ReportProgramId" OnChange="self.location.href='/index.cfm/departments/public-accountability-reporting/public-accountability-reports/?AgencyNo=' + List.AgencyNo.value + '&ReportFY=' + List.ReportFY.value + '&ReportProgramId=' + List.ReportProgramId.value + '##ViewReports';">
		<Option Value="None">&nbsp;</Option>
		<cfoutput query="AgencyPrograms">
		<Option Value="#ProgramId#" <cfif AgencyPrograms.ProgramId is url.ReportProgramId>Selected</cfif>>#MajorFunction#</cfoutput></cfselect>
	</TD>
	<TD>&nbsp;</TD>
	<TD><B>Fiscal Year:</B> <cfselect name="ReportFY"  OnChange="self.location.href='/index.cfm/departments/public-accountability-reporting/public-accountability-reports/?AgencyNo=' + List.AgencyNo.value + '&ReportFY=' + List.ReportFY.value + '&ReportProgramId=' + List.ReportProgramId.value + '##ViewReports';">
		<cfoutput query="GetFY">
		<Option  Value="#FY#" <cfif GetFY.FY is url.ReportFY>selected </cfif>>#FY#</cfoutput></cfselect>
	</TD>
	</TR>

	<TR>
	<TD COLSPAN="3"><CENTER><INPUT TYPE="Submit" Name="DoListReport" VALUE="View Submitted PAR"></CENTER></TD>
	</TR>	
	</cfform></TABLE>

<CENTER><A HREF="http://www.adobe.com/acrobat/readstep.html"><IMG SRC="/iwgraph/GetAcro.gif"></A></CENTER><BR>

