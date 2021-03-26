<cfoutput>
    <cfif listlen( results.columnlist ) lte 5>
        <cfset tableClass = ' datatable-export' />
    <cfelse>
        <cfset tableClass= ' datatable-export-fixed' />
    </cfif>

    <cfif variables.showMo eq "no">
        <cfset variables.colCount = listlen( results.columnList ) />
    <cfelseif variables.showMo eq "yes" >
        <cfset variables.colCount = listlen( results.columnList ) />
    </cfif>

    <table class="#tableClass# table-striped datatable-primary" style="width: 100%;">
    <CFIF Results.recordcount GT 0>
    <thead>
        <tr>
            <th class="super-header"></th>
            <th class="super-header"></th>
            <th class="super-header"></th>
            <CFIF variables.ShowMo is "Yes">
                <th colspan="12" class="super-header header-center">Monthly Expended Amounts</th>
            </CFIF>
        </tr>
        <tr>
            <th class="header-left">Code</th>
            <th class="header-left">#GroupByFN#</th>
            <th class="sum" align="right" nowrap="nowrap">Revenue YTD</th>
            <CFIF ShowMo is "Yes">
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
            </CFIF>
        </tr>
    </thead>
    <tfoot>
        <tr>
            <th></th>
            <th></th>
            <th style="text-align: right;"></th>
            <CFIF ShowMo is "Yes">
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
                <th style="text-align: right;"></th>
            </CFIF>
        </tr>
    </tfoot>
    <tbody>
        <cfloop QUERY="Results">
        <CFSET variables[ThisName] = TRIM(Results.Code)>
            <TR>
                <CFIF DisableHyperLink IS "Yes">
                    <td>#Code#</td>
                    <td nowrap="nowrap">#Name#</td>
                <cfelse>
                    <td><a href="?GroupBy=#OutGoingGroupBy#&FY=#variables.FY#&monthlyTotals=#variables.ShowMo#&FundCatSel=#variables.FundCatSel#&FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&AgcySel=#variables.AgcySel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyTypeSel=#variables.AgcyTypeSel#&AgcyCatSel=#variables.AgcyCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#variables.RevGrpSel#&RevTypeSel=#variables.RevTypeSel#&FundTypeSel=#variables.FundTypeSel#" target="_top">#Code#</a></td>
                    <td nowrap="nowrap"><a href="?GroupBy=#OutGoingGroupBy#&FY=#variables.FY#&monthlyTotals=#variables.ShowMo#&FundCatSel=#variables.FundCatSel#&FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&AgcySel=#variables.AgcySel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyTypeSel=#variables.AgcyTypeSel#&AgcyCatSel=#variables.AgcyCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#variables.RevGrpSel#&RevTypeSel=#variables.RevTypeSel#&FundTypeSel=#variables.FundTypeSel#" target="_top">#Name#</a></td>
                </CFIF>
                <td align="right">#DollarFormat(RevTotal)#</td>

                <CFIF ShowMo is "Yes">
                    <td align="right">#DollarFormat(RevJul)#</td>
                    <td align="right">#DollarFormat(RevAug)#</td>
                    <td align="right">#DollarFormat(RevSep)#</td>
                    <td align="right">#DollarFormat(RevOct)#</td>
                    <td align="right">#DollarFormat(RevNov)#</td>
                    <td align="right">#DollarFormat(RevDec)#</td>
                    <td align="right">#DollarFormat(RevJan)#</td>
                    <td align="right">#DollarFormat(RevFeb)#</td>
                    <td align="right">#DollarFormat(RevMar)#</td>
                    <td align="right">#DollarFormat(RevApr)#</td>
                    <td align="right">#DollarFormat(RevMay)#</td>
                    <td align="right">#DollarFormat(RevJun)#</td>
                </CFIF>
            </TR>
        </cfloop>
        <cfelse>
        <tr>
            <td>No records found</td>
        </tr>
    </tbody>
    </CFIF>
    </table>
</cfoutput>


