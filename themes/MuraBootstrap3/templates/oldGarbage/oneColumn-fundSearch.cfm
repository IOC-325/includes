<!--- SR 17070: Ledger Enhancements
 Date: 5/4/17
 Author: Andy Peterson
 --->

<!--- SR 17070 / WO 1028 - GRF to Go Before General Funds
Developer: Andy Peterson
Date 5/23/17
--->

<!---
Created By: Gary Ashbaugh
Date Created: 11-29-11

Description:  The program will give the user the list of Daily Transactions: General Funds, Bond Ratings, Backlogs, and Voucher Backlogs.
--->


<!--- SR 17XXX - Set up contentID variables based on application environment - dev, uat, prod --->
<!--- Bill Backlog in Dev - 91BD1BB0-99F8-0726-AEC32FBACF42E060 or 90D56047-CC51-9A27-C45BA3E2D661E4F5? --->
<cfif cgi.server_name contains "dev">
 <cfset variables.SearchFundContentID = "90D17A44-CB6B-77A6-D4DC314B32575620">
<cfelseif cgi.server_name contains "uat">
 <cfset variables.SearchFundContentID = "90D17A44-CB6B-77A6-D4DC314B32575620">
<cfelse>
 <cfset variables.SearchFundContentID = "90D17A44-CB6B-77A6-D4DC314B32575620">
</cfif>

<cfparam name="GETLASTUPDT" default="">

<!--- Get Last Date of Transactions From SQL Server --->
<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetLastUpdt"
   srce="LedgerDB2"
   returnVariable = "GetLastUpdt">

<!--- Get General Funds Daily Cash Transactions from SQL Server--->
<cfif isdefined("GETLASTUPDT")>
 <cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetDailyCashBalance"
     LastUpdt = "#DateFormat(GetLastUpdt,"mm/dd/yyyy")#"
   srce="LedgerDB2"
   returnVariable = "GetDailyCashBalance">

  <!--- Get Current Bond Ratings  from SQL Server--->
 <cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetBondRating"
   srce="General"
   returnVariable = "GetBondRating">


 <!--- Get Current Backlogs from SQL Server--->
 <cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetBacklogs"
     LastUpdt = "#DateFormat(GetLastUpdt,"mm/dd/yyyy")#"
   srce="LedgerDB2"
   returnVariable = "GetBacklogs">

</cfif>

<!--- Get Current Voucher Backlogs from SQL Server --->
<cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetVoucherBacklogs"
   srce="LedgerDB2"
   returnVariable = "GetVoucherBacklogs">

<!--- Start New Content --->
<cfoutput>
 <cfinclude template="inc/html_head.cfm" />
 <body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
  <div id="layout">
   <cfinclude template="inc/navbar.cfm" />

   <!-- START SUBMENU -->
   <cfset getSubNav = $.getSubNav() />
   <div id="submenu" class="hidden-xs">
    <div class="container">
     <ul>
      #getSubNav#
     </ul>
    </div>
   </div>
   <!-- END SUBMENU -->

   <!--- <div id="backlog"></div> --->

   <!-- START SEARCHFUND -->
   <cfset searchFund = $.getBean('content').loadBy( contentId = '#variables.SearchFundContentID#' ) />

   <div id="searchfund">
    <div class="container"><a name="fund-search"></a>
     #$.setDynamicContent( searchFund.getBody() )#
    </div>
   </div>
   <!-- END SEARCHFUND -->



   <cfinclude template="inc/footer.cfm" />
  </div>
 </body>
 <cfinclude template="inc/html_foot.cfm" />

</cfoutput>
