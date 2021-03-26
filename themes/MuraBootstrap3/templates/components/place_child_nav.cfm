<cfoutput>

<cfset bean=$.getBean('content').loadBy(contentID="B0C87F2D-1CC1-DE6E-2F2683C0D2FEBBCD")>
<cfset subNav=bean.getKidsIterator()>
<cfif subNav.hasNext()>
<nav class="mura-nav-sub well" id="navSub">
<ul class="nav nav-list">
<cfloop condition="subNav.hasNext()">
<cfset item=subNav.next()>
<li><a href="#item.getURL()#">#item.getMenuTitle()#</a></li>
</cfloop>
</ul>
</nav>
</cfif> 

</cfoutput>