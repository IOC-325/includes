<cfinvoke component="Queries.expenditures"
	method="ExpenditureTotalsQuery"
	returnvariable="CFY_DebtPayments"
	control="Fund"
	GroupBy="None"
	Max="20"
	FY="#application.PopularQueryFY#"
	Type="A"
	ShowBudg="Yes"
	ShowMo="NO"
	ShowLapse="NO"
	FundSel="0101"
	FundClsSel=""
	FundGrpSel=""
	FundTypSel=""
	FundCatSel=""
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
	returnvariable="PFY_DebtPayments"
	control="Fund"
	GroupBy="None"
	Max="20"
	FY="#application.pfy#"
	Type="A"
	ShowBudg="Yes"
	ShowMo="NO"
	ShowLapse="NO"
	FundSel="0101"
	FundClsSel=""
	FundGrpSel=""
	FundTypSel=""
	FundCatSel=""
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
					<h4>How much money does the State pay for its debt during the fiscal year?</h4>
					<table class="table table-sorting table-striped table-2018">
						<tr>
							<th class="bg-info">Type</th>
							<th class="bg-info text-right">Current FY Amount</th>
							<th class="bg-info text-right">Previous FY Amount</th>
						</tr>
						<tr>
							<td>Current Debt Service</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?FundSel=0101&FundGrpSel=0&FundCatSel=0&FundTypeSel=0&GroupBy=Agcy&FY=#application.PopularQueryFY#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=">#DollarFormat(CFY_DebtPayments.ExpTotal)#</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?FundSel=0101&FundGrpSel=0&FundCatSel=0&FundTypeSel=0&GroupBy=Agcy&FY=#application.pfy#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=">#DollarFormat(PFY_DebtPayments.ExpTotal)#</td>
						</tr>

					</table>
	</cfoutput>

					<h3>About Debt Payment Spending</h3>
					<p>When the state borrows money, it is required to pay it back within a certain period of time with interest. 
					The amounts above show the debt service the state has paid for the state&#39s general obligation bonds from the 
					General Obligation Bond Retirement and Interest Fund in total for the previous fiscal year and year-to-date 
					for the current fiscal year. These bonds are generally used for capital projects such as roads and bridges, 
					school construction, mass transportation, and state facilities. A portion of Illinois&#39 general obligation debt 
					service is going to repay bonds issued for pension payment purposes and for the payment of old bills to vendors.
					


	</div>
	<!-- END EXPENSE -->
