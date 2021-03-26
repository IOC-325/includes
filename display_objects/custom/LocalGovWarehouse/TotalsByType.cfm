<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css" />


<cfquery datasource="AFRSQLPROD" name="getTotalCount">
	select Description
	, count(description) as totcount
	from UnitData
    where Dissolved = 'N'
    and DissolvedAdmin = 'N'
	group by Description
	order by totcount desc
</cfquery>

<!--- <cfdump var="#getTotalCount#"> --->

<table class="table table-striped locgovDataTable">
<thead>
    <tr>
        <th class="bg-info">Description</th>
        <th class="bg-info">Total Count</th>
    </tr>
</thead>
    <tbody>
    <cfoutput query="getTotalCount">
    <tr>
        <td>#Description#<cfif description eq "Community College"
                or description eq "Drainage District"
                or description eq "Housing Authority"
                or description eq "School District"
            >*
            <cfelseif description eq "Road & Bridge District">
            **</cfif>
        </td>
        <td>#totcount#</td>
    </tr>
    </cfoutput>
</tbody>
</table>


<p class="margintop"><strong>*Not required to file annual financial data with the Illinois Office of the Comptroller<br />
**Financial data included in the Annual Financial Report of township</strong></p>

<script>
    $(document).ready(function(){
        $('.locgovDataTable').DataTable({
            "searching": false,
            "lengthChange": false,
            "scrollX": true,
            "scrollY": "400px",
            "scrollCollapse": true,
            "paging": false
        });
    });
</script>






