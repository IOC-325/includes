<cfset structFilData = structnew()>
<cfset structFilData.Agency = variables.Agency/>
<cfset structFilData.FindLastName = variables.FindLastName />
<cfset structFilData.FindFirstName = variables.FindFirstName />
<cfset structFilData.SalaryRange = variables.SALARYRANGE />
<cfif variables.Position neq "">
 <cfset structFilData.Position = trim(variables.Position) />
</cfif>
<cfif variables.Issue_Year neq "0" AND variables.Issue_Year neq "">
 <cfset structFilData.IssueYear = variables.Issue_Year />
<!--- <cfelse>
  <CFIF Quarter(NOW()) GTE 2>
   <CFSET variables.Issue_Year = DATEFORMAT(NOW(), 'yyyy') +  1>
  <cfelse>
   <CFSET variables.Issue_Year = DATEFORMAT(NOW(), 'yyyy')>
  </CFIF>
  <cfset structFilData.IssueYear = variables.Issue_Year /> --->
</cfif>
<cfif variables.EmpId neq "">
 <cfset structFilData.EmpId = trim(variables.EmpId) />
</cfif>
<cfif variables.Agency eq "">
 <cfset structFilData.Agency = 0 />
</cfif>


<cfinvoke component = "ledger.includes.display_objects.custom.EmplSalarySQL.Component.EmployeeSalary"
      method = "GetEmployeeHistory2"
      returnVariable = "qEH">
   <cfinvokeargument name="structData" value="#structFilData#">
 </cfinvoke>



<cfoutput>

<CFIF qEH.recordcount GTE 2500>
	<div class="alert alert-warning" role="alert">Your request has generated over 2,500 records. Please refine your search and submit again</div>
<cfelse>
  Records found: #qEH.recordcount# <!--- <cfdump var="#qeh#"> --->
</CFIF>
          <p><b>Issue Year:</b> <cfif variables.Issue_Year is 0>
           ALL <cfelse>#variables.Issue_Year#</cfif></p>
          <cfif variables.Agency neq "" and variables.Agency neq "0">
           <p><b>Agency:</b> <cfset TmpAgency="#URLEncodedFormat(trim(Agency))#">
           #trim(variables.Agency)#</p>
          </cfif>
     <table class="table table-striped datatable ManualTable" width="100%">
      <thead>
        <tr>
         <cfif trim(variables.Agency) is not "">
          <th class="bg-info text-center">Name</th>
          <th class="bg-info text-center">Position</th>
         <cfelse>
          <th class="bg-info text-center">Name</th>
          <th class="bg-info text-center">Agency</th>
          <th class="bg-info text-center">Position</th>
         </cfif>
         <th class="cldate bg-info text-center">Last Paid</th>
         <th class="bg-info text-center"><div class="show-tooltip" data-toggle="tooltip" data-placement="top" title="Rate of pay is determined by the employer.">Rate of Pay</div></th>
         <th class="bg-info text-center">YTD Gross</th>
        </tr>
       </thead>
       <tbody>
         <cfloop query="qEH" >
               <tr>
               <cfset TmpAgency="#URLEncodedFormat(trim(Agency))#"><cfset TmpPosition="#URLEncodedFormat(trim(Position))#">
               <cfif trim(variables.Agency) is not "">
                  <td>
                    <a href="/financial-data/state-expenditures/employee-salary-database/employee-history?Issue_Year=#variables.Issue_Year#&EmpId=#UrlEncodedformat(encrypt(Last4, application.theKey, application.theAlgor, application.TheEncode))#&Agency=#UrlEncodedformat(trim(TmpAgency))#&Last_Name=#trim(Last_Name)#&First_Name=#trim(First_Name)#&Position=">
                     #trim(Last_Name)#, #trim(First_Name)#
                    </a>
                  </td>
                  <td>
                    <a href="/financial-data/state-expenditures/employee-salary-database?Issue_Year=#variables.Issue_Year#&EmpId=#UrlEncodedformat(encrypt(Last4, application.theKey, application.theAlgor, application.TheEncode))#&Agency=&Last_Name=&First_Name=&Position=#TmpPosition#">
                     #trim(Position)#
                    </a>
                  </td>
                <cfelse>
                  <td>
                   <a href="/financial-data/state-expenditures/employee-salary-database/employee-history?Issue_Year=#variables.Issue_Year#&EmpId=#UrlEncodedformat(encrypt(Last4, application.theKey, application.theAlgor, application.TheEncode))#&Agency=#UrlEncodedformat(trim(TmpAgency))#&Last_Name=#trim(Last_Name)#&First_Name=#trim(First_Name)#&Position=">
                    #trim(Last_Name)#, #trim(First_Name)#</a></td>
                  <td>
                   <a href="/financial-data/state-expenditures/employee-salary-database?Issue_Year=#variables.Issue_Year#&EmpId=#UrlEncodedformat(encrypt(Last4, application.theKey, application.theAlgor, application.TheEncode))#&Agency=#TmpAgency#&Last_Name=&First_Name=&Position=">#trim(Agency)#</a></td>
                  <td><a href="/financial-data/state-expenditures/employee-salary-database?Issue_Year=#variables.Issue_Year#&EmpId=#UrlEncodedformat(encrypt(Last4, application.theKey, application.theAlgor, application.TheEncode))#&Agency=&Last_Name=&First_Name=&Position=#TmpPosition#">#trim(Position)#</a></td>
                </cfif>
                <td>#DateFormat(LAST_PAID_DATE,"mm/dd/yyyy")#</td>
                <td style="text-align: right;"><cfif Rate_Of_Pay LTE 500>$ #NumberFormat(Round(Rate_Of_Pay),"999,999,999,999")#<cfelse>$ #NumberFormat((Round(Rate_Of_Pay/100) * 100),"999,999,999,999")#</cfif></td>
                <td style="text-align: right;"><cfif YTD_Gross NEQ "">$ #NumberFormat((Round(YTD_Gross/100) * 100),"999,999,999,999")#</cfif></td>
               </tr>
         </cfloop>
       </tbody>
     </table>
</cfoutput>