
<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="CFY_results" 
	control="Fund"
	GroupBy="None"
	Max="20"
	FY="#application.PopularQueryFY#"
	Type="A"
	ShowBudg="Yes"
	ShowMo="NO"
	ShowLapse="NO"
	FundSel=""
	FundClsSel=""
	FundGrpSel=""
	FundTypSel=""
	FundCatSel="E"
	AgcySel=""
	AgcyClsSel=""
	AgcyGrpSel=""
	AgcyTypSel=""
	AgcyCatSel=""
	ApprSel=""
	ApprClsSel=""
	ApprGrpSel=""
	ApprTypSel=""
	ApprCatSel=""
	ObjeSel=""
	ObjtSel=""
	ObjtClsSel=""
	ObjtGrpSel=""
	ObjtTypSel=""
	ObjtCatSel=""
	SortName="No"
	>

<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="PFY_results" 
	control="Fund"
	GroupBy="None"
	Max="20"
	FY="#application.pfy#"
	Type="A"
	ShowBudg="Yes"
	ShowMo="NO"
	ShowLapse="NO"
	FundSel=""
	FundClsSel=""
	FundGrpSel=""
	FundTypSel=""
	FundCatSel="E"
	AgcySel=""
	AgcyClsSel=""
	AgcyGrpSel=""
	AgcyTypSel=""
	AgcyCatSel=""
	ApprSel=""
	ApprClsSel=""
	ApprGrpSel=""
	ApprTypSel=""
	ApprCatSel=""
	ObjeSel=""
	ObjtSel=""
	ObjtClsSel=""
	ObjtGrpSel=""
	ObjtTypSel=""
	ObjtCatSel=""
	SortName="No"
	>

<cfoutput>
<!-- START EXPENSE -->
	<div id="expense" class="revenue">

					<h4>How much money has been spent on infrastructure projects in the state?</h4>
					<table class="table table-sorting table-striped table-2018">
						<tr>
							<th class="bg-info">Type</th>
							<th class="bg-info text-right">Current FY Amount</th>
							<th class="bg-info text-right">Previous FY Amount</th>
						</tr>
						<tr>
							<td>Infrastructure</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-fund?FundSel=0&FundGrpSel=0&FundCatSel=E+&FundTypeSel=0&GroupBy=Agcy&FY=#application.PopularQueryFY#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=">#DollarFormat(CFY_results.exptotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-fund?FundSel=0&FundGrpSel=0&FundCatSel=E+&FundTypeSel=0&GroupBy=Agcy&FY=#application.pfy#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=">#DollarFormat(PFY_results.exptotal)#</a></td>
						</tr>
						
					</table>
 
					<h3>Rebuild Illinois</h3>
					<p>In 2019, the Governor and General Assembly approved the state&rsquo;s first major infrastructure program in 10 years. 
					The six-year, $45 billion plan, Rebuild Illinois, will make capital investments in roads, bridges, railways, elementary 
					and high schools, universities, early childhood centers, broadband access, environmental projects and state facilities, 
					including crime labs and veterans&rsquo; homes, across the state.</p>


	</div>
	<!-- END EXPENSE -->
	</cfoutput>