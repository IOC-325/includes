<cfset request.bodytopic="Media Request - Thank you for your request.">

<cfset request.TodayDate=Now()>

<cfif (hash(uCase(form.captcha)) eq form.captchaHash) and form.mth eq "5">

<cfstoredproc DATASOURCE="External_User" PROCEDURE="InsertMediaRequest" RETURNCODE="YES">
	<cfprocparam CFSQLTYPE="CF_SQL_VARCHAR" DBVARNAME="First_Name" VALUE="#form.first_name#" TYPE="in"/>
   <cfprocparam CFSQLTYPE="CF_SQL_Varchar" DBVARNAME="Last_Name" VALUE="#form.last_name#" TYPE="IN">
   <cfprocparam CFSQLTYPE="CF_SQL_VARCHAR" DBVARNAME="Email" VALUE="#form.email#" TYPE="IN">
   <cfprocparam CFSQLTYPE="CF_SQL_VARCHAR" DBVARNAME="Phone" VALUE="#form.phone#" TYPE="IN">
   <cfprocparam CFSQLTYPE="CF_SQL_VARCHAR" DBVARNAME="Company" VALUE="#form.company#" TYPE="IN">
   <cfprocparam CFSQLTYPE="CF_SQL_LONGVARCHAR" DBVARNAME="Request" VALUE="#form.request#" TYPE="IN">
   <cfprocparam CFSQLTYPE="CF_SQL_VARCHAR" DBVARNAME="Contact_Method" VALUE="#form.contact_method#" TYPE="IN">     
	<cfprocresult NAME="myrslt">
</cfstoredproc>


<CFMAIL
	FROM = "webmaster@IllinoisComptroller.Gov"
	TO = "kathyc@IllinoisComptroller.Gov"
	SUBJECT = "Media Request Has Been Sent!">
	
	Hey Kathy, I am a Media person and I want to know something. Can you help me? I think you can by going to:

	 http://ioc-a-intra/mediarequest/index.htm !
</CFMAIL> 
<CFMAIL
	TO = "#FORM.EMAIL#"
	FROM = "kathyc@IllinoisComptroller.Gov"
	SUBJECT = "Media Request Auto Reply">Dear #form.first_Name#,

This is to confirm that your media request was received. You will be hearing from us as soon as we can respond.

Regards,
Kathy Cutler
EARS 
Illinois Comptroller's Office
http://www.IllinoisComptroller.com
</CFMAIL> 



<H2 align="center">Media Request Confirmation</h2>
<p>Thank you for your request. Please return to the <A HREF="http://www.ioc.state.il.us">Comptroller's Front Page</A>.</p>


<cfelse>

<!--- LyLaCapture information wrong --->
    <cflocation url="index.cfm?first_name=#form.first_name#&last_name=#FORM.last_name#&email=#FORM.email#&phone=#FORM.phone#&company=#FORM.company#&request=#FORM.request#&contact_method=#form.contact_method#&TmpError=Yes">
   
</cfif>


