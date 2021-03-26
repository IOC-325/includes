
<!---
	Modified Date: 11-10-15
	Modified By: Gary Ashbaugh
	Modifications Made: Created a PDF Report for the Warrant page
--->

<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">

<cfif not isdefined("Session.VendTIN")>
	<cflocation url="/vendors/enhanced-vendor-remittance?TimedOut=True" addtoken="No">
</cfif>
<cfinclude template="TmpVendorapplicationSettings.cfm">

</cfLock>

<CFSET Area = "DeductionWarrantDownloadForm">

<CFIF IsDefined ("form.SortBy")>
  <CFSET SortBy = form.SortBy>  
<cfelseif IsDefined ("url.SortBy")>
 <CFSET SortBy = URL.SortBy>
</CFIF>
<CFIF IsDefined ("form.AscDesc")>
 <CFSET AscDesc = form.AscDesc>
<cfelseif IsDefined ("URL.AscDesc")>
 <CFSET AscDesc = URL.AscDesc>
</CFIF>
<CFIF IsDefined ("form.LastRecentDate")>
 <CFSET LastRecentDate = form.LastRecentDate>
<cfelseif IsDefined ("URL.LastRecentDate")>
 <CFSET LastRecentDate = URL.LastRecentDate>
</CFIF>
<CFIF IsDefined ("form.Warrant")>
 <CFSET Warrant = form.Warrant>
<cfelseif IsDefined ("URL.Warrant")>
 <CFSET Warrant = URL.Warrant>
</CFIF>
<CFIF IsDefined ("form.Trace")>
 <CFSET Trace = form.Trace>
<cfelseif IsDefined ("URL.Trace")>
 <CFSET Trace = URL.Trace>
</CFIF>
<CFIF IsDefined ("form.StartDate")>
 <CFSET StartDate = form.StartDate>
<cfelseif IsDefined ("URL.StartDate")>
 <CFSET StartDate = URL.StartDate>
<cfelse>
 <CFSET StartDate = "">
</CFIF>
<CFIF IsDefined ("form.EndDate")>
 <CFSET EndDate = form.EndDate>
<cfelseif IsDefined ("URL.EndDate")>
 <CFSET EndDate = URL.EndDate>
<cfelse>
 <CFSET EndDate = "">
</CFIF>

<!---<CFINCLUDE TEMPLATE="VendHeader.cfm">--->

<!--- ***************************************************************** --->
<!--- *                   pdf report                                  * --->
<!--- ***************************************************************** --->

	<cfif urldecode(SortBy) is not "Employee_Name">
		<cfset TmpSortOrder = "#URLDecode(SortBy)# " & "#AscDesc#" & ",Employee_Name">
	<cfelse>
		<cfset TmpSortOrder = "#URLDecode(SortBy)# " & "#AscDesc#">
	</cfif>
    <cfset TmpCompCode = "#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
    <cfset TmpActualCode = "#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">

<cftry>
<cfStoredProc  datasource="Deductions" Procedure="Get_DeductionByWarrant">
    <cfprocparam type="In"  cfsqltype="CF_SQL_Char" dbvarname="@Comp_Code" value="#TmpCompCode#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Actual_Code" value="#TmpActualCode#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Trailer_Warrant_Number" value="#form.Warrant#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@Trailer_Warrant_Trace" value="#form.Trace#">
    <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SortOrder" value="#TmpSortOrder#">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetDeductionByWarrantRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetDeductionByWarrantRetMsg">
    <cfprocresult name="GetDeductionByWarrant">
</cfstoredproc>
<cfcatch type="any">
<b>Sorry, there appears to be a problem..please try back later!</b>
</cfcatch>
</cftry>
   
	<cfset TmpPay_Period_Number="">	
	
     <cfdocument format="PDF" margintop=".1" marginbottom=".2" marginright=".3" marginleft=".3" mimetype="text/html" orientation="landscape">
  
 	<cfoutput> 
    <b><center>Deductions for 
	<cfif form.MostRecent is not "Y">
		Deductions listed have Anticipated Direct Deposit Dates between <B>#DateFormat(StartDate, "mm-dd-yy")# </B>and <B>#Dateformat(EndDate, "mm-dd-yy")#</B><br />for Warrant/Trace of <B>#Warrant#-#Trace#</B>.</center><br /> <cfif TimeFormat(now(),"medium") GE "12:00:01 AM" and TimeFormat(now(),"medium") lt "9:00:00 AM" and DateFormat(EndDate,"mm/dd/yyyy") ge DateFormat(DateAdd("d",1,now()),"mm/dd/yyyy")><font color="Red"><br>WARNING: Not all of the deductions might be included yet since it is before 9:00 AM on #DateFormat(now(),"mm/dd/yyyy")# and you have chosen #DateFormat(EndDate,"mm/dd/yyyy")# as your Ending Date.</font></cfif>
	<cfelse>
		Deductions listed are for the Most Recent Generation Date associated with <b>#DateFormat(LastRecentDate,"mm/dd/yyyy")#</B> <br />for Warrant/Trace of <B>#Warrant#-#Trace#</B>.   <cfif TimeFormat(now(),"medium") GE "12:00:01 AM" and TimeFormat(now(),"medium") lt "9:00:00 AM"><font color="Red"><br>WARNING: Not all of the deductions might be included yet since it is before 9:00 AM.</font></cfif></center>
	</cfif></b>
     <br><br>
      <table border="1" width="98%" cellspacing="1" cellpadding="1">		
     <TR>
        <TD align="Center" id="WarrantNo" width="5%"><b><br /><br />Trailer<br>Code</b></TD>
		<TD align="Center" id="WarrantNo"><b><br /><br /><br>PP</b></TD>
        <TD align="Center" id="WarrantNo"><b><br /><br />Begin/End<br>Pay Period</b></TD>	
        <TD align="Center" id="WarrantNo" width="20%"><b><br /><br /><br>Name</b></TD>     
		<TD align="Center" id="WarrantNo"><b><br /><br /><br>Soc Sec No</b></TD>  	
        <TD  align="center" id="WarrantNo"><b><br /><br />Deduction<br />Amount</b></TD>
		<TD align="Center" id="WarrantNo"><b><br /><Br />Trailer<br>Warrant-Trace</b></TD> 
		<TD align="center" id="WarrantNo"><b><br /><br />Trailer<br>Amount</b></TD>  
        <TD align="Center" id="WarrantNo"><b><br /><br />Voucher<br>Number</b></TD> 
        <TD align="Center" id="WarrantNo"><b><br /><br />Generated<br />Date</b></TD>
        <TD align="Center" id="WarrantNo"><b>Anticipated<br />Direct<br />Deposit<br />Date</b></TD>  
        <TD align="Center" id="WarrantNo"><b>Payroll<br />Code</b></TD>
     </TR>
    
     <cfset TotTrailerWarrantAmount=0>
     <cfset TotNumberOfDeductions=0>
     <cfloop query="GetDeductionByWarrant">	
	 <cfset TotTrailerWarrantAmount = TotTrailerWarrantAmount + Deduction_Amount>
     <cfset TotNumberOfDeductions=TotNumberOfDeductions+1>
       <TR>
		<TD align="right">#TmpCompCode##TmpActualCode#</td>
         <td align="Center">#NumberFormat(Pay_Period,"09")#</td>
        <TD align="Center">#DateFormat(PP_Beginning_Date,"mm/dd/yy")#-<br />#DateFormat(GetDeductionByWarrant.PP_Ending_Date,"mm/dd/yy")#</TD>
        <TD align="left">#Employee_Name#</TD>
        <TD align="left">xxx-xx-#NumberFormat(Id,"0999")#</TD>
        <TD align="Right"><cfif Deduction_Amount lt 0><font color="Red">#NumberFormat(Deduction_Amount,"-99,999,999.90")#</font><cfelse>#NumberFormat(Deduction_Amount,"-99,999,999.90")#</cfif></TD>
     <TD align="Center">#Warrant#-<br />#Trace#</TD>
        <td  align="Right"><cfif Trailer_Warrant_Amount lt 0><font color="Red">#NumberFormat(Trailer_Warrant_Amount,"-9,999,999,999.90")#</font><cfelse>#NumberFormat(Trailer_Warrant_Amount,"-9,999,999,999.90")#</cfif></td> 
        <TD align="Center">#Voucher_Number#</TD>
        <TD align="left">#DateFormat(Work_Date,"mm/dd/yy")#</TD>
        <TD align="left">#DateFormat(Issue_Date,"mm/dd/yy")#</TD> 
        <TD align="Center">#NumberFormat(Pay_Code,"09999")#</TD>
        </TR>  
 	</cfloop>
    <tr>
    <TD align="left" colspan="3">Number of Deductions:</TD>
    <td align="left">#NumberFormat(TotNumberOfDeductions,"999,999,999,999")#</td>
    <TD align="left">Total:</TD>
    <TD align="Right"><cfif TotTrailerWarrantAmount lt 0><font color="Red">#NumberFormat(TotTrailerWarrantAmount,"-99,999,999.90")#</font><cfelse>#NumberFormat(TotTrailerWarrantAmount,"-99,999,999.90")#</cfif></TD>
     <TD align="Center">&nbsp;</TD>
     <td align="Right">&nbsp;</td> 
     <TD align="Center">&nbsp;</TD>
     <TD align="left">&nbsp;</TD>
     <TD align="left">&nbsp;</TD>
     <TD align="left">&nbsp;</TD> 
    </tr>
    </TABLE>   
   
	</cfoutput>
	</cfdocument>  
 
 <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    
