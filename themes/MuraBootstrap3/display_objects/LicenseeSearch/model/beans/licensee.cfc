component output="false" accessors="true"
{
  remote function getLicenseeAutoSuggest (string term)
  {
   var q = new storedProc();
   var result = [];
   q.setDatasource("PUBLIC_PLACE");
   q.setProcedure("getAllLicenseeInformationByFilters");
   q.addParam(cfsqltype="cf_sql_varchar", type="in", value=arguments.term, dbvarname="@searchText");
   q.addProcResult(name="rs1",resultset=1);
   var result = q.execute();
   getLicensees=result.getProcResultSets().rs1;
   for(i=1;i<=getLicensees.recordCount;i++){
    result[i] = getLicensees.SearchContent[i];
   }
   return result;
  }

  public query function getLicensee (string searchText)
  {
   var q = new storedProc();
   q.setDatasource("PUBLIC_PLACE");
   q.setProcedure("getAllLicenseeInformationByFilters");
   q.addParam(cfsqltype="cf_sql_varchar", type="in", value=#searchText#, dbvarname="@searchText");
   q.addProcResult(name="qListOfLicenseeDetails",resultset=1);
   var result = q.execute();
   // writeDump(result.getProcResultSets().qListOfLicenseeDetails);
   // abort;
   return result.getProcResultSets().qListOfLicenseeDetails;
   // queryObj = new query();
   // queryObj.setDatasource("PUBLIC_PLACE");
   // queryObj.setName("qListOfLicenseeDetails");
   // queryObj.addParam(name="search",value="%#rc#%",cfsqltype="cf_sql_varchar");
   // result = queryObj.execute(sql="SELECT LICENSEE_NUMBER,[LICENSEE_CODE],LICENSEE_TYPE_NAME,[LICENSEE_NAME],[BUSINESS_NAME],[LICENSEE_ADDRESS],[LICENSEE_CITY],[LICENSEE_STATE],[LICENSEE_ZIP],[LICENSEE_PHONE],[LICENSEE_FAX],LICENSEE_COUNTRY AS COUNTY,LICENSEE_STATUS,Convert(varchar(10),DATE_ISSUED,101) as DATE_ISSUED,CONTACT_PERSON_LAST_NAME + ' '+ CONTACT_PERSON_FIRST_NAME AS CONTACT_NAME,CONTACT_PHONE,Convert(varchar(10),ANNAUL_REPORTING_DUE_DATE,101) as ANNAUL_REPORTING_DUE_DATE FROM [dbo].[vw_LICENSEE] where LICENSEE_NAME LIKE :search order by BUSINESS_NAME");
   // qListOfLicenseeDetails = result.getResult();
   // //writeDump(qListOfLicensee);
   // return qListOfLicenseeDetails;
  }

  public query function getLicenseeDetails (string id)
  {
   var q = new storedProc();
   q.setDatasource("PUBLIC_PLACE");
   q.setProcedure("getAllLicenseeInformationByLicenseeNumber");
   q.addParam(cfsqltype="cf_sql_varchar", type="in", value=#id#, dbvarname="@searchText");
   q.addProcResult(name="qListOfLicenseeDetails",resultset=1);
   var result = q.execute();
   return result.getProcResultSets().qListOfLicenseeDetails;
   // queryObj = new query();
   // queryObj.setDatasource("PUBLIC_PLACE");
   // queryObj.setName("qListOfLicenseeDetails");
   // queryObj.addParam(name="licensee_number",value="#rc#",cfsqltype="cf_sql_int");
   // result = queryObj.execute(sql="SELECT LICENSEE_NUMBER,[LICENSEE_CODE],LICENSEE_TYPE_NAME,[LICENSEE_NAME],[BUSINESS_NAME],[LICENSEE_ADDRESS],[LICENSEE_CITY],[LICENSEE_STATE],[LICENSEE_ZIP],[LICENSEE_PHONE],[LICENSEE_FAX],LICENSEE_COUNTRY AS COUNTY,LICENSEE_STATUS,Convert(varchar(10),DATE_ISSUED,101) as DATE_ISSUED,CONTACT_PERSON_LAST_NAME + ' '+ CONTACT_PERSON_FIRST_NAME AS CONTACT_NAME,CONTACT_PHONE,Convert(varchar(10),ANNAUL_REPORTING_DUE_DATE,101) as ANNAUL_REPORTING_DUE_DATE FROM [dbo].[vw_LICENSEE] where LICENSEE_NUMBER = :licensee_number");
   // qListOfLicenseeDetails = result.getResult();
   //writeDump(qListOfLicensee);
   //return qListOfLicenseeDetails;
  }

  public function setComplaintIfo (rc)
  {
   var q = new storedProc();
   q.setDatasource("PUBLIC_PLACE");
   q.setProcedure("setpublicUserComplaint");
   q.addParam(cfsqltype="cf_sql_varchar", type="in", value=#rc.FNAME#, dbvarname="@firstName");
   q.addParam(cfsqltype="cf_sql_varchar", type="in", value=#rc.LNAME#, dbvarname="@lastName");
   q.addParam(cfsqltype="cf_sql_varchar", type="in", value=#rc.phone#, dbvarname="@phone");
   q.addParam(cfsqltype="cf_sql_varchar", type="in", value=#rc.phoneExt#, dbvarname="@phoneExt");
   q.addParam(cfsqltype="cf_sql_varchar", type="in", value=#rc.address#, dbvarname="@Address");
   q.addParam(cfsqltype="cf_sql_varchar", type="in", value=#rc.complaint#, dbvarname="@ComplaintInfo");
   q.addProcResult(name="qListOfLicenseeDetails",resultset=1);
   var result = q.execute();
   //writeDump(ListToArray(result.getProcResultSets().qListOfLicenseeDetails.Recent_ID));
   //abort();
   return result.getProcResultSets().qListOfLicenseeDetails.Recent_ID;
  }
  public function sendComplaintEmail (rc)
  {
   mailerService = new mail();
   var complaintPhone = rc.phone;
   if(rc.phoneExt neq '')
    complaintPhone = complaintPhone & " (" &  rc.phoneExt & ") ";
   savecontent variable="mailBody"{
       WriteOutput("Below is the complaint information submitted by " & rc.LNAME & " ," & rc.FNAME & " :" & "<br><br>" & rc.complaint & ".<br><br>" & "His/her Contact Phone is : " & complaintPhone & ", Email is " & rc.address);
   }
   /* set mail attributes using implicit setters provided */
   mailerService.setTo(#application.placeBCCEmail#);
   mailerService.setFrom(#application.placeBCCEmail#);
   mailerService.setSubject('Complaint');
   mailerService.setType("html");
   // /* add mailparams */
   // mailerService.addParam(file=expandpath(form.attachment),type="text/plain",remove=false);
   /* send mail using send(). Attribute values specified in an end action like "send" will not persist after the action is performed */
   mailerService.send(body=mailBody);
  }
}