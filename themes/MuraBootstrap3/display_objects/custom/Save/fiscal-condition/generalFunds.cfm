<cfparam name="GETLASTUPDT" default="">

 <cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetDailyCashBalance"
     LastUpdt = "#DateFormat(GetLastUpdt,"mm/dd/yyyy")#"
   srce="LedgerDB2"
   returnVariable = "GetDailyCashBalance">

 <cftry>
 <cfoutput>
 <cfif GetDailyCashBalance.recordcount>
   <cfset EndDailyAmount = GetDailyCashBalance.SumOfBEGIN_DAILY_AMT + GetDailyCashBalance.SumOfRECEIPT_AMT + GetDailyCashBalance.SumOfTRANS_IN_AMT + GetDailyCashBalance.SumOfTRANS_OUT_AMT + GetDailyCashBalance.NET_WARRANTS>

<div class="row">
						<div class="col-sm-10 col-sm-offset-1">

							<h2>General Funds Daily Cash Transactions</h2>
							<p>The General Funds include the General Revenue Fund and three education funds and is the state's largest and most important fund group.</p>

							<div class="row">
								<div class="col-sm-11 col-sm-offset-1">
									<div class="detail">
										<div class="amount_type">Begin Daily Amount:</div>
										<div class="amount">#DollarFormat(GetDailyCashBalance.SumOfBEGIN_DAILY_AMT)#</div>
										<div class="amount_type">Receipt Amount:</div>
										<div class="amount">#DollarFormat(GetDailyCashBalance.SumOfRECEIPT_AMT)#</div>
										<div class="amount_type">Transfers In:</div>
										<div class="amount">#DollarFormat(GetDailyCashBalance.SumOfTRANS_IN_AMT)#</div>
										<div class="amount_type">Transfers Out:</div>
										<div class="amount">#DollarFormat(GetDailyCashBalance.SumOfTRANS_OUT_AMT)#</div>
										<div class="amount_type">Net Warrants Issued:</div>
										<div class="amount">#DollarFormat(GetDailyCashBalance.NET_WARRANTS)#</div>
										<div class="amount_type">End Daily Amount:</div>
										<div class="amount">#DollarFormat(EndDailyAmount)#</div>
									</div>
								</div>
							</div>
</cfif></cfoutput>
							<h2>General Funds Budgetary Balance</h2>
							<p>The General Funds is a grouping of four funds within the state treasury. The funds included in this grouping are the General Revenue Fund, which acts as the state's largest operating account, and the three school funds: the Education Assistance Fund, the Common School Fund, and the Common School Special Account Fund. Reviewing this figure provides an indication of the state's fiscal health. The figures in the chart below show the gross amount of outstanding expenditures budgeted for these four funds when the fiscal year closed. A negative balance means there were more expenditures reported to the Comptroller than there were revenues to pay them. The General Funds' Budgetary Balance is used by budget officials in <a href="http://illinoiscomptroller.gov/ledger/assets/File/16-12-29_budget-balance-views.pdf">some of the ways they define a balanced budget.</a></p>

						</div>

					</div>

					<div class="graph-block hidden-xs">
						<h3>Fiscal Year</h3>
						<div id="chart"></div>
					</div>

					<div class="balance visible-xs">

						<ul>
							<li>
								<div class="pull-left money">$ in Millions</div>
								<div class="pull-right h4">(Deficit)</div>
							</li>
                            				<li>
								<div class="pull-left">FY 2016</div>
								<div class="pull-right">($3,543)</div>
							</li>                          
                            				<li>
								<div class="pull-left">FY 2015</div>
								<div class="pull-right">($2,900)</div>
							</li>
                            				<li>
								<div class="pull-left">FY 2014</div>
								<div class="pull-right">($3,931)</div>
							</li>
							<li>
								<div class="pull-left">FY 2013</div>
								<div class="pull-right">($3,988)</div>
							</li>
							<li>
								<div class="pull-left">FY 2012*</div>
								<div class="pull-right">($4,984)</div>
							</li>
							<li>
								<div class="pull-left">FY 2011*</div>
								<div class="pull-right">($4,507)</div>
							</li>
							<li>
								<div class="pull-left">FY 2010*</div>
								<div class="pull-right">($6,094)</div>
							</li>
							<li>
								<div class="pull-left">FY 2009*</div>
								<div class="pull-right">($3,673)</div>
							</li>
							<li>
								<div class="pull-left">FY 2008*</div>
								<div class="pull-right">($834)</div>
							</li>
							<li>
								<div class="pull-left">FY 2007*</div>
								<div class="pull-right">($135)</div>
							</li>
							<li>
								<div class="pull-left">FY 2006*</div>
								<div class="pull-right">($291)</div>
							</li>
							<li>
								<div class="pull-left">FY 2005*</div>
								<div class="pull-right">($474)</div>
							</li>
							<li>
								<div class="pull-left">FY 2004*</div>
								<div class="pull-right">($410)</div>
							</li>
							<li>
								<div class="pull-left">FY 2003*</div>
								<div class="pull-right">($1,094)</div>
							</li>
							<li>
								<div class="pull-left">FY 2002</div>
								<div class="pull-right">($1,220)</div>
							</li>
							<li>
								<div class="pull-left">FY 2001</div>
								<div class="pull-right">$300</div>
							</li>
						</ul>

						<div class="restart">* As restated.</div>

					</div>

					<!-- js code for the chart -->
						<script>
							$(document).ready(function(){
						    // Chart ****************************
					    $('#chart').highcharts({
					        title: {
					            text: '',
					            x: -20 //center
					        },
					        subtitle: {
					            text: '',
					            x: -20
					        },
					        xAxis: {
					            categories: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16'],
					        },
					        yAxis: {
					            title: {
					                text: ''
					            },
					            labels: {
					                formatter: function () {
					                    return Highcharts.numberFormat(this.value,0);
					                },
					                  style: {
					                    color: '#fff',
					                    fontSize:'18px'
					                }
					            },
					            plotLines: [{
					                value: 0,
					                width: 3,
					                color: '#FFFFFF',
					            }]
					        },
					        tooltip: {
					            useHTML: true,
					            valuePrefix: ' $',
					            valueSuffix: '&nbsp;billion',
					            backgroundColor: '#414142',
					            borderWidth: 0,
					        },
					        legend: {
					            layout: 'vertical',
					            align: 'right',
					            verticalAlign: 'middle',
					            borderWidth: 0,
					        },
					         plotOptions: {
					            series: {
					                marker: {
					                    fillColor: '#FFFFFF',
					                    lineWidth: 0,
					                    radius: 3,
					                    symbol: 'square',
					                    lineColor: '#FFFFFF' // inherit from series
					                }
					            }
					        },

					        series: [{
					            name: 'FY',
					            lineWidth: 4,
					            color:'#2cabe1',
					            data: [300, -1220, -1094, -410, -474, -291, -135, -834, -3673, -6094, -4507, -4984, -3988, -3931, -2900, -3543]
					        }]

					    });
						}); //end document.ready()
					</script>
<cfcatch type="any">
 <cfdump var="#cfcatch#">
 <cfabort>
 <span style="color:Gray;">Sorry, we could not process your request. </span><cfabort>
</cfcatch>
</cftry>