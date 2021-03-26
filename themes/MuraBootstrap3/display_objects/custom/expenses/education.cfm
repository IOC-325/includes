<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="resultsCY" 
	control="Agcy"
	GroupBy="None"
	Max="20"
	FY="#application.PopularQueryFY#"
	Type="A"
	ShowBudg="NO"
	ShowMo="NO"
	ShowLapse="NO"
	FundSel=""
	FundClsSel=""
	FundGrpSel=""
	FundTypSel=""
	FundCatSel=""
	AgcySel="586"
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
	returnvariable="resultsPY" 
	control="Agcy"
	GroupBy="None"
	Max="20"
	FY="#application.pfy#"
	Type="A"
	ShowBudg="NO"
	ShowMo="NO"
	ShowLapse="NO"
	FundSel=""
	FundClsSel=""
	FundGrpSel=""
	FundTypSel=""
	FundCatSel=""
	AgcySel="586"
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

					<h4>How much money does the state pay for education?</h4>
					<table class="table table-sorting table-striped table-2018">
						<tr>
							<th class="bg-info">Type</th>
							<th class="bg-info text-right">Current FY Amount</th>
							<th class="bg-info text-right">Previous FY Amount</th>
						</tr>
						<tr>
							<td>K-12 Education Spending</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?AgcySel=586&AgcyGrpSel=0&AgcyCatSel=0&AgcyTypeSel=0&GroupBy=Obje&FY=#application.PopularQueryFY#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=" target="_blank">#Dollarformat(resultsCY.exptotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/by-agency?AgcySel=586&AgcyGrpSel=0&AgcyCatSel=0&AgcyTypeSel=0&GroupBy=Obje&FY=#application.pfy#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=" target="_blank">#Dollarformat(resultsPY.exptotal)#</a></td>
						</tr>				
					</table>
 
					<h3>About K - 12 Education Spending</h3>
					<p>General State Aid and other major state educational grant programs are paid through the 
					<a href="/financial-data/state-expenditures/by-fund?GroupBy=Obje&FY=#application.PopularQueryFY#&ShowMo=Yes&ShowBudg=Yes&ShowLapse=No&FundSel=0001&FundGrpSel=&FundCatSel=&AgcySel=586&AgcyGrpSel=&AgcyTypeSel=&AgcyCatSel=&RevSel=&RevClsSel=&RevGrpSel=&RevTypeSel=&Type=A&ObjeSel=&ObjeGrpSel=&ObjeCatSel=&ObjeTypeSel=" target="_blank">General Revenue Fund</a>, the
					<a href="/financial-data/state-expenditures/by-fund?FundSel=0007&FundGrpSel=0&FundCatSel=0&FundTypeSel=0&GroupBy=Agcy&FY=#application.PopularQueryFY#&Type=A&ShowMo=Yes&ShowBudg=Yes&submitted=" target="_blank">Education Assistance Fund</a>, the 
					<a href="/financial-data/state-expenditures/by-fund?GroupBy=Obje&FY=#application.PopularQueryFY#&ShowMo=Yes&ShowBudg=Yes&ShowLapse=No&FundSel=0412&FundGrpSel=&FundCatSel=&AgcySel=586&AgcyGrpSel=&AgcyTypeSel=&AgcyCatSel=&RevSel=&RevClsSel=&RevGrpSel=&RevTypeSel=&Type=A&ObjeSel=&ObjeGrpSel=&ObjeCatSel=&ObjeTypeSel=" target="_blank">Common School Fund</a>, and the 
					<a href="/financial-data/state-expenditures/by-fund/?FundSel=0640&FundGrpSel=0&FundCatSel=0&FundTypeSel=0&GroupBy=Agcy&FY=#application.PopularQueryFY#&Type=A&ShowMo=Yes&ShowBudg=Yes&ShowLapse=Yes&submitted=" target="_blank">Fund for the Advancement of Education</a> (four of the seven General Funds in the state treasury). Several of the funds listed here 
					<a href="/financial-data/state-revenues/by-revenue-source?GetQueryData=true&Revenue_Source=Default&Group=26&Class=Default&Type=Default&GroupBy=Rev&FY=#application.PopularQueryFY#&ShowMo=Yes&FundSel=&FundGrpSel=&FundTypeSel=&FundCatSel=&AgcyGrpSel=&AgcyTypeSel=&AgcyCatSel=&AgcySel=586&RevSel=&RevClsSel=&RevGrpSel=&RevTypeSel=" target="_blank">collect federal revenues</a>, which the State Board of Education passes 
					on to local school districts. Most of state education spending is through state grants to local school districts, but spending also includes 
					operationals for the State Board of Education.</p>
	</div>
	<!-- END EXPENSE -->
	</cfoutput>