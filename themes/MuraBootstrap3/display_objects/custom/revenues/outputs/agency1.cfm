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

    <CFIF Results.recordcount GT 0>
        <table class="#tableClass# table-striped datatable-primary" style="width: 100%;">
            <thead>
                <tr>
                    <th class="super-header">&nbsp;</th>
                    <th class="super-header">&nbsp;</th>
                    <th class="super-header">&nbsp;</th>
                    <CFIF variables.ShowMo is "Yes">
                        <th colspan="12" class="super-header header-center">Monthly Recorded Amounts</th>
                    </CFIF>
                </tr>
                <tr>
                    <th>Code</th>
                    <th>#GroupByFN#</th>
                    <th align="right" class="sum" nowrap="nowrap">Revenue YTD</th>
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
                <CFSET variables[ThisName] = Results.Code>
                    <tr>
                        <CFIF DisableHyperLink IS "Yes">
                            <td>#Code#</td>
                            <td nowrap="nowrap">#Name#</td>
                        <cfelse>
                            <td><a href="?AgcySel=#variables.AgcySel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyCatSel=#variables.AgcyCatSel#&AgcyTypeSel=#variables.AgcyTypeSel#&GroupBy=#OutGoingGroupBy#&FY=#variables.FY#&ShowMo=#Variables.ShowMo#&FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&FundTypeSel=#variables.FundTypeSel#&FundCatSel=#variables.FundCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevTypeSel=#variables.RevTypeSel#&RevCatSel=#variables.RevCatSel#" target="_top">#Code#</a></td>
                            <td nowrap="nowrap"><a href="?AgcySel=#variables.AgcySel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyCatSel=#variables.AgcyCatSel#&AgcyTypeSel=#variables.AgcyTypeSel#&GroupBy=#OutGoingGroupBy#&FY=#variables.FY#&ShowMo=#Variables.ShowMo#&FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&FundTypeSel=#variables.FundTypeSel#&FundCatSel=#variables.FundCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevTypeSel=#variables.RevTypeSel#&RevCatSel=#variables.RevCatSel#" target="_top">#Name#</a></td>
                        </CFIF>
                        <CFIF IsDefined ("RevTotal")>
                            <td class="data-right">#DollarFormat(RevTotal)#</td>
                        <cfelse>
                            <td class="data-right">#DollarFormat(ExpTotal)#</td>
                        </CFIF>

                        <CFIF ShowMo is "Yes">
                            <CFIF IsDefined ("RevTotal")>
                                <td class="data-right">#DollarFormat(RevJul)#</td>
                                <td class="data-right">#DollarFormat(RevAug)#</td>
                                <td class="data-right">#DollarFormat(RevSep)#</td>
                                <td class="data-right">#DollarFormat(RevOct)#</td>
                                <td class="data-right">#DollarFormat(RevNov)#</td>
                                <td class="data-right">#DollarFormat(RevDec)#</td>
                                <td class="data-right">#DollarFormat(RevJan)#</td>
                                <td class="data-right">#DollarFormat(RevFeb)#</td>
                                <td class="data-right">#DollarFormat(RevMar)#</td>
                                <td class="data-right">#DollarFormat(RevApr)#</td>
                                <td class="data-right">#DollarFormat(RevMay)#</td>
                                <td class="data-right">#DollarFormat(RevJun)#</td>
                            <cfelse>
                                <td class="data-right">#DollarFormat(ExpTotal1)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal2)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal3)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal4)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal5)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal6)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal7)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal8)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal9)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal10)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal11)#</td>
                                <td class="data-right">#DollarFormat(ExpTotal12)#</td>
                            </CFIF>
                        </CFIF>
                    </tr>
                </cfloop>
            </tbody>
        </table>
    <cfelse>
        <table class="table">
            <tbody>
                <tr>
                    <td align="center">No records found</td>
                </tr>
            </tbody>
        </table>
    </CFIF>
</cfoutput>