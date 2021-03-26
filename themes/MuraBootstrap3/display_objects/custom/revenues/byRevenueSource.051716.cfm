<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css" />
<cfparam name="DisableHyperLink" default="no">
<cfparam name="OutGoingGroupBy" default="None">
<cfparam name="variables.Revenue_Source" default="">
<cfparam name="variables.Group" default="">
<cfparam name="variables.Class" default="">
<cfparam name="variables.Type" default="">
<cfparam name="variables.ShowMo" default="">


<CFIF IsDefined ("form.Revenue_Source")>
	<CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">

	<cfif form.GroupBy eq 0 or TRIM(form.GroupBy) eq "None" OR form.GroupBy IS "Default">
        <cfset variables.GroupBy = "Rev">
    <cfelse>
        <cfset variables.GroupBy = form.GroupBy>
    </cfif>
    <CFSET variables.GroupBy = variables.GroupBy>
    <cfif form.REVENUE_SOURCE eq 0 or TRIM(form.REVENUE_SOURCE) eq "" OR form.REVENUE_SOURCE IS "Default">
        <cfset variables.REVENUE_SOURCE = "">
    <cfelse>
        <cfset variables.REVENUE_SOURCE = form.REVENUE_SOURCE>
    </cfif>
    <cfif form.Class eq 0 or TRIM(form.Class) eq "">
        <cfset variables.Class = "">
    <cfelse>
        <cfset variables.Class = form.Class>
    </cfif>
    <cfif form.Group eq 0 or TRIM(form.Group) eq "">
        <cfset variables.Group = "">
    <cfelse>
        <cfset variables.Group = form.Group>
    </cfif>
    <cfif form.Type eq 0 or TRIM(form.Type) eq "">
        <cfset variables.Type = "">
    <cfelse>
        <cfset variables.Type = form.Type>
    </cfif>
    <cfif form.FY eq 0 or TRIM(form.FY) eq "">
        <cfset variables.FY = "#DATEFORMAT(NOW(), 'yy')#">
    <cfelse>
        <cfset variables.FY = form.FY>
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

    <cfif IsDefined("form.RevCatSel") AND TRIM(form.RevCatSel) IS NOT "" AND form.RevCatSel IS NOT 0>
     	<cfset variables.RevCatSel = TRIM(form.RevCatSel)>
    <cfelse>
     	<cfset variables.RevCatSel = "">
    </cfif>

    <cfif IsDefined("form.RevGrpSel") AND TRIM(form.RevGrpSel) IS NOT "">
     <cfset variables.RevGrpSel = form.RevGrpSel>
    <cfelse>
     <cfset variables.RevGrpSel = "">
    </cfif>

     <cfif IsDefined("form.RevTypeSel") AND TRIM(form.RevTypeSel) IS NOT "">
     <cfset variables.RevTypeSel = form.RevTypeSel>
    <cfelse>
     <cfset variables.RevTypeSel = "">
    </cfif>
     <CFIF IsDefined ("form.FundSel") and Form.FundSel IS NOT "Default">
    	<CFSET variables.FundSel = form.FundSel>
    <cfelse>
    	<CFSET variables.FundSel = "">
    </CFIF>
     <CFIF IsDefined ("form.FundGrpSel") and Form.FundGrpSel IS NOT "Default">
    	<CFSET variables.FundGrpSel = form.FundGrpSel>
    <cfelse>
    	<CFSET variables.FundGrpSel = "">
    </CFIF>

    <CFIF IsDefined ("form.FundTypeSel") and Form.FundTypeSel IS NOT "Default">
    	<CFSET variables.FundTypeSel = form.FundTypeSel>
    <cfelse>
    	<CFSET variables.FundTypeSel = "">
    </CFIF>

    <CFIF IsDefined ("form.FundCatSel") and Form.FundCatSel IS NOT "Default">
    	<CFSET variables.FundCatSel = form.FundCatSel>
    <cfelse>
    	<CFSET variables.FundCatSel = "">
    </CFIF>
    <CFIF IsDefined ("form.ShowMo") AND form.ShowMo IS "Yes">
        <CFSET variables.ShowMo = "Yes">
    <cfelse>
        <CFSET variables.ShowMo = "No">
    </CFIF>
    <CFSET variables.Submitted = true>
<cfelseif IsDefined ("URL.Revenue_Source")>
  	<CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">

	<cfif url.GroupBy eq 0 or TRIM(url.GroupBy) eq "None" OR url.GroupBy IS "Default">
        <cfset variables.GroupBy = "Rev">
    <cfelse>
        <cfset variables.GroupBy = TRIM(URLDecode(url.GroupBy, 'utf-8'))>
    </cfif>
    <cfif url.REVENUE_SOURCE eq 0 or TRIM(url.REVENUE_SOURCE) eq "" OR url.REVENUE_SOURCE IS "Default">
        <cfset variables.REVENUE_SOURCE = "">
    <cfelse>
        <cfset variables.REVENUE_SOURCE = TRIM(URLDecode(url.REVENUE_SOURCE, 'utf-8'))>
    </cfif>
    <cfif url.Class eq 0 or TRIM(url.Class) eq "" OR URL.Class IS "Default">
        <cfset variables.Class = "">
    <cfelse>
        <cfset variables.Class = TRIM(URLDecode(url.Class, 'utf-8'))>
    </cfif>
    <cfif url.Group eq 0 or TRIM(url.Group) eq "" OR url.Group IS "Default">
        <cfset variables.Group = "">
    <cfelse>
        <cfset variables.Group = TRIM(URLDecode(url.Group, 'utf-8'))>
    </cfif>
    <cfif url.Type eq 0 or TRIM(url.Type) eq "" eq "" OR url.Type IS "Default">
        <cfset variables.Type = "">
    <cfelse>
        <cfset variables.Type = TRIM(URLDecode(url.Type, 'utf-8'))>
    </cfif>
   
    <cfif url.FY eq 0 or TRIM(url.FY) eq "" eq "" OR url.FY IS "Default">
        <cfset variables.FY = "#DATEFORMAT(NOW(), 'yy')#">
    <cfelse>
        <cfset variables.FY = TRIM(URLDecode(url.FY, 'utf-8'))>
    </cfif>
    <CFIF IsDefined ("url.ShowMo") AND URL.ShowMo IS "Yes">
        <CFSET variables.ShowMo = "Yes">
    <cfelse>
        <CFSET variables.ShowMo = "No">
    </CFIF>
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
     <cfset variables.AgcyTypeSel = URL.AgcyTypeSel>
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
	 <cfif IsDefined("url.RevCatSel") AND TRIM(url.RevCatSel) IS NOT "" AND URL.RevCatSel IS NOT 0 AND URL.RevCatSel IS NOT "Default">
         <cfset variables.RevCatSel = TRIM(URLDecode(URL.RevCatSel, 'utf-8'))>
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
    <CFIF IsDefined ("url.FundSel") and TRIM(url.FundSel) IS NOT "Default">
    	<CFSET variables.FundSel = url.FundSel>
    <cfelse>
    	<CFSET variables.FundSel = "">
    </CFIF>
     <CFIF IsDefined ("url.FundGrpSel") and TRIM(url.FundGrpSel) IS NOT "Default">
    	<CFSET variables.FundGrpSel = url.FundGrpSel>
    <cfelse>
    	<CFSET variables.FundGrpSel = "">
    </CFIF>

    <CFIF IsDefined ("url.FundTypeSel") and TRIM(url.FundTypeSel) IS NOT "Default">
    	<CFSET variables.FundTypeSel = url.FundTypeSel>
    <cfelse>
    	<CFSET variables.FundTypeSel = "">
    </CFIF>

    <CFIF IsDefined ("url.FundCatSel") and TRIM(url.FundCatSel) IS NOT "Default">
    	<CFSET variables.FundCatSel = url.FundCatSel>
    <cfelse>
    	<CFSET variables.FundCatSel = "">
    </CFIF>

   
    <CFIF IsDefined ("URL.PrintAsPDF")>
    	<CFSET variables.PrintAsPDF = true>
    </CFIF>
	<CFSET variables.Submitted = true>
<cfelse>
 	 <CFSET variables.Group = "">
    <CFSET variables.REVENUE_SOURCE = "">
    <CFSET variables.Class = "">
    <CFSET variables.Group = "">
    <CFSET variables.Type = "">
    <cfset variables.FY = DateFormat(NOW(), "yy")>
    <CFSET variables.ShowMo ="">
    <CFSET HideSwitch1 = "block">
    <CFSET HideSwitch2 = "none">
    <CFSET variables.ShowMo = "No">
    <CFSET variables.AgcySel = "">
    <CFSET variables.AgcyGrpSel = "">
    <CFSET variables.AgcyCatSel = "">
    <CFSET variables.AgcyTypSel = "">
    <CFSET variables.FundSel = "">
    <CFSET variables.FundGrpSel = "">
    <CFSET variables.FundTypeSel = "">
    <CFSET variables.FundCatSel = "">
    <CFSET variables.RevSel = "">
    <CFSET variables.RevClsSel = "">
     <cfset variables.RevCatSel = "">
    <CFSET variables.RevGrpSel = "">
    <CFSET variables.RevTypeSel = "">


</cfif>

<cfif IsDefined ("variables.Submitted")>
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
		<CFSET OutGoingGroupBy ="None">
        <CFSET DisableHyperLink = "No">
    <cfelseif ListFindNoCase("Fund,AgcyCat,AgcyGrp,AgcyType,None", variables.GroupBy) GT 0>
		<CFSET OutGoingGroupBy ="Agcy">
        <CFSET DisableHyperLink = "No">
    <cfelseif ListFindNoCase("Agcy,RevCls,RevGrp,RevType,None", variables.GroupBy) GT 0>
		<CFSET OutGoingGroupBy ="Rev">
        <CFSET DisableHyperLink = "No">
    <cfelse>
		<CFSET OutGoingGroupBy ="None">
        <CFSET DisableHyperLink = "Yes">
    </cfif>
    <!--- Create a cookie that will retain the users search results  --->
    <!--- Cookie stores the selected values as a CSV string  --->
    <!--- Cookie CSV position legend:
	1) Fund
	2) Group
	3) Category
	4) Type
	5) Group by
	6) Fiscal Year
	7) View Monthly Totals
	 --->
     <CFIF TRIM(variables.Revenue_Source) IS "">
     	  <CFSET Postion1 = "Default">
     <cfelse>
     	 <CFSET Postion1 = variables.Revenue_Source>
     </CFIF>
     <CFIF TRIM(variables.Group) IS "">
     	  <CFSET Postion2 = "Default">
     <cfelse>
     	 <CFSET Postion2 = variables.Group>
     </CFIF>
     <CFIF TRIM(variables.Class) IS "">
     	  <CFSET Postion3 = "Default">
     <cfelse>
     	 <CFSET Postion3 = variables.Class>
     </CFIF>
      <CFIF TRIM(variables.Type) IS "">
     	  <CFSET Postion4 = "Default">
     <cfelse>
     	 <CFSET Postion4 = variables.Type>
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
     <CFIF variables.ShowMo IS "Yes">
     	  <CFSET Postion7 = "Yes">
     <cfelse>
     	 <CFSET Postion7 = "No">
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
  
    <cfcookie name="RevenuesByRevenueSource" value="#Postion1#,#Postion2#,#Postion3#,#Postion4#,#Postion5#,#Postion6#,#Postion7#,#Postion8#,#Postion9#,#Postion10#,#Postion11#,#Postion12#,#Postion13#,#Postion14#,#Postion15#" expires="never">
<!--- <cftry> --->
<!---  <cfinvoke component="Queries.temp2"
         method="RevenueAgencyQuery" --->
          
<cfinvoke component="Queries.revenues"
             method="RevenueQuery"
            returnvariable="results">
            <cfinvokeargument name="Control" value="Rev">
            <cfinvokeargument name="GroupBy" value="#variables.GroupBy#">
            <cfinvokeargument name="Max" value="20">
            <cfinvokeargument name="FY" value="#variables.FY#">
            <cfinvokeargument name="ShowMo" value="#variables.ShowMo#">
            <cfinvokeargument name="FundSel" value="#variables.FundSel#">
            <cfinvokeargument name="FundGrpSel" value="#variables.FundGrpSel#">
            <cfinvokeargument name="FundTypeSel" value="#variables.FundTypeSel#">
            <cfinvokeargument name="FundCatSel" value="#variables.FundCatSel#">
            <cfinvokeargument name="AgcySel" value="#variables.AgcySel#">
            <cfinvokeargument name="AgcyGrpSel" value="#variables.AgcyGrpSel#">
            <cfinvokeargument name="AgcyTypeSel" value="#variables.AgcyTypeSel#">
            <cfinvokeargument name="AgcyCatSel" value="#variables.AgcyCatSel#">
            <cfinvokeargument name="RevSel" value="#variables.REVENUE_SOURCE#">
            <cfinvokeargument name="RevClsSel" value="#variables.Class#">
            <cfinvokeargument name="RevGrpSel" value="#variables.Group#">
            <cfinvokeargument name="RevTypeSel" value="#variables.Type#">
            <cfinvokeargument name="SortName" value="No">
     </cfinvoke>
    <!--- Get the column headers from the query.  This is used for the table header in the report results below. --->
	<CFSET ColumnList = results.columnList>
<!--- 	<cfcatch type="any">
		<CFSET ColumnNames = "Error">
        <!--- Catch any errors whereas the incoming input values caused a DB2 crash --->
        <CFSET Error = "1">
    </cfcatch>
   </cftry> --->

</CFIF>

<!--- get Revenue --->
<cfinvoke component="Queries.warehouse"
	method="GetRevenueSource"
	returnvariable="qRL">
</cfinvoke>


<!--- get Revenue groups --->
<cfinvoke component="Queries.warehouse"
	method="GetRevenueGroup"
	returnvariable="qRGL" >
</cfinvoke>

<!--- get Revenue class --->
<cfinvoke component="Queries.warehouse"
	method="GetRevenueClass"
	returnvariable="qRC" >
</cfinvoke>

<!--- get Revenue Types --->
<cfinvoke component="Queries.warehouse"
	method="GetRevenueType"
	returnvariable="qRT" >
</cfinvoke>
<!--- Get Fiscal years --->
 <cfinvoke component="Queries.warehouse"
		method="getFYs"
		returnvariable="qFYList" >
	<cfinvokeargument name="numFYs" value="5"/>
    <cfinvokeargument name="MaxFY" value="#DATEFORMAT(NOW(), 'yyyy')#">
</cfinvoke>
<!--- Get Revenue Source Group By--->
 <cfinvoke component="Queries.autosuggest"
		method="GetRevenueSourceGroupBy">
</cfinvoke>


 <!--- Get Friend Names for form submitted values. --->
<CFIF IsDefined ("cookie.RevenuesByRevenueSource") AND ListLen(cookie.RevenuesByRevenueSource) IS 15>
	<CFSET C1_Revenue = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,1), 'utf-8'))>
    <CFSET C1_Group = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,2), 'utf-8'))>
    <CFSET C1_Class = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,3), 'utf-8'))>
    <CFSET C1_Type = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,4), 'utf-8'))>
    <CFSET C1_GroupBy = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,5), 'utf-8'))>
    <CFSET C1_FY = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,6), 'utf-8'))>
    <CFSET C1_MT = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,7), 'utf-8'))>
    <CFSET C1_FundCatSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,8), 'utf-8'))>
    <CFSET C1_FundSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,9), 'utf-8'))>
    <CFSET C1_FundGrpSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,10), 'utf-8'))>
    <CFSET C1_FundTypeSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,11), 'utf-8'))>
    <CFSET C1_AgcyCatSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,12), 'utf-8'))>
    <CFSET C1_AgcySel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,13), 'utf-8'))>
    <CFSET C1_AgcyGrpSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,14), 'utf-8'))>
    <CFSET C1_AgcyTypeSel = TRIM(URLDecode(ListGetAt(cookie.RevenuesByRevenueSource,15), 'utf-8'))>

  <cfinvoke component="Queries.revenues"
         method="GetFreindlyName_RevenueSource"
         returnvariable="FN1">
   </cfinvoke>
</CFIF>
<cfoutput>

<div id="expense" class="revenue">
<div class="container" <cfif IsDefined ("results")>style="width: 100% !important"</cfif>>
<div class="row">
    <div id="1" style="display:none" class="col-md-7 col-md-offset-2 alert alert-info text-center">
                 Gathering data, please wait...
    </div>
<div class="col-md-10 col-md-offset-1">
      <!--- Default Display and Dynamic Display --->

  <CFIF NOT IsDefined ("results")>
             <h1>#$.getTitle()#</h1>
				<p>The state of Illinois collects revenue from a variety of sources. Information provided by the Office of the Comptroller allows taxpayers to identify those revenue streams. </p>
 <cfelseif IsDefined ("cookie.RevenuesByRevenueSource") AND ListLen(cookie.RevenuesByRevenueSource) IS 15>

  <div id="4" style="display:block">
   <cfsaveContent variable="headString">
            <div class="row">
             <div class="col-md-9 col-md-offset-3">

                 <CFIF TRIM(FN1.val1) IS NOT "">
                      <h1> Revenue Source: #FN1.val1#</h1>
                 </CFIF>
            	   <h1>Total Revenues</h1>
               </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-md-offset-3">

                    <CFIF TRIM(FN1.val2) IS NOT "">
                        <p>Revenue Group: #FN1.val2#</p>
                    </CFIF>
                    <CFIF TRIM(FN1.val3) IS NOT "">
                        <p >Revenue Category: #FN1.val3#</p>
                    </CFIF>
                    <CFIF TRIM(FN1.val4) IS NOT "">
                        <p >Revenue Type: #FN1.val4#</p>
                    </CFIF>
                    <CFIF TRIM(FN1.val5) IS NOT "">
                        <p >Revenues by #FN1.val5#</p>
                    </CFIF>
                        <p >Fiscal Year: #C1_FY#</p>
                      
                    <CFIF FN1.val8 IS NOT "Default" AND FN1.val8 IS NOT "">
                    	Fund Category: #FN1.val8#<BR />
                    </CFIF>
                    <CFIF FN1.val9 IS NOT "Default" AND FN1.val9 IS NOT "">
                    	Fund: #FN1.val9#<BR />
                    </CFIF>
                    <CFIF FN1.val10 IS NOT "Default" AND FN1.val10 IS NOT "">
                    	Fund Group: #FN1.val10#<BR />
                    </CFIF>
                    <CFIF FN1.val11 IS NOT "Default" AND FN1.val11 IS NOT "">
                    	Fund Type: #FN1.val11#<BR />
                    </CFIF> 
					<CFIF TRIM(FN1.val12) IS NOT "Default" AND TRIM(FN1.val12) IS NOT "">
                        Agency Category: #FN1.val12#<BR />
                    </CFIF>
                     <CFIF TRIM(FN1.val13) IS NOT "Default" AND TRIM(FN1.val13) IS NOT "">
                        Agency: #FN1.val13#<BR />
                    </CFIF>
                    <CFIF TRIM(FN1.val14) IS NOT "Default" AND TRIM(FN1.val14) IS NOT "">
                        Agency Group: #FN1.val14#<BR />
                    </CFIF>
                      <CFIF TRIM(FN1.val15) IS NOT "Default" AND TRIM(FN1.val15) IS NOT "">
                        Agency Type: #FN1.val15#<BR />
                    </CFIF>    
                </div>
                  </cfsaveContent>
                  #headString#
                <div class="col-md-5 pull-left">
                    <!--- Display Adobe PDF Download for results --->
                    <CFIF IsDefined ("Results")>
                        <div id="3" style="display:block">
                            <p><a href="?GetQueryData=true&Revenue_Source=#C1_Revenue#&Group=#C1_Group#&Class=#C1_Class#&Type=#C1_Type#&GroupBy=#C1_GroupBy#&FY=#C1_FY#&ShowMo=#C1_MT#&FundSel=#C1_FundSel #&FundGrpSel=#C1_FundGrpSel#&FundTypeSel=#C1_FundTypeSel#&FundCatSel=#C1_FundCatSel#&AgcySel=#C1_AgcySel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&AgcyGrpSel=#C1_AgcyGrpSel#&PrintAsPDF=true"><img alt="" src="#$.siteconfig('themeassetpath')#/images/AdobeAcrobat.png" /></a></p>
                        </div>
                    </CFIF>
                </div>
            </div>
            </div>
            <div id="5" style="display:none">
              <h1>#$.getTitle()#</h1>
              <p>The state of Illinois collects revenue from a variety of sources. Information provided by the Office of the Comptroller allows taxpayers to identify those revenue streams. </p>
           </div>
 </CFIF>


<div class="row">
 <cfform method="get" enctype="application/x-www-form-urlencoded" preloader="no">
 <div id="101" style="display:#HideSwitch1#">
<fieldset>
 <div class="col-xs-12 col-sm-10">
<select name="Revenue_Source">
    <option value="0" selected="selected">Select an Revenue Source</option>
    <option value="0">All</option>
    <cfloop query="qRL">
        <option value= "#qRL.Revenue_Source#">#qRL.Revenue_Source# - #qRL.Name#</option>
    </cfloop>
</select>
</div>
<div class="col-xs-10">
<select name="Group">
    <option value="0" selected="selected">Select Group</option>
    <option value="0">All</option>
    <cfloop query="qRGL">
        <option value= "#qRGL.Group#">#qRGL.Group# - #qRGL.Name#</option>
    </cfloop>
</select>

</div>
<div class="col-xs-2">
<a class="tooltip-icon" href="##" data-toggle="tooltip" data-placement="top" title="Group!">?</a>
</div>


<div class="col-xs-10">

<select name="Class">
<option value="0" selected="selected">Select Class</option>
<option value="0">All</option>
    <cfloop query="qRC">
        <option value= "#qRC.Class#">#qRC.Class# - #qRC.Name#</option>
    </cfloop>
</select>

</div>
<div class="col-xs-2">
<a class="tooltip-icon" href="##" data-toggle="tooltip" data-placement="top" title="Class!">?</a>
</div>
<div class="col-xs-10">

<select name="Type">
<option value="0" selected="selected">Select Type</option>
<option value="0">All</option>
    <cfloop query="qRT">
        <option value= "#qRT.Type#">#qRT.Type# - #qRT.Name#</option>
    </cfloop>
</select>

</div>
<div class="col-xs-2">
<a class="tooltip-icon" href="##" data-toggle="tooltip" data-placement="top" title="Type!">?</a>
</div>

<div class="col-sm-10 col-xs-12">
<div class="hr"></div>
</div>
<!--- The DB2 database takes 2 digit year --->
<div class="col-sm-10 col-xs-12" required>

<cfselect name="FY">
    <option value="#DATEFORMAT(NOW(), 'yy')#" selected="selected">Fiscal Year</option>
    <Cfloop index="i" list="#qFYList#">
        <option value="#RIGHT(i,2)#">#i#</option>
    </Cfloop>
</cfselect>

</div>


<!--- Group By --->
<div class="col-sm-10 col-xs-12">

<cfselect name="GroupBy">
    <option value="None" selected="selected">Group By</option>
    <Cfloop query="#application.qRevenueGroupSources#">
        <option value="#application.qRevenueGroupSources.AbbrName#">#application.qRevenueGroupSources.Name#</option>
    </Cfloop>
</cfselect>

</div>



<div class="col-sm-10 col-xs-12">

<cfinput type="checkbox" name="ShowMo" id="checkbox_1" value="Yes" />
<label for="checkbox_1">View Monthly Amounts</label>

</div>


<div class="text-center top-pad col-xs-12 col-sm-11">
 	<cfinput type="submit" name="GetQueryData" class="btn btn-success" onclick="return SwitchOn();" value="Search">
</div>

</fieldset>
</div>
</cfform>
</div>
</div>

   <!--- Search Again button --->
                <div class="row show custom-pad-around">
                <div class="col-md-offset-4 col-md-10">
                   <!---  <div class="custom-pad-around col-md-offset-2 col-md-10"> --->
                      <a href="##" onclick="return SwitchOff();" class="btn btn-success col-sm-3" id="100" style="display:#HideSwitch2#">Search Again</a>
                    </div>
                </div>
 				</div>

<CFIF IsDefined ("variables.submitted")>
	 <cfset numberOfColumns = ListLen(ColumnList) />
     <CFIF NumberOfColumns GT 15>
     	<cfset numberOfColumns = 15 />
     </CFIF>
     <CFIF ListFindNoCase(ColumnList,"ExpTotal") GT 0>
            <CFSET SumColumn = "ExpTotal">
         <cfelseif ListFindNoCase(ColumnList,"RevTotal") GT 0>
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


	 <div class="row show">

    			<!--- ******************************************************************************************** --->
                <!--- ******************************************************************************************** --->
                <!---                               Results below                                                  --->
                <!--- ******************************************************************************************** --->
                <!--- ******************************************************************************************** --->
               <CFIF IsDefined ("variables.PrintAsPDF")>
                       <cfsaveContent variable="returnString">
                       		<cfinclude template="outputs/RevenueSource1.cfm">
                       </cfsaveContent>
                       <CFSET Variables.PDFContent= ReplaceNoCase(ReplaceNoCase(ReplaceNoCase(headString,"h1","h4","all"),"<p>","","all"),"<\/p>","") & "<br/>" & returnString>
                       <CFSET Variables.PDFContent=returnString>
                        <CFIF variables.ShowMo is "Yes">
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
                     	 <cfinclude template="outputs/RevenueSource1.cfm">
                      </div>
                    </CFIF>
				</div>

                <!--- ******************************************************************************************** --->
                <!--- ******************************************************************************************** --->
                <!---                                     End report results                                       --->
                <!--- ******************************************************************************************** --->
                <!--- ******************************************************************************************** --->


</CFIF>

				 <CFIF IsDefined ("Error") AND Error IS 1>
               	<!--- Display Query Input error  --->
               		<div class="col-md-12" align="center">
                    <!--- 	<img alt="" src="#$.siteconfig('themeassetpath')#/images/CW_AlertIcon.jpg" /> --->
                        <BR /><h1>No records found. Please use different search criteria.</h1>
                    </div>
               </CFIF>

 <!--- Display Last search results if cookie exists --->
				<CFIF Not IsDefined ("results") AND IsDefined ("cookie.RevenuesByRevenueSource") AND ListLen(cookie.RevenuesByRevenueSource) IS 15>


                    <a href="?GetQueryData=true&Revenue_Source=#C1_Revenue#&Group=#C1_Group#&Class=#C1_Class#&Type=#C1_Type#&GroupBy=#C1_GroupBy#&FY=#C1_FY#&ShowMo=#C1_MT#&FundSel=#C1_FundSel #&FundGrpSel=#C1_FundGrpSel#&FundTypeSel=#C1_FundTypeSel#&FundCatSel=#C1_FundCatSel#&AgcySel=#C1_AgcySel#&AgcyTypeSel=#C1_AgcyTypeSel#&AgcyCatSel=#C1_AgcyCatSel#&AgcyGrpSel=#C1_AgcyGrpSel#">
                        <div class="col-sm-offset-1 col-sm-12">
                        <div class="lastsearch">
                            <h2>Last Search</h2>
                            <div class="block">
                                <ul>
                                <CFIF C1_Revenue IS NOT "Default">
                                    <li>Agency: #FN1.val1#</li>
                                </CFIF>
                                <CFIF C1_Group IS NOT "Default">
                                    <li>Group: #FN1.val2#</li>
                                </cfif>
                                <CFIF C1_Class IS NOT "Default">
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
                                
								<CFIF FN1.val8 IS NOT "Default" AND FN1.val8 IS NOT "">
                                  <li>Fund Category: #FN1.val8#</li>
                                </CFIF>
                                <CFIF FN1.val9 IS NOT "Default" AND FN1.val9 IS NOT "">
                                	<li>Fund: #FN1.val9#</li>
                                </CFIF>
                                <CFIF FN1.val10 IS NOT "Default" AND FN1.val10 IS NOT "">
                                	<li>Fund Group: #FN1.val10#</li>
                                </CFIF>
                                <CFIF FN1.val11 IS NOT "Default" AND FN1.val11 IS NOT "">
                                	<li>Fund Type: #FN1.val11#</li>
                                </CFIF> 
                                <CFIF TRIM(FN1.val12) IS NOT "Default" AND TRIM(FN1.val12) IS NOT "">
                                	<li>Agency Category: #FN1.val12#</li>
                                </CFIF>
                                <CFIF TRIM(FN1.val13) IS NOT "Default" AND TRIM(FN1.val13) IS NOT "">
                                	<li>Agency: #FN1.val13#</li>
                                </CFIF>
                                <CFIF TRIM(FN1.val14) IS NOT "Default" AND TRIM(FN1.val14) IS NOT "">
                                	<li>Agency Group: #FN1.val14#</li>
                                </CFIF>
                                <CFIF TRIM(FN1.val15) IS NOT "Default" AND TRIM(FN1.val15) IS NOT "">
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