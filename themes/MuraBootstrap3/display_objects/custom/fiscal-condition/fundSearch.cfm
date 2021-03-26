<!--- Administering Agency Fix 
  - ASP, 20180124
  - Add funds that have various administering agencies#application.whDSN#
    SR #18011
  cachedwithin="#CreateTimeSpan(1,0,0,0)#"
--->

<link rel="stylesheet" type="text/css" href="/ledger/includes/themes/MuraBootstrap3/assets/font-awesome/css/font-awesome.min.css">

<style>
    .mytooltip {
        position: relative;
        display: inline-block;
        /*border-bottom: 1px dotted black;*/
    }

    .mytooltip .mytooltiptext {
        visibility: hidden;
        width: 120px;
        background-color: rgba(44, 171, 225, 1);
        color: rgba(255, 255, 255, 1);
        text-align: center;
        border-radius: 6px;
        padding: 10px;
        position: absolute;
        z-index: 1;
        bottom: 100%;
        left: 50%;
        margin-left: -60px;
        /*opacity: 0;*/
        transition: opacity 1s;
        font-family: 'Avenir', Helvetica, Arial, sans-serif;
        font-size: 12px;
        line-height: 16px;;
    }

    .mytooltip .mytooltiptext::after {
        content: "";
        position: absolute;
        top: 100%;
        left: 50%;
        margin-left: -5px;
        border-width: 5px;
        border-style: solid;
        border-color: rgba(44, 171, 225, 1) transparent transparent transparent;
    }

    .mytooltip:hover .mytooltiptext {
        visibility: visible;
        opacity: 1;
    }

    .fa {
        display: inline-block;
        font-family: FontAwesome;
        font-style: normal;
        font-weight: normal;
        font-size: initial !important;
        line-height: 1;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }

    .info-formatting {
        font-size: 16px;
        top: -19px;
        position: relative;
       /* color: white;*/
    }



</style>
<!--- <cfif cgi.http_host contains "uat">
 <cfset variables.actionPage = "64633888-5056-932D-88B51EA83A2F5419">
 <cfset variables.fundPage = "A72F6F8F-5056-9397-F02AE48ED06E6CD3">
<cfelse> --->
<cfset variables.actionPage = "90D17A44-CB6B-77A6-D4DC314B32575620">
<cfset variables.fundPage = "90D17A44-CB6B-77A6-D4DC314B32575620">
<!--- </cfif> --->

<cfif isDefined("url.orderby")>
    <cfcookie name="orderBy" expires="never" value="#url.orderBy#">
    <cfset variables.orderBy = cookie.orderby>
</cfif>

<cfif isDefined("cookie.orderby")>
    <cfset variables.orderby = cookie.orderby>
</cfif>

<cfparam name="variables.orderBy" default="Name">

<cfif isdefined("form.getfundDescription")>
    <cfif isDefined("form.cbfund")>
        <cflocation url="/Ledger/?LinkServID=#variables.FundPage#&cbfund=#cbfund#">
    <cfelse>
        <p>Please make sure you select a fund first.</p>
        <cfabort>
    </cfif>
</cfif>

<cfparam name="cbfund" default="0001">
<cfif cbfund eq "" or not isDefined("form.cbfund")>
    <cfset form.cbfund = "0001">
<cfelse>
    <cfset cbfund = form.cbfund>
</cfif>
<cftry>

    <cfquery NAME="results" DATASOURCE="#application.whdsn#"><!--- CACHEDWITHIN="#CreateTimeSpan(0,12,0,0)#"--->
        <cfif CBFund is "Empty">
            SELECT #application.whOwner#FUND.NAME,
            #application.whOwner#FUND.FUND,
            #application.whOwner#SUMM_DAILY_CASH.BEGIN_DAILY_AMT,
            #application.whOwner#SUMM_DAILY_CASH.RECEIPT_AMT,
            #application.whOwner#SUMM_DAILY_CASH.TRANS_IN_AMT,
            #application.whOwner#SUMM_DAILY_CASH.TRANS_OUT_AMT,
            #application.whOwner#SUMM_DAILY_CASH.WARR_ISSUED_AMT+#application.whOwner#SUMM_DAILY_CASH.WARR_VOIDED_AMT+#application.whOwner#SUMM_DAILY_CASH.MISCELLANEOUS_AMT+#application.whOwner#SUMM_DAILY_CASH.REFUND_AMT as NET_WARR_ISSUED,
            #application.whOwner#SUMM_DAILY_CASH.END_DAILY_AMT
        FROM #application.whOwner#SUMM_DAILY_CASH
        INNER JOIN
            #application.whOwner#FUND ON
            #application.whOwner#SUMM_DAILY_CASH.FUND = #application.whOwner#FUND.FUND
        WHERE
        (#application.whOwner#SUMM_DAILY_CASH.BALANCE_DATE=(SELECT MAX(BALANCE_DATE) FROM #application.whOwner#SUMM_DAILY_CASH))
        AND
        (#application.whOwner#SUMM_DAILY_CASH.FUND='0001')
        <cfelse>
            SELECT #application.whOwner#FUND.NAME,
            #application.whOwner#FUND.FUND,
            #application.whOwner#SUMM_DAILY_CASH.BEGIN_DAILY_AMT,
            #application.whOwner#SUMM_DAILY_CASH.RECEIPT_AMT,
            #application.whOwner#SUMM_DAILY_CASH.TRANS_IN_AMT,
            #application.whOwner#SUMM_DAILY_CASH.TRANS_OUT_AMT,
            #application.whOwner#SUMM_DAILY_CASH.WARR_ISSUED_AMT+#application.whOwner#SUMM_DAILY_CASH.WARR_VOIDED_AMT+#application.whOwner#SUMM_DAILY_CASH.MISCELLANEOUS_AMT+#application.whOwner#SUMM_DAILY_CASH.REFUND_AMT as NET_WARR_ISSUED,
            #application.whOwner#SUMM_DAILY_CASH.END_DAILY_AMT
        FROM #application.whOwner#SUMM_DAILY_CASH
        INNER JOIN
            #application.whOwner#FUND ON
            #application.whOwner#SUMM_DAILY_CASH.FUND = #application.whOwner#FUND.FUND
        WHERE
        (#application.whOwner#SUMM_DAILY_CASH.BALANCE_DATE=(SELECT MAX(BALANCE_DATE) FROM #application.whOwner#SUMM_DAILY_CASH))
        AND
        (#application.whOwner#SUMM_DAILY_CASH.FUND=
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#CBFund#">)
        </cfif>
    </cfquery>
    <cfcatch type="database">
        <cfinclude template="/warehouseOfflineMessage.htm">
        <cfabort>
    </cfcatch>
</cftry>
<!--- <cfdump var="#results#">
 --->

<cfform role="form" class="form-horizontal" METHOD="Post" name="Form1">
    <cfif variables.orderby eq "Number">
            <cfinvoke component="/common/FUN4" method="dropdownfund" returnvariable="dropdownfund" orderby="fund">
        <cfelseif variables.orderby eq "Name">
            <cfinvoke component="/common/FUN4" method="dropdownfund" returnvariable="dropdownfund" orderby="name">
    </cfif>
    <fieldset id="fldFund">
    <div class="row">
    <div class="col-sm-10 col-sm-offset-1">
    <select id="cbFund" name="cbFund" class="select2">
    <cfoutput>
        <cfloop QUERY="DropDownFund">
            <cfif variables.orderBy eq "Name">
                    <option VALUE="#FUND#" <cfif cbFund eq Fund>selected</cfif>>#NAME# - #FUND# </option>
            <cfelse>
                    <option VALUE="#FUND#" <cfif cbFund eq Fund>selected</cfif>>#FUND# - #NAME# </option>
            </cfif>
        </cfloop></cfoutput>
    </select>
    </div>
    </div>
    </fieldset>

    <div class="text-center form-group">
        <button type="submit" class="btn btn-primary" href="##cfFund" value="Get Fund Balance">Search</button>
    </div>
    <div class="row">
    <div class="explosive">
    <div class="col-xs-12 col-sm-10 col-sm-offset-1">
    <CFIF NOT Results.recordcount>
        <p align="center">No Results Found</p><!--- <img src="../images/NoResultsFound.png" /> --->
        <div class="text-center margintop30">
            <button type="button" class="btn btn-default" name="GetFundDetails" value="Learn More About This Fund">
            Learn More About This Fund </button>
        </div>
    <cfelse>
        <cfif isDefined("form.GetFundDetails")>

            <cfif cbfund eq "">
                <cfset cbfund = '0145'></cfif>

<!--- Administering Agency Fix 
  - ASP, 20180124
  - Add funds that have various administering agencies#application.whDSN#
    SR #18011
  cachedwithin="#CreateTimeSpan(1,0,0,0)#"
--->
<cfquery name="qryListOfVariousFunds" datasource="#application.whDSN#">
select fund 
from wh.fund 
where ADMINSTRING_AGENCY = 'VAR'
group by fund
</cfquery>

<cfset variables.listOfVariousFunds = "">
<cfloop query="qryListOfVariousFunds">
<cfset variables.listOfVariousFunds = listAppend(variables.listOfVariousFunds, qryListOfVariousFunds.fund)>
</cfloop>                

<CFQUERY DATASOURCE="#application.whDSN#" NAME="RESULTS" cachedwithin="#CReateTimeSpan(1, 0, 0, 0)#">
SELECT
f.OFFICIAL_FUND_NAME
, f.FUND
, f.STATUS
, f.EFFECTIVE_DATE
, f.STATUTORY_ORIGIN
, f.ADMINSTRING_AGENCY
, f.CATEGORY
, f.FUND_DESCRIPTION1
, f.FUND_DESCRIPTION2
, f.FUND_DESCRIPTION3
, f.FUND_DESCRIPTION4
, f.FUND_DESCRIPTION5
, f.FUND_DESCRIPTION6
, f.FUND_DESCRIPTION7
, f.FUND_DESCRIPTION8
, f.FUND_DESCRIPTION9
, fc.NAME
<cfif not ListFind(variables.listOfVariousFunds,cbFund)>
, c.NAME as AGENCY_NM
</cfif>
FROM (WH.fund as f inner join wh.fund_cat as fc on (f.Category = fc.Category )
and (f.fiscal_year = fc.fiscal_year))
<cfif not ListFind(variables.listOfVariousFunds,cbFund)>
INNER JOIN WH.AGENCY as c on f.ADMINSTRING_AGENCY = c.AGENCY
</cfif>
where f.fiscal_year = <cfqueryparam cfsqltype="cf_sql_integer" value="20#application.cfy#">
AND f.fund = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CBFund#">
<cfif not ListFind(variables.listOfVariousFunds,cbFund)>
and c.fiscal_year = <cfqueryparam cfsqltype="cf_sql_integer" value="20#application.cfy#">
</cfif>
</CFQUERY>

            <CFIF NOT Results.recordcount>
                    <p align="center">We're sorry! No Results are Found</p>
            <cfelse>
                <cfoutput query="results">
                    <p class="margintop30"><strong>Here you can find detailed information relating to each of the
                        State's active funds.</strong><br/>
                            <a href="/printer_friendly/pf.cfm?cbfund=#FUND#&amp;Page=Description" target="_blank">
                    PRINTER FRIENDLY</a>
                </p>
                <p><strong>Official Fund Name:</strong>
                    <br/>#OFFICIAL_FUND_NAME#</p>

                <P><B>COMPTROLLER ASSIGNED FUND NUMBER: </B>#FUND#
                        <BR/><B>ACTIVE/INACTIVE:</B> #STATUS#
                        <BR/><strong>EFFECTIVE DATE:</strong> #dateformat(EFFECTIVE_DATE, 'm/d/yy')#
                        <BR/><strong>STATUTORY ORIGIN:</strong> #STATUTORY_ORIGIN#
            <BR /><B>ADMINISTERING AGENCY:</B> <cfif not ListFind(variables.listOfVariousFunds,cbFund)>#AGENCY_NM#<cfelse>VARIOUS</cfif>
                        <BR/><B>FUND CATEGORY:</B> #name#
                    </P>

                    <P><strong>PURPOSE OF FUND:</strong><BR/>
                    #FUND_DESCRIPTION1#
                    #FUND_DESCRIPTION2#
                    #FUND_DESCRIPTION3#
                    #FUND_DESCRIPTION4#
                    #FUND_DESCRIPTION5#
                    #FUND_DESCRIPTION6#
                    #FUND_DESCRIPTION7#
                    #FUND_DESCRIPTION8#
                    #FUND_DESCRIPTION9#
                    </P>
                </CFOUTPUT>
                    <div><strong>AGENCY NAMES WITH SPENDING AUTHORITY FROM FUND:</strong><BR/>
                    <cfquery datasource="#application.whdsn#" name="agency" cachedwithin="#CReateTimeSpan(1, 0, 0, 0)#">
                            SELECT WH.AGENCY.NAME
                            FROM (WH.AGENCY INNER JOIN WH.FUND_AGENCY ON WH.AGENCY.AGENCY = WH.FUND_AGENCY.AGENCY) INNER
                            JOIN WH.FUND ON WH.FUND_AGENCY.FUND = WH.FUND.FUND
                            where WH.FUND.FUND='#cbfund#' and WH.Fund_Agency.fiscal_year = 20#application.cfy#
                            GROUP BY WH.FUND.FUND, WH.AGENCY.NAME
                    </cfquery>
                <UL>
                <CFOUTPUT query="AGENCY">
<!---<cfif agency.name neq 'capital development board' and agency.fund neq '0543'>--->
                    <LI>#NAME#</LI>
<!---</cfif>--->
                </CFOUTPUT></UL>
                </div>
            <div class="text-center">
<!--- <a href="/fiscal-condition/#CashBalances" class="btn btn-default">View Cash Balance</a> --->
                    <button type="submit" class="btn btn-primary" href="##cfFund" value="Get Fund Balance">View Cash Balance</button>
<!---                 <a href="/Ledger/?LinkServID=90D17A44-CB6B-77A6-D4DC314B32575620#cfFund" class="btn btn-default">View Cash Balance</a> --->
                </div>
            </CFIF>

        <cfelse>

            <cfoutput QUERY="results" MAXROWS="1">
                <div id="CashBalances">
                <h2>#NAME# - #FUND# Cash Transactions</h2>
            <p class="margintop30"><strong>Here you can find detailed information relating to each of the State's
                    active funds.</strong><br/>
                    <a href="/printer_friendly/pf.cfm?cbfund=#FUND#&amp;Page=balance" target="_blank">PRINTER
                FRIENDLY</a>
            </p>
            <div class="row">
            <div class="col-xs-12 col-sm-10 col-sm-offset-1">
            <div class="detail">
                <div class="amount_type">Beginning Daily Amount:</div>
            <div class="amount">#DollarFormat(BEGIN_DAILY_AMT)#
                    <div class="mytooltip"><i class="fa fa-info-circle info-formatting"></i><span class="mytooltiptext">The amount of cash in the fund at the beginning of the business day.</span>
                    </div></div>
                    <div class="amount_type">Receipt Amount:</div>
                <div class="amount">#DollarFormat(RECEIPT_AMT)#
                    <div class="mytooltip"><i class="fa fa-info-circle info-formatting"></i><span class="mytooltiptext">The amount of deposits into the fund for the business day from various taxes and fees.</span>
                    </div></div>
                    <div class="amount_type">Transfers In:</div>
                <div class="amount">#DollarFormat(TRANS_IN_AMT)#
                    <div class="mytooltip"><i class="fa fa-info-circle info-formatting"></i><span class="mytooltiptext">The amount of monies transferred into the fund from other state funds for the business day.</span>
                    </div></div>
                    <div class="amount_type">Transfers Out:</div>
                <div class="amount">#DollarFormat(trans_out_amt)#
                    <div class="mytooltip"><i class="fa fa-info-circle info-formatting"></i><span class="mytooltiptext">The amount of monies transferred out of the fund to other state funds for the business day.</span>
                    </div></div>
                    <div class="amount_type">Net Warrants Issued:</div>
                <div class="amount">#DollarFormat(NET_WARR_ISSUED)#
                    <div class="mytooltip"><i class="fa fa-info-circle info-formatting" style=""></i><span
                            class="mytooltiptext">The amount of vouchers released from the fund for the business day.</span>
                    </div></div>
                <cfif results.FUND neq "0001">
                        <div class="amount_type">End Daily Amount:</div>
                    <div class="amount">#DollarFormat(END_DAILY_AMT)#</div>
                <cfelse>
                        <div class="amount_type">End Daily Amount:</div>
                            <div class="amount" style="color:rgba(20, 80, 137, 1);">#DollarFormat(END_DAILY_AMT)#
                    <span style="color:rgba(20, 80, 137, 1);">*</span></div>
                        <p class="well well-lg margintop30">
                        <span style="color:rgba(20, 80, 137, 1);">*</span>  Reflects operating revenue used to address obligations
                    and bill backlogs. At times, balances may rise in order to meet these pending obligations, such as
                    General State Aid, Medical, Human Services, Payrolls, Pensions, etc.</p>
                </div>
                </cfif>
                </div>
                </div>
                </div>
                </div>
            </cfoutput>
                <div class="text-center margintop">
                    <button class="btn btn-primary" name="GetFundDetails" value="Learn More About This Fund">Learn More
                        About This Fund
                    </button>
                </div>
        </cfif>
    </CFIF>
    </div>
    </div>

</cfform>
