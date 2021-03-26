<CFPARAM NAME="Control" DEFAULT="Main">
<CFPARAM NAME="GroupBy" DEFAULT="None">
<CFPARAM NAME="FY" DEFAULT="#DATEFORMAT(NOW(), 'yyyy')#">
<CFPARAM NAME="Type" DEFAULT="O">
<CFPARAM NAME="Max" DEFAULT="20">
<CFPARAM NAME="ShowBudg" DEFAULT="No">
<CFPARAM NAME="ShowMo" DEFAULT="No">
<CFPARAM NAME="ShowLapse" DEFAULT="No">
<CFPARAM NAME="SortName" DEFAULT="No">
<cfparam name="ObjtSel" default="">
<cfparam name="ObjtGrpSel" default="">
<cfparam name="ObjtCatSel" default="">
<cfparam name="ObjtTypSel" default="">
<cfparam name="ObjtClsSel" default="">
<style>
.pace {
  -webkit-pointer-events: none;
  pointer-events: none;

  -webkit-user-select: none;
  -moz-user-select: none;
  user-select: none;

  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  -ms-box-sizing: border-box;
  -o-box-sizing: border-box;
  box-sizing: border-box;

  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
  border-radius: 10px;

  -webkit-background-clip: padding-box;
  -moz-background-clip: padding;
  background-clip: padding-box;

  z-index: 2000;
  position: fixed;
  margin: auto;
  top: 12px;
  left: 0;
  right: 0;
  bottom: 0;
  width: 200px;
  height: 50px;
  overflow: hidden;
}

.pace .pace-progress {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  -ms-box-sizing: border-box;
  -o-box-sizing: border-box;
  box-sizing: border-box;

  -webkit-border-radius: 2px;
  -moz-border-radius: 2px;
  border-radius: 2px;

  -webkit-background-clip: padding-box;
  -moz-background-clip: padding;
  background-clip: padding-box;

  -webkit-transform: translate3d(0, 0, 0);
  transform: translate3d(0, 0, 0);

  display: block;
  position: absolute;
  right: 100%;
  margin-right: -7px;
  width: 93%;
  top: 7px;
  height: 14px;
  font-size: 12px;
  background: #143b58;
  color: #143b58;
  line-height: 60px;
  font-weight: bold;
  font-family: Helvetica, Arial, "Lucida Grande", sans-serif;

  -webkit-box-shadow: 120px 0 #fff, 240px 0 #fff;
  -ms-box-shadow: 120px 0 #fff, 240px 0 #fff;
  box-shadow: 120px 0 #fff, 240px 0 #fff;
}

.pace .pace-progress:after {
  content: attr(data-progress-text);
  display: inline-block;
  position: fixed;
  width: 45px;
  text-align: right;
  right: 0;
  padding-right: 16px;
  top: 4px;
}

.pace .pace-progress[data-progress-text="0%"]:after { right: -200px }
.pace .pace-progress[data-progress-text="1%"]:after { right: -198.14px }
.pace .pace-progress[data-progress-text="2%"]:after { right: -196.28px }
.pace .pace-progress[data-progress-text="3%"]:after { right: -194.42px }
.pace .pace-progress[data-progress-text="4%"]:after { right: -192.56px }
.pace .pace-progress[data-progress-text="5%"]:after { right: -190.7px }
.pace .pace-progress[data-progress-text="6%"]:after { right: -188.84px }
.pace .pace-progress[data-progress-text="7%"]:after { right: -186.98px }
.pace .pace-progress[data-progress-text="8%"]:after { right: -185.12px }
.pace .pace-progress[data-progress-text="9%"]:after { right: -183.26px }
.pace .pace-progress[data-progress-text="10%"]:after { right: -181.4px }
.pace .pace-progress[data-progress-text="11%"]:after { right: -179.54px }
.pace .pace-progress[data-progress-text="12%"]:after { right: -177.68px }
.pace .pace-progress[data-progress-text="13%"]:after { right: -175.82px }
.pace .pace-progress[data-progress-text="14%"]:after { right: -173.96px }
.pace .pace-progress[data-progress-text="15%"]:after { right: -172.1px }
.pace .pace-progress[data-progress-text="16%"]:after { right: -170.24px }
.pace .pace-progress[data-progress-text="17%"]:after { right: -168.38px }
.pace .pace-progress[data-progress-text="18%"]:after { right: -166.52px }
.pace .pace-progress[data-progress-text="19%"]:after { right: -164.66px }
.pace .pace-progress[data-progress-text="20%"]:after { right: -162.8px }
.pace .pace-progress[data-progress-text="21%"]:after { right: -160.94px }
.pace .pace-progress[data-progress-text="22%"]:after { right: -159.08px }
.pace .pace-progress[data-progress-text="23%"]:after { right: -157.22px }
.pace .pace-progress[data-progress-text="24%"]:after { right: -155.36px }
.pace .pace-progress[data-progress-text="25%"]:after { right: -153.5px }
.pace .pace-progress[data-progress-text="26%"]:after { right: -151.64px }
.pace .pace-progress[data-progress-text="27%"]:after { right: -149.78px }
.pace .pace-progress[data-progress-text="28%"]:after { right: -147.92px }
.pace .pace-progress[data-progress-text="29%"]:after { right: -146.06px }
.pace .pace-progress[data-progress-text="30%"]:after { right: -144.2px }
.pace .pace-progress[data-progress-text="31%"]:after { right: -142.34px }
.pace .pace-progress[data-progress-text="32%"]:after { right: -140.48px }
.pace .pace-progress[data-progress-text="33%"]:after { right: -138.62px }
.pace .pace-progress[data-progress-text="34%"]:after { right: -136.76px }
.pace .pace-progress[data-progress-text="35%"]:after { right: -134.9px }
.pace .pace-progress[data-progress-text="36%"]:after { right: -133.04px }
.pace .pace-progress[data-progress-text="37%"]:after { right: -131.18px }
.pace .pace-progress[data-progress-text="38%"]:after { right: -129.32px }
.pace .pace-progress[data-progress-text="39%"]:after { right: -127.46px }
.pace .pace-progress[data-progress-text="40%"]:after { right: -125.6px }
.pace .pace-progress[data-progress-text="41%"]:after { right: -123.74px }
.pace .pace-progress[data-progress-text="42%"]:after { right: -121.88px }
.pace .pace-progress[data-progress-text="43%"]:after { right: -120.02px }
.pace .pace-progress[data-progress-text="44%"]:after { right: -118.16px }
.pace .pace-progress[data-progress-text="45%"]:after { right: -116.3px }
.pace .pace-progress[data-progress-text="46%"]:after { right: -114.44px }
.pace .pace-progress[data-progress-text="47%"]:after { right: -112.58px }
.pace .pace-progress[data-progress-text="48%"]:after { right: -110.72px }
.pace .pace-progress[data-progress-text="49%"]:after { right: -108.86px }
.pace .pace-progress[data-progress-text="50%"]:after { right: -107px }
.pace .pace-progress[data-progress-text="51%"]:after { right: -105.14px }
.pace .pace-progress[data-progress-text="52%"]:after { right: -103.28px }
.pace .pace-progress[data-progress-text="53%"]:after { right: -101.42px }
.pace .pace-progress[data-progress-text="54%"]:after { right: -99.56px }
.pace .pace-progress[data-progress-text="55%"]:after { right: -97.7px }
.pace .pace-progress[data-progress-text="56%"]:after { right: -95.84px }
.pace .pace-progress[data-progress-text="57%"]:after { right: -93.98px }
.pace .pace-progress[data-progress-text="58%"]:after { right: -92.12px }
.pace .pace-progress[data-progress-text="59%"]:after { right: -90.26px }
.pace .pace-progress[data-progress-text="60%"]:after { right: -88.4px }
.pace .pace-progress[data-progress-text="61%"]:after { right: -86.53999999999999px }
.pace .pace-progress[data-progress-text="62%"]:after { right: -84.68px }
.pace .pace-progress[data-progress-text="63%"]:after { right: -82.82px }
.pace .pace-progress[data-progress-text="64%"]:after { right: -80.96000000000001px }
.pace .pace-progress[data-progress-text="65%"]:after { right: -79.1px }
.pace .pace-progress[data-progress-text="66%"]:after { right: -77.24px }
.pace .pace-progress[data-progress-text="67%"]:after { right: -75.38px }
.pace .pace-progress[data-progress-text="68%"]:after { right: -73.52px }
.pace .pace-progress[data-progress-text="69%"]:after { right: -71.66px }
.pace .pace-progress[data-progress-text="70%"]:after { right: -69.8px }
.pace .pace-progress[data-progress-text="71%"]:after { right: -67.94px }
.pace .pace-progress[data-progress-text="72%"]:after { right: -66.08px }
.pace .pace-progress[data-progress-text="73%"]:after { right: -64.22px }
.pace .pace-progress[data-progress-text="74%"]:after { right: -62.36px }
.pace .pace-progress[data-progress-text="75%"]:after { right: -60.5px }
.pace .pace-progress[data-progress-text="76%"]:after { right: -58.64px }
.pace .pace-progress[data-progress-text="77%"]:after { right: -56.78px }
.pace .pace-progress[data-progress-text="78%"]:after { right: -54.92px }
.pace .pace-progress[data-progress-text="79%"]:after { right: -53.06px }
.pace .pace-progress[data-progress-text="80%"]:after { right: -51.2px }
.pace .pace-progress[data-progress-text="81%"]:after { right: -49.34px }
.pace .pace-progress[data-progress-text="82%"]:after { right: -47.480000000000004px }
.pace .pace-progress[data-progress-text="83%"]:after { right: -45.62px }
.pace .pace-progress[data-progress-text="84%"]:after { right: -43.76px }
.pace .pace-progress[data-progress-text="85%"]:after { right: -41.9px }
.pace .pace-progress[data-progress-text="86%"]:after { right: -40.04px }
.pace .pace-progress[data-progress-text="87%"]:after { right: -38.18px }
.pace .pace-progress[data-progress-text="88%"]:after { right: -36.32px }
.pace .pace-progress[data-progress-text="89%"]:after { right: -34.46px }
.pace .pace-progress[data-progress-text="90%"]:after { right: -32.6px }
.pace .pace-progress[data-progress-text="91%"]:after { right: -30.740000000000002px }
.pace .pace-progress[data-progress-text="92%"]:after { right: -28.880000000000003px }
.pace .pace-progress[data-progress-text="93%"]:after { right: -27.02px }
.pace .pace-progress[data-progress-text="94%"]:after { right: -25.16px }
.pace .pace-progress[data-progress-text="95%"]:after { right: -23.3px }
.pace .pace-progress[data-progress-text="96%"]:after { right: -21.439999999999998px }
.pace .pace-progress[data-progress-text="97%"]:after { right: -19.58px }
.pace .pace-progress[data-progress-text="98%"]:after { right: -17.72px }
.pace .pace-progress[data-progress-text="99%"]:after { right: -15.86px }
.pace .pace-progress[data-progress-text="100%"]:after { right: -14px }


.pace .pace-activity {
  position: absolute;
  width: 100%;
  height: 28px;
  z-index: 2001;
  box-shadow: inset 0 0 0 2px #143b58, inset 0 0 0 7px #FFF;
  border-radius: 10px;
}

.pace.pace-inactive {
  display: none;
}
.borderless > tbody > tr > td {
    border: none;
}
</style>
<CFIF IsDefined ("form.ObjtSel")>
  <CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">
  <CFSET ObjtSel = form.ObjtSel>
    <CFSET ObjtGrpSel = form.ObjtGrpSel>
    <CFSET ObjtCatSel = form.ObjtCatSel>
    <CFSET ObjtTypSel = form.ObjtTypSel>
    <CFSET ObjtClsSel = form.ObjtClsSel>
    <CFSET GroupBy = form.FormGroup>
     <CFSET FY = form.FY>
     <CFSET Type = form.Type>
    <CFIF IsDefined ("form.ViewMonthly")>
      <CFSET ViewMonthly = "Yes">
        <CFSET ShowMo = "Yes">
    <cfelse>
      <CFSET ViewMonthly = "No">
    </CFIF>
     <CFIF IsDefined ("form.ViewBudget")>
      <CFSET ViewBudget = "Yes">
          <CFSET ShowBudg = "Yes">
    <cfelse>
      <CFSET ViewBudget = "No">
    </CFIF>
    <CFIF IsDefined ("form.ViewLapse")>
      <CFSET ViewLapse = "Yes">
        <CFSET ShowLapse = "Yes">
    <cfelse>
      <CFSET ViewLapse = "No">
    </CFIF>
    <CFIF form.FormGroup IS "None">
      <CFSET form.FormGroup = "fund">
    </CFIF>
 
     <cfinvoke component="Queries.expenditures"
         method="ExpenditureQuery"
         returnvariable="results">
            <cfinvokeargument name="Control" value="Obje">
            <cfinvokeargument name="GroupBy" value="#form.FormGroup#">
            <cfinvokeargument name="Max" value="20">
            <cfinvokeargument name="FY" value="16">
            <cfinvokeargument name="ShowBudg" value="#ViewBudget#">
      <cfinvokeargument name="ShowMo" value="#ViewMonthly#">
      <cfinvokeargument name="ShowLapse" value="#ViewLapse#"> 
            <cfinvokeargument name="FundSel" value="">
            <cfinvokeargument name="FundGrpSel" value="">
      <cfinvokeargument name="FundClsSel" value="">
            <cfinvokeargument name="FundTypSel" value="">
            <cfinvokeargument name="FundCatSel" value="">
            <cfinvokeargument name="AgcySel" value="">
      <cfinvokeargument name="AgcyClsSel" value="">
            <cfinvokeargument name="AgcyGrpSel" value="">
            <cfinvokeargument name="AgcyTypSel" value="">
            <cfinvokeargument name="AgcyCatSel" value="">
      <cfinvokeargument name="ApprSel" value="">
            <cfinvokeargument name="ApprClsSel" value="">
            <cfinvokeargument name="ApprGrpSel" value="">
            <cfinvokeargument name="ApprTypSel" value="">
      <cfinvokeargument name="ApprCatSel" value="">
            <cfinvokeargument name="RevSel" value="">
            <cfinvokeargument name="RevClsSel" value="">
            <cfinvokeargument name="RevGrpSel" value="">
            <cfinvokeargument name="RevTypSel" value="">
      <cfinvokeargument name="ObjeSel" value="">
            <cfinvokeargument name="ObjtSel" value="#form.ObjtSel#">
            <cfinvokeargument name="ObjtClsSel" value="#form.ObjtClsSel#">
            <cfinvokeargument name="ObjtGrpSel" value="#form.ObjtGrpSel#">
      <cfinvokeargument name="ObjtTypSel" value="#form.ObjtTypSel#">
            <cfinvokeargument name="ObjtCatSel" value="#form.ObjtCatSel#">
            <cfinvokeargument name="Type" value="#form.Type#">
            <cfinvokeargument name="SortName" value="">
     </cfinvoke> 
 <cfelse>
  <CFSET HideSwitch1 = "block">
    <CFSET HideSwitch2 = "none">

</CFIF>

<cfoutput>

<!--- Get Objects --->
<cfinvoke component="Queries.warehouse"
  method="GetObjectForDetailObject"
  returnvariable="qObject">
</cfinvoke>
<!--- Get Group --->
<cfinvoke component="Queries.warehouse"
  method="GetGroupsForDetailObject"
  returnvariable="qGroup">
</cfinvoke>
<!--- Get Category  --->
<cfinvoke component="Queries.warehouse"
  method="GetCategoryForDetailObject"
  returnvariable="qCat">
</cfinvoke>
<!--- Get Type --->
<cfinvoke component="Queries.warehouse"
  method="GetTypeForDetailObject"
  returnvariable="qType">
</cfinvoke>
<!--- Get Class  --->
<cfinvoke component="Queries.warehouse"
  method="GetClassForDetailObject"
  returnvariable="qClass">
</cfinvoke>
<!--- Get Revenue Source Group By--->
 <cfinvoke component="Queries.autosuggest"
    method="GetRevenueSourceGroupBy" >
</cfinvoke>
<!--- Get Fiscal years --->
 <cfinvoke component="Queries.warehouse"
    method="getFYs"
    returnvariable="qFYList" >
  <cfinvokeargument name="numFYs" value="3"/>
    <cfinvokeargument name="MaxFY" value="#DATEFORMAT(NOW(), 'yyyy')#">
</cfinvoke>
<div id="agency">
  <div class="container">
    <div class="row">
      <div class="col-md-10 col-md-offset-1">
<div id="1" style="display:none" class="col-md-5 col-sm-offset-3 alert alert-info col-md-4">
Gathering data, please wait...
</div>
<div id="101" style="display:#HideSwitch1#">        
        <h1>#$.getTitle()#</h1>

        #$.getSummary()#

        <div class="row">
<cfform method="post" enctype="application/x-www-form-urlencoded" preloader="no">
<fieldset>
<!--- <div class="col-xs-12 col-sm-10">
<h2>Select One</h2>
</div> --->

<div class="col-xs-10">
<SELECT NAME="ObjtSel">
<OPTION VALUE="">Object</option>
<cfloop query="qObject">
<CFIF ObjtSel is qObject.Object>
        <OPTION VALUE="#Object#" SELECTED>#Object# - #Name#</option>
    <CFELSE>
        <OPTION VALUE="#Object#">#Object# - #Name#</option>
    </CFIF>
</cfloop>
</SELECT>
</div>

<div class="col-xs-2"><a class="tooltip-icon" data-placement="top" data-toggle="tooltip" href="##" title="Group!">?</a></div>

<div class="col-xs-10">




<SELECT NAME="ObjtGrpSel">
<OPTION VALUE="" selected="selected">Group</option>
<cfloop query="qGroup">
   <CFIF ObjtGrpSel is qGroup.Group>
        <OPTION VALUE="#Group#" SELECTED>#Group# - #Name#</option>
    <CFELSE>
        <OPTION VALUE="#Group#">#Group# - #Name#</option>
    </CFIF>
</cfloop>
</SELECT>


</div>

<div class="col-xs-2"><a class="tooltip-icon" data-placement="top" data-toggle="tooltip" href="##" title="Group!">?</a></div>

<div class="col-xs-10">




<SELECT NAME="ObjtCatSel">
<OPTION VALUE="">Category</option>
<cfloop query="qCat">
   <CFIF ObjtCatSel is qCat.Category>
        <OPTION VALUE="#Category#" SELECTED>#Category# - #Name#</option>
    <CFELSE>
        <OPTION VALUE="#Category#">#Category# - #Name#</option>
    </CFIF>
</cfloop>
</SELECT>


</div>

<div class="col-xs-2"><a class="tooltip-icon" data-placement="top" data-toggle="tooltip" href="##" title="Type!">?</a></div>

<div class="col-xs-10">

<SELECT NAME="ObjtTypSel">
<OPTION VALUE="">Type</option>
<cfloop query="qType">
   <CFIF ObjtTypSel is qType.Type>
        <OPTION VALUE="#Type#" SELECTED>#Type# - #Name#</option>
    <CFELSE>
        <OPTION VALUE="#Type#">#Type# - #Name#</option>
    </CFIF>
</cfloop>
</SELECT>

</div>

<div class="col-xs-2"><a class="tooltip-icon" data-placement="top" data-toggle="tooltip" href="##" title="Group!">?</a></div>

<div class="col-xs-10">


<SELECT NAME="ObjtClsSel">
<OPTION VALUE="" selected="selected"> Class</option>
<cfloop query="qClass">
   <CFIF ObjtClsSel is qClass.Class>
        <OPTION VALUE="#Class#" SELECTED>#Class# - #Name#</option>
    <CFELSE>
        <OPTION VALUE="#Class#">#Class# - #Name#</option>
    </CFIF>
</cfloop>
</SELECT>

</div>

<div class="col-xs-2"><a class="tooltip-icon" data-placement="top" data-toggle="tooltip" href="##" title="Category!">?</a></div>

<div class="col-sm-10 col-xs-12">
<div class="hr">&nbsp;</div>
</div>

<div class="col-sm-10 col-xs-12">
<cfselect name="FormGroup">
    <option value="None" selected="selected">Group By</option>
    <Cfloop query="#application.qRevenueGroupSources#">
      <CFIF GroupBy IS application.qRevenueGroupSources.AbbrName> 
          <option value="#application.qRevenueGroupSources.AbbrName#" selected="selected">#application.qRevenueGroupSources.Name#</option>
        <cfelse>
          <option value="#application.qRevenueGroupSources.AbbrName#">#application.qRevenueGroupSources.Name#</option>
        </CFIF>
    </Cfloop>
</cfselect>

</div>

<div class="col-sm-10 col-xs-12">
<cfselect name="FY">
    <option value="#DATEFORMAT(NOW(), 'yy')#" selected="selected">Fiscal Year</option>
    <Cfloop index="i" list="#qFYList#">
      <CFIF FY IS RIGHT(i,2)>
        <option value="#RIGHT(i,2)#" selected="selected">#i#</option>
        <cfelse>
        <option value="#RIGHT(i,2)#">#i#</option>
        </CFIF>
    </Cfloop>
</cfselect>
</div>

<div class="col-sm-10 col-xs-12">
<SELECT NAME="Type">
  <CFIF Type is "0">
        <OPTION VALUE="A" SELECTED>Type of Spending</option>
    <CFELSE>
        <OPTION VALUE="A">Type of Spending</option>
    </CFIF>
    <CFIF Type is "A">
        <OPTION VALUE="A" SELECTED>Appropriated Only</option>
    <CFELSE>
        <OPTION VALUE="A">Appropriated Only</option>
    </CFIF>

    <CFIF Type is "N">
        <OPTION VALUE="N" SELECTED>Non-Appropriated Only</option>
    <CFELSE>
        <OPTION VALUE="N">Non-Appropriated Only</option>
    </CFIF>

    <CFIF Type is "B">
        <OPTION VALUE="B" SELECTED>Both</option>
    <CFELSE>
        <OPTION VALUE="B">Both</option>
    </CFIF>
</SELECT>

</div>

<div class="col-sm-10 col-xs-12">
<CFIF IsDefined ("form.ViewMonthly")>
  <input name="ViewMonthly" type="checkbox" id="ViewMonthly" value="1" checked="checked" />
<cfelse>
  <input id="ViewMonthly" name="ViewMonthly" type="checkbox" value="1" />
</CFIF>
<label for="ViewMonthly">View Monthly Amounts</label>
</div>

<div class="col-sm-10 col-xs-12">
<CFIF IsDefined ("form.ViewBudget")>
  <input name="ViewBudget" type="checkbox" id="ViewBudget" value="1" checked="checked" />
<cfelse>
  <input id="ViewBudget" name="ViewBudget" type="checkbox" value="1" />
</cfif>
<label for="ViewBudget">View Budget Amounts</label>
</div>

<div class="col-sm-10 col-xs-12">
<CFIF IsDefined ("form.ViewLapse")>
  <input name="ViewLapse" type="checkbox" id="ViewLapse" value="1" checked="checked" />
<cfelse>
  <input id="ViewLapse" name="ViewLapse" type="checkbox" value="1" />
</cfif>
<label for="ViewLapse">View Lapse Amounts</label>
</div>

<div class="text-center top-pad col-xs-12 col-sm-11">
<button class="btn btn-primary" type="submit" onclick="return SwitchOn();" >Submit</button>
</div>
</fieldset>

  </cfform>
  </div>
</div>
<div class="col-sm-11">
<table width="100%">
    <tr>
        <td align="center">
        <div class="col-sm-5"></div>
          <a href="##" onclick="return SwitchOff();" class="btn btn-success col-sm-3" id="100" style="display:#HideSwitch2#">Search Again</a>
        </td>
    </tr>
</table>
</div>
<BR /><BR />

<div class="col-sm-11">
<cfif IsDefined ("results")>
<BR /><BR />
<div class="table-responsive">
     <table id="example" class="<cfif ShowMo eq "yes">datatable-expenses-fixed<cfelse>datatable-expenses</cfif> table-striped datatable-primary">
      <thead>
<!--- <div class="table-responsive">
<table id="example" class="datatable table-striped" align="center" style="font-size:12px;"> --->
<CFIF Results.recordcount GT 0>
<cfset numberOfColumns = listlen( ArrayToList( Results.getColumnNames() ) ) />

<cfinvoke component="Queries.warehouse"
  method="CalculateTotalFromQuery"
  returnvariable="CalculatedTotal">
  <cfinvokeargument name="IncomingQuery" value="#Results#">
  <cfinvokeargument name="ColumnToApplyCalculation" value="ExpTotal">
</cfinvoke>

<CFIF (variables.ShowLapse is "Yes") OR (variables.ShowMo is "Yes")>
    <TR>
    <TH></TH>
    <TH></TH>
    <CFIF variables.ShowBudg is "Yes">
        <TH></TH>
    </CFIF>
    <TH></TH>
    <CFIF variables.ShowMo is "Yes">
        <TH COLSPAN=12 ALIGN=CENTER BGCOLOR="Silver">Monthly Expended Amounts</TH>
        <TH COLSPAN=3 ALIGN=CENTER BGCOLOR="Silver">Lapse Periods</TH>
    <CFELSE>
        <TH COLSPAN=2 ALIGN=CENTER BGCOLOR="Silver">Expended Amount</TH>
    </CFIF>
    </TR>
</CFIF>

<TR>

<TH ALIGN=CENTER BGCOLOR="Silver">Code</TH>
<TH ALIGN=LEFT BGCOLOR="Silver">Name</TH>


<CFIF ShowBudg is "Yes">
  <TH ALIGN=RIGHT BGCOLOR="Silver">Appropriated</TH>
</CFIF>

<TH ALIGN=RIGHT BGCOLOR="Silver" NOWRAP>Expended YTD</TH>

<CFIF ShowMo is "Yes">
<TH ALIGN=CENTER BGCOLOR="Silver">Jul</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Aug</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Sep</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Oct</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Nov</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Dec</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Jan</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Feb</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Mar</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Apr</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">May</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Jun</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Jul</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Aug</TH>
<TH ALIGN=CENTER BGCOLOR="Silver">Sep</TH>
<CFELSE>
  <CFIF ShowLapse is "Yes">
    <TH ALIGN=RIGHT BGCOLOR="Silver">Non-Lapse</TH>
    <TH ALIGN=RIGHT BGCOLOR="Silver">Lapse</TH>
    </CFIF>
</CFIF>

<CFIF ShowBudg is "Yes">
  <TH ALIGN=RIGHT BGCOLOR="Silver">Unexpended</TH>
</CFIF>
</TR>
</thead>
<tbody>
<cfloop QUERY="Results">
<TR>

<CFIF variables.GroupBy is "None">
    <TD ALIGN=CENTER>#Code#</TD>
    <TD ALIGN=LEFT NOWRAP>#Name#</TD>
<CFELSE>
    <TD ALIGN=CENTER>#Code#</TD>
    
    <TD ALIGN=LEFT NOWRAP>#Name#</TD>
</CFIF>

<CFIF ShowBudg is "Yes">
  <TD ALIGN=RIGHT>#DollarFormat(ApprTotal)#</TD>
</CFIF>

<TD ALIGN=RIGHT>#DollarFormat(ExpTotal)#</TD>

<CFIF ShowMo is "Yes">
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal1)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal2)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal3)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal4)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal5)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal6)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal7)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal8)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal9)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal10)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal11)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal12)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal13)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal14)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal15)#</TD>
<CFELSE>
  <CFIF  ShowLapse is "Yes">
    <TD ALIGN=RIGHT>#DollarFormat(ExpTotal-ExpLapse)#</TD>
    <TD ALIGN=RIGHT>#DollarFormat(ExpLapse)#</TD>
    </CFIF>
</CFIF>

<CFIF ShowBudg is "Yes">
  <TD ALIGN=RIGHT>#DollarFormat(UnexpTotal)#</TD>
</CFIF>
</TR>
</cfloop>
 </tbody>
<tfoot>
  <tr>
    <th colspan="#numberOfColumns#" style="text-align: right;">
      Total: #DOLLARFORMAT(CalculatedTotal)#
    </th>
  </tr>
</tfoot>

</table>
<!---
<div class="alert alert-warning alert-dismissible">
Total: #DOLLARFORMAT(CalculatedTotal)#
</div>
--->
</div>
<cfelse>
<tr>
  <td>No records found</td>
</tr>
  </tbody>
</table>
</CFIF>
</cfif>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END AGENCY -->
</cfoutput>
<script type="text/javascript">
<!--
/* Switch that allows search again */
      function SwitchOn() {
       var e = document.getElementById(100);
        var e2 = document.getElementById(101);
    var e3 = document.getElementById(1);
      e.style.display = 'block';
        e2.style.display = 'none';
    e3.style.display = 'block';
    $(function() {
        e3.delay(2000).fadeOut(0);

      });
    }
   function SwitchOff() {
         var e = document.getElementById(100);
         var e2 = document.getElementById(101);
     var e3 = document.getElementById(1);
          e.style.display = 'none';
         e2.style.display = 'block';
      e3.style.display = 'none';
    $(function() {
        e3.delay(2000).fadeOut(0);
      });
    };

//-->
</script>