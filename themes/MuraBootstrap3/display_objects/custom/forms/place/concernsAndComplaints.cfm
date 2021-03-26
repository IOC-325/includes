<cfif StructKeyExists( form, 'btnSubmit' )>

    <cfsavecontent variable="msg">
    <cfoutput>  
    <p>
        <b>Name:</b>#form.name#
    </p>
    
    <p>
        <b>Email:</b>#form.email#
    </p>

    <p>
        <b>Phone:</b>#form.phone#
    </p>

    <p>
        <b>Company:</b>#form.nameofcompany#
    </p>

    <p>
        <b>Details:</b>#form.complaintdetails#
    </p>
    </cfoutput>
    </cfsavecontent>

    <cfmail
          to="PLACE@IllinoisComptroller.Gov"
          from="admin@illinoiscomptroller.gov" 
          cc="Andy.Peterson@illinoiscomptroller.gov"
          subject="PLACE - Concerns and Complaints Form Submission" type="html"  >
          #msg#
         <br/>
          <p>Thank you!</p>
    </cfmail>

    <cfmail
          to="#form.email#"
          from="admin@illinoiscomptroller.gov" 
          cc="Andy.Peterson@illinoiscomptroller.gov"
          subject="PLACE - Concerns and Complaints Form Submission" type="html"  >
         <p class="text-center">Message Sent. Thank you for taking the time to fill out the form. Someone will be in touch shortly. <br/> Thank you!</p>
    </cfmail>

    <p class="text-center">Message Sent. Thank you for taking the time to fill out the form </p> <br/>
<cfelse>
<form class="searchform" id="searchform" name="place-complaints" action="" method="post">

    <div class="row">
      <div class="col-xs-12 col-sm-7 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">Name</div>
      </div>

      <div class="col-xs-12 col-sm-5">
          <input name="name" type="text" class="form-control" />
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-7 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">email</div>
      </div>

      <div class="col-xs-12 col-sm-5">
          <input name="email" type="text" class="form-control" />
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-7 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">phone number</div>
      </div>

      <div class="col-xs-12 col-sm-5">
          <input name="phone" type="text" class="form-control" />
      </div>
    </div>


    <div class="row">
      <div class="col-xs-12 col-sm-7 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">name of company in complaint</div>
      </div>

      <div class="col-xs-12 col-sm-5">
          <input name="nameofcompany" type="text" class="form-control" />
      </div>
    </div>

    <div class="row">
      <div class="col-xs-12 col-sm-7 col-sm-offset-0 col-md-5 col-md-offset-1 label-div">
          <div class="btn-label">details of complaint</div>
      </div>

      <div class="col-xs-12 col-sm-5">
          <textarea name="complaintdetails" class="form-control" rows="4"></textarea>
      </div>
    </div>

        <div class="text-center">
            <input class="btn btn btn-success" name="btnSubmit" type="submit" />
        </div>

</form>
</cfif>


