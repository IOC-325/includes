<cfif isDefined("form.submit")>

  <cfif form.Type eq 0>
   <cfset variables.Type = "A">
  <cfelse>
   <cfset variables.Type = form.Type>
  </cfif>
  <cfif form.GroupBy eq 0>
   <cfset variables.GroupBy = "Fund">
  <cfelse>
   <cfset variables.GroupBy = form.GroupBy>
  </cfif>
  <cfif form.FY eq 0>
   <cfset variables.FY = "16">
  <cfelse>
   <cfset variables.FY = form.FY>
  </cfif>
  <cfif IsDefined("form.ShowBudg")>
   <cfset variables.ShowBudg = "Yes">
  <cfelse>
   <cfset variables.ShowBudg = "No">
  </cfif>
  <cfif IsDefined("form.ShowMo")>
   <cfset variables.ShowMo = "Yes">
  <cfelse>
   <cfset variables.ShowMo = "No">
  </cfif>
  <cfif IsDefined("form.ShowLapse")>
   <cfset variables.ShowLapse = "Yes">
  <cfelse>
   <cfset variables.ShowLapse = "No">
  </cfif>
  <cfinvoke component="Queries.expenditures"
   method="ExpenditureQuery"
   returnvariable="results"
   control="State"
   GroupBy="#variables.GroupBy#"
   Max="20"
   FY="#variables.FY#"
   Type="#variables.Type#"
   ShowBudg="#variables.ShowBudg#"
   ShowMo="#variables.ShowMo#"
   ShowLapse="#variables.ShowLapse#"
   FundSel=""
   FundClsSel=""
   FundGrpSel=""
   FundTypSel=""
   FundCatSel=""
   AgcySel=""
   AgcyClsSel=""
   AgcyGrpSel=""
   AgcyTypSel=""
   AgcyCatSel=""
   ApprSel=""
   ApprClsSel=""
   ApprGrpSel=""
   ApprTypSel=""
   ApprCatSel=""
   ObjeSel=""
   ObjtSel=""
   ObjtClsSel=""
   ObjtGrpSel=""
   ObjtTypSel=""
   ObjtCatSel=""
   SortName="Code">
  </cfinvoke>
  <!--- Get the column headers from the query.  This is used for the table header in the report results below. --->
 <CFSET ColumnList = results.getMeta().getColumnLabels()>
 <CFSET ColumnList = ArrayToList(ColumnList)>

 <cfelse>
   <!-- get Fiscal Years --->
    <cfinvoke component="Queries.warehouse"
     method="getFYs"
     returnvariable="FYList" >
    <cfinvokeargument name="numFYs" value="3"/>
   </cfinvoke>
</cfif>
<cfoutput>
<!-- START Statewide -->
<cfform method="post" action="">
<div id="agency">
 <div class="container" <cfif IsDefined ("results")>style="width: 100% !important"</cfif>>
   <cfif not isDefined("results")>
    <div class="row">
     <div class="col-md-10 col-md-offset-1">
      <h1>#$.getTitle()#</h1>

      <p>Any intro text needed?</p>

      <div class="row">
       <form action="##">
        <fieldset>

         <div class="col-sm-10 col-xs-12">
          <select name="GroupBy">
           <option value="None">Group By None</option>
           <option value="Fund" selected="">Group By Fund</option>
           <option value="FundGrp">Group By Fund Group</option>
           <option value="FundCat">Group By Fund Category</option>
           <option value="FundType">Group By Fund Type</option>

           <option value="Agcy">Group By Agency</option>
           <option value="AgcyGrp">Group By Agency Group</option>
           <option value="AgcyCat">Group By Agency Category</option>
           <option value="AgcyType">Group By Agency Type</option>

           <option value="ApprCls">Group By Appropriation Class</option>
           <option value="ApprGrp">Group By Appropriation Group</option>
           <option value="ApprCat">Group By Appropriation Category</option>
           <option value="ApprType">Group By Appropriation Type</option>
           <option value="Obje">Group By Object of Expenditure</option>

           <option value="Objt">Group By Object</option>
           <option value="ObjtGrp">Group By Object Group</option>
           <option value="ObjtCat">Group By Object Category</option>
           <option value="ObjtType">Group By Object Type</option>
          </select>
         </div>

         <div class="col-sm-10 col-xs-12 required">
          <select name="FY">
           <!--- <option value="0" selected="selected">Fiscal Year</option> --->
             <Cfloop index="i" list="#FYList#">
               <option value="#Right(i,2)#">Fiscal Year #i#</option>
             </Cfloop>
          </select>
         </div>

         <div class="col-sm-10 col-xs-12">
          <select name="Type">
           <option value="0">Type of Spending</option>
              <option value="A" selected="selected">Appropriated Only</option>
              <option value="N">Non-Appropriated Only</option>
              <option value="B">Both</option>
          </select>
         </div>

         <div class="col-sm-10 col-xs-12">
          <input id="ShowMo" name="ShowMo" type="checkbox" value="Checkbox One" />
          <label for="ShowMo">View Monthly Amounts</label>
         </div>

         <div class="col-sm-10 col-xs-12">
          <input id="ShowBudg" name="ShowBudg" type="checkbox" value="Checkbox One" />
          <label for="ShowBudg">View Budget Amounts</label>
         </div>

         <div class="col-sm-10 col-xs-12">
          <input id="ShowLapse" name="ShowLapse" type="checkbox" value="Checkbox One" />
          <label for="ShowLapse">View Lapse Amounts</label>
         </div>

         <div class="text-center top-pad col-xs-12 col-sm-11">
          <button class="btn btn-success" name="submit" type="submit">Submit</button>
         </div>
        </fieldset>
       </form>
      </div>
     </div>
    </div>
   </cfif>

  <cfif IsDefined ("results")>
    <div class="row show">
      <div class="text-center custom-pad-around col-sm-10 col-xs-12">
        <button class="btn btn-success" name="searchAgain" type="submit">Search Again</button>
      </div>
    </div>
             <!---
              <table class="main datatable-expenses">
               <thead>
                <tr class="bg-primary">
                 <cfloop index="i" list="#ColumnList#">
                 <CFSET CleanOutput = Replacenocase(i, "APPR", "", "all")>
                 <CFSET CleanOutput = Replacenocase(CleanOutput, "Exp", "", "all")>
                   <th>#CleanOutput#</th>
                  </cfloop>
                </tr>
               </thead>
               <cfloop QUERY="results">
                <tr>
                  <cfloop index="ii" list="#ArrayToList(results.getMeta().getColumnLabels())#">
                  <td>#results[ii][Results.currentrow]#</td>
                 </cfloop>
                </tr>
               </cfloop>
              </table> --->
    <div class="table-responsive">
      <table id="example" class="<cfif ShowMo eq "yes">datatable-expenses-fixed<cfelse>datatable-expenses</cfif> table-striped datatable-primary">
      <thead>
        <CFIF (variables.ShowLapse is "Yes") OR (variables.ShowMo is "Yes")>
          <TR>
            <TH class="super-header">&nbsp;</TH>
            <TH class="super-header">&nbsp;</TH>
            <CFIF variables.ShowBudg is "Yes">
              <TH class="super-header">&nbsp;</TH>
            </CFIF>
            <TH class="super-header">&nbsp;</TH>
            <CFIF variables.ShowMo is "Yes">
             <TH class="super-header" COLSPAN="12" ALIGN=CENTER>Monthly Expended Amounts</TH>
             <TH class="super-header" COLSPAN="4" ALIGN=CENTER>Lapse Periods</TH>
            <CFELSE>
             <TH class="super-header" COLSPAN="2" ALIGN=CENTER>Expended Amount</TH>
            </CFIF>
          </TR>
        </CFIF>

        <TR>
          <TH ALIGN="Left">Code</TH>
          <TH ALIGN="LEFT">Name</TH>

          <CFIF ShowBudg is "Yes">
            <TH ALIGN=RIGHT>Appropriated</TH>
          </CFIF>

          <TH ALIGN="RIGHT" NOWRAP>Expended YTD</TH>

          <CFIF ShowMo is "Yes">
            <TH ALIGN="CENTER">Jul</TH>
            <TH ALIGN="CENTER">Aug</TH>
            <TH ALIGN="CENTER">Sep</TH>
            <TH ALIGN="CENTER">Oct</TH>
            <TH ALIGN="CENTER">Nov</TH>
            <TH ALIGN="CENTER">Dec</TH>
            <TH ALIGN="CENTER">Jan</TH>
            <TH ALIGN="CENTER">Feb</TH>
            <TH ALIGN="CENTER">Mar</TH>
            <TH ALIGN="CENTER">Apr</TH>
            <TH ALIGN="CENTER">May</TH>
            <TH ALIGN="CENTER">Jun</TH>
            <TH ALIGN="CENTER">Jul</TH>
            <TH ALIGN="CENTER">Aug</TH>
            <TH ALIGN="CENTER">Sep</TH>
          <CFELSE>
            <CFIF ShowLapse is "Yes">
             <TH ALIGN="RIGHT">Non-Lapse</TH>
             <TH ALIGN="RIGHT">Lapse</TH>
            </CFIF>
          </CFIF>

          <CFIF ShowBudg is "Yes">
            <TH ALIGN="RIGHT">Unexpended</TH>
          </CFIF>
        </TR>
      </thead>

      <tbody>
        <cfloop QUERY="Results">
          <TR>

           <CFIF variables.GroupBy is "None">
            <TD ALIGN="left">#Code#</TD>
             <TD ALIGN="left" NOWRAP>#Name#</TD>
           <CFELSE>
            <TD ALIGN="left">
            <!--- <a href="/Expert/Exp/EEFramesQuery.cfm?#NewSettings#&#GroupBy#Sel=#Code#" target="_top"> --->
            #Code#<!--- </A> --->
            </TD>

             <TD ALIGN="left" NOWRAP>
             <!--- <a href="/Expert/Exp/EEFramesQuery.cfm?#NewSettings#&#GroupBy#Sel=#Code#" target="_top"> --->
            #Name#<!--- </A> --->
            </TD>
           </CFIF>

           <CFIF ShowBudg is "Yes">
            <TD ALIGN="RIGHT">#DollarFormat(ApprTotal)#</TD>
           </CFIF>

           <TD ALIGN="RIGHT">#DollarFormat(ExpTotal)#</TD>

           <CFIF ShowMo is "Yes">
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal1)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal2)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal3)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal4)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal5)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal6)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal7)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal8)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal9)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal10)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal11)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal12)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal13)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal14)#</TD>
            <TD ALIGN="RIGHT">#DollarFormat(ExpTotal15)#</TD>
           <CFELSE>
            <CFIF  ShowLapse is "Yes">
             <TD ALIGN="RIGHT">#DollarFormat(ExpTotal-ExpLapse)#</TD>
             <TD ALIGN="RIGHT">#DollarFormat(ExpLapse)#</TD>
            </CFIF>
           </CFIF>

           <CFIF ShowBudg is "Yes">
            <TD ALIGN="RIGHT">#DollarFormat(UnexpTotal)#</TD>
           </CFIF>
          </TR>
        </cfloop>
      </tbody>
     </table>
    <div>
  </cfif>
 </div>
</div>
</cfform>
<!-- END Statewide -->
</cfoutput>

<!---
<script>
$(document).ready(function() {
    $('#example').dataTable({
  "sPaginationType": "full_numbers",
  "footerCallback": function ( row, data, start, end, display ) {
    var api = this.api(), data;
    // Remove the formatting to get integer data for summation
    var intVal = function ( i ) {
     return typeof i === 'string' ? i.replace(/[\$,]/g, '')*1 : typeof i === 'number' ? i : 0;
    };

    // total_salary over all pages
    total_salary = api.column( 1 ).data().reduce( function (a, b) {
     return intVal(a) + intVal(b);
    },0 );

    // total_page_salary over this page
    total_page_salary = api.column( 1, { page: 'current'} ).data().reduce( function (a, b) {
     return intVal(a) + intVal(b);
    }, 0 );

    total_page_salary = parseFloat(total_page_salary);
    total_salary = parseFloat(total_salary);
    // Update footer
    $('#totalSalary').html(total_page_salary.toFixed(2)+"/"+total_salary.toFixed(2));
   },
 });
});
</script>
--->