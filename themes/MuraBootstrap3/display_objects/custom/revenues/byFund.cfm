<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css"/>
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/jquery.dataTables1.10.20.min.css" rel="stylesheet" type="text/css">
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/fixedColumns.dataTables3.3.0.min.css" rel="stylesheet" type="text/css">

<cfparam name="DisableHyperLink" default="no">
<cfparam name="OutGoingGroupBy" default="None">
<cfif isDefined("form.submitted")>
    <cfif form.FundSel eq 0 OR form.FundSel IS "Default">
        <cfset variables.FundSel = "">
    <cfelse>
        <cfset variables.FundSel = form.FundSel>
    </cfif>
    <cfif form.FundGrpSel eq 0 OR form.FundGrpSel IS "Default">
        <cfset variables.FundGrpSel = "">
    <cfelse>
        <cfset variables.FundGrpSel = form.FundGrpSel>
    </cfif>
    <cfif form.FundCatSel eq 0 OR form.FundCatSel IS "Default">
        <cfset variables.FundCatSel = "">
    <cfelse>
        <cfset variables.FundCatSel = form.FundCatSel>
    </cfif>
    <cfif form.FundTypeSel eq 0 OR form.FundTypeSel IS "Default">
        <cfset variables.FundTypeSel = "">
    <cfelse>
        <cfset variables.FundTypeSel = form.FundTypeSel>
    </cfif>
    <cfif form.GroupBy eq 0 OR form.GroupBy IS "Default" OR form.Groupby IS "None">
        <cfset variables.GroupBy = "Agcy">
    <cfelse>
        <cfset variables.GroupBy = form.GroupBy>
    </cfif>
    <cfif form.FY eq 0 OR form.FY IS "Default">
        <cfset variables.FY = "#application.CFY#">
    <cfelse>
        <cfset variables.FY = form.FY>
    </cfif>
    <cfif IsDefined("form.ShowMo") AND form.ShowMo IS "Yes">
        <cfset variables.ShowMo = "Yes">
    <cfelse>
        <cfset variables.ShowMo = "No">
    </cfif>

    <cfif IsDefined("form.AgcySel") AND TRIM(form.AgcySel) IS NOT "">
        <cfset variables.AgcySel = form.AgcySel>
    <cfelse>
        <cfset variables.AgcySel = "">
    </cfif>

    <cfif IsDefined("form.AgcyGrpSel") AND TRIM(form.AgcyGrpSel) IS NOT "">
        <cfset variables.AgcyGrpSel = form.AgcyGrpSel>
    <cfelse>
        <cfset variables.AgcyGrpSel = "">
    </cfif>

    <cfif IsDefined("form.AgcyTypeSel") AND TRIM(form.AgcyTypeSel) IS NOT "">
        <cfset variables.AgcyTypeSel = form.AgcyTypeSel>
    <cfelse>
        <cfset variables.AgcyTypeSel = "">
    </cfif>

    <cfif IsDefined("form.AgcyCatSel") AND TRIM(form.AgcyCatSel) IS NOT "">
        <cfset variables.AgcyCatSel = form.AgcyCatSel>
    <cfelse>
        <cfset variables.AgcyCatSel = "">
    </cfif>

    <cfif IsDefined("form.RevSel") AND TRIM(form.RevSel) IS NOT "">
        <cfset variables.RevSel = form.RevSel>
    <cfelse>
        <cfset variables.RevSel = "">
    </cfif>

    <cfif IsDefined("form.RevClsSel") AND TRIM(form.RevClsSel) IS NOT "">
        <cfset variables.RevClsSel = form.RevClsSel>
    <cfelse>
        <cfset variables.RevClsSel = "">
    </cfif>

    <cfif IsDefined("form.RevGrpSel") AND TRIM(form.RevGrpSel) IS NOT "">
        <cfset variables.RevGrpSel = form.RevGrpSel>
    <cfelse>
        <cfset variables.RevGrpSel = "">
    </cfif>

    <cfif IsDefined("form.RevCatSel") AND TRIM(form.RevCatSel) IS NOT "">
        <cfset variables.RevCatSel = form.RevCatSel>
    <cfelse>
        <cfset variables.RevCatSel = "">
    </cfif>

    <cfif IsDefined("form.RevTypeSel") AND TRIM(form.RevTypeSel) IS NOT "">
        <cfset variables.RevTypeSel = form.RevTypeSel>
    <cfelse>
        <cfset variables.RevTypeSel = "">
    </cfif>

    <CFSET variables.submitted = true>
    <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
    <cfelseif IsDefined("URL.FundSel") AND IsDefined("URL.FundGrpSel") AND IsDefined("URL.FundCatSel") AND IsDefined("URL.FundTypeSel") AND IsDefined("URL.GroupBy") AND IsDefined("URL.FY")>
    <cfif url.FundSel eq 0 OR TRIM(URL.FundSel) IS "Default" OR TRIM(URL.FundSel) IS "">
        <cfset variables.FundSel = "">
    <cfelse>
        <cfset variables.FundSel = TRIM(URLDecode(url.FundSel, 'utf-8'))>
    </cfif>

    <cfif url.FundGrpSel eq 0 OR TRIM(URL.FundGrpSel) IS "Default" OR TRIM(URL.FundGrpSel) IS "">
        <cfset variables.FundGrpSel = "">
    <cfelse>
        <cfset variables.FundGrpSel = TRIM(URLDecode(url.FundGrpSel, 'utf-8'))>
    </cfif>
    <cfif url.FundCatSel eq 0 OR TRIM(URL.FundCatSel) IS "Default" OR TRIM(URL.FundCatSel) IS "">
        <cfset variables.FundCatSel = "">
    <cfelse>
        <cfset variables.FundCatSel = TRIM(URLDecode(url.FundCatSel, 'utf-8'))>
    </cfif>

    <cfif url.FundTypeSel eq 0 OR TRIM(URL.FundTypeSel) IS "Default" OR TRIM(URL.FundTypeSel) IS "">
        <cfset variables.FundTypeSel = "">
    <cfelse>
        <cfset variables.FundTypeSel = TRIM(URLDecode(url.FundTypeSel, 'utf-8'))>
    </cfif>

    <cfif url.GroupBy eq 0 OR TRIM(URL.GroupBy) IS "Default" OR URL.Groupby IS "None" OR TRIM(URL.GroupBy) IS "">
        <cfset variables.GroupBy = "Fund">
    <cfelse>
        <cfset variables.GroupBy = TRIM(URLDecode(url.GroupBy, 'utf-8'))>
    </cfif>

    <cfif url.FY eq 0 OR TRIM(URL.FY) IS "Default" OR TRIM(URL.FY) IS "">
        <cfset variables.FY = "16">
    <cfelse>
        <cfset variables.FY = TRIM(URLDecode(url.FY, 'utf-8'))>
    </cfif>
    <cfif IsDefined("url.ShowMo") AND TRIM(URL.ShowMo) IS "Yes">
        <cfset variables.ShowMo = "Yes">
    <cfelse>
        <cfset variables.ShowMo = "No">
    </cfif>

<!--- Handle Inline report link submit --->
    <cfif IsDefined("url.AgcySel") AND TRIM(url.AgcySel) IS NOT "" AND TRIM(url.AgcySel) IS NOT "Default">
        <cfset variables.AgcySel = URL.AgcySel>
    <cfelse>
        <cfset variables.AgcySel = "">
    </cfif>

    <cfif IsDefined("url.AgcyGrpSel") AND TRIM(url.AgcyGrpSel) IS NOT "" AND TRIM(url.AgcyGrpSel) IS NOT "Default">
        <cfset variables.AgcyGrpSel = URL.AgcyGrpSel>
    <cfelse>
        <cfset variables.AgcyGrpSel = "">
    </cfif>

    <cfif IsDefined("url.AgcyTypeSel") AND TRIM(url.AgcyTypeSel) IS NOT "" AND TRIM(url.AgcyTypeSel) IS NOT "Default">
        <cfset variables.AgcyTypeSel = TRIM(URLDecode(URL.AgcyTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcyTypeSel = "">
    </cfif>

    <cfif IsDefined("url.AgcyCatSel") AND TRIM(url.AgcyCatSel) IS NOT "" AND TRIM(url.AgcyCatSel) IS NOT "Default">
        <cfset variables.AgcyCatSel = URL.AgcyCatSel>
    <cfelse>
        <cfset variables.AgcyCatSel = "">
    </cfif>

    <cfif IsDefined("url.RevSel") AND TRIM(url.RevSel) IS NOT "" AND TRIM(url.RevSel) IS NOT "Default">
        <cfset variables.RevSel = URL.RevSel>
    <cfelse>
        <cfset variables.RevSel = "">
    </cfif>

    <cfif IsDefined("url.RevClsSel") AND TRIM(url.RevClsSel) IS NOT "" AND TRIM(url.RevClsSel) IS NOT "Default">
        <cfset variables.RevClsSel = URL.RevClsSel>
    <cfelse>
        <cfset variables.RevClsSel = "">
    </cfif>

    <cfif IsDefined("url.RevCatSel") AND TRIM(url.RevCatSel) IS NOT "" AND TRIM(url.RevCatSel) IS NOT "Default">
        <cfset variables.RevCatSel = URL.RevCatSel>
    <cfelse>
        <cfset variables.RevCatSel = "">
    </cfif>

    <cfif IsDefined("url.RevGrpSel") AND TRIM(url.RevGrpSel) IS NOT "" AND TRIM(url.RevGrpSel) IS NOT "Default">
        <cfset variables.RevGrpSel = URL.RevGrpSel>
    <cfelse>
        <cfset variables.RevGrpSel = "">
    </cfif>

    <cfif IsDefined("url.RevTypeSel") AND TRIM(url.RevTypeSel) IS NOT "" AND TRIM(url.RevTypeSel) IS NOT "Default">
        <cfset variables.RevTypeSel = URL.RevTypeSel>
    <cfelse>
        <cfset variables.RevTypeSel = "">
    </cfif>

    <CFSET form.submitted = true>
    <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
    <CFIF IsDefined("URL.PrintAsPDF")>
        <CFSET form.PrintAsPDF = true>
    </CFIF>

<cfelse>
    <CFSET variables.FundSel = "">
    <CFSET variables.FundGrpSel = "">
    <CFSET variables.FundCatSel = "">
    <CFSET variables.FundTypeSel = "">
    <cfset variables.GroupBy = "Fund">
    <cfset variables.FY = "#application.cfy#">
    <cfset variables.ShowMo = "No">
    <CFSET variables.AgcySel = "">
    <CFSET variables.AgcyGrpSel = "">
    <CFSET variables.AgcyTypeSel = "">
    <CFSET variables.AgcyTypeSel = "">
    <CFSET variables.AgcyCatSel = "">
    <CFSET variables.RevSel = "">
    <cfset variables.RevCatSel = "">
    <CFSET variables.RevClsSel = "">
    <CFSET variables.RevGrpSel = "">
    <CFSET variables.RevTypeSel = "">
    <CFSET HideSwitch1 = "block">
    <CFSET HideSwitch2 = "none">
</cfif>

<CFIF IsDefined("form.submitted")>
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
    <CFIF ListFindNoCase("FundCat,FundGrp,FundType", variables.GroupBy) GT 0>
        <CFIF variables.FundSel is "">
            <CFSET OutGoingGroupBy = "Fund">
            <CFSET DisableHyperLink = "No">
        <CFELSE>
            <CFSET OutGoingGroupBy = "None">
            <CFSET DisableHyperLink = "Yes">
        </CFIF>
        <cfelseif ListFindNoCase("Fund,AgcyCat,AgcyGrp,AgcyType,None", variables.GroupBy) GT 0>

        <CFSET OutGoingGroupBy = "Agcy">
        <CFSET DisableHyperLink = "No">

        <cfelseif ListFindNoCase("Agcy,RevCls,RevGrp,RevType,None", variables.GroupBy) GT 0>
        <CFIF variables.RevSel is "">
            <CFSET OutGoingGroupBy = "Rev">
        <CFELSE>
            <CFSET OutGoingGroupBy = "None">
            <CFSET DisableHyperLink = "Yes">
        </CFIF>
    <cfelse>
        <CFSET OutGoingGroupBy = "None">
        <CFSET DisableHyperLink = "Yes">
    </cfif>

<!--- Create a cookie that will retain the users search results  --->
<!--- Cookie stores the selected values as a CSV string  --->
<!--- Cookie CSV position legend:
1) FundSel
2) FundGrpSel
3) FundCatSel
4) FundTypeSel
5) Group by
6) Fiscal Year
7) View Monthly Totals
9) RevCatSel
10) RevGrpSel
11) RevTypeSel
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
<!--- Revenue --->
    <CFIF TRIM(variables.RevCatSel) IS "">
        <CFSET Postion8 = "Default">
    <cfelse>
        <CFSET Postion8 = variables.RevCatSel>
    </CFIF>
    <CFIF TRIM(variables.RevSel) IS "">
        <CFSET Postion9 = "Default">
    <cfelse>
        <CFSET Postion9 = variables.RevSel>
    </CFIF>
    <CFIF TRIM(variables.RevGrpSel) IS "">
        <CFSET Postion10 = "Default">
    <cfelse>
        <CFSET Postion10 = variables.RevGrpSel>
    </CFIF>
    <CFIF TRIM(variables.RevTypeSel) IS "">
        <CFSET Postion11 = "Default">
    <cfelse>
        <CFSET Postion11 = variables.RevTypeSel>
    </CFIF>
<!--- Agency --->
    <CFIF TRIM(variables.AgcyCatSel) IS "">
        <CFSET Postion12 = "Default">
    <cfelse>
        <CFSET Postion12 = variables.AgcyCatSel>
    </CFIF>
    <CFIF TRIM(variables.AgcySel) IS "">
        <CFSET Postion13 = "Default">
    <cfelse>
        <CFSET Postion13 = variables.AgcySel>
    </CFIF>
    <CFIF TRIM(variables.AgcyGrpSel) IS "">
        <CFSET Postion14 = "Default">
    <cfelse>
        <CFSET Postion14 = variables.AgcyGrpSel>
    </CFIF>
    <CFIF TRIM(variables.AgcyTypeSel) IS "">
        <CFSET Postion15 = "Default">
    <cfelse>
        <CFSET Postion15 = variables.AgcyTypeSel>
    </CFIF>
    <CFIF TRIM(variables.RevClsSel) IS "">
        <CFSET Postion16 = "Default">
    <cfelse>
        <CFSET Postion16 = variables.RevClsSel>
    </CFIF>
    <cfcookie name="RevenuesByFund" value="#Postion1#,#Postion2#,#Postion3#,#Postion4#,#Postion5#,#Postion6#,#Postion7#,#Postion8#,#Postion9#,#Postion10#,#Postion11#,#Postion12#,#Postion13#,#Postion14#,#Postion15#,#Postion16#" expires="never">
<!--- Get Friendly Names --->
        <cfinvoke component="Queries.revenues"
                method="GetFreindlyName_Revenues_Fund"
                returnvariable="FN1">
        </cfinvoke>

    <cftry>
            <cfinvoke component="Queries.revenues"
                    method="RevenueQuery"
                    returnvariable="results"
                    Control="Fund"
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
<!--- get Funds --->
<cfinvoke component="Queries.warehouse"
        method="getFunds"
        returnvariable="FundList">
</cfinvoke>
<!--- get Fund Groups --->
<cfinvoke component="Queries.warehouse"
        method="getFundGroups"
        returnvariable="FundGrpList">
</cfinvoke>

<!--- get Fund Categories --->
<cfinvoke component="Queries.warehouse"
        method="getFundCategories"
        returnvariable="FundCatList">
</cfinvoke>
<!--- get Fund Types --->
<cfinvoke component="Queries.warehouse"
        method="getFundTypes"
        returnvariable="FundTypList">
</cfinvoke>
<!--- get Fiscal Years --->
<cfinvoke component="Queries.warehouse"
        method="getFYs"
        returnvariable="FYList">
        <cfinvokeargument name="numFYs" value="5"/>
</cfinvoke>

<CFIF IsDefined("cookie.RevenuesByFund") AND ListLen(cookie.RevenuesByFund) IS 16>
    <CFSET C1_Fund = TRIM(ListGetAt(cookie.RevenuesByFund, 1))>
    <CFSET C1_Group = TRIM(ListGetAt(cookie.RevenuesByFund, 2))>
    <CFSET C1_Category = TRIM(ListGetAt(cookie.RevenuesByFund, 3))>
    <CFSET C1_Type = TRIM(ListGetAt(cookie.RevenuesByFund, 4))>
    <CFSET C1_GroupBy = TRIM(ListGetAt(cookie.RevenuesByFund, 5))>
    <CFSET C1_FY = TRIM(ListGetAt(cookie.RevenuesByFund, 6))>
    <CFSET C1_MT = TRIM(ListGetAt(cookie.RevenuesByFund, 7))>
    <CFSET C1_RevCatSel = TRIM(ListGetAt(cookie.RevenuesByFund, 8))>
    <CFSET C1_RevSel = TRIM(ListGetAt(cookie.RevenuesByFund, 9))>
    <CFSET C1_RevGrpSel = TRIM(ListGetAt(cookie.RevenuesByFund, 10))>
    <CFSET C1_RevTypeSel = TRIM(ListGetAt(cookie.RevenuesByFund, 11))>
    <CFSET C1_AgcyCatSel = TRIM(ListGetAt(cookie.RevenuesByFund, 12))>
    <CFSET C1_AgcySel = TRIM(ListGetAt(cookie.RevenuesByFund, 13))>
    <CFSET C1_AgcyGrpSel = TRIM(ListGetAt(cookie.RevenuesByFund, 14))>
    <CFSET C1_AgcyTypeSel = TRIM(ListGetAt(cookie.RevenuesByFund, 15))>
    <CFSET C1_RevClsSel = TRIM(ListGetAt(cookie.RevenuesByFund, 16))>

        <cfinvoke component="Queries.revenues"
                method="GetFreindlyName_Revenues_Fund"
                returnvariable="FN1">
        </cfinvoke>

</CFIF>

<cfoutput>

    <div id="expense" class="revenue">

            <div class="container"
                 <cfif IsDefined('results')>style='width: 100% !important'</cfif>>
<div class="row">
    <div id="1" style="display:none;" class="col-md-4 col-md-offset-4 alert alert-info text-center">
        Gathering data, please wait...
    </div>
</div>
<div class="row">
    <div class="col-md-10 col-md-offset-1">
<!--- Default Display and Dynamic Display --->

    <CFIF NOT IsDefined("results")>
            <p>State funds are created by the General Assembly to address specific state revenues and liabilities.</p>

        <cfelseif IsDefined("cookie.RevenuesByFund") AND ListLen(cookie.RevenuesByFund) IS 16>
        <div id="4" style="display:block">
        <cfsaveContent variable="headString">
                <div class="row">
                    <div class="col-md-9 col-md-offset-3">
                    </div>
                </div>
            <div class="row">
            <div class="col-md-3 col-md-offset-3">
            <CFIF TRIM(FN1.val1) IS NOT "">
                    <p>Agency: #FN1.val1#</p>
            </CFIF>                
            <CFIF TRIM(FN1.val2) IS NOT "">
                    <p>Fund Group: #FN1.val2#</p>
            </CFIF>
            <CFIF TRIM(FN1.val3) IS NOT "">
                    <p>Fund Category: #FN1.val3#</p>
            </CFIF>
            <CFIF TRIM(FN1.val4) IS NOT "">
                    <p>Fund Type: #FN1.val4#</p>
            </CFIF>
            <CFIF TRIM(FN1.val5) IS NOT "" and TRIM(FN1.val1) IS NOT "">
                    <p>Revenues by #FN1.val5#</p>
            </CFIF>
                <p>Fiscal Year: #C1_FY#</p>

            <p><CFIF TRIM(FN1.val8) IS NOT "Default" AND TRIM(FN1.val8) IS NOT "">
                    Revenue Category: #FN1.val8#<BR/>
            </CFIF>
            <CFIF FN1.val9 IS NOT "Default" AND FN1.val9 IS NOT "">
                    Revenue: #FN1.val9#<BR/>
            </CFIF>
            <CFIF FN1.val10 IS NOT "Default" AND FN1.val10 IS NOT "">
                    Revenue Group: #FN1.val10#<BR/>
            </CFIF>
            <CFIF FN1.val11 IS NOT "Default" AND FN1.val11 IS NOT "">
                    Revenue Type: #FN1.val11#<BR/>
            </CFIF>
            <CFIF FN1.val16 IS NOT "Default" AND FN1.val16 IS NOT "">
                    Revenue Class: #FN1.val16#<BR/>
            </CFIF>
            <CFIF FN1.val12 IS NOT "Default" AND FN1.val12 IS NOT "">
                    Agency Category: #FN1.val12#<BR/>
            </CFIF>
            <CFIF FN1.val13 IS NOT "Default" AND FN1.val13 IS NOT "">
                    Agency: #FN1.val13#<BR/>
            </CFIF>
            <CFIF FN1.val14 IS NOT "Default" AND FN1.val14 IS NOT "">
                    Agency Group: #FN1.val14#<BR/>
            </CFIF>
            <CFIF FN1.val15 IS NOT "Default" AND FN1.val15 IS NOT "">
                    Agency Type: #FN1.val15#
            </CFIF></p>
            </div>
        </cfsaveContent>
        #headString#
        <div class="col-md-5 pull-left">
<!--- Display Adobe PDF Download for results --->
        <CFIF IsDefined("Results")>
                <div id="3" style="display:block">
                <p><a href="
?FundSel=#C1_Fund#&FundGrpSel=#C1_Group#&FundCatSel=#C1_Category#&FundTypeSel=#C1_Type#&GroupBy=#C1_GroupBy#&FY=#C1_FY#&ShowMo=#C1_MT#&AgcySel=#variables.AgcySel#&AgcyGrpSel=#C1_AgcyGrpSel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&RevSel=#C1_RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#C1_RevGrpSel#&RevTypeSel=#C1_RevTypeSel#&PrintAsPDF=true">
                    <img alt="PDF File" src="#$.siteconfig('themeassetpath')#/images/AdobeAcrobat.png" /></a></p>
            </div>
        </CFIF>
        </div>
        </div>
        </div>
            <div id="5" style="display:none">
                <p>State funds are created by the General Assembly to address specific state revenues and
                    liabilities.</p>
            </div>
    </CFIF>


        <div class="row">

        <cfform action="" method="get" enctype="application/x-www-form-urlencoded" preloader="no" id="searchform">
            <div id="101" style="display:#HideSwitch1#">

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Select a Fund</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select name="FundSel">
            <option value="0" selected="selected">Select a Fund</option>
            <option value="">All</option>
            <cfloop query="FundList">
                    <option value="#Fund#">#Fund# - #Name#</option>
            </cfloop>
            </select>
            </div>
            </div>

            <div class="row">
                <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                    <div class="btn-label">Group</div>
                </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
            <select name="FundGrpSel">
                <option value="0" selected="selected">Group</option>
                <option value="">All</option>
            <cfloop query="FundGrpList">
                    <option value="#group#">#group# - #Name#</option>
            </cfloop>
            </select>
            </div>
            </div>

            <div class="row">
                <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                    <div class="btn-label">Category</div>
                </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
            <select name="FundCatSel">
                <option value="0" selected="selected">Category</option>
                <option value="">All</option>
            <cfloop query="FundCatList">
                    <option value="#Category#">#Category# - #Name#</option>
            </cfloop>
            </select>
            </div>
            </div>

            <div class="row">
                <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                    <div class="btn-label">Type</div>
                </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
            <select name="FundTypeSel">
                <option value="0" selected="selected">Type</option>
                <option value="">All</option>
            <cfloop query="FundTypList">
                    <option value="#Type#">#Type# - #Name#</option>
            </cfloop>
            </select>
            </div>
            </div>

            <div class="row">
                <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                    <div class="btn-label">Group By</div>
                </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
            <select name="GroupBy">
<!--- <option value="Agcy" selected="selected">Group By</option> --->
                <option value="AgcyCat">Agency Category</option>
                <option value="AgcyCls">Agency Class</option>
                <option value="AgcyGrp">Agency Group</option>
                <option value="AgcyType">Agency Type</option>
                <option value="Fund">Fund</option>
                <option value="FundCat">Fund Category</option>
                <option value="FundGrp">Fund Group</option>
                <option value="FundType">Fund Type</option>
                <option value="Agcy" selected="selected">Group By Agency</option>
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
<!--- <option value="0" selected="selected">Fiscal Year</option> --->
            <Cfloop index="i" list="#FYList#">
                    <option value="#Right(i, 2)#"><CFIF application.cfy IS RIGHT(i, 2)>Fiscal Year</CFIF> #i#</option>
            </Cfloop>
            </select>
            </div>
            </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">View Monthly Totals</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input type="checkbox" id="checkbox_1" name="ShowMo" value="Yes"/>
                    </div>
                </div>

                <div class="text-center">
                    <button class="btn btn-primary" name="submitted" type="submit" onclick="return SwitchOn();">Submit
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
</div>
</div>
    <cfif IsDefined("results")>
        <cfset numberOfColumns = listlen(ArrayToList(Results.getColumnNames()))/>
        <CFIF NumberOfColumns GT 15>
            <cfset numberOfColumns = 15/>
        </CFIF>
        <CFIF ListFindNoCase(ArrayToList(Results.getColumnNames()), "ExpTotal") GT 0>
            <CFSET SumColumn = "ExpTotal">
            <cfelseif ListFindNoCase(ArrayToList(Results.getColumnNames()), "RevTotal") GT 0>
            <CFSET SumColumn = "RevTotal">
        <cfelse>
            <CFSET SumColumn = "RevTotal">
        </CFIF>

            <cfinvoke component="Queries.warehouse"
                    method="CalculateTotalFromQuery"
                    returnvariable="CalculatedTotal">
                    <cfinvokeargument name="IncomingQuery" value="#Results#">
                    <cfinvokeargument name="ColumnToApplyCalculation" value="#SumColumn#">
            </cfinvoke>

            <div class="show">

<!--- ******************************************************************************************** --->
<!--- ******************************************************************************************** --->
<!---                               Results below                                                  --->
<!--- ******************************************************************************************** --->
<!--- ******************************************************************************************** --->
            <CFIF IsDefined("form.PrintAsPDF")>
                <cfsaveContent variable="returnString">
                    <cfinclude template="outputs/Fund1.cfm">
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
                    <div id="2" style="width: 98%; margin: 0px auto;display:block">
                    <cfinclude template="outputs/Fund1.cfm">
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
    <CFIF Not IsDefined("results") AND IsDefined("cookie.RevenuesByFund") AND ListLen(cookie.RevenuesByFund) IS 16>
            <a href="?FundSel=#C1_Fund#&FundGrpSel=#C1_Group#&FundCatSel=#C1_Category#&FundTypeSel=#C1_Type#&GroupBy=#C1_GroupBy#&FY=#C1_FY#&ShowMo=#C1_MT#">
        <div class="row">
        <div class="col-sm-offset-1 col-sm-10">
        <div class="lastsearch">
            <p>Last Search</p>
        <ul>
            <CFIF C1_Fund IS NOT "Default">
                    <li>Agency: #FN1.val1#</li>
            </CFIF>
            <CFIF C1_Group IS NOT "Default">
                    <li>Group: #FN1.val2#</li>
            </cfif>
            <CFIF C1_Category IS NOT "Default">
                    <li>Category: #FN1.val3#</li>
            </CFIF>
            <CFIF C1_Type IS NOT "Default">
                    <li>Type: #FN1.val4#</li>
            </CFIF>
            <CFIF C1_GroupBy IS NOT "Default">
                    <li>Group by: #FN1.val5#</li>
            </CFIF>
            <CFIF C1_FY IS NOT "Default">
                    <li>Fiscal Year: #FN1.val6#</li>
            </CFIF>
            <CFIF C1_MT IS NOT "Default">
                    <li>View Monthly Totals: #FN1.val7#</li>
            </CFIF>
            <CFIF C1_RevCatSel IS NOT "Default" AND C1_RevCatSel IS NOT "">
                    <li>Revenue Category: #FN1.val8#</li>
            </CFIF>
            <CFIF C1_RevSel IS NOT "Default" AND C1_RevSel IS NOT "">
                    <li>Revenue: #FN1.val9#</li>
            </CFIF>
            <CFIF C1_RevGrpSel IS NOT "Default" AND C1_RevGrpSel IS NOT "">
                    <li>Revenue Group: #FN1.val10#</li>
            </CFIF>
            <CFIF C1_RevTypeSel IS NOT "Default" AND C1_RevTypeSel IS NOT "">
                    <li>Revenue Type: #FN1.val11#</li>
            </CFIF>
            <CFIF C1_RevClsSel IS NOT "Default" AND C1_RevClsSel IS NOT "">
                    <li>Revenue Class: #FN1.val16#</li>
            </CFIF>
            <CFIF C1_AgcyCatSel IS NOT "Default" AND C1_AgcyCatSel IS NOT "">
                    <li>Agency Category: #FN1.val12#</li>
            </CFIF>
            <CFIF C1_AgcySel IS NOT "Default" AND C1_AgcySel IS NOT "">
                    <li>Agency: #FN1.val13#</li>
            </CFIF>
            <CFIF C1_AgcyGrpSel IS NOT "Default" AND C1_AgcyGrpSel IS NOT "">
                    <li>Agency Group: #FN1.val14#</li>
            </CFIF>
            <CFIF TRIM(C1_AgcyTypeSel) IS NOT "Default" AND TRIM(C1_AgcyTypeSel) IS NOT "">
                    <li>Agency Type: #FN1.val15#</li>
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

<script>
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
        $(function() {
        e3.delay(2000).fadeOut(0);
      });
      }
      function SwitchOff() {
        $(".container[style]").removeAttr("style")
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
        $(function() {
          e3.delay(2000).fadeOut(0);
          });
      };

    //-->

    </script>