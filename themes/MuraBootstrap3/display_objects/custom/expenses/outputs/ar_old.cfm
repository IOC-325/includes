<cfoutput query="results">
<div class="container">
<!-- net approp, ytd, total lapse, enxepended -->
<div class="row">
    <div class="col-sm-4">
        <table class="table table-bordered vendor-table">
            <thead>
                <tr>
                    <th colspan="2">Appropriation Amounts</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Net of trans Appr Amt</td>
                    <td align="right">#DollarFormat((Results.RevisedTotal)+(Results.transInTotal)+(Results.transOutTotal))#</td>    
                </tr>
                <tr>
                    <td>Original</td>
                    <td align="right">#DollarFormat(Results.OriginalTotal)#</td>
                </tr>
                <tr>
                    <td>Revised</td>
                    <td align="right">#DollarFormat(Results.RevisedTotal)#</td>
                </tr>
                <tr>
                    <td>transfer In</td>
                    <td align="right">#DollarFormat(Results.transInTotal)#</td>
                </tr>
                <tr>
                    <td>transfer Out</td>
                    <td align="right">#DollarFormat(Results.transOutTotal)#</td>
                </tr>
                <tr>
                    <td>Reversion</td>
                    <td align="right">#DollarFormat(Results.RevertTotal)#</td>
                </tr>
                <tr>
                    <td>Beg Cash Balance</td>
                    <td align="right">#DollarFormat(Results.CashBalTotal)#</td>
                </tr>
                <tr>
                    <td>Net Appropriated</td>
                    <td align="right">#DollarFormat(Results.ApprTotal)#</td>
                </tr>
            </tbody>
        </table>

        <table class="table table-bordered vendor-table">
            <thead>
                <tr>
                    <th colspan="2">Unexpended Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Unexpended</td>
                    <td align="right">#DollarFormat(Results.UnExpTotal)#</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="col-sm-4">
        <table class="table table-bordered vendor-table">
            <thead>
                <tr>
                    <th colspan="2">Expended Amounts</th>        
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Year To Date</td>
                    <td align="right">#DollarFormat(Results.ExpTotal)#</td>    
                </tr>
                <tr>
                    <td>July</td>
                    <td align="right">#DollarFormat(Results.ExpTotal1)#</td>
                </tr>
                <tr>
                    <td>August</td>
                    <td align="right">#DollarFormat(Results.ExpTotal2)#</td>
                </tr>
                <tr>
                    <td>September</td>
                    <td align="right">#DollarFormat(Results.ExpTotal3)#</td>
                </tr>
                <tr>
                    <td>October</td>
                    <td align="right">#DollarFormat(Results.ExpTotal4)#</td>
                </tr>
                <tr>
                    <td>November</td>
                    <td align="right">#DollarFormat(Results.ExpTotal5)#</td>
                </tr>
                <tr>
                    <td>December</td>
                    <td align="right">#DollarFormat(Results.ExpTotal6)#</td>
                </tr>
                <tr>
                    <td>January</td>
                    <td align="right">#DollarFormat(Results.ExpTotal7)#</td>
                </tr>
                <tr>
                    <td>February</td>
                    <td align="right">#DollarFormat(Results.ExpTotal8)#</td>
                </tr>
                <tr>
                    <td>March</td>
                    <td align="right">#DollarFormat(Results.ExpTotal9)#</td>
                </tr>
                <tr>
                    <td>April</td>
                    <td align="right">#DollarFormat(Results.ExpTotal10)#</td>
                </tr>
                <tr>
                    <td>May</td>
                    <td align="right">#DollarFormat(Results.ExpTotal11)#</td>
                </tr>
                <tr>
                    <td>June</td>
                    <td align="right">#DollarFormat(Results.ExpTotal12)#</td>
                </tr>

            </tbody>
        </table>
    </div>
    <div class="col-sm-4">
        <table class="table table-bordered vendor-table">
            <thead>
                <tr>
                    <th colspan="2">Lapse Amounts</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Total Lapse</td>
                    <td align="right">#DollarFormat(Results.ExpLapse)#</td>
                </tr>
                <tr>
                    <td>Total Non-Lapse</td>
                    <td align="right">#DollarFormat(Results.ExpTotal-ExpLapse)#</td>
                </tr>
                <tr>
                    <td>Lapse July</td>
                    <td align="right">#DollarFormat(Results.ExpTotal13)#</td>
                </tr>
                <tr>
                    <td>Lapse August</td>
                    <td align="right">#DollarFormat(Results.ExpTotal14)#</td>
                </tr>
                <tr>
                    <td>Lapse September</td>
                    <td align="right">#DollarFormat(Results.ExpTotal15)#</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</div>
</cfoutput>