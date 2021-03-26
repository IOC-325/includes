<!--- by agency --->
<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css"/>
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/jquery.dataTables1.10.20.min.css" rel="stylesheet" type="text/css">
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/fixedColumns.dataTables3.3.0.min.css" rel="stylesheet" type="text/css">

<cfparam name="DisableHyperLink" default="no">
<cfparam name="OutGoingGroupBy" default="None">
<CFPARAM NAME="variables.ShowMo" DEFAULT="Yes">

<cfif isDefined("form.GroupBy")>

    <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
    <CFSET form.Submitted = true>

    <cfif form.GroupBy eq 0>
        <cfset variables.GroupBy = "Fund">
    <cfelse>
        <cfset variables.GroupBy = form.GroupBy>
    </cfif>
    <cfif form.FY eq 0>
        <cfset variables.FY = "#application.cfy#">
    <cfelse>
        <cfset variables.FY = form.FY>
    </cfif>

    <cfif IsDefined("form.ShowBudg") AND TRIM(form.ShowBudg) IS "Yes">
        <cfset variables.ShowBudg = "Yes">
    <cfelse>
        <cfset variables.ShowBudg = "No">
    </cfif>

    <cfif IsDefined("form.ShowMo") AND TRIM(form.ShowMo) IS "Yes">
        <cfset variables.ShowMo = "Yes">
    <cfelse>
        <cfset variables.ShowMo = "No">
    </cfif>

    <cfif IsDefined("form.ShowLapse") AND TRIM(form.ShowLapse) IS "Yes">
        <cfset variables.ShowLapse = "Yes">
    <cfelse>
        <cfset variables.ShowLapse = "No">
    </cfif>

    <cfif TRIM(form.Type) eq 0 OR TRIM(form.Type) IS "Default">
        <cfset variables.Type = "A">
    <cfelse>
        <cfset variables.Type = TRIM(form.Type)>
    </cfif>

<!--- Handle Inline report link submit --->
    <cfif IsDefined("form.AgcySel") AND TRIM(form.AgcySel) IS NOT "" AND form.AgcySel IS NOT 0 AND form.AgcySel IS NOT "Default">
        <cfset variables.AgcySel = TRIM(form.AgcySel)>
    <cfelse>
        <cfset variables.AgcySel = "">
    </cfif>

    <cfif IsDefined("form.AgcyGrpSel") AND TRIM(form.AgcyGrpSel) IS NOT "" AND form.AgcyGrpSel IS NOT 0 AND form.AgcyGrpSel IS NOT "Default">
        <cfset variables.AgcyGrpSel = TRIM(form.AgcyGrpSel)>
    <cfelse>
        <cfset variables.AgcyGrpSel = "">
    </cfif>

    <cfif IsDefined("form.AgcyTypeSel") AND TRIM(form.AgcyTypeSel) IS NOT "" AND form.AgcyTypeSel IS NOT 0 AND form.AgcyTypeSel IS NOT "Default">
        <cfset variables.AgcyTypeSel = TRIM(form.AgcyTypeSel)>
    <cfelse>
        <cfset variables.AgcyTypeSel = "">
    </cfif>

    <cfif IsDefined("form.AgcyCatSel") AND TRIM(form.AgcyCatSel) IS NOT "" AND form.AgcyCatSel IS NOT 0 AND form.AgcyCatSel IS NOT "Default">
        <cfset variables.AgcyCatSel = TRIM(form.AgcyCatSel)>
    <cfelse>
        <cfset variables.AgcyCatSel = "">
    </cfif>

    <cfif IsDefined("form.RevSel") AND TRIM(form.RevSel) IS NOT "" AND form.RevSel IS NOT 0>
        <cfset variables.RevSel = TRIM(form.RevSel)>
    <cfelse>
        <cfset variables.RevSel = "">
    </cfif>

    <cfif IsDefined("form.RevClsSel") AND TRIM(form.RevClsSel) IS NOT "" AND form.RevClsSel IS NOT 0>
        <cfset variables.RevClsSel = TRIM(form.RevClsSel)>
    <cfelse>
        <cfset variables.RevClsSel = "">
    </cfif>

    <cfif IsDefined("form.RevCatSel") AND TRIM(form.RevCatSel) IS NOT "" AND form.RevCatSel IS NOT 0>
        <cfset variables.RevCatSel = TRIM(form.RevCatSel)>
    <cfelse>
        <cfset variables.RevCatSel = "">
    </cfif>

    <cfif IsDefined("form.RevGrpSel") AND TRIM(form.RevGrpSel) IS NOT "" AND form.RevGrpSel IS NOT 0>
        <cfset variables.RevGrpSel = TRIM(form.RevGrpSel)>
    <cfelse>
        <cfset variables.RevGrpSel = "">
    </cfif>

    <cfif IsDefined("form.RevTypeSel") AND TRIM(form.RevTypeSel) IS NOT "" AND form.RevTypeSel IS NOT 0>
        <cfset variables.RevTypeSel = TRIM(form.RevTypeSel)>
    <cfelse>
        <cfset variables.RevTypeSel = "">
    </cfif>

    <cfif IsDefined("form.FundSel") AND TRIM(form.FundSel) IS NOT "" AND form.FundSel IS NOT 0 AND TRIM(form.FundSel) IS NOT "Default">
        <cfset variables.FundSel = TRIM(form.FundSel)>
    <cfelse>
        <cfset variables.FundSel = "">
    </cfif>

    <cfif IsDefined("form.FundClsSel") AND TRIM(form.FundClsSel) IS NOT "" AND form.FundClsSel IS NOT 0 AND TRIM(form.FundClsSel) IS NOT "Default">
        <cfset variables.FundClsSel = TRIM(form.FundClsSel)>
    <cfelse>
        <cfset variables.FundClsSel = "">
    </cfif>

    <cfif IsDefined("form.FundGrpSel") AND TRIM(form.FundGrpSel) IS NOT "" AND form.FundGrpSel IS NOT 0 AND TRIM(form.FundGrpSel) IS NOT "Default">
        <cfset variables.FundGrpSel = TRIM(form.FundGrpSel)>
    <cfelse>
        <cfset variables.FundGrpSel = "">
    </cfif>

    <cfif IsDefined("form.FundTypeSel") AND TRIM(form.FundTypeSel) IS NOT "" AND form.FundTypeSel IS NOT 0 AND TRIM(form.FundTypeSel) IS NOT "Default">
        <cfset variables.FundTypeSel = TRIM(form.FundTypeSel)>
    <cfelse>
        <cfset variables.FundTypeSel = "">
    </cfif>

    <cfif IsDefined("form.FundCatSel") AND TRIM(form.FundCatSel) IS NOT "" AND form.FundCatSel IS NOT 0 AND form.FundCatSel IS NOT "Default" AND TRIM(form.FundCatSel) IS NOT "Default">
        <cfset variables.FundCatSel = TRIM(form.FundCatSel)>
    <cfelse>
        <cfset variables.FundCatSel = "">
    </cfif>
<!--- Obje --->
    <cfif IsDefined("form.ObjeSel") AND TRIM(form.ObjeSel) IS NOT "" AND form.ObjeSel IS NOT 0 AND TRIM(form.ObjeSel) IS NOT "Default">
        <cfset variables.ObjeSel = TRIM(form.ObjeSel)>
    <cfelse>
        <cfset variables.ObjeSel = "">
    </cfif>

    <cfif IsDefined("form.ObjeClsSel") AND TRIM(form.ObjeClsSel) IS NOT "" AND form.ObjeClsSel IS NOT 0 AND TRIM(form.ObjeClsSel) IS NOT "Default">
        <cfset variables.ObjeClsSel = TRIM(form.ObjeClsSel)>
    <cfelse>
        <cfset variables.ObjeClsSel = "">
    </cfif>

    <cfif IsDefined("form.ObjeGrpSel") AND TRIM(form.ObjeGrpSel) IS NOT "" AND form.ObjeGrpSel IS NOT 0 AND TRIM(form.ObjeGrpSel) IS NOT "Default">
        <cfset variables.ObjeGrpSel = TRIM(form.ObjeGrpSel)>
    <cfelse>
        <cfset variables.ObjeGrpSel = "">
    </cfif>

    <cfif IsDefined("form.ObjeTypeSel") AND TRIM(form.ObjeTypeSel) IS NOT "" AND form.ObjeTypeSel IS NOT 0 AND TRIM(form.ObjeTypeSel) IS NOT "Default">
        <cfset variables.ObjeTypeSel = TRIM(form.ObjeTypeSel)>
    <cfelse>
        <cfset variables.ObjeTypeSel = "">
    </cfif>

    <cfif IsDefined("form.ObjeCatSel") AND TRIM(form.ObjeCatSel) IS NOT "" AND form.ObjeCatSel IS NOT 0 AND form.ObjeCatSel IS NOT "Default" AND TRIM(form.ObjeCatSel) IS NOT "Default">
        <cfset variables.ObjeCatSel = TRIM(form.ObjeCatSel)>
    <cfelse>
        <cfset variables.ObjeCatSel = "">
    </cfif>

    <cfif IsDefined("form.ApprSel") AND TRIM(form.ApprSel) IS NOT "" AND form.ApprSel IS NOT 0 AND form.ApprSel IS NOT "Default">
        <cfset variables.ApprSel = TRIM(form.ApprSel)>
    <cfelse>
        <cfset variables.ApprSel = "">
    </cfif>

    <cfif IsDefined("form.ApprGrpSel") AND TRIM(form.ApprGrpSel) IS NOT "" AND form.ApprGrpSel IS NOT 0 AND form.ApprGrpSel IS NOT "Default">
        <cfset variables.ApprGrpSel = TRIM(form.ApprGrpSel)>
    <cfelse>
        <cfset variables.ApprGrpSel = "">
    </cfif>

    <cfif IsDefined("form.ApprTypeSel") AND TRIM(form.ApprTypeSel) IS NOT "" AND form.ApprTypeSel IS NOT 0 AND form.ApprTypeSel IS NOT "Default">
        <cfset variables.ApprTypeSel = TRIM(form.ApprTypeSel)>
    <cfelse>
        <cfset variables.ApprTypeSel = "">
    </cfif>

    <cfif IsDefined("form.ApprCatSel") AND TRIM(form.ApprCatSel) IS NOT "" AND form.ApprCatSel IS NOT 0 AND form.ApprCatSel IS NOT "Default">
        <cfset variables.ApprCatSel = TRIM(form.ApprCatSel)>
    <cfelse>
        <cfset variables.ApprCatSel = "">
    </cfif>

    <cfif IsDefined("form.ApprClsSel") AND TRIM(form.ApprClsSel) IS NOT "" AND form.ApprClsSel IS NOT 0 AND form.ApprClsSel IS NOT "Default">
        <cfset variables.ApprClsSel = TRIM(form.ApprClsSel)>
    <cfelse>
        <cfset variables.ApprClsSel = "">
    </cfif>

    <cfelseif IsDefined("URL.GroupBy") AND IsDefined("URL.FY")>
    <cfif URL.GroupBy eq 0 OR URL.GroupBy IS "Default" OR URL.Groupby IS "None">
        <cfset variables.GroupBy = "Fund">
    <cfelse>
        <cfset variables.GroupBy = TRIM(URLDecode(url.GroupBy, 'utf-8'))>
    </CFIF>
    <cfif URL.FY eq 0>
        <cfset variables.FY = "#application.cfy#">
    <cfelse>
        <cfset variables.FY = TRIM(URLDecode(URL.FY, 'utf-8'))>
    </cfif>

    <cfif IsDefined("URL.ShowBudg") AND TRIM(URL.ShowBudg) IS "Yes">
        <cfset variables.ShowBudg = "Yes">
    <cfelse>
        <cfset variables.ShowBudg = "No">
    </cfif>

    <cfif IsDefined("URL.ShowMo") AND TRIM(URL.ShowMo) IS "Yes">
        <cfset variables.ShowMo = "Yes">
    <cfelse>
        <cfset variables.ShowMo = "No">
    </cfif>

    <cfif IsDefined("URL.ShowLapse") AND TRIM(URL.ShowLapse) IS "Yes">
        <cfset variables.ShowLapse = "Yes">
    <cfelse>
        <cfset variables.ShowLapse = "No">
    </cfif>

    <cfif TRIM(URL.Type) eq 0 OR TRIM(URL.Type) IS "Default">
        <cfset variables.Type = "A">
    <cfelse>
        <cfset variables.Type = TRIM(URLDecode(URL.Type, 'utf-8'))>
    </cfif>

<!--- Handle Inline report link submit --->
    <cfif IsDefined("url.AgcySel") AND TRIM(url.AgcySel) IS NOT "" AND URL.AgcySel IS NOT 0 AND TRIM(url.AgcySel) IS NOT "Default">
        <cfset variables.AgcySel = TRIM(URLDecode(URL.AgcySel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcySel = "">
    </cfif>

    <cfif IsDefined("url.AgcyGrpSel") AND TRIM(url.AgcyGrpSel) IS NOT "" AND URL.AgcyGrpSel IS NOT 0 AND TRIM(url.AgcyGrpSel) IS NOT "Default">
        <cfset variables.AgcyGrpSel = TRIM(URLDecode(URL.AgcyGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcyGrpSel = "">
    </cfif>

    <cfif IsDefined("url.AgcyTypeSel") AND TRIM(url.AgcyTypeSel) IS NOT "" AND URL.AgcyTypeSel IS NOT 0 AND TRIM(url.AgcyTypeSel) IS NOT "Default">
        <cfset variables.AgcyTypeSel = TRIM(URLDecode(URL.AgcyTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcyTypeSel = "">
    </cfif>

    <cfif IsDefined("url.AgcyCatSel") AND TRIM(url.AgcyCatSel) IS NOT "" AND URL.AgcyCatSel IS NOT 0 AND TRIM(url.AgcyCatSel) IS NOT "Default">
        <cfset variables.AgcyCatSel = TRIM(URLDecode(URL.AgcyCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.AgcyCatSel = "">
    </cfif>

    <cfif IsDefined("url.RevSel") AND TRIM(url.RevSel) IS NOT "" AND URL.RevSel IS NOT 0>
        <cfset variables.RevSel = TRIM(URLDecode(URL.RevSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevSel = "">
    </cfif>

    <cfif IsDefined("url.RevClsSel") AND TRIM(url.RevClsSel) IS NOT "" AND URL.RevClsSel IS NOT 0>
        <cfset variables.RevClsSel = TRIM(URLDecode(URL.RevClsSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevClsSel = "">
    </cfif>

    <cfif IsDefined("url.RevCatSel") AND TRIM(url.RevCatSel) IS NOT "" AND URL.RevCatSel IS NOT 0>
        <cfset variables.RevCatSel = TRIM(URLDecode(URL.RevCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevCatSel = "">
    </cfif>

    <cfif IsDefined("url.RevGrpSel") AND TRIM(url.RevGrpSel) IS NOT "" AND URL.RevGrpSel IS NOT 0>
        <cfset variables.RevGrpSel = TRIM(URLDecode(URL.RevGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevGrpSel = "">
    </cfif>

    <cfif IsDefined("url.RevTypeSel") AND TRIM(url.RevTypeSel) IS NOT "" AND URL.RevTypeSel IS NOT 0>
        <cfset variables.RevTypeSel = TRIM(URLDecode(URL.RevTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.RevTypeSel = "">
    </cfif>

    <cfif IsDefined("url.FundSel") AND TRIM(url.FundSel) IS NOT "" AND URL.FundSel IS NOT 0 AND TRIM(url.FundSel) IS NOT "Default">
        <cfset variables.FundSel = TRIM(URLDecode(URL.FundSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundSel = "">
    </cfif>

    <cfif IsDefined("url.FundClsSel") AND TRIM(url.FundClsSel) IS NOT "" AND URL.FundClsSel IS NOT 0 AND TRIM(url.FundClsSel) IS NOT "Default">
        <cfset variables.FundClsSel = TRIM(URLDecode(URL.FundClsSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundClsSel = "">
    </cfif>

    <cfif IsDefined("url.FundGrpSel") AND TRIM(url.FundGrpSel) IS NOT "" AND URL.FundGrpSel IS NOT 0 AND TRIM(url.FundGrpSel) IS NOT "Default">
        <cfset variables.FundGrpSel = TRIM(URLDecode(URL.FundGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundGrpSel = "">
    </cfif>
    <cfif IsDefined("url.FundTypeSel") AND TRIM(url.FundTypeSel) IS NOT "" AND URL.FundTypeSel IS NOT 0 AND TRIM(url.FundTypeSel) IS NOT "Default">
        <cfset variables.FundTypeSel = TRIM(URLDecode(URL.FundTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundTypeSel = "">
    </cfif>

    <cfif IsDefined("url.FundCatSel") AND TRIM(url.FundCatSel) IS NOT "" AND URL.FundCatSel IS NOT 0 AND URL.FundCatSel IS NOT "Default" AND TRIM(url.FundCatSel) IS NOT "Default">
        <cfset variables.FundCatSel = TRIM(URLDecode(URL.FundCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.FundCatSel = "">
    </cfif>

<!--- Ojbe --->
    <cfif IsDefined("url.ObjeSel") AND TRIM(url.ObjeSel) IS NOT "" AND URL.ObjeSel IS NOT 0 AND TRIM(url.ObjeSel) IS NOT "Default">
        <cfset variables.ObjeSel = TRIM(URLDecode(URL.ObjeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ObjeSel = "">
    </cfif>

    <cfif IsDefined("url.ObjeClsSel") AND TRIM(url.ObjeClsSel) IS NOT "" AND URL.ObjeClsSel IS NOT 0 AND TRIM(url.ObjeClsSel) IS NOT "Default">
        <cfset variables.ObjeClsSel = TRIM(URLDecode(URL.ObjeClsSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ObjeClsSel = "">
    </cfif>

    <cfif IsDefined("url.ObjeGrpSel") AND TRIM(url.ObjeGrpSel) IS NOT "" AND URL.ObjeGrpSel IS NOT 0 AND TRIM(url.ObjeGrpSel) IS NOT "Default">
        <cfset variables.ObjeGrpSel = TRIM(URLDecode(URL.ObjeGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ObjeGrpSel = "">
    </cfif>

    <cfif IsDefined("url.ObjeTypeSel") AND TRIM(url.ObjeTypeSel) IS NOT "" AND URL.ObjeTypeSel IS NOT 0 AND TRIM(url.ObjeTypeSel) IS NOT "Default">
        <cfset variables.ObjeTypeSel = TRIM(URLDecode(URL.ObjeTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ObjeTypeSel = "">
    </cfif>

    <cfif IsDefined("url.ObjeCatSel") AND TRIM(url.ObjeCatSel) IS NOT "" AND URL.ObjeCatSel IS NOT 0 AND URL.ObjeCatSel IS NOT "Default" AND TRIM(url.ObjeCatSel) IS NOT "Default">
        <cfset variables.ObjeCatSel = TRIM(URLDecode(URL.ObjeCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ObjeCatSel = "">
    </cfif>

    <cfif IsDefined("url.ApprSel") AND TRIM(url.ApprSel) IS NOT "" AND URL.ApprSel IS NOT 0 AND URL.ApprSel IS NOT "Default">
        <cfset variables.ApprSel = TRIM(URLDecode(URL.ApprSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ApprSel = "">
    </cfif>

    <cfif IsDefined("url.ApprGrpSel") AND TRIM(url.ApprGrpSel) IS NOT "" AND URL.ApprGrpSel IS NOT 0 AND URL.ApprGrpSel IS NOT "Default">
        <cfset variables.ApprGrpSel = TRIM(URLDecode(URL.ApprGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ApprGrpSel = "">
    </cfif>

    <cfif IsDefined("url.ApprTypeSel") AND TRIM(url.ApprTypeSel) IS NOT "" AND URL.ApprTypeSel IS NOT 0 AND URL.ApprTypeSel IS NOT "Default">
        <cfset variables.ApprTypeSel = TRIM(URLDecode(URL.ApprTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ApprTypeSel = "">
    </cfif>

    <cfif IsDefined("url.ApprCatSel") AND TRIM(url.ApprCatSel) IS NOT "" AND URL.ApprCatSel IS NOT 0 AND URL.ApprCatSel IS NOT "Default">
        <cfset variables.ApprCatSel = TRIM(URLDecode(URL.ApprCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ApprCatSel = "">
    </cfif>

    <cfif IsDefined("url.ApprClsSel") AND TRIM(url.ApprClsSel) IS NOT "" AND URL.ApprClsSel IS NOT 0 AND URL.ApprClsSel IS NOT "Default">
        <cfset variables.ApprClsSel = TRIM(URLDecode(URL.ApprClsSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ApprClsSel = "">
    </cfif>

    <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
    <CFIF IsDefined("URL.PrintAsPDF")>
        <CFSET form.PrintAsPDF = true>
    </CFIF>

    <CFSET form.Submitted = true>
<cfelse>
    <cfset variables.GroupBy = "Agcy">
    <cfset variables.FY = "#application.cfy#">
    <cfset variables.Type = "A">
    <cfset variables.ShowMo = "No">
    <cfset variables.ShowBudg = "No">
    <cfset variables.ShowLapse = "No">
    <CFSET HideSwitch1 = "block">
    <CFSET HideSwitch2 = "none">
    <CFSET variables.FundSel = "">
    <CFSET variables.FundGrpSel = "">
    <CFSET variables.FundTypeSel = "">
    <CFSET variables.FundCatSel = "">
    <CFSET variables.AgcySel = "">
    <CFSET variables.AgcyGrpSel = "">
    <CFSET variables.AgcyTypeSel = "">
    <CFSET variables.AgcyTypeSel = "">
    <CFSET variables.AgcyCatSel = "">
    <CFSET variables.RevSel = "">
    <CFSET variables.RevClsSel = "">
    <CFSET variables.RevCatSel = "">
    <CFSET variables.RevGrpSel = "">
    <CFSET variables.RevTypeSel = "">
    <CFSET variables.ObjeSel = "">
    <CFSET variables.ObjeGrpSel = "">
    <CFSET variables.ObjeTypeSel = "">
    <CFSET variables.ObjeCatSel = "">
    <CFSET variables.ApprSel = "">
    <CFSET variables.ApprGrpSel = "">
    <CFSET variables.ApprTypeSel = "">
    <CFSET variables.ApprCatSel = "">
    <CFSET variables.ApprClsSel = "">

</cfif>

<CFIF IsDefined("form.Submitted")>
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
        <CFSET OutGoingGroupBy = "Obje">
        <CFSET DisableHyperLink = "Yes">
        <cfelseif ListFindNoCase("Fund,AgcyCat,AgcyGrp,AgcyType", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Agcy">
        <CFSET DisableHyperLink = "No">
        <cfelseif ListFindNoCase("Agcy,None", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Obje">
        <CFSET DisableHyperLink = "No">
        <cfelseif ListFindNoCase("Obje,ApprCat,ApprGrp,ApprType,ApprCls", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Objt">
        <CFSET DisableHyperLink = "No">
        <cfelseif ListFindNoCase("Appr,ObjtCat,ObjtGrp,ObjtType", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Objt">
        <CFSET DisableHyperLink = "Yes">
        <cfelseif ListFindNoCase("Objt", variables.GroupBy) GT 0>
        <CFSET OutGoingGroupBy = "Objt">
        <CFSET DisableHyperLink = "Yes">
    <cfelse>
        <CFSET OutGoingGroupBy = ThisName>
        <CFSET DisableHyperLink = "No">
    </cfif>


<!--- Create a cookie that retains the users form submitted values  --->
<!--- Because there is a limit to the number of cookies per domain each page that requires it gets 1 cookie per page. --->
<!---  The cookie stores the selected values as a CSV string   --->
<!--- Cookie CSV position legend:
    1) Group By
    2) Fiscal Year
    3) Type
    4) View Monthly Totals
    5) View Budget Amounts
    6) View Lapse Amounts
    7) Agency Category
    8) Agency
    9) Agency Group
    10) Agency Type
    11) Fund Category
    12) Fund
    13) Fund Group
    14) Fund Type
    15) Revenue Category
    16) Revenue
    17) Revenue Group
    18) Revenue Type
    19) Object Category
    20) Object
    21) Object Group
    22) Object Type
    23) Appropriation Category
    24) Appropriation
    25) Appropriation Group
    26) Appropriation Type
    27) Appropriation Class
     --->

    <CFIF TRIM(variables.GroupBy) IS "">
        <CFSET Postion1 = "Default">
    <cfelse>
        <CFSET Postion1 = variables.GroupBy>
    </CFIF>
    <CFIF TRIM(variables.FY) IS "" OR TRIM(variables.FY) IS "0">
        <CFSET Postion2 = "Default">
    <cfelse>
        <CFSET Postion2 = variables.FY>
    </CFIF>
    <CFIF TRIM(variables.Type) IS "" OR TRIM(variables.Type) IS "Default">
        <CFSET Postion3 = "Default">
    <cfelse>
        <CFSET Postion3 = variables.Type>
    </CFIF>
    <CFIF TRIM(variables.ShowMo) IS "">
        <CFSET Postion4 = "No">
    <cfelse>
        <CFSET Postion4 = variables.ShowMo>
    </CFIF>
    <CFIF TRIM(variables.ShowBudg) IS "">
        <CFSET Postion5 = "No">
    <cfelse>
        <CFSET Postion5 = variables.ShowBudg>
    </CFIF>
    <CFIF TRIM(variables.ShowLapse) IS "">
        <CFSET Postion6 = "No">
    <cfelse>
        <CFSET Postion6 = variables.ShowLapse>
    </CFIF>
    <CFIF TRIM(variables.AgcyCatSel) IS "">
        <CFSET Postion7 = "Default">
    <cfelse>
        <CFSET Postion7 = variables.AgcyCatSel>
    </CFIF>
    <CFIF TRIM(variables.AgcySel) IS "">
        <CFSET Postion8 = "Default">
    <cfelse>
        <CFSET Postion8 = variables.AgcySel>
    </CFIF>
    <CFIF TRIM(variables.AgcyGrpSel) IS "">
        <CFSET Postion9 = "Default">
    <cfelse>
        <CFSET Postion9 = variables.AgcyGrpSel>
    </CFIF>
    <CFIF TRIM(variables.AgcyTypeSel) IS "">
        <CFSET Postion10 = "Default">
    <cfelse>
        <CFSET Postion10 = variables.AgcyTypeSel>
    </CFIF>
<!--- Fund --->
    <CFIF TRIM(variables.FundCatSel) IS "">
        <CFSET Postion11 = "Default">
    <cfelse>
        <CFSET Postion11 = variables.FundCatSel>
    </CFIF>
    <CFIF TRIM(variables.FundSel) IS "">
        <CFSET Postion12 = "Default">
    <cfelse>
        <CFSET Postion12 = variables.FundSel>
    </CFIF>
    <CFIF TRIM(variables.FundGrpSel) IS "">
        <CFSET Postion13 = "Default">
    <cfelse>
        <CFSET Postion13 = variables.FundGrpSel>
    </CFIF>
    <CFIF TRIM(variables.FundTypeSel) IS "">
        <CFSET Postion14 = "Default">
    <cfelse>
        <CFSET Postion14 = variables.FundTypeSel>
    </CFIF>
<!--- Revenue --->
    <CFIF TRIM(variables.RevCatSel) IS "">
        <CFSET Postion15 = "Default">
    <cfelse>
        <CFSET Postion15 = variables.RevCatSel>
    </CFIF>
    <CFIF TRIM(variables.RevSel) IS "">
        <CFSET Postion16 = "Default">
    <cfelse>
        <CFSET Postion16 = variables.RevSel>
    </CFIF>
    <CFIF TRIM(variables.RevGrpSel) IS "">
        <CFSET Postion17 = "Default">
    <cfelse>
        <CFSET Postion17 = variables.RevGrpSel>
    </CFIF>
    <CFIF TRIM(variables.RevTypeSel) IS "">
        <CFSET Postion18 = "Default">
    <cfelse>
        <CFSET Postion18 = variables.RevTypeSel>
    </CFIF>
<!--- Obje --->
    <CFIF TRIM(variables.ObjeCatSel) IS "">
        <CFSET Postion19 = "Default">
    <cfelse>
        <CFSET Postion19 = variables.ObjeCatSel>
    </CFIF>
    <CFIF TRIM(variables.ObjeSel) IS "">
        <CFSET Postion20 = "Default">
    <cfelse>
        <CFSET Postion20 = variables.ObjeSel>
    </CFIF>
    <CFIF TRIM(variables.ObjeGrpSel) IS "">
        <CFSET Postion21 = "Default">
    <cfelse>
        <CFSET Postion21 = variables.ObjeGrpSel>
    </CFIF>
    <CFIF TRIM(variables.ObjeTypeSel) IS "">
        <CFSET Postion22 = "Default">
    <cfelse>
        <CFSET Postion22 = variables.ObjeTypeSel>
    </CFIF>
    <CFIF TRIM(variables.ApprCatSel) IS "">
        <CFSET Position23 = "Default">
    <cfelse>
        <CFSET Position23 = variables.ApprCatSel>
    </CFIF>
    <CFIF TRIM(variables.ApprSel) IS "">
        <CFSET Position24 = "Default">
    <cfelse>
        <CFSET Position24 = variables.ApprSel>
    </CFIF>
    <CFIF TRIM(variables.ApprGrpSel) IS "">
        <CFSET Position25 = "Default">
    <cfelse>
        <CFSET Position25 = variables.ApprGrpSel>
    </CFIF>
    <CFIF TRIM(variables.ApprTypeSel) IS "">
        <CFSET Position26 = "Default">
    <cfelse>
        <CFSET Position26 = variables.ApprTypeSel>
    </CFIF>

    <CFIF TRIM(variables.ApprClsSel) IS "">
        <CFSET Position27 = "Default">
    <cfelse>
        <CFSET Position27 = variables.ApprClsSel>
    </CFIF>

    <cfcookie name="ExpenseByAgency" value="#Postion1#,#Postion2#,#Postion3#,#Postion4#,#Postion5#,#Postion6#,#Postion7#,#Postion8#,#Postion9#,#Postion10#,
#Postion11#,#Postion12#,#Postion13#,#Postion14#,#Postion15#,#Postion16#,#Postion17#,#Postion18#,#Postion19#,#Postion20#,#Postion21#,#Postion22#,#Position23#,#Position24#,#Position25#,#Position26#,#Position27#" expires="never">
<!--- CFTRY is used to prevent displaying database errors from incoming URL.GroupBy variables that have been manipulated in the URL string.  The revenues query should be rewritten to prevent this from happening.   --->
    <cftry>

            <cfinvoke component="Queries.expenditures"
                    method="ExpenditureQuery"
                    returnvariable="results"
                    control="Fund"
                    GroupBy="#variables.GroupBy#"
                    Max="20"
                    FY="#variables.FY#"
                    Type="#variables.Type#"
                    ShowBudg="#variables.ShowBudg#"
                    ShowMo="#variables.ShowMo#"
                    ShowLapse="#variables.ShowLapse#"
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
                    ApprSel="#variables.ApprSel#"
                    ApprClsSel="#variables.ApprClsSel#"
                    ApprGrpSel="#variables.ApprGrpSel#"
                    ApprTypeSel="#variables.ApprTypeSel#"
                    ApprCatSel="#variables.ApprCatSel#"
                    ObjeSel="#variables.ObjeSel#"
                    ObjeGrpSel="#variables.ObjeGrpSel#"
                    ObjeTypeSel="#variables.ObjeTypeSel#"
                    ObjeCatSel="#variables.ObjeCatSel#"
                    ObjtSel=""
                    ObjtClsSel=""
                    ObjtGrpSel=""
                    ObjtTypeSel=""
                    ObjtCatSel=""
                    SortName="Code">
            </cfinvoke>
<!--- Get the column headers from the query.  This is used for the table header in the report results below. --->
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

<CFIF IsDefined("cookie.ExpenseByAgency") AND ListLen(cookie.ExpenseByAgency) IS 27>
<!--- Get the clients cookie values and set them as variables  --->
    <CFSET C1_GroupBy = ListGetAt(cookie.ExpenseByAgency, 1)>
    <CFSET C1_FY = ListGetAt(cookie.ExpenseByAgency, 2)>
    <CFSET C1_Type = ListGetAt(cookie.ExpenseByAgency, 3)>
    <CFSET C1_ShowMo = ListGetAt(cookie.ExpenseByAgency, 4)>
    <CFSET C1_Budget = ListGetAt(cookie.ExpenseByAgency, 5)>
    <CFSET C1_Lapse = ListGetAt(cookie.ExpenseByAgency, 6)>
    <CFSET C1_AgcyCatSel = ListGetAt(cookie.ExpenseByAgency, 7)>
    <CFSET C1_AgcySel = ListGetAt(cookie.ExpenseByAgency, 8)>
    <CFSET C1_AgcyGrpSel = ListGetAt(cookie.ExpenseByAgency, 9)>
    <CFSET C1_AgcyTypeSel = ListGetAt(cookie.ExpenseByAgency, 10)>
    <CFSET C1_FundCatSel = ListGetAt(cookie.ExpenseByAgency, 11)>
    <CFSET C1_FundSel = ListGetAt(cookie.ExpenseByAgency, 12)>
    <CFSET C1_FundGrpSel = ListGetAt(cookie.ExpenseByAgency, 13)>
    <CFSET C1_FundTypeSel = ListGetAt(cookie.ExpenseByAgency, 14)>
    <CFSET C1_RevCatSel = ListGetAt(cookie.ExpenseByAgency, 15)>
    <CFSET C1_RevSel = ListGetAt(cookie.ExpenseByAgency, 16)>
    <CFSET C1_RevGrpSel = ListGetAt(cookie.ExpenseByAgency, 17)>
    <CFSET C1_RevTypeSel = ListGetAt(cookie.ExpenseByAgency, 18)>
    <CFSET C1_ObjeCatSel = ListGetAt(cookie.ExpenseByAgency, 19)>
    <CFSET C1_ObjeSel = ListGetAt(cookie.ExpenseByAgency, 20)>
    <CFSET C1_ObjeGrpSel = ListGetAt(cookie.ExpenseByAgency, 21)>
    <CFSET C1_ObjeTypeSel = ListGetAt(cookie.ExpenseByAgency, 22)>
    <CFSET C1_ApprCatSel = ListGetAt(cookie.ExpenseByAgency, 23)>
    <CFSET C1_ApprSel = ListGetAt(cookie.ExpenseByAgency, 24)>
    <CFSET C1_ApprGrpSel = ListGetAt(cookie.ExpenseByAgency, 25)>
    <CFSET C1_ApprTypeSel = ListGetAt(cookie.ExpenseByAgency, 26)>
    <CFSET C1_ApprClsSel = ListGetAt(cookie.ExpenseByAgency, 27)>
<!--- Get Friend Names from the cookie values. --->
        <cfinvoke component="Queries.expenditures"
                method="GetFreindlyName_Expense_ByAgency"
                returnvariable="FN1">
        </cfinvoke>
</CFIF>

<cfoutput>
    <div id="agency">
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
            <p>Agencies are established by the General Assembly to administer the various functions of state  government.</p>
        <cfelseif IsDefined("cookie.ExpenseByAgency") AND ListLen(cookie.ExpenseByAgency) IS 27>
        <div id="4" style="display:block">
        <cfsaveContent variable="headString">
            <div class="row">
            <div class="col-md-9 col-md-offset-3">
            <p>Expenditures by: #FN1.val1#</p>
        </div>
        </div>
        <div class="row">
        <div class="col-md-3 col-md-offset-3">
        <p>Fiscal Year:
            <CFIF C1_FY LTE 60>20#C1_FY#
            <cfelse>19#C1_FY#<br></CFIF>
            <CFIF C1_Type IS NOT "Default" AND C1_Type IS NOT "">
                    Type: #FN1.val3#
            </CFIF></p>
            <CFIF C1_ShowMo IS NOT "Default" AND C1_ShowMo IS NOT "">
                    <p>Show Monthly: #FN1.val4#</p>
            </CFIF>
            <CFIF C1_Budget IS NOT "Default" AND C1_Budget IS NOT "">
                    <p>Show Budget: #FN1.val5#</p>
            </CFIF>
            <CFIF C1_Lapse IS NOT "Default" AND C1_Lapse IS NOT "">
                    <p>Show Lapse: #FN1.val6#</p>
            </CFIF>
            <CFIF C1_AgcyCatSel IS NOT "Default" AND C1_AgcyCatSel IS NOT "">
                    <p>Agency Category: #FN1.val7#</p>
            </CFIF>
            <CFIF C1_AgcySel IS NOT "Default" AND C1_AgcySel IS NOT "">
                    <p>Agency: #FN1.val8#</p>
            </CFIF>
            <CFIF C1_AgcyGrpSel IS NOT "Default" AND C1_AgcyGrpSel IS NOT "">
                    <p>Agency Group: #FN1.val9#</p>
            </CFIF>
            <CFIF C1_AgcyTypeSel IS NOT "Default" AND C1_AgcyTypeSel IS NOT "">
                    <p>Agency Type: #FN1.val10#</p>
            </CFIF>

            <CFIF FN1.val11 IS NOT "Default" AND FN1.val11 IS NOT "">
                    <p>Fund Category: #FN1.val11#<BR/>
            </CFIF>
            <p><CFIF FN1.val12 IS NOT "Default" AND FN1.val12 IS NOT "">
                    Fund: #FN1.val12#<BR/>
            </CFIF>
            <CFIF FN1.val13 IS NOT "Default" AND FN1.val13 IS NOT "">
                    Fund Group: #FN1.val13#<BR/>
            </CFIF>
            <CFIF FN1.val14 IS NOT "Default" AND FN1.val14 IS NOT "">
                    Fund Type: #FN1.val14#<BR/>
            </CFIF>
            <CFIF FN1.val15 IS NOT "Default" AND FN1.val15 IS NOT "">
                    Revenue Category: #FN1.val15#<BR/>
            </CFIF>
            <CFIF FN1.val16 IS NOT "Default" AND FN1.val16 IS NOT "">
                    Revenue: #FN1.val16#<BR/>
            </CFIF>
            <CFIF FN1.val17 IS NOT "Default" AND FN1.val17 IS NOT "">
                    Revenue Group: #FN1.val17#<BR/>
            </CFIF>
            <CFIF FN1.val18 IS NOT "Default" AND FN1.val18 IS NOT "">
                    Revenue Type: #FN1.val18#<BR/>
            </CFIF>
            <CFIF C1_ObjeCatSel IS NOT "Default" AND C1_ObjeCatSel IS NOT "">
                    Object Category: #FN1.val19#<BR/>
            </CFIF>
            <CFIF C1_ObjeSel IS NOT "Default" AND TRIM(FN1.val20) IS NOT "">
                    Object: #FN1.val20#<BR/>
            </CFIF>
            <CFIF C1_ObjeGrpSel IS NOT "Default" AND C1_ObjeGrpSel IS NOT "">
                    Object Group: #FN1.val21#<BR/>
            </CFIF>
            <CFIF C1_ObjeTypeSel IS NOT "Default" AND C1_ObjeTypeSel IS NOT "">
                    Object Type: #FN1.val22#<BR/>
            </CFIF>
            <CFIF C1_ApprCatSel IS NOT "Default" AND C1_ApprCatSel IS NOT "">
                    Appropration Category: #FN1.val23#<BR/>
            </CFIF>
            <CFIF C1_ApprSel IS NOT "Default" AND C1_ApprSel IS NOT "">
                    Appropration: #FN1.val24#<BR/>
            </CFIF>
            <CFIF C1_ApprGrpSel IS NOT "Default" AND C1_ApprGrpSel IS NOT "">
                    Appropration Group: #FN1.val25#<BR/>
            </CFIF>
            <CFIF C1_ApprTypeSel IS NOT "Default" AND C1_ApprTypeSel IS NOT "">
                    Appropration Type: #FN1.val26#<BR/>
            </CFIF>
            <CFIF C1_ApprClsSel IS NOT "Default" AND C1_ApprClsSel IS NOT "">
                    Appropration Type: #FN1.val27#
            </CFIF></p>

            </div>

        </cfsaveContent>
        #headString#
        <div class="col-md-5 pull-left">
<!--- Display Adobe PDF Download for results --->
        <CFIF IsDefined("Results")>
                <div id="3" style="display:block;">
                <p><a href="?GroupBy=#C1_GroupBy#&FY=#C1_FY#&ShowMo=#C1_ShowMo#&ShowBudg=#C1_Budget#&ShowLapse=#C1_Lapse#&FundSel=#C1_FundSel#&FundGrpSel=#C1_FundGrpSel#&FundCatSel=#C1_FundCatSel#&FundTypeSel=#C1_FundTypeSel#&AgcySel=#C1_AgcySel#&AgcyGrpSel=#C1_AgcyGrpSel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&RevSel=#C1_RevSel#&RevCatSel=#C1_RevCatSel#&RevGrpSel=#C1_RevGrpSel#&RevTypeSel=#C1_RevTypeSel#&Type=#C1_Type#&ObjeSel=#C1_ObjeSel#&ObjeGrpSel=#C1_ObjeGrpSel#&ObjeCatSel=#C1_ObjeCatSel#&ObjeTypeSel=#C1_ObjeTypeSel#&ApprSel=#C1_ApprSel#&ApprGrpSel=#C1_ApprGrpSel#&ApprTypeSel=#C1_ApprTypeSel#&ApprCatSel=#C1_ApprCatSel#&ApprClsSel=#C1_ApprClsSel#&PrintAsPDF=true">
                    <img alt="PDF_FILE" src="#$.siteconfig('themeassetpath')#/images/AdobeAcrobat.png" /></a></p>
            </div>
        </CFIF>
        </div>
        </div>
        </div>
            <div id="5" style="display:none;">
                <p>Agencies are established by the General Assembly to administer the various functions of state
                    government.</p>
            </div>
    </CFIF>

    <cfform method="get" enctype="application/x-www-form-urlencoded" preloader="no" id="searchform">
            <div id="101" style="display:#HideSwitch1#">
        <div class="row">
            <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                <div class="btn-label">Select an Agency</div>
            </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
        <select name="AgcySel" class="select2">
            <option value="0" selected="selected">Select an Agency</option>
            <option value="">All</option>
            <Cfloop query="agencyList">
                    <option value="#Agency#">#Agency# - #Name#</option>
            </Cfloop>
            </select>
            </div>
            </div>

            <div class="row">
                <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                    <div class="btn-label">Group</div>
                </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
            <select name="AgcyGrpSel" class="select2">
                <option value="0" selected="selected">Select a Group</option>
                <option value="">All</option>
                <cfloop query="agencyGroupList">
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
            <select name="AgcyCatSel" class="select2">
                <option value="0" selected="selected">Select a Category</option>
                <option value="">All</option>
            <Cfloop query="agencyCatList">
                    <option value="#Category#">#Category# - #Name#</option>
            </Cfloop>
            </select>
            </div>
            </div>

            <div class="row">
                <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                    <div class="btn-label">Type</div>
                </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
            <select name="AgcyTypeSel" class="select2">
                <option value="0" selected="selected">Type</option>
                <option value="0">All</option>
            <Cfloop query="agencyTypeList">
                    <option value="#Type#">#Type# - #Name#</option>
            </Cfloop>
            </select>
            </div>
            </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">Group By</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <select name="GroupBy" class="select2">
                            <option value="None">None</option>
                            <option value="Agcy">Agency</option>
                            <option value="AgcyCat">Agency Category</option>
                            <option value="AgcyGrp">Agency Group</option>
                            <option value="AgcyType">Agency Type</option>
                            <option value="ApprCat">Appropriation Category</option>
                            <option value="ApprCls">Appropriation Class</option>
                            <option value="ApprGrp">Appropriation Group</option>
                            <option value="ApprType">Appropriation Type</option>
                            <option value="Fund">Fund</option>
                            <option value="FundCat">Fund Category</option>
                            <option value="FundGrp">Fund Group</option>
                            <option value="FundType">Fund Type</option>
                            <option value="Obje" selected="selected">Group By Object of Expenditure</option>
                            <option value="Objt">Object</option>
                            <option value="ObjtCat">Object Category</option>
                            <option value="ObjtGrp">Object Group</option>
                            <option value="ObjtType">Object Type</option>
                        </select>
                    </div>
                </div>

            <div class="row">
                <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                    <div class="btn-label">Fiscal Year</div>
                </div>

            <div class="col-xs-12 col-sm-7 col-md-5">
            <select name="FY" class="select2">
<!--- <option value="0" selected="selected">Fiscal Year</option> --->
            <Cfloop index="i" list="#FYList#">
                    <option value="#Right(i, 2)#"><CFIF application.cfy IS Right(i, 2)>Fiscal Year </CFIF>#i#</option>
            </Cfloop>
            </select>
            </div>
            </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">Type of Spending</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <select name="Type" class="select2">
                            <option value="B">Type of Spending</option>
                            <option value="A" selected="selected">Appropriated Only</option>
                            <option value="N">Non-Appropriated Only</option>
                            <option value="B">Both</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">View Monthly Amounts</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input id="ShowMo" name="ShowMo" type="checkbox" value="Yes"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">View Budget Amounts</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input id="ShowBudg" name="ShowBudg" type="checkbox" value="Yes"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">View Lapse Amounts</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input id="ShowLapse" name="ShowLapse" type="checkbox" value="Yes"/>
                    </div>
                </div>

                <div class="text-center">
                    <button class="btn btn-primary" name="submitted" type="submit" onclick="return SwitchOn();">Submit
                    </button>
                </div>

            </div>
    </cfform>

    </div>

    </div>
<!--- Search Again button --->
        <div class="show">
                <div class="text-center" id="100" style="display:#HideSwitch2#">
            <a href="##" onclick="return SwitchOff();" class="btn btn-success">Search Again</a>
    </div>
    </div>

    <cfif IsDefined("results")>
        <cfset numberOfColumns = listlen(ArrayToList(Results.getColumnNames()))/>
            <div class="show">

<!--- ******************************************************************************************** --->
<!--- ******************************************************************************************** --->
<!---                               Results below                                                  --->
<!--- ******************************************************************************************** --->
<!--- ******************************************************************************************** --->
            <CFIF IsDefined("form.PrintAsPDF")>
                <cfsaveContent variable="returnString">
                    <cfinclude template="outputs/byAgency1.cfm">
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
                    <div id="2" style="width: 98%; margin: 30px auto;display:block">
                    <cfinclude template="outputs/byAgency1.cfm">
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
<!--- 	<img alt="" src="#$.siteconfig('themeassetpath')#/images/CW_AlertIcon.jpg" /> --->
                <BR/><p>No records found. Please use different search criteria.</p>
            </div>
    </CFIF>


<!--- Display Last search results if cookie exists --->
    <CFIF Not IsDefined("results") AND IsDefined("cookie.ExpenseByAgency") AND ListLen(cookie.ExpenseByAgency) IS 27>


            <a href="?GroupBy=#C1_GroupBy#&FY=#C1_FY#&ShowMo=#C1_ShowMo#&ShowBudg=#C1_Budget#&ShowLapse=#C1_Lapse#&FundSel=#C1_FundSel#&FundGrpSel=#C1_FundGrpSel#&FundCatSel=#C1_FundCatSel#&FundTypeSel=#C1_FundTypeSel#&AgcySel=#C1_AgcySel#&AgcyGrpSel=#C1_AgcyGrpSel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&RevSel=#C1_RevSel#&RevCatSel=#C1_RevCatSel#&RevGrpSel=#C1_RevGrpSel#&RevTypeSel=#C1_RevTypeSel#&Type=#C1_Type#&ObjeSel=#C1_ObjeSel#&ObjeGrpSel=#C1_ObjeGrpSel#&ObjeCatSel=#C1_ObjeCatSel#&ObjeTypeSel=#C1_ObjeTypeSel#&ApprSel=#C1_ApprSel#&ApprGrpSel=#C1_ApprGrpSel#&ApprTypeSel=#C1_ApprTypeSel#&ApprCatSel=#C1_ApprCatSel#&ApprClsSel=#C1_ApprClsSel#">
        <div class="row">
        <div class="col-sm-offset-1 col-sm-10">
        <div class="lastsearch">
            <h2>Last Search</h2>

        <ul>
            <CFIF C1_GroupBy IS NOT "Default" AND C1_GroupBy IS NOT "">
                    <li>Group By: #FN1.val1#</li>
            </CFIF>
            <CFIF C1_FY IS NOT "Default" AND C1_FY IS NOT "">
                    <li>Fiscal Year: #FN1.val2#</li>
            </cfif>
            <CFIF C1_Type IS NOT "Default" AND C1_Type IS NOT "">
                    <li>Type: #FN1.val3#</li>
            </CFIF>
            <CFIF C1_ShowMo IS NOT "Default" AND C1_ShowMo IS NOT "">
                    <li>Show Monthly: #FN1.val4#</li>
            </CFIF>
            <CFIF C1_Budget IS NOT "Default" AND C1_Budget IS NOT "">
                    <li>Show Budget: #FN1.val5#</li>
            </CFIF>
            <CFIF C1_Lapse IS NOT "Default" AND C1_Lapse IS NOT "">
                    <li>Show Lapse: #FN1.val6#</li>
            </CFIF>
            <CFIF C1_AgcyCatSel IS NOT "Default" AND C1_AgcyCatSel IS NOT "">
                    <li>Agency Category: #FN1.val7#</li>
            </CFIF>
            <CFIF C1_AgcySel IS NOT "Default" AND C1_AgcySel IS NOT "">
                    <li>Agency: #FN1.val8#</li>
            </CFIF>
            <CFIF C1_AgcyGrpSel IS NOT "Default" AND C1_AgcyGrpSel IS NOT "">
                    <li>Agency Group: #FN1.val9#</li>
            </CFIF>
            <CFIF C1_AgcyTypeSel IS NOT "Default" AND C1_AgcyTypeSel IS NOT "">
                    <li>Agency Type: #FN1.val10#</li>
            </CFIF>

            <CFIF FN1.val11 IS NOT "Default" AND FN1.val11 IS NOT "">
                    Fund Category: #FN1.val11#<BR/>
            </CFIF>
            <CFIF FN1.val12 IS NOT "Default" AND FN1.val12 IS NOT "">
                    Fund: #FN1.val12#<BR/>
            </CFIF>
            <CFIF FN1.val13 IS NOT "Default" AND FN1.val13 IS NOT "">
                    Fund Group: #FN1.val13#<BR/>
            </CFIF>
            <CFIF FN1.val14 IS NOT "Default" AND FN1.val14 IS NOT "">
                    Fund Type: #FN1.val14#<BR/>
            </CFIF>
            <CFIF FN1.val15 IS NOT "Default" AND FN1.val15 IS NOT "">
                    Revenue Category: #FN1.val15#<BR/>
            </CFIF>
            <CFIF FN1.val16 IS NOT "Default" AND FN1.val16 IS NOT "">
                    Revenue: #FN1.val16#<BR/>
            </CFIF>
            <CFIF FN1.val17 IS NOT "Default" AND FN1.val17 IS NOT "">
                    Revenue Group: #FN1.val17#<BR/>
            </CFIF>
            <CFIF FN1.val18 IS NOT "Default" AND FN1.val18 IS NOT "">
                    Revenue Type: #FN1.val18#<BR/>
            </CFIF>
            <CFIF C1_ObjeCatSel IS NOT "Default" AND C1_ObjeCatSel IS NOT "">
                    Object Category: #FN1.val19#<BR/>
            </CFIF>
            <CFIF C1_ObjeSel IS NOT "Default" AND TRIM(FN1.val20) IS NOT "">
                    Object: #FN1.val20#<BR/>
            </CFIF>
            <CFIF C1_ObjeGrpSel IS NOT "Default" AND C1_ObjeGrpSel IS NOT "">
                    Object Group: #FN1.val21#<BR/>
            </CFIF>
            <CFIF C1_ObjeTypeSel IS NOT "Default" AND C1_ObjeTypeSel IS NOT "">
                    Object Type: #FN1.val22#<BR/>
            </CFIF>
            <CFIF C1_ApprCatSel IS NOT "Default" AND C1_ApprCatSel IS NOT "">
                    <li>Appropriation Category: #FN1.val23#</li>
            </CFIF>
            <CFIF C1_ApprSel IS NOT "Default" AND C1_ApprSel IS NOT "">
                    <li>Appropriation: #FN1.val24#</li>
            </CFIF>
            <CFIF C1_ApprGrpSel IS NOT "Default" AND C1_ApprGrpSel IS NOT "">
                    <li>Appropriation Group: #FN1.val25#</li>
            </CFIF>
            <CFIF C1_ApprTypeSel IS NOT "Default" AND C1_ApprTypeSel IS NOT "">
                    <li>Appropriation Type: #FN1.val26#</li>
            </CFIF>
            <CFIF C1_ApprTypeSel IS NOT "Default" AND C1_ApprTypeSel IS NOT "">
                    <li>Appropriation Class: #FN1.val27#</li>
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
    </script>
