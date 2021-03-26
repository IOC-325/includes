<!-- dspEnterWarrantNumber.cfm -->
<cfsavecontent variable="myJS">


</cfsavecontent>

<cfhtmlhead text="#myJS#">

<div align="center">
<cfform action="/vendors/warrant-inquiry-form/warrant-inquiry-form-results/" method="POST" enablecab="No">

<div class="row">
	<div class="col-sm-4 col-sm-offset-0 col-md-3 col-md-offset-1 label-div">
		<div class="btn-label-grey btn-label label-gray">Warrant Number</div>
	</div>
	<div class="col-sm-6 col-md-5 label-div">
		<cfinput type="Text" 
		name="transaction_number" 
		message="Please enter your nine digit warrant number before proceeding" 
		required="Yes"
		class="form-control"
		value="" maxlength="9">
	</div>
	<div class="col-xs-12 col-sm-2 text-center">
		<input class="btn btn-success nomargin" id="btnSearch" name="submit" type="submit" value="SUBMIT">
	</div>
</div>
</cfform>
</div>
