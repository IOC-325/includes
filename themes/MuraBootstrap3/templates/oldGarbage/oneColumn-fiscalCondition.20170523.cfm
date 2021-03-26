<!--- SR 17070: Ledger Enhancements
	Date: 5/4/17
	Author: Andy Peterson
	Work Item 1016 - Cleaning up.
	--->
<!---
Created By: Gary Ashbaugh
Date Created: 11-29-11

Description:  The program will give the user the list of Daily Transactions: General Funds, Bond Ratings, Backlogs, and Voucher Backlogs.
--->

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

<!--- Get Current Voucerh Backlogs from SQL Server --->
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

<!--- SR - Set up contentID variables based on application environment - dev, uat, prod --->
<!--- Bill Backlog in Dev - 91BD1BB0-99F8-0726-AEC32FBACF42E060 or 90D56047-CC51-9A27-C45BA3E2D661E4F5? --->

			<!-- START BACKLOG --><!--- contentID will have to change based on environment. --->
			<cfset billBacklog = $.getBean('content').loadBy( contentId = '90D56047-CC51-9A27-C45BA3E2D661E4F5' ) />
			<a name="bill-backlog"></a>
			<div id="backlog">
				<div class="container">#$.setDynamicContent( billBacklog.getBody() )#
				</div>
			</div>
			<!-- END BACKLOG -->

			<!-- START GENERALFUND -->
			<cfset generalFund = $.getBean('content').loadBy( contentId = '90D37F92-9580-6CED-2B7EC341FD8942FC' ) />
			<a name="general-funds"></a>
			<div id="generalfund">
				<div class="container">
					#$.setDynamicContent( generalFund.getBody() )#
				</div>
			</div>
			<!-- END GENERALFUND -->

			<!-- START SEARCHFUND -->
			<cfset searchFund = $.getBean('content').loadBy( contentId = '90D17A44-CB6B-77A6-D4DC314B32575620' ) />
			<a name="fund-search"></a>
			<div id="searchfund">
				<div class="container">
					#$.setDynamicContent( searchFund.getBody() )#
				</div>
			</div>
			<!-- END SEARCHFUND -->

			<!-- START BONDRATING -->
			<cfset bondRating = $.getBean('content').loadBy( contentId = '90CB4373-B7D5-ABC2-183072424298B197' ) />
			<a name="bond-ratings"></a>
			<div id="bondrating">
				<div class="container">
					#$.setDynamicContent( bondRating.getBody() )#
				</div>
			</div>
			<!-- END BONDRATING -->

			<!-- APPROPRIATION INQUIRIES -->
			<cfset appropriationInquiries = $.getBean('content').loadBy( contentId = '2D5AF696-B9EB-9A3B-67A28085DA856AC9' ) />
			<a name="appropriation-inquiries"></a>
			<div id="appropriationInquiries">
				<div class="container">
					#$.setDynamicContent( appropriationInquiries.getBody() )#
				</div>
			</div>
			<!-- END APPROPRIATION INQUIRIES -->

			<cfinclude template="inc/footer.cfm" />
		</div>
	</body>
	<cfinclude template="inc/html_foot.cfm" />

</cfoutput>
