
	<!---SR 17070 WI 1016  This is a sample modal window --->
	<div id="myModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<div class="modal-body">
					
						 <div class="graph-block hidden-xs" style="">
								<!--- <h3>Fiscal Year</h3> --->
								<div id="chart"></div>
							</div>



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
							            		categories: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17'],
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
							            data: [300, -1220, -1094, -410, -474, -291, -135, -834, -3673, -6094, -4507, -4984, -3988, -3931, -2900, -3543, -7984]
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
