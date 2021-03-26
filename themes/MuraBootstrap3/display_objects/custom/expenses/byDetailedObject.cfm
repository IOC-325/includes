<!--- by detailed object --->
<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css"/>
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/jquery.dataTables1.10.20.min.css" rel="stylesheet" type="text/css">
<link href="/comptroller/includes/themes/MuraBootstrap3/css/ledger/fixedColumns.dataTables3.3.0.min.css" rel="stylesheet" type="text/css">

<cfparam name="DisableHyperLink" default="no">
<cfparam name="OutGoingGroupBy" default="None">
<cfparam name="headerFont" default="headerFont">
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
    <cfif IsDefined("form.AgcySel") AND TRIM(form.AgcySel) IS NOT "" AND form.AgcySel IS NOT 0>
     <cfset variables.AgcySel = TRIM(form.AgcySel)>
    <cfelse>
     <cfset variables.AgcySel = "">
    </cfif>

    <cfif IsDefined("form.AgcyGrpSel") AND TRIM(form.AgcyGrpSel) IS NOT "" AND form.AgcyGrpSel IS NOT 0>
     <cfset variables.AgcyGrpSel = TRIM(form.AgcyGrpSel)>
    <cfelse>
     <cfset variables.AgcyGrpSel = "">
    </cfif>

    <cfif IsDefined("form.AgcyTypeSel") AND TRIM(form.AgcyTypeSel) IS NOT "" AND form.AgcyTypeSel IS NOT 0>
     <cfset variables.AgcyTypeSel = TRIM(form.AgcyTypeSel)>
    <cfelse>
     <cfset variables.AgcyTypeSel = "">
    </cfif>

     <cfif IsDefined("form.AgcyCatSel") AND TRIM(form.AgcyCatSel) IS NOT "" AND form.AgcyCatSel IS NOT 0>
     <cfset variables.AgcyCatSel = TRIM(form.AgcyCatSel)>
    <cfelse>
     <cfset variables.AgcyCatSel = "">
    </cfif>

      <cfif IsDefined("form.AgcyClsSel") AND TRIM(form.AgcyClsSel) IS NOT "" AND form.AgcyClsSel IS NOT 0>
     <cfset variables.AgcyClsSel = TRIM(form.AgcyClsSel)>
    <cfelse>
     <cfset variables.AgcyClsSel = "">
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
    
     <cfif IsDefined("form.RevCatSel") AND TRIM(form.RevCatSel) IS NOT "" AND form.RevCatSel IS NOT 0 AND form.RevCatSel IS NOT "Default">
     <cfset variables.RevCatSel = TRIM(form.RevCatSel)>
    <cfelse>
     <cfset variables.RevCatSel = "">
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

     <cfif IsDefined("form.FundCatSel") AND TRIM(form.FundCatSel) IS NOT "" AND form.FundCatSel IS NOT 0 AND TRIM(form.FundCatSel) IS NOT "Default">
     	<cfset variables.FundCatSel = TRIM(form.FundCatSel)>
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

     <cfif IsDefined("form.ApprCatSel") AND TRIM(form.ApprCatSel) IS NOT "" AND form.ApprCatSel IS NOT 0 AND TRIM(form.ApprCatSel) IS NOT "Default">
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

     <cfif IsDefined("form.ObjeCatSel") AND TRIM(form.ObjeCatSel) IS NOT "" AND form.ObjeCatSel IS NOT 0 AND TRIM(form.ObjeCatSel) IS NOT "Default">
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

     <cfif IsDefined("form.ObjtCatSel") AND TRIM(form.ObjtCatSel) IS NOT "" AND form.ObjtCatSel IS NOT 0  AND TRIM(form.ObjtCatSel) IS NOT "Default">
     	<cfset variables.ObjtCatSel = TRIM(form.ObjtCatSel)>
    <cfelse>
     	<cfset variables.ObjtCatSel = "">
    </cfif>


<cfelseif IsDefined ("URL.GroupBy") AND IsDefined ("URL.FY")>
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
    <cfif IsDefined("url.AgcySel") AND TRIM(url.AgcySel) IS NOT "" AND URL.AgcySel IS NOT 0  AND TRIM(url.AgcySel) IS NOT "Default">
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

     <cfif IsDefined("url.AgcyClsSel") AND TRIM(url.AgcyClsSel) IS NOT "" AND URL.AgcyClsSel IS NOT 0 AND TRIM(url.AgcyClsSel) IS NOT "Default">
     <cfset variables.AgcyClsSel = TRIM(URLDecode(URL.AgcyClsSel, 'utf-8'))>
    <cfelse>
     <cfset variables.AgcyClsSel = "">
    </cfif>

     <cfif IsDefined("url.RevSel") AND TRIM(url.RevSel) IS NOT "" AND URL.RevSel IS NOT 0 AND TRIM(url.RevSel) IS NOT "Default">
     <cfset variables.RevSel = TRIM(URLDecode(URL.RevSel, 'utf-8'))>
    <cfelse>
     <cfset variables.RevSel = "">
    </cfif>

    <cfif IsDefined("url.RevClsSel") AND TRIM(url.RevClsSel) IS NOT "" AND URL.RevClsSel IS NOT 0  AND TRIM(url.RevClsSel) IS NOT "Default">
     <cfset variables.RevClsSel = TRIM(URLDecode(URL.RevClsSel, 'utf-8'))>
    <cfelse>
     <cfset variables.RevClsSel = "">
    </cfif>

    <cfif IsDefined("url.RevGrpSel") AND TRIM(url.RevGrpSel) IS NOT "" AND URL.RevGrpSel IS NOT 0 AND TRIM(url.RevGrpSel) IS NOT "Default">
     <cfset variables.RevGrpSel = TRIM(URLDecode(URL.RevGrpSel, 'utf-8'))>
    <cfelse>
     <cfset variables.RevGrpSel = "">
    </cfif>

    <cfif IsDefined("url.RevTypeSel") AND TRIM(url.RevTypeSel) IS NOT "" AND URL.RevTypeSel IS NOT 0 AND TRIM(url.RevTypeSel) IS NOT "Default">
     	<cfset variables.RevTypeSel = TRIM(URLDecode(URL.RevTypeSel, 'utf-8'))>
    <cfelse>
     	<cfset variables.RevTypeSel = "">
    </cfif>
    
     <cfif IsDefined("url.RevCatSel") AND TRIM(url.RevCatSel) IS NOT "" AND URL.RevCatSel IS NOT 0 AND TRIM(url.RevCatSel) IS NOT "Default">
     <cfset variables.RevCatSel = TRIM(URLDecode(URL.RevCatSel, 'utf-8'))>
    <cfelse>
     <cfset variables.RevCatSel = "">
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

     <cfif IsDefined("url.FundCatSel") AND TRIM(url.FundCatSel) IS NOT "" AND URL.FundCatSel IS NOT 0 AND TRIM(url.FundCatSel) IS NOT "Default">
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

     <cfif IsDefined("url.ApprCatSel") AND TRIM(url.ApprCatSel) IS NOT "" AND URL.ApprCatSel IS NOT 0 AND TRIM(url.ApprCatSel) IS NOT "Default">
     	<cfset variables.ApprCatSel = TRIM(URLDecode(URL.ApprCatSel, 'utf-8'))>
    <cfelse>
     	<cfset variables.ApprCatSel = "">
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

     <cfif IsDefined("url.ObjeCatSel") AND TRIM(url.ObjeCatSel) IS NOT "" AND URL.ObjeCatSel IS NOT 0 AND  TRIM(url.ObjeCatSel) IS NOT "Default">
     	<cfset variables.ObjeCatSel = TRIM(URLDecode(URL.ObjeCatSel, 'utf-8'))>
    <cfelse>
     	<cfset variables.ObjeCatSel = "">
    </cfif>


      <cfif IsDefined("url.ObjtSel") AND TRIM(url.ObjtSel) IS NOT "" AND URL.ObjtSel IS NOT 0 AND TRIM(url.ObjtSel) IS NOT "Default">
     	<cfset variables.ObjtSel = TRIM(URLDecode(URL.ObjtSel, 'utf-8'))>
    <cfelse>
     	<cfset variables.ObjtSel = "">
    </cfif>

    <cfif IsDefined("url.ObjtClsSel") AND TRIM(url.ObjtClsSel) IS NOT "" AND URL.ObjtClsSel IS NOT 0 AND TRIM(url.ObjtClsSel) IS NOT "Default">
     <cfset variables.ObjtClsSel = TRIM(URLDecode(URL.ObjtClsSel, 'utf-8'))>
    <cfelse>
     <cfset variables.ObjtClsSel = "">
    </cfif>

    <cfif IsDefined("url.ObjtGrpSel") AND TRIM(url.ObjtGrpSel) IS NOT "" AND URL.ObjtGrpSel IS NOT 0 AND TRIM(url.ObjtGrpSel) IS NOT "Default">
     <cfset variables.ObjtGrpSel = TRIM(URLDecode(URL.ObjtGrpSel, 'utf-8'))>
    <cfelse>
     <cfset variables.ObjtGrpSel = "">
    </cfif>

     <cfif IsDefined("url.ObjtTypeSel") AND TRIM(url.ObjtTypeSel) IS NOT "" AND URL.ObjtTypeSel IS NOT 0 AND TRIM(url.ObjtTypeSel) IS NOT "Default">
     <cfset variables.ObjtTypeSel = TRIM(URLDecode(URL.ObjtTypeSel, 'utf-8'))>
    <cfelse>
     <cfset variables.ObjtTypeSel = "">
    </cfif>

     <cfif IsDefined("url.ObjtCatSel") AND TRIM(url.ObjtCatSel) IS NOT "" AND URL.ObjtCatSel IS NOT 0 AND TRIM(url.ObjtCatSel) IS NOT "Default">
     	<cfset variables.ObjtCatSel = TRIM(URLDecode(URL.ObjtCatSel, 'utf-8'))>
    <cfelse>
     	<cfset variables.ObjtCatSel = "">
    </cfif>

    <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
    <CFIF IsDefined ("URL.PrintAsPDF")>
    	<CFSET form.PrintAsPDF = true>
    </CFIF>

    <CFSET form.Submitted = true>
<cfelse>
	<cfset variables.GroupBy = "Objt">
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
    <cfset variables.AgcyClsSel = "">
    <CFSET variables.AgcyTypeSel = "">
    <CFSET variables.AgcyCatSel = "">
    <CFSET variables.RevSel = "">
    <CFSET variables.RevClsSel = "">
    <CFSET variables.RevGrpSel = "">
    <CFSET variables.RevTypeSel = "">
    <cfset variables.RevCatSel = "">
    <CFSET variables.ObjeSel = "">
    <CFSET variables.ObjeGrpSel = "">
    <CFSET variables.ObjeTypeSel = "">
    <CFSET variables.ObjeCatSel = "">
    <CFSET variables.ApprSel = "">
    <CFSET variables.ApprGrpSel = "">
    <CFSET variables.ApprTypeSel = "">
    <CFSET variables.ApprCatSel = "">
    <CFSET variables.ApprClsSel = "">
    <CFSET variables.ObjtSel = "">
    <CFSET variables.ObjtGrpSel = "">
    <CFSET variables.ObjtTypeSel = "">
    <CFSET variables.ObjtCatSel = "">
    <cfset variables.ObjtClsSel = "">
</cfif>


 <CFIF IsDefined ("form.Submitted")>

   <!--- Concatenate the selector name from GroupBy + sel.  This will be an input the report query.  This logic is used to drive the  sub reports links within the report results.   --->
    <CFSET ThisName = "#TRIM(variables.GroupBy)#Sel">
    <!--- Get Groupby Friendly Name --->
    <cfinvoke component="Queries.autosuggest"
                method="GetFullListGroupBy"
                returnvariable="qRG" >
         <cfinvokeargument name="IncomingGroupBy" value="#variables.GroupBy#">
     </cfinvoke>
		<CFIF qRG.recordcount GT 0>
            <CFSET GroupByFN = qRG.Name>
        <cfelse>
            <CFSET GroupByFN = "Name">
        </CFIF>


    <!--- Reset the GroupBy name --->
    <CFIF ListFindNoCase("FundCat,FundGrp,FundType", variables.GroupBy) GT 0>
		<CFSET OutGoingGroupBy ="Obje">
        <CFSET DisableHyperLink = "Yes">
    <cfelseif ListFindNoCase("Fund,AgcyCat,AgcyGrp,AgcyType", variables.GroupBy) GT 0>
		<CFSET OutGoingGroupBy ="Agcy">
        <CFSET DisableHyperLink = "No">
    <cfelseif ListFindNoCase("Agcy,None", variables.GroupBy) GT 0>
		<CFSET OutGoingGroupBy ="Obje">
        <CFSET DisableHyperLink = "No">
    <cfelseif ListFindNoCase("Obje,ApprCat,ApprGrp,ApprType,ApprCls", variables.GroupBy) GT 0>
		<CFSET OutGoingGroupBy ="Objt">
        <CFSET DisableHyperLink = "No">
     <cfelseif ListFindNoCase("Appr,ObjtCat,ObjtGrp,ObjtType", variables.GroupBy) GT 0>
		<CFSET OutGoingGroupBy ="Objt">
        <CFSET DisableHyperLink = "Yes">
      <cfelseif ListFindNoCase("Objt", variables.GroupBy) GT 0>
		<CFSET OutGoingGroupBy ="Objt">
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
		7) Object Expenditure
		8) Appropriation Group
		9) Appropriation Category
		10) Appropriation Type
		11) Appropriation Class
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
     <CFIF TRIM(variables.ObjtSel) IS "">
        <CFSET Postion23 = "Default">
     <cfelse>
       <CFSET Postion23 = variables.ObjtSel>
     </CFIF>
     <CFIF TRIM(variables.ObjtGrpSel) IS "">
        <CFSET Postion24 = "Default">
     <cfelse>
       <CFSET Postion24 = variables.ObjtGrpSel>
     </CFIF>
      <CFIF TRIM(variables.ObjtCatSel) IS "">
        <CFSET Postion25 = "Default">
     <cfelse>
       <CFSET Postion25 = variables.ObjtCatSel>
     </CFIF>
      <CFIF TRIM(variables.ObjtTypeSel) IS "">
        <CFSET Postion26 = "Default">
     <cfelse>
       <CFSET Postion26 = variables.ObjtTypeSel>
     </CFIF>
     <CFIF TRIM(variables.ObjtClsSel) IS "">
        <CFSET Postion27 = "Default">
     <cfelse>
       <CFSET Postion27 = variables.ObjtClsSel>
     </CFIF>
     
      <CFIF TRIM(variables.ApprSel) IS "">
        <CFSET Postion28 = "Default">
     <cfelse>
       <CFSET Postion28 = variables.ApprSel>
     </CFIF>
     <CFIF TRIM(variables.ApprGrpSel) IS "">
        <CFSET Postion29 = "Default">
     <cfelse>
       <CFSET Postion29 = variables.ApprGrpSel>
     </CFIF>
      <CFIF TRIM(variables.ApprCatSel) IS "">
        <CFSET Postion30 = "Default">
     <cfelse>
       <CFSET Postion30 = variables.ApprCatSel>
     </CFIF>
      <CFIF TRIM(variables.ApprTypeSel) IS "">
        <CFSET Postion31 = "Default">
     <cfelse>
       <CFSET Postion31 = variables.ApprTypeSel>
     </CFIF>
     <CFIF TRIM(variables.ApprClsSel) IS "">
        <CFSET Postion32 = "Default">
     <cfelse>
       <CFSET Postion32 = variables.ApprClsSel>
     </CFIF>

<cfcookie name="ExpenseByDetailedObject" value="#Postion1#,#Postion2#,#Postion3#,#Postion4#,#Postion5#,#Postion6#,#Postion7#,#Postion8#,#Postion9#,#Postion10#,#Postion11#,#Postion12#,#Postion13#,#Postion14#,#Postion15#,#Postion16#,#Postion17#,#Postion18#,#Postion19#,#Postion20#,#Postion21#,#Postion22#,#Postion23#,#Postion24#,#Postion25#,#Postion26#,#Postion27#,#Postion28#,#Postion29#,#Postion30#,#Postion31#,#Postion32#" expires="never">
   <!--- CFTRY is used to prevent displaying database errors from incoming URL.GroupBy variables that have been manipulated in the URL string.  The revenues query should be rewritten to prevent this from happening.   --->
<!--- <cftry> --->

     <cfinvoke component="Queries.expenditures"
         method="ExpenditureQuery"
         returnvariable="results">
            <cfinvokeargument name="Control" value="Objt">
            <cfinvokeargument name="GroupBy" value="#variables.GroupBy#">
            <cfinvokeargument name="Max" value="20">
            <cfinvokeargument name="FY" value="#variables.FY#">
            <cfinvokeargument name="ShowBudg" value="#variables.ShowBudg#">
			<cfinvokeargument name="ShowMo" value="#variables.ShowMo#">
			<cfinvokeargument name="ShowLapse" value="#variables.ShowLapse#">
            <cfinvokeargument name="FundSel" value="#variables.FundSel#">
            <cfinvokeargument name="FundGrpSel" value="#variables.FundGrpSel#">
			<cfinvokeargument name="FundClsSel" value="#variables.FundClsSel#">
            <cfinvokeargument name="FundTypeSel" value="#variables.FundTypeSel#">
            <cfinvokeargument name="FundCatSel" value="#variables.FundCatSel#">
            <cfinvokeargument name="AgcySel" value="#variables.AgcySel#">
			<cfinvokeargument name="AgcyClsSel" value="#variables.AgcyClsSel#">
            <cfinvokeargument name="AgcyGrpSel" value="#variables.AgcyGrpSel#">
            <cfinvokeargument name="AgcyTypeSel" value="#variables.AgcyTypeSel#">
            <cfinvokeargument name="AgcyCatSel" value="#variables.AgcyCatSel#">
			<cfinvokeargument name="ApprSel" value="#variables.ApprSel#">
            <cfinvokeargument name="ApprClsSel" value="#variables.ApprClsSel#">
            <cfinvokeargument name="ApprGrpSel" value="#variables.ApprGrpSel#">
            <cfinvokeargument name="ApprTypeSel" value="#variables.ApprTypeSel#">
			<cfinvokeargument name="ApprCatSel" value="#variables.ApprCatSel#">
            <cfinvokeargument name="RevSel" value="#variables.RevSel#">
            <cfinvokeargument name="RevClsSel" value="#variables.RevClsSel#">
            <cfinvokeargument name="RevGrpSel" value="#variables.RevGrpSel#">
            <cfinvokeargument name="RevTypeSel" value="#variables.RevTypeSel#">
			<cfinvokeargument name="ObjeSel" value="#variables.ObjeSel#">
            <cfinvokeargument name="ObjtSel" value="#variables.ObjtSel#">
            <cfinvokeargument name="ObjtClsSel" value="#variables.ObjtClsSel#">
            <cfinvokeargument name="ObjtGrpSel" value="#variables.ObjtGrpSel#">
			<cfinvokeargument name="ObjtTypeSel" value="#variables.ObjtTypeSel#">
            <cfinvokeargument name="ObjtCatSel" value="#variables.ObjtCatSel#">
            <cfinvokeargument name="Type" value="#variables.Type#">
            <cfinvokeargument name="SortName" value="Code">
     </cfinvoke>
	 <!--- Get the column headers from the query.  This is used for the table header in the report results below. --->
 <cfset ColumnNames = ArrayToList(Results.getColumnNames()) />

 <!--- 	<cfcatch type="any">
		<CFSET ColumnNames = "Error">
        <!--- Catch any errors whereas the incoming input values caused a DB2 crash --->
        <CFSET Error = "1">
    </cfcatch>
   </cftry> --->

</CFIF>


<cfoutput>

<!--- Get Objects --->
<cfinvoke component="Queries.warehouse"
  method="GetObjectForDetailObject"
  returnvariable="qObject">
</cfinvoke>
<!--- Get Group --->
<cfinvoke component="Queries.warehouse"
  method="GetGroupsForDetailObject"
  returnvariable="qGroup">
</cfinvoke>
<!--- Get Category  --->
<cfinvoke component="Queries.warehouse"
  method="GetCategoryForDetailObject"
  returnvariable="qCat">
</cfinvoke>
<!--- Get Type --->
<cfinvoke component="Queries.warehouse"
  method="GetTypeForDetailObject"
  returnvariable="qType">
</cfinvoke>
<!--- Get Class  --->
<cfinvoke component="Queries.warehouse"
  method="GetClassForDetailObject"
  returnvariable="qClass">
</cfinvoke>
<!--- Get Revenue Source Group By--->
 <cfinvoke component="Queries.autosuggest"
    method="GetRevenueSourceGroupBy" >
</cfinvoke>
<!--- Get Fiscal years --->
 <cfinvoke component="Queries.warehouse"
    method="getFYs"
    returnvariable="qFYList" >
  <cfinvokeargument name="numFYs" value="5"/>
    <cfinvokeargument name="MaxFY" value="#application.cfy#">
</cfinvoke>

<CFIF IsDefined ("cookie.ExpenseByDetailedObject") AND ListLen(cookie.ExpenseByDetailedObject) IS 32>
     <!--- Get the clients cookie values and set them as variables  --->
	<CFSET C1_GroupBy = ListGetAt(cookie.ExpenseByDetailedObject,1)>
    <CFSET C1_FY = ListGetAt(cookie.ExpenseByDetailedObject,2)>
    <CFSET C1_Type = ListGetAt(cookie.ExpenseByDetailedObject,3)>
    <CFSET C1_ShowMo = ListGetAt(cookie.ExpenseByDetailedObject,4)>
    <CFSET C1_Budget = ListGetAt(cookie.ExpenseByDetailedObject,5)>
    <CFSET C1_Lapse = ListGetAt(cookie.ExpenseByDetailedObject,6)>
    <CFSET C1_AgcyCatSel = ListGetAt(cookie.ExpenseByDetailedObject,7)>
    <CFSET C1_AgcySel = ListGetAt(cookie.ExpenseByDetailedObject,8)>
    <CFSET C1_AgcyGrpSel = ListGetAt(cookie.ExpenseByDetailedObject,9)>
    <CFSET C1_AgcyTypeSel = ListGetAt(cookie.ExpenseByDetailedObject,10)>
	<CFSET C1_FundCatSel = ListGetAt(cookie.ExpenseByDetailedObject,11)>
    <CFSET C1_FundSel = ListGetAt(cookie.ExpenseByDetailedObject,12)>
    <CFSET C1_FundGrpSel = ListGetAt(cookie.ExpenseByDetailedObject,13)>
    <CFSET C1_FundTypeSel = ListGetAt(cookie.ExpenseByDetailedObject,14)>
    <CFSET C1_RevCatSel = ListGetAt(cookie.ExpenseByDetailedObject,15)>
    <CFSET C1_RevSel = ListGetAt(cookie.ExpenseByDetailedObject,16)>
    <CFSET C1_RevGrpSel = ListGetAt(cookie.ExpenseByDetailedObject,17)>
    <CFSET C1_RevTypeSel = ListGetAt(cookie.ExpenseByDetailedObject,18)>
    <CFSET C1_ObjeCatSel = ListGetAt(cookie.ExpenseByDetailedObject,19)>
    <CFSET C1_ObjeSel = ListGetAt(cookie.ExpenseByDetailedObject,20)>
    <CFSET C1_ObjeGrpSel = ListGetAt(cookie.ExpenseByDetailedObject,21)>
    <CFSET C1_ObjeTypeSel = ListGetAt(cookie.ExpenseByDetailedObject,22)>
    <CFSET C1_ObjtSel = ListGetAt(cookie.ExpenseByDetailedObject,23)>
    <CFSET C1_ObjtGrpSel = ListGetAt(cookie.ExpenseByDetailedObject,24)>
    <CFSET C1_ObjtCatSel = ListGetAt(cookie.ExpenseByDetailedObject,25)>
    <CFSET C1_ObjtTypeSel = ListGetAt(cookie.ExpenseByDetailedObject,26)>
    <CFSET C1_ObjtClsSel = ListGetAt(cookie.ExpenseByDetailedObject,27)>
    <CFSET C1_ApprSel = ListGetAt(cookie.ExpenseByDetailedObject,28)>
    <CFSET C1_ApprGrpSel = ListGetAt(cookie.ExpenseByDetailedObject,29)>
    <CFSET C1_ApprCatSel = ListGetAt(cookie.ExpenseByDetailedObject,30)>
    <CFSET C1_ApprTypeSel = ListGetAt(cookie.ExpenseByDetailedObject,31)>
    <CFSET C1_ApprClsSel = ListGetAt(cookie.ExpenseByDetailedObject,32)>
      <!--- Get Friend Names from the cookie values. --->
    <cfinvoke component="Queries.expenditures"
        method="GetFreindlyName_Expense_ByDetailedObject"
        returnvariable="FN1">
    </cfinvoke>
</CFIF>

<!-- START FUND -->

<div id="agency">
 <div class="container" <cfif IsDefined ('results')>style='width: 100% !important'</cfif>>

    <div class="row">
        <div id="1" style="display:none" class="col-md-4 col-md-offset-4 alert alert-info text-center">
            Gathering data, please wait...
        </div>
    </div>
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
               <CFIF NOT IsDefined ("results")>
                      	<p>By Detail Object is a department classification used by the State to group expenses.</p>
               <cfelseif IsDefined ("cookie.ExpenseByDetailedObject") AND ListLen(cookie.ExpenseByDetailedObject) IS 32>

                        <div id="4" style="display:block">
                        <cfsaveContent variable="headString">
                    <div class="row">
                             <div class="col-md-3 col-md-offset-3">
                                  <p>Fiscal Year: <CFIF C1_FY LTE 60>20#C1_FY#<cfelse>19#C1_FY#</CFIF></p>
                                <CFIF C1_Type IS NOT "Default" AND C1_Type IS NOT "">
                                    <p>Type: #FN1.val3#</p>
                                </CFIF>
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
                                     <p>Fund Category: #FN1.val11#</p>
                                </CFIF>
                                 <CFIF FN1.val12 IS NOT "Default" AND FN1.val12 IS NOT "">
                                     <p>Fund: #FN1.val12#</p>
                                </CFIF>
                                <CFIF FN1.val13 IS NOT "Default" AND FN1.val13 IS NOT "">
                                     <p> Fund Group: #FN1.val13#</p>
                                </CFIF>
                                  <CFIF FN1.val14 IS NOT "Default" AND FN1.val14 IS NOT "">
                                      <p>Fund Type: #FN1.val14#</p>
                                </CFIF>
                                 <CFIF FN1.val15 IS NOT "Default" AND FN1.val15 IS NOT "">
                                     <p>Revenue Category: #FN1.val15#</p>
                                </CFIF>
                                 <CFIF FN1.val16 IS NOT "Default" AND FN1.val16 IS NOT "">
                                     <p>Revenue: #FN1.val16#</p>
                                </CFIF>
                                <CFIF FN1.val17 IS NOT "Default" AND FN1.val17 IS NOT "">
                                     <p>Revenue Group: #FN1.val17#</p>
                                </CFIF>
                                  <CFIF FN1.val18 IS NOT "Default" AND FN1.val18 IS NOT "">
                                     <p>Revenue Type: #FN1.val18#</p>
                                </CFIF>
                                 <CFIF C1_ObjeCatSel IS NOT "Default" AND C1_ObjeCatSel IS NOT "">
                                     <p>Object Category: #FN1.val19#</p>>
                                </CFIF>
                                 <CFIF C1_ObjeSel IS NOT "Default" AND TRIM(FN1.val20) IS NOT "">
                                     <p>Object: #FN1.val20#</p>
                                </CFIF>
                                <CFIF C1_ObjeGrpSel IS NOT "Default" AND C1_ObjeGrpSel IS NOT "">
                                     <p>Object Group: #FN1.val21#</p>
                                </CFIF>
                                  <CFIF C1_ObjeTypeSel IS NOT "Default" AND C1_ObjeTypeSel IS NOT "">
                                     <p>Object Type: #FN1.val22#</p>
                                </CFIF>
                                 <CFIF C1_ObjtSel IS NOT "Default" AND C1_ObjtSel IS NOT "">
                                     <p>Detail: #FN1.val23#</p>
                                </CFIF>
                                 <CFIF C1_ObjtGrpSel IS NOT "Default" AND C1_ObjtGrpSel IS NOT "">
                                     <p>Detail Group: #FN1.val24#</p>
                                </CFIF>
                                <CFIF C1_ObjtCatSel IS NOT "Default" AND C1_ObjtCatSel IS NOT "">
                                     <p>Detail Category: #FN1.val25#</p>
                                </CFIF>
                     
                                 <CFIF C1_ObjtTypeSel IS NOT "Default" AND TRIM(C1_ObjtTypeSel) IS NOT "">
                                     <p>Detail Type: #FN1.val26#</p>
                                </CFIF>
                                <CFIF C1_ObjtClsSel IS NOT "Default" AND C1_ObjtClsSel IS NOT "">
                                     <p>Detail Class: #FN1.val27#</p>
                                </CFIF>
                                 <CFIF C1_ApprSel IS NOT "Default" AND C1_ApprSel IS NOT "">
                                     <p>Appropriation: #FN1.val28#</p>
                                </CFIF>
                                 <CFIF C1_ApprGrpSel IS NOT "Default" AND C1_ApprGrpSel IS NOT "">
                                     <p>Appropriation Group: #FN1.val29#</p>
                                </CFIF>
                                <CFIF C1_ApprCatSel IS NOT "Default" AND C1_ApprCatSel IS NOT "">
                                     <p>Appropriation Category: #FN1.val30#</p>
                                </CFIF>
                                 <CFIF C1_ApprTypeSel IS NOT "Default" AND C1_ApprTypeSel IS NOT "">
                                     <p>Appropriation Type: #FN1.val31#</p>
                                </CFIF>
                                <CFIF C1_ApprClsSel IS NOT "Default" AND C1_ApprClsSel IS NOT "">
                                     <p>Appropriation Class: #FN1.val32#</p>
                                </CFIF>
                               </div>
                              </cfsaveContent>
                              #headString#
                             <div class="col-md-5 pull-left">
                               <!--- Display Adobe PDF Download for results --->
                               <CFIF IsDefined ("Results")>
                                       <div id="3" style="display:block">
                                        <p><a href="?GroupBy=#C1_GroupBy #&FY=#C1_FY#&Type=#C1_Type#&ShowMo=#C1_ShowMo#&ShowBudg=#C1_Budget#&ShowLapse=#C1_Lapse#&FundSel=#C1_FundSel#&FundGrpSel=#C1_FundGrpSel#&FundCatSel=#C1_FundCatSel#&FundTypeSel=#C1_FundTypeSel#&AgcySel=#C1_AgcySel#&AgcyGrpSel=#C1_AgcyGrpSel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&RevSel=#C1_RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#C1_RevGrpSel#&RevTypeSel=#C1_RevTypeSel#&ObjeSel=#C1_ObjeSel#&ObjeGrpSel=#C1_ObjeGrpSel#&ObjeCatSel=#C1_ObjeCatSel#&ObjeTypeSel=#C1_ObjeTypeSel#&ApprSel=#C1_ApprSel#&ApprGrpSel=#C1_ApprGrpSel#&ApprCatSel=#C1_ApprCatSel#&ApprTypeSel=#C1_ApprTypeSel#&ApprClsSel=#C1_ApprClsSel#&objtSel=#C1_ObjtSel#&objtGrpSel=#C1_ObjtGrpSel#&objtCatSel=#C1_ObjtCatSel#&objtTypeSel=#C1_ObjtTypeSel#&ObjtClsSel=#C1_ObjtClsSel#&PrintAsPDF=true"><img alt="PDF_FILE" src="#$.siteconfig('themeassetpath')#/images/AdobeAcrobat.png" /></a></p>
                                       </div>
                               </CFIF>
                             </div>
                         </div>
	                    </div>
                        <div id="5" style="display:none">
                            <!--- <h1>Expenses #$.getTitle()#</h1> --->
                          <p>By Detailed Object is a department classification used by the State to group expenses.</p>
                        </div>
          			</CFIF>

<cfform method="get" enctype="application/x-www-form-urlencoded" preloader="no" id="searchform">
 <div id="101" style="display:#HideSwitch1#">
    <div class="row">
      <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">Object</div>
      </div>

      <div class="col-xs-12 col-sm-7 col-md-5">
          <SELECT NAME="ObjtSel" class="select2">
          <OPTION VALUE="">Object</option>
          <cfloop query="qObject">
          <CFIF ObjtSel is qObject.Object>
                  <OPTION VALUE="#Object#" SELECTED>#Object# - #Name#</option>
              <CFELSE>
                  <OPTION VALUE="#Object#">#Object# - #Name#</option>
              </CFIF>
          </cfloop>
          </SELECT>
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">Group</div>
      </div>

      <div class="col-xs-12 col-sm-7 col-md-5">
        <SELECT NAME="ObjtGrpSel" class="select2">
        <OPTION VALUE="" selected="selected">Group</option>
        <cfloop query="qGroup">
           <CFIF ObjtGrpSel is qGroup.Group>
                <OPTION VALUE="#Group#" SELECTED>#Group# - #Name#</option>
            <CFELSE>
                <OPTION VALUE="#Group#">#Group# - #Name#</option>
            </CFIF>
        </cfloop>
        </SELECT>
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">Category</div>
      </div>

      <div class="col-xs-12 col-sm-7 col-md-5">
        <SELECT NAME="ObjtCatSel" class="select2">
        <OPTION VALUE="">Category</option>
        <cfloop query="qCat">
           <CFIF variables.ObjtCatSel is qCat.Category>
                <OPTION VALUE="#Category#" SELECTED>#Category# - #Name#</option>
            <CFELSE>
                <OPTION VALUE="#Category#">#Category# - #Name#</option>
            </CFIF>
        </cfloop>
        </SELECT>
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">Type</div>
      </div>

      <div class="col-xs-12 col-sm-7 col-md-5">
        <SELECT NAME="ObjtTypeSel" class="select2">
        <OPTION VALUE="">Type</option>
        <cfloop query="qType">
           <CFIF variables.ObjtTypeSel is qType.Type>
                <OPTION VALUE="#TRIM(Type)#" SELECTED>#Type# - #Name#</option>
            <CFELSE>
                <OPTION VALUE="#TRIM(Type)#">#Type# - #Name#</option>
            </CFIF>
        </cfloop>
        </SELECT>
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">Class</div>
      </div>

      <div class="col-xs-12 col-sm-7 col-md-5">
        <SELECT NAME="ObjtClsSel" class="select2">
        <OPTION VALUE="" selected="selected"> Class</option>
        <cfloop query="qClass">
           <CFIF variables.ObjtClsSel is qClass.Class>
                <OPTION VALUE="#Class#" SELECTED>#Class# - #Name#</option>
            <CFELSE>
                <OPTION VALUE="#Class#">#Class# - #Name#</option>
            </CFIF>
        </cfloop>
        </SELECT>
      </div>
    </div>
    
    <div class="row">
        <div class="col-sm-10 col-xs-12">
        <div class="hr">&nbsp;</div>
        </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">Group By</div>
      </div>

      <div class="col-xs-12 col-sm-7 col-md-5">
        <cfselect name="GroupBy" class="select2">
            <option value="None">None</option>
            <OPTION VALUE="Agcy" selected="selected">Group by Agency</option>
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
            <option value="Obje">Object of Expenditure</option>
            <option value="Objt">Object</option>
            <option value="ObjtCat">Object Category</option>
            <option value="ObjtGrp">Object Group</option>
            <option value="ObjtType">Object Type</option>
        </cfselect>
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">Fiscal Year</div>
      </div>

      <div class="col-xs-12 col-sm-7 col-md-5">
        <cfselect name="FY" class="select2">
           
            <Cfloop index="i" list="#qFYList#">
              <CFIF application.cfy IS RIGHT(i,2)>
                <option value="#RIGHT(i,2)#" selected="selected">Fiscal Year 20#i#</option>
                <cfelse>
                <option value="#RIGHT(i,2)#">20#i#</option>
                </CFIF>
            </Cfloop>
        </cfselect>
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">Type of Spending</div>
      </div>

      <div class="col-xs-12 col-sm-7 col-md-5">
        <select name="Type" class="select2">
            <option value="A" selected="selected">Type of Spending</option>
            <option value="A">Appropriated Only</option>
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
        <input id="ShowMo" name="ShowMo" type="checkbox" value="Yes" />
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">View Budget Amounts</div>
      </div>

      <div class="col-xs-12 col-sm-7 col-md-5">
        <input id="ShowBudg" name="ShowBudg" type="checkbox" value="Yes" />
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">View Lapse Amounts</div>
      </div>

      <div class="col-xs-12 col-sm-7 col-md-5">
        <input id="ShowLapse" name="ShowLapse" type="checkbox" value="Yes" />
      </div>
    </div>

      <div class="text-center">
          <button class="btn btn-primary" type="submit" onclick="return SwitchOn();" >Submit</button>
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

         <cfif IsDefined ("results")>
				<cfset numberOfColumns = listlen( ArrayToList( Results.getColumnNames() ) ) />
              <div class="show">

    			<!--- ******************************************************************************************** --->
                <!--- ******************************************************************************************** --->
                <!---                               Results below                                                  --->
                <!--- ******************************************************************************************** --->
                <!--- ******************************************************************************************** --->
					<CFIF IsDefined ("form.PrintAsPDF")>
                       <cfsaveContent variable="returnString">
                       		<cfinclude template="outputs/ByDetailObject1.cfm">
                       </cfsaveContent>

                       <CFSET Variables.PDFContent= ReplaceNoCase(ReplaceNoCase(ReplaceNoCase(headString,"h1","h4","all"),"<p>","","all"),"<\/p>","") & "<br/>" & returnString>
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
                            <cfinclude template="outputs/ByDetailObject1.cfm">
                        </div>
                    </CFIF>


				</div>
                <!--- ******************************************************************************************** --->
                <!--- ******************************************************************************************** --->
                <!---                                     End report results                                       --->
                <!--- ******************************************************************************************** --->
                <!--- ******************************************************************************************** --->

              </cfif>

			   <CFIF IsDefined ("Error") AND Error IS 1>
               	<!--- Display Query Input error  --->
               		<div class="text-center">
                    <!--- 	<img alt="" src="#$.siteconfig('themeassetpath')#/images/CW_AlertIcon.jpg" /> --->
                        <BR /><h1>No records found. Please use different search criteria.</h1>
                    </div>
               </CFIF>

            <!--- Display Last search results if cookie exists --->
				<CFIF Not IsDefined ("results") AND IsDefined ("cookie.ExpenseByDetailedObject") AND ListLen(cookie.ExpenseByDetailedObject) IS 32>


                    <a href="?GroupBy=#C1_GroupBy #&FY=#C1_FY#&Type=#C1_Type#&ShowMo=#C1_ShowMo#&ShowBudg=#C1_Budget#&ShowLapse=#C1_Lapse#&FundSel=#C1_FundSel#&FundGrpSel=#C1_FundGrpSel#&FundCatSel=#C1_FundCatSel#&FundTypeSel=#C1_FundTypeSel#&AgcySel=#C1_AgcySel#&AgcyGrpSel=#C1_AgcyGrpSel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&RevSel=#C1_RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#C1_RevGrpSel#&RevTypeSel=#C1_RevTypeSel#&ObjeSel=#C1_ObjeSel#&ObjeGrpSel=#C1_ObjeGrpSel#&ObjeCatSel=#C1_ObjeCatSel#&ObjeTypeSel=#C1_ObjeTypeSel#&ApprSel=#C1_ApprSel#&ApprGrpSel=#C1_ApprGrpSel#&ApprCatSel=#C1_ApprCatSel#&ApprTypeSel=#C1_ApprTypeSel#&ApprClsSel=#C1_ApprClsSel#&objtSel=#C1_ObjtSel#&objtGrpSel=#C1_ObjtGrpSel#&objtCatSel=#C1_ObjtCatSel#&objtTypeSel=#C1_ObjtTypeSel#&ObjtClsSel=#C1_ObjtClsSel#">
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
                                     Fund Category: #FN1.val11#<BR />
                                </CFIF>
                                 <CFIF FN1.val12 IS NOT "Default" AND FN1.val12 IS NOT "">
                                    Fund: #FN1.val12#<BR />
                                </CFIF>
                                <CFIF FN1.val13 IS NOT "Default" AND FN1.val13 IS NOT "">
                                     Fund Group: #FN1.val13#<BR />
                                </CFIF>
                                  <CFIF FN1.val14 IS NOT "Default" AND FN1.val14 IS NOT "">
                                     Fund Type: #FN1.val14#<BR />
                                </CFIF>
                                 <CFIF FN1.val15 IS NOT "Default" AND FN1.val15 IS NOT "">
                                    Revenue Category: #FN1.val15#<BR />
                                </CFIF>
                                 <CFIF FN1.val16 IS NOT "Default" AND FN1.val16 IS NOT "">
                                    Revenue: #FN1.val16#<BR />
                                </CFIF>
                                <CFIF FN1.val17 IS NOT "Default" AND FN1.val17 IS NOT "">
                                    Revenue Group: #FN1.val17#<BR />
                                </CFIF>
                                  <CFIF FN1.val18 IS NOT "Default" AND FN1.val18 IS NOT "">
                                    Revenue Type: #FN1.val18#<BR />
                                </CFIF>
                                 <CFIF C1_ObjeCatSel IS NOT "Default" AND C1_ObjeCatSel IS NOT "">
                                    Object Category: #FN1.val19#<BR />
                                </CFIF>
                                 <CFIF C1_ObjeSel IS NOT "Default" AND TRIM(FN1.val20) IS NOT "">
                                    Object: #FN1.val20#<BR />
                                </CFIF>
                                <CFIF C1_ObjeGrpSel IS NOT "Default" AND C1_ObjeGrpSel IS NOT "">
                                    Object Group: #FN1.val21#<BR />
                                </CFIF>
                                  <CFIF C1_ObjeTypeSel IS NOT "Default" AND C1_ObjeTypeSel IS NOT "">
                                    Object Type: #FN1.val22#<BR />
                                </CFIF>
                                 <CFIF C1_ObjtSel IS NOT "Default" AND C1_ObjtSel IS NOT "">
                                    <li>Object of Detail: #FN1.val23#</li>
                                </CFIF>
                                 <CFIF C1_ObjtGrpSel IS NOT "Default" AND C1_ObjtGrpSel IS NOT "">
                                    <li>Detail Group: #FN1.val24#</li>
                                </CFIF>
                                <CFIF C1_ObjtCatSel IS NOT "Default" AND C1_ObjtCatSel IS NOT "">
                                    <li>Detail Category: #FN1.val25#</li>
                                </CFIF>
                                 <CFIF C1_ObjtTypeSel IS NOT "Default" AND C1_ObjtTypeSel IS NOT "">
                                    <li>Detail Type: #FN1.val26#</li>
                                </CFIF>
                                <CFIF C1_ObjtClsSel IS NOT "Default" AND C1_ObjtClsSel IS NOT "">
                                    <li>Detail Class: #FN1.val27#</li>
                                </CFIF>
								<CFIF C1_ApprSel IS NOT "Default" AND C1_ApprSel IS NOT "">
                                     <li>Appropriation: #FN1.val28#</li>
                                </CFIF>
                                 <CFIF C1_ApprGrpSel IS NOT "Default" AND C1_ApprGrpSel IS NOT "">
                                    <li>Appropriation Group: #FN1.val29#</li>
                                </CFIF>
                                <CFIF C1_ApprCatSel IS NOT "Default" AND C1_ApprCatSel IS NOT "">
                                    <li>Appropriation Category: #FN1.val30#</li>
                                </CFIF>
                                 <CFIF C1_ApprTypeSel IS NOT "Default" AND C1_ApprTypeSel IS NOT "">
                                     <li>Appropriation Type: #FN1.val31#</li>
                                </CFIF>
                                <CFIF C1_ApprClsSel IS NOT "Default" AND C1_ApprClsSel IS NOT "">
                                     <li>Appropriation Class: #FN1.val32#</li>
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
		$(function() {
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
		$(function() {
			e3.delay(2000).fadeOut(0);
			});
	}


</script>
