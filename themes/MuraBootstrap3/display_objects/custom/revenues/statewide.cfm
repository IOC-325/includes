<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css"/>
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/jquery.dataTables1.10.20.min.css" rel="stylesheet" type="text/css">
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/fixedColumns.dataTables3.3.0.min.css" rel="stylesheet" type="text/css">
<!---<link href="/comptroller/includes/themes/MuraBootstrap3/assets/datatable/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">--->

<cfparam name="DisableHyperLink" default="no">
<cfparam name="OutGoingGroupBy" default="None">
<CFPARAM NAME="variables.ShowMo" DEFAULT="Yes">

<CFIF IsDefined("form.GroupBy")>
    <cfif form.GroupBy eq 0>
        <cfset variables.GroupBy = "Fund">
    <cfelse>
        <cfset variables.GroupBy = form.GroupBy>
    </cfif>
    <cfif form.FY eq 0>
        <cfset variables.FY = "#application.CFY#">
    <cfelse>
        <cfset variables.FY = form.FY>
    </cfif>
    <cfif IsDefined("form.MONTHLYTOTALS")>
        <cfset variables.ShowMo = "Yes">
    <cfelse>
        <cfset variables.ShowMo = "No">
    </cfif>

<!--- Handle Inline report link submit --->
    <cfif IsDefined("form.AgcySel") AND TRIM(form.AgcySel) IS NOT "">
        <cfset variables.AgcySel = TRIM(URLDecode(form.AgcySel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcySel = "">
    </cfif>

    <cfif IsDefined("form.AgcyGrpSel") AND TRIM(form.AgcyGrpSel) IS NOT "">
        <cfset variables.AgcyGrpSel = TRIM(URLDecode(form.AgcyGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcyGrpSel = "">
    </cfif>

    <cfif IsDefined("form.AgcyTypeSel") AND TRIM(form.AgcyTypeSel) IS NOT "">
        <cfset variables.AgcyTypeSel = TRIM(URLDecode(form.AgcyTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcyTypeSel = "">
    </cfif>

    <cfif IsDefined("form.AgcyCatSel") AND TRIM(form.AgcyCatSel) IS NOT "">
        <cfset variables.AgcyCatSel = TRIM(URLDecode(form.AgcyCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcyCatSel = "">
    </cfif>

    <cfif IsDefined("form.RevSel") AND TRIM(form.RevSel) IS NOT "">
        <cfset variables.RevSel = TRIM(URLDecode(form.RevSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevSel = "">
    </cfif>

    <cfif IsDefined("form.RevClsSel") AND TRIM(form.RevClsSel) IS NOT "">
        <cfset variables.RevClsSel = TRIM(URLDecode(form.RevClsSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevClsSel = "">
    </cfif>

    <cfif IsDefined("form.RevCatSel") AND TRIM(form.RevCatSel) IS NOT "">
        <cfset variables.RevCatSel = TRIM(URLDecode(form.RevCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevCatSel = "">
    </cfif>

    <cfif IsDefined("form.RevGrpSel") AND TRIM(form.RevGrpSel) IS NOT "">
        <cfset variables.RevGrpSel = TRIM(URLDecode(form.RevGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevGrpSel = "">
    </cfif>

    <cfif IsDefined("form.RevTypeSel") AND TRIM(form.RevTypeSel) IS NOT "">
        <cfset variables.RevTypeSel = TRIM(URLDecode(form.RevTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevTypeSel = "">
    </cfif>
    <cfif IsDefined("form.FundSel") AND TRIM(form.FundSel) IS NOT "">
        <cfset variables.FundSel = TRIM(URLDecode(form.FundSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundSel = "">
    </cfif>

    <cfif IsDefined("form.FundClsSel") AND TRIM(form.FundClsSel) IS NOT "">
        <cfset variables.FundClsSel = TRIM(URLDecode(form.FundClsSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundClsSel = "">
    </cfif>

    <cfif IsDefined("form.FundGrpSel") AND TRIM(form.FundGrpSel) IS NOT "">
        <cfset variables.FundGrpSel = TRIM(URLDecode(form.FundGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundGrpSel = "">
    </cfif>

    <cfif IsDefined("form.FundTypeSel") AND TRIM(form.FundTypeSel) IS NOT "">
        <cfset variables.FundTypeSel = TRIM(URLDecode(form.FundTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundTypeSel = "">
    </cfif>

    <cfif IsDefined("form.FundCatSel") AND TRIM(form.FundCatSel) IS NOT "">
        <cfset variables.FundCatSel = TRIM(URLDecode(form.FundCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundCatSel = "">
    </cfif>

    <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
    <cfelseif IsDefined("URL.GroupBy") AND IsDefined("URL.FY")>
    <cfif URL.GroupBy eq 0 OR URL.GroupBy IS "Default">
        <cfset variables.GroupBy = "Fund">
    <cfelse>
        <cfset variables.GroupBy = TRIM(URLDecode(url.GroupBy, 'utf-8'))>
    </CFIF>
    <cfif URL.FY eq 0>
        <cfset variables.FY = "#application.cfy#">
    <cfelse>
        <cfset variables.FY = TRIM(URLDecode(URL.FY, 'utf-8'))>
    </cfif>
    <cfif IsDefined("URL.MonthlyTotals") AND TRIM(URL.MonthlyTotals) IS "Yes">
        <cfset variables.ShowMo = "Yes">
    <cfelse>
        <cfset variables.ShowMo = "No">
    </cfif>

    <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
    <CFIF IsDefined("URL.PrintAsPDF")>
        <CFSET form.PrintAsPDF = true>
    </CFIF>

    <!--- Handle Inline report link submit --->
    <cfif IsDefined("url.AgcySel") AND TRIM(url.AgcySel) IS NOT "" AND TRIM(url.AgcySel) IS NOT "Default">
        <cfset variables.AgcySel = TRIM(URLDecode(URL.AgcySel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcySel = "">
    </cfif>

    <cfif IsDefined("url.AgcyGrpSel") AND TRIM(url.AgcyGrpSel) IS NOT "" AND TRIM(url.AgcyGrpSel) IS NOT "Default">
        <cfset variables.AgcyGrpSel = TRIM(URLDecode(URL.AgcyGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcyGrpSel = "">
    </cfif>

    <cfif IsDefined("url.AgcyTypeSel") AND TRIM(url.AgcyTypeSel) IS NOT "" AND TRIM(url.AgcyTypeSel) IS NOT "Default">
        <cfset variables.AgcyTypeSel = TRIM(URLDecode(URL.AgcyTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcyTypeSel = "">
    </cfif>

    <cfif IsDefined("url.AgcyCatSel") AND TRIM(url.AgcyCatSel) IS NOT "" AND TRIM(url.AgcyCatSel) IS NOT "Default">
        <cfset variables.AgcyCatSel = TRIM(URLDecode(URL.AgcyCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcyCatSel = "">
    </cfif>

    <cfif IsDefined("url.RevSel") AND TRIM(url.RevSel) IS NOT "" AND TRIM(url.RevSel) IS NOT "Default">
        <cfset variables.RevSel = TRIM(URLDecode(URL.RevSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevSel = "">
    </cfif>

    <cfif IsDefined("url.RevClsSel") AND TRIM(url.RevClsSel) IS NOT "" AND TRIM(url.RevClsSel) IS NOT "Default">
        <cfset variables.RevClsSel = TRIM(URLDecode(URL.RevClsSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevClsSel = "">
    </cfif>

    <cfif IsDefined("url.RevCatSel") AND TRIM(url.RevCatSel) IS NOT "" AND TRIM(url.RevCatSel) IS NOT "Default">
        <cfset variables.RevCatSel = TRIM(URLDecode(URL.RevCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevCatSel = "">
    </cfif>

    <cfif IsDefined("url.RevGrpSel") AND TRIM(url.RevGrpSel) IS NOT "" AND TRIM(url.RevGrpSel) IS NOT "Default">
        <cfset variables.RevGrpSel = TRIM(URLDecode(URL.RevGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevGrpSel = "">
    </cfif>

    <cfif IsDefined("url.RevTypeSel") AND TRIM(url.RevTypeSel) IS NOT "" AND TRIM(url.RevTypeSel) IS NOT "Default">
        <cfset variables.RevTypeSel = TRIM(URLDecode(URL.RevTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevTypeSel = "">
    </cfif>
    <cfif IsDefined("url.FundSel") AND TRIM(url.FundSel) IS NOT "" AND TRIM(url.FundSel) IS NOT "Default">
        <cfset variables.FundSel = TRIM(URLDecode(URL.FundSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundSel = "">
    </cfif>

    <cfif IsDefined("url.FundClsSel") AND TRIM(url.FundClsSel) IS NOT "" AND TRIM(url.FundClsSel) IS NOT "Default">
        <cfset variables.FundClsSel = TRIM(URLDecode(URL.FundClsSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundClsSel = "">
    </cfif>

    <cfif IsDefined("url.FundGrpSel") AND TRIM(url.FundGrpSel) IS NOT "" AND TRIM(url.FundGrpSel) IS NOT "Default">
        <cfset variables.FundGrpSel = TRIM(URLDecode(URL.FundGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundGrpSel = "">
    </cfif>

    <cfif IsDefined("url.FundTypeSel") AND TRIM(url.FundTypeSel) IS NOT "" AND TRIM(url.FundTypeSel) IS NOT "Default">
        <cfset variables.FundTypeSel = TRIM(URLDecode(URL.FundTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundTypeSel = "">
    </cfif>

    <cfif IsDefined("url.FundCatSel") AND TRIM(url.FundCatSel) IS NOT "" AND TRIM(url.FundCatSel) IS NOT "Default">
        <cfset variables.FundCatSel = TRIM(URLDecode(URL.FundCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundCatSel = "">
    </cfif>

    <CFSET form.Submitted = true>

<cfelse>
    <cfset variables.GroupBy = "Fund">
    <cfset variables.FY = "20#application.CFY#">
    <cfset variables.ShowMo = "No">
    <CFSET HideSwitch1 = "block">
    <CFSET HideSwitch2 = "none">

    <CFSET variables.AgcySel = "">
    <CFSET variables.AgcyGrpSel = "">
    <CFSET variables.AgcyCatSel = "">
    <CFSET variables.AgcyTypeSel = "">
    <CFSET variables.FundSel = "">
    <CFSET variables.FundGrpSel = "">
    <CFSET variables.FundTypeSel = "">
    <CFSET variables.FundCatSel = "">
    <CFSET variables.RevSel = "">
    <CFSET variables.RevClsSel = "">
    <CFSET variables.RevCatSel = "">
    <CFSET variables.RevGrpSel = "">
    <CFSET variables.RevTypeSel = "">

</CFIF>
<cfif isDefined("form.submitted")>
    <!--- Concatenate the selector name from GroupBy + sel.  This will be an input the report query.  This logic is used to drive the  sub reports links within the report results.   --->
    <CFSET ThisName = "#TRIM(variables.GroupBy)#Sel">
    <!--- Get Groupby Friendly Name --->
        <cfinvoke component="Queries.autosuggest"
                method="GetFullListGroupBy"
                returnvariable="qRG">
                <cfinvokeargument name="IncomingGroupBy" value="#variables.GroupBy#">
        </cfinvoke>
    <CFIF qRG.recordcount GT 0>
        <CFSET GroupByFN = qRG.Name>
    <cfelse>
        <CFSET GroupByFN = "Name">
    </CFIF>
    <!--- Reset the GroupBy name --->
    <cfif ListFindNoCase("FundCat,FundGrp,FundType", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Fund">
        <CFSET DisableHyperLink = "No">
        <cfelseif ListFindNoCase("Fund", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Agcy">
        <CFSET DisableHyperLink = "No">
        <cfelseif ListFindNoCase("AgcyCat,AgcyGrp,AgcyType,None", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Agcy">
        <CFSET DisableHyperLink = "No">
        <cfelseif ListFindNoCase("Agcy,RevCls,RevGrp,RevType,None", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Rev">
        <CFSET DisableHyperLink = "No">
        <cfelseif ListFindNoCase("Rev", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "None">
        <CFSET DisableHyperLink = "Yes">
    <cfelse>
        <CFSET OutGoingGroupBy = ThisName>
        <CFSET DisableHyperLink = "No">
    </cfif>

<!--- Create a cookie that retains the users form submitted values  --->
<!--- Because there is a limit to the number of cookies per domain each page that requires it gets 1 cookie per page. --->
<!---  The cookie stores the selected values as a CSV string   --->
<!--- Cookie CSV position legend:
  1) Fund
  2) Group
  3) Category
  4) Type
  5) Group by
  6) Fiscal Year
  7) View Monthly Totals
   --->

    <CFIF TRIM(variables.FundSel) IS "">
        <CFSET Postion1 = "Default">
    <cfelse>
        <CFSET Postion1 = variables.FundSel>
    </CFIF>
    <CFIF TRIM(variables.FundGrpSel) IS "">
        <CFSET Postion2 = "Default">
    <cfelse>
        <CFSET Postion2 = variables.FundGrpSel>
    </CFIF>
    <CFIF TRIM(variables.FundCatSel) IS "">
        <CFSET Postion3 = "Default">
    <cfelse>
        <CFSET Postion3 = variables.FundCatSel>
    </CFIF>
    <CFIF TRIM(variables.FundTypeSel) IS "">
        <CFSET Postion4 = "Default">
    <cfelse>
        <CFSET Postion4 = variables.FundTypeSel>
    </CFIF>
    <CFIF TRIM(variables.GroupBy) IS "">
        <CFSET Postion5 = "Default">
    <cfelse>
        <CFSET Postion5 = variables.GroupBy>
    </CFIF>
    <CFIF TRIM(variables.FY) IS "">
        <CFSET Postion6 = "Default">
    <cfelse>
        <CFSET Postion6 = variables.FY>
    </CFIF>
    <CFIF TRIM(variables.ShowMo) IS "">
        <CFSET Postion7 = "No">
    <cfelse>
        <CFSET Postion7 = variables.ShowMo>
    </CFIF>
    <CFIF TRIM(variables.AgcyCatSel) IS "">
        <CFSET Postion8 = "Default">
    <cfelse>
        <CFSET Postion8 = variables.AgcyCatSel>
    </CFIF>

    <CFIF TRIM(variables.AgcySel) IS "">
        <CFSET Postion9 = "Default">
    <cfelse>
        <CFSET Postion9 = variables.AgcySel>
    </CFIF>

    <CFIF TRIM(variables.AgcyGrpSel) IS "">
        <CFSET Postion10 = "Default">
    <cfelse>
        <CFSET Postion10 = variables.AgcyGrpSel>
    </CFIF>

    <CFIF TRIM(variables.AgcyTypeSel) IS "">
        <CFSET Postion11 = "Default">
    <cfelse>
        <CFSET Postion11 = variables.AgcyTypeSel>
    </CFIF>
<!--- Revenue --->
    <CFIF TRIM(variables.RevCatSel) IS "">
        <CFSET Postion12 = "Default">
    <cfelse>
        <CFSET Postion12 = variables.RevCatSel>
    </CFIF>
    <CFIF TRIM(variables.RevSel) IS "">
        <CFSET Postion13 = "Default">
    <cfelse>
        <CFSET Postion13 = variables.RevSel>
    </CFIF>
    <CFIF TRIM(variables.RevGrpSel) IS "">
        <CFSET Postion14 = "Default">
    <cfelse>
        <CFSET Postion14 = variables.RevGrpSel>
    </CFIF>
    <CFIF TRIM(variables.RevTypeSel) IS "">
        <CFSET Postion15 = "Default">
    <cfelse>
        <CFSET Postion15 = variables.RevTypeSel>
    </CFIF>
    <CFIF TRIM(variables.RevClsSel) IS "">
        <CFSET Postion16 = "Default">
    <cfelse>
        <CFSET Postion16 = variables.RevClsSel>
    </CFIF>

    <cfcookie name="RevenuesStatewide" value="#Postion1#,#Postion2#,#Postion3#,#Postion4#,#Postion5#,#Postion6#,#Postion7#,#Postion8#,#Postion9#,#Postion10#,#Postion11#,#Postion12#,#Postion13#,#Postion14#,#Postion15#,#Postion16#" expires="never">
<!--- CFTRY is used to prevent displaying database errors from incoming URL.GroupBy variables that have been manipulated in the URL string.  The revenues query should be rewritten to prevent this from happening.   --->

    <cftry>

            <cfinvoke component="Queries.revenues"
                    method="RevenueQuery"
                    returnvariable="results"
                    Control="State"
                    GroupBy="#variables.GroupBy#"
                    Max="20"
                    FY="#variables.FY#"
                    ShowMo="#variables.ShowMo#"
                    FundSel="#variables.FundSel#"
                    FundGrpSel="#variables.FundGrpSel#"
                    FundTypeSel="#variables.FundTypeSel#"
                    FundCatSel="#variables.FundCatSel#"
                    AgcySel="#variables.AgcySel#"
                    AgcyGrpSel="#variables.AgcyGrpSel#"
                    AgcyTypeSel="#variables.AgcyTypeSel#"
                    AgcyCatSel="#variables.AgcyCatSel#"
                    RevSel="#variables.RevSel#"
                    RevClsSel="#variables.RevClsSel#"
                    RevGrpSel="#variables.RevGrpSel#"
                    RevTypeSel="#variables.RevTypeSel#"
                    SortName="NO">
            </cfinvoke>
        <cfset ColumnNames = ArrayToList(Results.getColumnNames())/>
        <cfcatch type="any">
            <CFSET ColumnNames = "Error">
<!--- Catch any errors whereas the incoming input values caused a DB2 crash --->
            <CFSET Error = "1">
        </cfcatch>
    </cftry>

</cfif>

<!--- get Fiscal Years --->
<cfinvoke component="Queries.warehouse"
        method="getFYs"
        returnvariable="FYList">
        <cfinvokeargument name="numFYs" value="5"/>
</cfinvoke>

<CFIF IsDefined("cookie.RevenuesStatewide") AND ListLen(cookie.RevenuesStatewide) IS 16>
<!--- Get the clients cookie values and set them as variables  --->
    <CFSET C1_Fund = ListGetAt(cookie.RevenuesStatewide, 1)>
    <CFSET C1_Group = ListGetAt(cookie.RevenuesStatewide, 2)>
    <CFSET C1_Category = ListGetAt(cookie.RevenuesStatewide, 3)>
    <CFSET C1_Type = ListGetAt(cookie.RevenuesStatewide, 4)>
    <CFSET C1_GroupBy = ListGetAt(cookie.RevenuesStatewide, 5)>
    <CFSET C1_FY = ListGetAt(cookie.RevenuesStatewide, 6)>
    <CFSET C1_MT = ListGetAt(cookie.RevenuesStatewide, 7)>
    <CFSET C1_AgcyCatSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesStatewide, 8), 'utf-8'))>
    <CFSET C1_AgcySel = TRIM(URLDecode(ListGetAt(cookie.RevenuesStatewide, 9), 'utf-8'))>
    <CFSET C1_AgcyGrpSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesStatewide, 10), 'utf-8'))>
    <CFSET C1_AgcyTypeSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesStatewide, 11), 'utf-8'))>
    <CFSET C1_RevCatSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesStatewide, 12), 'utf-8'))>
    <CFSET C1_RevSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesStatewide, 13), 'utf-8'))>
    <CFSET C1_RevGrpSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesStatewide, 14), 'utf-8'))>
    <CFSET C1_RevTypeSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesStatewide, 15), 'utf-8'))>
    <CFSET C1_RevClsSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesStatewide, 16), 'utf-8'))>
    <!--- Get Friend Names from the cookie values. --->
    <cfinvoke component="Queries.revenues"
            method="GetFreindlyName_Revenue_Statewide"
            returnvariable="FN1">
    </cfinvoke>
</CFIF>

<cfoutput>
    <div id="expense" class="revenue">
            <div class="container"
                 <cfif IsDefined('results')>style='width: 100% !important'</cfif>>

    <div class="row">
        <div id="1" style="display:none" class="col-md-4 col-md-offset-4 alert alert-info text-center">
            Gathering data, please wait...
        </div>
    </div>
<div class="row">

<div class="col-md-10 col-md-offset-1">

    <CFIF NOT IsDefined("results")>
            <p>State funds are created by the General Assembly to address specific state revenues and liabilities.</p>
        <cfelseif IsDefined("cookie.RevenuesStatewide") AND ListLen(cookie.RevenuesStatewide) IS 16>

            <div id="4" style="display:block">
            <cfsaveContent variable="headString">
                <div class="row">
                <div class="col-md-9 col-md-offset-3">
                <p><CFIF C1_Fund IS NOT "Default">
                        Fund Category: #FN1.val1#<BR/>
                </CFIF>
                <CFIF C1_Group IS NOT "Default">
                        Group: #FN1.val2#<BR/>
                </cfif>
                <CFIF C1_Category IS NOT "Default">
                        Category: #FN1.val3#<BR/>
                </CFIF>
                <CFIF C1_Type IS NOT "Default">
                        Type: #FN1.val4#<BR/>
                </CFIF>

                <CFIF TRIM(FN1.val8) IS NOT "Default" AND TRIM(FN1.val8) IS NOT "">
                        Agency Category: #FN1.val8#<BR/>
                </CFIF>
                <CFIF TRIM(FN1.val9) IS NOT "Default" AND TRIM(FN1.val9) IS NOT "">
                        Agency: #FN1.val9#<BR/>
                </CFIF>
                <CFIF TRIM(FN1.val10) IS NOT "Default" AND TRIM(FN1.val10) IS NOT "">
                        Agency Group: #FN1.val10#<BR/>
                </CFIF>
                <CFIF TRIM(FN1.val11) IS NOT "Default" AND TRIM(FN1.val11) IS NOT "">
                        Agency Type: #FN1.val11#<BR/>
                </CFIF>
                <CFIF FN1.val12 IS NOT "Default" AND FN1.val12 IS NOT "">
                        Revenue Category: #FN1.val12#<BR/>
                </CFIF>
                <CFIF FN1.val13 IS NOT "Default" AND FN1.val13 IS NOT "">
                        Revenue: #FN1.val13#<BR/>
                </CFIF>
                <CFIF FN1.val14 IS NOT "Default" AND FN1.val14 IS NOT "">
                        Revenue Group: #FN1.val14#<BR/>
                </CFIF>
                <CFIF FN1.val15 IS NOT "Default" AND FN1.val15 IS NOT "">
                        Revenue Type: #FN1.val15#<BR/>
                </CFIF>
                <CFIF FN1.val16 IS NOT "Default" AND FN1.val16 IS NOT "">
                        Revenue Class: #FN1.val16#
                </CFIF></p>

                </div>
                </div>
                <div class="row">
                <div class="col-md-3 col-md-offset-3">
                <p>Fiscal Year:
                <CFIF C1_FY LTE 60>20#C1_FY#
                <cfelse>19#C1_FY#</CFIF></p>
            </div>

            </cfsaveContent>
            #headString#
            <div class="col-md-5 pull-left">
<!--- Display Adobe PDF Download for results --->
            <CFIF IsDefined("Results")>
                    <div id="3" style="display:block">
                    <p>
                            <a href="?GroupBy=#C1_GroupBy#&FY=#C1_FY#&monthlyTotals=#variables.ShowMo#&FundSel=#C1_Fund #&FundGrpSel=#C1_Group#&FundTypeSel=#C1_Type#&FundCatSel=#C1_Category#&RevSel=#C1_RevSel#&RevClsSel=#C1_RevClsSel#&RevTypeSel=#C1_RevTypeSel#&RevCatSel=#C1_RevCatSel#&RevGrpSel=#C1_RevGrpSel#&AgcySel=#C1_AgcySel#&AgcyGrpSel=#C1_AgcyGrpSel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&monthlyTotals=#C1_MT#&PrintAsPDF=true">
                        <img alt="PDF File" src="#$.siteconfig('themeassetpath')#/images/AdobeAcrobat.png" /></a></p>
                </div>
            </CFIF>
            </div>
            </div>
            <div id="5" style="display:none">
            <h1>#$.getTitle()#</h1>
            <p>State funds are created by the General Assembly to address specific state revenues and liabilities.</p>
        </div>
        </div>

    </CFIF>

        <div class="row">
        <cfform method="get" enctype="application/x-www-form-urlencoded" preloader="no" id="searchform">
            <div id="101" style="display:#HideSwitch1#">

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Group By</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
            <select name="GroupBy">
            <option value="None">None</option>
            <option value="Agcy">Agency</option>
            <option value="AgcyCat">Agency Category</option>
            <option value="AgcyGrp">Agency Group</option>
            <option value="AgcyType">Agency Type</option>
            <option value="Fund" selected="selected">Group By Fund</option>
            <option value="FundCat">Fund Category</option>
            <option value="FundGrp">Fund Group</option>
            <option value="FundType">Fund Type</option>
            <!--- <option value="Fund" selected="selected">Group By</option> ????--->
            <option value="RevCls">Revenue Class</option>
            <option value="RevGrp">Revenue Group</option>
            <option value="Rev">Revenue Source</option>
            <option value="RevType">Revenue Type</option>
            </select>
            </div>
            </div>

            <div class="row">
                <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                    <div class="btn-label">Fiscal Year</div>
                </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
            <select name="FY">
            <Cfloop index="i" list="#FYList#">
                    <option value="#Right(i, 2)#"><CFIF application.cfy IS right(i, 2)>Fiscal Year</CFIF> #i#</option>
            </Cfloop>
            </select>
            </div>
            </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">View Monthly Totals</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input type="checkbox" id="checkbox_1" name="monthlyTotals" value="Yes"/>
                    </div>
                </div>

                <div class="text-center">
                    <button class="btn btn-primary" name="submitted" type="submit" onclick="return SwitchOn();">
                        Submit
                    </button>
                </div>

        </cfform>

        </div>
        </div>
<!--- Search Again button --->
        <div class="show margintop30">
                <div class="text-center" id="100" style="display:#HideSwitch2#">
            <a href="##" onclick="return SwitchOff();" class="btn btn-success">Search Again</a>
    </div>
    </div>
<!--- end search again --->
    </div>
    </div>
<!--- Report Results below --->

    <cfif IsDefined("results")>
        <cfset numberOfColumns = listlen(ArrayToList(Results.getColumnNames()))/>

            <cfinvoke component="Queries.warehouse"
                    method="CalculateTotalFromQuery"
                    returnvariable="CalculatedTotal">
                    <cfinvokeargument name="IncomingQuery" value="#Results#">
                    <cfinvokeargument name="ColumnToApplyCalculation" value="RevTotal">
            </cfinvoke>
            <div class="show">

<!--- ******************************************************************************************** --->
<!--- ******************************************************************************************** --->
<!---                               Results below                                                  --->
<!--- ******************************************************************************************** --->
<!--- ******************************************************************************************** --->
            <CFIF IsDefined("form.PrintAsPDF")>
                <cfsaveContent variable="returnString">
                    <cfinclude template="outputs/sw1.cfm">
                </cfsaveContent>

                <CFSET Variables.PDFContent = ReplaceNoCase(ReplaceNoCase(ReplaceNoCase(headString, "h1", "h4", "all"), "<p>", "", "all"), "<\/p>", "") & "<br/>" & returnString>
                <CFIF ShowMo is "Yes">
                    <CFSET pageOri = "landscape">
                <cfelse>
                    <CFSET pageOri = "portrait">
                </cfif>

                    <cfinvoke component="Queries.GeneratePdf"
                            method="generatePdfFile"
                            returnvariable="pdfile">
                            <cfinvokeargument name="data" value="#Variables.PDFContent#">
                            <cfinvokeargument name="classId" value="##example">
                            <cfinvokeargument name="cffFilePath" value="/ledger/includes/themes/TheLedger/css/style.css">
                            <cfinvokeargument name="pageOri" value="#pageOri#">
                            <cfinvokeargument name="colLen" value="#ListLen(Results.ColumnList)#">
                    </cfinvoke>
                #Variables.PDFContent#

            <cfelse>

                    <div id="2" style="width: 98%; margin: 0 auto; display:block; overflow: auto;">
                    <cfinclude template="outputs/sw1.cfm">
                    </div>
            </CFIF>


            </div>
<!--- ******************************************************************************************** --->
<!--- ******************************************************************************************** --->
<!---                                     End report results                                       --->
<!--- ******************************************************************************************** --->
<!--- ******************************************************************************************** --->

    </cfif>
    <CFIF IsDefined("Error") AND Error IS 1>
<!--- Display Query Input error  --->
            <div class="col-md-12" align="center">
<!---   <img alt="" src="#$.siteconfig('themeassetpath')#/images/CW_AlertIcon.jpg" /> --->
                <BR/><h1>No records found. Please use different search criteria.</h1>
            </div>
    </CFIF>

<!--- Display Last search results if cookie exists --->
    <CFIF Not IsDefined("results") AND IsDefined("cookie.RevenuesStatewide") AND ListLen(cookie.RevenuesStatewide) IS 16>
            <a href="?GroupBy=#C1_GroupBy#&FY=#C1_FY#&monthlyTotals=#variables.ShowMo#&FundSel=#C1_Fund #&FundGrpSel=#C1_Group#&FundTypeSel=#C1_Type#&FundCatSel=#C1_Category#&RevSel=#C1_RevSel#&RevClsSel=#C1_RevClsSel#&RevTypeSel=#C1_RevTypeSel#&RevCatSel=#C1_RevCatSel#&RevGrpSel=#C1_RevGrpSel#&AgcySel=#C1_AgcySel#&AgcyGrpSel=#C1_AgcyGrpSel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&monthlyTotals=#C1_MT#">
        <div class="row">
        <div class="col-sm-offset-1 col-sm-10">
        <div class="lastsearch">
            <p>Last Search</p>

        <ul>
        <li>Revenues by: #FN1.val5#</li>
        <li>Fiscal Year: #FN1.val6#</li>
            <CFIF FN1.val1 IS NOT "Default" AND TRIM(FN1.val1) IS NOT "">
                    <li>Fund Category: #FN1.val1#</li>
            </CFIF>
            <CFIF FN1.val2 IS NOT "Default" AND TRIM(FN1.val2) IS NOT "">
                    <li>Group: #FN1.val2#</li>
            </cfif>
            <CFIF FN1.val3 IS NOT "Default" AND TRIM(FN1.val3) IS NOT "">
                    <li>Category: #FN1.val3#</li>
            </CFIF>
            <CFIF FN1.val4 IS NOT "Default" AND TRIM(FN1.val4) IS NOT "">
                    <li>Type: #FN1.val4#</li>
            </CFIF>

            <CFIF TRIM(FN1.val8) IS NOT "Default" AND TRIM(FN1.val8) IS NOT "">
                    <li>Agency Category: #FN1.val8#</li>
            </CFIF>
            <CFIF TRIM(FN1.val9) IS NOT "Default" AND TRIM(FN1.val9) IS NOT "">
                    <li>Agency: #FN1.val9#</li>
            </CFIF>
            <CFIF TRIM(FN1.val10) IS NOT "Default" AND TRIM(FN1.val10) IS NOT "">
                    <li>Agency Group: #FN1.val10#</li>
            </CFIF>
            <CFIF TRIM(FN1.val11) IS NOT "Default" AND TRIM(FN1.val11) IS NOT "">
                    <li>Agency Type: #FN1.val11#</li>
            </CFIF>
            <CFIF FN1.val12 IS NOT "Default" AND FN1.val12 IS NOT "">
                    <li>Revenue Category: #FN1.val12#</li>
            </CFIF>
            <CFIF FN1.val13 IS NOT "Default" AND FN1.val13 IS NOT "">
                    <li>Revenue: #FN1.val13#</li>
            </CFIF>
            <CFIF FN1.val14 IS NOT "Default" AND FN1.val14 IS NOT "">
                    <li>Revenue Group: #FN1.val14#</li>
            </CFIF>
            <CFIF FN1.val15 IS NOT "Default" AND FN1.val15 IS NOT "">
                    <li>Revenue Type: #FN1.val15#</li>
            </CFIF>
            <CFIF FN1.val16 IS NOT "Default" AND FN1.val16 IS NOT "">
                    <li>Revenue Class: #FN1.val16#</li>
            </CFIF>
            </ul>
            </div>
            </div>
            </div>
            </a>
    </CFIF>

    </div>
    </div>
</cfoutput>

<script src="/comptroller/includes/themes/MuraBootstrap3/js/ledger/jquery.dataTables1.10.20.min.js"></script>
<script src="/comptroller/includes/themes/MuraBootstrap3/js/ledger/datatables.fixedColumns3.3.0.min.js"></script>

<script type="text/javascript">
    <!--
    /* Switch that allows search again
    ****** ID LEGEND ****************
    1 = Gathering Data DIV
    2 = Search Results DIV
    3 = Adobe Print PDF BUTTON
    4 = submitted Results Page Title DIV
    5 = Default Page Title DIV
    100 = Search Again BUTTON
    101 = Form Selectors DIV
    ********************************
    */

    function SwitchOn() {
        var e = document.getElementById(100);
        var e2 = document.getElementById(101);
        var e3 = document.getElementById(1);
        var e4 = document.getElementById(2);
        var e5 = document.getElementById(3);
        var e6 = document.getElementById(4);
        var e7 = document.getElementById(5);
        e.style.display = 'block';
        e2.style.display = 'none';
        e3.style.display = 'block';
        e4.style.display = 'none';
        e5.style.display = 'none';
        e6.style.display = 'none';
        e7.style.display = 'block';
        $(function () {
            e3.delay(2000).fadeOut(0);
        });
    }

    function SwitchOff() {
        $(".container[style]").removeAttr("style");
        var e = document.getElementById(100);
        var e2 = document.getElementById(101);
        var e3 = document.getElementById(1);
        var e4 = document.getElementById(2);
        var e5 = document.getElementById(3);
        var e6 = document.getElementById(4);
        var e7 = document.getElementById(5);
        e.style.display = 'none';
        e2.style.display = 'block';
        e3.style.display = 'none';
        e4.style.display = 'none';
        e5.style.display = 'none';
        e6.style.display = 'none';
        e7.style.display = 'block';
        $(function () {
            e3.delay(2000).fadeOut(0);
        });
    }

    //-->

</script>
