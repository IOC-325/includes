 <cfinvoke component = "/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
   method = "GetBondRating"
   srce="General"
   returnVariable = "GetBondRating">
<!---    <cfdump var="#Left(GetBondRating.Moodys,Find("(",GetBondRating.Moodys)-1)#">
   <cfdump var="#Right(GetBondRating.Moodys,len(GetBondRating.Moodys)-Find("(",GetBondRating.Moodys)).Replace(")","")#"> --->
 <cftry>
 <cfoutput>
<div class="row">
						<div class="col-sm-10 col-sm-offset-1">

							<h2>Bond Ratings</h2>
							<p>When debt is issued by the government, independent credit rating agencies attach a rating to the issue. The ratings attached to all bonds associated with the State of Illinois affect interest payments and the cost to Illinois taxpayers. Individual bond ratings will vary, but the general and special obligation bond ratings are directly related to financial condition of the state government.</p>

							<div class="obligation">
								<h3>General Obligation</h3>
								<div class="row">
									<div class="col-sm-4">
										<div class="block">
											<h3>MOODY'S</h3>
											<div class="big">#Left(GetBondRating.Moodys,Find("(",GetBondRating.Moodys)-1)#</div>
											<span>#Right(GetBondRating.Moodys,len(GetBondRating.Moodys)-Find("(",GetBondRating.Moodys)).Replace(")","")#</span>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="block">
											<h3>S&amp;P</h3>
											<div class="big">#Left(GetBondRating.SandP,Find("(",GetBondRating.SandP)-1)#</div>
											<span>#Right(GetBondRating.SandP,len(GetBondRating.SandP)-Find("(",GetBondRating.SandP)).Replace(")","")#</span>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="block">
											<h3>Fitch</h3>
											<div class="big">#Left(GetBondRating.Fitch,Find("(",GetBondRating.Fitch)-1)#</div>
											<span>#Right(GetBondRating.Fitch,len(GetBondRating.Fitch)-Find("(",GetBondRating.Fitch)).Replace(")","")#</span>
										</div>
									</div>
								</div>
							</div>

							<div class="obligation">
								<h3>Special Obligation</h3>
								<div class="row">
									<div class="col-sm-4">
										<div class="block">
											<h3>MOODY'S</h3>
											<div class="big">Baa1</div>
											<span>negative outlook</span>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="block">
											<h3>S&amp;P</h3>
											<div class="big">AAA</div>
											<span>stable outlook</span>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="block">
											<h3>Fitch</h3>
											<div class="big">AA+</div>
											<span>stable outlook</span>
										</div>
									</div>

									<div class="col-sm-12">
										<div class="col-sm-12">
											<p>This table shows the most recent bond ratings from three credit rating bureaus for the two major State of Illinois bond programs. Click on a credit rating agency name in the table to learn more about how they determine bond ratings.</p>
										</div>
									</div>

								</div>
							</div>

							<div class="btn-align">
								<a class="btn btn-default" href="##">more about bond ratings</a>
							</div>

						</div>
					</div>
</cfoutput>
<cfcatch type="any">
 <cfdump var="#cfcatch#">
 <cfabort>
 <span style="color:Gray;">Sorry, we could not process your request. </span><cfabort>
</cfcatch>
</cftry>