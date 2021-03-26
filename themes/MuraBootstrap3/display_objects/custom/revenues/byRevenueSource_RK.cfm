<cfif isDefined("form.submit")>
  <CFSET HideSwitch1 = "none">
  <CFSET HideSwitch2 = "block">
<cfif form.formGroup eq 0 or TRIM(form.formGroup) eq "None">
        <cfset variables.formGroup = "fund">
    <cfelse>
        <cfset variables.formGroup = form.formGroup>
    </cfif>
    <cfif form.REVENUE_SOURCE eq 0 or TRIM(form.REVENUE_SOURCE) eq "">
        <cfset variables.REVENUE_SOURCE = "">
    <cfelse>
        <cfset variables.REVENUE_SOURCE = form.REVENUE_SOURCE>
    </cfif>
    <cfif form.Class eq 0 or TRIM(form.Class) eq "">
        <cfset variables.Class = "">
    <cfelse>
        <cfset variables.Class = form.Class>
    </cfif>
    <cfif form.Group eq 0 or TRIM(form.Group) eq "">
        <cfset variables.Group = "">
    <cfelse>
        <cfset variables.Group = form.Group>
    </cfif>
    <cfif form.Type eq 0 or TRIM(form.Type) eq "">
        <cfset variables.Type = "">
    <cfelse>
        <cfset variables.Type = form.Type>
    </cfif>
    <cfif form.FY eq 0 or TRIM(form.FY) eq "">
        <cfset variables.FY = "#DATEFORMAT(NOW(), 'yy')#">
    <cfelse>
        <cfset variables.FY = form.FY>
    </cfif>
    <CFIF IsDefined ("form.ViewMonthlyAmounts")>
        <CFSET ShowMonthlySwitch = "Yes">
    <cfelse>
        <CFSET ShowMonthlySwitch = "No">
    </CFIF>

    <cfinvoke component="Queries.revenues"
         method="RevenueQuery"
         returnvariable="results">
            <cfinvokeargument name="Control" value="Rev">
            <cfinvokeargument name="GroupBy" value="#variables.formGroup#">
            <cfinvokeargument name="Max" value="20">
            <cfinvokeargument name="FY" value="#variables.FY#">
            <cfinvokeargument name="ShowMo" value="#ShowMonthlySwitch#">
            <cfinvokeargument name="FundSel" value="">
            <cfinvokeargument name="FundGrpSel" value="">
            <cfinvokeargument name="FundTypSel" value="">
            <cfinvokeargument name="FundCatSel" value="">
            <cfinvokeargument name="AgcySel" value="">
            <cfinvokeargument name="AgcyGrpSel" value="">
            <cfinvokeargument name="AgcyTypSel" value="">
            <cfinvokeargument name="AgcyCatSel" value="">
            <cfinvokeargument name="RevSel" value="#variables.REVENUE_SOURCE#">
            <cfinvokeargument name="RevClsSel" value="#variables.Class#">
            <cfinvokeargument name="RevGrpSel" value="#variables.Group#">
            <cfinvokeargument name="RevTypSel" value="#variables.Type#">
            <cfinvokeargument name="SortName" value="No">
     </cfinvoke>
    <!--- Get the column headers from the query.  This is used for the table header in the report results below. --->
 <CFSET ColumnList = results.columnList>
 <cfelse>
   <CFSET HideSwitch1 = "block">
   <CFSET HideSwitch2 = "none">
</cfif>

    <cfinvoke component="Queries.warehouse"
    method="GetRevenueSource"
    returnvariable="qRL">
   </cfinvoke>


   <!--- get Revenue groups --->
   <cfinvoke component="Queries.warehouse"
    method="GetRevenueGroup"
    returnvariable="qRGL" >
   </cfinvoke>

   <!--- get Revenue class --->
   <cfinvoke component="Queries.warehouse"
    method="GetRevenueClass"
    returnvariable="qRC" >
   </cfinvoke>

   <!--- get Revenue Types --->
   <cfinvoke component="Queries.warehouse"
    method="GetRevenueType"
    returnvariable="qRT" >
   </cfinvoke>
   <!--- Get Fiscal years --->
    <cfinvoke component="Queries.warehouse"
     method="getFYs"
     returnvariable="qFYList" >
    <cfinvokeargument name="numFYs" value="5"/>
       <cfinvokeargument name="MaxFY" value="#DATEFORMAT(NOW(), 'yyyy')#">
   </cfinvoke>
   <!--- Get Revenue Source Group By--->
    <cfinvoke component="Queries.autosuggest"
     method="GetRevenueSourceGroupBy" >
   </cfinvoke>


<cfoutput>
<div id="expense" class="revenue">
 <div class="container">
 <cfform method="post" enctype="application/x-www-form-urlencoded" preloader="no">

     <div class="row">
      <div class="col-md-10 col-md-offset-1" id="SearchInfo">
       <h1>#$.getTitle()#</h1>
        <p>The state of Illinois collects revenue from a variety of sources. Information provided by the Office of the Comptroller allows taxpayers to identify those revenue streams. </p>
        <div class="row">
          <fieldset>
           <div class="col-xs-12 col-sm-10">
            <select name="Revenue_Source">
             <option value="0" selected="selected">Select an Revenue Source</option>
             <option value="0">All</option>
             <cfloop query="qRL">
              <option value= "#qRL.Revenue_Source#">#qRL.Revenue_Source# - #qRL.Name#</option>
             </cfloop>
            </select>
           </div>
           <div class="col-xs-10">
            <select name="Group">
             <option value="0" selected="selected">Select Group</option>
             <option value="0">All</option>
             <cfloop query="qRGL">
              <option value= "#qRGL.Group#">#qRGL.Group# - #qRGL.Name#</option>
             </cfloop>
            </select>
           </div>
           <div class="col-xs-2">
            <a class="tooltip-icon" href="##" data-toggle="tooltip" data-placement="top" title="Group!">?</a>
           </div>
           <div class="col-xs-10">
            <select name="Class">
             <option value="0" selected="selected">Select Class</option>
             <option value="0">All</option>
             <cfloop query="qRC">
              <option value= "#qRC.Class#">#qRC.Class# - #qRC.Name#</option>
             </cfloop>
            </select>
           </div>
           <div class="col-xs-2">
            <a class="tooltip-icon" href="##" data-toggle="tooltip" data-placement="top" title="Category!">?</a>
           </div>
           <div class="col-xs-10">
                <select name="Type">
                <option value="0" selected="selected">Select Type</option>
                <option value="0">All</option>
                 <cfloop query="qRT">
                   <option value= "#qRT.Type#">#qRT.Type# - #qRT.Name#</option>
                 </cfloop>
                </select>
           </div>
           <div class="col-xs-2">
            <a class="tooltip-icon" href="##" data-toggle="tooltip" data-placement="top" title="Type!">?</a>
           </div>
           <div class="col-sm-10 col-xs-12">
            <div class="hr"></div>
           </div>
           <div class="col-sm-10 col-xs-12">
                <cfselect name="FormGroup">
                 <option value="None" selected="selected">Group By</option>
                    <Cfloop query="#application.qRevenueGroupSources#">
                     <option value="#application.qRevenueGroupSources.AbbrName#">#application.qRevenueGroupSources.Name#</option>
                    </Cfloop>
                </cfselect>
           </div>
           <div class="col-sm-10 col-xs-12 required">
                <select name="FY">
                 <option value="#DATEFORMAT(NOW(), 'yy')#" selected="selected">Fiscal Year</option>
                    <Cfloop index="i" list="#qFYList#">
                     <option value="#RIGHT(i,2)#">#i#</option>
                    </Cfloop>
                </select>
           </div>

           <div class="col-sm-10 col-xs-12">
            <input type="checkbox" id="checkbox_1" name="monthlyTotals" value="Checkbox One" />
               <label for="checkbox_1">View Monthly Totals</label>
              </div>

              <div class="text-center top-pad col-xs-12 col-sm-11">
               <button class="btn btn-success" name="submit" type="submit">Submit</button>
              </div>
          </fieldset>
          <div class="col-sm-11">
           <div class="lastsearch">
            <h2>Last Search</h2>
            <div class="block">
             <ul>
              <li>Fund Category: B - Highway Funds</li>
              <li>Revenues by Revenue Source</li>
              <li>Fiscal Year 16</li>
             </ul>
            </div>
           </div>
          </div>
        </div>
      </div>
     </div>

   <cfif IsDefined ("results")>


    <CFIF ListLen(ColumnList) LTE 3>
     <CFSET SetFontSize = 14>
    <cfelseif ListLen(ColumnList) GT 3 AND ListLen(ColumnList) LTE 6>
     <CFSET SetFontSize = 12>
    <cfelse>
     <CFSET SetFontSize = 9>
    </CFIF>


    <div class="row show">
      <div class="text-center custom-pad-around col-sm-10 col-xs-12">
        <button class="btn btn-success" name="searchAgain" type="button" style="display:#HideSwitch2#">Search Again</button>
      </div>

        <cfset varColIst = results.ColumnList>
        <!--- <table class="table datatable no-footer"> --->
        <table class="table no-footer table-striped" style="font-size:#SetFontSize#px">

          <tr >
            <cfloop index = "ListElement" list = "#varColIst#">
                <th ><cfoutput>#ListElement#</cfoutput></th>
            </cfloop>
          </tr>

         <cfloop QUERY="results">
          <tr>
          <cfloop index = "ListElement" list = "#varColIst#">
           <!--- <td>#Evaluate("results.#ListElement#")#</td> --->
              <td>
               <cfif isNumeric(results[ListElement][results.currentRow]) and Ucase(ListElement) neq 'CODE'>
               #DollarFormat(results[ListElement][results.currentRow])#
               <cfelse>
                #results[ListElement][results.currentRow]#
              </cfif>
             </td>
          </cfloop>
          </tr>
         </cfloop>
        </table>
    </div>
   </cfif>
  </cfform>
 </div>
</div>


</cfoutput>