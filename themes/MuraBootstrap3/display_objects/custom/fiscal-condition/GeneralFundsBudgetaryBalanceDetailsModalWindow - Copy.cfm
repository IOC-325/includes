<cfoutput>
	<!--- This is a sample modal window --->
	<div id="myModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times-circle"></i></button>
					<h3>General Funds Budgetary Balance in Detail</h3>
				</div>
				<div class="modal-body">
					<!--- <h4>This is just a sample&hellip;</h4> --->
					<p>The General Funds are comprised of four separate funds: the General Revenue Fund, which is the state's largest operating account;
						the Education Assistance Fund; the Common School Fund; and the Common School Special Account Fund.</P>
						<p>The figures in the chart below show the gross amount of outstanding expenditures budgeted for these four funds when the fiscal years
shown (2001 to 2016) closed. A negative balance means there were more expenditures reported to the Comptroller than there were revenues to pay them.</p>

						<p>The General Funds' Budgetary Balance is used by budget officials in
							<a href="http://illinoiscomptroller.gov/ledger/assets/File/16-12-29_budget-balance-views.pdf">some of the ways they define a balanced budget</a>.</p>


						 <div class="graph-block hidden-xs" style="">
								<!--- <h3>Fiscal Year</h3> --->
								<div id="chart"></div>
							</div>
</cfoutput>


							<!-- js code for the chart -->
								<script>
									$(document).ready(function(){

										Highcharts.setOptions({
												lang: {
													thousandsSep: '.'
												}
											});


								    // Chart ****************************
							    		$('#chart').highcharts({ 

											chart: {width:570},

											title: {
							            		text: 'Fiscal Year',
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
							                	text: 'Billions'
                                            	, color:'#fff'
							            		},
							            
							            	labels: {
							                	formatter: function () {
	                                                return Highcharts.numberFormat(this.value,0,0,".");
								                	},
								                
								               	style: {
								                    color: '#fff',
								                    fontSize:'12px'
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


				</div>
				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Close</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
