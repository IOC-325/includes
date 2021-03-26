<CFHEADER NAME = "Expires" VALUE = "#Now()#">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>ColdFusion Calendar</TITLE>
</HEAD>

<BODY BGCOLOR = "#ffffff">
	
<!--- Set the month and year parameters to equal the current values if they do not exist. --->	
<CFPARAM NAME = "month" DEFAULT = "#DatePart('m', Now())#">
<CFPARAM NAME = "year" DEFAULT = "#DatePart('yyyy', Now())#">

<!--- Set the requested (or current) month/year date and determine the number of days in the month. --->
<CFSET ThisMonthYear = CreateDate(year, month, '1')>
<CFSET Days = DaysInMonth(ThisMonthYear)>

<!--- Set the values for the previous and next months for the back/next links. --->
<CFSET LastMonthYear = DateAdd('m', -1, ThisMonthYear)>
<CFSET LastMonth = DatePart('m', LastMonthYear)>
<CFSET LastYear = DatePart('yyyy', LastMonthYear)>

<CFSET NextMonthYear = DateAdd('m', 1, ThisMonthYear)>
<CFSET NextMonth = DatePart('m', NextMonthYear)>
<CFSET NextYear = DatePart('yyyy', NextMonthYear)>

<SCRIPT LANGUAGE = "JavaScript">
<!--

// function to populate the date on the form and to close this window. --->
function ShowDate(DayOfMonth)
{
	<CFOUTPUT>
		var FormName = "#FormName#";
		var FieldName = "#FieldName#";
		var DateToShow = "#month#/" + DayOfMonth + "/#year#";
		eval("self.opener.document." + FormName + "." + FieldName + ".value = DateToShow");
		window.close();
	</CFOUTPUT>
}

//-->
</SCRIPT>

<TABLE BORDER = "0">
	<TR>
		<TD ALIGN = "center">
			<!--- Display the current month/year as well as the back/next links. --->
			<CFOUTPUT>
				<SPAN CLASS = "small">
					<NOBR><A HREF = "CFDateSelectPopupWindow.cfm?month=#LastMonth#&year=#LastYear#&FormName=#FormName#&FieldName=#FieldName#">&lt;&lt;</A>&nbsp;&nbsp;#MonthAsString(month)#&nbsp;#year#&nbsp;&nbsp;<A HREF = "CFDateSelectPopupWindow.cfm?month=#NextMonth#&year=#NextYear#&FormName=#FormName#&FieldName=#FieldName#">&gt;&gt;</A>
				</SPAN>
			</CFOUTPUT><P>
			
			<TABLE BORDER = "1">
				<!--- Display the day of week headers.  I've truncated the values to display only the first three letters  --->
				<!--- of each day of the week.  --->
				<TR>
					<CFLOOP FROM = "1" TO = "7" INDEX = "LoopDay">
						<CFOUTPUT>
							<TD WIDTH = "50" ALIGN = "center"><SPAN CLASS = "small">#Left(DayOfWeekAsString(LoopDay), 1)#</SPAN></TD>
						</CFOUTPUT>
					</CFLOOP>
				</TR>
				
				<!--- Set the ThisDay variable to 0.  This value will remain 0 until the day of the week on which the --->
				<!--- first day of the month falls on is reached. --->
				<CFSET ThisDay = 0>
				
				<!--- Loop through until the number of days in the month is reached.  --->
				<CFLOOP CONDITION = "ThisDay LTE Days">
					<TR>
					<!--- Loop through each day of the week. --->
					<CFLOOP FROM = "1" TO = "7" INDEX = "LoopDay">
						<!--- If ThisDay is still 0, check to see if the current day of the week in the loop --->
						<!--- matches the day of the week for the first day of the month. --->
						<!--- If the values match, set ThisDay to 1. --->
						<!--- Otherwise, the value will remain 0 until the correct day of the week is found. --->
						<CFIF ThisDay IS 0>
							<CFIF DayOfWeek(ThisMonthYear) IS LoopDay>
								<CFSET ThisDay = 1>
							</CFIF>
						</CFIF>
						<!--- If the ThisDay value is still 0, or it is greater than the number of days in the month, --->
						<!--- display nothing in the column. --->
						<!--- Otherwise, display the day of the month and increment the value. --->
						<CFIF (ThisDay IS NOT 0) AND (ThisDay LTE Days)>
							<CFOUTPUT>
								<TD ALIGN = "center"><A HREF = "javascript:ShowDate(#ThisDay#)"><SPAN CLASS = "small">#ThisDay#</SPAN></A></TD>
							</CFOUTPUT>
							<CFSET ThisDay = ThisDay + 1>
						<CFELSE>
							<TD><SPAN CLASS = "small">&nbsp;</SPAN></TD>
						</CFIF>
					</CFLOOP>
					</TR>
				</CFLOOP>
				
			</TABLE>
			
		</TD>
	</TR>
</TABLE>

</BODY>
</HTML>

