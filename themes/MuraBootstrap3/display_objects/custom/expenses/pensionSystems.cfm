<!--- CURRENT FY --->
<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="CFY_SERS" 
	control="Obje"
	GroupBy="None"
	Max="20"
	FY="#application.PopularQueryFY#"
	Type="B"
	ShowBudg="Yes"
	ShowMo="NO"
	ShowLapse="NO"
	FundSel=""
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
	ApprCatSel="1160"
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
	returnvariable="CFY_TRS" 
	control="AGCY"
	GroupBy="Obje"
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
	FundCatSel=""
	AgcySel="593"
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
	returnvariable="CFY_SURS" 
	control="Fund"
	GroupBy="None"
	Max="20"
	FY="#application.PopularQueryFY#"
	Type="A"
	ShowBudg="Yes"
	ShowMo="NO"
	ShowLapse="NO"
	FundSel="0054"
	FundClsSel=""
	FundGrpSel=""
	FundTypSel=""
	FundCatSel=""
	AgcySel="693"
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
	returnvariable="CFY_TRSC" 
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
	FundCatSel=""
	AgcySel="594"
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
<!--- PREVIOUS FY --->


<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="PFY_SERS" 
	control="Obje"
	GroupBy="None"
	Max="20"
	FY="#application.pfy#"
	Type="B"
	ShowBudg="Yes"
	ShowMo="NO"
	ShowLapse="NO"
	FundSel=""
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
	ApprCatSel="1160"
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
	returnvariable="PFY_TRS" 
	control="AGCY"
	GroupBy="Obje"
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
	FundCatSel=""
	AgcySel="593"
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
	returnvariable="PFY_SURS" 
	control="Fund"
	GroupBy="None"
	Max="20"
	FY="#application.pfy#"
	Type="A"
	ShowBudg="Yes"
	ShowMo="NO"
	ShowLapse="NO"
	FundSel="0054"
	FundClsSel=""
	FundGrpSel=""
	FundTypSel=""
	FundCatSel=""
	AgcySel="693"
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
	returnvariable="PFY_TRSC" 
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
	FundCatSel=""
	AgcySel="594"
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
		
	
					<h4>How much money has Illinois paid into its retirement systems this fiscal year?</h4>
					<table class="table table-sorting table-striped table-2018">
						<tr>
							<th class="bg-info">Type</th>
							<th class="bg-info text-right">Current FY Amount</th>
							<th class="bg-info text-right">Previous FY Amount</th>
						</tr>
						<tr>
							<td>SERS, SURS, JRS, AND GARS</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?ObjeSel=&ApprGrpSel=&ApprCatSel=1160&ApprTypeSel=&ApprClsSel=&GroupBy=Agcy&FY=#application.PopularQueryFY#&Type=B&submitted=">#DollarFormat(cfy_sers.exptotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?ObjeSel=&ApprGrpSel=&ApprCatSel=1160&ApprTypeSel=&ApprClsSel=&GroupBy=Agcy&FY=#application.pfy#&Type=B&submitted=">#DollarFormat(pfy_sers.exptotal)#</a></td>
						</tr>
						<tr>
							<td>TRS</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?AgcySel=593&AgcyGrpSel=0&AgcyCatSel=0&AgcyTypeSel=0&GroupBy=Obje&FY=#application.PopularQueryFY#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=">#DollarFormat(cfy_TRS.exptotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?AgcySel=593&AgcyGrpSel=0&AgcyCatSel=0&AgcyTypeSel=0&GroupBy=Obje&FY=#application.pfy#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=">#DollarFormat(pfy_TRS.exptotal)#</a></td>
						</tr>
						<tr>
							<td>CTPF</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?AgcySel=594&AgcyGrpSel=0&AgcyCatSel=0&AgcyTypeSel=0&GroupBy=Obje&FY=#application.PopularQueryFY#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=">#DollarFormat(cfy_TRSC.exptotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?AgcySel=594&AgcyGrpSel=0&AgcyCatSel=0&AgcyTypeSel=0&GroupBy=Obje&FY=#application.pfy#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=">#DollarFormat(pfy_TRSC.exptotal)#</a></td>
						</tr>
						<tr>
							<td>SURS (Annual certified payment from State Pensions Fund)</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?GroupBy=Agcy&FY=#application.PopularQueryFY#&ShowMo=Yes&ShowBudg=Yes&ShowLapse=No&FundSel=0054&FundGrpSel=&AgcySel=693&AgcyGrpSel=&AgcyTypeSel=&AgcyCatSel=&RevSel=&RevClsSel=&RevGrpSel=&RevTypeSel=&Type=A&ObjeSel=&ObjeGrpSel=&ObjeCatSel=&ObjeTypeSel=">#DollarFormat(cfy_SURS.exptotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?GroupBy=Agcy&FY=#application.pfy#&ShowMo=Yes&ShowBudg=Yes&ShowLapse=No&FundSel=0054&FundGrpSel=&AgcySel=693&AgcyGrpSel=&AgcyTypeSel=&AgcyCatSel=&RevSel=&RevClsSel=&RevGrpSel=&RevTypeSel=&Type=A&ObjeSel=&ObjeGrpSel=&ObjeCatSel=&ObjeTypeSel=">#DollarFormat(pfy_SURS.exptotal)#</a></td>							
						</tr>						
					</table>
	</cfoutput> 
					<h3>About Pension System Funding</h3>
					<p>Each year, the state is required to make contributions to its statutory pension systems: State Employees&#39 Retirement System (SERS), State 
					Universities Retirement System (SURS), Judges&#39 Retirement System (JRS), General Assembly Retirement System (GARS) and Teachers&#39 Retirement 
					System (TRS). The state&#39s contributions to SERS come from payment requests directly from SERS and from state agency payrolls. Contributions 
					to GARS, JRS, SURS and TRS are vouchered directly by those pension systems. Additionally, the Chicago Teachers&#39 Pension Fund (CTPF) receives
					 some state appropriations, though the system is primarily funded by Chicago residents.</p>


	</div>
	<!-- END EXPENSE -->
