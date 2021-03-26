<cfoutput>
    <cfif listlen( results.columnlist ) lte 5>
        <cfset tableClass = ' datatable-export' />
    <cfelse>
        <cfset tableClass= ' datatable-export-fixed' />
    </cfif>

    <CFIF Results.recordcount GT 0>
	    <CFIF numberOfColumns IS 1>
            <table class="#tableClass# table-striped datatable-primary" style="width:100%;">
                <thead>
                    <tr>
                        <th>Type</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th></th>
                        <th style="text-align: right;"></th>
                    </tr> 
                </tfoot>
                <tbody>
                    <tr>
                        <td>Revenue</td>
                        <CFIF SumColumn IS "RevTotal">
                            <td style="text-align: right;">#DollarFormat(Results.RevTotal)#</td>
                        <cfelse>
                            <td style="text-align: right;">#DollarFormat(Results.ExpTotal)#</td>
                        </CFIF>
                    </tr>
                </tbody>
            </table>
        <cfelseif numberOfColumns IS 3>
            <table class="#tableClass# table-striped datatable-primary" style="width: 100%;">
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>#GroupByFN#</th>
                        <th class="sum header-center">Total</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th></th>
                        <th></th>
                        <th style="text-align: right;"></th>
                    </tr> 
                </tfoot>
                <tbody>
                    <Cfloop query="Results">
                        <CFSET variables[ThisName] = Results.Code>
                        <tr>
                            <CFIF ShowMo is "Yes" OR DisableHyperLink IS "Yes">
                                <td>#Results.Code#</TD>
                                <td nowrap="nowrap">#Results.Name#</TD>
                            <cfelse>
                                <td><a href="?GetQueryData=true&GroupBy=#OutGoingGroupBy#&FY=#C1_FY#&ShowMo=#C1_MT#&FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&FundTypeSel=#variables.FundTypeSel#&FundCatSel=#variables.FundCatSel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyTypeSel=#variables.AgcyTypeSel#&AgcyCatSel=#variables.AgcyCatSel#&AgcySel=#variables.AgcySel#&RevCatSel=#variables.RevCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#variables.RevGrpSel#&RevTypeSel=#variables.RevTypeSel#">#Code#</a></TD>
                                <td nowrap="nowrap"><a href="?GetQueryData=true&GroupBy=#OutGoingGroupBy#&FY=#C1_FY#&ShowMo=#C1_MT#&FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&FundTypeSel=#variables.FundTypeSel#&FundCatSel=#variables.FundCatSel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyTypeSel=#variables.AgcyTypeSel#&AgcyCatSel=#variables.AgcyCatSel#&AgcySel=#variables.AgcySel#&RevCatSel=#variables.RevCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#variables.RevGrpSel#&RevTypeSel=#variables.RevTypeSel#">#Name#</a></TD>
                            </CFIF>
                            <td align="right">
                                <CFIF SumColumn IS "RevTotal">
                                    #DollarFormat(Results.RevTotal)# 
                                <cfelse>
                                    #DollarFormat(Results.ExpTotal)#
                                </CFIF>
                            </td>
                        </tr>
                    </Cfloop>
                </tbody>
            </table>
        <cfelseif numberOfColumns GT 13>
            <table class="#tableClass# table-striped datatable-primary" style="width: 100%;">  
                <thead>
                    <tr>
                        <th colspan="3" class="super-header">&nbsp;</th>
                        <th colspan="12" class="super-header header-center">Monthly Revenues</th>
                    </tr>
                    <tr>
                        <th class="header-left">Code</th>
                        <th class="header-left">#GroupByFN#</th>
                        <th class="sum header-left" nowrap="nowrap">Revenue YTD</th>
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
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <td></td>
                        <td></td>
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
                    </tr>
                </tfoot>
                <tbody>
                    <cfloop query="results">
                        <CFSET variables[ThisName] = Results.Code>
                        <tr>
                            <CFIF DisableHyperLink IS "Yes">
                                <td>#Results.Code#</TD>
                                <td nowrap="nowrap">#Results.Name#</TD>
                            <cfelse>
                                <td><a href="?GetQueryData=true&GroupBy=#OutGoingGroupBy#&FY=#C1_FY#&ShowMo=#C1_MT#&FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&FundTypeSel=#variables.FundTypeSel#&FundCatSel=#variables.FundCatSel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyTypeSel=#variables.AgcyTypeSel#&AgcyCatSel=#variables.AgcyCatSel#&AgcySel=#variables.AgcySel#&RevCatSel=#variables.RevCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#variables.RevGrpSel#&RevTypeSel=#variables.RevTypeSel#">#Code#</a></td>
                                <td nowrap="nowrap"><a href="?GetQueryData=true&GroupBy=#OutGoingGroupBy#&FY=#C1_FY#&ShowMo=#C1_MT#&FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&FundTypeSel=#variables.FundTypeSel#&FundCatSel=#variables.FundCatSel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyTypeSel=#variables.AgcyTypeSel#&AgcyCatSel=#variables.AgcyCatSel#&AgcySel=#variables.AgcySel#&RevCatSel=#variables.RevCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#variables.RevGrpSel#&RevTypeSel=#variables.RevTypeSel#">#Name#</a></td>
                            </CFIF>
                            <td align="right">#DollarFormat(RevTotal)#</td>
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
                        </tr>
                    </cfloop>
                </tbody>
            </table>
        </cfif>
        <cfelse>
            <table class="table table-striped">
                <tbody>
                    <tr>
                        <td align="center">No records found</td>
                    </tr>
                </tbody>
            </table>
        </cfif>
</cfoutput>