<p>Looping through Kids of "contact" file name.</p>
<!--- Read out an existing node from the default site.---> 
<cfset content=application.contentManager.getActiveContentByFilename('contact','default')>

<!--- Pull out a content iterator of the nodes child content.---> 
<cfset it=content.getKidsIterator()>

<!--- The number of Items to be listed is determined by the content.getNextN() value. It's default is 10. --->
<cfset it.setPage(1)>

<!--- You can also set the start row instead of setting a page number. --->
<cfset it.setStartRow(1)>

<cfloop from="1" to="#it.pageCount()#" index="p">
	<cfset it.setPage(p)>
   <cfoutput><h2>Page #p#</h2></cfoutput>
   <!--- Iterate throught the child content. 
   The it.hasNext() will return true until the page length 
   as determined by the content.getNextN() has been reached --->
   <cfloop condition="it.hasNext()"> <!--- The it.next() method returns a new contentNavBean. It acts as a facade to data into the wrapped query while digging into the full bean when needed. ---> 
		<cfset sub1=it.next()>
      <cfoutput>
      #it.currentIndex()#:#sub1.getMenuTitle()#</br>
      </cfoutput>
   </cfloop> 
</cfloop> 