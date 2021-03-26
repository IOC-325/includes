<cfoutput>
    <cfif listlen( results.columnlist ) lte 8>
        <cfset tableClass = ' datatable-export' />
    <cfelse>
        <cfset tableClass= ' datatable-export-fixed' />
    </cfif>

    <CFIF Results.recordcount GT 0>
        <table class="#tableClass# table-striped datatable-primary" style="width: 100%;">
            <thead>
                <!--- Create two header if Lapse or Monthly --->
                <CFIF (variables.ShowLapse is "Yes") OR (variables.ShowMo is "Yes")>
                <tr>
                    <th class="super-header"></th>
                    <th class="super-header"></th>
                    <cfif variables.showBudg eq "yes" AND IsDefined ("Results.ApprTotal")>
                        <th class="super-header">&nbsp;</th>
                    </cfif>
                    <th class="super-header">&nbsp;</th>
                    <CFIF variables.ShowMo IS "Yes">
                        <th class="super-header header-center" colspan="12">Monthly Expended Amounts</th>
                    </CFIF>
                    <CFIF variables.ShowLapse is "Yes" AND variables.ShowMo IS "Yes">
                        <th class="super-header header-center" colspan="3">Lapse Periods</th>
                    </cfif>
                    <cfif (variables.showBudg eq "yes" AND IsDefined ("Results.UnexpTotal")) OR variables.ShowLapse IS "Yes">
                        <CFIF variables.ShowLapse IS "Yes">
                            <CFSET Col_EA = 3>
                        <cfelse>
                            <CFSET Col_EA = 1>
                        </CFIF>
                        <th class="super-header header-center" colspan="#Col_EA#">Expended Amount</th>
                    </cfif>
                </tr>
                </CFIF>
                <tr>
                    <th class="header-left">Code</th>
                    <th class="header-left">#GroupByFN#</th>
                    <CFIF variables.ShowBudg is "Yes" AND IsDefined ("Results.ApprTotal")>
                        <th class="sum header-left">Appropriated</th>
                    </CFIF>
                    <th class="sum header-left" nowrap="nowrap">Expended YTD</th>
                    <CFIF variables.ShowMo is "Yes">
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
                    <CFIF variables.ShowMo is "Yes" AND variables.ShowLapse is "Yes">
                        <th class="sum header-center">Jul</th>
                        <th class="sum header-center">Aug</th>
                        <th class="sum header-center"><a style="color: white;" data-toggle="modal" href="##myModal">Sep and more</a></th>
                    </cfif>
                    <CFIF variables.ShowLapse is "Yes">
                        <th class="sum header-left">Non-Lapse</th>
                        <th class="sum header-left">Lapse</th>
                    </CFIF>
                    <CFIF variables.ShowBudg is "Yes" AND IsDefined ("Results.UnexpTotal")>
                        <th class="sum header-left">Unexpended</th>
                    </CFIF>
                </tr>
            </thead>
            <tbody>
                <cfloop QUERY="Results">
                    <CFSET variables[ThisName] = Results.Code>
                    <tr>
                        <CFIF DisableHyperLink IS "Yes">
                            <td>#Code#</td>
                            <td nowrap="nowrap">#Name#</td>
                        <cfelse>
                             <td><a href="?GroupBy=#OutGoingGroupBy#&FY=#variables.FY#&ShowMo=#variables.ShowMo#&ShowBudg=#variables.ShowBudg#&ShowLapse=#variables.ShowLapse#&FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&FundCatSel=#variables.FundCatSel#&FundTypeSel=#variables.FundTypeSel#&AgcySel=#variables.AgcySel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyTypeSel=#variables.AgcyTypeSel#&AgcyCatSel=#variables.AgcyCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#variables.RevGrpSel#&RevTypeSel=#variables.RevTypeSel#&Type=#variables.Type#&ObjeSel=#variables.ObjeSel#&ObjeGrpSel=#variables.ObjeGrpSel#&ObjeCatSel=#variables.ObjeCatSel#&ObjeTypeSel=#variables.ObjeTypeSel#&ApprSel=#variables.ApprSel#&ApprGrpSel=#variables.ApprGrpSel#&ApprCatSel=#variables.ApprCatSel#&ApprTypeSel=#variables.ApprTypeSel#&ApprClsSel=#variables.ApprClsSel#&objtSel=#variables.objtSel#&objtGrpSel=#variables.objtGrpSel#&objtCatSel=#variables.objtCatSel#&objtTypeSel=#variables.objtTypeSel#" target="_top">#Code#</a></td>
                             <td><a href="?GroupBy=#OutGoingGroupBy#&FY=#variables.FY#&ShowMo=#variables.ShowMo#&ShowBudg=#variables.ShowBudg#&ShowLapse=#variables.ShowLapse#&FundSel=#variables.FundSel#&FundGrpSel=#variables.FundGrpSel#&FundCatSel=#variables.FundCatSel#&FundTypeSel=#variables.FundTypeSel#&AgcySel=#variables.AgcySel#&AgcyGrpSel=#variables.AgcyGrpSel#&AgcyTypeSel=#variables.AgcyTypeSel#&AgcyCatSel=#variables.AgcyCatSel#&RevSel=#variables.RevSel#&RevClsSel=#variables.RevClsSel#&RevGrpSel=#variables.RevGrpSel#&RevTypeSel=#variables.RevTypeSel#&Type=#variables.Type#&ObjeSel=#variables.ObjeSel#&ObjeGrpSel=#variables.ObjeGrpSel#&ObjeCatSel=#variables.ObjeCatSel#&ObjeTypeSel=#variables.ObjeTypeSel#&ApprSel=#variables.ApprSel#&ApprGrpSel=#variables.ApprGrpSel#&ApprCatSel=#variables.ApprCatSel#&ApprTypeSel=#variables.ApprTypeSel#&ApprClsSel=#variables.ApprClsSel#&objtSel=#variables.objtSel#&objtGrpSel=#variables.objtGrpSel#&objtCatSel=#variables.objtCatSel#&objtTypeSel=#variables.objtTypeSel#" target="_top">#Name#</a></td>
                        </cfif>
                        <CFIF variables.ShowBudg is "Yes"  AND IsDefined ("Results.ApprTotal")>
                            <td align="right"> #DollarFormat(ApprTotal)#</td>
                        </CFIF>
                        <td align="right">#DollarFormat(Results.ExpTotal)#</td>
                        <CFIF variables.ShowMo is "Yes">
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
                        <CFIF variables.ShowLapse is "Yes">
                            <CFIF variables.ShowMo is "Yes">
                                <td align="right">#DollarFormat(ExpTotal13)#</td>
                                <td align="right">#DollarFormat(ExpTotal14)#</td>
                                <td align="right">#DollarFormat(ExpTotal15)#</td>
                            </cfif>
                            <!--- Non Lapse --->
                            <td align="right">#DollarFormat(ExpTotal-ExpLapse)#</td>
                            <!--- Lapse --->
                            <td align="right">#DollarFormat(ExpLapse)#</td>
                        </CFIF>
                        <CFIF variables.ShowBudg is "Yes"  AND IsDefined ("Results.UnexpTotal")>
                        <!--- Unexpended --->
                        <td align="right"><CFIF IsDefined ("Results.UnexpTotal")>#DollarFormat(Results.UnexpTotal)#<cfelse> $0.00</CFIF></td>
                        </CFIF>
                    </tr>
                </cfloop>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="2">&nbsp;</td>
                    <CFIF variables.ShowBudg is "Yes" AND IsDefined ("Results.ApprTotal")>
                        <td style="text-align: right;"></td>
                    </CFIF>
                    <td style="text-align: right;"></td>
                    <CFIF variables.ShowMo is "Yes">
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
                    </cfif>
                    <CFIF variables.ShowLapse is "Yes">
                        <CFIF variables.ShowMo is "Yes">
                            <td style="text-align: right;"></td>
                            <td style="text-align: right;"></td>
                            <td style="text-align: right;"></td>
                        </cfif>
                        <td style="text-align: right;"></td>
                        <td style="text-align: right;"></td>
                    </CFIF>
                    <CFIF variables.ShowBudg is "Yes" AND IsDefined ("Results.UnexpTotal")>
                        <td style="text-align: right;"></td>
                    </CFIF>
                </tr>
            </tfoot>
        </table>
        <cfelse>
        <table class="table">
            <tr>
                <td align="center">No Results Found</td>
            </tr>
        </table>
    </CFIF>
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