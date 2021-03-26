<!--- http://informationwarehouse.ioc-dev.ioc.com/Expert/Rev/ERFramesQuery.cfm?Control=Rev&GroupBy=None&Max=20&FY=16&ShowMo=NO&FundSel=&FundGrpSel=&FundTypSel=&FundCatSel=&AgcySel=&AgcyGrpSel=&AgcyTypSel=&AgcyCatSel=&RevSel=&RevClsSel=&RevGrpSel=&RevTypSel=02&SortName=No
 --->
 <cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="CFY_IndividualIncomeTax" 
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
	RevTypeSel="02"
	SortName="No"
	>

<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="CFY_CorporateIncomeTax" 
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
	RevTypeSel="03"
	SortName="No"
	>
<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="CFY_PersPropTax" 
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
	RevSel="0149"
	RevClsSel=""
	RevGrpSel=""
	RevTypeSel=""
	SortName="No"
	>

<!--- Previous FY --->	

 <cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="PFY_IndividualIncomeTax" 
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
	RevTypeSel="02"
	SortName="No"
	>

<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="PFY_CorporateIncomeTax" 
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
	RevTypeSel="03"
	SortName="No"
	>

<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="PFY_PersPropTax" 
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
	RevSel="0149"
	RevClsSel=""
	RevGrpSel=""
	RevTypeSel=""
	SortName="No"
	>
<cfoutput>
<!-- START EXPENSE -->

					<p>How much money has the state collected from taxpayers since July 1?</p>
					<table class="table table-sorting table-striped table-2018">
						<tr>
							<th class="bg-info">Type</th>
							<th class="bg-info text-right">Current FY Amount</th>
							<th class="bg-info text-right">Previous FY Amount</th>
						</tr>
						<tr>

							<!--- /index.cfm/find-a-revenue/revenue-source/?Revenue_Source=0&Group=0&Class=0&Type=02&FY=17&GroupBy=Agcy&ShowMo=Yes&GetQueryData=Search --->
							<td>Individual</td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=0&RevTypeSel=02&FY=#application.PopularQueryFY#&GroupBy=None&GetQueryData=Search">#DollarFormat(CFY_IndividualIncomeTax.RevTotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=0&RevTypeSel=02&FY=#application.pfy#&GroupBy=None&GetQueryData=Search">#DollarFormat(PFY_IndividualIncomeTax.RevTotal)#</a></td>
						</tr>
						<tr>
							<!--- Revenue_Source=0&Group=0&Class=0&Type=03&FY=17&GroupBy=Agcy&ShowMo=Yes&GetQueryData=Search --->
							<td>Corporate</td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=0&RevTypeSel=03&FY=#application.PopularQueryFY#&GroupBy=None&GetQueryData=Search">#DollarFormat(CFY_CorporateIncomeTax.RevTotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=0&RevTypeSel=03&FY=#application.pfy#&GroupBy=None&GetQueryData=Search">#DollarFormat(PFY_CorporateIncomeTax.RevTotal)#</a></td>
						</tr>
						<tr>
							<!--- ?Revenue_Source=0149&Group=0&Class=0&Type=0&FY=17&GroupBy=Agcy&ShowMo=Yes&GetQueryData=Search --->
							<td>Personal Property Replacement</td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0149&RevGrpSel=0&RevClsSel=0&RevTypeSel=0&FY=#application.PopularQueryFY#&GroupBy=None&GetQueryData=Search">#DollarFormat(CFY_PersPropTax.RevTotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0149&RevGrpSel=0&RevClsSel=0&RevTypeSel=0&FY=#application.pfy#&GroupBy=None&GetQueryData=Search">#DollarFormat(PFY_PersPropTax.RevTotal)#</a></td>
						</tr>						
					</table>

					<p>About Income Tax</p>
					<p>The income tax is the largest generator of state revenues. Most of the individual and corporate income tax revenues are deposited into the state&rsquo;s <a href="/financial-data/state-revenues/by-fund/?FundSel=0&FundGrpSel=0&FundCatSel=A+&FundTypeSel=0&GroupBy=Fund&FY=#application.PopularQueryFY#&ShowMo=Yes&submitted=" target="_blank">General Funds</a>, but a portion is deposited into the Income Tax Refund Fund to be set aside for the payment of refunds to individuals and corporations.</p>

					<p>About Personal Property Replacement Tax</p>

					<P>PPRT is an income tax on corporations, business partnerships, trusts, and "S" corporations. The revenues are primarily allocated to local governments to replace the personal property tax that was abolished by the Illinois Constitution of 1970. The State does not retain these revenues.</P>
					
					<!---<p>Click&nbsp;<a href="/find-a-revenue/income-tax/income-tax-revenues-for-fiscal-year-2016/">here</a> to find out how much the state has received in individual Income tax revenue in Fiscal Year 2016. (FY15 figures are <a href="/find-a-revenue/income-tax/income-tax-revenues-for-fiscal-year-2015/">here</a>.)</p>


					<p>Click <a href="/find-a-revenue/income-tax/corporate-income-tax-revenues-for-fiscal-year-2016/">here</a> to find out how much the state has received in corporate income tax revenuein FY15.&nbsp; (FY14 figures are <a href="/find-a-revenue/income-tax/corporate-income-tax-revenues-for-fiscal-year-2015/">here</a>.)</p>

					<p>Click <a href="/find-a-revenue/income-tax/personal-property-replacement-tax-revenues-for-fiscal-year-2016">here</a>&nbsp; to find out how much the state has received in personal property replacement tax (PPRT) revenue in FY 15. (FY14 figures are <a href="http://www.wh1.ioc.state.il.us/Expert/Rev/ERFramesQuery.cfm?Control=Rev&amp;GroupBy=Fund&amp;Max=20&amp;FY=14&amp;ShowMo=NO&amp;FundSel=&amp;FundGrpSel=&amp;FundTypSel=&amp;FundCatSel=&amp;AgcySel=&amp;AgcyGrpSel=&amp;AgcyTypSel=&amp;AgcyCatSel=&amp;RevSel=0149&amp;RevClsSel=&amp;RevGrpSel=&amp;RevTypSel=&amp;SortName=No&amp;CFID=5008687&amp;CFTOKEN=90480eb3e411f5c9-11D2F472-5056-932D-88E2497BB05EA0D8">here</a>.)&nbsp;&nbsp; PPRT is an income tax on corporations, business partnerships, trusts and &ldquo;S&rdquo; corporations.&nbsp; The revenues are primarily allocated to local governments to replace the personal property tax that was abolished by the Illinois Constitution of 1970. The State does not retain these revenues.</p>--->

	<!-- END EXPENSE -->
	</cfoutput>