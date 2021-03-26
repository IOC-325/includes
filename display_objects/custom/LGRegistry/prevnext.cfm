<!--- prevnext.cfm --->
<cfparam NAME="max" DEFAULT="3">

<cfif not isDefined("StartRow")>
	<cfset startrow=1>
</cfif>

<TABLE>
<TR>
<CFOUTPUT>

	<CFIF StartRow IS NOT 1>
		<TD>
			<A HREF="doDrillDown.cfm?StartRow=1"><IMG SRC="/iwgraph/BtnTop.gif" BORDER=0 ALT="Go to Beginning of Query Results"></A>		
		</TD>

		<TD>
			<CFSET NewRow = Max(StartRow - Max, 1)>
			<A HREF="doDrillDown.cfm?StartRow=#NewRow#"><IMG SRC="/iwgraph/BtnPrev.gif" BORDER=0 ALT="Show Previous #Max# Records"></A>		
		</TD>
	<CFELSE>
		<TD>
			<IMG SRC="/iwgraph/BtnTopDisabled.gif" BORDER=0 ALT="No Previous Records">
		</TD>

		<TD>
			<IMG SRC="/iwgraph/BtnPrevDisabled.gif" BORDER=0 ALT="No Previous Records">
		</TD>
	</CFIF>

	<TD VALIGN=CENTER NOWRAP>
		<CFSET NewRow = Min(StartRow + Max - 1, select.recordcount)>
		#StartRow# - #NewRow# of #select.recordcount#
	</TD>

	<CFIF StartRow + (Max-1) LT select.recordcount>
	
		<TD>
			<CFSET NewRow = StartRow + Max>
			<A HREF="doDrillDown.cfm?StartRow=#NewRow#&Max=#Max#"><IMG SRC="/iwgraph/BtnNext.gif" BORDER=0 ALT="Next #Max# Records"></A>
		<!--- <A HREF="/iwcommon/RunQuery.cfm?Query=#Query#&StartRow=#NewRow#&Params=None"><IMG SRC="/iwgraph/BtnNext.gif" BORDER=0 ALT="Next #Max# Records"></A> ---></TD>
	
		<TD>
			<CFSET NewRow = select.recordcount - Max + 1>
			<A HREF="doDrillDown.cfm?StartRow=#NewRow#"><IMG SRC="/iwgraph/BtnBottom.gif" BORDER=0 ALT="Go to End of Query Results"></A>		
		</TD>
			
	<CFELSE>
		<TD>
			<IMG SRC="/iwgraph/BtnNextDisabled.gif" BORDER=0 ALT="No More Records"></A>
		</TD>
		<TD>
			<IMG SRC="/iwgraph/BtnBottomDisabled.gif" BORDER=0 ALT="No More Records"></A>
		</TD>
	</CFIF>

</CFOUTPUT>
</TABLE>
<!-- End of Prev/Next -->
