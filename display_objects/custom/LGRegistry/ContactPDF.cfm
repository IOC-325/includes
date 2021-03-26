
<!--- Pseudo Code for changes
PDF output for results from the Contact Information page --->

<html>
<head>
	<title>Contact PDF</title>
</head>

<body>

<!--- creating PDF output --->
<cfdocument format="pdf"
orientation = "landscape">
<cfinclude template="NumbersOnly.cfm">
<cfinclude template="PhoneFormat.cfm">

<CFPARAM NAME="View" DEFAULT="">
<CFPARAM NAME="form.county" DEFAULT="">
<CFPARAM NAME="form.govType" DEFAULT="">
<CFPARAM NAME="form.alpha" DEFAULT="">
<CFPARAM NAME="newTypeList" DEFAULT="">
<CFPARAM NAME="UnitName" DEFAULT="">
<CFPARAM NAME="SelUnitCode2" DEFAULT="">
<CFPARAM NAME="list" DEFAULT="''">

<CFIF ISDEFINED("form.SelUnitCode2") and len(form.SelUnitCode2) le 8000> 

<cfStoredProc datasource="#application.LocalGovernmentDatasource#" Procedure="Reg_getList">
      <cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@Code" value="#Trim(form.SelUnitCode2)#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="RegSelUnitCodeRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="RegSelUnitCodeRetMsg">
	<cfprocresult name="getList">
</cfstoredproc>

<cfStoredProc datasource="#application.LocalGovernmentDatasource#" Procedure="Reg_TotCount">
      <cfprocparam type="In"  cfsqltype="cf_sql_VarChar" dbvarname="@Code" value="#Trim(form.SelUnitCode2)#">
	<cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="RegTotCountRetVal">
	<cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="RegTotCountRetMsg">
	<cfprocresult name="totCount">
</cfstoredproc>

</cfif>

<center><font size="+5">Contact Information</font></center>

<!--- text output --->
<p>Your search for <CFPARAM NAME="lstUnitName" DEFAULT="">

<cfoutput QUERY="totCount">
<CFIF ISDEFINED("UnitName")>
	<cfset UnitName2 = ListAppend(UnitName, " ")> 
	<cfset lstUnitName = ListAppend(lstUnitName, UnitName)>
</cfif>	
</cfoutput>

<CFOUTPUT><strong>#lstUnitName#</strong></CFOUTPUT>
unit name<cfif totCount.recordCount GT 1>s</cfif> resulted in <cfoutput query="getList" maxrows="1"><strong>#getList.RecordCount#</strong></cfoutput> Contact Information results.</p>
  <cfoutput query="getList" maxrows="1"><p><strong>#getList.RecordCount# Results</strong></p></cfoutput>
 
<!--- Table output ---> 
    <cfoutput query="getList">
        <br>
        <p class="margintop30"><b>Contact Information: #UnitName# #Description#</b></p>
                    <cfif len(#FirstName#)>
                       <h5><strong>Contact Person</strong></h5>
                       <table width="100%" border="1" cellspacing="0" cellpadding="5" style="font-size: 13px;margin-top: 20px;">
                        <tr>
                            <td ALIGN="center"><b>First Name</b></td>
                            <td ALIGN="center"><b>Last Name</b></td>
                            <td ALIGN="center" colspan = "2"><b>Title</b></td>
                            <td ALIGN="center"><b>Phone</b></td>
                            <td ALIGN="center"><b>Cell Phone</b></td>
                            <td ALIGN="center"><b>Fax</b></td>
                        </tr>
                        <tr>
                            <td>#FirstName#</td>
                            <td>#LastName#</td>
                            <td colspan = "2">#Title#</td>
                            <td><cfif phone neq "" and phone neq "n/a" and phone neq "none">#(PhoneFormat(Phone, "(xxx) xxx-xxxx"))#</cfif><cfif len(#Ext#)> ext. #Ext#</cfif></td>
                            <td><cfif mobile neq "" and mobile neq "n/a" and mobile neq "none">#(PhoneFormat(Mobile, "(xxx) xxx-xxxx"))#</cfif></td>
                            <td><cfif Fax neq "" and Fax neq "n/a" and Fax neq "none">#(PhoneFormat(Fax, "(xxx) xxx-xxxx"))#</cfif></td>
                        </tr>
                        <tr>
                            <td ALIGN="center"><b>Address</b></td>
                            <td ALIGN="center"><b>City</b></td>
                            <td ALIGN="center"><b>State</b></td>
                            <td ALIGN="center"><b>Zip</b></td>
                            <td ALIGN="center" colspan = "3"><b>Email</b></td>
                        </tr>
                        <tr>
                            <td>#Address#</td>
                            <td>#City#</td>
                            <td>#State#</td>
                            <td>#Zip#</td>
                            <td  colspan = "3">#Email_Gov#</td>
                        </tr>
                        </table>
                    </cfif>
                    <cfif len(#CEOFName#)>
                    <h5><strong>CEO</strong></h5> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" style="font-size: 13px;margin-top: 20px;">
                      <tr>
                            <td ALIGN="center"><b>First Name</b></td>
                            <td ALIGN="center"><b>Last Name</b></td>
                            <td ALIGN="center"colspan = "2"><b>Title</b></td>
                            <td ALIGN="center"><b>Phone</b></td>
                            <td ALIGN="center"><b>Cell Phone</b></td>
                            <td ALIGN="center"><b>Fax</b></td>
                      </tr>
                      <tr>
                            <td>#CEOFName#</td>
                            <td>#CEOLName#</td>
                            <td colspan = "2">#CEOTitle#</td>
                            <td><cfif CEOPhone neq "" and CEOPhone neq "n/a" and CEOPhone neq "none">#(PhoneFormat(CEOPhone, "(xxx) xxx-xxxx"))#</cfif><cfif len(#CEOExt#)> ext. #CEOExt#</cfif></td>
                            <td><cfif CEOMobile neq "" and CEOMobile neq "n/a" and CEOMobile neq "none">#(PhoneFormat(CEOMobile, "(xxx) xxx-xxxx"))#</cfif></td>
                            <td><cfif CEOFax neq "" and CEOFax neq "n/a" and CEOFax neq "none">#(PhoneFormat(CEOFax, "(xxx) xxx-xxxx"))#</cfif></td>
                     </tr>
                     <tr>
                            <td ALIGN="center"><b>Address</b></td>
                            <td ALIGN="center"><b>City</b></td>
                            <td ALIGN="center"><b>State</b></td> 
                            <td ALIGN="center"><b>Zip</b></td> 
                            <td ALIGN="center" colspan = "3"><b>Email</b></td>  
                    </tr>
                    <tr>
                            <td>#CEOAddr#</td>
                            <td>#CEOCity#</td>    
                            <td>#CEOState#</td>    
                            <td>#CEOZip#</td>    
                            <td colspan = "3">#CEOEmail#</td>    
                    </tr>  
                </table>                                                          
                </cfif> 
                <cfif len(#CFOFName#)>
                <h5><strong>CFO</strong></h5>
                <table width="100%" border="1" cellspacing="0" cellpadding="5" style="font-size: 13px;margin-top: 20px;">               
                     <tr>
                            <td ALIGN="center"><b>First Name</b></td>
                            <td ALIGN="center"><b>Last Name</b></td>
                            <td ALIGN="center" colspan ="2"><b>Title</b></td>
                            <td ALIGN="center"><b>Phone</b></td>
                            <td ALIGN="center"><b>Cell Phone</b></td>
                            <td ALIGN="center"><b>Fax</b></td>
                    </tr>
                    <tr>
                            <td>#CFOFName#</td>
                            <td>#CFOLName#</td>
                            <td colspan = "2">#CFOTitle#</td>
                            <td><cfif CFOPhone neq "" and CFOPhone neq "n/a" and CFOPhone neq "none">#(PhoneFormat(CFOPhone, "(xxx) xxx-xxxx"))#</cfif><cfif len(#CFOExt#)> ext. #CFOExt#</cfif></td>
                            <td><cfif CFOMobile neq "" and CFOMobile neq "n/a" and CFOMobile neq "none">#(PhoneFormat(CFOMobile, "(xxx) xxx-xxxx"))#</cfif></td>
                            <td><cfif CFOFax neq "" and CFOFax neq "n/a" and CFOFax neq "none">#(PhoneFormat(CFOFax, "(xxx) xxx-xxxx"))#</cfif></td>
                    </tr>
                    <tr>
                            <td ALIGN ="center"><b>Address</b></td>
                            <td ALIGN ="center"><b>City</b></td>
                            <td ALIGN ="center"><b>State</b></td>
                            <td ALIGN ="center"><b>Zip</b></td>
                            <td ALIGN ="center" colspan = "3"><b>Email</b></td>
                    </tr>
                    <tr>
                            <td>#CFOAddr#</td>
                            <td>#CFOCity#</td>
                            <td>#CFOState#</td>
                            <td>#CFOZip#</td>
                            <td colspan = "3">#CFOEmail#</td>
                    </tr>
            </table>    
            </cfif>
            <cfif len(#PAFName#)>
                <h5><strong>Purchasing Agent</strong></h5>
                <table width="100%" border="1" cellspacing="0" cellpadding="5" style="font-size: 13px;margin-top: 20px;">              
                     <tr>
                            <td ALIGN="center"><b>First Name</b></td>
                            <td ALIGN="center"><b>Last Name</b></td>
                            <td ALIGN="center" colspan ="2"><b>Title</b></td>
                            <td ALIGN="center"><b>Phone</b></td>
                            <td ALIGN="center"><b>Cell Phone</b></td>
                            <td ALIGN="center"><b>Fax</b></td>
                    </tr>
                    <tr>
                            <td>#PAFName#</td>
                            <td>#PALName#</td>
                            <td colspan = "2">#PATitle#</td>
                            <td><cfif PAPhone neq "" and PAPhone neq "n/a" and PAPhone neq "none">#(PhoneFormat(PAPhone, "(xxx) xxx-xxxx"))#</cfif><cfif len(#PAExt#)> ext. #PAExt#</cfif></td>
                            <td><cfif PAMobile neq "" and PAMobile neq "n/a" and PAMobile neq "none">#(PhoneFormat(PAMobile, "(xxx) xxx-xxxx"))#</cfif></td>
                            <td><cfif PAFax neq "" and PAFax neq "n/a" and PAFax neq "none">#(PhoneFormat(PAFax, "(xxx) xxx-xxxx"))#</cfif></td>
                    </tr>
                    <tr>
                            <td ALIGN ="center"><b>Address</b></td>
                            <td ALIGN ="center"><b>City</b></td>
                            <td ALIGN ="center"><b>State</b></td>
                            <td ALIGN ="center"><b>Zip</b></td>
                            <td ALIGN ="center" colspan = "3"><b>Email</b></td>
                    </tr>
                    <tr>
                            <td>#PAAddr#</td>
                            <td>#PACity#</td>
                            <td>#PAState#</td>
                            <td>#PAZip#</td>
                            <td colspan = "3">#PAEmail#</td>
                    </tr>
            </table>    
            </cfif>
            <cfif len(#FOIAFName#)>
                <h5><strong>FOIA Officer</strong></h5>
                <table width="100%" border="1" cellspacing="0" cellpadding="5" style="font-size: 13px;margin-top: 20px;">              
                     <tr>
                            <td ALIGN="center"><b>First Name</b></td>
                            <td ALIGN="center"><b>Last Name</b></td>
                            <td ALIGN="center" colspan ="2"><b>Title</b></td>
                            <td ALIGN="center"><b>Phone</b></td>
                            <td ALIGN="center"><b>Cell Phone</b></td>
                            <td ALIGN="center"><b>Fax</b></td>
                    </tr>
                    <tr>
                            <td>#FOIAFName#</td>
                            <td>#FOIALName#</td>
                            <td colspan = "2">#FOIATitle#</td>
                            <td><cfif FOIAPhone neq "" and FOIAPhone neq "n/a" and FOIAPhone neq "none">#(PhoneFormat(FOIAPhone, "(xxx) xxx-xxxx"))#</cfif><cfif len(#FOIAExt#)> ext. #FOIAExt#</cfif></td>
                            <td><cfif FOIAMobile neq "" and FOIAMobile neq "n/a" and FOIAMobile neq "none">#(PhoneFormat(FOIAMobile, "(xxx) xxx-xxxx"))#</cfif></td>
                            <td><cfif FOIAFax neq "" and FOIAFax neq "n/a" and FOIAFax neq "none">#(PhoneFormat(FOIAFax, "(xxx) xxx-xxxx"))#</cfif></td>
                    </tr>
                    <tr>
                            <td ALIGN ="center"><b>Address</b></td>
                            <td ALIGN ="center"><b>City</b></td>
                            <td ALIGN ="center"><b>State</b></td>
                            <td ALIGN ="center"><b>Zip</b></td>
                            <td ALIGN ="center" colspan = "3"><b>Email</b></td>
                    </tr>
                    <tr>
                            <td>#FOIAAddr#</td>
                            <td>#FOIACity#</td>
                            <td>#FOIAState#</td>
                            <td>#FOIAZip#</td>
                            <td colspan = "3">#FOIAEmail#</td>
                    </tr>
            </table>    
            </cfif>
            <cfif len(#TIFFName#)>
                <h5><strong>TIF Administrator</strong></h5>
                <table width="100%" border="1" cellspacing="0" cellpadding="5" style="font-size: 13px;margin-top: 20px;">              
                     <tr>
                            <td ALIGN="center"><b>First Name</b></td>
                            <td ALIGN="center"><b>Last Name</b></td>
                            <td ALIGN="center" colspan ="2"><b>Title</b></td>
                            <td ALIGN="center"><b>Phone</b></td>
                            <td ALIGN="center"><b>Cell Phone</b></td>
                            <td ALIGN="center"><b>Fax</b></td>
                    </tr>
                    <tr>
                            <td>#TIFFName#</td>
                            <td>#TIFLName#</td>
                            <td colspan = "2">#TIFTitle#</td>
                            <td><cfif TIFPhone neq "" and TIFPhone neq "n/a" and TIFPhone neq "none">#(PhoneFormat(TIFPhone, "(xxx) xxx-xxxx"))#</cfif><cfif len(#TIFExt#)> ext. #TIFExt#</cfif></td>
                            <td><cfif TIFMobile neq "" and TIFMobile neq "n/a" and TIFMobile neq "none">#(PhoneFormat(TIFMobile, "(xxx) xxx-xxxx"))#</cfif></td>
                            <td><cfif TIFFax neq "" and TIFFax neq "n/a" and TIFFax neq "none">#(PhoneFormat(TIFFax, "(xxx) xxx-xxxx"))#</cfif></td>
                    </tr>
                    <tr>
                            <td ALIGN ="center"><b>Address</b></td>
                            <td ALIGN ="center"><b>City</b></td>
                            <td ALIGN ="center"><b>State</b></td>
                            <td ALIGN ="center"><b>Zip</b></td>
                            <td ALIGN ="center" colspan = "3"><b>Email</b></td>
                    </tr>
                    <tr>
                            <td>#TIFAddr#</td>
                            <td>#TIFCity#</td>
                            <td>#TIFState#</td>
                            <td>#TIFZip#</td>
                            <td colspan = "3">#TIFEmail#</td>
                    </tr>
            </table>    
            </cfif>
  </cfoutput>
<cfdocumentitem type="footer">
    <p>Local Government Registry</p>
    <div align="center">
        page
        <cfoutput>
          #cfdocument.currentpagenumber#
        </cfoutput>/
        <cfoutput>
        #cfdocument.totalpagecount#
        </cfoutput>
    </div><br>
</cfdocumentitem>

</cfdocument>
</body>
</html>
