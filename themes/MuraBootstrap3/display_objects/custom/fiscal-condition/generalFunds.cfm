<link rel="stylesheet" type="text/css" href="/ledger/includes/themes/MuraBootstrap3/assets/font-awesome/css/font-awesome.min.css">
<link href="/comptroller/includes/themes/MuraBootstrap3/assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<style>
.mytooltip {
    position: relative;
    display: inline-block;
    /*border-bottom: 1px dotted black;*/

}

.mytooltip .mytooltiptext {
    visibility: hidden;
    width: 120px;
    background-color: #2CABE1;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 10px 10px 10px 10px;
    position: absolute;
    z-index: 1;
    bottom: 100%;
    left: 50%;
    margin-left: -60px;
    /*opacity: 0;*/
    transition: opacity 1s;
    font-family: verdana;
}

.mytooltip .mytooltiptext::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #555 transparent transparent transparent;
}

.mytooltip:hover .mytooltiptext {
    visibility: visible;
    opacity: 1;
}

.mytooltiptext{font-size:12px;}

.fa {
  display: inline-block ;
  font-family: FontAwesome ;
  font-style: normal ;
  font-weight: normal ;
  font-size: initial !important;
  line-height: 1 ;
  -webkit-font-smoothing: antialiased ;
  -moz-osx-font-smoothing: grayscale ;
}

.icon-before {  // For icons added immediately before the element targeted
    margin-right: .25em;
    color: @brand-primary;
}

    .info-formatting{
        font-size:16px;top:-2em;position:relative;color:white;
    }
.amount {
    font-size: 45px;
    font-weight: 900;
}
</style>
<cfoutput>#$.dspThemeInclude('display_objects/custom/fiscal-condition/GeneralFundsBudgetaryBalanceDetailsModalWindow.cfm')#</cfoutput>
<cfparam name="GETLASTUPDT" default="">

<!--- RK aded the belo code as part of SR#1050 --->
<cfinvoke component = "/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetLastUpdt"
   srce="LedgerDB2"
   returnVariable = "GetLastUpdt">
<!--- RK aded the belo code as part of SR#1050 --->

 <cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetDailyCashBalance"
     LastUpdt = "#DateFormat(GetLastUpdt,"mm/dd/yyyy")#"
   srce="LedgerDB2"
   returnVariable = "GetDailyCashBalance">
<!--- <cfdump var="#GetDailyCashBalance#"> <Cfabort>--->
 <cftry>
 <cfoutput>
 <cfif GetDailyCashBalance.recordcount>
   <cfset EndDailyAmount = GetDailyCashBalance.SumOfBEGIN_DAILY_AMT + GetDailyCashBalance.SumOfRECEIPT_AMT + GetDailyCashBalance.SumOfTRANS_IN_AMT + GetDailyCashBalance.SumOfTRANS_OUT_AMT + GetDailyCashBalance.NET_WARRANTS>

<div class="row">
						<div class="col-sm-10 col-sm-offset-1">

							<h2>General Funds Daily Cash Transactions</h2>
							<p>The General Funds include the General Revenue Fund and three education funds,
                and is the state's largest and most important fund group.</p>

							<div class="row">
								<div class="col-sm-11 col-sm-offset-1">
									<div class="detail">
										<div class="amount_type">Beginning Daily Amount:</div>
										<div class="amount">#DollarFormat(GetDailyCashBalance.SumOfBEGIN_DAILY_AMT)#<div class="mytooltip"><i class="fa fa-info-circle info-formatting"></i><span class="mytooltiptext">The amount of cash in the fund at the beginning of the business day.</span></div>
                    </div>
										<div class="amount_type">Receipt Amount:</div>
										<div class="amount">#DollarFormat(GetDailyCashBalance.SumOfRECEIPT_AMT)#<div class="mytooltip"><i class="fa fa-info-circle info-formatting"></i><span class="mytooltiptext">The amount of deposits into the fund for the business day from various taxes and fees.</span></div></div>
										<div class="amount_type">Transfers In:</div>
										<div class="amount">#DollarFormat(GetDailyCashBalance.SumOfTRANS_IN_AMT)#<div class="mytooltip"><i class="fa fa-info-circle info-formatting"></i><span class="mytooltiptext">The amount of monies transferred into the fund from other state funds for the business day.</span></div></div>
										<div class="amount_type">Transfers Out:</div>
										<div class="amount">#DollarFormat(GetDailyCashBalance.SumOfTRANS_OUT_AMT)#<div class="mytooltip"><i class="fa fa-info-circle info-formatting"></i><span class="mytooltiptext">The amount of monies transferred out of the fund to other state funds for the business day.</span></div></div>
										<div class="amount_type">Net Warrants Issued:</div>
										<div class="amount">#DollarFormat(GetDailyCashBalance.NET_WARRANTS)#<div class="mytooltip"><i class="fa fa-info-circle info-formatting" style=""></i><span class="mytooltiptext">The amount of vouchers released from the fund for the business day.</span></div></div>
										<div class="amount_type">Ending Daily Amount:</div>
										<div class="amount" style="color:##2CABE1">#DollarFormat(EndDailyAmount)#*</div>
                    <!--- <p class="well well-lg" style="background-color:##808285; color:##fff; margin-top:20px; font-style:italic; border-color:##2CABE1;"><span style="color:##2CABE1;">*</span>
                      Reflects all general funds. Without a budget or legal spending authority, the majority of this amount cannot be used to pay down the bill backlog. Such balances are growing and await appropriations by the General Assembly and the Governor.</p>
									</div>--->
								</div>
							</div>
</cfif></cfoutput>
							<h2>General Funds Budgetary Balance</h2>
              <p>The General Funds balance provides an indication of the state's fiscal health.
                It is made up of four funds within the state treasury:</p>
                <ul>
                  <li>General Revenue Fund, which acts as the state's largest operating account</li>
                  <li>Education Assistance Fund</li>
                  <li>Common School Fund</li>
                  <li>Common School Special Account Fund</li>
                </ul>
              <p>To learn more about the General Funds and the state's fiscal health, click <a href="##myModal" data-toggle="modal" class="brighter">here</a>.</p>
							<!--- <p>The General Funds is a grouping of four funds within the state treasury.
                The funds included in this grouping are the General Revenue Fund,
                which acts as the state's largest operating account, and the three school funds:
                the Education Assistance Fund, the Common School Fund, and the Common School Special Account Fund.
                Reviewing this figure provides an indication of the state's fiscal health.
                The figures in the chart below show the gross amount of outstanding expenditures budgeted
                for these four funds when the fiscal year closed.
                A negative balance means there were more expenditures reported to the Comptroller
                than there were revenues to pay them.
                The General Funds' Budgetary Balance is used by budget officials in
                <a href="http://illinoiscomptroller.gov/ledger/assets/File/fy15-Budget-balance-views.pdf">some of the
                  ways they define a balanced budget.</a></p> --->

						</div>

					</div>


<cfcatch type="any">
 <cfdump var="#cfcatch#">
 <cfabort>
 <span style="color:Gray;">Sorry, we could not process your request. </span><cfabort>
</cfcatch>
</cftry>
