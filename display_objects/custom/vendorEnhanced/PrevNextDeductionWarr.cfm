<!-- Show Previous and Next commands if necessary  -->
<CFIF #ParameterExists(StartRow)# IS "No">
	<CFSET StartRow = 1>
</CFIF>

<TABLE>
<TR>
<CFOUTPUT>

	<CFIF StartRow IS NOT 1>
		<TD>
			<A HREF="#Query#StartRow=1"><!---<IMG SRC="/iwgraph/LeftArrowFirstBlue2.gif" BORDER=0 ALT="Go to Beginning of Query Results">---><IMG SRC="/iwgraph/BtnTop.png" ALT="Go to Beginning of Query Results"></A>
		</TD>

		<TD>
			<CFSET NewRow = Max(StartRow - Max, 1)>
			<A HREF="#Query#StartRow=#NewRow#"><!---<IMG SRC="/iwgraph/LeftArrowBlue2.gif" BORDER=0 ALT="Show Previous #Max# Records">---><IMG SRC="/iwgraph/BtnPrev.png" ALT="Show Previous #Max# Records"></A>
		</TD>
	<CFELSE>
		<TD>
			<!---<IMG SRC="/iwgraph/LeftArrowNoFirst2.gif" BORDER=0 ALT="No Previous Records">---><IMG SRC="/iwgraph/BtnTopDisabled.png" ALT="No Previous Records">
		</TD>

		<TD>
			<!---<IMG SRC="/iwgraph/LeftArrowNoPrev2.gif" BORDER=0 ALT="No Previous Records">---><IMG SRC="/iwgraph/BtnPrevDisabled.png" ALT="No Previous Records">
		</TD>
	</CFIF>

	<TD VALIGN="CENTER" NOWRAP class="display-pos">
		<CFSET NewRow = Min(StartRow + Max - 1, GetDeductionByWarrant.RecordCount)>
		#StartRow# - #NewRow# of #GetDeductionByWarrant.RecordCount#
	</TD>

	<CFIF StartRow + (Max-1) LT GetDeductionByWarrant.RecordCount>
	
		<TD>
			<CFSET NewRow = StartRow + Max>
			<A HREF="#Query#StartRow=#NewRow#"><!---<IMG SRC="/iwgraph/RightArrowBlue2.gif" BORDER=0 ALT="Next #Max# Records">---><IMG SRC="/iwgraph/BtnNext.png" ALT="Next #Max# Records"></A>
		</TD>
	
		<TD>
			<CFSET NewRow = GetDeductionByWarrant.RecordCount - Max + 1>
			<A HREF="#Query#StartRow=#NewRow#"><!---<IMG SRC="/iwgraph/RightArrowLastBlue2.gif" BORDER=0 ALT="Go to End of Query Results">---><IMG SRC="/iwgraph/BtnBottom.png" ALT="Go to End of Query Results"></A>
		</TD>
			
	<CFELSE>
		<TD>
			<!---<IMG SRC="/iwgraph/RightArrowNoNext2.gif" BORDER=0 ALT="No More Records">---><IMG SRC="/iwgraph/BtnNextDisabled.png" ALT="No More Records">
		</TD>
		<TD>
			<!---<IMG SRC="/iwgraph/RightArrowNoLast2.gif" BORDER=0 ALT="No More Records">---><IMG SRC="/iwgraph/BtnBottomDisabled.png" ALT="No More Records">
		</TD>
	</CFIF>

</CFOUTPUT>
</TABLE>
<!-- End of Prev/Next -->
