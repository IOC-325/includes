<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance">
	<meta name="author" content="Gary Ashbaugh">

<!---
	Created Date: 10-14-14
	Created By: Gary Ashbaugh

	Description: Per SR14136 brought the page into new IOC style, bootstrapped it, and brought it under main IOC web site.

--->

<SCRIPT LANGUAGE="Javascript">
 <!--
	function makeRemote(fileName) {
        remote = window.open("","remotewin","width=500,height=200,scrollbars=1");
		
		remote.location.href = "https://illinoiscomptroller.gov/Vendor/" + fileName + ".cfm";
		
        if (remote.opener == null) remote.opener = window; 
         remote.opener.name = "opener";
         }

	<cfoutput>              
	function ADOWindow(parms) {
		remote = window.open("https://illinoiscomptroller.gov/vendors/enhanced-vendor-remittance/about-download-options?"+parms,"remotewin","width=460,height=200,scrollbars=1,addressbar=yes");
		
		if (remote.opener == null) remote.opener = window; 
			remote.opener.name = "opener";
		}
	</cfoutput>		 

	function makeNewRemote(fileName) { 
         remote = window.open("","remotewin","width=300,height=110,scrollbars=1");

		 //Production
		 remote.location.href = "https://illinoiscomptroller.gov/Vendor/"+fileName+".cfm";
         
		 if (remote.opener == null) remote.opener = window; 
         	remote.opener.name = "opener";
         }

         //-->

</SCRIPT>

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<!--- <cfsilent> --->
<!---<cf_formURL2attributes>--->

<CFIF IsDefined ("URL.MostRecent")>
 <CFSET MostRecent = URL.MostRecent>
<cfelseif IsDefined ("form.MostRecent")>
 <CFSET MostRecent = form.MostRecent>
<cfelseif IsDefined ("MostRecent")>
 <CFSET MostRecent = MostRecent>
</CFIF>

<CFIF IsDefined ("URL.MostRecentDate")>
 <CFSET MostRecentDate = URL.MostRecentDate>
<cfelseif IsDefined ("form.MostRecentDate")>
 <CFSET MostRecentDate = form.MostRecentDate>
<cfelseif IsDefined ("MostRecentDate")>
 <CFSET MostRecentDate = MostRecentDate>
</CFIF>

<CFIF IsDefined ("URL.LastRecentDate")>
 <CFSET LastRecentDate = URL.LastRecentDate>
<cfelseif IsDefined ("form.LastRecentDate")>
 <CFSET LastRecentDate = form.LastRecentDate>
<cfelseif IsDefined ("LastRecentDate")>
 <CFSET LastRecentDate = LastRecentDate>
</CFIF>

<CFIF IsDefined ("form.SortBy")>
 <CFSET SortBy = form.SortBy>
<cfelseif IsDefined ("URL.SortBy")>
 <CFSET SortBy = URL.SortBy>
</CFIF>
<CFIF IsDefined ("form.AscDesc")>
 <CFSET AscDesc = form.AscDesc>
<cfelseif IsDefined ("URL.AscDesc")>
 <CFSET AscDesc = URL.AscDesc>
</CFIF>

<CFIF IsDefined ("form.max")>
 <CFSET max = form.max>
<cfelseif IsDefined ("url.max")>
 <CFSET max = URL.max>
</CFIF>

<CFIF IsDefined ("form.StartRow")>
  <CFSET StartRow = form.StartRow>  
<cfelseif IsDefined ("url.StartRow")>
 <CFSET StartRow = URL.StartRow>
</CFIF>

<CFIF IsDefined ("form.StartDate")>
 <CFSET StartDate = form.StartDate>
<cfelseif IsDefined ("URL.StartDate")>
 <CFSET StartDate = URL.StartDate>
</CFIF>

<CFIF IsDefined ("form.EndDate")>
 <CFSET EndDate = form.EndDate>
<cfelseif IsDefined ("URL.EndDate")>
 <CFSET EndDate = URL.EndDate>
</CFIF>

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">
<cfinclude template="TmpVendorapplicationSettings.cfm">
<cfif not isdefined("Session.VendTIN")>
	<!--- Calls Index from VendorEnhanced --->
    <cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>
</cfLock>
<!---</cfsilent>--->

<cfStoredProc  datasource="Deductions" Procedure="Get_MaxDeductionEndDt">
    <cfprocparam type="Out"  cfsqltype="CF_SQL_Date" dbvarname="@MaxIssue_Date" variable="GetMaxIssue_Date">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetMaxDeductionEndDtRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetMaxDeductionEndDtRetMsg">
    <cfprocresult name="GetMaxDeductionEndDt">
</cfstoredproc>

<CFHeader name="Cache-control" value="public">
<CFINCLUDE TEMPLATE="VendHeader.cfm">

<CFSET Area="Warrants">
<cfparam name="StartRow" default="1">
<CFIF IsDefined ("URL.StartRow")>
 <CFSET StartRow = URL.StartRow>
</CFIF>

<cfparam name="Max" default="20">
<cfparam NAME="attributes.StartDate" DEFAULT="">
<cfparam NAME="attributes.EndDate" DEFAULT="">
<cfparam NAME="attributes.SortBy" DEFAULT="Issue_Date desc, Employee_Name">
<cfparam NAME="attributes.Status" DEFAULT="A">
<!---<cfparam NAME="form.StartDate" DEFAULT="">--->

<cfinclude template="DeductionSQL.cfm">

<cfif MostRecent is not "Y">
	<cfoutput>
    <!---<cfif DateFormat(endDate,"mm/dd/yyyy") gt DateFormat(DateAdd("d",1,now()),"mm/dd/yyyy")>--->
  	<cfif DateFormat(endDate,"mm/dd/yyyy") gt DateFormat(GetMaxIssue_Date,"mm/dd/yyyy")>
    	<b><font color="red">You have select an Ending Date greater than #DateFormat(GetMaxIssue_Date,"mm/dd/yyyy")# <!---#DateFormat(DateAdd("D",1,now()),"mm/dd/yyyy")#--->.  We have automatically changed the date back to <!---#DateFormat(DateAdd("D",1,now()),"mm/dd/yyyy")#---> #DateFormat(GetMaxIssue_Date,"mm/dd/yyyy")#.</font></b>
        <!---<cfset TmpEndDate = "#DateFormat(DateAdd("D",1,now()),"mm/dd/yyyy")#">--->
        <cfset TmpEndDate = "#DateFormat(GetMaxIssue_Date,"mm/dd/yyyy")#">
   	<cfelse>
    	<cfset TmpEndDate = "#DateFormat(EndDate,"mm/dd/yyyy")#">
    </cfif>

	<CFSET Query = "/vendors/enhanced-vendor-remittance/deduction-list/?MostRecent=N&WorkDate=&startDate=#DateFormat(startDate,"mm/dd/yyyy")#&endDate=#DateFormat(TmpEndDate,"mm/dd/yyyy")#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&MostRecentDate=&LastRecentDate&Max=#Max#&">
	<CFSET QueryParams = "startDate=#DateFormat(startDate,"mm/dd/yyyy")#&MostRecent=N&WorkDate=&endDate=#DateFormat(TmpEndDate,"mm/dd/yyyy")#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&MostRecentDate=&LastRecentDate=&Max=#Max#&">

	<p id="instructions2">Deductions listed have Anticipated Direct Deposit Dates between <B>#DateFormat(startDate, 'mm-dd-yy')# </B>and <B>#Dateformat(TmpEndDate, 'mm-dd-yy')#</B>.  <cfif TimeFormat(now(),"medium") GE "12:00:01 AM" and TimeFormat(now(),"medium") lt "9:00:00 AM" and DateFormat(TmpEndDate,"mm/dd/yyyy") ge DateFormat(DateAdd("d",1,now()),"mm/dd/yyyy")><font color="Red"><br>WARNING: Not all of the deductions might be included yet since it is before 9:00 AM on #DateFormat(now(),"mm/dd/yyyy")# and you have chosen #DateFormat(TmpEndDate,"mm/dd/yyyy")# as your Ending Date.</font></cfif></p>
   </cfoutput>
<cfelse>
	<cfoutput>
    <CFSET Query = "/vendors/enhanced-vendor-remittance/deduction-list/?MostRecent=Y&MostRecentDate=#DateFormat(MostRecentDate,"mm/dd/yyyy")#&LastRecentDate=#DateFormat(LastRecentDate,"mm/dd/yyyy")#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&Max=#Max#&">
	<CFSET QueryParams = "LastRecentDate=#DateFormat(LastRecentDate,"mm/dd/yyyy")#&MostRecent=Y&MostRecentDate=#DateFormat(MostRecentDate,"mm/dd/yyyy")#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&Max=#Max#&">

	<p id="instructions2">Deductions listed are for the Most Recent Generation Date associated with #DateFormat(LastRecentDate,"mm/dd/yyyy")#.   <cfif TimeFormat(now(),"medium") GE "12:00:01 AM" and TimeFormat(now(),"medium") lt "9:00:00 AM"><span class="red"><br>WARNING: Not all of the deductions might be included yet since it is before 9:00 AM.</span></cfif></P>
	</cfoutput>
</cfif>

<div class="clearfix marginb5">
   <div class="pull-left">
		<cfif isdefined("GetDeduction")>
            <br>
            <CFINCLUDE TEMPLATE="PrevNextDeduction.cfm">
        </cfif>
    </div>
    <div class="pull-right margintop">
            <!--- Download csv file --->
            <cfoutput>
            <form method="post" action="/vendors/enhanced-vendor-remittance/download-csv/" class="pull-left">
            	<input type="hidden" name="CSV" value="Yes">
                <cfif MostRecent is not "Y">
                	<!---<cfif DateFormat(endDate,"mm/dd/yyyy") gt DateFormat(DateAdd("d",1,now()),"mm/dd/yyyy")>
						<cfset TmpEndDate = "#DateFormat(DateAdd("D",1,now()),"mm/dd/yyyy")#">--->
                    <cfif DateFormat(endDate,"mm/dd/yyyy") gt DateFormat(GetMaxIssue_Date,"mm/dd/yyyy")>
                       <cfset TmpEndDate = "#DateFormat(GetMaxIssue_Date,"mm/dd/yyyy")#">
                    <cfelse>
                        <cfset TmpEndDate = "#DateFormat(EndDate,"mm/dd/yyyy")#">
                    </cfif>

					<input type="hidden" name="startDate" value="#DateFormat(startDate,"mm/dd/yyyy")#">
                    <input type="hidden" name="MostRecent" value="N">
                    <input type="hidden" name="WorkDate" value="">
                    <input type="hidden" name="endDate" value="#DateFormat(TmpEndDate,"mm/dd/yyyy")#">
                    <input type="hidden" name="Sortby" value="#UrlEncodedFormat('#Sortby#')#">
                    <input type="hidden" name="AscDesc" value="#AscDesc#">
                    <input type="hidden" name="MostRecentDate" value="">
                    <input type="hidden" name="LastRecentDate" value="">

				<cfelse>
                	<cfset TmpEndDate="#DateFormat(LastRecentDate,"mm/dd/yyyy")#">
					<input type="hidden" name="LastRecentDate" value="#DateFormat(LastRecentDate,"mm/dd/yyyy")#">
                    <input type="hidden" name="MostRecent" value="Y">
                    <input type="hidden" name="MostRecentDate" value="#DateFormat(MostRecentDate,"mm/dd/yyyy")#">
                    <input type="hidden" name="Sortby" value="#UrlEncodedFormat('#Sortby#')#">
                    <input type="hidden" name="AscDesc" value="#AscDesc#">

				</cfif>

                <input type="submit" name="CSV" id="Download" value="CSV" class="small-btn">

            </form>
            </cfoutput>
        	<cfoutput>
            <form method="post" action="/vendors/enhanced-vendor-remittance/download-pdf/" target="_new" class="pull-left marginl15">
            <input type="hidden" name="PDF" value="Yes">
                <cfif MostRecent is not "Y">
                	<!---<cfif DateFormat(endDate,"mm/dd/yyyy") gt DateFormat(DateAdd("d",1,now()),"mm/dd/yyyy")>
						<cfset TmpEndDate = "#DateFormat(DateAdd("D",1,now()),"mm/dd/yyyy")#">--->
                    <cfif DateFormat(endDate,"mm/dd/yyyy") gt DateFormat(GetMaxIssue_Date,"mm/dd/yyyy")>
                    	<cfset TmpEndDate = "#DateFormat(GetMaxIssue_Date,"mm/dd/yyyy")#">
                    <cfelse>
                        <cfset TmpEndDate = "#DateFormat(EndDate,"mm/dd/yyyy")#">
                    </cfif>

					<input type="hidden" name="startDate" value="#DateFormat(startDate,"mm/dd/yyyy")#">
                    <input type="hidden" name="MostRecent" value="N">
                    <input type="hidden" name="WorkDate" value="">
                    <input type="hidden" name="endDate" value="#DateFormat(TmpEndDate,"mm/dd/yyyy")#">
                    <input type="hidden" name="Sortby" value="#UrlEncodedFormat('#Sortby#')#">
                    <input type="hidden" name="AscDesc" value="#AscDesc#">
                    <input type="hidden" name="MostRecentDate" value="">
                    <input type="hidden" name="LastRecentDate" value="">

				<cfelse>
                	<cfset TmpEndDate="#DateFormat(LastRecentDate,"mm/dd/yyyy")#">
					<input type="hidden" name="LastRecentDate" value="#DateFormat(LastRecentDate,"mm/dd/yyyy")#">
                    <input type="hidden" name="MostRecent" value="Y">
                    <input type="hidden" name="MostRecentDate" value="#DateFormat(MostRecentDate,"mm/dd/yyyy")#">
                    <input type="hidden" name="Sortby" value="#UrlEncodedFormat('#Sortby#')#">
                    <input type="hidden" name="AscDesc" value="#AscDesc#">

				</cfif>
                <input type="submit" name="PDF" id="PDF" value="PDF" class="small-btn">
                <a style="cursor:help;" href="javascript:makeRemote('DeductionDownloadHelp');"><img src="/Comptroller/images/button_question.gif" alt="Help" border="0" /></a>

            </form>
			</cfoutput>
    </div>
</div>

<div name="FormWrapper" id="FormWrapper">
    <div class="table-responsive-new">
<TABLE class="table table-striped vendor-table">
        <thead>
<tr>
<th id="SocSecNo" class="text-center"><A HREF="javascript: makeNewRemote('SSN')"  TITLE="The last 4-digits of the FEIN or Social Security Number for the deduction.  Click on the associated hyperlink to see the detail information regarding the deduction." STYLE="cursor:help">Soc Sec Number</A></th>
<th id="EmplName" class="text-center"><A HREF="javascript: makeNewRemote('Name')"  TITLE="This field displays the name of the employee or retiree at whose direction the deduction was made." STYLE="cursor:help">Name</A></th>
<th id="PPBeginDt" class="text-center"><A HREF="javascript: makeNewRemote('PPBeginDate')"  TITLE="This field displays the starting date for the pay period or retirement period to which the deduction applies." STYLE="cursor:help">Pay Period Beginning Date</A></th>
<th  id="PPEndDt" class="text-center"><A HREF="javascript: makeNewRemote('PPEndDate')"  TITLE="This field displays the ending date date for the pay period or retirement period to which the deduction applies." STYLE="cursor:help">Pay Period Ending Date</A></th>
<th  id="GeneratedDt" class="text-center"><A HREF="javascript: makeNewRemote('GeneratedDate')"  TITLE="For payroll, this field displays the date the deduction was processed plus one business day.  For retirement, this field displays the date the deduction was processed." STYLE="cursor:help">Generated Date</A></th>
<th  id="AnticipatedDt" class="text-center"><A HREF="javascript: makeNewRemote('AnticipatedDirDepDate')"  TITLE="This field displays expected date that the amount will be available in the account of the individual or institution for whom it was deducted." STYLE="cursor:help">Anticipated Direct Deposit Date</A></th>
<th  id="DeductionAmount" class="text-right"><A HREF="javascript: makeNewRemote('DeductionAmount')"  TITLE="This field displays the amount taken out of the salary or retirement payment at the direction of the payee." STYLE="cursor:help">Deduction Amount</A></th>
<th  id="WarrantTrace" class="text-center"><A HREF="javascript: makeNewRemote('DeductionWarrant')"  TITLE="A warrant is a check issued by the government, so think of the warrant number as a check number. If the payment was made via Direct Deposit, then
the warrant number becomes an EFT (electronic funds transfer) number, which is a string of only numerical values." STYLE="cursor:help">Warrant/Trace</A></th>
<th  id="PayCode" class="text-center"><A HREF="javascript: makeNewRemote('PayrollCode')"  TITLE="This field displays the payroll code associated with the deduction." STYLE="cursor:help">Payroll Code</A></th>
</tr>
        </thead>
<cfif isdefined("GetDeduction")>
	<CFOUTPUT QUERY="GetDeduction" STARTROW="#StartRow#" MAXROWS="#Max#">
    <TR <cfif currentrow mod 2 is 0>id="darkcolor"<cfelse>id="lightcolor"</cfif>>
        <cfif MostRecent is not "Y">
            <TD ALIGN="CENTER" id="SocSecNo2"><a HREF="/vendors/enhanced-vendor-remittance/deduction-detail/?Run_No=#URLEncodedFormat(Run_No)#&MostRecent=#MostRecent#&MostRecentDate=#DateFormat(StartDate,"mm/dd/yyyy")#&LastRecentDate=#DateFormat(TmpEndDate,"mm/dd/yyyy")#&startDate=#startDate#&endDate=#TmpEndDate#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&Work_Date=#URLEncodedFormat(DateFOrmat(Work_Date,"mm/dd/yyyy"))#&Max=#Max#&StartRow=#StartRow#" CLASS="hotsub" id="SSN">XXX-XX-#Id#</A></TD>
        <cfelse>
            <TD ALIGN="CENTER" id="SocSecNo2"><A HREF="/vendors/enhanced-vendor-remittance/deduction-detail/?Run_No=#URLEncodedFormat(Run_No)#&MostRecent=#MostRecent#&MostRecentDate=#DateFormat(MostRecentDate,"mm/dd/yyyy")#&LastRecentDate=#DateFormat(LastRecentDate,"mm/dd/yyyy")#&startDate=#MostRecentDate#&endDate=#TmpEndDate#&Sortby=#UrlEncodedFormat('#Sortby#')#&AscDesc=#AscDesc#&Work_Date=#URLEncodedFormat(DateFormat(Work_Date,"mm/dd/yyyy"))#&Max=#Max#&StartRow=#StartRow#" CLASS="hotsub" id="SSN">XXX-XX-#Id#</A></TD>
        </cfif>
        <TD ALIGN="CENTER" id="EmplName2">#Employee_Name#</TD>
        <TD ALIGN="CENTER" id="PPBeginDt2">#DateFormat(PP_Beginning_Date,"mm/dd/yy")#</TD>
        <TD ALIGN="CENTER" id="PPEndDt2">#DateFormat(PP_Ending_Date,"mm/dd/yy")#</TD>
        <TD ALIGN="CENTER" id="GeneratedDt2">#DateFormat(Work_Date,"mm/dd/yy")#</TD>
        <TD ALIGN="CENTER" id="AnticipatedDt3">#DateFormat(Issue_Date,"mm/dd/yy")#</TD>
        <TD ALIGN="right" id="DeductionAmount2"><cfif Deduction_Amount lt 0><font color="Red">$#NumberFormat(Deduction_Amount,"9,999,999.99")#</font><cfelse>$#NumberFormat(Deduction_Amount,"9,999,999.99")#</cfif></TD>
        <TD ALIGN="CENTER" id="WarrantTrace2">#Trailer_Warrant_Number#-<br>#Trailer_Warrant_Trace#</TD>
        <TD ALIGN="CENTER" id="PayCode2">#Pay_Code#</TD>
    </TR>

    </CFOUTPUT>
</cfif>
</TABLE>
</div>
<!--- Production --->
<div class="text-center"><p>Click <cfoutput><a href="https://illinoiscomptroller.gov/vendors/enhanced-vendor-remittance/instructions/" target="_new">
here</a></cfoutput> for assistance with this screen.</p></div>

</div>
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>


<script>

	$('#First').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to go to the first set of deduction records."
	});
	$('#Next').tooltip({
			'show': false,
				'placement': 'top',
				'title': "Click here to go to the next set of deduction records."
		});
	$('#Previous').tooltip({
			'show': false,
				'placement': 'top',
				'title': "Click here to go to the previous set of deduction records."
		});
	$('#Last').tooltip({
			'show': false,
				'placement': 'top',
				'title': "Click here to go to the last set of deduction records."
		});
	$('#Download').tooltip({
			'show': false,
				'placement': 'top',
				'title': "Click here to download the deduction records into an Excel Spreadsheet."
		});
	$('#PDF').tooltip({
			'show': false,
				'placement': 'top',
				'title': "Click here to generate the pdf report containing the deduction information"
		});
	$('#FindDeductions').tooltip({
		'show': false,
			'placement': 'top',
			'title': "Click here to see the detail information regarding this deduction."
	});
<!---
	$('#SocSecNo').tooltip({
            'show': false,
                'placement': 'top',
                'title': "The last 4-digits of the FEIN or Social Security Number for the deduction.  Click on the associated hyperlink to see the detail information regarding the deduction."
        });
	$('#EmplName').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The Name is ..."
	});
	$('#PPBeginDt').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The Pay Period Beginning Date is ...."
	});
	$('#PPEndDt').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The Pay Period Ending Date is ...."
	});
	$('#GeneratedDt').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The Generated Date is ..."
	});
	$('#AnticipatedDt').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The Anticipated Direct Deposit Date is ..."
	});
	$('#DeductionAmount').tooltip({
		'show': false,
			'placement': 'top',
			'title': "The Deduction Amount is ..."
	});
	--->
</script>

<!---</BODY>
</HTML>
--->
