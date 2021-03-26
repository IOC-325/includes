<cfparam name="GETLASTUPDT" default="">
<!--- Get Last Date of Transactions  --->
<!--- SR 17070 Work Item 1016 --->
<cfinvoke component="/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
        method="GetLastUpdt"
        srce="LedgerDB2"
        returnVariable="GetLastUpdt">
<!--- Get Current Backlogs --->
<cfinvoke component="/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
        method="GetBacklogs"
        LastUpdt="#DateFormat(GetLastUpdt, "mm/dd/yyyy")#"
        srce="LedgerDB2"
        returnVariable="GetBacklogs">

<cfinvoke component="/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
        method="GetVoucherBacklogs"
        srce="LedgerDB2"
        returnVariable="GetVoucherBacklogs">
    
<!--- Why LedgerDB2 --->


<cftry> <!--- This will change from 2610000000 to 2476000000 on 1/20/18 at 8:00 AM --->

    <!--- 2018 12 13 - Using Class Extensions for amounts so that user can update them in content manager ---> 
    <!--- <cfdump var="#m.content()#"> --->
    <cfset variables.InMillionsDecimal = "#esapiEncode('html', m.content('AmountHeldAtAgenciesInMillions'))#">
    <cfset variables.TotalBacklog = GetBacklogs.SumOfEnd_OF_DAY_BALANCE + #esapiEncode('html', m.content('AmountHeldAtAgencies'))#>
    <!--- 2018 12 13 - /Using Class Extension ---> 
    <cfoutput>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-sm-offset-0 col-md-10 col-md-offset-1">
                <div class="row row-eq-height">
                    <div class="col-xs-12 col-sm-3">
                        <div class="release-date">
                            <div class="date-inner">
                                <span class="display-time">As of 8:00 AM</span>
                                <!--- <span class="display-month">#ucase(dateformat(datePart('m', now()), 'mmm'))#  #dateformat(datePart('d', now()), 'dd')#</span> --->
                                <span class="display-month">#ucase(dateFormat(now(), "mmm dd"))#</span>                                
                                <span class="display-year">#datePart('yyyy', now())#</span>
                            </div>
                        </div>
                    </div>

                    <!--- 20200605 sample text: The backlog includes General Funds liabilities currently at the Illinois Office of Comptroller and the estimated $530 million reported by state agencies. It does not include $2.72 billion in short-term borrowing that is required to be repaid.*--->
                    <div class="col-xs-12 col-sm-9 pd-left0">
                        <div class="release-2col">
                            <div class="release-2col-inner">
                                <div class="text1">ESTIMATED GENERAL FUNDS PAYABLE BACKLOG</div>
                                <div class="text2">The backlog includes General Funds liabilities currently at the Illinois Office of Comptroller and the estimated  
                                $#esapiEncode('html', m.content('AmountHeldAtAgenciesInMillions'))# million reported by state agencies. It does not include $2.72 billion in short-term borrowing that is required to be repaid.*</div>
                                <div class="text3 marginb15">#DollarFormat(variables.TotalBacklog)#</div>
                                <div class="release-2col-inner-sub">
                                    <div class="text1">Vouchers Backlogged</div>
                                    <div class="text2">Includes vouchers and transfers to other state funds.</div>
                                    <div class="text3">#NumberFormat(GetVoucherBacklogs.TotVoucherBacklog, "999,999,999")#</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>
    <cfcatch type="any">
        <cfdump var="#cfcatch#">
        <cfabort>
        <span style="color:Gray;">Sorry, we could not process your request. </span>
        <cfabort>
    </cfcatch>
</cftry>
