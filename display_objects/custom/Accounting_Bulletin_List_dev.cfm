<cf_CacheOMatic
    key="accountingbulletin-custom"
    nocache="#$.event('nocache')#"
    timespan="#CreateTimeSpan(0,7,0,0)#">

<cfscript>
myFeed=$.getBean('feed');
myFeed.setMaxItems(0); // 0=unlimited;
myFeed.setNextN(0);
// sort by functions
//myFeed.setSortBy('orderNo');
// myFeed.setSortBy('accountingBulletinDate');
myFeed.setSortBy('AccountingBulletinNumber');
myFeed.setSortDirection('desc');

myFeed.addParam(
    field='path'
    ,   relationship='AND'
    ,   condition='contains'
    ,   criteria='463D2898-4C62-4EF0-99BEEAA6AFEC62E4'
    ,   dataType='varchar'
    );
myFeed.addParam(
    field='parentId'
    ,   relationship='AND'
    ,   condition='EQ'
    ,   criteria='463D2898-4C62-4EF0-99BEEAA6AFEC62E4'
    ,   dataType='varchar'
    );
myFeed.addParam(
    field='type'
    ,   relationship='AND'
    ,   condition='equals'
    ,   criteria='page'
    ,   dataType='varchar'
    );


myIterator = myFeed.getIterator();
</cfscript>

<!--- <cfdump var="#myFeed.getQuery()#">
<cfabort> --->
<!--- <h4>The Accounting Bulletins are available in PDF format below.</h4> --->

<cfif myIterator.hasNext()>
    <div class="table-responsive-new">
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
                        <cfif item.getTitle() neq "Archived Accounting Bulletins">
                        <tr>
                            <td>
                            <cfset itemkidsIt = item.getKidsIterator()>
                            <!--- <cfloop condition="itemKidsIt.hasNext()"> --->
                            <!--- KidFile is looping through the children of this node and pulling up our file for us --->
                            <cfset kidFile = itemKidsIt.next()>
                                <!--- <cfif kidFile.getContentSubType() eq 'pdf'> --->
                                    <a href="#kidFile.getURL()#">
                                      #dateformat(item.getAccountingBulletinDate(),'m/d/yyyy')#
                                    </a>
                                <!--- </cfif> --->
                              <!--- </cfloop> --->
                            </td>
                            <td><a href="#kidFile.getURL()#">#item.getAccountingBulletinNumber()#</a></td>
                            <td><a href="#kidFile.getURL()#">#item.getTitle()#</a></td>
                        </tr>
                        </cfif>
                    </cfloop>
                </cfoutput>
            </tbody>
        </table>
    </div>
    <p class="text-center">
        <a href="/agencies/accounting-bulletins/archived-accounting-bulletins/"><strong>Archived Accounting Bulletins</strong></a>
    </p>
 <cfelse>
 <p>No Accounting Bulletins exist. Archives below.</p>
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
