<!--- Control=Rev&GroupBy=Fund&Max=20&FY=14&ShowMo=NO&FundSel=&FundGrpSel=&FundTypSel=&FundCatSel=&AgcySel=&AgcyGrpSel=&AgcyTypSel=&AgcyCatSel=&RevSel=&RevClsSel=&RevGrpSel=&RevTypSel=09&SortName=No
 --->
<cfinvoke component="Queries.revenues" 
	method="RevenueQuery" 
	returnvariable="results" 
	Control="Rev" 
	GroupBy="Fund"
	Max="20"
	FY="16"
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
	RevTypSel="09"
	SortName="No"
	>

<cfdump var="#results#">

<cfoutput>
<!-- START EXPENSE -->
	<div id="expense" class="revenue">
		<div class="container">
			<div class="row">	
				<div class="col-md-10 col-md-offset-1">
					<h1>Sales Tax Revenues</h1>
					<h4>How much money does the state collect from working taxpayers?</h4>
					<p>The income tax is the largest generator of state source revenues. Most of the individual and corporate income tax revenues are deposited into the state&rsquo;s General Funds, but a portion is deposited into the Income Tax Refund Fund (##278) to be set aside for the payment of refunds to individuals and corporations.</p>
					<p>Click&nbsp;<a href="http://www.wh1.ioc.state.il.us/Expert/Rev/ERFramesQuery.cfm?Control=Rev&amp;GroupBy=Fund&amp;Max=20&amp;FY=15&amp;ShowMo=NO&amp;FundSel=&amp;FundGrpSel=&amp;FundTypSel=&amp;FundCatSel=&amp;AgcySel=&amp;AgcyGrpSel=&amp;AgcyTypSel=&amp;AgcyCatSel=&amp;RevSel=&amp;RevClsSel=&amp;RevGrpSel=&amp;RevTypSel=02&amp;SortName=No&amp;CFID=5018056&amp;CFTOKEN=988828b4f30b5291-373E9022-5056-932D-8878D660ACE57550&amp;jsessionid=6762E083D488E5E9D7FC89652DD1088C.cfusion">here</a> to find out how much the state has received in individual Income tax revenue in Fiscal Year 2015. (FY14 figures are <a href="http://www.wh1.ioc.state.il.us/Expert/Rev/ERFramesQuery.cfm?Control=Rev&amp;GroupBy=Fund&amp;Max=20&amp;FY=14&amp;ShowMo=NO&amp;FundSel=&amp;FundGrpSel=&amp;FundTypSel=&amp;FundCatSel=&amp;AgcySel=&amp;AgcyGrpSel=&amp;AgcyTypSel=&amp;AgcyCatSel=&amp;RevSel=&amp;RevClsSel=&amp;RevGrpSel=&amp;RevTypSel=02&amp;SortName=No&amp;CFID=4645347&amp;CFTOKEN=b40e1865a019bcf-0B986507-5056-932D-88283FF3EA919B40">here</a>.)</p>
					<p>Click <a href="http://www.wh1.ioc.state.il.us/Expert/Rev/ERFramesQuery.cfm?Control=Rev&amp;GroupBy=Fund&amp;Max=20&amp;FY=15&amp;ShowMo=NO&amp;FundSel=&amp;FundGrpSel=&amp;FundTypSel=&amp;FundCatSel=&amp;AgcySel=&amp;AgcyGrpSel=&amp;AgcyTypSel=&amp;AgcyCatSel=&amp;RevSel=0148&amp;RevClsSel=&amp;RevGrpSel=&amp;RevTypSel=&amp;SortName=No&amp;CFID=5018056&amp;CFTOKEN=988828b4f30b5291-373E9022-5056-932D-8878D660ACE57550&amp;jsessionid=6762E083D488E5E9D7FC89652DD1088C.cfusion">here</a> to find out how much the state has received in corporate income tax revenuein FY15.&nbsp; (FY14 figures are <a href="http://www.wh1.ioc.state.il.us/Expert/Rev/ERFramesQuery.cfm?Control=Rev&amp;GroupBy=Fund&amp;Max=20&amp;FY=14&amp;ShowMo=NO&amp;FundSel=&amp;FundGrpSel=&amp;FundTypSel=&amp;FundCatSel=&amp;AgcySel=&amp;AgcyGrpSel=&amp;AgcyTypSel=&amp;AgcyCatSel=&amp;RevSel=0148&amp;RevClsSel=&amp;RevGrpSel=&amp;RevTypSel=&amp;SortName=No&amp;CFID=5008687&amp;CFTOKEN=90480eb3e411f5c9-11D2F472-5056-932D-88E2497BB05EA0D8">here</a>.)</p>
					<p>Click <a href="http://www.wh1.ioc.state.il.us/Expert/Rev/ERFramesQuery.cfm?Control=Rev&amp;GroupBy=Fund&amp;Max=20&amp;FY=15&amp;ShowMo=NO&amp;FundSel=&amp;FundGrpSel=&amp;FundTypSel=&amp;FundCatSel=&amp;AgcySel=&amp;AgcyGrpSel=&amp;AgcyTypSel=&amp;AgcyCatSel=&amp;RevSel=0149&amp;RevClsSel=&amp;RevGrpSel=&amp;RevTypSel=&amp;SortName=No&amp;CFID=5018056&amp;CFTOKEN=988828b4f30b5291-373E9022-5056-932D-8878D660ACE57550&amp;jsessionid=6762E083D488E5E9D7FC89652DD1088C.cfusion">here</a>&nbsp; to find out how much the state has received in personal property replacement tax (PPRT) revenue in FY 15. (FY14 figures are <a href="http://www.wh1.ioc.state.il.us/Expert/Rev/ERFramesQuery.cfm?Control=Rev&amp;GroupBy=Fund&amp;Max=20&amp;FY=14&amp;ShowMo=NO&amp;FundSel=&amp;FundGrpSel=&amp;FundTypSel=&amp;FundCatSel=&amp;AgcySel=&amp;AgcyGrpSel=&amp;AgcyTypSel=&amp;AgcyCatSel=&amp;RevSel=0149&amp;RevClsSel=&amp;RevGrpSel=&amp;RevTypSel=&amp;SortName=No&amp;CFID=5008687&amp;CFTOKEN=90480eb3e411f5c9-11D2F472-5056-932D-88E2497BB05EA0D8">here</a>.)&nbsp;&nbsp; PPRT is an income tax on corporations, business partnerships, trusts and &ldquo;S&rdquo; corporations.&nbsp; The revenues are primarily allocated to local governments to replace the personal property tax that was abolished by the Illinois Constitution of 1970. The State does not retain these revenues.</p>
				</div>
			</div>	
		</div>
	</div>
	<!-- END EXPENSE -->
	</cfoutput>