<!-- Show Previous and Next commands if necessary  -->
<CFIF #ParameterExists(SpreadsheetStartRow)# IS "No">
	<CFSET SpreadsheetStartRow = 1>
</CFIF>

<TABLE>
<TR>
<CFOUTPUT>

	<CFIF SpreadsheetStartRow IS NOT 1>
		<TD>
			<A HREF="#Query#SpreadsheetStartRow=1" id="FirstSpreadsheet"><!---<IMG SRC="/iwgraph/LeftArrowFirstBlue2.gif" BORDER=0 ALT="Go to Beginning of Spreadsheet Results">---><IMG SRC="/iwgraph/BtnTop.png" ALT="Go to Beginning of Spreadsheet Results"></A>
		</TD>

		<TD>
			<CFSET NewRow = Max(SpreadsheetStartRow - SpreadsheetMax, 1)>
			<A HREF="#Query#SpreadsheetStartRow=#SpreadsheetNewRow#"  id="PreviousSpreadsheet"><!---<IMG SRC="/iwgraph/LeftArrowBlue2.gif" BORDER=0 ALT="Show Previous #SpreadsheetMax# Records">---><IMG SRC="/iwgraph/BtnPrev.png" ALT="Show Previous #SpreadsheetMax# Records"></A>
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
		<CFSET SpreadsheetNewRow = Min(SpreadsheetStartRow + SpreadsheetMax - 1, arraylen(Session.MyTRANSACTION_NUMBER))>
		#SpreadsheetStartRow# - #SpreadsheetNewRow# of #arraylen(Session.MyTRANSACTION_NUMBER)#
	</TD>

	<CFIF SpreadsheetStartRow + (SpreadsheetMax-1) LT arraylen(Session.MyTRANSACTION_NUMBER)>
	
		<TD>
			<CFSET SpreadsheetNewRow = SpreadsheetStartRow + SpreadsheetMax>
			<A HREF="#Query#SpreadsheetStartRow=#SpreadsheetNewRow#" id="NextSpreadsheet"><!---<IMG SRC="/iwgraph/RightArrowBlue2.gif" BORDER=0 ALT="Next #SpreadsheetMax# Records">---><IMG SRC="/iwgraph/BtnNext.png" BORDER="0" ALT="Next #SpreadsheetMax# Records"></A>
		</TD>
	
		<TD>
			<CFSET SpreadsheetNewRow = arraylen(Session.MyTRANSACTION_NUMBER) - SpreadsheetMax + 1>
			<A HREF="#Query#SpreadsheetStartRow=#SpreadsheetNewRow#"  id="LastSpreadsheet"><!---<IMG SRC="/iwgraph/RightArrowLastBlue2.gif" BORDER=0 ALT="Go to End of Spreadsheet Results">---><IMG SRC="/iwgraph/BtnBottom.png" BORDER="0" ALT="Go to End of Spreadsheet Results"></A>
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
