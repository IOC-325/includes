<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta name="robots" content="noindex,nofollow">
<!--- 
Created By: Gary Ashbaugh
Date Created: 2-15-2012
Description:  The program will allow users to register for the Local Government Training Conference
--->

<cfparam name="MailFrom" default="Lauren.Shiliga@IllinoisComptroller.Gov">
<cfparam name="FailTo" default="Gary.Ashbaugh@IllinoisComptroller.Gov">



<script language="JavaScript"><!--
	 
	  function ValidateForm() { 
	 	if (document.LDRPConfReg.LastName.value=='') {
			alert("You must enter your last name. We can not register you until you correct this problem!");
			return false;
		}
		else if (document.LDRPConfReg.FirstName.value=='') {
			alert("You must enter your first name.  We can not register you until you correct this problem!");
			return false;
		}
		else if (document.LDRPConfReg.Location.value=='') {
			alert("You must enter the location of the conference you will be attending.  We can not register you until you correct this problem!");
			return false;
		}
		else if (document.LDRPConfReg.Email.value=='') {
			alert("You must enter the E-Mail address in case we need to contact you.  We can not register you until you correct this problem!");
			return false;
		}
		else if (document.LDRPConfReg.UnitofGovernment.value=='') {
			alert("You must enter your Unit of Government.  We can not register you until you correct this problem!");
			return false;
		}
		else {
			
			return true;
				
		}

	 }
	 
// -->	 
</script>

<cfif ParameterExists(SubmitRegistration)>
	<CFLOCK SCOPE="Session" timeout="100">
	<cfoutput>
    <cfif (not isdefined("form.Location")) or trim(form.LastName) is "" or trim(form.FirstName) is "" or trim(form.Email) is "" or trim(form.UnitofGovernment) is "">
    	<font color="red"><b>We can not register you since you failed to fillout either your First Name, Last Name, E-Mail, Unit Of Government, and/or Location.  Click on your browser's back button, fill in the missing information, and then click on the "Submit Registration" again.</b></font>
    <cfelse>
		
		<cfStoredProc datasource="LDRPConfReg" Procedure="Check_TrainingConfReg">
            <cfif trim(form.FirstName) is not "">
                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Firstname" value="#form.Firstname#">
            <cfelse>
                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Firstname" null="yes">
            </cfif>
            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Lastname" value="#form.Lastname#">
			<cfif trim(form.UnitofGovernment) is not "">
                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@UnitofGovernment" value="#form.UnitofGovernment#">
            <cfelse>
                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@UnitofGovernment" null="yes">
            </cfif>
            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckTrainingConfRegRetVal">
            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckTrainingConfRegRetMsg">
            <cfprocresult name="CheckTrainingConfReg">
        </cfstoredproc>
		
		<cfif CheckTrainingConfReg.recordcount>
			<font color="red"><b>You have already registered for "Follow the Money".  If you wish to change your location, please contact us at #MailFrom# or contact our Public Affairs Division at (855) 452-7587.</b></font>
		<cfelse>
	        <cfStoredProc datasource="LDRPConfReg" Procedure="Add_TrainingConfReg">
	            <cfif trim(form.FirstName) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Firstname" value="#form.Firstname#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Firstname" null="yes">
	            </cfif>
	            <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Lastname" value="#form.Lastname#">
	            <cfif trim(form.Title) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Title" value="#form.Title#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Title" null="yes">
	            </cfif>
                 <cfif trim(form.ElectedOfficial) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@ElectedOfficial" value="#form.ElectedOfficial#">
	            <cfelse>
	            	<cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@ElectedOfficial" value="N">
                </cfif>
	            <cfif trim(form.UnitofGovernment) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@UnitofGovernment" value="#form.UnitofGovernment#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@UnitofGovernment" null="yes">
	            </cfif>
	            <cfif trim(form.County) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@County" value="#form.County#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@County" null="yes">
	            </cfif>
	            <cfif trim(form.Address) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Address" value="#form.Address#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Address" null="yes">
	            </cfif>
	            <cfif trim(form.City) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@City" value="#form.City#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@City" null="yes">
	            </cfif>
	            <cfif trim(form.State) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@State" value="#form.State#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@State" null="yes">
	            </cfif>
	            <cfif trim(form.PostalCode) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PostalCode" value="#form.PostalCode#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@PostalCode" null="yes">
	            </cfif>
	            <cfif trim(form.Phone) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Phone" value="#form.Phone#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Phone" null="yes">
	            </cfif>
	            <cfif trim(form.Fax) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Fax" value="#form.Fax#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Fax" null="yes">
	            </cfif>
	            <cfif trim(form.Email) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Email" value="#form.Email#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Email" null="yes">
	            </cfif>
	            <cfif trim(form.Location) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Location" value="#trim(form.Location)#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@Location" null="yes">
	            </cfif>
	            <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@WillAttend" value="Y">
	            <cfif trim(form.BreakOutSes1) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@BreakOutSes1" value="#form.BreakOutSes1#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@BreakOutSes1" null="yes">
	            </cfif>
	            <cfif trim(form.BreakOutSes2) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@BreakOutSes2" value="#form.BreakOutSes2#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@BreakOutSes2" null="yes">
	            </cfif>
	            <cfif trim(form.BreakOutSes3) is not "">
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@BreakOutSes3" value="#form.BreakOutSes3#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_varChar" dbvarname="@BreakOutSes3" null="yes">
	            </cfif>
	            <cfif isdefined("form.LunchRequest")>
	                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@LunchRequest" value="#form.LunchRequest#">
	            <cfelse>
	                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@LunchRequest" value="N">
	            </cfif>
	            <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="AddTrainingConfRegRetVal">
	            <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="AddTrainingConfRegRetMsg">
	            <cfprocresult name="AddTrainingConfReg">
	        </cfstoredproc>
	        
	        <b>Thank You for registering with us for "Follow the Money" on #DateFormat(Now(),"mm/dd/yyyy")#!<br><br>You have registered for the following location: #trim(form.Location)#.<br><br>If we have you registered for the wrong location, please contact our office at <a href="Mailto:#MailFrom#?Subject=Follow the Money">#MailFrom#</a> or contact our Public Affairs Division at (855) 452-7587.<br><br>You will be receiving a Confirmation E-Mail from us shortly.  Please print off the E-Mail for your records.  If you do NOT receive the E-Mail, please check your "Junk E-mail" folder.
	        
	        <CFMail 
			TO="#trim(form.EMail)#"
			from="#MailFrom#" failto="#FailTo#" 
	    	 subject="Follow the Money Registration Confirmation"
			  type="html">
			 <P>This is an automated E-Mail sent to you by the Illinois Office of the Comptroller, Public Affairs Division.  It is being sent from the Follow the Money Registration application.<br><br><b>You have been registered for #form.Location#</b>.<br>Please print off this Confirmation E-Mail for your records.<br><br>If you did not register for  "Follow the Money" or you are registered for the wrong location, please contact our office at <a href="Mailto:#MailFrom#?Subject=Follow the Money">#MailFrom#</a> or contact our Public Affairs Division at  (855) 452-7587.
			<br><br>
			Thank You,
			<br><br><Br><Br>
			Illinois Office of the Comptroller, Public Affairs Division</P>
			 <BR>
			 <BR>
			 <FONT STYLE="A.Report" SIZE="-1">**This is an automated E-Mail sent to you by the Illinois Office of the Comptroller, Public Affairs Division from its Follow the Money Registration application.</FONT>
			</cfmail>
	    
	    	<CFMail 
			TO="#MailFrom#"
			from="#MailFrom#"
	    	 subject="Registration Confirmation for #form.FirstName# #form.LastName#"
			  type="html">
	          
	          The following Follow the Money Registration has been received via Follow the Money Registration application.<br /><br />
			 <P>First Name: #Form.FirstName#<br />
	         Last Name: #Form.LastName#<br />
	         Job Title: #form.Title#<br />
	         Elected Official: #form.ElectedOfficial#<br />
	         Unit of Government: #form.UnitofGovernment#<br />
	         County: #form.County#<br />
	         Address: #form.Address#<br />
	         City: #form.City#<br />
	         State: #form.State#<br />
	         ZIP: #form.PostalCode#<br />
	         Phone: #form.Phone#<br />
	         Fax: #form.Fax#<br />
	         E-Mail: #form.Email#<br />
	         Location: #Location#<br />
	         Will Attend: Y<br />
	         Date Submitted: #DateFormat(Now(),"mm/dd/yyyy")#<br />
	         Submitted By: Online Registration<br />
			 <BR>
			 <BR>
			 <FONT STYLE="A.Report" SIZE="-1">**This is an automated E-Mail sent to you by the Illinois Office of the Comptroller, Public Affairs Division from its Follow the Money Reqistration application.</FONT>
			</cfmail>
          
            <cfif isdefined("ShareEmail")>
			
				<cfquery name="CheckEmail" datasource="Mura_To_6">
                Select Email
				from TMAILINGLISTMEMBERS
				where ltrim(rtrim(Email)) = '#ltrim(rtrim(form.Email))#'
				</cfquery>
				
				<cfif CheckEmail.recordcount eq 0>
					<cfquery name="InsertEmail" datasource="MURA_TO_6">
					INSERT INTO TMAILINGLISTMEMBERS (MLID, email, SiteID, fname, lname, company, isVerified, created, nonmuraphone, nonmuraprovider)
					VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="F56E20CD-88DB-44F3-AE7F945842C00377">
							, <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#"/>
							, <cfqueryparam cfsqltype="cf_sql_varchar" value="comptroller"/>
							, <cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.FirstName#"/>
							, <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lastname#"/>
							, <cfqueryparam cfsqltype="cf_sql_varchar" value="TeamingUpForTaxpayersApplication"/>
							, <cfqueryparam cfsqltype="cf_sql_integer" value="0">
							, <cfqueryparam cfsqltype="cf_sql_date" value="#createODBCDateTime(Now())#"/>
							, <cfqueryparam cfsqltype="cf_sql_varchar" value="NULL"/>
							, <cfqueryparam cfsqltype="cf_sql_varchar" value="NULL"/>)
					</cfquery>
				</cfif>
            
            </cfif>
		
		</cfif>
		<cfabort>
	</cfif>
	</cfoutput>
	</cflock>


</cfif>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Follow the Money Registration</title>
</head>

<cfoutput>
    <cfStoredProc datasource="LDRPConfReg" Procedure="Get_County">
		<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCountyRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCountyRetMsg">
		<cfprocresult name="GetCounty">
	</cfstoredproc>
    
    <cfStoredProc datasource="LDRPConfReg" Procedure="Get_TrainingConfLocation">
		<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTrainingConfLocationRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTrainingConfLocationRetMsg">
		<cfprocresult name="GetTrainingConfLocation">
	</cfstoredproc>
    
    <cfStoredProc datasource="LDRPConfReg" Procedure="Get_TrainingConfBrkout">
    	<cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="Optional" value="Y">
		<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTrainingConfBrkoutRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTrainingConfBrkoutRetMsg">
		<cfprocresult name="GetOptionalTrainingConfBrkout">
	</cfstoredproc>
    
    <cfStoredProc datasource="LDRPConfReg" Procedure="Get_TrainingConfBrkout">
    	<cfprocparam type="In" cfsqltype="cf_sql_char" dbvarname="Optional" value="N">
		<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTrainingConfBrkoutRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTrainingConfBrkoutRetMsg">
		<cfprocresult name="GetTrainingConfBrkout">
	</cfstoredproc>

    
    <cfStoredProc datasource="LDRPConfReg" Procedure="Get_TrainingConfLocation">
		<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetTrainingConfLocationRetVal">
		<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetTrainingConfLocationRetMsg">
		<cfprocresult name="GetTrainingConfLocation">
	</cfstoredproc>
 

</cfoutput>

<body>

<cfform name="LDRPConfReg" action="http://www.ioc.state.il.us/index.cfm/departments/local-government-division/followthemoney/follow-the-money1/" onsubmit="return ValidateForm()"   method="post">
<cfoutput>
<img src="/iwgraph/FollowtheMoneybanner_nonTransparent.png" width="638" height="188" />
<table width="100%" border="0" cellpadding="1" cellspacing="1" align="left">
<tr><td colspan="3"><b>Please complete the online registration form below.<br><br>Make sure to select a <i>Location</i>.  Once you have filled in your registration information and selected a location, click on the <i>Submit Registration</i> button to complete your registration.  Please contact us if you do NOT receive a Confirmation E-Mail from our office after submitting your registration.<br><br>If you have any questions or concerns, please contact our office at <cfoutput><a href="Mailto:#MailFrom#?Subject=Follow the Money">#MailFrom#</a></cfoutput> or contact our Public Affairs Division at (855) 452-7587. </b></td></tr>
<tr><td colspan="3">&nbsp;</td></tr>
<tr><td colspan="3"><b><i>First Name</i></b>&nbsp;<input type="text" name="FirstName" size="15" maxlength="25" tabindex="1" />&nbsp;&nbsp;&nbsp;<b><i>Last Name</i></b>&nbsp;<input type="text" name="LastName" size="15" maxlength="25" tabindex="2" /></td></tr>
<tr><td colspan="3"><b><i>Job Title</i></b>&nbsp;<input type="text" name="Title" size="50" maxlength="50" tabindex="3" /></td></tr>
<tr><td colspan="3"><b><i>Elected Official</i></b>&nbsp;<input type="radio" name="ElectedOfficial" value="Y" tabindex="4" />Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="ElectedOfficial" value="N"  checked tabindex="5" />No</td></tr>
<tr><td colspan="3"><b><i>Unit of Government</i></b>&nbsp;<input type="text" name="UnitofGovernment" size="50" maxlength="50" tabindex="6" /></td></tr>
<tr><td colspan="3"><b><i>County</i></b>&nbsp;<select name="County" tabindex="7">
	<option value="" selected>&nbsp;</option>
    <cfloop query="GetCounty">
    <option value="#County#">#County#</option>
    </cfloop>
</select></td></tr>
<tr><td colspan="3"><b><i>Address</i></b>&nbsp;<input type="text" name="Address" size="70" maxlength="150" tabindex="8" /></td></tr>
<tr><td colspan="3"><b><i>City</i></b>&nbsp;<input type="text" name="City" size="50" maxlength="50" tabindex="9" /></td></tr>
<tr><td colspan="3"><b><i>State</i></b>&nbsp;<input type="text" name="State" size="3" maxlength="10" tabindex="10" value="IL" />&nbsp;&nbsp;<b><i>ZIP</i></b>&nbsp;<input type="text" name="PostalCode" size="5" maxlength="10" tabindex="11" /></td></tr>
<tr><td colspan="3"><b><i>Phone</i></b>&nbsp;<input type="text" name="Phone" size="30" maxlength="30" tabindex="12" />&nbsp;&nbsp;<b><i>Fax</i></b>&nbsp;<input type="text" name="Fax" size="30" maxlength="30" tabindex="13" /></td></tr>
<tr><td colspan="3"><b><i>E-Mail</i></b>&nbsp;<input type="text" name="Email" size="50" maxlength="50" tabindex="14" /></td></tr>
<tr><td valign="top" colspan="3"><b><i>Locations</i></b></td></tr>
<cfloop query="GetTrainingConfLocation">
<tr><td>&nbsp;</td><td width="1%"><input type="radio" name="Location" value="#GetTrainingConfLocation.Location#" /></td><td><b>#GetTrainingConfLocation.Location#</b></td></td></tr>
</cfloop>
<!--- Un-Comment out the following 3 fields if breakout sessions and lunch fields are going to be used --->
<input type="hidden" name="BreakOutSes1" value="" />
<input type="hidden" name="BreakOutSes2" value="" />
<input type="hidden" name="BreakOutSes3" value="" />

<!--- Un-Comment out the following field if lunch field is going to be used --->
<input type="hidden" name="LunchRequest" value="N" />

<!--- Comment out the following 3 fields if breakout sessions are not going to be used --->
<!---
<tr><td colspan="3"><b><i>Break-Out Sessions 1</i></b>&nbsp;<select name="BreakOutSes1" tabindex="16">
	<option value="" selected>&nbsp;</option>
    <cfloop query="GetTrainingConfBrkout">
    <option value="#BreakoutSessions#">#BreakoutSessions#</option>
    </cfloop>
</select></td></tr>
<tr><td colspan="3"><b><i>Break-Out Sessions 2 (Optional)</i></b>&nbsp;<select name="BreakOutSes2" tabindex="17">
	<option value="" selected>&nbsp;</option>
    <cfloop query="GetOptionalTrainingConfBrkout">
    <option value="#BreakoutSessions#">#BreakoutSessions#</option>
    </cfloop>
</select></td></tr>
<tr><td colspan="3"><b><i>Break-Out Sessions 3 (Optional)</i></b>&nbsp;<select name="BreakOutSes3" tabindex="18">
	<option value="" selected>&nbsp;</option>
    <cfloop query="GetOptionalTrainingConfBrkout">
    <option value="#BreakoutSessions#">#BreakoutSessions#</option>
    </cfloop>
</select></td></tr>
--->

<!--- Comment out the following field if Lunch is going not to be used --->
<!---
<tr><td colspan="3"><b><i>Lunch Request</i></b>&nbsp;<input type="radio" name="LunchRequest" value="Y" tabindex="19" />Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="LunchRequest" value="N"  checked tabindex="20" />No</td></tr>
--->

<input type="hidden" name="Notes" value="" />
<tr><td colspan="3"><input type="checkbox" name="ShareEMail" tabindex="20" />&nbsp;<b><i>By checking this box I certify that the E-Mail provided is registered to me.  I authorize the Office of the Comptroller to send me occasional E-Mails. (Optional)</i></b></td></tr>
<tr><td colspan="3"><center><input type="submit" name="SubmitRegistration" value="Submit Registration" tabindex="21" ></center></td></tr>
<tr><td>&nbsp;</td></tr>
</table>
</cfoutput>
</cfform>
</body>
</html>