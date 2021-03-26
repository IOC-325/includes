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
myFeed.setSortBy('accountingBulletinNumber');
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

myIterator = myFeed.getIterator();
</cfscript>

<!--- <cfdump var="#myFeed.getQuery()#">
<cfabort> --->
<!--- <h4>The Accounting Bulletins are available in PDF format below.</h4> --->

<cfif myIterator.hasNext()>
	<table width="100%" class="table table-striped">
    <tr align="center">
        <td colspan="2">
            <strong>Number and Title</strong>
        </td>
	</tr>
    <cfoutput>
        <cfloop condition="myIterator.hasNext()">
        	<cfset item=myIterator.next()>
            <cfset itemkidsIt = item.getKidsIterator()>
                <tr>
                    <td width="15%">
                      <cfloop condition="itemKidsIt.hasNext()">
                        <cfset kidFile = itemKidsIt.next()>
                        <cfif kidFile.getContentSubType() eq 'pdf'>
                            <a href="#kidFile.getURL()#">
                                <cfset dashloc = find('-', kidfile.getTitle())-2 />
                                <cfif dashloc gt 0>
                                    #left( kidfile.getTitle(), dashloc )#
                                <cfelse>
                                    #kidFile.getTitle()#
                                </cfif>
                            </a>
                        
                        </cfif>

                      </cfloop>
                    </td>
                    <td width="85%">

                        <cfset titledashloc = find( '-', item.getTitle() ) + 1>
                        <cfif titledashloc gt 2><!--- #item.getTitle()# --->
                            <!--- <cfloop condition="itemKidsIt.hasNext()"><cfset kidFile = itemKidsIt.next()>---><cfif kidFile.getContentSubType() eq 'pdf'><a href="#kidFile.getURL()#"> 
                            #right( item.getTitle(), len( item.getTitle() ) - titledashloc )# 
                         </a></cfif><!---</cfloop> --->
                        <cfelseif item.getTitle() eq 'Archived Accounting Bulletins'>
                            <cfsavecontent variable="strAB">
                                <b><a href="#item.getURL()#">Archived Accounting Bulletins</a></b>
                            </cfsavecontent>
                        <!--- <a href="#item.getURL()#">
                            <strong>#item.getTitle()#</strong>
                        </a>
                        <cfelse>
                            #item.getTitle()#
                        </cfif> --->
                         <cfelse>
                            <cfif kidFile.getContentSubType() eq 'pdf'><a href="#kidFile.getURL()#"> #item.getTitle()#</a></cfif>
                        </cfif>
                            
                        
                    </td>
                     
                </tr>
        </cfloop>
    
    <tr><td colspan="2">#strAB#</td></tr>
    </cfoutput></table>
 <cfelse>
 <p>No Accounting Bulletins exist. Archives below.</p>
 </cfif>

 </cf_CacheOMatic>