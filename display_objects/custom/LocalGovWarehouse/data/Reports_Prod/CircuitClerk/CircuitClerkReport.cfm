<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<cfset Code=ArrayNew(1)>
<cfset County_Name=ArrayNew(1)>
<cfset DtReport_Received=ArrayNew(1)>
<cfset DtAuditAuth_Resubmit=ArrayNew(1)>
<cfset Drivers_Education_Fund=ArrayNew(1)>
<cfset Violent_Crime_Fund=ArrayNew(1)>
<cfset Domestic_Violance_Shelter_Fund=ArrayNew(1)>
<Cfset Domestic_Violance_Service_Fund=ArrayNew(1)>
<Cfset Sex_Offender_Fund=ArrayNew(1)>
<cfset DtAuditReport_Received=ArrayNew(1)>
<cfset DtFundsAuth_Resubmit=ArrayNew(1)>
<!---<cfset CircuitClerk = structNew()>--->

<cfStoredProc datasource="AFRUAT" Procedure="Get_County">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCountyRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCountyRetMsg">
	<cfprocresult name="GetCounty">
</cfstoredproc>

<cfset i=0>
<cfloop query="GetCounty">	
	<cfoutput>
 	<cfset i=i+1>
	<cfset Code[i]="#NumberFormat(GetCounty.County_Code,"099")#">
	<cfset County_Name[i]="#GetCounty.County#"> 
    
    <cfset TmpCode = "#GetCounty.County_Code#" & "/000/00">
    
    <cfStoredProc datasource="AFRUAT" Procedure="Get_AuditInfo">
        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#TmpCode#">
        <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@FY" value="#url.CFY#">
        <cfprocparam type="In"  cfsqltype="CF_SQL_VarChar" dbvarname="@Instrument" value="Circuit Clerk Funds">
        <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAuditInfoRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAuditInfoRetMsg">
        <cfprocresult name="GetAuditInfo">
    </cfstoredproc>
  
    <cfStoredProc datasource="AFRUAT" Procedure="Get_CircuitClerkListFunds">
        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#TmpCode#">
        <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@FY" value="#url.CFY#">
        <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetListFundsRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetListFundsRetMsg">
        <cfprocresult name="GetListFunds">
    </cfstoredproc> 
    
    <cfStoredProc datasource="AFRUAT" Procedure="Get_AuditInfo">
        <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#TmpCode#">
        <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@FY" value="#url.CFY#">
        <cfprocparam type="In"  cfsqltype="CF_SQL_VarChar" dbvarname="@Instrument" value="Circuit Clerk Annual Audit">
        <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetAuditReportInfoRetVal">
        <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetAuditReportInfoRetMsg">
        <cfprocresult name="GetAuditReportInfo">
    </cfstoredproc>    
    
   	<!--- Calculate Due Date for Report --->
    <cfset Due_Date = "03/31/" & #url.CFY#+1>

    <!--- Funds Report Received --->
    <cfif trim(GetAuditInfo.RecDate) is not "">
		<cfset DtReport_Received[i]="#DateFormat(GetAuditInfo.RecDate,"mm/dd/yyyy")#">
    <cfelseif trim(GetAuditInfo.RecDate) is "" and (now() gt Due_Date)>
		<cfset DtReport_Received[i]="Delinquent">     
    <cfelse>
    	<cfset DtReport_Received[i]="No Report">
    </cfif>
    
    <!--- Drivers Eduction Fund --->
    <cfif trim(GetListFunds.Drivers_Education_Fund) is not "">
		<cfset Drivers_Education_Fund[i]="#GetLIstFunds.Drivers_Education_Fund#">   
    <cfelse>
    	<cfset Drivers_Education_Fund[i]="No Report">
    </cfif>
    
    <!--- Violent Crime Fund --->
    <cfif trim(GetListFunds.Violent_Crime_Fund) is not "">
		<cfset Violent_Crime_Fund[i]="#GetLIstFunds.Violent_Crime_Fund#">   
    <cfelse>
    	<cfset Violent_Crime_Fund[i]="No Report">
    </cfif>
    
    <!--- Domestic Violance Shelter Fund --->
    <cfif trim(GetListFunds.Domestic_Violance_Shelter_Fund) is not "">
		<cfset Domestic_Violance_Shelter_Fund[i]="#GetLIstFunds.Domestic_Violance_Shelter_Fund#">   
    <cfelse>
    	<cfset Domestic_Violance_Shelter_Fund[i]="No Report">
    </cfif>
    
    <!--- Domestic Violance Service Fund --->
    <cfif trim(GetListFunds.Domestic_Violance_Service_Fund) is not "">
		<cfset Domestic_Violance_Service_Fund[i]="#GetLIstFunds.Domestic_Violance_Service_Fund#">   
    <cfelse>
    	<cfset Domestic_Violance_Service_Fund[i]="No Report">
    </cfif>
    
    <!--- Sex Offende Fund --->
    <cfif trim(GetListFunds.Sex_Offender_Fund) is not "">
		<cfset Sex_Offender_Fund[i]="#GetListFunds.Sex_Offender_Fund#">   
    <cfelse>
    	<cfset Sex_Offender_Fund[i]="No Report">
    </cfif>
    
    <!--- Funds Audit Auth Resubmit --->
    <cfif trim(GetAuditInfo.AuthResubmit) is not "">
    	<cfset DtFundsAuth_Resubmit[i]="#DateFormat(GetAuditInfo.AuthResubmit,"mm/dd/yyyy")#"> 
    <cfelse>	
    	<cfset DtFundsAuth_Resubmit[i] = "No Report">
    </cfif>
    
   	<!--- Calculate Due Date for Report --->
     <cfset AuditDue_Date = "06/30/" & #url.CFY#+1>
    
    <!--- Audit Report Received --->
    <cfif trim(GetAuditReportInfo.RecDate) is not "">
		<cfset DtAuditReport_Received[i]="#DateFormat(GetAuditReportInfo.RecDate,"mm/dd/yyyy")#"> 
    <cfelseif trim(GetAuditReportInfo.RecDate) is "" and (now() gt AuditDue_Date)> 
		<cfset DtAuditReport_Received[i]="Delinquent">     
    <cfelse>
    	<cfset DtAuditReport_Received[i]="No Report"> 
    </cfif>
    
    <!--- Audit Auth Resubmit --->
    <cfif trim(GetAuditReportInfo.AuthResubmit) is not "">
    	<cfset DtAuditAuth_Resubmit[i]="#DateFormat(GetAuditReportInfo.AuthResubmit,"mm/dd/yyyy")#"> 
    <cfelse>	
    	<cfset DtAuditAuth_Resubmit[i] = "No Report">
    </cfif>
    </cfoutput>
</cfloop>

<body>
<cfdocument format="PDF" margintop=".1" marginbottom=".2" marginright=".2" marginleft=".2" mimetype="text/html" orientation="landscape" authpassword="IOCCircuitClerk2">
<cfoutput>
<center><b><font size="+1">Circuit Clerk Funds Report for #url.CFY#</font></b><Br />
<img src="Report2.png" class="img-responsive" width="20" height="20"> = Audit Report &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Report1.png" class="img-responsive" width="20" height="20"> = Supplimental Information</center>
 <table border="1" width="100%" cellspacing="1" cellpadding="1">
     <TR>
        <TD align="Center" id="WarrantNo"><b><br /><br />County<br>Code</b></TD>
		<TD align="Center" id="WarrantNo"><b><br /><br />County<br>Name</b></TD>
        <TD align="Center" id="WarrantNo"><b><br />Date Report<br />Received</b></TD>	
        <TD align="Center" id="WarrantNo"><b><br />Drivers<br />Eduction<br />Fund</b></TD>     
		<TD align="Center" id="WarrantNo"><b>Violent<br />Crime Victims<br />Assistance Fund</b></TD>  	
        <TD  align="center" id="WarrantNo"><b>Domestic Violence<br />Shelter and<br />Service Fund</b></TD>
		<TD align="Center" id="WarrantNo"><b>Domestic<br />Violence Abuser<br />Services Fund</b></TD> 
		<TD align="center" id="WarrantNo"><b><br />Sex Offender<br />Investigation Fund</b></TD> 
        <TD align="Center" id="WarrantNo"><b><br />Date<br />Audit<br />Received</b></TD>  
        <TD align="Center" id="WarrantNo"><b><br /><br />Audit<br />Report</b></TD> 
     </TR>
    <cfloop index="j" from="1" to="102">
    	<cfif DtAuditReport_Received[j] is not "No Report">
        	<cfset TmpCode = "#Code[j]#" & "/000/00">
            <cfStoredProc datasource="AFRUAT" Procedure="Get_CircuitClerkAuditList">
                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#TmpCode#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@FY" value="#url.CFY#">
                <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCircuitClerkAuditListRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCircuitClerkAuditListRetMsg">
                <cfprocresult name="GetCircuitClerkAuditList">
            </cfstoredproc>
            
            <cfStoredProc datasource="AFRUAT" Procedure="Get_CircuitClerkAuditListSupDoc">
                <cfprocparam type="In"  cfsqltype="cf_sql_Char" dbvarname="@Code" value="#TmpCode#">
                <cfprocparam type="In"  cfsqltype="CF_SQL_char" dbvarname="@FY" value="#url.CFY#">
                <cfprocparam type="Out"  cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="GetCircuitClerkAuditListRetVal">
                <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="GetCircuitClerkAuditListRetMsg">
                <cfprocresult name="GetCircuitClerkAuditListSupDoc">
            </cfstoredproc>
        </cfif>
     	<TR>
        <TD align="Center" id="WarrantNo">#Code[j]#</TD>
		<TD align="Center" id="WarrantNo">#County_Name[j]#</TD>
        <cfif DtReport_Received[j] is "No Report" or DtFundsAuth_Resubmit[j] is not "No Report">
        	<TD align="Center" id="WarrantNo">&nbsp;</TD>	
            <TD align="Center" id="WarrantNo">&nbsp;</TD>    
            <TD align="Center" id="WarrantNo">&nbsp;</TD>  	
            <TD align="Center" id="WarrantNo">&nbsp;</TD>
            <TD align="Center" id="WarrantNo">&nbsp;</TD> 
            <TD align="Center" id="WarrantNo">&nbsp;</TD> 
        <cfelse>
            <TD align="Center" id="WarrantNo"><cfif DtReport_Received[j] is "Delinquent">Delinquent<cfelse>#DateFormat(DtReport_Received[j],"mm/dd/yyyy")#</cfif></TD>	
            <TD align="right" id="WarrantNo"><cfif Drivers_Education_Fund[j] is "No Report">&nbsp;<cfelse>#NumberFormat(Drivers_Education_Fund[j],"999,999,999,999,999,999.99")#</cfif></TD>     
            <TD align="right" id="WarrantNo"><cfif Violent_Crime_Fund[j] is "No Report">&nbsp;<cfelse>#NumberFormat(Violent_Crime_Fund[j],"999,999,999,999,999,999.99")#</cfif></TD>  	
            <TD  align="right" id="WarrantNo"><cfif Domestic_Violance_Shelter_Fund[j] is "No Report">&nbsp;<cfelse>#NumberFormat(Domestic_Violance_Shelter_Fund[j],"999,999,999,999,999,999.99")#</cfif></TD>
            <TD align="right" id="WarrantNo"><cfif Domestic_Violance_Service_Fund[j] is "No Report">&nbsp;<cfelse>#NumberFormat(Domestic_Violance_Service_Fund[j],"999,999,999,999,999,999.99")#</cfif></TD> 
            <TD align="right" id="WarrantNo"><cfif Sex_Offender_Fund[j] is "No Report">&nbsp;<cfelse>#NumberFormat(Sex_Offender_Fund[j],"999,999,999,999,999,999.99")#</cfif></TD> 
        </cfif> 
        <cfif DtAuditReport_Received[j] is "No Report" or DtAuditAuth_Resubmit[j] is not "No Report" >
        	<TD align="Center" id="WarrantNo">&nbsp;</TD>
            <TD align="Center" id="WarrantNo">&nbsp;</TD>
        <cfelse>
            <TD align="Center" id="WarrantNo">
				<cfif DtAuditReport_Received[j] is "Delinquent">
                	Delinquent
           		<cfelse>
                	#DateFormat(DtAuditReport_Received[j],"mm/dd/yyyy")#
              	</cfif>
            </TD> 
            <TD align="Center" id="WarrantNo">
            	<cfloop query="GetCircuitClerkAuditList">
                	<a href="https://ftp.illinoiscomptroller.gov/CircuitClerkDev/FY#url.CFY#/#Replace(TmpCode,"/","","all")#/#GetCircuitClerkAuditList.FileName#.pdf" target="_new"><img src="Report2.png" class="img-responsive" width="20" height="20"><!---<span class="glyphicon glyphicon-file"></span><span class="glyphicon glyphicon-file">---></span></a>
               	</cfloop>
                <cfloop query="GetCircuitClerkAuditListSupDoc">
                	<a href="https://ftp.illinoiscomptroller.gov/CircuitClerkDev/FY#url.CFY#/#Replace(TmpCode,"/","","all")#/#GetCircuitClerkAuditList.FileName#.pdf" target="_new"><img src="Report1.png" class="img-responsive" width="20" height="20"><!---<span class="glyphicon glyphicon-file"></span><span class="glyphicon glyphicon-file">---></span></a>
               	</cfloop>
            </TD>
       	</cfif>  
     </TR>
     </cfloop>
</cfoutput>
</cfdocument> 
</body>
</html>