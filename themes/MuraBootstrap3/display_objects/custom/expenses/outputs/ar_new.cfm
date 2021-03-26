<!-- Result Columns -->

<cfoutput>
    <cfif listlen(results.columnlist) lte 5>
        <cfset tableClass = 'datatable-export'/>
        <cfelse>
        <cfset tableClass = 'datatable-export-fixed'/>
    </cfif>
    <table class="<cfoutput>#tableClass#</cfoutput> table-striped datatable-primary" style="width:100%">
    <thead>
    <tr>
        <th class="header-left">Fund</th>
        <th class="header-left">Agency</th>
        <th class="header-left">Organization</th>
        <th class="header-left">Approp unit</th>
        <th class="header-left">Name</th>
        <CFIF variables.View IS "Budg">
            <th class="sum header-center">Original</th>
            <th class="sum header-center">Revised</th>
            <th class="sum header-center">Transfer In</th>
            <th class="sum header-center">Transfer Out</th>
            <th class="sum header-center">Net of Transfers Appropriated Amount</th>
            <th class="sum header-center">Reversion</th>
            <!---<th class="sum header-center">Beg Cash Bal</th>--->
            <th class="sum header-center">Net Appropriated</th>
            <th class="sum header-center">Year To Date Expended Amount</th>
            <th class="sum header-center">Unexpended Amount</th>
        </CFIF>
        <CFIF variables.View IS NOT "Budg">
            <th class="sum header-center">Net Appropriated</th>
            <th class="sum header-center">Net of Transfers Appropriated Amount</th>
            <th class="sum header-center">Expended YTD</th>
        </CFIF>
        <CFIF variables.ShowMo IS "Yes">
            <th class="sum header-center">Jul</th>
            <th class="sum header-center">Aug</th>
            <th class="sum header-center">Sep</th>
            <th class="sum header-center">Oct</th>
            <th class="sum header-center">Nov</th>
            <th class="sum header-center">Dec</th>
            <th class="sum header-center">Jan</th>
            <th class="sum header-center">Feb</th>
            <th class="sum header-center">Mar</th>
            <th class="sum header-center">Apr</th>
            <th class="sum header-center">May</th>
            <th class="sum header-center">Jun</th>
            <th class="sum header-center">Jul</th>
            <th class="sum header-center">Aug</th>
            <th class="sum header-center"><a style="color: white;" data-toggle="modal" href="##myModal">Sep and more</a></th>
        </CFIF>

        <CFIF variables.ShowLapse IS "Yes">
            <th class="sum header-center">Non-Lapse</th>
            <th class="sum header-center">Lapse</th>
        </CFIF>

        <CFIF variables.View IS "Exp">
            <th class="sum header-center">Unexpended</th>
        </CFIF>
    </tr>
    </thead>

    <tbody>
    <cfloop query="Results">
<!--- <CFIF variables.View IS "Budg">
	<CFSET Key = Results.Code>
<cfelse>
	<CFSET Key = Results.Code2>
</CFIF> --->
    <tr>
        <td>#Fund# - #Fund_Name#</td>
        <td>#Agency# - #Agency_Name#</td>
        <td>#Organization# - #Organization_Name#</td>
        <td align="center" NOWRAP>
            <a href="/agencies/resource-library/appropriation-inquiries/appropriation-inquiries-results-page?FY=#variables.FY#&ShowBudg=#variables.ShowBudg#&ShowExp=#variables.ShowExp#&ShowMo=#variables.ShowMo#&ShowLapse=#variables.ShowLapse#&View=#variables.View#&FundSel=#Fund#&AgcySel=#Agency#&OrgSel=#Organization#&ApprSel=#Results.Code#&Obj_Exp=#Results.Code2#">#Results.Code#</a>
        </td>
        <td NOWRAP>
            <a href="/agencies/resource-library/appropriation-inquiries/appropriation-inquiries-results-page?FY=#variables.FY#&ShowBudg=#variables.ShowBudg#&ShowExp=#variables.ShowExp#&ShowMo=#variables.ShowMo#&ShowLapse=#variables.ShowLapse#&View=#variables.View#&FundSel=#Fund#&AgcySel=#Agency#&OrgSel=#Organization#&ApprSel=#Results.Code#&Obj_Exp=#Results.Code2#">
        #APP_NAME#</a></td>
        <CFIF variables.View IS "Budg">
            <td align="right">#DollarFormat(Results.OriginalTotal)#</td>
            <td align="right">#DollarFormat(Results.RevisedTotal)#</td>
            <td align="right">#DollarFormat(Results.TransInTotal)#</td>
            <td align="right">#DollarFormat(Results.TransOutTotal)#</td>
            <td align="right">#DollarFormat(VAL(Results.RevisedTotal) + VAL(Results.TransInTotal) + VAL(Results.TransOutTotal))#</td>
            <td align="right">#DollarFormat(Results.RevertTotal)#</td>
            <!--- <td align="right">#DollarFormat(Results.CashBalTotal)#</td> --->
            <td align="right">#DollarFormat(Results.ApprTotal)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal)#</td>
            <td align="right">#DollarFormat(Results.UnExpTotal)#</td>
        </CFIF>
        <CFIF variables.View IS NOT "Budg">
            <td align="right"><CFIF IsDefined("Results.ApprTotal") AND IsNumeric(Results.ApprTotal)>#DollarFormat(Results.ApprTotal)#<cfelse>$0.00</CFIF></td>
            <td align="right"><CFIF IsDefined("Results.NetTotal") AND IsNumeric(Results.NetTotal)>#DollarFormat(Results.NetTotal)#<cfelse>$0.00</CFIF></td>
            <td align="right"><CFIF IsDefined("Results.ExpTotal") AND IsNumeric(Results.ExpTotal)>#DollarFormat(Results.ExpTotal)#<cfelse>$0.00</CFIF></td>
        </CFIF>
        <CFIF variables.ShowMo IS "Yes">
            <td align="right">#DollarFormat(Results.ExpTotal1)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal2)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal3)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal4)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal5)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal6)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal7)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal8)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal9)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal10)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal11)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal12)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal13)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal14)#</td>
            <td align="right">#DollarFormat(Results.ExpTotal15)#</td>
        </CFIF>
        <CFIF variables.ShowLapse IS "Yes">
            <td align="right">#DollarFormat(Results.ExpTotal - Results.ExpLapse)#</td>
            <td align="right">#DollarFormat(Results.ExpLapse)#</td>
        </CFIF>
        <CFIF variables.View IS "Exp">
            <td align="right"> <CFIF IsDefined("Results.UnexpTotal") AND IsNumeric(Results.UnexpTotal)>#DollarFormat(Results.UnexpTotal)#<cfelse> $0.00</CFIF></td>
        </CFIF>
        </tr>
    </cfloop>
    </tbody>
    <tfoot>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <CFIF variables.View IS "Budg">
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
        </CFIF>
        <CFIF variables.View IS NOT "Budg">
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
        </CFIF>
        <CFIF variables.ShowMo IS "Yes">
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
        </CFIF>
        <CFIF variables.ShowLapse IS "Yes">
            <td style="text-align: right;"></td>
            <td style="text-align: right;"></td>
        </CFIF>
        <CFIF variables.View IS "Exp">
            <td style="text-align: right;"></td>
        </CFIF>
    </tr>
    </tfoot>
    </table>
</cfoutput>

<!--- Modal --->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width: 70%">
            <!-- Modal content-->
            <div id="LaspseAmount" class="modal-content">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <p><h4 class="modal-title" align="center">This amount represents expenditures for September Lapse Period and any succeeding Lapse Period months.  
                    <br>You can obtain information for the individual months by contacting our Office <a href="https://illinoiscomptroller.gov/about/contact/send-us-a-message/">here.</a> </h4></p>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>