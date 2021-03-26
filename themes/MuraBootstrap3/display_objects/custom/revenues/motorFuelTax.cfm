<!--- http://www.wh1.ioc.state.il.us/Expert/Rev/ERFramesQuery.cfm?Control=Rev&GroupBy=None&Max=20&FY=16&ShowMo=YES&FundSel=&FundGrpSel=&FundTypSel=&FundCatSel=&AgcySel=&AgcyGrpSel=&AgcyTypSel=&AgcyCatSel=&RevSel=1034&RevClsSel=&RevGrpSel=&RevTypSel=&SortName=No--->

<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="CFY_MotorFuelTax" 
	Control="Rev" 
	GroupBy="Fund"
	Max="20"
	FY="#application.PopularQueryFY#"
	ShowMo="NO"
	FundSel=""
	FundGrpSel=""
	FundTypSel=""
	FundCatSel=""
	AgcySel =""
	AgcyGrpSel=""
	AgcyTypSel=""
	AgcyCatSel=""
	RevSel=""
	RevClsSel=""
	RevGrpSel=""
	RevTypeSel="09"
	SortName="No"
	>
<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="PFY_MotorFuelTax" 
	Control="Rev" 
	GroupBy="Fund"
	Max="20"
	FY="#application.pfy#"
	ShowMo="NO"
	FundSel=""
	FundGrpSel=""
	FundTypSel=""
	FundCatSel=""
	AgcySel =""
	AgcyGrpSel=""
	AgcyTypSel=""
	AgcyCatSel=""
	RevSel=""
	RevClsSel=""
	RevGrpSel=""
	RevTypeSel="09"
	SortName="No"
	>
<cfoutput>
<!-- START EXPENSE -->

					<p>How much money has the state collected from the drivers at pumps in Illinois since July 1?</p>
					<table class="table table-sorting table-striped table-2018">
						<tr>
							<th class="bg-info text">Type</th>
							<th class="bg-info text-right">Current FY Amount</th>
							<th class="bg-info text-right">Previous FY Amount</th>
						</tr>
						<tr>
							<!--- /index.cfm/find-a-revenue/revenue-source/?Revenue_Source=0&Group=0&Class=0&Type=09&FY=17&GroupBy=Agcy&ShowMo=Yes&GetQueryData=Search --->
							<td>Motor Fuel Tax</td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=0&RevTypeSel=09&FY=#application.PopularQueryFY#&GroupBy=None&GetQueryData=Search">#DollarFormat(CFY_motorFuelTax.RevTotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=0&RevTypeSel=09&FY=#application.pfy#&GroupBy=None&GetQueryData=Search">#DollarFormat(PFY_motorFuelTax.RevTotal)#</a></td>
						</tr>				
					</table>
 
					<p>About Motor Fuel Tax</p>
					<!--- /index.cfm/find-a-revenue/fund/?  --->
					
					<p>After revenues are 
					<a href="/financial-data/state-revenues/by-fund?FundSel=0012&FundGrpSel=0&FundCatSel=0&FundTypeSel=0&GroupBy=RevType&FY=#application.PopularQueryFY#&ShowMo=Yes&submitted=" target="_blank">
					deposited into the Motor Fuel Tax Fund</a>, they are transferred into state construction funds, the 
					<a href="/financial-data/state-revenues/by-fund?FundSel=0414&FundGrpSel=0&FundCatSel=0&FundTypeSel=0&GroupBy=RevType&FY=#application.PopularQueryFY#&ShowMo=Yes&submitted=" target="_blank">Motor Fuel Tax - Municipalities Fund</a>, the <a href="/financial-data/state-revenues/by-fund?FundSel=0415&FundGrpSel=0&FundCatSel=0&FundTypeSel=0&GroupBy=RevType&FY=#application.PopularQueryFY#&ShowMo=Yes&submitted=" target="_blank">Motor Fuel Tax Fund - Town and Road Districts</a>, and the <a href="/financial-data/state-revenues/by-fund/?FundSel=0413&FundGrpSel=0&FundCatSel=0&FundTypeSel=0&GroupBy=RevType&FY=#application.PopularQueryFY#&ShowMo=Yes&submitted=" target="_blank">Motor Fuel Tax Fund - Counties</a>
					. The amounts transferred to the local government funds are distributed for local road construction projects. An amendment to the state constitution adopted by Illinois voters in November 2016 prohibits revenues from the Motor Fuel Tax to be used for purposes other than transportation costs.</p>

	<!-- END EXPENSE -->
	</cfoutput>