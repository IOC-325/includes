<!-- Show Previous and Next commands if necessary  -->
<CFIF #ParameterExists(StartRow)# IS "No">
	<CFSET StartRow = 1>
<!--- Added code on 1/17 to take care of a potential hacking issue --->
<cfelseif isnumeric(StartRow) is "False">
	<Cfset StartRow=1>
</CFIF>

<TABLE>
<TR>
<CFOUTPUT>

	<CFIF StartRow IS NOT 1>
		<TD>
			<A HREF="#Query#StartRow=1" id="First"><IMG SRC="/iwgraph/BtnTop.png" ALT="Go to Beginning of Query Results"></A>
		</TD>

		<TD>
			<CFSET NewRow = Max(StartRow - max, 1)>
			<A HREF="#Query#StartRow=#NewRow#" id="Previous"><IMG SRC="/iwgraph/BtnPrev.png" ALT="Show Previous #max# Records"></A>
		</TD>
	<CFELSE>
		<TD>
			<IMG SRC="/iwgraph/BtnTopDisabled.png" ALT="No Previous Records">
		</TD>

		<TD>
			<IMG SRC="/iwgraph/BtnPrevDisabled.png" ALT="No Previous Records">
		</TD>
	</CFIF>

	<TD VALIGN=CENTER NOWRAP class="display-pos">
<!---		<cfif not isDefined("results.RecordCount")><!--- Error 031114 --->
			<cfmail to="webmaster@IllinoisComptroller.Gov" from="webmaster@IllinoisComptroller.Gov" subject="IOC-WEBVM-2 IW Results.RecordCount Error (Mura)" type="html">

			Error Info:
			
			<cfif isDefined("arguments.exception")>
				<cfdump var="#arguments.exception#" label="arguments.exception">
			</cfif>

			<cfif isDefined("Error")>
				<cfdump var="#Error#" label="error">
			</cfif>

			<cfif isDefined("CFCatch")>
				<cfdump var="#CFCatch#" label="CFCatch">
			</cfif>

			</cfmail>
		
			<cfabort>
		
		</cfif>--->
		<CFSET NewRow = Min(StartRow + max - 1, Results.RecordCount)>
		#StartRow# - #NewRow# of #Results.RecordCount#
	</TD>

	<CFIF StartRow + (max-1) LT Results.RecordCount>
	
		<TD>
			<CFSET NewRow = StartRow + max>
			<A HREF="#Query#StartRow=#NewRow#" id="Next"><IMG SRC="/iwgraph/BtnNext.png" ALT="Next #max# Records"></A>
		</TD>
	
		<TD>
			<CFSET NewRow = Results.RecordCount - max + 1>
			<A HREF="#Query#StartRow=#NewRow#" id="Last"><IMG SRC="/iwgraph/BtnBottom.png" ALT="Go to End of Query Results"></A>
		</TD>
			
	<CFELSE>
		<TD>
			<IMG SRC="/iwgraph/BtnNextDisabled.png" ALT="No More Records">
		</TD>
		<TD>
			<IMG SRC="/iwgraph/BtnBottomDisabled.png" ALT="No More Records">
		</TD>
	</CFIF>

</CFOUTPUT>
</TABLE>
<!-- End of Prev/Next -->