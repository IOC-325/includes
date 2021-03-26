<link href="/ledger/includes/themes/TheLedger/css/pageloading.css" rel="stylesheet" type="text/css" />
<link href="/comptroller/includes/themes/MuraBootstrap3/assets/datatable/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<CFSET variables.Issue_Year = URL.Issue_Year>
<cfif isDefined("url.Agency")>
 <CFSET variables.Agency = TRIM(URLDecode(url.Agency, 'utf-8'))>
<cfelse>
 <CFSET variables.Agency = "">
</cfif>
<cfif isDefined("url.Position")>
 <CFSET variables.Position = TRIM(URLDecode(url.Position, 'utf-8'))>
<cfelse>
 <CFSET variables.Position = "">
</cfif>
<cfset variables.BegRange = "">
<cfif variables.BegRange eq "">
 <cfset variables.BegRange =  0>
</cfif>
<cfset variables.EndRange = "">
<cfif variables.EndRange eq "">
 <cfset variables.EndRange =  400>
</cfif>
<CFSET variables.SalaryRange = "#BegRange#,#EndRange#">
<cfif isDefined("url.First_Name")>
 <CFSET variables.FindFirstName = TRIM(URLDecode(url.First_Name, 'utf-8'))>
<cfelse>
 <CFSET variables.FindFirstName = "">
</cfif>
<cfif isDefined("url.Last_Name")>
 <CFSET variables.FindLastName = TRIM(URLDecode(url.Last_Name, 'utf-8'))>
<cfelse>
 <CFSET variables.FindLastName = "">
</cfif>
<cfif isDefined("url.EmpId")>
 <CFSET variables.EmpId = TRIM(URLDecode(url.EmpId, 'utf-8'))>
<cfelse>
 <CFSET variables.EmpId = "">
</cfif>

<cfset structFilData = structnew()>
<cfset structFilData.Agency = variables.Agency/>
<cfset structFilData.FindLastName = variables.FindLastName />
<cfset structFilData.FindFirstName = variables.FindFirstName />
<cfif variables.Position neq "">
 <cfset structFilData.Position = trim(variables.Position) />
</cfif>
<cfset structFilData.IssueYear = variables.Issue_Year />
<cfif variables.EmpId neq "">
 <cfset structFilData.EmpId = trim(variables.EmpId) />
</cfif>
<cfif variables.Agency eq "">
 <cfset structFilData.Agency = 0 />
</cfif>
 <cfset CFY = #variables.Issue_Year#>
 <cfset PFY = #variables.Issue_Year#-1>
 <cfset PFY2 = #variables.Issue_Year#-2>

<cfinvoke component = "ledger.includes.display_objects.custom.EmplSalarySQL.Component.EmployeeSalary"
      method = "GetEmployeeHistory4"
      returnVariable = "qEH">
   <cfinvokeargument name="structData" value="#structFilData#">
 </cfinvoke>

<cfoutput>
<div class="row">
    <div class="col-sm-12">

 Records found: #qEH.recordcount#

<p>Below is the salary history of the employee that you requested.</p>
<table class="table table-striped table-condensed">
 <thead class="thead-default">
   <tr>
    <th>Name</th>
    <th>Agency</th>
    <!--- <th>Division</th> --->
   </tr>
 </thead>
 <tbody>
   <cfif qEH.recordcount>
    <cfloop query="qEH" startrow="1" endrow="1">
     <cfset TmpAgency="#URLEncodedFormat(trim(Agency))#">
    <tr>
      <td>#trim(Last_Name)#, #trim(First_Name)#</td>
      <td>
        <a href="/financial-data/state-expenditures/employee-salary-database/">#trim(Agency)#</a>
       </td>
      <!--- <td><cfif trim(agency) neq "department of corrections">#trim(Division)#</cfif></td> --->
    </tr>
    </cfloop>
   </cfif>
 </tbody>
</table>

<table class="table table-striped datatable" width="100%">
  <thead>
        <tr>
         <th class="bg-info text-center">Agency</th>
         <th class="bg-info text-center">Position</th>
         <th class="bg-info text-center">Last Paid Dt</th>
         <th class="bg-info text-center">Issue Year</th>
         <th class="bg-info text-center"><div class="show-tooltip" data-toggle="tooltip" data-placement="top" title="Rate of Pay is determined by the employer.">Rate of Pay</div></th>
         <th class="bg-info text-center">YTD Gross</th>
        </tr>
  </thead>
  <tbody>
<cfif qEH.recordcount>

  <cfloop  query="qEH">
   <cfset TmpAgency="#URLEncodedFormat(trim(Agency))#">
   <cfset TmpPosition="#URLEncodedFormat(trim(Position))#">
        <tr>
          <td>
           <a href="/financial-data/state-expenditures/employee-salary-database?Issue_Year=#CFY#&EmpId=&Agency=#TmpAgency#&Last_Name=&Position=&BegRange=&EndRange=&StartRec=1&EndRec=20&Groupby=Position">
             #trim(Agency)#
            </a>
          </td>
        <td>
         <a href="/financial-data/state-expenditures/employee-salary-database?Issue_Year=#CFY#&EmpId=&Agency=&Last_Name=&Position=#tmpPosition#&BegRange=&EndRange=&StartRec=1&EndRec=20&Groupby=Position">
          #trim(Position)#
         </a>
      </td>
    <td>#DateFormat(LAST_PAID_DATE,"mm/dd/yyyy")#</td>
    <td>#Issue_Year#</td>
    <td style="text-align: right;"><cfif Rate_Of_Pay LTE 500>$ #NumberFormat(Round(RATE_OF_PAY),"999,999,999,999")#<cfelse>$ #NumberFormat((Round(RATE_OF_PAY/100) * 100),"999,999,999,999")#</cfif></td>
    <td style="text-align: right;"><cfif YTD_Gross NEQ "">$ #NumberFormat((Round(YTD_Gross/100) * 100),"999,999,999,999")#</cfif></td>
        </tr>
  </cfloop>
</cfif>
</tbody>
</table>
</div>
</div>
</cfoutput>
