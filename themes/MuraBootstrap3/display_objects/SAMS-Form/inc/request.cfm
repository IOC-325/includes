<cftry> <!--- Just for testing since mura surpresses exception error messages --->
<cfscript>

/***************************************************************************
* Developer: Zac Ely
* Date: 8/27/18
*
* Included by index.cfm
****************************************************************************/

// Defaults for the form fields

param name="form.isSubmitted" default="false";
param name="form.reCaptchaValid" default="false";

// Requester info fields
param name="form.firstName" default="";
param name="form.lastName" default="";
param name="form.telephone" default="";
param name="form.email" default="";
param name="form.street" default="";
param name="form.city" default="";
param name="form.stateID" default="";
param name="form.zipcode" default="";
param name="form.agencyID" default="";

// Revision info fields
param name="form.revisionType" default="";
param name="form.sectionID" default="";
param name="form.procedureID" default="";
param name="form.reason" default="";
param name="form.description" default="";
param name="form.comments" default="";

// Queries for filling the combo boxes
remote = createObject("component", "Queries.remote");

qAgency = remote.getAgency();
sections = remote.getSections();
qStates = createObject("component", "Queries.states").getStatesPerCountryID(1);

form.sections = sections;
form.qAgency = qAgency;
form.qStates = qStates;

// Recaptcha
creds = {'sitekey'='6Ld142UUAAAAAKGowgtr1TxOCwh9feh5gQA8gUKu', 'secret'='6Ld142UUAAAAAGRAXioLo8U58D7S-YsvdZYlZ6mp'};

if(StructKeyExists(form, 'g-recaptcha-response'))
{
    reCaptcha = createObject("component", "Queries.recaptcha");
    reCaptcha.setSecret(creds.secret);
    resp = reCaptcha.verifyResponse(response=form['g-recaptcha-response'], remoteip=cgi.remote_addr);
}

// Get any error messages from our validate functions for requester and revision fields
if(form.isSubmitted == "true")
{
    revisionComp = createObject("component", "Queries.revisionRequest");

    errorsRequester = revisionComp.validateRequester(form);
    errorsRevision = revisionComp.validateRevision(form);

    // Check if google's response to the captcha was valid
    if(isDefined('resp'))
    {
        if(resp.success)
            form.reCaptchaValid = true;
        else
            arrayAppend(errorsRequester, "The reCaptcha was not valid");
    }

    if(arrayIsEmpty(errorsRequester) && arrayIsEmpty(errorsRevision) && form.reCaptchaValid)
    {
        //Only save digits of telephone number and remove leading 1 if present
        form.telephone = revisionComp.getDigits(form.telephone);

        if(left(form.telephone, 1) == "1")
            form.telephone = right(form.telephone, 10);

        revisionBean = m.getBean('revision').loadBy(revisionID=createUUID());

        // Save revision info to db
        if(form.revisionType == "existing")
        {
            result = revisionBean
                .set('revisionType', form.revisionType)
                .set('procedureNumber', form.procedureID)
                .set('reason', form.reason)
                .set('description', form.description)
                .set('comments', form.comments)
                .save();
        }
        else
        {
            result = revisionBean
                .set('revisionType', form.revisionType)
                .set('section', form.sectionID)
                .set('reason', form.reason)
                .set('description', form.description)
                .set('comments', form.comments)
                .save();
        }

        errorsRv = result.get('errors');

        // If no errors while saving revision, then save requester info
        if(!structCount(errorsRv))
        {
            requesterBean = m.getBean('requester').loadBy(requesterID=createUUID());    // Creates new bean for requester

            // Add do while

            requesterBean
                .set('revisionID', revisionBean.get('revisionID'))
                .set('firstName', form.firstName)
                .set('lastName', form.lastName)
                .set('agencyID', form.agencyID)
                .set('email', form.email)
                .set('street', form.street)
                .set('city', form.city)
                .set('stateID', form.stateID)
                .set('zipcode', form.zipcode)
                .set('telephone', form.telephone)
                .save();
        }
        
    
        // Send revision request data through email
        revisionComp.sendNotification(form);
    }
}

</cfscript>


<cfoutput>
<div id="container">

    <form method="post" enctype="application/x-www-form-urlencoded" name="revisionForm" id="revisionForm">
        <input type="hidden" name="reCaptchaValid" id="reCaptchaValid" <cfif isDefined("form.reCaptchaValid")>value="#form.reCaptchaValid#"<cfelse>value="false"</cfif>>

        <div class="mura-body marginb20">
            <p>The SAMS Manual has been designed to facilitate the adding of new procedures and the revising of existing procedures. All users of this manual are encouraged to recommend revisions to any part of the manual. This webform is designed to record and submit suggested changes to the Comptroller's Office. </p>
        </div>
        <div id="captcha-alert">
        </div>

    <!--- Display message based on the submit event ---> 
        <cfif form.isSubmitted IS 'true'>
            <cfif arrayIsEmpty(errorsRequester) and arrayIsEmpty(errorsRevision) and form.reCaptchaValid>
                <div class="alert alert-success"> 
                    The revision request has been submitted. The Systems Administration Department has been notified of the request.
                </div>
            <cfelseif arrayIsEmpty(errorsRequester) and arrayIsEmpty(errorsRevision)>
                <div class="alert alert-warning">
                    The reCaptcha was not loaded properly, please reload the webform
                </div>
            <cfelseif not arrayIsEmpty(errorsRequester)>
                <div class="alert alert-danger">
                    <cfloop array="#errorsRequester#" index="error">
                        <li class="error-list">#error#</li>
                    </cfloop>
                </div>
            </cfif>
        </cfif>

    <!--- Requester details form layout --->
        <div class="row marginb15">
            <div class="col-sm-12 col-md-3">
                <div class="all-required col-sm-1"> * </div>
                indicates a required field.
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 col-md-6">
                <div class="form-group field-required">
                    <label class="field-label" for="firstName">First Name</label>
                    <input class="form-control" type="text" id="firstName" name="firstName" maxlength="100" />
                </div>
            </div>
            <div class="col-sm-12 col-md-6">
                <div class="form-group field-required">
                    <label class="field-label" for="lastName"> Last Name </label>                    
                    <input class="form-control" type="text" id="lastName" name="lastName" maxlength="100" />
                </div>                
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 col-md-6">
                <div class="form-group field-required">
                    <label class="field-label" for="telephone">Phone Number</label>
                    <input class="form-control" type="text" id="telephone" name="telephone" maxlength="20">
                </div>
            </div>
            <div class="col-sm-12 col-md-6">
                <div class="form-group field-required">
                    <label class="field-label" for="email"> Email</label>
                    <input class="form-control" id="email" name="email" maxlength="90">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 col-md-6 ">
                <div class="form-group field-required">
                    <label class="field-label" for="street">Street Address</label>
                    <input class="form-control" type="text" id="street" name="street" maxlength="255">
                </div>
            </div>
            <div class="col-sm-12 col-md-2">
                <div class="form-group field-required">
                    <label class="field-label" for="city">City</label>
                    <input class="form-control" type="text" id="city" name="city" maxlength="75">
                </div>
            </div>
            <div class="col-sm-6 col-md-2">
                <div class="form-group field-required">
                    <label class="field-label" for="stateID">State</label>
                    <select class="form-control" id="stateID" name="stateID" placeholder="state">
                    <option selected></option>
                        <cfloop query="qStates">
                            <option value="#qStates.StateID#">#qStates.State#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
            <div class="col-sm-6 col-md-2">
                <div class="form-group field-required">
                    <label class="field-label" for="zipcode">ZIP Code</label>
                    <input class="form-control" type="text" id="zipcode" name="zipcode" maxlength="10">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 col-md-6">
                <div class="form-group field-required">
                    <label class="field-label" for="agencyID"> Agency</label>
                    <select class="form-control" name="agencyID" id="agencyID">
                        <option selected></option>
                        <cfloop query="qAgency">
                            <option value="#qAgency.AgencyID#">#qAgency.Agency#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
        </div>

        <h2 class="marginb20"> Revision Details</h2>

        <!--- Display an error message if any errors occured during validation --->
        <cfif form.isSubmitted eq 'true'>  
            <cfif not arrayIsEmpty(errorsRevision)>
                <div class="alert alert-danger">
                    <cfloop array="#errorsRevision#" index="error">
                        <li class="error-list">#error#</li>
                    </cfloop>
                </div>
            </cfif>
        </cfif>

        <div id="type-alert">
        </div>

        <!--- Revision detail form layout --->
        <div class="row">
            <div class="col-sm-12 col-md-6">
                <div class="form-group">
                    <label> New or Existing Procedure </label>
                    <div class="simple-radio">
                        <input class="radio-button" type="radio" name="revisionType" id="new" value="new" onChange="procedureOrSection()"/>
                        <label for="new" class="radio-label"> New</label>
                        <input class="radio-button" type="radio" name="revisionType" id="existing" value="existing" onChange="procedureOrSection()" checked/>
                        <label for="existing" class="radio-label"> Existing</label>
                    </div>
                </div>
            </div>
            <div id="procedureID-container" class="col-sm-12 col-md-6">
                <div class="form-group field-required">
                    <label class="field-label" for="procedureID">Procedure Number</label>
                    <input class="form-control" type="text" id="procedureID" name="procedureID" maxlength="25" placeholder="01.00.00">
                </div>
            </div>
            <div id="section-container" class="col-sm-12 col-md-6" style="display: none">
                <div class="form-group">
                    <label class="field-label" for="sectionID">Section<span class="small text-muted"> (optional)</span></label>
                    <select class="form-control" id="sectionID" name="sectionID"> 
                        <option value="" selected></option>
                        <cfloop query="sections">
                            <option value="#sections.sectionID#">#sections.sectionNumber# - #sections.sectionName#</option>
                        </cfloop>
                    </select> 
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 col-md-6">
                <div class="form-group field-required">
                    <label class="field-label" for="reason">Reason</label>
                    <textarea class="form-control resize-v" id="reason" name="reason" maxlength="500" placeholder="Why this change should be made."></textarea>
                </div>
            </div>
            <div class="col-sm-12 col-md-6">
                <div class="form-group field-required">
                    <label class="field-label" for="description">Description</label>
                    <textarea class="form-control resize-v" id="description" name="description" maxlength="1000" placeholder="Details of the change."></textarea>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class="field-label" for="comments">Comments</label>
                    <textarea class="form-control resize-v" id="comments" name="comments" maxlength="1000" placeholder="Other additional comments."></textarea>
                </div>
            </div>
        </div>
        <div class="text-center">
            <div class="g-recaptcha" data-sitekey="#creds.siteKey#"></div>
        </div>
        <div class="text-center">
            <div class="col-sm-12">
                <input class="btn btn-success" id="validate" name="validate" type="button" value="Submit" onclick="validateSubmission()" >
                
                <!--- Different submit button for testing server side validation more easily --->
<!---                 <input class="btn btn-success" id="validate" name="validate" value="Submit" type="submit" > --->
            </div>
        </div>
    
    	<input type="hidden" id="isSubmitted" name="isSubmitted" value="true" />
    </form>
</div>
</cfoutput>

<script src="https://www.google.com/recaptcha/api.js?hl=en"></script>
<script src="\comptroller\includes\themes\MuraBootstrap3\display_objects\SAMS-Form\assets\js\utilities.js" type="text/Javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!---  Error Handling in case anything throws exceptions --->

<!--- Used during testing because Mura surpresses exception error messages --->
    <cfcatch type="any">

        <cfdump var="#cfcatch#">
        <!--- <cfoutput>
        <p>Error Message: #cfcatch.message#</p>
        <p>Error Detail: #cfcatch.detail#</p>
        <p>Error Location: #GetBaseTemplatePath()#</p>
        </cfoutput> --->
    </cfcatch>
</cftry>
