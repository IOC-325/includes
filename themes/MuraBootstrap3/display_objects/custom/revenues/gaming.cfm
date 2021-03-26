<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="CFY_Riverboat" 
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
	RevClsSel="532"
	RevGrpSel=""
	RevTypSel=""
	SortName="No"
	>

<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="CFY_VideoGambling" 
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
	RevClsSel="534"
	RevGrpSel=""
	RevTypSel=""
	SortName="No"
	>
<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="CFY_StateLottery" 
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
	RevClsSel="380"
	RevGrpSel=""
	RevTypSel=""
	SortName="No"
	>

	<!--- PREVIOUS FY --->
<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="PFY_Riverboat" 
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
	RevClsSel="532"
	RevGrpSel=""
	RevTypSel=""
	SortName="No"
	>

<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="PFY_VideoGambling" 
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
	RevClsSel="534"
	RevGrpSel=""
	RevTypSel=""
	SortName="No"
	>
<cfinvoke component="Queries.revenues" 
	method="RevenueTotalsQuery" 
	returnvariable="PFY_StateLottery" 
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
	RevClsSel="380"
	RevGrpSel=""
	RevTypSel=""
	SortName="No"
	>
	<cfoutput>
<!-- START EXPENSE -->

					<p>How much money has the state collected from levies of gaming in Illinois since July 1?</p>
					<table class="table table-sorting table-striped table-2018">
						<tr>
							<th class="bg-info">Type</th>
							<th class="bg-info text-right">Current FY Amount</th>
							<th class="bg-info text-right">Previous FY</th>
						</tr>
						<tr>
							<td>Riverboat Gaming</td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=532&RevTypeSel=0&FY=#application.PopularQueryFY#&GroupBy=None&GetQueryData=Search">#DollarFormat(CFY_Riverboat.RevTotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=532&RevTypeSel=0&FY=#application.pfy#&GroupBy=None&GetQueryData=Search">#DollarFormat(PFY_Riverboat.RevTotal)#</a></td>
						</tr>
						<tr>
							<td>Video Gaming Tax</td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=534&RevTypeSel=0&FY=#application.PopularQueryFY#&GroupBy=None&GetQueryData=Search">#DollarFormat(CFY_VideoGambling.RevTotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=534&RevTypeSel=0&FY=#application.pfy#&GroupBy=None&GetQueryData=Search">#DollarFormat(PFY_VideoGambling.RevTotal)#</a></td>
						</tr>
						<tr>
							<td>State Lottery</td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=380&RevTypeSel=0&FY=#application.PopularQueryFY#&GroupBy=None&GetQueryData=Search">#DollarFormat(CFY_StateLottery.RevTotal)#</a></td>
							<td class="text-right"><a href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=380&RevTypeSel=0&FY=#application.pfy#&GroupBy=None&GetQueryData=Search">#DollarFormat(PFY_StateLottery.RevTotal)#</a></td>
						</tr>						
					</table>
 
					<h3>About Riverboat Gaming</h3>
					<p>Illinois has 10 riverboats which generate revenue from wagering taxes, license fees and part of the admissions tax. 
					These revenues are deposited into the 
					<a href="/financial-data/state-revenues/by-fund?FundSel=0129&FundGrpSel=0&FundCatSel=0&FundTypeSel=0&GroupBy=RevType&FY=#application.PopularQueryFY#&ShowMo=Yes&submitted=" target="_blank">
					State Gaming Fund</a>. The State Gaming Fund supports the 
					<a href="/financial-data/state-expenditures/by-agency?AgcySel=565&AgcyGrpSel=0&AgcyCatSel=0&AgcyTypeSel=0&GroupBy=Obje&FY=#application.PopularQueryFY#&Type=A&ShowBudg=Yes&ShowLapse=Yes&submitted=" target="_blank">
					operations of the Gaming Board</a> and makes transfers into the General Funds for education spending.</p>
                  
                    <p>The Gaming Board tracks each boat's profits and how much of them are disbursed to the state and local governments. 
					<a href="https://www.igb.illinois.gov/RiverboatReports.aspx" target="_blank">The Board's monthly reports can be found on its website</a>. </p>

					<div class="well">
					<p>Licenses and Fees</p>
					<p>This query shows the amount from riverboat licensing fees deposited into the General Revenue Fund and State Gaming Fund</p>
					<!--- <button type="button" class="btn btn-success center-block">VIEW THESE AMOUNTS</BUTTON> --->
					<p class="text-center">
						<a class="btn btn-success" href="/financial-data/state-revenues/by-revenue-source/?RevSel=1034&RevGrpSel=0&RevClsSel=0&RevTypeSel=0&FY=#application.PopularQueryFY#&GroupBy=Rev&ShowMo=Yes&GetQueryData=Search" target="_blank" role="button">VIEW THESE AMOUNTS</a></p>
 					</div>

					<h3 class="margintop30">About Video Gaming Tax</h3>
					<!--- /index.cfm/find-a-revenue/fund/?FundSel=0694&FundGrpSel=Default&FundCatSel=Default&FundTypeSel=Default&GroupBy=Rev&FY=17&ShowMo=Yes&AgcySel=&AgcyGrpSel=&AgcyTypeSel=&AgcyCatSel=&RevSel=&RevClsSel=&RevGrpSel=&RevTypeSel= --->
					<P>The State collects license fees and video gaming taxes from video gaming terminals at locations throughout the state. A portion of the tax is returned to 
					local governments where the tax was collected. The remainder is deposited into the 
					<a href="/financial-data/state-revenues/by-fund?FundSel=0694&FundGrpSel=Default&FundCatSel=Default&FundTypeSel=Default&GroupBy=Rev&FY=#application.PopularQueryFY#&ShowMo=Yes&AgcySel=&AgcyGrpSel=&AgcyTypeSel=&AgcyCatSel=&RevSel=&RevClsSel=&RevGrpSel=&RevTypeSel=" target="_blank">
					Capital Projects Fund</a> to cover costs related to the state's 2009 capital plan.</P>

					<div class="well">
					<p>Licenses and Fees</p>
					<p>View licenses and fees deposited into the State Gaming Fund, which includes video gaming fee revenues (identified by a VGA identifier at the beginning of the revenue source name).</p>
					<p class="text-center">
					<a class="btn btn-success" href="/financial-data/state-revenues/by-revenue-source?RevSel=0&RevGrpSel=0&RevClsSel=534&RevTypeSel=0&FY=#application.PopularQueryFY#&GroupBy=None&ShowMo=Yes&GetQueryData=Search" target="_blank" role="button">VIEW THESE AMOUNTS</a></p>
 					</div>

 					<h3 class="margintop30">About State Lottery</h3>
 					<!--- /index.cfm/find-an-expense/by-agency/?AgcySel=458&AgcyGrpSel=0&AgcyCatSel=0&AgcyTypeSel=0&GroupBy=Obje&FY=17&Type=A&ShowBudg=Yes&ShowLapse=Yes&submitted= --->
					<P>These totals include monies which will be paid out to winners and will cover 
					<a href="/financial-data/state-expenditures/by-agency?AgcySel=458&AgcyGrpSel=0&AgcyCatSel=0&AgcyTypeSel=0&GroupBy=Obje&FY=#application.PopularQueryFY#&Type=A&ShowBudg=Yes&ShowLapse=Yes&submitted=" target="_blank">
					administrative costs of the Department of Lottery</a>. A portion of the amount deposited into the State Lottery Fund will be transferred to the General Funds for education spending and a portion will be transferred to the Capital Projects Fund for costs related to the state's 2009 capital plan.</P>

	<!-- END EXPENSE -->
	</cfoutput>