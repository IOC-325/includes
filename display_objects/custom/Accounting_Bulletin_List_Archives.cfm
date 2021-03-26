<cfscript>
myFeed=$.getBean('feed');
myFeed.setMaxItems(0); // 0=unlimited;
myFeed.setNextN(0);
myFeed.addParam(
    field='parentId'
    ,   relationship='AND'
    ,   condition='eq'
    ,   criteria='B563D988-DCB8-4DC0-C7FD25D4C95C68BC'
    ,   dataType='varchar'
    );

// sort by functions
myFeed.setSortBy('date');
myFeed.setSortDirection('asc');
myIterator = myFeed.getIterator();
</cfscript>

<cfif myIterator.hasNext()>
    <div class="table-responsive">
        <table id="example" class="table table-bordered table-hover table-2018">
            <thead>
                <tr style="background-color: rgba(88,88,91,1); color: white;">
                    <th>Date</th>
                    <th>#</th>
                    <th>Title</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput>
                    <cfloop condition="myIterator.hasNext()">
                        <cfset item=myIterator.next()>
                        <tr>
                            <td>
                                <cfset itemkidsIt = item.getKidsIterator()>
                                <cfloop condition="#itemKidsIt.hasNext()#">
                                    <cfset kidFile = itemKidsIt.next() />
                                    <cfif kidFile.getContentSubType() eq 'pdf'>
                                        <a href="#kidFile.getURL()#">
                                           <!---  #item.getMenuTitle()# --->
                                           #dateFormat(item.getAccountingBulletinDate(),'m/d/yyyy')#
                                        </a>
                                    </cfif>
                                </cfloop>
                            </td>
                            <td><a href="#kidFile.getURL()#">#item.getAccountingBulletinNumber()#</a></td>
                            <td><a href="#kidFile.getURL()#">#item.getTitle()#</a></td>
                        </tr>
                    </cfloop>
                </cfoutput>
            </tbody>
        </table>
    </div>
    <cfelse>
    <p>No payroll Bulletins exist. Archives below.</p>
</cfif>
<script>
    $('#example').dataTable( {
        bFilter: false,
        bInfo: false,
        "bLengthChange": false,
        "pageLength": 15,
        "ordering": false,
        "searching": true
    });
</script>