<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css"/>
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/jquery.dataTables1.10.20.min.css" rel="stylesheet" type="text/css">
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/fixedColumns.dataTables3.3.0.min.css" rel="stylesheet" type="text/css">

<cfparam name="DisableHyperLink" default="no">
<cfparam name="OutGoingGroupBy" default="None">
<cfif isDefined("form.submitted")>
    <cfif form.AgcySel eq 0 OR form.AgcySel IS NOT "Default">
        <cfset variables.AgcySel = "">
    <cfelse>
        <cfset variables.AgcySel = form.AgcySel>
    </cfif>

    <cfif form.AgcyGrpSel eq 0 OR form.AgcyGrpSel IS NOT "Default">
        <cfset variables.AgcyGrpSel = "">
    <cfelse>
        <cfset variables.AgcyGrpSel = form.AgcyGrpSel>
    </cfif>

    <cfif form.AgcyCatSel eq 0 OR form.AgcyCatSel IS NOT "Default">
        <cfset variables.AgcyCatSel = "">
    <cfelse>
        <cfset variables.AgcyCatSel = form.AgcyCatSel>
    </cfif>

    <cfif form.AgcyTypeSel eq 0 OR form.AgcyTypeSel IS NOT "Default">
        <cfset variables.AgcyTypeSel = "">
    <cfelse>
        <cfset variables.AgcyTypeSel = form.AgcyTypeSel>
    </cfif>

    <cfif form.GroupBy eq 0 OR form.GroupBy IS NOT "Default">
        <cfset variables.GroupBy = "Agcy">
    <cfelse>
        <cfset variables.GroupBy = form.GroupBy>
    </cfif>

    <cfif form.FY eq 0>
        <cfset variables.FY = "#application.cfy#">
    <cfelse>
        <cfset variables.FY = form.FY>
    </cfif>

    <cfif IsDefined("form.ShowMo") AND form.ShowMo IS "Yes">
        <cfset variables.ShowMo = "Yes">
    <cfelse>
        <cfset variables.ShowMo = "No">
    </cfif>

    <CFIF IsDefined("form.FundSel") and Form.FundSel IS NOT "Default">
        <CFSET variables.FundSel = form.FundSel>
    <cfelse>
        <CFSET variables.FundSel = "">
    </CFIF>
    <CFIF IsDefined("form.FundGrpSel") and Form.FundGrpSel IS NOT "Default">
        <CFSET variables.FundGrpSel = form.FundGrpSel>
    <cfelse>
        <CFSET variables.FundGrpSel = "">
    </CFIF>

    <CFIF IsDefined("form.FundTypeSel") and Form.FundTypeSel IS NOT "Default">
        <CFSET variables.FundTypeSel = form.FundTypeSel>
    <cfelse>
        <CFSET variables.FundTypeSel = "">
    </CFIF>

    <CFIF IsDefined("form.FundCatSel") and Form.FundCatSel IS NOT "Default">
        <CFSET variables.FundCatSel = form.FundCatSel>
    <cfelse>
        <CFSET variables.FundCatSel = "">
    </CFIF>

    <CFIF IsDefined("form.RevSel") and Form.RevSel IS NOT "Default">
        <CFSET variables.RevSel = form.RevSel>
    <cfelse>
        <CFSET variables.RevSel = "">
    </CFIF>

    <CFIF IsDefined("form.RevClsSel") and Form.RevClsSel IS NOT "Default">
        <CFSET variables.RevClsSel = form.RevClsSel>
    <cfelse>
        <CFSET variables.RevClsSel = "">
    </CFIF>

    <cfif IsDefined("form.RevCatSel") AND TRIM(form.RevCatSel) IS NOT "" AND form.RevCatSel IS NOT 0>
        <cfset variables.RevCatSel = TRIM(form.RevCatSel)>
    <cfelse>
        <cfset variables.RevCatSel = "">
    </cfif>

    <CFIF IsDefined("form.RevGrpSel") and Form.RevGrpSel IS NOT "Default">
        <CFSET variables.RevGrpSel = form.RevGrpSel>
    <cfelse>
        <CFSET variables.RevGrpSel = "">
    </CFIF>

    <CFIF IsDefined("form.RevTypeSel") and Form.RevTypeSel IS NOT "Default">
        <CFSET variables.RevTypeSel = form.RevTypeSel>
    <cfelse>
        <CFSET variables.RevTypeSel = "">
    </CFIF>

    <CFSET variables.Control = "State">
    <CFSET variables.ColName = "Fund">

    <CFSET variables.submitted = true>
    <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
    <cfelseif IsDefined("URL.AgcySel") AND IsDefined("URL.AgcyGrpSel") AND IsDefined("URL.AgcyCatSel") AND IsDefined("URL.AgcyTypeSel") AND IsDefined("URL.GroupBy") AND IsDefined("URL.FY")>

    <cfif IsDefined("url.AgcySel") AND TRIM(url.AgcySel) IS NOT "" AND TRIM(url.AgcySel) IS NOT "Default" AND TRIM(url.AgcySel) IS NOT 0>
        <cfset variables.AgcySel = URL.AgcySel>
    <cfelse>
        <cfset variables.AgcySel = "">
    </cfif>

    <cfif IsDefined("url.AgcyGrpSel") AND TRIM(url.AgcyGrpSel) IS NOT "" AND TRIM(url.AgcyGrpSel) IS NOT "Default" AND TRIM(url.AgcyGrpSel) IS NOT 0>
        <cfset variables.AgcyGrpSel = URL.AgcyGrpSel>
    <cfelse>
        <cfset variables.AgcyGrpSel = "">
    </cfif>

    <cfif IsDefined("url.AgcyTypeSel") AND TRIM(url.AgcyTypeSel) IS NOT "" AND TRIM(url.AgcyTypeSel) IS NOT "Default" AND TRIM(url.AgcyTypeSel) IS NOT 0>
        <cfset variables.AgcyTypeSel = URL.AgcyTypeSel>
    <cfelse>
        <cfset variables.AgcyTypeSel = "">
    </cfif>

    <cfif IsDefined("url.AgcyCatSel") AND TRIM(url.AgcyCatSel) IS NOT "" AND TRIM(url.AgcyCatSel) IS NOT "Default" AND TRIM(url.AgcyCatSel) IS NOT 0>
        <cfset variables.AgcyCatSel = URL.AgcyCatSel>
    <cfelse>
        <cfset variables.AgcyCatSel = "">
    </cfif>

    <cfif url.GroupBy eq 0 or TRIM(url.GroupBy) eq "None" OR url.GroupBy IS "Default">
        <cfset variables.GroupBy = "Rev">
    <cfelse>
        <cfset variables.GroupBy = TRIM(URLDecode(url.GroupBy, 'utf-8'))>
    </cfif>

    <cfif url.FY eq 0 or TRIM(url.FY) eq "" eq "" OR url.FY IS "Default">
        <cfset variables.FY = "#application.cfy#">
    <cfelse>
        <cfset variables.FY = TRIM(URLDecode(url.FY, 'utf-8'))>
    </cfif>

    <cfif IsDefined("url.ShowMo") AND TRIM(URL.ShowMo) IS "Yes">
        <cfset variables.ShowMo = "Yes">
    <cfelse>
        <cfset variables.ShowMo = "No">
    </cfif>
<!--- Handle Anchor Link values --->
    <CFIF IsDefined("url.FundSel") and TRIM(url.FundSel) IS NOT "Default" and TRIM(url.FundSel) IS NOT 0>
        <CFSET variables.FundSel = url.FundSel>
    <cfelse>
        <CFSET variables.FundSel = "">
    </CFIF>
    <CFIF IsDefined("url.FundGrpSel") and TRIM(url.FundGrpSel) IS NOT "Default" and TRIM(url.FundGrpSel) IS NOT 0>
        <CFSET variables.FundGrpSel = url.FundGrpSel>
    <cfelse>
        <CFSET variables.FundGrpSel = "">
    </CFIF>

    <CFIF IsDefined("url.FundTypeSel") and TRIM(url.FundTypeSel) IS NOT "Default" and TRIM(url.FundTypeSel) IS NOT 0>
        <CFSET variables.FundTypeSel = url.FundTypeSel>
    <cfelse>
        <CFSET variables.FundTypeSel = "">
    </CFIF>

    <CFIF IsDefined("url.FundCatSel") and TRIM(url.FundCatSel) IS NOT "Default" and TRIM(url.FundCatSel) IS NOT 0>
        <CFSET variables.FundCatSel = url.FundCatSel>
    <cfelse>
        <CFSET variables.FundCatSel = "">
    </CFIF>

    <cfif IsDefined("url.RevSel") AND TRIM(url.RevSel) IS NOT "" AND TRIM(url.RevSel) IS NOT "Default" AND TRIM(url.RevSel) IS NOT 0>
        <cfset variables.RevSel = URL.RevSel>
    <cfelse>
        <cfset variables.RevSel = "">
    </cfif>

    <cfif IsDefined("url.RevClsSel") AND TRIM(url.RevClsSel) IS NOT "" AND TRIM(url.RevClsSel) IS NOT "Default" AND TRIM(url.RevClsSel) IS NOT 0>
        <cfset variables.RevClsSel = URL.RevClsSel>
    <cfelse>
        <cfset variables.RevClsSel = "">
    </cfif>
    <cfif IsDefined("url.RevCatSel") AND TRIM(url.RevCatSel) IS NOT "" AND URL.RevCatSel IS NOT 0 AND URL.RevCatSel IS NOT "Default">
        <cfset variables.RevCatSel = TRIM(URLDecode(URL.RevCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevCatSel = "">
    </cfif>
    <cfif IsDefined("url.RevGrpSel") AND TRIM(url.RevGrpSel) IS NOT "" AND TRIM(url.RevGrpSel) IS NOT "Default" AND TRIM(url.RevGrpSel) IS NOT 0>
        <cfset variables.RevGrpSel = URL.RevGrpSel>
    <cfelse>
        <cfset variables.RevGrpSel = "">
    </cfif>

    <cfif IsDefined("url.RevTypeSel") AND TRIM(url.RevTypeSel) IS NOT "" AND TRIM(url.RevTypeSel) IS NOT "Default" AND TRIM(url.RevTypeSel) IS NOT 0>
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
<!--- Not sure if we need these two but incase here they are --->
    <CFSET variables.Control = "State">
    <CFSET variables.ColName = "Fund">
<cfelse>
    <CFSET variables.AgcySel = "">
    <CFSET variables.AgcyGrpSel = "">
    <CFSET variables.AgcyCatSel = "">
    <CFSET variables.AgcyTypeSel = "">
    <cfset variables.GroupBy = "Fund">
    <cfset variables.FY = "#application.cfy#">
    <cfset variables.ShowMo = "No">

    <CFSET variables.FundSel = "">
    <CFSET variables.FundGrpSel = "">
    <CFSET variables.FundTypeSel = "">
    <CFSET variables.FundCatSel = "">
    <CFSET variables.RevSel = "">
    <CFSET variables.RevClsSel = "">
    <CFSET variables.RevCatSel = "">
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
        <CFSET OutGoingGroupBy = "Fund">
        <CFSET DisableHyperLink = "No">
        <cfelseif ListFindNoCase("Fund,AgcyCat,AgcyGrp,AgcyType,None", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Agcy">
        <CFSET DisableHyperLink = "No">
        <cfelseif ListFindNoCase("Agcy,RevCls,RevGrp,RevType,None", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Rev">
        <CFSET DisableHyperLink = "No">
        <cfelseif ListFindNoCase("Rev", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Rev">
        <CFSET DisableHyperLink = "Yes">
    <cfelse>
        <CFSET OutGoingGroupBy = ThisName>
        <CFSET DisableHyperLink = "No">
    </cfif>
<!--- Create a cookie that retains the users form submitted values  --->
<!--- Because there is a limit to the number of cookies per domain each page that requires it gets 1 cookie per page. --->
<!---  The cookie stores the selected values as a CSV string   --->
<!--- Cookie CSV position legend:
1) Agency
2) Group
3) Category
4) Type
5) Group by
6) Fiscal Year
7) View Monthly Totals
 --->
    <CFIF TRIM(variables.AgcySel) IS "">
        <CFSET Postion1 = "Default">
    <cfelse>
        <CFSET Postion1 = variables.AgcySel>
    </CFIF>
    <CFIF TRIM(variables.AgcyGrpSel) IS "">
        <CFSET Postion2 = "Default">
    <cfelse>
        <CFSET Postion2 = variables.AgcyGrpSel>
    </CFIF>
    <CFIF TRIM(variables.AgcyCatSel) IS "">
        <CFSET Postion3 = "Default">
    <cfelse>
        <CFSET Postion3 = variables.AgcyCatSel>
    </CFIF>
    <CFIF TRIM(variables.AgcyTypeSel) IS "">
        <CFSET Postion4 = "Default">
    <cfelse>
        <CFSET Postion4 = variables.AgcyTypeSel>
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

<!--- Fund --->
    <CFIF TRIM(variables.FundCatSel) IS "">
        <CFSET Postion8 = "Default">
    <cfelse>
        <CFSET Postion8 = variables.FundCatSel>
    </CFIF>
    <CFIF TRIM(variables.FundSel) IS "">
        <CFSET Postion9 = "Default">
    <cfelse>
        <CFSET Postion9 = variables.FundSel>
    </CFIF>
    <CFIF TRIM(variables.FundGrpSel) IS "">
        <CFSET Postion10 = "Default">
    <cfelse>
        <CFSET Postion10 = variables.FundGrpSel>
    </CFIF>
    <CFIF TRIM(variables.FundTypeSel) IS "">
        <CFSET Postion11 = "Default">
    <cfelse>
        <CFSET Postion11 = variables.FundTypeSel>
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

    <cfcookie name="RevenuesByAgency" value="#Postion1#,#Postion2#,#Postion3#,#Postion4#,#Postion5#,#Postion6#,#Postion7#,#Postion8#,#Postion9#,#Postion10#,#Postion11#,#Postion12#,#Postion13#,#Postion14#,#Postion15#,#Postion16#" expires="never">
    <cftry>
            <cfinvoke component="Queries.revenues"
                    method="RevenueQuery"
                    returnvariable="results"
                    Control="Agcy"
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
                    SortName="No">
            </cfinvoke>
        <cfset ColumnNames = ArrayToList(Results.getColumnNames())/>

        <cfcatch type="any">
            <CFSET ColumnNames = "Error">
<!--- Catch any errors whereas the incoming input values caused a DB2 crash --->
            <CFSET Error = "1">
        </cfcatch>
    </cftry>

</cfif>
<!-- get agencies --->
<cfinvoke component="Queries.warehouse"
        method="getAgencies"
        returnvariable="agencyList">
</cfinvoke>
<!-- get agency groups -->
<cfinvoke component="Queries.warehouse"
        method="getAgencyGroups"
        returnvariable="agencyGroupList">
</cfinvoke>
<!-- get agency groups -->
<cfinvoke component="Queries.warehouse"
        method="getAgencyCategories"
        returnvariable="agencyCatList">
</cfinvoke>
<!-- get Agency Types -->
<cfinvoke component="Queries.warehouse"
        method="getAgencyTypes"
        returnvariable="agencyTypeList">
</cfinvoke>
<!-- get Fiscal Years --->
<cfinvoke component="Queries.warehouse"
        method="getFYs"
        returnvariable="FYList">
        <cfinvokeargument name="numFYs" value="5"/>
</cfinvoke>

<!--- Get Friend Names for form submitted values. --->
<CFIF IsDefined("cookie.RevenuesByAgency") AND ListLen(cookie.RevenuesByAgency) IS 16>
    <CFSET C1_Agency = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 1), 'utf-8'))>
    <CFSET C1_Group = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 2), 'utf-8'))>
    <CFSET C1_Category = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 3), 'utf-8'))>
    <CFSET C1_Type = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 4), 'utf-8'))>
    <CFSET C1_GroupBy = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 5), 'utf-8'))>
    <CFSET C1_FY = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 6), 'utf-8'))>
    <CFSET C1_MT = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 7), 'utf-8'))>
    <CFSET C1_FundCatSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 8), 'utf-8'))>
    <CFSET C1_FundSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 9), 'utf-8'))>
    <CFSET C1_FundGrpSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 10), 'utf-8'))>
    <CFSET C1_FundTypeSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 11), 'utf-8'))>
    <CFSET C1_RevCatSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 12), 'utf-8'))>
    <CFSET C1_RevSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 13), 'utf-8'))>
    <CFSET C1_RevGrpSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 14), 'utf-8'))>
    <CFSET C1_RevTypeSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 15), 'utf-8'))>
    <CFSET C1_RevClsSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByAgency, 16), 'utf-8'))>
        <cfinvoke component="Queries.revenues"
                method="GetFreindlyName_Revenues_Agency"
                returnvariable="FN1">
        </cfinvoke>

</CFIF>

<cfoutput>
    <div id="expense" class="revenue">
            <div class="container"
                 <cfif IsDefined("results")>style="width: 100% !important"</cfif>>
    <div class="row">
        <div id="1" style="display:none" class="col-md-4 col-md-offset-4 alert alert-info text-center">
            Gathering data, please wait...
        </div>
    </div>
<div class="row">
<div class="col-md-10 col-md-offset-1">
<!--- Default Display and Dynamic Display --->
    <CFIF not isDefined("results")>
<!--- <p>#$.getTitle()#</p> --->
            <p>Agencies are established by the General Assembly to administer the various functions of state
                government.</p>
        <cfelseif IsDefined("cookie.RevenuesByAgency")>

        <div id="4" style="display:block">
        <cfsaveContent variable="headString">
            <div class="row">
            <div class="col-md-9 col-md-offset-3">
            <CFIF TRIM(FN1.val1) IS NOT "">
                    <p>Agency: #FN1.val1#</p>
            </CFIF>

            </div>
            </div>
            <div class="row">
            <div class="col-md-3 col-md-offset-3">

            <CFIF TRIM(FN1.val2) IS NOT "">
                    <p>Agency Group: #FN1.val2#</p>
            </CFIF>
            <CFIF TRIM(FN1.val3) IS NOT "">
                    <p>Agency Category: #FN1.val3#</p>
            </CFIF>
            <CFIF TRIM(FN1.val4) IS NOT "">
                    <p>Agency Type: #FN1.val4#</p>
            </CFIF>
                <p>Agency Year: #C1_FY#</p>
            <CFIF TRIM(FN1.val5) IS NOT "">
                    <p>Group By: #FN1.val5#</p>
            </CFIF>
            <CFIF TRIM(FN1.val7) IS NOT "">
                    <p>Show Monthly: #FN1.val7#</p>
            </CFIF>


            <CFIF FN1.val8 IS NOT "Default" AND FN1.val8 IS NOT "">
                    Fund Category: #FN1.val8#<BR/>
            </CFIF>
            <CFIF FN1.val9 IS NOT "Default" AND FN1.val9 IS NOT "">
                    Fund: #FN1.val9#<BR/>
            </CFIF>
            <CFIF FN1.val10 IS NOT "Default" AND FN1.val10 IS NOT "">
                    Fund Group: #FN1.val10#<BR/>
            </CFIF>
            <CFIF FN1.val11 IS NOT "Default" AND FN1.val11 IS NOT "">
                    Fund Type: #FN1.val11#<BR/>
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
                    Revenue Class: #FN1.val16#<BR/>
            </CFIF>
            </div>
        </cfsaveContent>
        #headString#
        <div class="col-md-5 pull-left">
<!--- Display Adobe PDF Download for results --->
        <CFIF IsDefined("Results")>
                <div id="3" style="display:block">
                <p>
                        <a href="?AgcySel=#C1_Agency#&AgcyGrpSel=#C1_Group#&AgcyCatSel=#C1_Category#&AgcyTypeSel=#C1_Type#&GroupBy=#C1_GroupBy#&FY=#C1_FY#&ShowMo=#C1_MT#&FundSel=#C1_FundSel#&FundGrpSel=#C1_FundGrpSel#&FundTypeSel=#C1_FundTypeSel#&FundCatSel=#C1_FundCatSel#&RevSel=#C1_RevSel#&RevClsSel=#C1_RevClsSel#&RevTypeSel=#C1_RevTypeSel#&RevCatSel=#C1_RevCatSel#&PrintAsPDF=true">
                    <img alt="PDF File" src="#$.siteconfig('themeassetpath')#/images/AdobeAcrobat.png" /></a></p>
            </div>
        </CFIF>
        </div>
        </div>
        </div>
        <div id="5" style="display:none">
            <p>Agencies are established by the General Assembly to administer the various functions of state
                government.</p>
        </div>
    </CFIF>

    <cfform action="" method="get" enctype="application/x-www-form-urlencoded" preloader="no" id="searchform">
        <div id="101" style="display:#HideSwitch1#">

    <div class="row">
        <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
            <div class="btn-label">Select an Agency</div>
        </div>

    <div class="col-xs-12 col-sm-7 col-md-5">
    <select name="AgcySel" id="AgcySel">
        <option value="0" selected="selected">Select an Agency</option>
        <option value="0">All</option>
        <cfloop query="agencyList">
                <option value="#TRIM(agencyList.Agency)#">#agencyList.Agency# - #agencyList.Name#</option>
        </cfloop>
        </select>
        </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Group</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select name="AgcyGrpSel">
            <option value="0" selected="selected">Group</option>
            <option value="0">All</option>
        <Cfloop query="agencyGroupList">
                <option value="#TRIM(group)#">#group# - #Name#</option>
        </Cfloop>
        </select>
        </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Category</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select name="AgcyCatSel">
            <option value="0" selected="selected">Category</option>
            <option value="0">All</option>
        <Cfloop query="agencyCatList">
                <option value="#TRIM(Category)#">#Category# - #Name#</option>
        </Cfloop>
        </select>
        </div>
        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Type</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select name="AgcyTypeSel">
            <option value="0" selected="selected">Type</option>
            <option value="0">All</option>
        <Cfloop query="agencyTypeList">
                <option value="#TRIM(Type)#">#Type# - #Name#</option>
        </Cfloop>
        </select>
        </div>
        </div>

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
                        <option value="Fund">Fund</option>
                        <option value="FundCat">Fund Category</option>
                        <option value="FundGrp">Fund Group</option>
                        <option value="FundType">Fund Type</option>
                        <OPTION VALUE="Rev" SELECTED>Group By Revenue Source</option>
                        <OPTION VALUE="RevCls">Revenue Class</option>
                        <OPTION VALUE="RevGrp">Revenue Group</option>
                        <OPTION VALUE="RevType">Revenue Type</option>
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
                <option value="#Right(i, 2)#"><CFIF application.cfy IS Right(i, 2)>Fiscal Year</CFIF> #i#</option>
        </Cfloop>
        </select>
        </div>
        </div>

            <div class="row">
                <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                    <div class="btn-label">Show Monthly Amounts</div>
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

<!--- Search Again button --->
    <div class="show margintop30">
        <div class="text-center" style="display:#HideSwitch2#"  id="100">
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
                    <cfinclude template="outputs/agency1.cfm">
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
                    <div id="2" style="width: 98%; margin: 0px auto; display:block">
                    <cfinclude template="outputs/agency1.cfm">
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
                <BR/><p>No records found. Please use different search criteria.</p>
            </div>
    </CFIF>


<!--- Display Last search results if cookie exists --->
    <CFIF Not IsDefined("results") AND IsDefined("cookie.RevenuesByAgency") AND ListLen(cookie.RevenuesByAgency) IS 16>


            <a href="?AgcySel=#C1_Agency#&AgcyGrpSel=#C1_Group#&AgcyCatSel=#C1_Category#&AgcyTypeSel=#C1_Type#&GroupBy=#C1_GroupBy#&FY=#C1_FY#&ShowMo=#C1_MT#&FundSel=#C1_FundSel#&FundGrpSel=#C1_FundGrpSel#&FundTypeSel=#C1_FundTypeSel#&FundCatSel=#C1_FundCatSel#&RevSel=#C1_RevSel#&RevClsSel=#C1_RevClsSel#&RevTypeSel=#C1_RevTypeSel#&RevCatSel=#C1_RevCatSel#">
        <div class="row">
        <div class="col-sm-offset-1 col-sm-10">
        <div class="lastsearch">
            <p>Last Search</p>

        <ul>
            <CFIF TRIM(FN1.val1) IS NOT "">
                    <li> Agency: #FN1.val1#</li>
            </CFIF>
            <CFIF TRIM(FN1.val2) IS NOT "">
                    <li>Agency Group: #FN1.val2#</li>
            </CFIF>
            <CFIF TRIM(FN1.val3) IS NOT "">
                    <li>Agency Category: #FN1.val3#</li>
            </CFIF>
            <CFIF TRIM(FN1.val4) IS NOT "">
                    <li>Agency Type: #FN1.val4#</li>
            </CFIF>
                <li>Agency Year: #C1_FY#</li>
            <CFIF TRIM(FN1.val5) IS NOT "">
                    <li>Group By: #FN1.val5#</li>
            </CFIF>
            <CFIF TRIM(FN1.val7) IS NOT "">
                    <li>Show Monthly: #FN1.val7#</li>
            </CFIF>


            <CFIF FN1.val8 IS NOT "Default" AND FN1.val8 IS NOT "">
                    Fund Category: #FN1.val8#<BR/>
            </CFIF>
            <CFIF FN1.val9 IS NOT "Default" AND FN1.val9 IS NOT "">
                    Fund: #FN1.val9#<BR/>
            </CFIF>
            <CFIF FN1.val10 IS NOT "Default" AND FN1.val10 IS NOT "">
                    Fund Group: #FN1.val10#<BR/>
            </CFIF>
            <CFIF FN1.val11 IS NOT "Default" AND FN1.val11 IS NOT "">
                    Fund Type: #FN1.val11#<BR/>
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
                    Revenue Class: #FN1.val16#<BR/>
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