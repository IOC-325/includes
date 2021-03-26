<cfoutput>
 
<!--- <div> --->
  <form action="#$.content('url')#?keywords=#$.event('keywords')#" style="float:right" class="breadcrumb">
<input type="text" name="keywords" value="#HTMLEditFormat($.event('keywords'))#" /><input type="submit" value="Search" />
 
  </form>
<!--- </div> --->
 
<cfscript>
  // DYNAMIC FEED ITERATOR
  // image
  showImage = true;
  imageWidth = 300;
  imageHeight = 150;
  // feed
  dynamicFeed=$.getBean('feed');
  dynamicFeed.setName('temp');
  dynamicFeed.setIsActive(1);
  //dynamicFeed.loadBy(name='Feed Name Goes Here'); // this setting is totally optional, unless you want to load an existing Content Collection/Local Index
  //dynamicFeed.setSortBy('lastupdate'); // lastUpdate, releaseDate, displayStart, menuTitle, rating, comments, created, orderno, random
  //dynamicFeed.setSortDirection('desc'); // asc, desc
  //dynamicFeed.setIsFeaturesOnly(0); // 1, 0
  //dynamicFeed.setShowNavOnly(0); // 1, 0 (Include navigation items only?)
  //dynamicFeed.setShowExcludeSearch(0); // 1, 0 (Include items that have been excluded from site search?)
  dynamicFeed.setMaxItems(0); // 0=unlimited
  dynamicFeed.setNextN(4); // Items Per Page
    //dynamicFeed.setNextN($.content('nextN')); // use the content's own settings
  // allow for categoryid via url
  if ( len($.event('categoryid')) and IsValid('uuid', $.event('categoryid')) ) {
    dynamicFeed.setCategoryID($.event('categoryid'));
  }
  
  // ADVANCED PARAMS
  // relationship: Equals, GT, GTE, LT, LTE, NEQ, Begins, Contains
  // field^dataType: tcontent.lastupdate^date, tcontent.releaseDate^date, tcontent.menuTitle^varchar, tcontent.created^date, tcontent.menuTitle^varchar, tcontent.title^varchar, tcontent.Credits^varchar, tcontent.summary^varchar, tcontent.metaDesc^varchar, tcontent.metaKeywords^varchar, tcontent.type^varchar, tcontent.subType^varchar, tcontenttags.tag^varchar, tcontent.displayStart^timestamp, tcontent.displayStop^timestamp, tcontent.expires^timestamp, tcontent.contentID^varchar, tcontent.parentID^varchar, tcontent.path^varchar, tcontentcategoryassign.categoryID^varchar
  // allow for tag via url
  if ( len($.event('tag')) ) {
    dynamicFeed.addParam(
      relationship='AND'
      ,field='tcontenttags.tag'
      ,dataType='varchar'
      ,criteria=URLDecode($.event('tag'))
      ,condition='CONTAINS'
    );
  }

  // if you want to narrow down to a specific section of the site, e.g., 'about'
  contentBean = $.getBean('content').loadBy(filename='services/comptroller-s-critters');
  if ( !contentBean.getIsNew() ) {
   dynamicFeed.addParam(
     relationship='AND'
     ,field='tcontent.path'
     ,dataType='varchar'
     ,criteria=contentBean.getContentID()
     ,condition='CONTAINS'
   );
  }

  // if you want to filter content of a specific 'sub-type'
  // dynamicFeed.addParam(
  //  relationship='AND'
  //  ,field='tcontent.subType'
  //  ,dataType='varchar'
  //  ,criteria='YourSubtypeHere'
  // );


  // Create a grouping
  if ( len(trim($.event('keywords'))) ) {

    dynamicFeed.addParam(relationship='andOpenGrouping');

      delims = ' ^,'; // loop over words separated by either a space OR a comma
      for ( x=1; x <= ListLen(delims, '^'); x++ ) {
        delim = ListGetAt(delims, x, '^');
        // if you want to include content of an extended attribute
        // let's loop over the keywords...
        for ( i=1; i <= ListLen($.event('keywords'), '#delim#'); i++ ) {

          keyword = ListGetAt($.event('keywords'), i, '#delim#');
          //keyword = replaceNoCase(keyword, '+', ' ', 'ALL');

          dynamicFeed.addParam(
            relationship='OR'
            ,field='tcontent.title'
            ,dataType='varchar'
            ,criteria=trim(keyword)
            ,condition='CONTAINS'
          );

          // could add more fields and/or extended attributes to search on here
          // dynamicFeed.addParam(
          //  relationship='OR'
          //  ,field='someExtendedAttribute'
          //  ,dataType='varchar'
          //  ,criteria=trim(keyword)
          //  ,condition='CONTAINS'
          // );

        };
      };

    dynamicFeed.addParam(relationship='closeGrouping');

  }

  /*
  if ( len(trim($.event('keywords'))) ) {

    rs1 = dynamicFeed.getQuery();

    f2=$.getBean('feed');
    f2.setMaxItems(0);
    f2.setNextN($.content('nextN'));
    if ( len($.event('categoryid')) and IsValid('uuid', $.event('categoryid')) ) {
      f2.setCategoryID($.event('categoryid'));
    }
    if ( len($.event('tag')) ) {
      f2.addParam(
        relationship='AND'
        ,field='tcontenttags.tag'
        ,dataType='varchar'
        ,criteria=URLDecode($.event('tag'))
      );
    }
    f2.addParam(relationship='andOpenGrouping');
    // if you want to include content of an extended attribute
    // let's loop over the keywords...
      for ( i=1; i <= ListLen($.event('keywords'), ' '); i++ ) {
        keyword = ListGetAt($.event('keywords'), i, ' ');
        f2.addParam(
          relationship='OR'
          ,field='otherContent'
          ,dataType='varchar'
          ,criteria=trim(keyword)
        );
        // could add more extended attributes to search on here
      };
    f2.addParam(relationship='closeGrouping');
    rs2 = f2.getQuery();

    // Query of Queries
    qoq = new Query();
      qoq.setDBType('query');
      qoq.setAttributes(rs1=rs1); // needed for QoQ
      qoq.setAttributes(rs2=rs2);
      qoq.setSQL('SELECT * FROM rs1 UNION SELECT * FROM rs2');
      //qoq.setMaxRows(2); // limit max rows, if desired
      rsQoQ = qoq.execute().getResult(); // the recordset
      iterator = $.getBean('contentIterator').setQuery(rsQoQ);
  } else {
    // THE ITERATOR!!
    iterator=dynamicFeed.getIterator();
  }
  */

  iterator=dynamicFeed.getIterator();


  // allow for pagination
  if ( val($.event('pageNo')) < 1 || val($.event('pageNo')) > iterator.pageCount() ) {
    $.event('pageNo',1);
  }
  iterator.setPage($.event('pageNo'));

</cfscript>
 
 
<cfif len(trim($.event('keywords'))) and iterator.hasNext()>
  <div class="feedWrapper">
    <ul class="feed">
      <cfloop condition="iterator.hasNext()">
        <cfset item=iterator.next()>
        <li class="feedItem">
          <h3 class="feedTitle">
            <a href="#item.getURL()#">
              <!--- #iterator.currentRow()# --->
              #iterator.currentIndex()#: #HTMLEditFormat(item.getTitle())#
            </a>
          </h3>
          <div class="lastupdate">#LSDateFormat(item.getLastUpdate())#</div>
          <cfif showImage and $.showImageInList(item.getFileExt())>
            <div class="feedImage">
              <a href="#item.getImageURL()#" title="#HTMLEditFormat(item.getTitle())#">
                <img src="#item.getImageURL(width=imageWidth,height=imageHeight)#" alt="#HTMLEditFormat(item.getTitle())#" border="0" />
              </a>
            </div>
          </cfif>
          <cfif len(item.getSummary())>
            <div class="summary wrapper">
              #item.getSummary()#
            </div>
          </cfif>
          <cfif !ListFindNoCase('File,Link', item.getType())>
            <div class="readmore">
              <a class="more" href="#item.getURL()#">Read More</a>
            </div>
          </cfif>
          <!--- comments --->
          <cfif val(item.getComments()) gt 0>
            <div class="comments">
              <h4><a href="#item.getURL(querystring='##svComments')#">Comments (#item.getComments()#)</a></h4>
            </div>
          </cfif>
          <!--- related content --->
          <cfset iteratorRelated = item.getRelatedContentIterator()>
          <cfif iteratorRelated.hasNext()>
            <div class="wrapper">
              <h4>Related Content</h4>
              <ul class="relatedcontent">
                <cfloop condition="iteratorRelated.hasNext()">
                  <cfset relatedItem = iteratorRelated.next()>
                  <li class="relatedItem">
                    <!---<img src="#relatedItem.getImageURL(width=100,height=50)#" border="0" class="imgRelated" alt="#HTMLEditFormat(relatedItem.getMenuTitle())#" />--->
                    <a href="#relatedItem.getURL()#">
                      #relatedItem.getMenuTitle()#
                    </a>
                  </li>
                </cfloop>
              </ul>
            </div>
          </cfif>
          <!--- categories --->
          <cfset iteratorCategories = item.getCategoriesIterator()>
          <cfif iteratorCategories.hasNext()>
            <div class="categories wrapper">
              <h4>Categories</h4>
              <cfloop condition="iteratorCategories.hasNext()">
                <cfset categoryItem = iteratorCategories.next()>
                <a href="#$.content().getURL(queryString='categoryID=#categoryItem.getCategoryID()#')#"<cfif $.event('categoryID') eq categoryItem.getCategoryID()> class="current"</cfif>>#HTMLEditFormat(categoryItem.getName())#</a><cfif iteratorCategories.hasNext()>, </cfif>
              </cfloop>
            </div>
          </cfif>
          <!--- tags --->
          <cfif len(item.getTags())>
            <div class="tags wrapper">
              <h4>Tags</h4>
              <cfloop from="1" to="#ListLen(item.getTags())#" index="t">
                <a href="#$.content().getURL(queryString='tag=#URLEncodedFormat(trim(ListGetAt(item.getTags(),t)))#')#"<cfif trim($.event('tag')) eq trim(ListGetAt(item.getTags(), t))> class="current"</cfif>>#HTMLEditFormat(trim(ListGetAt(item.getTags(), t)))#</a><cfif t neq ListLen(item.getTags())>, </cfif>
              </cfloop>
            </div>
          </cfif>
        </li>
      </cfloop>
    </ul>
 
 
    <!--- START: pagination --->
    <cfif iterator.pageCount() gt 1>
      <div class="paginationWrapper">
        <ul class="pagination">
          <cfloop from="1" to="#iterator.pageCount()#" index="p">
            <li>
            <a href="#$.content().getURL(queryString='categoryID=#$.event('categoryid')#&tag=#URLEncodedFormat(trim($.event('tag')))#&pageNo=#p#&keywords=#$.event('keywords')#')#"<cfif val($.event('pageNo')) eq p> class="current"</cfif>>#p#</a></li>
        </cfloop>
        </ul>
        <div class="pagecount">#val($.event('pageNo'))# of #iterator.pageCount()# total pages</div>
      </div>
    </cfif>
    <!--- END: pagination --->
 
  </div>
<cfelse>
  <cfif len(trim($.event('keywords')))>
    <div class="notice">Sorry, this feed has no items.</div>
  </cfif>
</cfif>
 
 
 
<!--- =======================================================================
  CSS 
--->
 
 <style type="text/css">
  .feedWrapper {
    font-family:Arial, Helvetica, sans-serif;
    font-size:0.9em;
    padding:1em;
    border:1px solid black;
    background-color:##efefef;
  }
  .feedWrapper a {}
  .feedWrapper a.current {
    color:black;
    text-decoration:none;
  }
  .feedItem {
    clear:both;
    display:block;
    padding:1em 0;
    margin:0;
    border-bottom:1px dashed grey;
  }
  .feed, .pagination, .tags {
    clear:both;
    display:block;
    margin:0;
    padding:0;
    float: none;
  }
  .feedTitle {
    margin:0;
    padding:0;
  }
  .feedTitle a {
    text-decoration:none;
    color:##630;
  }
  
  .paginationWrapper {
    clear:both;
    display:block;
    padding:1em 0;
  }
  .pagination li {
    float:left;
    list-style-type:none;
    padding:0 0.5em 0 0;
    margin:0;
  }
  .pagecount {
    clear:both;
    display:block;
  }
</style>
</cfoutput>