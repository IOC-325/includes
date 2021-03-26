<cfinvoke component="/ledger/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
        method="GetBondRating"
        srce="General"
        returnVariable="GetBondRating">
<!---    <cfdump var="#Left(GetBondRating.Moodys,Find("(",GetBondRating.Moodys)-1)#">
   <cfdump var="#Right(GetBondRating.Moodys,len(GetBondRating.Moodys)-Find("(",GetBondRating.Moodys)).Replace(")","")#"> --->
<cftry>
    <cfoutput>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-sm-offset-0 col-md-10 col-md-offset-1">
    <!--- <h2>Bond Ratings</h2> --->
                <p>When debt is issued by the government, independent credit rating agencies attach a rating to the issue.
                    The ratings attached to all bonds associated with the State of Illinois affect interest payments and the
                    cost to Illinois taxpayers. Individual bond ratings will vary, but the general and special obligation
                    bond ratings are directly related to financial condition of the state government.</p>

                <div class="obligation">
                    <h3><strong>General Obligation</strong></h3>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4">
                            <div class="block">
                                <h3>MOODY'S</h3>
                                <div class="big">Baa3</div>
                                <span>stable outlook</span>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4">
                            <div class="block">
                                <h3>S&amp;P</h3>
                                <div class="big">BBB-</div>
                                <span>stable outlook</span>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4">
                            <div class="block">
                                <h3>Fitch</h3>
                                <div class="big">BBB</div>
                                <span>negative outlook</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="obligation">
                    <h3><strong>Special Obligation</strong></h3>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4">
                            <div class="block">
                                <h3>MOODY'S</h3>
                                <div class="big">Baa3</div>
                                <span>negative outlook</span>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4">
                            <div class="block">
                                <h3>S&amp;P</h3>
                                <div class="big">AA-</div>
                                <span>stable outlook</span>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4">
                            <div class="block">
                                <h3>Fitch</h3>
                                <div class="big">AA+</div>
                                <span>stable outlook</span>
                            </div>
                        </div>

                        <div class="col-sm-12">
                            <p>This table shows the most recent bond ratings from three credit rating bureaus for the
                                two major State of Illinois bond programs.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>
    <cfcatch type="any">
        <cfdump var="#cfcatch#">
        <cfabort>
        <span style="color:Gray;">Sorry, we could not process your request. </span>
        <cfabort>
    </cfcatch>
</cftry>
