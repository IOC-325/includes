<!--- 
Date Created: 4=16=12
Created By: Gary Ashbaugh
Description:  The program allows the user to page through the "User Listing" 6 records at a time, First, Previous, Next, and Last
--->

<html>
<meta name="robots" content="noindex,nofollow">
<body>
	

<center>
<cfoutput>
<cfset TmpNewStartRec = 0>
<cfset TmpNewEndRec = 6>

<!--- Go to Beginning --->
<!--- Development & Production --->
<a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?StartRec=1&EndRec=#TmpNewEndRec#&ValUser=True&RetPage=#URLEncodedFormat(cgi.HTTP_REFERER)#" onClick="Javascript: MakeMouseCursorWait()"><img name="LeftFirstArrow" src="/Comptroller/images/LeftArrowFirstBlue2.gif" width="12" height="12" border="0" id="LeftArrowFirstBlue" alt="First Record" /></a>

<cfif #url.StartRec# ge 7>
	<cfset TmpNewStartRec = #url.StartRec# - 6>
	<cfset TmpNewEndRec = #url.StartRec# - 1>
<cfelse>
	<cfset TmpNewStartRec = 1>
	<cfset TmpNewEndRec = 6>
</cfif>

<!--- Go to Previous Record --->
<!--- Development & Production --->
<a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?StartRec=#TmpNewStartRec#&EndRec=#TmpNewEndRec#&ValUser=True&RetPage=#URLEncodedFormat(cgi.HTTP_REFERER)#" onClick="Javascript: MakeMouseCursorWait()"><img name="LeftArrow" src="/Comptroller/images/LeftArrowBlue2.gif" width="12" height="12" border="0" id="LeftArrowBlue" alt="Previous Record" /></a> 
 
 <!--- Display where the user is positioned --->
 <cfif url.StartRec gt url.EndRec>0<cfelse>#url.StartRec#</cfif> - <cfif url.EndRec ge url.EndRec>#url.EndRec#<cfelse>#url.EndRec#</cfif> of <cfif LastRec lt 6>6<cfelse>#LastRec#</cfif> 

<cfif LastRec le 6>
	<cfset TmpNewStartRec = 1>
	<cfset TmpNewEndRec = 6>
<cfelseif #url.EndRec# le (#LastRec# - 5)>
	<cfset TmpNewStartRec = #url.StartRec# + 6>
	<cfset TmpNewEndRec = #url.EndRec# + 6>
<cfelse>
	<cfif #url.EndRec# is #LastRec#>
		<cfset TmpNewStartRec =#url.StartRec#>
		<cfset TmpNewEndRec = #url.EndRec#>
	<cfelse>
    	<cfif ((#LastRec#-(#lastrec# mod 6)) + 1) ge #lastrec#>
        	<cfset TmpNewStartRec = #LastRec#>
            <cfset TmpNewEndRec = #LastRec#>
        <cfelse>
			<cfset TmpNewStartRec = #LastRec# - (#LastRec# mod 6) + 1>
			<cfset TmpNewEndRec = #LastRec#>
        </cfif>

	</cfif>
</cfif>

<!--- Go to Next Record --->
<!--- Development & Production --->
<a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?StartRec=#TmpNewStartRec#&EndRec=#TmpNewEndRec#&ValUser=True&RetPage=#URLEncodedFormat(cgi.HTTP_REFERER)#" onClick="Javascript: MakeMouseCursorWait()"><img name="RightArrow" src="/Comptroller/images/RightArrowBlue2.gif" width="12" height="12" border="0" id="RightArrowBlue" alt="Next Record" /></a>

<cfif LastRec le 6>
	<cfset TmpNewStartRec = 1>	
    <cfset TmpNewEndRec = 6>
<cfelse>
    <cfif ((#LastRec#-(#LastRec# mod 6)) + 1) ge #LastRec#>
           <cfset TmpNewStartRec = #LastRec#>
           <cfset TmpNewEndRec = #LastRec#>
	<cfelse>
		<cfset TmpNewStartRec = #LastRec# - (#LastRec# mod 6) + 1>
		<cfset TmpNewEndRec = #LastRec#>
	</cfif>
</cfif>


<!--- Go to Last Record --->
<!--- Development & Production --->
<a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?StartRec=#TmpNewStartRec#&EndRec=#TmpNewEndRec#&ValUser=True&RetPage=#URLEncodedFormat(cgi.HTTP_REFERER)#" onClick="Javascript: MakeMouseCursorWait()"><img name="RightLastArrow" src="/Comptroller/images/RIghtArrowLastBlue2.gif" width="12" height="12" border="0" id="RightLastArrowBlue" alt="Last Record" /></a>&nbsp;&nbsp;
<!--- Development & Production --->
<a href="/vendors/enhanced-vendor-remittance/secure-enhanced-vendor-remittance-registration/?NewPage=True"><img src="/images/AddPage.jpg" alt="New Page" width="15" height="15" /></a>
</cfoutput>


</center>
</body>
</html>