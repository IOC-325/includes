
<!---
Modified Date: 10-14-14
	Modified By: Gary Ashbaugh
	Modifications Made: Created an Deduction site per SR 14136
--->

<CFIF IsDefined ("form.SortBy")>
 <CFSET SortBy = form.SortBy>
<cfelseif IsDefined ("URL.SortBy")>
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



<cfLock Scope="SESSION" TIMEOUT="120" type="readonly">

<cfif not isdefined("Session.VendTIN")>
	<cflocation url="/vendors/enhanced-vendor-remittance/?TimedOut=True" addtoken="No">
</cfif>
<cfinclude template="TmpVendorapplicationSettings.cfm">

</cfLock>

<CFSET Area = "DeductionDownloadForm">

<!---<CFINCLUDE TEMPLATE="VendHeader.cfm">--->

<!--- ***************************************************************** --->
<!--- *                   pdf report                                  * --->
<!--- ***************************************************************** --->

	<cfif urldecode(SortBy) is not "Employee_Name">
		<cfset TmpSortOrder = "#URLDecode(SortBy)# " & "#AscDesc#" & ",Employee_Name">
	<cfelse>
		<cfset TmpSortOrder = "#URLDecode(SortBy)# " & "#AscDesc#">
	</cfif>
	<!---<cfset TmpSortOrder="#urlDecode(SortBy)# #AscDesc#, Employee_Name">--->

	<cfif form.MostRecent is not "Y">
    	<!--- pdf report by Issue_Date range --->
		<cfoutput>
        <cfStoredProc  datasource="Deductions" Procedure="Get_CSVDeduction">
            <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Comp_Code" value="#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
            <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Actual_Code" value="#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">
            <cfprocparam type="In"  cfsqltype="CF_SQL_date" dbvarname="@Begin_Issue_Date" value="#form.StartDate#">
            <cfprocparam type="In"  cfsqltype="CF_SQL_date" dbvarname="@Last_Issue_Date" value="#form.EndDate#">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SortOrder" value="#TmpSortOrder#">
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetpdfDeductionRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetpdfDeductionRetMsg">
            <cfprocresult name="GetpdfDeduction1">
        </cfstoredproc>
        </cfoutput>
     <cfelse>
        <cfoutput>
        <!---<cfset TmpSortOrder = "Generated_Date, Issue_Date, Name">--->

   <!---
   Comp_Code=#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#<br />
Actual_Code=#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#<br />
form.MostRecentDate=#form.MostRecentDate#<br />
<cfif form.LastRecentDate lt DateFormat(now(),"mm/dd/yyyy")>
form.LastRecentDate=#form.LastRecentDate#<br />
form.LastRecentDate=#form.LastRecentDate#<br />
<cfelse>
	#DateFormat(DateAdd("D",-1,form.LastRecentDate),"mm/dd/yyyy")#
    #DateFormat(DateAdd("D",-1,form.LastRecentDate),"mm/dd/yyyy")#
</cfif>
TmpSortOrder=#TmpSortOrder#<cfabort>
--->

        <cfStoredProc  datasource="Deductions" Procedure="Get_CSVDeduction">
           <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Comp_Code" value="#left(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),2)#">
            <cfprocparam type="In"  cfsqltype="cf_sql_varchar" dbvarname="@Actual_Code" value="#mid(decrypt(Session.VendTIN, application.theKey, application.theAlgor, application.TheEncode),3,3)#">
        	<cfprocparam type="In"  cfsqltype="cf_sql_date" dbvarname="@Begin_Issue_Date" null="yes">
        	<cfprocparam type="In"  cfsqltype="cf_sql_date" dbvarname="@Last_Issue_Date" null="yes">
            <cfprocparam type="In"  cfsqltype="CF_SQL_varchar" dbvarname="@SortOrder" value="#TmpSortOrder#">
        	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetpdfDeductionRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetpdfDeductionRetMsg">
            <cfprocresult name="GetpdfDeduction1">
        </cfstoredproc>
       	</cfoutput>

	</cfif>

  <!---  <cfdump var="#GetpdfDeduction1#"><cfabort>--->

	<cfset TmpPay_Period_Number="">

   <!--- <cfdocument format="PDF" margintop=".2" marginbottom=".2" marginright=".2" marginleft=".2" mimetype="text/html" orientation="landscape"  pagewidth="11" pageheight="8.5" encryption="128-bit" permissions="allowprinting" fontembed="no"  >--->

	<!---
	<link rel="stylesheet" type="text/css" href="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/css/CustomEVRLayoutFormatting.css">
	--->
	<!---<cfdocument localUrl="No" format="PDF">--->

    <cfdocument format="PDF" margintop=".1" marginbottom=".2" marginright=".2" marginleft=".2" mimetype="text/html" orientation="landscape">

 	<cfoutput>
    <b><center>Deductions for
	<cfif form.MostRecent is not "Y">
		Deductions listed are for Issue Date of #DateFormat(form.StartDate,"mm/dd/yyyy")# and Ending Issue Date of #DateFormat(form.EndDate,"mm/dd/yyyy")#.</center><br />  <cfif TimeFormat(now(),"medium") GE "12:00:01 AM" and TimeFormat(now(),"medium") lt "9:00:00 AM" and DateFormat(form.EndDate,"mm/dd/yyyy") ge DateFormat(DateAdd("d",1,now()),"mm/dd/yyyy")><font color="Red"><br>WARNING: Not all of the deductions might be included yet since it is before 9:00 AM on #DateFormat(now(),"mm/dd/yyyy")# and you have chosen #DateFormat(form.EndDate,"mm/dd/yyyy")# as your Ending Date.</font></cfif>
	<cfelse>
		Deductions listed are for the Most Recent Generation Date associated with #DateFormat(LastRecentDate,"mm/dd/yyyy")#.   <cfif TimeFormat(now(),"medium") GE "12:00:01 AM" and TimeFormat(now(),"medium") lt "9:00:00 AM"><font color="Red"><br>WARNING: Not all of the deductions might be included yet since it is before 9:00 AM.</font></cfif>


	</cfif></center></b>
     <br><br>
     <table border="1" width="100%" cellspacing="1" cellpadding="1">
     <TR>
        <TD align="Center" id="WarrantNo"><b><br /><br />Trailer<br>Code</b></TD>
		<TD align="Center" id="WarrantNo"><b><br /><br /><br>PP</b></TD>
        <TD align="Center" id="WarrantNo"><b><br /><br />Begin/End<br>Pay Period</b></TD>
        <TD align="Center" id="WarrantNo" width="15%"><b><br /><br /><br>Name</b></TD>
		<TD align="Center" id="WarrantNo"><b><br /><br /><br>Soc Sec No</b></TD>
        <TD  align="center" id="WarrantNo"><b><br /><br />Deduction<br />Amount</b></TD>
		<TD align="Center" id="WarrantNo"><b><br /><Br />Trailer<br>Warrant-Trace</b></TD>
		<TD align="center" id="WarrantNo"><b><br /><br />Trailer<br>Amount</b></TD>
        <TD align="Center" id="WarrantNo"><b><br /><br />Voucher<br>Number</b></TD>
        <TD align="Center" id="WarrantNo"><b><br /><br />Generated<br />Date</b></TD>
        <TD align="Center" id="WarrantNo" width="10%"><b>Anticipated<br />Direct<br />Deposit<br />Date</b></TD>
        <TD align="Center" id="WarrantNo" width="10%"><b>Payroll<br />Code</b></TD>
     </TR>
    <cfset TotTrailerWarrantAmount=0>
     <cfset TotNumberOfDeductions=0>

     <cfloop query="GetpdfDeduction1" >
     	<cfset TotTrailerWarrantAmount = TotTrailerWarrantAmount + Deduction_Amount>
     <cfset TotNumberOfDeductions=TotNumberOfDeductions+1>
     	<!---<cfif GetpdfDeduction1.Pay_Period_Number is not TmpPay_Period_Number and currentrow gt 1>
       		<tr bgcolor="black" style="height:1px;"><td colspan="9">&nbsp;</td></tr>
        	<cfset TmpPay_Period_Number = "#GetpdfDeduction1.Pay_Period_Number#">
        <cfelse>
        	<cfset TmpPay_Period_Number = "#GetpdfDeduction1.Pay_Period_Number#">
        </cfif>--->
        <TR>
		<TD align="center">#GetpdfDeduction1.Trailer_Code#</td>
        <td align="Center">#NumberFormat(Pay_Period_Number,"09")#</td>
        <TD align="Center">#DateFormat(PP_Beginning_Date,"mm/dd/yy")#-<br />#DateFormat(PP_Ending_Date,"mm/dd/yy")#</TD>
        <TD align="left">#Name#</TD>
        <TD align="left">xxx-xx-#NumberFormat(SSN,"0999")#</TD>
        <TD align="Right"><cfif Deduction_Amount lt 0><font color="Red">#NumberFormat(Deduction_Amount,"-99,999,999.90")#</font><cfelse>#NumberFormat(Deduction_Amount,"-99999999.90")#</cfif></TD>
        <TD align="Center">#Deposit_Warrant_Trace#</TD>
        <td  align="Right"><cfif Total_Deposit_Amount lt 0><font color="Red">#NumberFormat(Total_Deposit_Amount,"-9,999,999,999.90")#</font><cfelse>#NumberFormat(Total_Deposit_Amount,"-9,999,999,999.90")#</cfif></td>
        <TD align="Center">#Voucher_Number#</TD>
        <TD align="left">#DateFormat(Generated_Date,"mm/dd/yy")#</TD>
        <TD align="left">#DateFormat(Anticipated_Direct_Deposit_Date,"mm/dd/yy")#</TD>
        <TD align="center">#NumberFormat(Payroll_Code,"09999")#</TD>
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

