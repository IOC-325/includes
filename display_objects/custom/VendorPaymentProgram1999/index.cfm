

<!---<cfinclude template="/main/includes/header.cfm"> --->
 <cfset application.datasource =  "General">  



    
    <div class="container">
        <div class="page-title text-center">
            <h1>Financial Report</h1>
        </div>

  <cfif isDefined("form.submit")> 
  <cftry>
        <cfset filename = "../VendorPaymentProgram/2018/#form.entity#_FB_#form.FY#.pdf">
        <cfcontent type="application/pdf" file="#filename#" />
        <cfcatch type="any">
           <script language="javascript">
            alert("This file is currently not available.");
            history.go(-1);
            </script>
        </cfcatch>
   </cftry>     
  </cfif>

    <cfinvoke
        method="GetFYData"
        component="cfc.qdata"
        returnvariable="qFYdata">
    </cfinvoke>  
 <!--- <cfdump var="#qFYdata#">  --->


   <div class="card mb-4">
        <div class="card-body">
          <cfoutput> <!---  #getDirectoryFromPath( getCurrentTemplatePath() )#cfc WEB\Main2018\comptroller\includes\display_objects\custom\VendorPaymentProgram\ --->
            <cfform method="post">                     

                    <div class="mb-4">                    
                    <div >
                        <label for="FY" >Fiscal Year</label> 
                        <div>  
                            <cfselect name="FY" id="FY" 
                                        bind="cfc:cfc/qdata.GetFYData()" bindOnLoad="true" value="FY" display="FY">
                                     <option value="" selected> - Select Dropdown - </option>
                            </cfselect>
                        </div>
                    </div>

                    <div >
                        <label for="QualifiedPurchaser" >Qualified Purchaser</label> 
                        <div >
                            <cfselect name="QualifiedPurchaser" id="QualifiedPurchaser" 
                                      bind = "cfc:cfc/qdata.getQPByGroup({FY})" bindonload="false" value="QualifiedPurchaser" display="QualifiedPurchaser">
                                <option value="" selected> - Select Dropdown - </option>
                            </cfselect>
                        </div>
                    </div>

                    <div >
                        <label for="Entity" >Entity</label>
                        <div >
                           <cfselect name="Entity" id="Entity" 
                                bind = "cfc:cfc/qdata.getEntityNameByGroup({FY}, {QualifiedPurchaser})" bindonload="false" value="Entity" display="Entity" >
                                <option value="" selected>- Select Dropdown -</option>
                            </cfselect>
                        </div>
                    </div>
                </div>                     
                        
                      <br><br>  
                <div class="text-center">
                    <button type="submit" id="submit" name="submit" class="btn btn-primary mb-2">Submit</button>
                    <button type="button" class="btn btn-secondary mb-2" onclick="">Cancel</button>
                </div>
                
            </cfform>
          </cfoutput>
        </div> 
  </div> 
 <!--- </cfif>  --->   







