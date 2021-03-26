<!--- 
Date Created: 4=16=12
Created By: Gary Ashbaugh
Description:  The program allows the user to page through the "User Listing" 6 records at a time, First, Previous, Next, and Last
--->

<html>
<meta name="robots" content="noindex,nofollow">
<body>

<div class="text-center">
<cfoutput>
<cfset TmpNewStartRec = 0>
<cfset TmpNewEndRec = GetVendorUsersInfo.recordcount>
<!--- Go to Previous Record --->
<cfif url.StartRec ge 2>
	<cfset TmpNewStartRec = url.StartRec - 1>
<cfelse>
	<cfset TmpNewStartRec = 1>
</cfif>
<!--- Go to Beginning --->
<!--- Development & Production --->
<CFIF TmpNewEndRec LTE 1 OR url.StartRec LTE 1>
	<IMG SRC="/iwgraph/BtnTopDisabled.png" ALT="No Previous Records">
	<IMG SRC="/iwgraph/BtnPrevDisabled.png" ALT="No Previous Records">
<cfelse>
        <a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?StartRec=1&ValUser=True" onClick="Javascript: MakeMouseCursorWait()"><IMG SRC="/iwgraph/BtnTop.png"  ALT="First Record" id="First"></a>
        <a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?StartRec=#urlencodedformat(TmpNewStartRec)#&ValUser=True" onClick="Javascript: MakeMouseCursorWait()"><IMG SRC="/iwgraph/BtnPrev.png" id="Previous" ALT="Previous Record"></a>
</cfif>
 
<!--- Display where the user is positioned --->
<span class="display-pos">#url.StartRec# of #GetVendorUsersInfo.recordcount#</span>

<!--- Go to Next Record --->
<cfif url.StartRec lt GetVendorUsersInfo.recordcount>
	<cfset NextRecord = url.StartRec + 1>
<cfelse>
	<cfset NextRecord = url.StartRec>
</cfif>

<!--- Last Record --->
<cfset LastRecord = GetVendorUsersInfo.recordcount>


<!--- Go to Last Record --->
<!--- <cfif url.StartRec lt GetVendorUsersInfo.recordcount>
	<cfset TmpNewStartRec = GetVendorUsersInfo.recordcount>
<cfelse>
	<cfif GetVendorUsersInfo.recordcount>
		<cfset TmpNewStartRec = GetVendorUsersInfo.recordcount>
    <cfelse>
    	<cfset TmpNewStartRec = 1>
    </cfif>
</cfif> --->
<CFIF TmpNewEndRec LTE 1>
	<IMG SRC="/iwgraph/BtnNextDisabled.png" ALT="No More Records">
	<IMG SRC="/iwgraph/BtnBottomDisabled.png" ALT="No More Records">
<cfelse>
    <a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?StartRec=#urlencodedformat(NextRecord)#&ValUser=True" onClick="Javascript: MakeMouseCursorWait()"><IMG SRC="/iwgraph/BtnNext.png" id="Next" ALT="Next Record"></a>
    <a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?StartRec=#urlencodedformat(LastRecord)#&ValUser=True" onClick="Javascript: MakeMouseCursorWait()"><img src="/iwgraph/BtnBottom.png" id="Last" ALT="Last Record"></a>&nbsp;&nbsp;

</CFIF>

<!--- Add New User --->
<a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?NewPage=True"><img src="/Comptroller/images/AddUser.png" alt="Add New User" id="New" /></a>
</cfoutput>


</div>
</body>
</html>