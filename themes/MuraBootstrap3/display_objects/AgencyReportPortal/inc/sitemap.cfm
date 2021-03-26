
<script type="text/javascript">

function Instructions(){
	
		window.open("/ioc-pdf/SAMSMonthlyRpt/SiteMapInstructions.pdf","Instructions","scrollbars=1"); 
         }
		 
 </script>

<cfparam name="Session.ErrorMsg" default="">
<cfparam name="ReportNo" default="">
<cfparam name="FY" default="">
<cfparam name="Accounting_Period" default="">
<cfparam name="Agency_No" default="">
<cfparam name="url.ReportNo" default="">
<cfparam name="url.FY" default="">
<cfparam name="url.Accounting_Period" default="">
<cfparam name="url.Agency_No" default="">
<cfparam name="url.LoadNextFYInfo" default="False">
<cfparam name="url.LoadPrevFYInfo" default="False">
<cfparam name="url.ListPosition" default="">

<cfinvoke component="/comptroller/includes/themes/MuraBootstrap3/display_objects/SAMSMonthlyReport/model/beans/SiteRpt" method="getListReports" returnvariable="GetListReports">
   
<cfinvoke component="/comptroller/includes/themes/MuraBootstrap3/display_objects/SAMSMonthlyReport/model/beans/SiteRpt" method="GetListFY" SelectMonth="#url.Accounting_Period#" returnvariable="GetListFY">
 
<cfinvoke component="/comptroller/includes/themes/MuraBootstrap3/display_objects/SAMSMonthlyReport/model/beans/SiteRpt" method="GetListMonths" SelectFY="#url.FY#" SelectMonth="#url.Accounting_Period#" returnvariable="GetListMonths">
 
 <body> 
 <!---
 <div id="HeaderSec">
 --->
<!--- <div class="text-center" style="padding-bottom: 40px;">
  <h2><b>SAMS MONTHLY REPORT SITE MAP</b></h2>
</div> --->


<form action="" id="samsMonthlyReports" method="post" name="GetSelectionInfo">
  <div class="row">
    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
      <div class="btn-label">Fiscal Year</div>
    </div>

    <div class="col-xs-12 col-sm-7 col-md-5">
      <select id="FY" name="FY" class="select2" onchange="if (this.value) window.location.href=this.value">
        <option value="" selected>Fiscal Year</option>
        <cfoutput query="GetListFY">
            <option <cfif trim(url.FY) EQ FY> selected </cfif> value="?mcaction=sitemap&FY=#FY#&Accounting_Period=#url.Accounting_Period#&ReportNo=#url.ReportNo#&ListPosition=#url.ListPosition#">#FY#</option>
        </cfoutput>
      </select>
    </div>
  </div>

  <div class="row">
    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-3 col-md-offset-2 label-div">
      <div class="btn-label">Month</div>
    </div>

    <div class="col-xs-12 col-sm-7 col-md-5">
      <select id="Accounting_Period" name="Accounting_Period" class="select2" onchange="if (this.value) window.location.href=this.value">
        <option value="" selected>Month</option>
         <cfoutput query="GetListMonths">
          <option <cfif trim(url.Accounting_Period) EQ Accounting_Period> selected </cfif> value="?mcaction=sitemap&FY=#url.FY#&Accounting_Period=#Accounting_Period#&ReportNo=#url.ReportNo#&ListPosition=#url.ListPosition#">#Accounting_Period#</option>
          </cfoutput>
      </select>
    </div>
  </div>
</form>  

    <p class="text-center custom-padding-topbottom">
         <img src="/iwgraph/info_icon.png" align="center" height="30" width="30" alt="If you need help, click on the Instructions hyperlink">&nbsp;
        <a href="/ioc-pdf/SAMSMonthlyRpt/SiteMapInstructions.pdf" target="_New">Instructions</a>
      </p>



 <table align="left" border="0" cellpadding="1" cellspacing="1" class="table table-striped">
 
 	<cfoutput>
 	<cfif Session.Errormsg is not "">
 		<font color="##660033">#Session.ErrorMsg#</font> 
	</cfif>
	</cfoutput>

<tr><td colspan="5"><cfoutput>Available Reports <cfif trim(url.FY) is not "" or trim(url.Accounting_Period) is not "">for</cfif> #url.Accounting_Period# #url.FY#</cfoutput></td></tr>
<tr><td>
<!---
<div id="ReportSec">
--->

<table align="left" border="0" cellpadding="1" cellspacing="1" width="100%" bgcolor="#FFFFFF" bordercolor="#FFFFFF">

<cfif trim(url.FY) is not "" and trim(url.Accounting_Period) is not "">
<cfloop query="GetListReports">
<cfoutput>
 <tr>
  <td colspan="5">
    <cfif trim(GetListReports.ReportNo) is not "-">
    <cfif url.ListPosition is "#GetListReports.ReportNo#">
      <a href="?mcaction=sitemap&FY=#url.FY#&Accounting_Period=#url.Accounting_Period#&ReportNo=&ListPosition=">
        <img src="/iwgraph/arrowblueDown.gif" align="absmiddle" height="8" width="8" alt="Click here to close the list of reports for #GetListReports.ReportNo#">
      </a>
    <cfelse>
      <a href="?mcaction=sitemap&FY=#url.FY#&Accounting_Period=#url.Accounting_Period#&ReportNo=#GetListReports.ReportNo#&ListPosition=#GetListReports.ReportNo#">
        <img src="/iwgraph/ArrowBlue.gif" align="absmiddle" height="8" width="8" alt="Click here to see the list of reports for #GetListReports.ReportNo#">
      </a>
    </cfif>
    <a href="?mcaction=sitemap&FY=#url.FY#&Accounting_Period=#url.Accounting_Period#&ReportNo=#GetListReports.ReportNo#&ListPosition=#GetListReports.ReportNo#">
      <b><font size="-2">#GetListReports.ReportNo#</font></b></a>
  </cfif>
 </cfoutput>
 <div id="ListSec" >
 <tr><td>
 <cfif ((trim(ReportNo) is not "-") and (trim(url.ReportNo) is trim(GetListReports.ReportNo)))>
 
<cfinvoke component="/comptroller/includes/themes/MuraBootstrap3/display_objects/SAMSMonthlyReport/model/beans/SiteRpt" Method="Get_ListAvailSiteReports" ReportNo="#url.ReportNo#" FY="#url.FY#" Accounting_Period="#url.Accounting_Period#" returnVariable="GetListAvailReports">
<cfif GetListAvailReports.recordcount>
<ul>
   		<cfoutput query="GetListAvailReports"> 
            <cfif Revoked is "N" and DateFormat(DisplayDtTo,"mm/dd/yyyy") Ge DateFormat(Now(),"mm/dd/yyyy")>
            	<cfset TmpFileName = #trim(mid(ReportNo,1,5))# & "_" & #FY# & "_" & #DateFormat(GeneratedDt,"mm-dd-yy")#>
            	<cfif trim(Fund_num) is not "0000">
            		<cfset TmpFileName = TmpFileName & "_" & #mid(Fund_Num,1,4)#>
         		<cfelseif mid(AgencyNo,1,3) is not "000"><cfset TmpFileName = TmpFileName & "_" & #mid(AgencyNo,1,3)#></cfif>
           			<cfset ErrorMsgCnt = 0> 
                    <cfparam NAME="variables.myCount" DEFAULT="1">
					<cftry>
                    <img src="/iwgraph/acrop.gif" width="16" height="16" alt="Get Report" align="absmiddle"> <a href="https:files.illinoiscomptroller.gov/SAMSMonthlyRpt/#TmpFileName#.pdf"><font size="-2">#trim(ReportNo)# for #DateFormat(GeneratedDt,"mmmm")# of FY #FY# <cfif (DateFormat(GeneratedDt,"mm") is "07") and(DateFormat(GeneratedDt,"YYYY") is FY)>, Lapse Period 1, <cfelseif (DateFormat(GeneratedDt,"mm") is "08") and(DateFormat(GeneratedDt,"YYYY") is FY)>, Lapse Period 2, <cfelseif (DateFormat(GeneratedDt,"mm") is "09") and(DateFormat(GeneratedDt,"YYYY") is  FY)>, Lapse Period 3, <cfelseif (DateFormat(GeneratedDt,"mm") is "10") and(DateFormat(GeneratedDt,"YYYY") is  FY)>, Lapse Period 4, <cfelseif (DateFormat(GeneratedDt,"mm") is "11") and(DateFormat(GeneratedDt,"YYYY") is  FY)>, Lapse Period 5, <cfelseif (DateFormat(GeneratedDt,"mm") is "12") and(DateFormat(GeneratedDt,"YYYY") is  FY)>, Lapse Period 6, <cfelseif (DateFormat(GeneratedDt,"mm") is "01") and (DateFormat(GeneratedDt,"YYYY") is  FY+1)>, Lapse Period 7, </cfif> for <cfif AgencyNo is "000" and Fund_Num is "0000" and trim(ReportNo) is not "SB05">All Agencies<cfelseif AgencyNo is "000" and Fund_Num is "0000" and trim(ReportNo) is "SB05">All Funds<cfelseif AgencyNo is "000" and Fund_Num is not "0000">Fund No #Fund_Num#<cfelse>Agency No #AgencyNo#</cfif> </font></a><br>
           			<cfcatch type="any">There is currently a problem with accessing the FTP server. We appreciate your patience as we rectify the matter.</cfcatch>
            		
                    </cftry>
    
               </cfif>
			
      	</cfoutput></ul>

</cfif>
</cfif>
</td></tr>
</cfloop>
</cfif>
</table>
</td></tr>
</table>
