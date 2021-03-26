<!--- CR0008 - 08/26/97 --->
<!--- Give default values for all parameters --->
<!--- CFPARAMs are required when you wish to assign --->
<!--- a value (DEFAULT) to the name of a control in a form --->
<!--- that receives a value from a user --->
<!--- have new application variables that need to be inserted (maxrecs and cfy) --->
<!--- SR #18072 USER STORY 1489 - UPDATE template to use FY function rather than app vars; employ 5 fiscal years --->
<CFPARAM NAME="Control" DEFAULT="Main">
<CFPARAM NAME="Max" DEFAULT=application.maxrecs>
<CFPARAM NAME="FY" DEFAULT=application.CFY>
<CFPARAM NAME="Type" DEFAULT="A">
<CFPARAM NAME="View" DEFAULT="Budg">
<CFPARAM NAME="ShowBudg" DEFAULT="No">
<CFPARAM NAME="ShowExp" DEFAULT="No">
<CFPARAM NAME="ShowMo" DEFAULT="No">
<CFPARAM NAME="ShowLapse" DEFAULT="No">
<CFPARAM NAME="FundSel" DEFAULT="">
<CFPARAM NAME="AgcySel" DEFAULT="">
<CFPARAM NAME="ApprSel" Default="">
<CFPARAM NAME="OrgSel" Default="">
<CFPARAM NAME="SortName" Default="No">

<!--- get Fiscal Years - SR 18072 --->
<cfinvoke component="Queries.warehouse"
        method="getFYs"
        returnvariable="FYList">
        <cfinvokeargument name="numFYs" value="5"/>
</cfinvoke>

<!--- <cfdump var="#FYList#" abort="true"> --->
<!--- If The reset button has been in use, then the --->
<!--- Parameter does exist, and the values, FundSel, AgencySel --->
<!--- etc. are reset, and sort becomes yes --->
<!--- <CFIF #ParameterExists(Reset)# is "Yes"> --->
<cfif isDefined("Reset")>
    <CFSET FundSel = "">
    <CFSET AgcySel = "">
    <CFSET ApprSel = "">
    <CFSET SortName = "Yes">
</CFIF>

    <!--- Instructions --->
    <p>Select the Fund and Agency that you are interested in. You will then be prompted for the Organization
        (division/program) of the Agency you selected. The first screen will display a summary of appropriation or
        expenditure total amounts for each appropriation depending on the display option chosen. Each line in the
        summary is also a link to detailed appropriation and expenditure amounts for a given appropriation. If you know
        the appropriation, you can enter it. Inserting an appropriation will display detailed appropriation and
        expenditure information for that account. </p>

    <p><b>Instructions</b>: Click on each of the drop-down boxes below to choose from or type in your selections.</p>

<form role="form" method="post" action="/agencies/resource-library/appropriation-inquiries/appropriation-inquiries-results-page/">
    <!---2DAC1EB1-A4F6-E353-3901EBCA2CFCFC92 34752E01-94B1-C363-BD152098AC434FCA> --->
    <!-- Hidden parameter used by EEQuery to determine if the request -->
    <!-- came by form or drill down -->

    <INPUT TYPE=hidden NAME="FormInput">
<cfoutput>
    <INPUT TYPE="HIDDEN" NAME="Max" VALUE="#Max#">
        <INPUT TYPE="HIDDEN" NAME="ShowMo" VALUE="#ShowMo#">
        <INPUT TYPE="HIDDEN" NAME="ShowLapse" VALUE="#ShowLapse#">
        <INPUT TYPE="HIDDEN" NAME="ShowBudg" VALUE="#ShowBudg#">
        <INPUT TYPE="HIDDEN" NAME="ShowExp" VALUE="#ShowExp#">
        <INPUT TYPE="HIDDEN" NAME="SortName" VALUE="#SortName#">
    <INPUT TYPE="HIDDEN" id="hdnOrgSel" NAME="hdnOrgSel" VALUE="0">
</cfoutput>

    <!--- Beginning of Appropriation Inquiry ---> 
<cfinvoke component="Queries.AppropriationSqlQry" method="getFunds" returnvariable="FundList" sortname="No">

<cfinvoke component="Queries.AppropriationSqlQry" method="getAgencies" returnvariable="AgcyList" control="" sortname="No">


<div class="row custom-top-padding">
    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-4 col-md-offset-1 label-div">
        <div class="btn-label">Fund</div>
    </div>

<div class="col-xs-12 col-sm-7 col-md-5">
<SELECT class="form-control" NAME="FundSel" id="FundSel">
    <OPTION VALUE="">ALL FUNDS</option>
<CFOUTPUT QUERY="FundList">
        <OPTION VALUE="#Fund#">#Fund# - #Name#</option>
</CFOUTPUT>
</SELECT>
</div>
</div>
<div class="row custom-top-padding">
    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-4 col-md-offset-1 label-div">
        <div class="btn-label">AGENCY</div>
    </div>

<div class="col-xs-12 col-sm-7 col-md-5">
<select class="form-control" NAME="AgcySel" id="AgcySel">
    <OPTION VALUE="" SELECTED>ALL AGENCIES</option>
<CFOUTPUT QUERY="AgcyList">
        <OPTION VALUE="#Agency#">#Agency# - #Name#</option>
</CFOUTPUT>
</select>
</div>
</div>
    <div class="row custom-top-padding">
        <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-4 col-md-offset-1 label-div">
            <div class="btn-label">ORGANIZATION</div>
        </div>

        <div class="col-xs-12 col-sm-7 col-md-5">
            <SELECT id="OrgSel" NAME="OrgSel" class="form-control">
                <OPTION VALUE="" SELECTED>ALL ORGANIZATIONS</option>
            </SELECT>
        </div>
    </div>
<div class="row custom-top-padding">
    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-4 col-md-offset-1 label-div">
        <div class="btn-label">Appropriation</div>
    </div>

<div class="col-xs-12 col-sm-7 col-md-5">
<CFOUTPUT>
        <INPUT class="form-control" TYPE="text" NAME="ApprSel" SIZE=8 MAXLENGTH=8 VALUE="#ApprSel#"
               placeholder="OBJECT OF EXPENDITURE, SEQUENCE AND TYPE">
</CFOUTPUT>
</div>
</div>
<div class="row custom-top-padding">
    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-4 col-md-offset-1 label-div">
        <div class="btn-label">FISCAL YEAR</div>
    </div>

<div class="col-xs-12 col-sm-7 col-md-5">
<CFOUTPUT>
        <select class="form-control" name="FY">
            <Cfloop index="i" list="#FYList#">
                    <option value="#Right(i, 2)#"><CFIF application.cfy IS Right(i, 2)>Fiscal Year </CFIF>#i#</option>
            </Cfloop>
        </select>
</CFOUTPUT>
</div>
</div>
<div class="margintopbottom">
<p>
<CFOUTPUT>
        <strong>When choosing a fiscal year, note that the State's fiscal year starts July 1 (e.g., FY #application.CFY#
            is July 1, 20#application.PFY# through June 30, 20#application.CFY#).</strong>
</CFOUTPUT>
</p>
</div>
<div class="row">
    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-4 col-md-offset-1 label-div">
        <div class="btn-label">DISPLAY LAPSE / MONTHLY OPTIONS</div>
    </div>

<div class="col-xs-12 col-sm-7 col-md-5">
<CFIF ShowMo is "Yes">
        <div class="checkbox radio-custom-margin"><label><input type="checkbox" name="ShowMo" checked="true"
                                                                value="Yes">Monthly Amounts</label></div>
<CFELSE>
        <div class="checkbox radio-custom-margin"><label><input type="checkbox" name="ShowMo" value="Yes">Monthly
            Amounts</label></div>
</CFIF>

<CFIF ShowLapse is "Yes">
        <div class="checkbox radio-custom-margin"><label><input type="checkbox" checked="true" name="ShowLapse"
                                                                value="Yes">Lapse Amounts</label></div>
<CFELSE>
        <div class="checkbox radio-custom-margin"><label><input type="checkbox" name="ShowLapse" value="Yes">Lapse
            Amounts</label></div>
</CFIF>
</div>
</div>
    <!-- End of Fiscal Year Selection Control -->
    <div class="row">
        <div class="col-sm-5 hide">
            <label>Display Options:</label>
        </div>
        <!-- Display Options Control -->
        <div class="col-sm-7 hide">
            <div class="radio"><label><input type="radio" name="view" value="Budg" checked="true">Appropriation
                Details</label></div>
            <div class="radio"><label><input type="radio" name="view" value="Exp">Appropriation Expenditures</label>
            </div>
        </div>
    </div>
<!--- <div class="form-group">

<div class="col-sm-5">
    <label>Lapse / Monthly Options:</label>
</div>
<div class="col-sm-7">
    <!-- why are the CFIF and CFElse options both going to yes???-->
   <CFIF ShowMo is "Yes">
       <div class="checkbox"><label><input type="checkbox" name="ShowMo" checked="true" value="Yes">Monthly Amounts</label></div>
     <CFELSE>
        <div class="checkbox"><label><input type="checkbox" name="ShowMo" value="Yes">Monthly Amounts</label></div>
      </CFIF>

      <CFIF ShowLapse is "Yes">
       <div class="checkbox"><label><input type="checkbox" checked="true" name="ShowLapse" value="Yes">Lapse Amounts</label></div>
     <CFELSE>
        <div class="checkbox"><label><input type="checkbox" name="ShowLapse" value="Yes">Lapse Amounts</label></div>
      </CFIF>
</div>
</div> --->
    <div class="margintop">
        <p>The year-to-date expended amount will be displayed by default. You can also choose
            to include the budgeted dollars and/or monthly totals. </p>
    </div>
    <!-- End of Display Options Control -->
<CFOUTPUT>
        <INPUT TYPE="hidden" NAME="Max" VALUE="20">
</CFOUTPUT>
    <div class="text-center">
        <input class="btn btn-primary" type="submit" value="Continue">
    </div>

    <div class="text-center label-anchor margintopbottom">
        <span class="btn-label btn-label-grey">FY 19 Appropriation Account Code Assignments</span>
        <a class="btn-label" href="/agencies/resources/fy-19-appropriation-account-code-assignments/" target="_blank">DOWNLOAD</a>
    </div>

    <div class="text-center label-anchor margintopbottom">
        <span class="btn-label btn-label-grey">FY 18 Appropriation Account Code Assignments</span>
        <a class="btn-label" href="/agencies/resources/fy-18-appropriation-account-code-assignments/" target="_blank">DOWNLOAD</a>
    </div>
    <div class="text-center label-anchor margintop">
        <span class="btn-label btn-label-grey">FY 17 P.A. 100-21 Appropriation Account Code Assignments</span>
        <a class="btn-label"
           href="/agencies/resources/fy17-p-a-100-21-appropriation-account-code-assignments/" target="_blank">DOWNLOAD</a>
    </div>
</form>


<script>
    $(document).ready(function () {
        if ($('#AgcySel').val() !== "") {
            //$('#AgcySel').trigger('change');
            $.ajax({
                type: 'get',
                url: '/Queries/AppropriationSqlQry.cfc?method=getOrganizations&AgcySel=' + $('#AgcySel').val() + '&returnformat=json&queryformat=struct',
                dataType: "json",
                success: function (response) {
                    var len = response.length;
                    $("#OrgSel").empty();
                    $("#OrgSel").append("<OPTION VALUE=''>ALL ORGANIZATIONS</option>");
                    for (var i = 0; i < len; i++) {
                        var id = response[i].ORGANIZATION;
                        var name = response[i].NAME;
                        if ($("#hdnOrgSel").val() == id) {
                            $("#OrgSel").append("<option value='" + id + "' selected >" + id + ' - ' + name + "</option>");
                        } else {
                            $("#OrgSel").append("<option value='" + id + "'>" + id + ' - ' + name + "</option>");
                        }
                    }
                    $('#OrgSel').attr("class", "select2");
                    $('#OrgSel').select2();
                }
            });
        }
        $('#OrgSel').change(function () {
            $("#hdnOrgSel").val($('#OrgSel').val());
        });

        $('#AgcySel').change(function () {
            $.ajax({
                type: 'get',
                url: '/Queries/AppropriationSqlQry.cfc?method=getOrganizations&AgcySel=' + $('#AgcySel').val() + '&returnformat=json&queryformat=struct',
                dataType: "json",
                success: function (response) {
                    var len = response.length;
                    console.log(response);
                    $("#OrgSel").empty();
                    if ($("#hdnOrgSel").val() == 0) {
                        $("#OrgSel").append("<OPTION VALUE='' SELECTED>ALL ORGANIZATIONS</option>");
                    }
                    else {
                        $("#OrgSel").append("<OPTION VALUE=''>ALL ORGANIZATIONS</option>");
                    }
                    for (var i = 0; i < len; i++) {
                        var id = response[i].ORGANIZATION;
                        var name = response[i].NAME;

                        if ($("#hdnOrgSel").val() == id) {
                            $("#OrgSel").append("<option value='" + id + "' SELECTED>" + id + ' - ' + name + "</option>");
                        } else {
                            $("#OrgSel").append("<option value='" + id + "'>" + id + ' - ' + name + "</option>");
                        }
                    }
                    $('#OrgSel').attr("class", "select2");
                    $('#OrgSel').select2();
                }
            });
        });
    });
</script>