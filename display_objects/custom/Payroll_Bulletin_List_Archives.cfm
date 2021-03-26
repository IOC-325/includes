<cf_CacheOMatic 
    key="payroll-bulletin-archive-list" 
    nocache="#$.event('nocache')#"
    timespan="#CreateTimeSpan(0,7,0,0)#"> 
<cfscript>
myFeed=$.getBean('feed');
myFeed.setMaxItems(0); // 0=unlimited;
myFeed.setNextN(0);
myFeed.addParam(
    field='parentId'
    ,   relationship='AND'
    ,   condition='eq'
    ,   criteria='E92146FC-9161-DF3C-156C233E5ABE383A'
    ,   dataType='varchar'
    );

// sort by functions
myFeed.setSortBy('PayrollBulletinDate');
//myFeed.setSortBy('orderno');
myFeed.setSortDirection('desc');
myIterator = myFeed.getIterator();
</cfscript>
<cfif myIterator.hasNext()>
    <div class="table-responsive">
    <table id="example" class="table table-bordered table-hover">
    <thead>
        <tr style="background-color: rgba(88,88,91,1); color: white;">
            <th><strong>Date</strong></th>
            <th><strong>#</strong></th>
            <th><strong>Title</strong></th>
        </tr>
    </thead>
    <tbody>    
    <cfoutput>
        <cfloop condition="myIterator.hasNext()">
            <cfset item=myIterator.next()>
            <cfif len(item.getPayrollBulletinPDF())>
            <tr>
                <td>
                    <a href="/comptroller/cache/file/#item.getPayrollBulletinPDF()#.pdf">
                       #dateformat(item.getPayrollBulletinDate(),'mm/dd/yyyy')#
                    </a>
                </td>
                <td nowrap>
                    <a href="/comptroller/cache/file/#item.getPayrollBulletinPDF()#.pdf">
                        #item.getPayrollBulletinNumber()#
                    </a>
                </td>
                <td>
                    <a href="/comptroller/cache/file/#item.getPayrollBulletinPDF()#.pdf">#item.getMenuTitle()#</a>
                </td>
            </tr>
            </cfif>
        </cfloop>
    </cfoutput>
    </table>
    </div>
 <cfelse>
 <p>No payroll Bulletins exist. Archives below.</p>
 </cfif>
 </cf_CacheOMatic> 
   <script>
    $('#example').dataTable( {
        bFilter: false,
        bInfo: false,
        "bLengthChange": false,
        "pageLength": 15,
        "ordering": false,
        "searching": true
    } );    
</script>  