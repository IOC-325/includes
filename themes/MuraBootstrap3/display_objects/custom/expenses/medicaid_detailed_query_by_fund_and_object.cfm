<cfif isDefined("URL.FY") AND isDefined("URL.agency") AND isDefined("URL.Fund")>

    <cfif URL.agency eq 444>
        <!--- DHS CURRENT FY  & Previous FY, no changed to approprs.--->
        <cfinvoke component="Queries.expenditures" 
            method="MEDICAID_EXP_DHS_CFY_QUERY" 
            returnvariable="Q_MEDICAID_DETAILS">
            <cfinvokeargument  name="fiscal_year"  value="#URL.FY#">
            <cfinvokeargument  name="group_by_object"  value="#URL.Fund#">
        </cfinvoke>
    <cfelseif URL.agency eq 402 >
        <cfinvoke component="Queries.expenditures" 
            method="MEDICAID_EXP_AGING_CFY_QUERY" 
            returnvariable="Q_MEDICAID_DETAILS">
            <cfinvokeargument  name="fiscal_year"  value="#URL.FY#">
            <cfinvokeargument  name="group_by_object"  value="#URL.Fund#">
        </cfinvoke>
    <cfelseif URL.agency eq 478>
        <cfinvoke component="Queries.expenditures" 
            method="MEDICAID_EXP_HFS_CFY_QUERY" 
            returnvariable="Q_MEDICAID_DETAILS">
            <cfinvokeargument  name="fiscal_year"  value="#URL.FY#">
           <cfinvokeargument  name="group_by_object"  value="#URL.Fund#">
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
                    <h4><b>Fund:</b> #EncodeForHTML(URL.Fund)#</h4>
                    <h4><b>Fiscal Year:</b> 20#EncodeForHTML(URL.FY)#</h4>
                    <table class="table table-sorting table-striped table-2018">
                        <tr>
                            <th class="bg-info">Object</th>
                            <th class="bg-info">Description</th>
                            <th class="bg-info text-right">Amount</th>
                        </tr>
                        <cfif Q_MEDICAID_DETAILS.RecordCount>
                            <cfloop query="#Q_MEDICAID_DETAILS#">
                                <tr>	
                                    <td>#EncodeForHTML(Q_MEDICAID_DETAILS.Object)#</td>					
                                    <td>#EncodeForHTML(Q_MEDICAID_DETAILS.Name)#</td>
                                    <td class="text-right">
                                        #EncodeForHTML(DollarFormat(Q_MEDICAID_DETAILS.EXPTOTAL))#
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

<cfoutput>
<a href = "/financial-data/state-expenditures/medicaid-details-by-fund/?agency=#URLEncodedFormat(URL.agency)#&FY=#URLEncodedFormat(URL.FY)#">Back</a>
</cfoutput>