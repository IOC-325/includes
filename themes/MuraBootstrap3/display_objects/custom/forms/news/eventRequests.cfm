<cfif StructKeyExists(form, 'btnSubmit')>

    <CFSET ApprovedFileList = "pdf,jpg,png,jpeg">
    <CFSET variables.FileUploadEventDescDocumentErrorCode = 0>
    <cfset variables.EventDescDocumenServerPath = "">
    <CFSET variables.UploadMessage = "">    

     <CFIF IsDefined ("form.eventDescDocument") AND form.eventDescDocument IS NOT "">            

            <cffile action = "upload" destination = "#ExpandPath('/TempFileUploadPath')#" filefield="form.eventDescDocument" nameconflict="makeunique">

            <CFIF listfindnocase(ApprovedFileList,file.ServerFileExt) GT 0>
                <CFSET variables.nameoffile1 = file.ServerFile>
                <CFSET variables.attachmentsize1 = file.FileSize>
                <CFSET variables.FileUploadEventDescDocumentErrorCode = 0>
                <CFSET variables.UploadMessage = "">
                <CFSET variables.UniqueId = CreateUUID()>               
                <cfset variables.EventDescDocumenServerPath = expandpath('/TempFileUploadPath/EventRequests') & "/"& form.name & "_" & form.organization & "_EventRequest_" & variables.UniqueId & "." & file.ServerFileExt>

                <cffile action="rename"
                    source="#expandpath('/TempFileUploadPath')#/#file.ServerFile#"
                    destination="#variables.EventDescDocumenServerPath#">
            <cfelse>
                <cffile action="delete" file="#expandpath('/TempFileUploadPath')#/#file.ServerFile#">
                <CFSET variables.nameoffile1 = "">
                <CFSET variables.attachmentsize1 = "">
                <CFSET variables.FileUploadEventDescDocumentErrorCode = 1>
                <CFSET variables.UploadMessage = "Cover Letter Invalid File format">
            </cfif>   
    </cfif>


    <cfoutput>
        <cfsavecontent variable="msg">
            <p>
                <b>Name: </b>#form.name#
            </p>

            <p>
                <b>Organization: </b>#form.organization#
            </p>

            <p>
                <b>Email: </b>#form.email#
            </p>

            <p>
                <b>Phone: </b>#form.phone#
            </p>

            <p>
                <b>Proposed Date: </b>#form.proposedDate#
            </p>

            <p>
                <b>Proposed Time: </b>#form.proposedTime#
            </p>

            <p>
                <b>Location: </b>#form.location#
            </p>

            <p>
                <b>Event Description: </b>#form.eventDescription#
            </p>

        </cfsavecontent>
    </cfoutput>

    <cfmail
            to="Amanda.Prentice@illinoiscomptroller.gov;Scott.Goodrich@illinoiscomptroller.gov"
            from="admin@illinoiscomptroller.gov"
            cc="Andy.Peterson@illinoiscomptroller.gov"
            subject="Event Request Form has been Submitted" type="html">
        #msg#
        <cfif IsDefined("variables.EventDescDocumenServerPath") && variables.EventDescDocumenServerPath NEQ "">
            <p>
                event description Document: <em>See attached file</em>
            </p>
        </cfif>            

        <cfif variables.EventDescDocumenServerPath NEQ "">
            <!--- Attach the file. --->
            <cfmailparam
                file="#variables.EventDescDocumenServerPath#"
                />
        </cfif>        
        <br/>
        <p>Thank you!</p>
    </cfmail>

    <cfmail
            to="#form.email#"
            from="admin@illinoiscomptroller.gov"
            cc="Andy.Peterson@illinoiscomptroller.gov"
            subject="Event Request for Comptroller" type="html">
        <p class="text-center">Your event request has been sent to our office. Someone will be in touch shortly. <br/>
            Thank you!</p>
    </cfmail>

<!---     
    <cfset $.getBean('mailer').sendHTML(
              html=msg
            , sendto='#form.email#'
            , subject='Event Requests'
            , siteid=$.event('siteid')
        ) /> --->

    <p class="text-center">Your event request has been sent to our office. Someone will be in touch shortly. <br/> Thank
        you!</p>
<!---     <p>Message Sent. Thank you for taking the time to fill out the form</p> --->
<cfelse>
    <p>Thank you for your interest in partnering with the Office of the Illinois State Comptroller for your event!
        Please provide us with as many details as possible regarding your request to help us accommodate&nbsp;you in the
        best way possible. Please fill out the form below and our office will be in touch.</p>



    <cfform class="searchform" id="searchform" enctype="multipart/form-data"  name="place-complaints" action="" method="post">
        <div class="row">
            <div class="col-sm-12 col-sm-offset-0 col-md-10 col-md-offset-1">
                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">Name</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input name="name" type="text" required class="form-control"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">organization</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input name="organization" type="text" required class="form-control"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">email</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input name="email" type="text" required class="form-control"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">phone number</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input name="phone" type="text" required class="form-control"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">proposed date</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input name="proposedDate" type="text" required class="form-control"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">proposed time</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input name="proposedtime" type="text" required class="form-control"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">location</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <input name="location" type="text" required class="form-control"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                        <div class="btn-label">event description</div>
                    </div>

                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <textarea name="eventDescription" required class="form-control" rows="4"></textarea>
                    </div>
                </div>

                <div class="row">
                    <div class="eventDescDocument">
                        <div class="col-xs-12 col-sm-5 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
                           <div class="btn-label">event description Document</div>
                        </div>
                    <div class="col-xs-12 col-sm-7 col-md-5">
                        <cfinput type="file" name="eventDescDocument" id="eventDescDocument" class="myFile" data-size="1">
                            <p class="help-block"><em>Valid file type: .pdf, jpg, jpeg, png</em><span class="lblError" style="color: red;"></span></p>
                    </div>
                </div>                

                <div class="text-center">
                    <input class="btn btn-success" name="btnSubmit" type="submit" value="Submit"/>
                </div>
            </div>
        </div>
        </div>
    </cfform>

</cfif>


