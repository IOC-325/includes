<cfparam name="GETLASTUPDT" default="">

<!--- RK aded the belo code as part of SR#1050 --->
<cfinvoke component="/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
        method="GetLastUpdt"
        srce="LedgerDB2"
        returnVariable="GetLastUpdt">
<!--- RK aded the belo code as part of SR#1050 --->

<cfinvoke component="/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
        method="GetDailyCashBalance"
        LastUpdt="#DateFormat(GetLastUpdt, "mm/dd/yyyy")#"
        srce="LedgerDB2"
        returnVariable="GetDailyCashBalance">

<cftry>
    <cfoutput>
        <cfif GetDailyCashBalance.recordcount>
            <cfset EndDailyAmount = GetDailyCashBalance.SumOfBEGIN_DAILY_AMT + GetDailyCashBalance.SumOfRECEIPT_AMT + GetDailyCashBalance.SumOfTRANS_IN_AMT + GetDailyCashBalance.SumOfTRANS_OUT_AMT + GetDailyCashBalance.NET_WARRANTS>


            <div class="row row-eq-height">
                <div class="col-xs-1">
                    <a onclick='showPrev()' class="myarrow"><i class="fa fa-caret-left" aria-hidden="true"></i></a>
                </div>
                <div class="col-xs-10 col-sm-3">
                    <div class="release-date">
                        <div class="date-inner">
                            <span class="display-time">As of 8:00 AM</span>
                            <span class="display-month">#ucase(dateFormat(now(), "mmm dd"))#</span>
                            <span class="display-year">#ucase(dateFormat(now(), "yyyy"))#</span>
                        </div>
                    </div>
                </div>
                <div class="col-xs-10 col-xs-offset-1 col-sm-7 col-sm-offset-0 scroller" id="0" style="display: block;">
                    <div class="release-2col">
                        <div class="release-2col-inner">
                            <div class="text1">GENERAL FUNDS DAILY CASH TRANSACTIONS</div>
                            <div class="text2">
                                The General Funds balance provides an indication of the state's fiscal health. The state's largest and most important fund group, it includes seven funds, including the General Revenue Fund. 
                                <!--- The General Funds include the General Revenue Fund and three education funds, and is the state's largest and most important fund group. --->
                            </div>
                            <div class="text4">Beginning Daily Amount</div>
                            <div class="text3">#DollarFormat(GetDailyCashBalance.SumOfBEGIN_DAILY_AMT)#</div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-10 col-xs-offset-1 col-sm-7 col-sm-offset-0 scroller" id="1" style="display: none;">
                    <div class="release-2col">
                        <div class="release-2col-inner">
                            <div class="text1">GENERAL FUNDS DAILY CASH TRANSACTIONS</div>
                            <div class="text2">
                                The General Funds include the General Revenue Fund and three education funds, and is the state's largest and most important fund group.
                            </div>
                            <div class="text4">Receipt Amount</div>
                            <div class="text3">#DollarFormat(GetDailyCashBalance.SumOfRECEIPT_AMT)#</div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-10 col-xs-offset-1 col-sm-7 col-sm-offset-0 scroller" id="2" style="display: none;">
                    <div class="release-2col">
                        <div class="release-2col-inner">
                            <div class="text1">GENERAL FUNDS DAILY CASH TRANSACTIONS</div>
                            <div class="text2">
                                The General Funds include the General Revenue Fund and three education funds, and is the state's largest and most important fund group.
                            </div>
                            <div class="text4">Transfers In:</div>
                            <div class="text3">#DollarFormat(GetDailyCashBalance.SumOfTRANS_IN_AMT)#</div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-10 col-xs-offset-1 col-sm-7 col-sm-offset-0 scroller" id="3" style="display: none;">
                    <div class="release-2col">
                        <div class="release-2col-inner">
                            <div class="text1">GENERAL FUNDS DAILY CASH TRANSACTIONS</div>
                            <div class="text2">
                                The General Funds include the General Revenue Fund and three education funds, and is the state's largest and most important fund group.
                            </div>
                            <div class="text4">Transfers Out:</div>
                            <div class="text3">#DollarFormat(GetDailyCashBalance.SumOfTRANS_OUT_AMT)#</div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-10 col-xs-offset-1 col-sm-7 col-sm-offset-0 scroller" id="4" style="display: none;">
                    <div class="release-2col">
                        <div class="release-2col-inner">
                            <div class="text1">GENERAL FUNDS DAILY CASH TRANSACTIONS</div>
                            <div class="text2">
                                The General Funds include the General Revenue Fund and three education funds, and is the state's largest and most important fund group.
                            </div>
                            <div class="text4">Net Warrants Issued:</div>
                            <div class="text3">#DollarFormat(GetDailyCashBalance.NET_WARRANTS)#</div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-10 col-xs-offset-1 col-sm-7 col-sm-offset-0 scroller" id="5" style="display: none;">
                    <div class="release-2col">
                        <div class="release-2col-inner">
                            <div class="text1">GENERAL FUNDS DAILY CASH TRANSACTIONS</div>
                            <div class="text2">
                                The General Funds include the General Revenue Fund and three education funds, and is the state's largest and most important fund group.
                            </div>
                            <div class="text4">Ending Daily Amount:</div>
                            <div class="text3">#DollarFormat(EndDailyAmount)#*</div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-1">
                    <a onclick='showNext()' class="myarrow"><i class="fa fa-caret-right" aria-hidden="true"></i></a>
                </div>
            </div>
        </cfif>
    </cfoutput>

    <script>
        function showNext() {

            var scrollers = document.querySelectorAll('.scroller'), i, itemToShow;

            for (i = 0; i < scrollers.length; ++i) {

                if (scrollers[i].style.display == 'block') {
                    console.log(scrollers[i]);

                    itemToShow = i;
                    ++itemToShow;

                    if (itemToShow > 5) {
                        itemToShow = 0
                    }


                    scrollers[i].style.display = 'none';
                    scrollers[itemToShow].style.display = 'block';
                    break;
                }

            }
        }

        function showPrev() {

            var scrollers = document.querySelectorAll('.scroller'), i, itemToShow;

            for (i = 0; i < scrollers.length; ++i) {

                if (scrollers[i].style.display == 'block') {

                    itemToShow = i;
                    --itemToShow;

                    if (itemToShow < 0) {
                        itemToShow = 5
                    }

                    scrollers[i].style.display = 'none';
                    scrollers[itemToShow].style.display = 'block';
                    break;
                }

            }
        }
    </script>

    <cfcatch type="any">
        <cfdump var="#cfcatch#">
        <cfabort>
        <span style="color:Gray;">Sorry, we could not process your request. </span>
        <cfabort>
    </cfcatch>
</cftry>