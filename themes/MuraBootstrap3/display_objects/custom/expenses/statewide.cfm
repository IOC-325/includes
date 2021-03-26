<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css"/>
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/jquery.dataTables1.10.20.min.css" rel="stylesheet" type="text/css">
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/fixedColumns.dataTables3.3.0.min.css" rel="stylesheet" type="text/css">
<!---<link href="/comptroller/includes/themes/MuraBootstrap3/assets/datatable/css/jquery.dataTables.min.css" rel="stylesheet"  type="text/css">--->
<cfparam name="DisableHyperLink" default="no">
<cfparam name="OutGoingGroupBy" default="None">
<CFPARAM NAME="variables.ShowMo" DEFAULT="No">
<cfif isDefined("form.submit")>
    <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
    <CFSET form.Submitted = true>
    <cfif form.Type eq 0>
        <cfset variables.Type = "A">
    <cfelse>
        <cfset variables.Type = form.Type>
    </cfif>
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
        <cfset variables.Type = TRIM(URLDecode(form.Type, 'utf-8'))>
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
    <cfif IsDefined("form.ApprSel") AND TRIM(form.ApprSel) IS NOT "" AND form.ApprSel IS NOT 0 AND TRIM(form.ApprSel) IS NOT "Default">
        <cfset variables.ApprSel = TRIM(form.ApprSel)>
    <cfelse>
        <cfset variables.ApprSel = "">
    </cfif>

    <cfif IsDefined("form.ApprClsSel") AND TRIM(form.ApprClsSel) IS NOT "" AND form.ApprClsSel IS NOT 0 AND TRIM(form.ApprClsSel) IS NOT "Default">
        <cfset variables.ApprClsSel = TRIM(form.ApprClsSel)>
    <cfelse>
        <cfset variables.ApprClsSel = "">
    </cfif>

    <cfif IsDefined("form.ApprGrpSel") AND TRIM(form.ApprGrpSel) IS NOT "" AND form.ApprGrpSel IS NOT 0 AND TRIM(form.ApprGrpSel) IS NOT "Default">
        <cfset variables.ApprGrpSel = TRIM(form.ApprGrpSel)>
    <cfelse>
        <cfset variables.ApprGrpSel = "">
    </cfif>

    <cfif IsDefined("form.ApprTypeSel") AND TRIM(form.ApprTypeSel) IS NOT "" AND form.ApprTypeSel IS NOT 0 AND TRIM(form.ApprTypeSel) IS NOT "Default">
        <cfset variables.ApprTypeSel = TRIM(form.ApprTypeSel)>
    <cfelse>
        <cfset variables.ApprTypeSel = "">
    </cfif>

    <cfif IsDefined("form.ApprCatSel") AND TRIM(form.ApprCatSel) IS NOT "" AND form.ApprCatSel IS NOT 0 AND form.ApprCatSel IS NOT "Default">
        <cfset variables.ApprCatSel = TRIM(form.ApprCatSel)>
    <cfelse>
        <cfset variables.ApprCatSel = "">
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

    <cfif IsDefined("form.ObjeCatSel") AND TRIM(form.ObjeCatSel) IS NOT "" AND form.ObjeCatSel IS NOT 0 AND form.ObjeCatSel IS NOT "Default">
        <cfset variables.ObjeCatSel = TRIM(form.ObjeCatSel)>
    <cfelse>
        <cfset variables.ObjeCatSel = "">
    </cfif>
    <cfif IsDefined("form.ObjtSel") AND TRIM(form.ObjtSel) IS NOT "" AND form.ObjtSel IS NOT 0 AND TRIM(form.ObjtSel) IS NOT "Default">
        <cfset variables.ObjtSel = TRIM(form.ObjtSel)>
    <cfelse>
        <cfset variables.ObjtSel = "">
    </cfif>

    <cfif IsDefined("form.ObjtClsSel") AND TRIM(form.ObjtClsSel) IS NOT "" AND form.ObjtClsSel IS NOT 0 AND TRIM(form.ObjtClsSel) IS NOT "Default">
        <cfset variables.ObjtClsSel = TRIM(form.ObjtClsSel)>
    <cfelse>
        <cfset variables.ObjtClsSel = "">
    </cfif>

    <cfif IsDefined("form.ObjtGrpSel") AND TRIM(form.ObjtGrpSel) IS NOT "" AND form.ObjtGrpSel IS NOT 0 AND TRIM(form.ObjtGrpSel) IS NOT "Default">
        <cfset variables.ObjtGrpSel = TRIM(form.ObjtGrpSel)>
    <cfelse>
        <cfset variables.ObjtGrpSel = "">
    </cfif>

    <cfif IsDefined("form.ObjtTypeSel") AND TRIM(form.ObjtTypeSel) IS NOT "" AND form.ObjtTypeSel IS NOT 0 AND TRIM(form.ObjtTypeSel) IS NOT "Default">
        <cfset variables.ObjtTypeSel = TRIM(form.ObjtTypeSel)>
    <cfelse>
        <cfset variables.ObjtTypeSel = "">
    </cfif>

    <cfif IsDefined("form.ObjtCatSel") AND TRIM(form.ObjtCatSel) IS NOT "" AND form.ObjtCatSel IS NOT 0 AND form.ObjtCatSel IS NOT "Default">
        <cfset variables.ObjtCatSel = TRIM(form.ObjtCatSel)>
    <cfelse>
        <cfset variables.ObjtCatSel = "">
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

    <cfif IsDefined("url.ApprSel") AND TRIM(url.ApprSel) IS NOT "" AND URL.ApprSel IS NOT 0 AND TRIM(url.ApprSel) IS NOT "Default">
        <cfset variables.ApprSel = TRIM(URLDecode(URL.ApprSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ApprSel = "">
    </cfif>

    <cfif IsDefined("url.ApprClsSel") AND TRIM(url.ApprClsSel) IS NOT "" AND URL.ApprClsSel IS NOT 0 AND TRIM(url.ApprClsSel) IS NOT "Default">
        <cfset variables.ApprClsSel = TRIM(URLDecode(URL.ApprClsSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ApprClsSel = "">
    </cfif>

    <cfif IsDefined("url.ApprGrpSel") AND TRIM(url.ApprGrpSel) IS NOT "" AND URL.ApprGrpSel IS NOT 0 AND TRIM(url.ApprGrpSel) IS NOT "Default">
        <cfset variables.ApprGrpSel = TRIM(URLDecode(URL.ApprGrpSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ApprGrpSel = "">
    </cfif>
    <cfif IsDefined("url.ApprTypeSel") AND TRIM(url.ApprTypeSel) IS NOT "" AND URL.ApprTypeSel IS NOT 0 AND TRIM(url.ApprTypeSel) IS NOT "Default">
        <cfset variables.ApprTypeSel = TRIM(URLDecode(URL.ApprTypeSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ApprTypeSel = "">
    </cfif>

    <cfif IsDefined("url.ApprCatSel") AND TRIM(url.ApprCatSel) IS NOT "" AND URL.ApprCatSel IS NOT 0 AND URL.ApprCatSel IS NOT "Default">
        <cfset variables.ApprCatSel = TRIM(URLDecode(URL.ApprCatSel, 'utf-8'))>
    <cfelse>
        <cfset variables.ApprCatSel = "">
    </cfif>

<!--- Obje --->
    <cfif IsDefined("url.ObjeSel") AND TRIM(url.ObjeSel) IS NOT "" AND url.ObjeSel IS NOT 0 AND TRIM(url.ObjeSel) IS NOT "Default">
        <cfset variables.ObjeSel = TRIM(url.ObjeSel)>
    <cfelse>
        <cfset variables.ObjeSel = "">
    </cfif>

    <cfif IsDefined("url.ObjeClsSel") AND TRIM(url.ObjeClsSel) IS NOT "" AND url.ObjeClsSel IS NOT 0 AND TRIM(url.ObjeClsSel) IS NOT "Default">
        <cfset variables.ObjeClsSel = TRIM(url.ObjeClsSel)>
    <cfelse>
        <cfset variables.ObjeClsSel = "">
    </cfif>

    <cfif IsDefined("url.ObjeGrpSel") AND TRIM(url.ObjeGrpSel) IS NOT "" AND url.ObjeGrpSel IS NOT 0 AND TRIM(url.ObjeGrpSel) IS NOT "Default">
        <cfset variables.ObjeGrpSel = TRIM(url.ObjeGrpSel)>
    <cfelse>
        <cfset variables.ObjeGrpSel = "">
    </cfif>

    <cfif IsDefined("url.ObjeTypeSel") AND TRIM(url.ObjeTypeSel) IS NOT "" AND url.ObjeTypeSel IS NOT 0 AND TRIM(url.ObjeTypeSel) IS NOT "Default">
        <cfset variables.ObjeTypeSel = TRIM(url.ObjeTypeSel)>
    <cfelse>
        <cfset variables.ObjeTypeSel = "">
    </cfif>

    <cfif IsDefined("url.ObjeCatSel") AND TRIM(url.ObjeCatSel) IS NOT "" AND url.ObjeCatSel IS NOT 0 AND url.ObjeCatSel IS NOT "Default">
        <cfset variables.ObjeCatSel = TRIM(url.ObjeCatSel)>
    <cfelse>
        <cfset variables.ObjeCatSel = "">
    </cfif>
    <cfif IsDefined("url.ObjtSel") AND TRIM(url.ObjtSel) IS NOT "" AND url.ObjtSel IS NOT 0 AND TRIM(url.ObjtSel) IS NOT "Default">
        <cfset variables.ObjtSel = TRIM(url.ObjtSel)>
    <cfelse>
        <cfset variables.ObjtSel = "">
    </cfif>

    <cfif IsDefined("url.ObjtClsSel") AND TRIM(url.ObjtClsSel) IS NOT "" AND url.ObjtClsSel IS NOT 0 AND TRIM(url.ObjtClsSel) IS NOT "Default">
        <cfset variables.ObjtClsSel = TRIM(url.ObjtClsSel)>
    <cfelse>
        <cfset variables.ObjtClsSel = "">
    </cfif>

    <cfif IsDefined("url.ObjtGrpSel") AND TRIM(url.ObjtGrpSel) IS NOT "" AND url.ObjtGrpSel IS NOT 0 AND TRIM(url.ObjtGrpSel) IS NOT "Default">
        <cfset variables.ObjtGrpSel = TRIM(url.ObjtGrpSel)>
    <cfelse>
        <cfset variables.ObjtGrpSel = "">
    </cfif>

    <cfif IsDefined("url.ObjtTypeSel") AND TRIM(url.ObjtTypeSel) IS NOT "" AND url.ObjtTypeSel IS NOT 0 AND TRIM(url.ObjtTypeSel) IS NOT "Default">
        <cfset variables.ObjtTypeSel = TRIM(url.ObjtTypeSel)>
    <cfelse>
        <cfset variables.ObjtTypeSel = "">
    </cfif>

    <cfif IsDefined("url.ObjtCatSel") AND TRIM(url.ObjtCatSel) IS NOT "" AND url.ObjtCatSel IS NOT 0 AND url.ObjtCatSel IS NOT "Default">
        <cfset variables.ObjtCatSel = TRIM(url.ObjtCatSel)>
    <cfelse>
        <cfset variables.ObjtCatSel = "">
    </cfif>

    <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
    <CFIF IsDefined("URL.PrintAsPDF")>
        <CFSET form.PrintAsPDF = true>
    </CFIF>

    <CFSET form.Submitted = true>
<cfelse>
    <cfset variables.GroupBy = "Fund">
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
    <CFSET variables.ApprSel = "">
    <CFSET variables.ApprGrpSel = "">
    <CFSET variables.ApprTypeSel = "">
    <CFSET variables.ApprCatSel = "">
    <CFSET variables.ObjtSel = "">
    <CFSET variables.ObjtGrpSel = "">
    <CFSET variables.ObjtTypeSel = "">
    <CFSET variables.ObjtCatSel = "">
    <CFSET variables.ObjeSel = "">
    <CFSET variables.ObjeGrpSel = "">
    <CFSET variables.ObjeTypeSel = "">
    <CFSET variables.ObjeCatSel = "">

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
        <CFSET OutGoingGroupBy = "Fund">
        <CFSET DisableHyperLink = "No">
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
        <CFSET DisableHyperLink = "No">
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
    23) Appr Category
    24) Appr
    25) Appr Group
    26) Appr Type
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
<!--- Fund --->
    <CFIF TRIM(variables.FundCatSel) IS "">
        <CFSET Postion7 = "Default">
    <cfelse>
        <CFSET Postion7 = variables.FundCatSel>
    </CFIF>
    <CFIF TRIM(variables.FundSel) IS "">
        <CFSET Postion8 = "Default">
    <cfelse>
        <CFSET Postion8 = variables.FundSel>
    </CFIF>
    <CFIF TRIM(variables.FundGrpSel) IS "">
        <CFSET Postion9 = "Default">
    <cfelse>
        <CFSET Postion9 = variables.FundGrpSel>
    </CFIF>
    <CFIF TRIM(variables.FundTypeSel) IS "">
        <CFSET Postion10 = "Default">
    <cfelse>
        <CFSET Postion10 = variables.FundTypeSel>
    </CFIF>
<!--- Revenue --->
    <CFIF TRIM(variables.RevCatSel) IS "">
        <CFSET Postion11 = "Default">
    <cfelse>
        <CFSET Postion11 = variables.RevCatSel>
    </CFIF>
    <CFIF TRIM(variables.RevSel) IS "">
        <CFSET Postion12 = "Default">
    <cfelse>
        <CFSET Postion12 = variables.RevSel>
    </CFIF>
    <CFIF TRIM(variables.RevGrpSel) IS "">
        <CFSET Postion13 = "Default">
    <cfelse>
        <CFSET Postion13 = variables.RevGrpSel>
    </CFIF>
    <CFIF TRIM(variables.RevTypeSel) IS "">
        <CFSET Postion14 = "Default">
    <cfelse>
        <CFSET Postion14 = variables.RevTypeSel>
    </CFIF>
    <CFIF TRIM(variables.RevClsSel) IS "">
        <CFSET Postion15 = "Default">
    <cfelse>
        <CFSET Postion15 = variables.RevClsSel>
    </CFIF>
<!--- Agency --->

    <CFIF TRIM(variables.AgcyCatSel) IS "">
        <CFSET Postion16 = "Default">
    <cfelse>
        <CFSET Postion16 = variables.AgcyCatSel>
    </CFIF>
    <CFIF TRIM(variables.AgcySel) IS "">
        <CFSET Postion17 = "Default">
    <cfelse>
        <CFSET Postion17 = variables.AgcySel>
    </CFIF>
    <CFIF TRIM(variables.AgcyGrpSel) IS "">
        <CFSET Postion18 = "Default">
    <cfelse>
        <CFSET Postion18 = variables.AgcyGrpSel>
    </CFIF>
    <CFIF TRIM(variables.AgcyTypeSel) IS "">
        <CFSET Postion19 = "Default">
    <cfelse>
        <CFSET Postion19 = variables.AgcyTypeSel>
    </CFIF>
<!--- Obje --->
    <CFIF TRIM(variables.ObjeCatSel) IS "">
        <CFSET Postion20 = "Default">
    <cfelse>
        <CFSET Postion20 = variables.ObjeCatSel>
    </CFIF>
    <CFIF TRIM(variables.ObjeSel) IS "">
        <CFSET Postion21 = "Default">
    <cfelse>
        <CFSET Postion21 = variables.ObjeSel>
    </CFIF>
    <CFIF TRIM(variables.ObjeGrpSel) IS "">
        <CFSET Postion22 = "Default">
    <cfelse>
        <CFSET Postion22 = variables.ObjeGrpSel>
    </CFIF>
    <CFIF TRIM(variables.ObjeTypeSel) IS "">
        <CFSET Postion23 = "Default">
    <cfelse>
        <CFSET Postion23 = variables.ObjeTypeSel>
    </CFIF>
<!--- Appropriation --->
    <CFIF TRIM(variables.ApprGrpSel) IS "">
        <CFSET Postion24 = "Default">
    <cfelse>
        <CFSET Postion24 = variables.ApprGrpSel>
    </CFIF>
    <CFIF TRIM(variables.ApprCatSel) IS "">
        <CFSET Postion25 = "Default">
    <cfelse>
        <CFSET Postion25 = variables.ApprCatSel>
    </CFIF>
    <CFIF TRIM(variables.ApprTypeSel) IS "">
        <CFSET Postion26 = "Default">
    <cfelse>
        <CFSET Postion26 = variables.ApprTypeSel>
    </CFIF>
    <CFIF TRIM(variables.ApprClsSel) IS "">
        <CFSET Postion27 = "Default">
    <cfelse>
        <CFSET Postion27 = variables.ApprClsSel>
    </CFIF>

    <cfcookie name="ExpenseStatewide" value="#Postion1#,#Postion2#,#Postion3#,#Postion4#,#Postion5#,#Postion6#,#Postion7#,#Postion8#,#Postion9#,#Postion10#,#Postion11#,#Postion12#,#Postion13#,#Postion14#,#Postion15#,#Postion16#,#Postion17#,#Postion18#,#Postion19#,#Postion20#,#Postion21#,#Postion22#,#Postion23#,#Postion24#,#Postion25#,#Postion26#,#Postion27#" expires="never">

<!--- <cftry>  --->
        <cfinvoke component="Queries.expenditures"
                method="ExpenditureQuery"
                returnvariable="results"
                control="State"
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
                ObjtSel="#variables.ObjtSel#"
                ObjtClsSel="#variables.ObjtClsSel#"
                ObjtGrpSel="#variables.ObjtGrpSel#"
                ObjtTypeSel="#variables.ObjtTypeSel#"
                ObjtCatSel="#variables.ObjtCatSel#"
                SortName="Code">
        </cfinvoke>
<!--- Get the column headers from the query.  This is used for the table header in the report results below. --->
    <cfset ColumnNames = ArrayToList(Results.getColumnNames())/>

<!---  <cfcatch type="any">
		<CFSET ColumnNames = "Error">
        <!--- Catch any errors whereas the incoming input values caused a DB2 crash --->
        <CFSET Error = "1">
    </cfcatch>
   </cftry>  --->
</cfif>

<!--- get Fiscal Years --->
<cfinvoke component="Queries.warehouse"
        method="getFYs"
        returnvariable="FYList">
        <cfinvokeargument name="numFYs" value="5"/>
</cfinvoke>

<CFIF IsDefined("cookie.ExpenseStatewide") AND ListLen(cookie.ExpenseStatewide) IS 27>
<!--- Get the clients cookie values and set them as variables  --->
    <CFSET C1_GroupBy = ListGetAt(cookie.ExpenseStatewide, 1)>
    <CFSET C1_FY = ListGetAt(cookie.ExpenseStatewide, 2)>
    <CFSET C1_Type = ListGetAt(cookie.ExpenseStatewide, 3)>
    <CFSET C1_ShowMo = ListGetAt(cookie.ExpenseStatewide, 4)>
    <CFSET C1_Budget = ListGetAt(cookie.ExpenseStatewide, 5)>
    <CFSET C1_Lapse = ListGetAt(cookie.ExpenseStatewide, 6)>
    <CFSET C1_FundCatSel = ListGetAt(cookie.ExpenseStatewide, 7)>
    <CFSET C1_FundSel = ListGetAt(cookie.ExpenseStatewide, 8)>
    <CFSET C1_FundGrpSel = ListGetAt(cookie.ExpenseStatewide, 9)>
    <CFSET C1_FundTypeSel = ListGetAt(cookie.ExpenseStatewide, 10)>
    <CFSET C1_RevCatSel = ListGetAt(cookie.ExpenseStatewide, 11)>
    <CFSET C1_RevSel = ListGetAt(cookie.ExpenseStatewide, 12)>
    <CFSET C1_RevGrpSel = ListGetAt(cookie.ExpenseStatewide, 13)>
    <CFSET C1_RevTypeSel = ListGetAt(cookie.ExpenseStatewide, 14)>
    <CFSET C1_RevClsSel = ListGetAt(cookie.ExpenseStatewide, 15)>
    <CFSET C1_AgcyCatSel = ListGetAt(cookie.ExpenseStatewide, 16)>
    <CFSET C1_AgcySel = ListGetAt(cookie.ExpenseStatewide, 17)>
    <CFSET C1_AgcyGrpSel = ListGetAt(cookie.ExpenseStatewide, 18)>
    <CFSET C1_AgcyTypeSel = ListGetAt(cookie.ExpenseStatewide, 19)>
    <CFSET C1_ObjeCatSel = ListGetAt(cookie.ExpenseStatewide, 20)>
    <CFSET C1_ObjeSel = ListGetAt(cookie.ExpenseStatewide, 21)>
    <CFSET C1_ObjeGrpSel = ListGetAt(cookie.ExpenseStatewide, 22)>
    <CFSET C1_ObjeTypeSel = ListGetAt(cookie.ExpenseStatewide, 23)>
    <CFSET C1_ApprGrpSel = ListGetAt(cookie.ExpenseStatewide, 24)>
    <CFSET C1_ApprCatSel = ListGetAt(cookie.ExpenseStatewide, 25)>
    <CFSET C1_ApprTypeSel = ListGetAt(cookie.ExpenseStatewide, 26)>
    <CFSET C1_ApprClsSel = ListGetAt(cookie.ExpenseStatewide, 27)>
<!--- Get Friend Names from the cookie values. --->
        <cfinvoke component="Queries.expenditures"
                method="GetFreindlyName_Expense_Statewide"
                returnvariable="FN1">
        </cfinvoke>
</CFIF>

<cfoutput>
    <!-- START Statewide -->

    <div id="otherstate">
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
        <cfelseif IsDefined("cookie.ExpenseStatewide") AND ListLen(cookie.ExpenseStatewide) IS 27>
        <div id="4" style="display:block">
        <cfsaveContent variable="headString">
        <div class="row">
        <div class="col-md-3 col-md-offset-3">
            <p>Expenditures by: #FN1.val1#</p>
            <CFIF C1_Type IS NOT "Default" AND C1_Type IS NOT "">
                    <p>Type: #FN1.val3#</p>
            </CFIF>
                <p>Fiscal Year: <CFIF C1_FY LTE 60>20#C1_FY#
            <cfelse>19#C1_FY#</CFIF></p>

            <p><CFIF FN1.val7 IS NOT "Default" AND FN1.val7 IS NOT "">
                    Fund Category: #FN1.val7#<BR/>
            </CFIF>
            <CFIF FN1.val8 IS NOT "Default" AND FN1.val8 IS NOT "">
                    Fund: #FN1.val8#<BR/>
            </CFIF>
            <CFIF FN1.val9 IS NOT "Default" AND FN1.val9 IS NOT "">
                    Fund Group: #FN1.val9#<BR/>
            </CFIF>
            <CFIF FN1.val10 IS NOT "Default" AND FN1.val10 IS NOT "">
                    Fund Type: #FN1.val10#<BR/>
            </CFIF>
            <CFIF FN1.val11 IS NOT "Default" AND FN1.val11 IS NOT "">
                    Revenue Category: #FN1.val11#<BR/>
            </CFIF>
            <CFIF FN1.val12 IS NOT "Default" AND FN1.val12 IS NOT "">
                    Revenue: #FN1.val12#<BR/>
            </CFIF>
            <CFIF FN1.val13 IS NOT "Default" AND FN1.val13 IS NOT "">
                    Revenue Group: #FN1.val13#<BR/>
            </CFIF>
            <CFIF FN1.val14 IS NOT "Default" AND FN1.val14 IS NOT "">
                    Revenue Type: #FN1.val14#<BR/>
            </CFIF>
            <CFIF FN1.val15 IS NOT "Default" AND FN1.val15 IS NOT "">
                    Revenue Class: #FN1.val15#
            </CFIF></p>

            <CFIF C1_AgcyCatSel IS NOT "Default" AND C1_AgcyCatSel IS NOT "">
                    <p>Agency Category: #FN1.val16#</p>
            </CFIF>
            <CFIF C1_AgcySel IS NOT "Default" AND C1_AgcySel IS NOT "">
                    <p>Agency: #FN1.val17#</p>
            </CFIF>
            <CFIF C1_AgcyGrpSel IS NOT "Default" AND C1_AgcyGrpSel IS NOT "">
                    <p>Agency Group: #FN1.val18#</p>
            </CFIF>
            <CFIF C1_AgcyTypeSel IS NOT "Default" AND C1_AgcyTypeSel IS NOT "">
                    <p>Agency Type: #FN1.val19#</p>
            </CFIF>


            <p><CFIF C1_ObjeCatSel IS NOT "Default" AND C1_ObjeCatSel IS NOT "">
                    Object Category: #FN1.val20#<BR/>
            </CFIF>
            <CFIF C1_ObjeSel IS NOT "Default" AND TRIM(FN1.val21) IS NOT "">
                    Object: #FN1.val21#<BR/>
            </CFIF>
            <CFIF C1_ObjeGrpSel IS NOT "Default" AND C1_ObjeGrpSel IS NOT "">
                    Object Group: #FN1.val22#<BR/>
            </CFIF>
            <CFIF C1_ObjeTypeSel IS NOT "Default" AND C1_ObjeTypeSel IS NOT "">
                    Object Type: #FN1.val23#
            </CFIF></p>

            <CFIF C1_ApprGrpSel IS NOT "Default" AND C1_ApprGrpSel IS NOT "">
                    <p>Appropriation Group: #FN1.val24#</p>
            </CFIF>
            <CFIF C1_ApprCatSel IS NOT "Default" AND C1_ApprCatSel IS NOT "">
                    <p>Appropriation Category: #FN1.val25#</p>
            </CFIF>
            <CFIF C1_ApprTypeSel IS NOT "Default" AND C1_ApprTypeSel IS NOT "">
                    <p>Appropriation Type: #FN1.val26#</p>
            </CFIF>
            <CFIF C1_ApprClsSel IS NOT "Default" AND C1_ApprClsSel IS NOT "">
                    <p>Appropriation Class: #FN1.val27#</p>
            </CFIF>

            </div>

        </cfsaveContent>
        #headString#
        <div class="col-md-5 pull-left">
<!--- Display Adobe PDF Download for results --->
        <CFIF IsDefined("Results")>
                <div id="3" style="display:block">
                <p>
                        <a href="?GroupBy=#C1_GroupBy#&FY=#C1_FY#&ShowMo=#C1_ShowMo#&ShowBudg=#C1_Budget#&ShowLapse=#C1_Lapse#&FundSel=#C1_FundSel#&FundGrpSel=#C1_FundGrpSel#&FundTypeSel=#C1_FundTypeSel#&FundCatSel=#C1_FundCatSel#&ObjeSel=#variables.ObjeSel#&ObjeGrpSel=#variables.ObjeGrpSel#&ObjeTypeSel=#variables.ObjeTypeSel#&ObjeCatSel=#variables.ObjeCatSel#&
ApprSel=#variables.ApprSel#&ApprGrpSel=#C1_ApprGrpSel#&ApprTypeSel=#C1_ApprTypeSel#&ApprCatSel=#C1_ApprCatSel#&AgcySel=#C1_AgcySel#&AgcyGrpSel=#C1_AgcyGrpSel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&RevSel=#C1_RevSel#&RevClsSel=#C1_RevClsSel#&RevGrpSel=#C1_RevGrpSel#&RevTypeSel=#C1_RevTypeSel#&Type=#C1_Type#&PrintAsPDF=true">
                    <img alt="PDF_FILE" src="#$.siteconfig('themeassetpath')#/images/AdobeAcrobat.png" /></a></p>
            </div>
        </CFIF>
        </div>
        </div>
        </div>
        <div id="5" style="display:none">
        <!--- <h1>#$.getTitle()#</h1> --->
        <p>State funds are created by the General Assembly to address specific state revenues and liabilities.</p>
    </div>
    </CFIF>

    <cfform method="get" enctype="application/x-www-form-urlencoded" preloader="no" id="searchform">
        <div id="101" style="display:#HideSwitch1#">

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
                        <option value="Fund" selected="selected">Group By Fund</option>
                        <option value="FundCat">Fund Category</option>
                        <option value="FundGrp">Fund Group</option>
                        <option value="FundType">Fund Type</option>
                        <option value="Obje">Object of Expenditure</option>
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
                <option value="#application.cfy#" selected="selected">Fiscal Year</option>
            <Cfloop index="i" list="#FYList#">
                    <option value="#Right(i, 2)#">#i#</option>
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
                        <option value="0">Type of Spending</option>
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
                    <div id="2" style="width: 98%; margin: 0 auto;display:block">
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
<!--- 	<img alt="" src="#$.siteconfig('themeassetpath')#/images/CW_AlertIcon.jpg" /> --->
                <BR/><h1>No records found. Please use different search criteria.</h1>
            </div>
    </CFIF>


<!--- Display Last search results if cookie exists --->
    <CFIF Not IsDefined("results") AND IsDefined("cookie.ExpenseStatewide") AND ListLen(cookie.ExpenseStatewide) IS 27>


            <a href="?GroupBy=#C1_GroupBy#&FY=#C1_FY#&ShowMo=#C1_ShowMo#&ShowBudg=#C1_Budget#&ShowLapse=#C1_Lapse#&FundSel=#C1_FundSel#&FundGrpSel=#C1_FundGrpSel#&FundTypeSel=#C1_FundTypeSel#&FundCatSel=#C1_FundCatSel#&ObjtSel=#C1_ObjeSel#&ObjtGrpSel=#C1_ObjeGrpSel#&ObjtTypeSel=#C1_ObjeTypeSel#&ObjtCatSel=#C1_ObjeCatSel#&ApprGrpSel=#C1_ApprGrpSel#&ApprTypeSel=#C1_ApprTypeSel#&ApprCatSel=#C1_ApprCatSel#&AgcySel=#C1_AgcySel#&AgcyGrpSel=#C1_AgcyGrpSel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&RevSel=#C1_RevSel#&RevClsSel=#C1_RevClsSel#&RevGrpSel=#C1_RevGrpSel#&RevTypeSel=#C1_RevTypeSel#&Type=#C1_Type#">
        <div class="row">
        <div class="col-sm-offset-1 col-sm-10">
        <div class="lastsearch">
            <h2>Last Search</h2>

        <ul>
            <CFIF C1_GroupBy IS NOT "Default">
                    <li>Group By: #FN1.val1#</li>
            </CFIF>
            <CFIF C1_FY IS NOT "Default">
                    <li>Fiscal Year: #FN1.val2#</li>
            </cfif>
            <CFIF C1_Type IS NOT "Default">
                    <li>Type: #FN1.val3#</li>
            </CFIF>
            <CFIF C1_ShowMo IS NOT "Default">
                    <li>Show Monthly: #FN1.val4#</li>
            </CFIF>
            <CFIF C1_Budget IS NOT "Default">
                    <li>Show Budget: #FN1.val5#</li>
            </CFIF>
            <CFIF C1_Lapse IS NOT "Default">
                    <li>Show Lapse: #FN1.val6#</li>
            </CFIF>
            <CFIF FN1.val7 IS NOT "Default" AND FN1.val7 IS NOT "">
                    <li>Fund Category: #FN1.val7#</li>
            </CFIF>
            <CFIF FN1.val8 IS NOT "Default" AND FN1.val8 IS NOT "">
                    <li>Fund: #FN1.val8#</li>
            </CFIF>
            <CFIF FN1.val9 IS NOT "Default" AND FN1.val9 IS NOT "">
                    <li>Fund Group: #FN1.val9#</li>
            </CFIF>
            <CFIF FN1.val10 IS NOT "Default" AND FN1.val10 IS NOT "">
                    <li>Fund Type: #FN1.val10#</li>
            </CFIF>
            <CFIF FN1.val11 IS NOT "Default" AND FN1.val11 IS NOT "">
                    <li>Revenue Category: #FN1.val11#</li>
            </CFIF>
            <CFIF FN1.val12 IS NOT "Default" AND FN1.val12 IS NOT "">
                    <li>Revenue: #FN1.val12#</li>
            </CFIF>
            <CFIF FN1.val13 IS NOT "Default" AND FN1.val13 IS NOT "">
                    <li>Revenue Group: #FN1.val13#</li>
            </CFIF>
            <CFIF FN1.val14 IS NOT "Default" AND FN1.val14 IS NOT "">
                    <li>Revenue Type: #FN1.val14#</li>
            </CFIF>
            <CFIF FN1.val15 IS NOT "Default" AND FN1.val15 IS NOT "">
                    <li>Revenue Class: #FN1.val15#</li>
            </CFIF>

            <CFIF C1_AgcyCatSel IS NOT "Default" AND C1_AgcyCatSel IS NOT "">
                    <li>Agency Category: #FN1.val16#</li>
            </CFIF>
            <CFIF C1_AgcySel IS NOT "Default" AND C1_AgcySel IS NOT "">
                    <li>Agency: #FN1.val17#</li>
            </CFIF>
            <CFIF C1_AgcyGrpSel IS NOT "Default" AND C1_AgcyGrpSel IS NOT "">
                    <li>Agency Group: #FN1.val18#</li>
            </CFIF>
            <CFIF C1_AgcyTypeSel IS NOT "Default" AND C1_AgcyTypeSel IS NOT "">
                    <li>Agency Type: #FN1.val19#</li>
            </CFIF>


            <CFIF C1_ObjeCatSel IS NOT "Default" AND C1_ObjeCatSel IS NOT "">
                    <li>Object Category: #FN1.val20#</li>
            </CFIF>
            <CFIF C1_ObjeSel IS NOT "Default" AND TRIM(FN1.val21) IS NOT "">
                    <li>Object: #FN1.val21#</li>
            </CFIF>
            <CFIF C1_ObjeGrpSel IS NOT "Default" AND C1_ObjeGrpSel IS NOT "">
                    <li>Object Group: #FN1.val22#</li>
            </CFIF>
            <CFIF C1_ObjeTypeSel IS NOT "Default" AND C1_ObjeTypeSel IS NOT "">
                    <li>Object Type: #FN1.val23#</li>
            </CFIF>

            <CFIF C1_ApprGrpSel IS NOT "Default" AND C1_ApprGrpSel IS NOT "">
                    <li>Appropriation Group: #FN1.val24#</li>
            </CFIF>
            <CFIF C1_ApprCatSel IS NOT "Default" AND C1_ApprCatSel IS NOT "">
                    <li>Appropriation Category: #FN1.val25#</li>
            </CFIF>
            <CFIF C1_ApprTypeSel IS NOT "Default" AND C1_ApprTypeSel IS NOT "">
                    <li>Appropriation Type: #FN1.val26#</li>
            </CFIF>
            <CFIF C1_ApprClsSel IS NOT "Default" AND C1_ApprClsSel IS NOT "">
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
