<!-- Default results for Salary Employee Database landing page -->

<cfset structFilData = structnew()>
<cfset structFilData.Agency = variables.Agency/>
<cfset structFilData.Issue_Year = variables.Issue_Year />

<cfinvoke component = "ledger.includes.display_objects.custom.EmplSalarySQL.Component.EmployeeSalary"
method = "GetAgencySalary2"
returnVariable = "GetAgencySalary">
<cfinvokeargument name="structData" value="#structFilData#">
</cfinvoke>

<cfinvoke component = "ledger.includes.display_objects.custom.EmplSalarySQL.Component.EmployeeSalary"
method = "GetTotAgencySalary2"
returnVariable = "GetTotAgencySalary">
<cfinvokeargument name="AgencyQuery" value="#GetAgencySalary#">
</cfinvoke>


<cfoutput>

<table class="table table-striped datatable ManualTable">
    <thead>
    <tr>
        <th class="bg-info text-center">Agency</th>
        <th class="bg-info text-center">No. of Employees</th>
        <th class="bg-info text-center">YTD Gross</th>
    </tr>
    </thead>
    <tbody>
    <cfloop query="GetAgencySalary">
    <tr>
        <td width="20%" align="left">
         <a href="/financial-data/state-expenditures/employee-salary-database?Issue_Year=#variables.Issue_Year#&Agency=#ltrim(rtrim(Agency))#&EmpId=&Last_Name=&Position=#Position#">
          #trim(Agency)#</a>
        </td>
        <td width="15%" align="right">#NumberFormat(NUMBER_OF_EMPLOYEES,"999,999")#</td>
        <td width="25%" align="right">&nbsp;$ #NumberFormat(YTD_Gross,"999,999,999,999")#</td>
    </tr>
    </cfloop>
    </tbody>
    <tfoot>
        <tr>
        <td width="20%"><b>Grand Totals</b></td>
        <td width="15%" align="right" style="white-space: nowrap;"><b>$ #NumberFormat(GetTotAgencySalary.TotEmployees,"999,999,999")#</b></td>
        <td width="25%" align="right" style="white-space: nowrap;"><b>&nbsp;<cfif GetTotAgencySalary.TotYTDGross NEQ "">$ #NumberFormat((Round(GetTotAgencySalary.TotYTDGross/100) * 100),"999,999,999,999")#</cfif></b></td>
    </tr>
    </tfoot>
</table>
</cfoutput>