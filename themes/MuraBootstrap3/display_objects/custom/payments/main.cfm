<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css" />
<link href="/comptroller/includes/themes/MuraBootstrap3/assets/datatable/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">

<!--- There is a prolem with calling up this list. unless I explicitly tell the CFY is 17 on this page, then application.cfy is 16. Somewhere application.cfy is set to 16, but I cannot find it. This code should not be necessary / should be removed before posting production. --->
<!---<cfset application.cfy = "17">--->
<!--- Get Fiscal years --->
 <cfinvoke component="Queries.warehouse"
		method="getFYs"
		returnvariable="qFYList" >
	<cfinvokeargument name="numFYs" value="3"/>
    <cfinvokeargument name="MaxFY" value="20#application.cfy#">
</cfinvoke>
<cfparam name="variables.VendorName" default="">
<cfparam name="variables.FY" default="20#application.cfy#">

<cfparam name="variables.SortBy" default="Vendor_Name">
<CFIF IsDefined ("form.VendorName")>
	<CFSET variables.VendorName = form.VendorName>
    <CFSET variables.FY = form.FY>
</CFIF>
<cfoutput>
<!-- START PAYMENT -->
	<div id="payment">

			<div class="row">
        <div id="1" style="display:none" class="col-md-7 col-md-offset-2 alert alert-info text-center">
             Gathering data, please wait...
        </div>
            </div>	<!--- end row --->
					#$.getSummary()#
                <div class="example alert alert-danger hidden" id="errorMsg"> Please Enter Search Criteria.</div>

            						<cfform method="post" enctype="application/x-www-form-urlencoded" preloader="no">
                        <div class="row margintop">
            							<fieldset>
            								<div class="col-sm-7">
            									<cfinput type="text" id="VendorName" name="VendorName" class="form-control height" maxlength="255" placeholder="Vendor Name"  value="#variables.VendorName#">
            								</div>
            								<div class="col-sm-5">
                                            <select name="FY"  class="form-control height select">
            										<!--- <CFIF variables.FY IS 0>
                                                        <option value="#DATEFORMAT(NOW(), 'yyyy')#">Fiscal Year</option>
                                                    <cfelse>
                                                        <option value="#DATEFORMAT(NOW(), 'yyyy')#" selected="selected">Fiscal Year</option>
                                                    </CFIF> --->
                                                    <Cfloop index="i" list="#qFYList#">
            											<CFIF variables.FY IS i>
                                                            <option value="#i#" selected="selected">Fiscal Year #i#</option>
                                                         <cfelse>
                                                         	<option value="#i#">Fiscal Year #i#</option>
                                                        </CFIF>
                                                    </Cfloop>
                                            </select>
            								</div>

            							</fieldset>
                          </div>
                            <div class="text-center">                
                                            <cfinput type="submit" id="btnSearch" name="Search" class="btn btn-success" value="Submit">
                            </div>                          
            						</cfform>
          
<CFIF IsDefined ("form.Search")>

    <cfinvoke component="Queries.expenditures"
        method="GetVendorPayments"
        returnvariable="qVP" >
        <cfinvokeargument name="formData" value="#form#"/>
    </cfinvoke>

		<div id="payment" class="contract main2" align="center">
      <div id="2" style="width: 98%; margin: 21px auto; display:block">
			<table id="paymentsTable" <CFIF qVP.recordcount GT 0>class="datatable-export table-striped datatable-primary"<cfelse>class="table-striped datatable-primary"</cfif>>
				<thead>
					<tr>
						<th class="bg-info payments-th">Vendor Names</th>
						<th class="bg-info payments-th">Fiscal Year</th>
						<th class="bg-info payments-th">YTD Gross</th>
					</tr>
				</thead>

				<tbody>
                <CFIF qVP.recordcount GT 0>
                  <cfloop query="qVP" startrow="1" endrow="4000">
					<tr>
						<td><a data-toggle="modal" href="##myModal" data-name="#qVP.VENDOR_NAME#" data-Fy="#qVP.FISCAL_YEAR#" class="loadModal">#qVP.VENDOR_NAME#</a></td>
						<td>#qVP.FISCAL_YEAR#</td>
						<td>#DOLLARFORMAT(qVP.YTD_GROSS)#</td>
					</tr>
                 </cfloop>
                 <cfelse>
                 	<tr>
                    	<td colspan="3">No Payments Issued</td>
                    </tr>
                </CFIF>
				</tbody>
			</table>
         </div>
		</div> <!--- end result --->

<cfelse>
  <cfinvoke component="Queries.expenditures"
        method="GetVendorPaymentsDefaults"
        returnvariable="qVP" >
        <cfinvokeargument name="formData" value="#form#"/>
    </cfinvoke>

		<div id="payment" class="contract main2" align="center">

      <div id="2" style="width: 98%; margin: 21px auto; display:block">
        <table id="paymentsTable" class="datatable-export table-striped datatable-primary">
				<thead>
					<tr>
						<th class="bg-info payments-th">Vendor Name</th>
						<th class="bg-info payments-th">Fiscal Year</th>
						<th class="bg-info payments-th" title="The figure displayed on this page represents the gross amount of vouchers submitted to the Comptroller. The breakdown of payments shows only those that have been released to the vendor.">YTD Gross</th>
					</tr>
				</thead>

				<tbody>
                <CFIF qVP.recordcount GT 0>
                  <cfloop query="qVP">
					<tr>
						<td><a data-toggle="modal" href="##myModal" data-name="#qVP.VENDOR_NAME#" data-Fy="#qVP.FISCAL_YEAR#" class="loadModal">#qVP.VENDOR_NAME#</a></td>
						<td>#qVP.FISCAL_YEAR#</td>
						<td align="right">#DOLLARFORMAT(qVP.YTD_GROSS)#</td>
					</tr>
                 </cfloop>
                 <cfelse>
                 	<tr>
                    	<td colspan="3">No Payments Issued</td>
                    </tr>
                </CFIF>
				</tbody>
			 </table>
      </div>
		</div> <!--- end result --->

</CFIF>

	</div> <!--- end payment --->
	<!-- END PAYMENT -->
	<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog" style="width: 75%">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" align="center">Payment Information for <strong><span id="headerVendorName"></span></strong> </h4>
      </div>
      <div class="modal-body">
        <div id="VendWarrantList" class="table-responsive-new" style="width:100%">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>


 </cfoutput>

<script>
$(document).ready(function(){
   $("#btnSearch").click(function(event){
      if($("#VendorName").val() === "")
      {
        $("#errorMsg").toggleClass('hidden show');
        event.preventDefault();
      }
      else{
		 var e3 = document.getElementById(1);
		 var e4 = document.getElementById(2);
		e3.style.display = 'block';
		e4.style.display = 'none';
		$(function() {
		e3.delay(2000).fadeOut(0);
	});
        $("#errorMsg").toggle();

      }
   });

// get/present data for the popup payment window containing 5 columns of data
 $(".loadModal").click(function(event) {
  //get the vendor name and Fy
  $('#myModal').find("#headerVendorName").text($(this).data("name"));
  $('#myModal').find("#VendorNameInfo").text($(this).data("name"));
  $('#myModal').find("#FYValue").text($(this).data("fy"));
  if($(this).data("name") !== "" || $(this).data("fy") !== ""){
         $.ajax({
            url: "/Queries/autosuggest.cfc?method=GetVendorWarrantList&returnformat=json",
            type: "GET",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data:{
            fiscal_year: $(this).data("fy"),
            vendor_name: $(this).data("name")
            },
            success: function (data) {
             //initialize the table
             var trHTML = '<table id="tblVendWarrantList" class="datatable table table-striped" align="center" style="font-size:18px;"><thead><tr><th>Issue Date</th><th>&nbsp;</th><th>Contract No</th><th>&nbsp;</th><th>Agency Name</th><th>&nbsp;</th><th>Approp Cat</th><th>&nbsp;</th><th>Payment Amount</th></tr></thead><tbody>';
             $.each(data, function (i, item) {
              //for each element form tr
               trHTML += '<tr><td>' + item.ACCEPTANCE_DATE + '</td><td>&nbsp;</td><td><a class="contractInfo" href="#">' + item.CONTRACT_NUMBER.replace('<PRE>',"").replace('</PRE>',"") + '</a></td><td>&nbsp;</td><td>' + item.Agency_Name + '</td><td>&nbsp;</td><td>' + item.Approp_Cat_Name + '</td><td>&nbsp;</td><td align="right">' + item.Voucher_Amt + '</td></tr>';
               //get contract Info
             });
             trHTML += '</tbody></table>'
             //append to the div
             $('#VendWarrantList').html(trHTML);
             },
             error: function (msg) {
                 alert(msg.responseText);
             }
         });
     }
  //console.log($(this).data("fy"));
 });
$("#VendWarrantList").on( 'click', '.contractInfo', function() {
        var $this     = $(this),$parentTR = $this.closest('tr');
        var contractNum = $(this).html();
        //if the tr below this tr has colspan i.e. it has some dynamic info which is already loaded
        if($this.closest('tr').next().find('td').attr('colspan') === undefined){
          $.ajax({
             url: "/Queries/autosuggest.cfc?method=GetContractLookUp&returnformat=json",
             type: "GET",
             dataType: "json",
             contentType: "application/json; charset=utf-8",
             data:{
             contract_number: $(this).html()
             },
             success: function (data) {
              var trHTML = '';
              $.each(data, function (i, item) {
               //class="table table-responsive table-hover table-bordered"
                trHTML += '<tr style="background-color: #fff"><td colspan="1">&nbsp;</td><td colspan="8"><table align="left" id="contractInfo" class="table-responsive table-bordered"><tbody><tr><th colspan="2" align="center"><a class="paymentLookup" href="#"data-contractnumber=' + contractNum + ' data-agency=' + item.Agency + ' >Click here for payments made against this contract.</a></th></tr><th>Agency</th><td>' + item.Agency_Name +' (' + item.Agency + ')</td></tr><tr><th>Award Description</th><td>'+ item.AWARD_DESCRIPTION +'</td></tr><tr"><th>Type Description</th><td>'+ item.TYPE_DESCRIPTION +'</td></tr><tr><th>Class Description</th><td>'+ item.CLASS_DESCRIPTION +'</td></tr><tr><th>Vendor</th><td>'+ item.NAME +'</td></tr><tr><th>Vendor Line 2</th><td>'+ item.nameii +'</td></tr><tr><th>From Date</th><td>'+ item.FROM_DATE +'</td></tr><tr><th>To Date</th><td>'+ item.TO_DATE +'</td></tr><tr><th>Current Contract Amount</th><td>'+ item.CONTRACT_AMT +'</td></tr><tr><th>Planned Contract Amount</th><td>'+ item.MAX_CONTRACT_AMT +'</td></tr><tr><th>Current Expended Amount</th><td>'+ item.EXPENDED_AMT +'</td></tr></tbody></table></td></tr>';
              });
               $(trHTML).insertAfter($parentTR);
              },
              error: function (msg) {
                  alert(msg.responseText);
              }
          });
        }
        else{
         // see the paymentinfo is there then hide it, if it is not then check for the vendor warrent info and then adjust it's visibility
         /*if($this.closest('tr').next().next().find('td').attr('colspan') !== undefined && $this.closest('tr').next().next().css('display') !== "none"){
          $this.closest('tr').next().next().hide();
         }
         else if($this.closest('tr').next().attr('style') === undefined || $this.closest('tr').next().css('display') !== "none"){
           $this.closest('tr').next().hide();
         }
         else{
           $this.closest('tr').next().show();
         }*/
         $this.closest('tr').next().remove();
         $this.closest('tr').next().remove();
         //$('#tblVendWarrantList tbody > tr > td[colspan="1"]').remove();
         //$('#tblVendWarrantList tbody > tr > td[colspan="8"]').remove();
        }
 //var temptr = '<tr><td colspan="9"><table align="center" style="width:auto; padding:10px; text-align:right;" cellpadding="3" cellspacing="0" border="1" frame="box" rules="groups"> <tbody><tr style="background-color:#606B82;"> <th style="border:0; color:#fff;">Agency</th> <td style="border:0; color:#fff;">SECRETARY OF STATE (350)</td></tr><tr style="border:0; background-color:#F2DCD5"> <th>Award Description</th> <td>SOLE SOURCE PROCUREMENTS</td></tr><tr style="background-color:#D7D7D7;"> <th style="border:0;">Type Description</th> <td>OTHER CONTRACTS-EXT VENDOR </td></tr><tr style="border:0; background-color:#F2DCD5"> <th style="border:0;">Class Description</th> <td>REPAIR/MAINT NEC </td></tr><tr style="background-color:#D7D7D7;"> <th style="border:0;">Vendor</th> <td>IBM CORPORATION </td></tr><tr style="border:0; background-color:#F2DCD5"> <th style="border:0;">Vendor Line 2</th> <td> </td></tr><tr style="background-color:#D7D7D7;"> <th style="border:0;">From Date</th> <td>7/1/2015</td></tr><tr style="border:0; background-color:#F2DCD5"> <th style="border:0;">To Date</th> <td>6/30/2016</td></tr><tr style="background-color:#D7D7D7;"> <th style="border:0;">Current Contract Amount</th> <td>$1,899,971.00</td></tr><tr style="border:0; background-color:#F2DCD5"> <th style="border:0;">Planned Contract Amount</th> <td>$1,899,971.00</td></tr><tr style="background-color:#D7D7D7;"> <th style="border:0;">Current Expended Amount</th> <td>$1,899,971.00</td></tr></tbody></table></td></tr>';
 //$parentTR.clone().insertAfter($parentTR);
 //$(temptr).insertAfter($parentTR);
});
$("#VendWarrantList").on( 'click', '.paymentLookup', function() {
 var conNum = $(this).data("contractnumber");
 var agency = $(this).data("agency");
 //hide the parent tr for this so that we can display the paymentinfo in that position
 $(this).closest('tr').parent().parent().parent().parent().hide();
 $parentTR = $(this).closest('tr').parent().parent().parent().closest('tr');
 //var trHTML = '<table rules="groups" frame="box" cellpadding="5" align="center"> <tbody><tr style="background-color:#606B82;"> <th style="color:#fff;">Date</th><th style="color:#fff;">Amount</th> </tr><tr bgcolor="#F2DCD5"> <td style="text-align:right;">1/6/2016</td><td style="text-align:right;">$7,144.37</td></tr><tr bgcolor="#D7D7D7"> <td style="text-align:right;">11/2/2015</td><td style="text-align:right;">$3,942.83</td></tr><tr bgcolor="#F2DCD5"> <td style="text-align:right;">10/30/2015</td><td style="text-align:right;">$6,660.04</td></tr><tr bgcolor="#D7D7D7"> <td style="text-align:right;">8/24/2015</td><td style="text-align:right;">$5,109.62</td></tr><tr bgcolor="#F2DCD5"> <td style="text-align:right;">8/5/2015</td><td style="text-align:right;">$201.50</td></tr><tr bgcolor="#D7D7D7"> <td style="text-align:right;">7/28/2015</td><td style="text-align:right;">$45,697.23</td></tr><tr bgcolor="#F2DCD5"> <td style="text-align:right;">7/20/2015</td><td style="text-align:right;">$11,289.59</td></tr><tr style="background-color:#606B82; color:#fff; font-weight:bold;"> <td>Total</td><td style="text-align:right;">$80,045.18</td></tr></tbody></table>';
 //$(trHTML).insertAfter($parentTR);
          $.ajax({
             url: "/Queries/autosuggest.cfc?method=GetPaymentLookupByContract&returnformat=json",
             type: "GET",
             dataType: "json",
             contentType: "application/json; charset=utf-8",
             data:{
             agency: agency,
             contract_number: conNum
             },
             success: function (data) {
              var trHTML = '<tr style="background-color: #fff;"><td colspan="9"><table align="center" class="table-responsive table-hover table-bordered" width="50%"><thead><tr><th style="text-align:center;">Date</th><th style="text-align:center;">Amount</th></tr></thead><tbody>';
              $.each(data, function (i, item) {
               //class="table table-responsive table-hover table-bordered"
                trHTML +='<tr><td align="center">' + item.Acceptance_Date +'</td><td align="center">'+ item.Expended_Amt +'</td></tr>';
              });
              trHTML += '</tbody></table></td></tr>';
               $(trHTML).insertAfter($parentTR);
              },
              error: function (msg) {
                  alert(msg.responseText);
              }
          });
});
});

</script>