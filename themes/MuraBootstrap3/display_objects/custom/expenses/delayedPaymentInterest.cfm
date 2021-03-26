<!--- CURRENT FY --->
<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="CFY_CurrentYearPPI" 
	control="Objt"
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
	ApprCatSel=""
	ObjeSel=""
	ObjtSel="1991"
	ObjtClsSel=""
	ObjtGrpSel=""
	ObjtTypSel=""
	ObjtCatSel=""
	SortName="No"
	>

<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="CFY_FutureYearPPI" 
	control="Objt"
	GroupBy="None"
	Max="20"
	FY="#application.PopularQueryFY#"
	Type="B"
	ShowBudg="No"
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
	ApprCatSel=""
	ObjeSel=""
	ObjtSel="1995"
	ObjtClsSel=""
	ObjtGrpSel=""
	ObjtTypSel=""
	ObjtCatSel=""
	SortName="No"
	>

<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="CFY_OtherInterests" 
	control="Objt"
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
	ApprCatSel=""
	ObjeSel=""
	ObjtSel="1994"
	ObjtClsSel=""
	ObjtGrpSel=""
	ObjtTypSel=""
	ObjtCatSel=""
	SortName="No"
	>


<!--- PREVIOUS FY --->
<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="PFY_CurrentYearPPI" 
	control="Objt"
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
	ApprCatSel=""
	ObjeSel=""
	ObjtSel="1991"
	ObjtClsSel=""
	ObjtGrpSel=""
	ObjtTypSel=""
	ObjtCatSel=""
	SortName="No"
	>

<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="PFY_FutureYearPPI" 
	control="Objt"
	GroupBy="None"
	Max="20"
	FY="#application.pfy#"
	Type="B"
	ShowBudg="No"
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
	ApprCatSel=""
	ObjeSel=""
	ObjtSel="1995"
	ObjtClsSel=""
	ObjtGrpSel=""
	ObjtTypSel=""
	ObjtCatSel=""
	SortName="No"
	>

<cfinvoke component="Queries.expenditures" 
	method="ExpenditureTotalsQuery" 
	returnvariable="PFY_OtherInterests" 
	control="Objt"
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
	ApprCatSel=""
	ObjeSel=""
	ObjtSel="1994"
	ObjtClsSel=""
	ObjtGrpSel=""
	ObjtTypSel=""
	ObjtCatSel=""
	SortName="No"
	>
<cfoutput>
<!-- START EXPENSE -->
	<div id="expense" class="revenue">
					<h4>How much money has Illinois spent because it did not pay its bills on time?</h4>
					<table class="table table-sorting table-striped table-2018">
						<tr>
							<th class="bg-info">Type</th>
							<th class="bg-info text-right">Current FY Amount</th>
							<th class="bg-info text-right">Previous FY Amount</th>							
						</tr>
						<tr>
							<td>Current Year Interest</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/detail-object/?ObjtSel=1991&ObjtGrpSel=&ObjtCatSel=&ObjtTypeSel=&ObjtClsSel=&GroupBy=Agcy&FY=#application.PopularQueryFY#&Type=B&ShowMo=Yes&ShowBudg=Yes">#DollarFormat(CFY_CurrentYearPPI.exptotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/detail-object/?ObjtSel=1991&ObjtGrpSel=&ObjtCatSel=&ObjtTypeSel=&ObjtClsSel=&GroupBy=Agcy&FY=#application.pfy#&Type=B&ShowMo=Yes&ShowBudg=Yes">#DollarFormat(PFY_CurrentYearPPI.exptotal)#</a></td>							
						</tr>
						<tr>
							<td>Future Year Interest</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/detail-object/?ObjtSel=1995&ObjtGrpSel=&ObjtCatSel=&ObjtTypeSel=&ObjtClsSel=&GroupBy=Agcy&FY=#application.PopularQueryFY#&Type=B&ShowMo=Yes&ShowBudg=Yes">#DollarFormat(CFY_FutureYearPPI.exptotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/detail-object/?ObjtSel=1995&ObjtGrpSel=&ObjtCatSel=&ObjtTypeSel=&ObjtClsSel=&GroupBy=Agcy&FY=#application.pfy#&Type=B&ShowMo=Yes&ShowBudg=Yes">#DollarFormat(PFY_FutureYearPPI.exptotal)#</a></td>
						</tr>
						<tr>
							<td>Other Costs</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/detail-object/?ObjtSel=1994&ObjtGrpSel=&ObjtCatSel=&ObjtTypeSel=&ObjtClsSel=&GroupBy=Agcy&FY=#application.PopularQueryFY#&Type=B&ShowMo=Yes&ShowBudg=Yes">#DollarFormat(CFY_OtherInterests.exptotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/detail-object/?ObjtSel=1994&ObjtGrpSel=&ObjtCatSel=&ObjtTypeSel=&ObjtClsSel=&GroupBy=Agcy&FY=#application.pfy#&Type=B&ShowMo=Yes&ShowBudg=Yes">#DollarFormat(PFY_OtherInterests.exptotal)#</a></td>
						</tr>						
					</table>
 
	</cfoutput>
	     			<h3>About Late Payment Interest Penalties</h3>
					<p>The state is required to pay certain vendors interest costs when bills eligible for late payment interest penalties are not paid on time. Most interest, which is called 
					prompt pay interest, is paid under the <a href="http://www.ilga.gov/legislation/ilcs/ilcs3.asp?ActID=539&ChapAct=30%C2%A0ILCS%C2%A0540/&ChapterID=7&ChapterName=FINANCE&ActName=State%20Prompt%20Payment%20Act." 
					target="_blank">State Prompt Payment Act</a> at a rate of 1% per month after 90 days, either from current year or following year appropriations provided to the agencies. 
					Other interest, called timely pay interest, is paid under the <a href="http://www.ilga.gov/legislation/ilcs/ilcs5.asp?ActID=1249&ChapterID=22" target="_blank">Illinois Insurance Code</a>
					at a rate of 9% per year after 60 days. Three detailed object codes in the state&#39s accounting system pick up these interest costs. To get the total cost of interest paid, add the 
					three totals in the table above.</p>

	</div>
	<!-- END EXPENSE -->
