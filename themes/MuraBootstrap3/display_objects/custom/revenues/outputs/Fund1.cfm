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
                <th class="super-header"></th>
                <th class="super-header"></th>
                <th class="super-header"></th>
                <CFIF variables.ShowMo is "Yes">
                    <th colspan="12" class="super-header header-center">Monthly Revenue Amounts</th>
                </CFIF>
            </tr>
            <tr>
                <th class="header-left">Code</th>
                <th class="header-left">#GroupByFN#</th>
                <th class="sum header-left">Revenue YTD</th>
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
                <!--- Get the Concatenated GroupBy selector from  below the results output and assign a value from per row of the (CODE) results  --->
                <CFSET variables[ThisName] = Results.Code>
                <tr>
                <CFIF DisableHyperLink IS "Yes">
                    <td>#Code#</td>
                    <td nowrap="nowrap">#Name#</td>
                <cfelse>
                     <td><a href="?FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&FundCatSel=#variables.FundCatSel#&FundTypeSel=#variables.FundTypeSel#&GroupBy=#OutGoingGroupBy#&FY=#variables.FY#&ShowMo=#variables.ShowMo#&AgcySel=#variables.AgcySel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyTypeSel=#variables.AgcyTypeSel#&AgcyCatSel=#variables.AgcyCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#variables.RevGrpSel#&RevTypeSel=#variables.RevTypeSel#" target="_top">#Code#</a></td>
                    <td nowrap="nowrap"><a href="?FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&FundCatSel=#variables.FundCatSel#&FundTypeSel=#variables.FundTypeSel#&GroupBy=#OutGoingGroupBy#&FY=#variables.FY#&ShowMo=#variables.ShowMo#&AgcySel=#variables.AgcySel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyTypeSel=#variables.AgcyTypeSel#&AgcyCatSel=#variables.AgcyCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#variables.RevGrpSel#&RevTypeSel=#variables.RevTypeSel#" target="_top">#Name#</a></td>
                </CFIF>

                <CFIF IsDefined ("RevTotal")>
                    <td align="right">#DollarFormat(RevTotal)#</td>
                <cfelse>
                    <td align="right">#DollarFormat(ExpTotal)#</td>
                </CFIF>

                <CFIF ShowMo is "Yes">
                    <CFIF IsDefined ("RevTotal")>
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
                    <cfelse>
                        <td align="right">#DollarFormat(ExpTotal1)#</td>
                        <td align="right">#DollarFormat(ExpTotal2)#</td>
                        <td align="right">#DollarFormat(ExpTotal3)#</td>
                        <td align="right">#DollarFormat(ExpTotal4)#</td>
                        <td align="right">#DollarFormat(ExpTotal5)#</td>
                        <td align="right">#DollarFormat(ExpTotal6)#</td>
                        <td align="right">#DollarFormat(ExpTotal7)#</td>
                        <td align="right">#DollarFormat(ExpTotal8)#</td>
                        <td align="right">#DollarFormat(ExpTotal9)#</td>
                        <td align="right">#DollarFormat(ExpTotal10)#</td>
                        <td align="right">#DollarFormat(ExpTotal11)#</td>
                        <td align="right">#DollarFormat(ExpTotal12)#</td>
                    </CFIF>
                </CFIF>
                </tr>
            </cfloop>
        </tbody>
        <tfoot>
            <tr>
                <th colspan="#numberOfColumns#" style="text-align: right;">
                    Total: #DOLLARFORMAT(CalculatedTotal)#
                </th>
            </tr>
        </tfoot>
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