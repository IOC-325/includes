
<CFSET variables.FY = DATEFORMAT(NOW(), "yy")>
    <cfinvoke component="Queries.temp2"
         method="RevenueAgencyQuery"
         returnvariable="CFY_results">
            <cfinvokeargument name="Control" value="Rev">
            <cfinvokeargument name="GroupBy" value="Fund">
            <cfinvokeargument name="FY" value="#application.PopularQueryFY#">
            <cfinvokeargument name="ShowMo" value="">
            <cfinvokeargument name="FundSel" value="">
            <cfinvokeargument name="FundGrpSel" value="">
            <cfinvokeargument name="FundTypSel" value="">
            <cfinvokeargument name="FundCatSel" value="">
            <cfinvokeargument name="AgcySel" value="">
            <cfinvokeargument name="AgcyGrpSel" value="">
            <cfinvokeargument name="AgcyTypSel" value="">
            <cfinvokeargument name="AgcyCatSel" value="">
            <cfinvokeargument name="RevSel" value="">
            <cfinvokeargument name="RevClsSel" value="">
            <cfinvokeargument name="RevGrpSel" value="">
            <cfinvokeargument name="RevTypSel" value="06">
            <cfinvokeargument name="SortName" value="No">
     </cfinvoke>

    <cfinvoke component="Queries.temp2"
         method="RevenueAgencyQuery"
         returnvariable="PFY_results">
            <cfinvokeargument name="Control" value="Rev">
            <cfinvokeargument name="GroupBy" value="Fund">
            <cfinvokeargument name="FY" value="#application.pfy#">
            <cfinvokeargument name="ShowMo" value="">
            <cfinvokeargument name="FundSel" value="">
            <cfinvokeargument name="FundGrpSel" value="">
            <cfinvokeargument name="FundTypSel" value="">
            <cfinvokeargument name="FundCatSel" value="">
            <cfinvokeargument name="AgcySel" value="">
            <cfinvokeargument name="AgcyGrpSel" value="">
            <cfinvokeargument name="AgcyTypSel" value="">
            <cfinvokeargument name="AgcyCatSel" value="">
            <cfinvokeargument name="RevSel" value="">
            <cfinvokeargument name="RevClsSel" value="">
            <cfinvokeargument name="RevGrpSel" value="">
            <cfinvokeargument name="RevTypSel" value="06">
            <cfinvokeargument name="SortName" value="No">
     </cfinvoke>


<cfoutput>
<!-- START EXPENSE -->

					<p>How much money has the state collected from purchases in Illinois since July 1?</p>
					<table class="table table-sorting table-striped table-2018">
						<tr>
							<th class="bg-info">Type</th>
                            <th class="bg-info text-right">Current FY Amount</th>
                            <th class="bg-info text-right">Previous FY Amount</th>
						</tr>
						<tr>
                            <!--- /index.cfm/find-a-revenue/revenue-source/?Revenue_Source=0&Group=0&Class=0&Type=06&FY=17&GroupBy=Agcy&ShowMo=Yes&GetQueryData=Search --->
							<td>Sales Tax Revenue</td>
                            <td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=0&RevTypeSel=06&FY=#application.PopularQueryFY#&GroupBy=None&GetQueryData=Search">#DollarFormat(CFY_results.RevTotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=0&RevTypeSel=06&FY=#application.pfy#&GroupBy=None&GetQueryData=Search">#DollarFormat(PFY_results.RevTotal)#</td>
						</tr>				
					</table>

					<p>About Sales Tax Revenues</p>
					<p>Taxes imposed on the purchase of goods in Illinois is the second-largest state revenue source. The state collects the state sales tax and collects locally imposed sales taxes for local governments and processes the revenues collected in their taxing district back to the local governmental entity. The Regional Transportation Authority, home-rule units, and non-home rule municipalities are among the entities that may impose sales taxes under state laws.</p>


	<!-- END EXPENSE -->
	</cfoutput>