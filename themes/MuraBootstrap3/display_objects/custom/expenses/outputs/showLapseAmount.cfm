
<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css" />
<link href="/comptroller/includes/themes/MuraBootstrap3/assets/datatable/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">

<cfoutput>
<cfset variables.GroupBy = "#URL.GroupBy#">
<cfset variables.FY = "#URL.FY#">
<cfset variables.FundSel = "#URL.FundSel#">
<cfset variables.FundGrpSel = "#URL.FundGrpSel#">
<cfset variables.FundTypeSel = "#URL.FundTypeSel#">
<cfset variables.FundCatSel = "#URL.FundCatSel#">

<cfset variables.AgcySel = "#URL.AgcySel#">
<cfset variables.AgcyGrpSel = "#URL.AgcyGrpSel#">
<cfset variables.AgcyTypeSel = "#URL.AgcyTypeSel#">
<cfset variables.AgcyCatSel = "#URL.AgcyCatSel#">

<cfset variables.ObjeSel = "#URL.ObjeSel#">
<cfset variables.ObjeGrpSel = "#URL.ObjeGrpSel#">
<cfset variables.ObjeCatSel = "#URL.ObjeCatSel#">
<cfset variables.ObjeTypeSel = "#URL.ObjeTypeSel#">

<cfset variables.ApprSel = "#URL.ApprSel#">
<cfset variables.ApprGrpSel = "#URL.ApprGrpSel#">
<cfset variables.ApprTypeSel = "#URL.ApprTypeSel#">
<cfset variables.ApprCatSel = "#URL.ApprCatSel#">
<cfset variables.ApprClsSel = "#URL.ApprClsSel#">

<cfset variables.Type = "#URL.Type#">

<!--- Get result column and column name --->
<CFIF GroupBy is "Fund">
	<CFSET Column = "Fund">
	<CFSET ColName = "Fund">
	<CFSET DescTable = "WH.FUND_#FY#">
<CFELSEIF GroupBy is "FundCls">
	<CFSET Column = "Class">
	<CFSET ColName = "Fund Class">
	<CFSET DescTable = "WH.FUND_#FY#">
<CFELSEIF GroupBy is "FundGrp">
	<CFSET Column = "Group">
	<CFSET ColName = "Fund Group">
	<CFSET DescTable = "WH.FUND_#FY#">
<CFELSEIF GroupBy is "FundCat">
	<CFSET Column = "Category">
	<CFSET ColName = "Fund Category">
	<CFSET DescTable = "WH.FUND_#FY#">
<CFELSEIF GroupBy is "FundType">
	<CFSET Column = "Type">
	<CFSET ColName = "Fund Type">
	<CFSET DescTable = "WH.FUND_#FY#">
<CFELSEIF GroupBy is "Agcy">
	<CFSET Column = "Agency">
	<CFSET ColName = "Agency">
	<CFSET DescTable = "wh.AGENCY_#FY#">
<CFELSEIF GroupBy is "AgcyCls">
	<CFSET Column = "Class">
	<CFSET ColName = "Agency Class">
	<CFSET DescTable = "wh.AGENCY_#FY#">
<CFELSEIF GroupBy is "AgcyGrp">
	<CFSET Column = "Group">
	<CFSET ColName = "Agency Group">
	<CFSET DescTable = "wh.AGENCY_#FY#">
<CFELSEIF GroupBy is "AgcyCat">
	<CFSET Column = "Category">
	<CFSET ColName = "Agency Category">
	<CFSET DescTable = "WH.AGENCY_#FY#">
<CFELSEIF GroupBy is "AgcyType">
	<CFSET Column = "Type">
	<CFSET ColName = "Agency Type">
	<CFSET DescTable = "wh.AGENCY_#FY#">
<CFELSEIF GroupBy is "Appr">
	<CFSET Column = "Appropriation">
	<CFSET ColName = "Appropriation">
	<CFSET DescTable = "wh.APPROP_#FY#">
<CFELSEIF GroupBy is "ApprCls">
	<CFSET Column = "Class">
	<CFSET ColName = "Appropriation Class">
	<CFSET DescTable = "wh.APPROP_#FY#">
<CFELSEIF GroupBy is "ApprGrp">
	<CFSET Column = "Group">
	<CFSET ColName = "Appropriation Group">
	<CFSET DescTable = "wh.APPROP_#FY#">
<CFELSEIF GroupBy is "ApprCat">
	<CFSET Column = "Category">
	<CFSET ColName = "Appropriation Category">
	<CFSET DescTable = "wh.APPROP_#FY#">
<CFELSEIF GroupBy is "ApprType">
	<CFSET Column = "Type">
	<CFSET ColName = "Appropriation Type">
	<CFSET DescTable = "wh.APPROP_#FY#">
<CFELSEIF GroupBy is "Obje">
	<CFSET Column = "Obj_Exp">
	<CFSET ColName = "Object of Expenditure">
	<CFSET DescTable = "wh.OBJ_EXP_#FY#">
<CFELSEIF GroupBy is "Objt">
	<CFSET Column = "Object">
	<CFSET ColName = "Object">
	<CFSET DescTable = "wh.OBJECT_#FY#">
<CFELSEIF GroupBy is "ObjtCls">
	<CFSET Column = "Class">
	<CFSET ColName = "Object Class">
	<CFSET DescTable = "wh.OBJECT_#FY#">
<CFELSEIF GroupBy is "ObjtGrp">
	<CFSET Column = "Group">
	<CFSET ColName = "Object Group">
	<CFSET DescTable = "wh.OBJECT_#FY#">
<CFELSEIF GroupBy is "ObjtCat">
	<CFSET Column = "Category">
	<CFSET ColName = "Object Category">
	<CFSET DescTable = "wh.OBJECT_#FY#">
<CFELSEIF GroupBy is "ObjtType">
	<CFSET Column = "Type">
	<CFSET ColName = "Object Type">
	<CFSET DescTable = "wh.OBJECT_#FY#">
<cfelse>
	<CFSET Column = "Fund">
	<CFSET ColName = "Fund">
	<CFSET DescTable = "wh.FUND_#DateFormat(NOW(), 'yy')#">
</CFIF>

<!--- SQL Query --->

<CFQUERY NAME="Result" DATASOURCE="#application.whDSN#">        
         SELECT    SUM(CASE WHEN ACCEPTANCE_DATE BETWEEN '20#FY#-12-01' AND '20#FY#-12-31' THEN EXPENDED_AMT ELSE NULL END) AS DEC_LAPSE,
                   SUM(CASE WHEN ACCEPTANCE_DATE BETWEEN '20#FY#-11-01' AND '20#FY#-11-30' THEN EXPENDED_AMT ELSE NULL END) AS NOV_LAPSE,
                   SUM(CASE WHEN ACCEPTANCE_DATE BETWEEN '20#FY#-10-01' AND '20#FY#-10-31' THEN EXPENDED_AMT ELSE NULL END) AS OCT_LAPSE,
                   SUM(CASE WHEN ACCEPTANCE_DATE BETWEEN '20#FY#-09-01' AND '20#FY#-09-30' THEN EXPENDED_AMT ELSE NULL END) AS SEP_LAPSE,
                   #DescTable#.#Column# AS Code
         FROM      WH.TRANS_EXP_#FY#
				    <CFIF TRIM(FundSel) is not "" OR TRIM(FundTypeSel) is not "" OR TRIM(FundGrpSel) is not "" OR TRIM(FundCatSel) is not "">
						INNER JOIN WH.FUND_#FY#    ON WH.TRANS_EXP_#FY#.FUND = WH.FUND_#FY#.FUND AND WH.TRANS_EXP_#FY#.FISCAL_YEAR = WH.FUND_#FY#.FISCAL_YEAR
					</CFIF>
					<CFIF TRIM(AgcySel) is not "" OR TRIM(AgcyCatSel) is not "" OR TRIM(AgcyTypeSel) is not "" OR TRIM(AgcyGrpSel) is not "">
						INNER JOIN WH.AGENCY_#FY#  ON WH.TRANS_EXP_#FY#.Agency = WH.AGENCY_#FY#.Agency AND WH.TRANS_EXP_#FY#.FISCAL_YEAR = WH.AGENCY_#FY#.FISCAL_YEAR
					</CFIF>
					<CFIF TRIM(ObjeSel) is not "" OR TRIM(ObjeGrpSel) is not "" OR TRIM(ObjeCatSel) is not "" OR TRIM(ObjeTypeSel) is not "">
						INNER JOIN WH.OBJECT_#FY#  ON WH.TRANS_EXP_#FY#.OBJECT = WH.OBJECT_#FY#.OBJECT AND WH.TRANS_EXP_#FY#.FISCAL_YEAR = WH.OBJECT_#FY#.FISCAL_YEAR
					</CFIF>
					<CFIF TRIM(ApprSel) is not "" OR TRIM(ApprGrpSel) is not "" OR TRIM(ApprTypeSel) is not "" OR TRIM(ApprCatSel) is not "" OR TRIM(ApprClsSel) is not "">
						INNER JOIN WH.APPROP_#FY#  ON WH.TRANS_EXP_#FY#.Appropriation = WH.APPROP_#FY#.Appropriation AND WH.TRANS_EXP_#FY#.FISCAL_YEAR = WH.APPROP_#FY#.FISCAL_YEAR
					</CFIF>    
         WHERE  1 = 1
		 AND WH.TRANS_EXP_#FY#.FISCAL_YEAR = '20#FY#'
         <!--- Fund--->
         <CFIF TRIM(FundSel) is not "">
        	AND WH.FUND_#FY#.Fund = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FundSel#" />
            </CFIF>
		<CFIF TRIM(FundGrpSel) is not "">
        	AND WH.FUND_#FY#.Group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FundGrpSel#" />
            </CFIF>
        <CFIF TRIM(FundTypeSel) is not "">
        	AND WH.FUND_#FY#.Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FundTypeSel#" />
            </CFIF>    
		<CFIF TRIM(FundCatSel) is not "">
        	AND WH.FUND_#FY#.Category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FundCatSel#" />
            </CFIF> 
        <!--- Agency--->     
         <CFIF TRIM(AgcySel) is not "">
            AND WH.AGENCY_#FY#.Agency = <cfqueryparam cfsqltype="cf_sql_varchar" value="#AgcySel#" />
            </CFIF>
        <CFIF TRIM(AgcyGrpSel) is not "">
        	AND WH.AGENCY_#FY#.Group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#AgcyGrpSel#" />
            </CFIF>
		<CFIF TRIM(AgcyTypeSel) is not "">
        	AND WH.AGENCY_#FY#.Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#AgcyTypeSel#" />
            </CFIF>  
        <CFIF TRIM(AgcyCatSel) is not "">
        	AND WH.AGENCY_#FY#.Category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#AgcyCatSel#" />
            </CFIF>
		<!--- Object---> 	
		<CFIF TRIM(ObjeSel) is not "">
        	AND WH.OBJECT_#FY#.Object = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ObjeSel#" />
            </CFIF>
	    <CFIF TRIM(ObjeGrpSel) is not "">
	      	AND WH.OBJECT_#FY#.Group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ObjeGrpSel#" />
	        </CFIF>
	    <CFIF TRIM(ObjeCatSel) is not "">
	      	AND WH.OBJECT_#FY#.Category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ObjeCatSel#" />
	        </CFIF>
	    <CFIF TRIM(ObjeTypeSel) is not "">
	      	AND WH.OBJECT_#FY#.Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ObjeTypeSel#" />
	        </CFIF> 
		<!--- Appropriation--->  
        <CFIF TRIM(ApprSel) is not "">
        	AND WH.APPROP_#FY#.Appropriation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ApprSel#" />
            </CFIF>
		<CFIF TRIM(ApprClsSel) is not "">
        	AND WH.APPROP_#FY#.Class = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ApprClsSel#" />
            </CFIF>
		<CFIF TRIM(ApprGrpSel) is not "">
        	AND WH.APPROP_#FY#.Group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ApprGrpSel#" />
            </CFIF>
		<CFIF TRIM(ApprCatSel) is not "">
        	AND WH.APPROP_#FY#.Category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ApprCatSel#" />
            </CFIF>
            AND (ACCEPTANCE_DATE between '20#FY#-09-01' AND '20#FY#-12-31')
            GROUP BY #DescTable#.#Column#
</CFQUERY>

<cfdump var="#Result#"><cfabort>
	<div id="lapseamount" align="center">
	<!---<p>Expenditures by: #ColName#</p>
	<p>Appropriated Spending for Fiscal Year: 20#FY#</p>
	<p>Type: Both</p>--->
			<table id="lapseTable" class="table-striped datatable-primary" style="font-size:18px;width:60%;">
				<thead>
					<tr>
					    <th class="sum header-center">Code</th>
						<th class="sum header-center">Month</th>
                        <th class="sum header-center">Lapse Amount</th>
					</tr>
				</thead>

				<tbody>
					<tr>
						<td align="center">#Result.Code#</td>
						<td align="center">SEPTEMBER</td>
                        <td align="center">#DollarFormat(Result.SEP_LAPSE)#</td>
					</tr>
                    <tr>
						<td align="center">#Result.Code#</td>
						<td align="center">OCTOBER</td>
                        <td align="center">#DollarFormat(Result.OCT_LAPSE)#</td>
					</tr>
                    <tr>
						<td align="center">#Result.Code#</td>
						<td align="center">NOVEMBER</td>
                        <td align="center">#DollarFormat(Result.NOV_LAPSE)#</td>
					</tr>
                    <tr>
						<td align="center">#Result.Code#</td>
						<td align="center">DECEMBER</td>
                        <td align="center">#DollarFormat(Result.DEC_LAPSE)#</td>
					</tr>
				</tbody>
			</table>
	</div>
    </cfoutput>


