<!--- Pull a index by it's name with the new feedManager.readByName() method. This example is pulling a local index named "Features" from the default site.--->
<cfset feed=application.feedManager.readByName('Features','default')>
<cfset it=feed.getIterator()>
<h2><cfoutput>#feed.getName()#</cfoutput></h2>
<cfif it.recordCount()>
<!--- Iterate throught the child content --->
<cfloop condition="it.hasNext()">
	<cfset subContent=it.next()>
   <cfoutput>
   #it.currentIndex()#: #subContent.getMenutitle()#</br>
   </cfoutput>
</cfloop>
</cfif>