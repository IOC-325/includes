 <cfquery name="AgencyList" datasource="#application.agencyContactInfo#">
     SELECT
       ACI.[AGENCY]
       ,ACI.[NAME]
       ,IsNull(ACI.[CONTACT_INFO],'') AS CONTACT_INFO
       ,[WebsiteAddress]
       ,[IsActive]
     FROM
       [dbo].[Agency_Contact_Info] ACI LEFT JOIN [dbo].[Agency_Contact_Info_Editable] ACIE
     ON ACI.AGENCY = ACIE.AGENCY
     WHERE
       FISCAL_YEAR = (Select MAX(FISCAL_YEAR) FROM dbo.Agency)
       AND IsNull([IsActive],1) = 1
     ORDER BY ACI.[AGENCY]
 </cfquery>


<table class="table table-striped AgencyInfo" width="100%">
 <thead>
  <tr>
   <th class="bg-info">Agency Number</th>
   <th class="bg-info text-center">Agency Name</th>
   <th class="sum bg-info text-center">Contact Info</th>
   <th class="sum bg-info text-center">Website</th>
  </tr>
 </thead>
 <tbody>
  <cfoutput>
   <cfloop query = "AgencyList">
    <tr>
      <td>#AgencyList.AGENCY#</td>
      <td>#AgencyList.NAME#</td>
      <td>#AgencyList.CONTACT_INFO#</td>
      <td><a href="#AgencyList.WebsiteAddress#" target="_blank">#AgencyList.WebsiteAddress#</a></td>
     </tr>
   </cfloop>
  </cfoutput>
 </tbody>
</table>


<script>
$( window ).on("load", function() {
    if($(".AgencyInfo").length){
        $('.AgencyInfo').DataTable({
            columnDefs: [
                { type: 'currency', targets: "sum" }
            ],
            "initComplete": function(settings, json) {
                // this fixes the fixed first column width issue as well as the alignment issues
                $(window).trigger('resize');
            },
            "ordering": true,
            "info":     false,
            "searching": false,
            "lengthChange": false,
            "scrollX": true,
            "scrollY": "50vh",
            "scrollCollapse": false,
            "pageLength": 100,
            "paging": false,
            "iDisplayLength": 50,
            "order": [],
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'csv',
                    text: 'CSV',
                    extension: '.csv',
                    exportOptions: {
                      },
                    title: 'table'
                }
            ]
        });
    }
});

 function DollarFormat(num) {
  if(num !== undefined){
   num = num.toString().replace(/\$|\,|\(|\)/g,'');
   //console.log(num);
   if(isNaN(num))
   num = "0";
   sign = (num == (num = Math.abs(num)));
   num = Math.floor(num*100+0.50000000001);
   cents = num%100;
   num = Math.floor(num/100).toString();

   if(cents<10)
   cents = "0" + cents;
   for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
   num = num.substring(0,num.length-(4*i+3))+','+
   num.substring(num.length-(4*i+3));
   //return (((sign)?'':'-') + num + '.' + cents);
   return (((sign) ? '' : '(') + '$' + num + '.' + cents + ((sign) ? '' : ')'));
  }
 }
</script>