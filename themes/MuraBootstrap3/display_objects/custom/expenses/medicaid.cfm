<!--- ---------------------------------------------------
SR:     20117
Date Modified:   11/09/2020
Author: Daniel Seales
Update: Added function to show the current fiscal year
		and the previous two years.
---------------------------------------------------- --->

<!--- SET UP PAGE --->
<CFPARAM NAME = "DHS_CFY_TOTAL" DEFAULT="0">
<CFPARAM NAME = "DHS_PFY_TOTAL" DEFAULT="0">
<CFPARAM NAME = "DHS_PPFY_TOTAL" DEFAULT="0">

<CFPARAM NAME = "HFS_CFY_TOTAL" DEFAULT="0">
<CFPARAM NAME = "HFS_PFY_TOTAL" DEFAULT="0">
<CFPARAM NAME = "HFS_PPFY_TOTAL" DEFAULT="0">

<CFPARAM NAME = "AGING_CFY_TOTAL" DEFAULT="0">
<CFPARAM NAME = "AGING_PFY_TOTAL" DEFAULT="0">
<CFPARAM NAME = "AGING_PPFY_TOTAL" DEFAULT="0">

<!--- DHS CURRENT FY --->
<cfinvoke component="Queries.expenditures" 
	method="MEDICAID_EXP_DHS_CFY_QUERY" 
	returnvariable="Q_MEDICAID_EXP_DHS_CFY_QUERY">
	<cfinvokeargument  name="fiscal_year"  value="#application.cfy#">
</cfinvoke>

<!--- DHS PREVIOUS FY --->
<cfinvoke component="Queries.expenditures" 
	method="MEDICAID_EXP_DHS_CFY_QUERY" 
	returnvariable="Q_MEDICAID_EXP_DHS_PFY_QUERY">
	<cfinvokeargument  name="fiscal_year"  value="#application.pfy#">
</cfinvoke>

<!--- DHS PREVIOUS PREVIOUS FY --->
<cfinvoke component="Queries.expenditures" 
	method="MEDICAID_EXP_DHS_CFY_QUERY" 
	returnvariable="Q_MEDICAID_EXP_DHS_PPFY_QUERY">
	<cfinvokeargument  name="fiscal_year"  value="#application.PPFY#">
</cfinvoke>

<!--- HFS CURRENT FY --->
<cfinvoke component="Queries.expenditures" 
	method="MEDICAID_EXP_HFS_CFY_QUERY" 
	returnvariable="Q_MEDICAID_EXP_HFS_CFY_QUERY">
	<cfinvokeargument  name="fiscal_year"  value="#application.cfy#">
</cfinvoke>

<!--- HFS PREVIOUS FY --->
<cfinvoke component="Queries.expenditures" 
	method="MEDICAID_EXP_HFS_CFY_QUERY" 
	returnvariable="Q_MEDICAID_EXP_HFS_PFY_QUERY">
	<cfinvokeargument  name="fiscal_year"  value="#application.pfy#">
</cfinvoke>

<!--- HFS PREVIOUS PREVIOUS FY --->
<cfinvoke component="Queries.expenditures" 
	method="MEDICAID_EXP_HFS_CFY_QUERY" 
	returnvariable="Q_MEDICAID_EXP_HFS_PPFY_QUERY">
	<cfinvokeargument  name="fiscal_year"  value="#application.PPFY#">
</cfinvoke>

<!--- AGING CURRENT FY --->
<cfinvoke component="Queries.expenditures" 
	method="MEDICAID_EXP_AGING_CFY_QUERY" 
	returnvariable="Q_MEDICAID_EXP_AGING_CFY_QUERY">
	<cfinvokeargument name="fiscal_year"  value="#application.cfy#">
</cfinvoke>

<!--- AGING PREVIOUS FY --->
<cfinvoke component="Queries.expenditures" 
	method="MEDICAID_EXP_AGING_CFY_QUERY" 
	returnvariable="Q_MEDICAID_EXP_AGING_PFY_QUERY">
	<cfinvokeargument name="fiscal_year"  value="#application.pfy#">
</cfinvoke>

<!--- AGING PREVIOUS PREVIOUS FY --->
<cfinvoke component="Queries.expenditures" 
	method="MEDICAID_EXP_AGING_CFY_QUERY" 
	returnvariable="Q_MEDICAID_EXP_AGING_PPFY_QUERY">
	<cfinvokeargument name="fiscal_year"  value="#application.PPFY#">
</cfinvoke>


<!--- SET VARIABLES--->

<!--- HFS --->
<cfif LEN(Q_MEDICAID_EXP_HFS_CFY_QUERY.EXPTOTAL)>
	<cfset HFS_CFY_TOTAL = Q_MEDICAID_EXP_HFS_CFY_QUERY.EXPTOTAL>
</cfif>

<cfif LEN(Q_MEDICAID_EXP_HFS_PFY_QUERY.EXPTOTAL)>
	<cfset HFS_PFY_TOTAL = Q_MEDICAID_EXP_HFS_PFY_QUERY.EXPTOTAL>
</cfif>

<cfif LEN(Q_MEDICAID_EXP_HFS_PPFY_QUERY.EXPTOTAL)>
	<cfset HFS_PPFY_TOTAL = Q_MEDICAID_EXP_HFS_PPFY_QUERY.EXPTOTAL>
</cfif>

<!--- AGING --->
<cfif LEN(Q_MEDICAID_EXP_AGING_CFY_QUERY.EXPTOTAL)>
	<cfset AGING_CFY_TOTAL = Q_MEDICAID_EXP_AGING_CFY_QUERY.EXPTOTAL>
</cfif>

<cfif LEN(Q_MEDICAID_EXP_AGING_PFY_QUERY.EXPTOTAL)>
	<cfset AGING_PFY_TOTAL = Q_MEDICAID_EXP_AGING_PFY_QUERY.EXPTOTAL>
</cfif>

<cfif LEN(Q_MEDICAID_EXP_AGING_PPFY_QUERY.EXPTOTAL)>
	<cfset AGING_PPFY_TOTAL = Q_MEDICAID_EXP_AGING_PPFY_QUERY.EXPTOTAL>
</cfif>

<!--- DHS --->
<cfif len(Q_MEDICAID_EXP_DHS_CFY_QUERY.EXPTOTAL)>
	<cfset DHS_CFY_TOTAL = DHS_CFY_TOTAL + Q_MEDICAID_EXP_DHS_CFY_QUERY.EXPTOTAL>
</cfif>

<cfif len(Q_MEDICAID_EXP_DHS_PFY_QUERY.EXPTOTAL)>
	<cfset DHS_PFY_TOTAL = DHS_PFY_TOTAL + Q_MEDICAID_EXP_DHS_PFY_QUERY.EXPTOTAL>
</cfif>

<cfif len(Q_MEDICAID_EXP_DHS_PPFY_QUERY.EXPTOTAL)>
	<cfset DHS_PPFY_TOTAL = DHS_PPFY_TOTAL + Q_MEDICAID_EXP_DHS_PPFY_QUERY.EXPTOTAL>
</cfif>


<cfoutput>
<!-- START EXPENSE -->
	<div id="expense" class="revenue">
					
					<h4>How much does the state spend on Medicaid expenses for Illinois residents?</h4>
					<table class="table table-sorting table-striped table-2018">
						<tr>
							<th class="bg-info">Agency</th>
							<th class="bg-info text-right">FY 20#application.cfy# Amount</th>
							<th class="bg-info text-right">FY 20#application.pfy# Amount</th>
							<th class="bg-info text-right">FY 20#application.PPFY# Amount</th>
						</tr>
						<tr>
							<td>DHS</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/medicaid-details-by-fund/?agency=444&FY=#URLEncodedFormat(application.cfy)#">#EncodeForHTML(DollarFormat(DHS_CFY_TOTAL))#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/medicaid-details-by-fund/?agency=444&FY=#URLEncodedFormat(application.pfy)#">#EncodeForHTML(DollarFormat(DHS_PFY_TOTAL))#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/medicaid-details-by-fund/?agency=444&FY=#URLEncodedFormat(application.PPFY)#">#EncodeForHTML(DollarFormat(DHS_PPFY_TOTAL))#</a></td>
						</tr>
						<tr>
							<td>HFS</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/medicaid-details-by-fund/?agency=478&FY=#URLEncodedFormat(application.cfy)#">#EncodeForHTML(DollarFormat(HFS_CFY_TOTAL))#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/medicaid-details-by-fund/?agency=478&FY=#URLEncodedFormat(application.pfy)#">#EncodeForHTML(DollarFormat(HFS_PFY_TOTAL))#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/medicaid-details-by-fund/?agency=478&FY=#URLEncodedFormat(application.PPFY)#">#EncodeForHTML(DollarFormat(HFS_PPFY_TOTAL))#</a></td>
						</tr>
					<tr>
							<td>Aging</td>
							<td class="text-right"><a href="/financial-data/state-expenditures/medicaid-details-by-fund/?agency=402&FY=#URLEncodedFormat(application.cfy)#">#EncodeForHTML(DollarFormat(AGING_CFY_TOTAL))#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/medicaid-details-by-fund/?agency=402&FY=#URLEncodedFormat(application.pfy)#">#EncodeForHTML(DollarFormat(AGING_PFY_TOTAL))#</a></td>
							<td class="text-right"><a href="/financial-data/state-expenditures/medicaid-details-by-fund/?agency=402&FY=#URLEncodedFormat(application.PPFY)#">#EncodeForHTML(DollarFormat(AGING_PPFY_TOTAL))#</a></td>
						</tr>
					</table>
	</cfoutput>
					<h3>About Medicaid Spending</h3>
					<p>Medicaid is a joint state and federal program providing health care coverage to eligible pregnant women, senior citizens, parents, and persons with disabilities. 
					Federal law requires certain individuals to be covered, including low-income families and children. Eligibility is based on residency and modified adjusted gross income, 
					but income eligibility for persons with disabilities and persons 65 and older is determined using Social Security income methods.</p>

					<p>For every $1 Illinois spends on most Medicaid-eligible programs, the state receives a roughly $0.50 reimbursement from the federal government. The Illinois Department 
					of Healthcare and Family Services primarily administers Illinois&#39 Medicaid spending, though some Medicaid spending also occurs through the departments of Human Services and 
					Aging. While spending occurs in several funds, the majority comes from the General Revenue Fund and Healthcare Provider Relief Fund and includes spending on Managed Care Organizations.
					For an enhanced review of Managed Care Organizations spending <a href="/Office/MCO/">click here.</a></p>


	</div>
	<!-- END EXPENSE -->

	<h3>About Managed Care</h3>
		<p>
			Managed Care is a way to organize payments for Medicaid where a Managed Care Organization (MCO) is contracted by a state to 
			provide Medicaid services through a risk-based system for a pre-set premium, known as a capitation payment. This system is 
			called &#34risk-based&#34 because MCOs are at financial risk for the services outlined in their Medicaid contracts with the states, 
			since they are responsible for contracting with providers directly. If the price contracted with the provider is greater than 
			the annual capitation payment, then the MCO would have to absorb the loss. 

			Since 2018, Illinois has worked toward having MCOs provide 80 percent of the state&#39s Medicaid coverage. This shift in coverage
			from direct fee-for-service to managed care for Illinois Medicaid has resulted in a dramatic shift in Illinois expenditures on 
			MCOs.    
		</p>