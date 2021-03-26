<cf_CacheOMatic
    key="payrollbulletin-custom"
    nocache="#$.event('nocache')#"
    timespan="#CreateTimeSpan(0,7,0,0)#">

<cfscript>
myFeed=$.getBean('feed');
myFeed.setMaxItems(0); // 0=unlimited;
myFeed.setNextN(0);
myFeed.addParam( 
    field='path'
    ,   relationship='AND'
    ,   condition='contains'
    ,   criteria='5483E447-2A13-4616-ABE77FC2EB1C9BE4'
    ,   dataType='varchar'
    );
myFeed.addParam( 
    field='parentId'
    ,   relationship='AND'
    ,   condition='eq'
    ,   criteria='5483E447-2A13-4616-ABE77FC2EB1C9BE4'
    ,   dataType='varchar'
    );

// sort by functions
myFeed.setSortBy('orderno');
myFeed.setSortDirection('asc');
myIterator = myFeed.getIterator();
</cfscript>

<!--- <cfoutput>
<cfloop condition="myIterator.hasNext()">
    <cfset item=myIterator.next()>
    #item.getTitle()#<br>
</cfloop>
</cfoutput> --->

<cfif myIterator.hasNext()>
    <div class="table-responsive-new">
    <table id="example" class="table table-bordered table-hover">
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
            <cfset VarItemURL = "">
            <cfset VarItemTitle = "">
            <cfset item=myIterator.next()>
            <cfif item.getTitle() neq 'Archived Payroll Bulletins'>
                <tr>
                    <td>
                        <cfif len( item.getPayrollBulletinPDF() )> 
                            <a href="/comptroller/cache/file/#item.getPayrollBulletinPDF()#.pdf">
                                #dateformat(item.getPayrollBulletinDate(),'mm/dd/yyyy')#
                            </a>
                        <!--- <cfelse>
                           <cfset itemkidsIt = item.getKidsIterator()>
                            <cfloop condition="#itemKidsIt.hasNext()#">
                                <cfset kidFile = itemKidsIt.next() />
                                <cfif kidFile.getContentSubType() eq 'pdf'>
                                    <a href="#kidFile.getURL()#">
                                        #dateformat(item.getPayrollBulletinDate(),'mm/dd/yyyy')#
                                    </a>
                                </cfif>
                            </cfloop> --->
                        </cfif>
                    </td>
                    <td nowrap>
                        <cfif len( item.getPayrollBulletinPDF() )>
                        <a href="/comptroller/cache/file/#item.getPayrollBulletinPDF()#.pdf">
                            #item.getPayrollBulletinNumber()#
                        </a>
                        <!--- <cfelse>
                            <cfset itemkidsIt = item.getKidsIterator()>
                        <cfloop condition="#itemKidsIt.hasNext()#">
                            <cfset kidFile = itemKidsIt.next() />
                            <cfif kidFile.getContentSubType() eq 'pdf'>
                                <a href="#kidFile.getURL()#">
                                    #item.getPayrollBulletinNumber()#
                                </a>
                            </cfif>
                        </cfloop> --->
                        </cfif>
                    </td>
                    <td>
                        <cfif len( item.getPayrollBulletinPDF() )>
                            <a href="/comptroller/cache/file/#item.getPayrollBulletinPDF()#.pdf">#item.getMenuTitle()#</a>
                        <cfelseif item.getTitle() eq 'Archived Payroll Bulletins'>
                            <cfset VarItemURL = item.getURL()>
                            <cfset VarItemTitle = item.getTitle()>  &nbsp;                      
                        <cfelse>
                            <cfset itemkidsIt = item.getKidsIterator()>
                            <cfloop condition="#itemKidsIt.hasNext()#">
                                <cfset kidFile = itemKidsIt.next() />
                                <cfif kidFile.getContentSubType() eq 'pdf'>
                                    <a href="#kidFile.getURL()#">
                                        #item.getMenuTitle()#
                                    </a>
                                </cfif>
                            </cfloop>
                        </cfif>
                    </td>
                </tr>
            <cfelse>
                <cfset VarItemURL = item.getURL()>
                <cfset VarItemTitle = item.getTitle()>
            </cfif>
        </cfloop>
    </cfoutput>
	</tbody>
    </table>
    </div>
    <p class="text-center">                        
        <cfoutput><a href="#VarItemURL#"> <strong>#VarItemTitle#</strong></a></cfoutput>
    </p>
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
    });    
</script>   
