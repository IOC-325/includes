<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
<!---<head>--->
	<!---<title>Vendor Payments</title>--->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Enhanced Vendor Remittance Manage User">
	<meta name="author" content="Gary Ashbaugh">
	<meta name="robots" content="noindex,nofollow">
<cfset DisplayvendorRecord = False>
<cfparam name="Session.TargetEMail" default="">


<SCRIPT LANGUAGE="JavaScript" type="text/javascript" src="script1.js"></SCRIPT>  

<link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">

<cfoutput>
<cfStoredProc  datasource="SMTPBouncedEmailsUAT" Procedure="Get_EmailHistory">
	<cfprocparam type="In" cfsqltype="cf_sql_varchar" dbvarname="@Email" value="#trim(url.TargetEmail)#">
	<cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="@BouncedCheck" value="N">
	<cfprocparam type="In" cfsqltype="cf_sql_date" dbvarname="@StartDate" value="#DateFormat(dateadd("d",-61,now()),"mm/dd/yyyy")#">
	<cfprocparam type="In" cfsqltype="cf_sql_date" dbvarname="@EndDate" value="#DateFormat(dateadd("d",-1,now()),"mm/dd/yyyy")#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetEmailHistoryRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetEmailHistoryRetMsg">
	<cfprocresult name="GetListofBouncedEmails">
</cfstoredproc>

<!---
<cfStoredProc  datasource="SMTPBouncedEmailsUAT" Procedure="Get_EmailLogsNotLoaded">
	<cfprocparam type="In" cfsqltype="cf_sql_date" dbvarname="@StartDate" value="#DateFormat(dateadd("d",-61,now()),"mm/dd/yyyy")#">
	<cfprocparam type="In" cfsqltype="cf_sql_date" dbvarname="@EndDate" value="#DateFormat(dateadd("d",-1,now()),"mm/dd/yyyy")#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetEmailLogsNotLoadedRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetEmailLogsNotLoadedRetMsg">
	<cfprocresult name="GetEmailLogsNotLoaded">
</cfstoredproc>
--->

<cfif GetEmailHistoryRetVal is 0>
	<cfset DisplayvendorRecord = True>      
<cfelse>
    <div class="alert alert-danger marginb20"><b>Could not find any Email records <cfif trim(url.TargetEmail) is not "">matching #url.TargetEmail#</cfif></b></div>
</cfif>
</cfoutput>

<CFINCLUDE TEMPLATE="VendHeader.cfm">

<!--- Update Form --->
<cfif DisplayvendorRecord is True>
	<!---<body >--->
    <!---
	<p>There were issue(s) loading the SMTP log file on the following Date(s).</p>
    <p class="marginb20"><b><u>Date Accepted</U></b></p>
    <p class="marginb20"><cfoutput query="GetEmailLogsNotLoaded">#DateFormat(Issue_Date,"mm/dd/yyyy")#, </cfoutput></p>
	--->
    <p class="marginb20">Below is a list of the emails for <cfoutput><b>#GetListofBouncedEmails.Recipient#</b></cfoutput> that were sent via our Email Relay Company.</p>
    <div class="table-responsive">
        <table class="table table-striped vendor-table">
            <thead>
                <tr>
                	<th>Id</th>
                    <th>Message Id</th>
                    <th>Date Delivered</th>
                    <th>Recipient</th>
                    <th>Response Code</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query="GetListofBouncedEmails">
                <cfif (MailFrom is "Vendor_Remittance@IllinoisComptroller.Gov" or mailfrom is "Remittance@IllinoisComptroller.Gov")>
                <tr>
                	<td>#Id#</td>
                    <td>#Msg_Id#</td>
                    <td>#DateFormat(msg_time,"mm/dd/yyyy")#</td>
                    <td>#msg_data_rcpt_to#</td>
                    <td><cfif details_delivery_code is not "250"><font color="Red"></cfif>#details_delivery_code#<cfif details_delivery_code is not "250"></font></cfif></td>
                    <td><cfif details_delivery_code is not "250"><font color="Red"></cfif>#details_delivery_event#<cfif details_delivery_code is not "250"></font></cfif></td>
                </tr>
                </cfif>
                </cfoutput>
            </tbody>
        </table>
    </div>
</cfif>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
