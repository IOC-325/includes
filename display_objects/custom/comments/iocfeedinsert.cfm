<!---
This template is fed by the GENERAL COMMENTS form (GeneralComments.cfm)for the website.
Date: 7/16/15 
--->

<cfif not isDefined("form.division")>
	<CFSET Session.Comments.COMMENT_TYPE = form.COMMENT_TYPE>
    <CFSET Session.Comments.USER_TYPE = form.USER_TYPE>
    <CFSET Session.Comments.SUBJECT = form.SUBJECT>
    <CFSET Session.Comments.Division = form.Division>
    <CFSET Session.Comments.COMMENTS = form.COMMENTS>
    <CFSET Session.Comments.FirstName = form.FirstName>
    <CFSET Session.Comments.middleName = form.middleName>
    <CFSET Session.Comments.lastName = form.lastName>
    <CFSET Session.Comments.COMPANY = form.COMPANY>
    <CFSET Session.Comments.telephone = form.telephone>
    <CFSET Session.Comments.FAX = form.FAX>
    <CFSET Session.Comments.Email = form.Email>
    <CFSET Session.Comments.Address1 = form.Address1>
    <CFSET Session.Comments.Address2 = form.Address2>
    <CFSET Session.Comments.City = form.City>
    <CFSET Session.Comments.State = form.State>
    <CFSET Session.Comments.ZipCode = form.ZipCode>
   
            <cflocation url="/comptroller/?LinkServID=139A1441-1FCB-4059-8ACFA90306E53445&error=1" addtoken="no">	
            <cfabort>
</cfif>
<CFSET IsBot = true>
<CFIF IsDefined ("form.CaptchaWord")>
    <cfinvoke
        component="security.IOCSecurity"
        method="BotTest"
        returnvariable="IsBot">
        <cfinvokeargument name="formData" value="#form#">
    </cfinvoke>
    
    <CFIF IsBot IS "false">
    	<CFSET IsBot = false>
    <CFELSE>
		<!---BOT--->
	<CFSET Session.Comments.COMMENT_TYPE = form.COMMENT_TYPE>
    <CFSET Session.Comments.USER_TYPE = form.USER_TYPE>
    <CFSET Session.Comments.SUBJECT = form.SUBJECT>
    <CFSET Session.Comments.Division = form.Division>
    <CFSET Session.Comments.COMMENTS = form.COMMENTS>
    <CFSET Session.Comments.FirstName = form.FirstName>
    <CFSET Session.Comments.middleName = form.middleName>
    <CFSET Session.Comments.lastName = form.lastName>
    <CFSET Session.Comments.COMPANY = form.COMPANY>
    <CFSET Session.Comments.telephone = form.telephone>
    <CFSET Session.Comments.FAX = form.FAX>
    <CFSET Session.Comments.Email = form.Email>
    <CFSET Session.Comments.Address1 = form.Address1>
    <CFSET Session.Comments.Address2 = form.Address2>
    <CFSET Session.Comments.City = form.City>
    <CFSET Session.Comments.State = form.State>
    <CFSET Session.Comments.ZipCode = form.ZipCode> 
        <cflocation url = "/comptroller/?LinkServID=139A1441-1FCB-4059-8ACFA90306E53445&error=2" addtoken="no">	
    </CFIF>
</CFIF>
<cfoutput>
    
	<cfif TRIM(form.Division) eq "General Inquiry" AND IsBot IS false>
			<!--- This is a special case where the item goes to iConstituent --->
             <cfmail usetls="true"
                to="ilc@hcrm.iconstituent.com" 
                cc="andy.peterson@illinoiscomptroller.gov" 
                from="generalinquiry@illinoiscomptroller.gov" 
                Subject="Comment from Website" 
                server="outlook.office365.com"
                username="generalinquiry@illinoiscomptroller.gov"
                password="Password123"
                type="text"> 
    
    			
                        <APP>  
                        <PREFIX>#Form.Prefix#</PREFIX> 
                        <FirstName>#Form.FirstName#</FirstName> 
                        <MiddleName>#form.MiddleName#</MiddleName> 
                        <LastName>#form.LastName#</LastName> 
                        <SUFFIX>#form.suffix#</SUFFIX> 
                        <ADDRESS1>#form.address1#</ADDRESS1>
                        <ADDRESS2>#form.address2#</ADDRESS2> 
                        <CITY>#form.city#</CITY> 
                        <STATE>#form.state#</STATE> 
                        <ZIP>#form.zipCode#</ZIP> 
                        <CompanyName>#form.company#</CompanyName>
                        <EMAIL>#form.email#</EMAIL> 
                        <HomePHONE>#form.telephone#</HomePHONE>
                        <ISSUE>#form.subject#</ISSUE>
                        <MessageBody>#form.comments#</MessageBody>
                        <IpAddress>#cgi.remote_addr#</IpAddress>  
                        </APP>
            </cfmail>

	<cfelseif IsBot IS false>

			<cfif form.Division is "1099">
                <cfset TmpDivEmail = "1099@illinoiscomptroller.gov">
            <cfelseif form.Division is "PLACE">
                <cfset TmpDivEmail = "PLACE@illinoiscomptroller.gov">
            <cfelseif form.Division is "FeeRpt">
                <cfset TmpDivEmail = "FeeRpt@illinoiscomptroller.gov">
            <cfelseif form.Division is "FiscalFocus">
                <cfset TmpDivEmail = "FiscalFocus@illinoiscomptroller.gov">
            <cfelseif form.Division is "IW">
                <cfset TmpDivEmail = "IW@illinoiscomptroller.gov">
            <cfelseif form.Division is "LocGov">
                <cfset TmpDivEmail = "LocGov@illinoiscomptroller.gov">
            <cfelseif form.Division is "SAMSMonthlyRpt">
                <cfset TmpDivEmail = "SAMSMonthlyRpt@illinoiscomptroller.gov">
            <cfelseif form.Division is "TaxExp">
                <cfset TmpDivEmail = "TaxExp@illinoiscomptroller.gov">
            <cfelseif form.Division is "W2">
                <cfset TmpDivEmail = "W2@illinoiscomptroller.gov">
               <cfelseif form.Division is "Spanish">
                <cfset TmpDivEmail = "espanol@illinoiscomptroller.gov">
            <cfelse>
                <cfset TmpDivEmail = "GeneralInquiry@illinoiscomptroller.gov">
            </cfif>
        
            <cfif trim(form.Subject) is "">
                <cfset TmpSubject = "Feedback has been sent!">
            <cfelse>
                <cfset TmpSubject = "#form.Subject#">
            </cfif>
        
            <cfif trim(form.EMail) is "">
                <cfset TmpFromEMail = "webmaster@illinoiscomptroller.gov">
            <cfelse>
                <cfset TmpFromEmail = "#form.EMail#">
            </cfif>
     
            <cfmail usetls="true" 
                    bcc="andy.peterson@illinoiscomptroller.gov" 
                    from= "generalinquiry@illinoiscomptroller.gov" 
                    TO = "#TmpDivEmail#" 
                    subject="Email from Our Website: #TmpSubject#" 
                    type="HTML"
                    server="outlook.office365.com"
                    username="generalinquiry@illinoiscomptroller.gov"
                    password="Password123"> 
                  
                            <p>Comment Target Responder =#form.Division#</p>
                            <p>Suggestion, Praise, Question, or Complaint :  #form.Comment_Type#</p>
                            <p>Subject: #FORM.SUBJECT#</p>
                           <p>Name: #FORM.firstname# #form.lastname#</p>
                            <p>New or Existing User: #form.User_Type#</p>
                            <p>Company=#form.Company#</p>
                            <p>TELEPHONE=#FORM.TELEPHONE#</p>
                            <p>Fax=#form.Fax#</p>
                            <p>Zip=#form.zipcode#</p>
                            <p>
                            <cfif trim(form.EMail) is "">
                                <B><FONT COLOR="Red">No EMail Supplied...Manual Reply!</FONT></B>
                            <cfelse>
                                EMAIL=<A HREF="mailto:#form.Email#">#FORM.EMAIL#</A>
                            </cfif></p>
                            <p>Comments=#FORM.COMMENTS#</p>
            
            </cfmail> 
    <cfelse>
    		CAPTCHA warning!  
            <!--- Never should see this because CAPTCHA ERRORS are redirected on line 23 --->
            <cfabort>

	</cfif>

	<CENTER><H2>Thank You!</H2>
	<P> Thank you for your comments.</P>
    <cfif IsBot IS false>
	<P><B>You are now being sent an automatic confirmation email response to the email address you provided.</B> If you do not receive this automatic email, it might mean that you have sent us an invalid email address. If this is the case, double-check your spelling and try submitting again. </P>
	
	<P><B>To assist in the delivery of email: </B> Please allow all mail coming from "@illinoiscomptroller.gov" to be delivered to your email account if you wish to receive a reply. </P>
    	
    </cfif>
 
 	<P>Please return to <A HREF="http://illinoiscomptroller.gov">Comptroller's Front Page</A>.
	</P></CENTER>
	

	<P ALIGN="left"><H2>Your Message: </H2>
	<B>Email</B>: #HTMLEditFormat(EMAIL)#<BR>
	<B>Subject:</B> #HTMLEditFormat(SUBJECT)#<BR>
	<B>Comment: </B>#HTMLEditFormat(COMMENTS)#</p> 
  

</cfoutput>

