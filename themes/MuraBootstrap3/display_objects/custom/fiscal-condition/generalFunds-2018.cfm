<cfparam name="GETLASTUPDT" default="">

<!--- RK added the below code as part of SR#1050 --->
<cfinvoke component="/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
        method="GetLastUpdt"
        srce="LedgerDB2"
        returnVariable="GetLastUpdt">

<cfinvoke component="/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
        method="GetDailyCashBalance"
        LastUpdt="#DateFormat(GetLastUpdt, "mm/dd/yyyy")#"
        srce="DB2PRD"
        returnVariable="GetDailyCashBalance">

<cfstoredproc datasource="Common" procedure="Read_GetLastWorkDate">
    <cfprocresult name="q_last_work_date">
</cfstoredproc>	

<cftry>
    <cfoutput>
        <cfif GetDailyCashBalance.recordcount>
            <cfset EndDailyAmount = GetDailyCashBalance.SumOfBEGIN_DAILY_AMT + GetDailyCashBalance.SumOfRECEIPT_AMT + GetDailyCashBalance.SumOfTRANS_IN_AMT + GetDailyCashBalance.SumOfTRANS_OUT_AMT + GetDailyCashBalance.NET_WARRANTS>

                <div class="date-inner text-center">
                    <span class="display-time">Summary of activity for</span>
                    <span class="display-month">#ucase(dateFormat(q_last_work_date.last_work_date, "mmmm dd"))#</span>
                    <span class="display-year">#ucase(dateFormat(q_last_work_date.last_work_date, "yyyy"))#</span>
                </div>

                <h2 class="margintop30">GENERAL FUNDS DAILY CASH TRANSACTIONS</h2>
                <p class="margintop"><strong>The General Funds balance provides an indication of the state's fiscal health. The state's largest and most important fund group, it includes several funds, including the General Revenue Fund.</strong></p>
                <div class="row">
                    <div class="col-xs-12 col-sm-10 col-sm-offset-1">
                        <div class="amount_type">Beginning Daily Amount:</div>
                        <div class="amount">#DollarFormat(GetDailyCashBalance.SumOfBEGIN_DAILY_AMT)#</div>

                        <div class="amount_type">Receipt Amount:</div>
                        <div class="amount">#DollarFormat(GetDailyCashBalance.SumOfRECEIPT_AMT)#</div>

                        <div class="amount_type">Transfers In:</div>
                        <div class="amount">#DollarFormat(GetDailyCashBalance.SumOfTRANS_IN_AMT)#</div>

                        <div class="amount_type">Transfers Out:</div>
                        <div class="amount">#DollarFormat(GetDailyCashBalance.SumOfTRANS_OUT_AMT)#</div>

                        <div class="amount_type">Net Warrants Issued:</div>
                        <div class="amount">#DollarFormat(GetDailyCashBalance.NET_WARRANTS)#</div>

                        <div class="amount_type">Ending Daily Amount:</div>
                        <div class="amount" style="color:rgba(20, 80, 137, 1);">#DollarFormat(EndDailyAmount)#*</div>

                        <p class="well well-lg nomargin margintop30">
                            <span style="color:rgba(20, 80, 137, 1);">*</span>  Reflects operating revenue used to address obligations
                            and bill backlogs. At times, balances may rise in order to meet these pending obligations, such as
                            General State Aid, Medical, Human Services, Payrolls, Pensions, etc. The balance above represents the General funds cash balance as of the start of the current business day.
                        </p>
                    </div>
                </div>
        </cfif>
    </cfoutput>
    <cfcatch type="any">
        <cfdump var="#cfcatch#">
        <cfabort>
        <span style="color:Gray;">Sorry, we could not process your request. </span>
        <cfabort>
    </cfcatch>
</cftry>