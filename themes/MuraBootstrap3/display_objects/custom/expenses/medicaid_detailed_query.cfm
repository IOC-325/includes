<cfif isDefined("URL.FY") AND isDefined("URL.agency")>

    <cfif URL.agency eq 444>
        <!--- DHS CURRENT FY --->
        <cfinvoke component="Queries.expenditures" 
            method="MEDICAID_EXP_DHS_CFY_QUERY" 
            returnvariable="Q_MEDICAID_DETAILS">
            <cfinvokeargument  name="fiscal_year"  value="#URL.FY#">
            <cfinvokeargument  name="group_by_fund"  value="0">
        </cfinvoke>
    <cfelseif URL.agency eq 402 >
        <!--- AGING CURRENT FY --->
        <cfinvoke component="Queries.expenditures" 
            method="MEDICAID_EXP_AGING_CFY_QUERY" 
            returnvariable="Q_MEDICAID_DETAILS">
            <cfinvokeargument  name="fiscal_year"  value="#URL.FY#">
            <cfinvokeargument  name="group_by_fund"  value="0">
        </cfinvoke>
    <cfelseif URL.agency eq 478>
        <!--- DHS CURRENT FY --->
        <cfinvoke component="Queries.expenditures" 
            method="MEDICAID_EXP_HFS_CFY_QUERY" 
            returnvariable="Q_MEDICAID_DETAILS">
            <cfinvokeargument  name="fiscal_year"  value="#URL.FY#">
            <cfinvokeargument  name="group_by_fund"  value="0">
        </cfinvoke>
    <cfelse>
        <cfset error = true>
    </cfif>
<!-- START EXPENSE -->

    <cfif !isDefined("error")>
        <div id="expense" class="revenue">
            <cfoutput>
                <div stlye="width:50%; margin-left:auto; margin-right:auto;">
                    <h4><b>Agency:</b> #EncodeForHTML(URL.agency)#</h4>
                    <h4><b>Fiscal Year:</b> 20#EncodeForHTML(URL.FY)#</h4>
                    <table class="table table-sorting table-striped table-2018">
                        <tr>
                            <th class="bg-info">Fund</th>
                            <th class="bg-info text-right">Amount</th>
                        </tr>
                        <cfif Q_MEDICAID_DETAILS.RecordCount>
                            <cfloop query="#Q_MEDICAID_DETAILS#">
                                <tr>						
                                    <td>#EncodeForHTML(Q_MEDICAID_DETAILS.Name)#</td>
                                    <td class="text-right">
                                        <a href="/financial-data/state-expenditures/medicaid-details-by-object/?fund=#URLEncodedFormat(Q_MEDICAID_DETAILS.Fund)#&agency=#URLEncodedFormat(URL.agency)#&FY=#URL.FY#">
                                            #EncodeForHTML(DollarFormat(Q_MEDICAID_DETAILS.EXPTOTAL))#
                                        </a>
                                    </td>
                                </tr>
                            </cfloop>
                        <cfelse>
                            <tr>						
                                <td colspan="2" class="text-center">No Data Available</td>
                            </tr>
                        </cfif>
                    </table>
                </div>
            </cfoutput>
        </div>
        <!-- END EXPENSE -->
    <cfelse>
        Oops something went wrong!
    </cfif>

<cfelse>
    Oops something went wrong!
</cfif>


<a href = "/financial-data/state-expenditures/medicaid/">Back</a>