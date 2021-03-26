<cfparam name="Revenue_Source" default="">
<cfparam name="Group" default="">
<cfparam name="Class" default="">
<cfparam name="Type" default="">


<!--- Style below is the graphical layout for page loading icon.   Different styles can be found at http://github.hubspot.com/pace/docs/welcome/ --->
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
<CFIF IsDefined ("form.GetQueryData")>
	<CFSET HideSwitch1 = "none">
    <CFSET HideSwitch2 = "block">

	<cfif form.formGroup eq 0 or TRIM(form.formGroup) eq "None">
        <cfset variables.formGroup = "fund">
    <cfelse>
        <cfset variables.formGroup = form.formGroup>
    </cfif>
    <cfif form.REVENUE_SOURCE eq 0 or TRIM(form.REVENUE_SOURCE) eq "">
        <cfset variables.REVENUE_SOURCE = "">
    <cfelse>
        <cfset variables.REVENUE_SOURCE = form.REVENUE_SOURCE>
    </cfif>
    <cfif form.Class eq 0 or TRIM(form.Class) eq "">
        <cfset variables.Class = "">
    <cfelse>
        <cfset variables.Class = form.Class>
    </cfif>
    <cfif form.Group eq 0 or TRIM(form.Group) eq "">
        <cfset variables.Group = "">
    <cfelse>
        <cfset variables.Group = form.Group>
    </cfif>
    <cfif form.Type eq 0 or TRIM(form.Type) eq "">
        <cfset variables.Type = "">
    <cfelse>
        <cfset variables.Type = form.Type>
    </cfif>
    <cfif form.FY eq 0 or TRIM(form.FY) eq "">
        <cfset variables.FY = "#DATEFORMAT(NOW(), 'yy')#">
    <cfelse>
        <cfset variables.FY = form.FY>
    </cfif>
    <CFIF IsDefined ("form.ViewMonthlyAmounts")>
        <CFSET ShowMonthlySwitch = "Yes">
    <cfelse>
        <CFSET ShowMonthlySwitch = "No">
    </CFIF>

    <cfinvoke component="Queries.revenues"
         method="RevenueQuery"
         returnvariable="results">
            <cfinvokeargument name="Control" value="Rev">
            <cfinvokeargument name="GroupBy" value="#variables.formGroup#">
            <cfinvokeargument name="Max" value="20">
            <cfinvokeargument name="FY" value="#variables.FY#">
            <cfinvokeargument name="ShowMo" value="#ShowMonthlySwitch#">
            <cfinvokeargument name="FundSel" value="">
            <cfinvokeargument name="FundGrpSel" value="">
            <cfinvokeargument name="FundTypSel" value="">
            <cfinvokeargument name="FundCatSel" value="">
            <cfinvokeargument name="AgcySel" value="">
            <cfinvokeargument name="AgcyGrpSel" value="">
            <cfinvokeargument name="AgcyTypSel" value="">
            <cfinvokeargument name="AgcyCatSel" value="">
            <cfinvokeargument name="RevSel" value="#variables.REVENUE_SOURCE#">
            <cfinvokeargument name="RevClsSel" value="#variables.Class#">
            <cfinvokeargument name="RevGrpSel" value="#variables.Group#">
            <cfinvokeargument name="RevTypSel" value="#variables.Type#">
            <cfinvokeargument name="SortName" value="No">
     </cfinvoke>
    <!--- Get the column headers from the query.  This is used for the table header in the report results below. --->
	<CFSET ColumnList = results.columnList>
<cfelse>
	<CFSET HideSwitch1 = "block">
    <CFSET HideSwitch2 = "none">
</CFIF>
<!--- get Revenue --->
<cfinvoke component="Queries.warehouse"
	method="GetRevenueSource"
	returnvariable="qRL">
</cfinvoke>


<!--- get Revenue groups --->
<cfinvoke component="Queries.warehouse"
	method="GetRevenueGroup"
	returnvariable="qRGL" >
</cfinvoke>

<!--- get Revenue class --->
<cfinvoke component="Queries.warehouse"
	method="GetRevenueClass"
	returnvariable="qRC" >
</cfinvoke>

<!--- get Revenue Types --->
<cfinvoke component="Queries.warehouse"
	method="GetRevenueType"
	returnvariable="qRT" >
</cfinvoke>
<!--- Get Fiscal years --->
 <cfinvoke component="Queries.warehouse"
		method="getFYs"
		returnvariable="qFYList" >
	<cfinvokeargument name="numFYs" value="5"/>
    <cfinvokeargument name="MaxFY" value="#DATEFORMAT(NOW(), 'yyyy')#">
</cfinvoke>
<!--- Get Revenue Source Group By--->
 <cfinvoke component="Queries.autosuggest"
		method="GetRevenueSourceGroupBy" >
</cfinvoke>


<cfoutput>
<!--- Record counts: <BR />
Revenue Source #qRL.recordcount# <BR />
Group #qRGL.recordcount# <BR />
Class #qRC.recordcount# <BR />
Type #qRT.recordcount# <BR />
Fiscal Year #ListLen(qFYList)#<BR /> --->
	<div id="expense" class="fund">
		<div class="container">
 <cfform method="post" enctype="application/x-www-form-urlencoded" preloader="no">

			<div class="row">
				<div class="col-md-12 col-md-offset-1">
          <div id="1" style="display:none" class="alert alert-info col-md-4">
            Gathering data, please wait...
          </div>
    <div id="101" style="display:#HideSwitch1#">
<h1>#$.getTitle()#</h1>
<p>The state of Illinois collects revenue from a variety of sources. Information provided by the Office of the Comptroller allows taxpayers to identify those revenue streams. </p>
 <div class="row">

        <fieldset>
            <div class="col-sm-12">
                <select name="Revenue_Source">
                    <option value="0" selected="selected">Select an Revenue Source</option>
                    <option value="0">All</option>
                    <cfloop query="qRL">
						<option value= "#qRL.Revenue_Source#">#qRL.Revenue_Source# - #qRL.Name#</option>
                    </cfloop>
                </select>

            </div>



            <div class="col-sm-10">

                <select name="Group">
                    <option value="0" selected="selected">Select Group</option>
                    <option value="0">All</option>
                    <cfloop query="qRGL">
						<option value= "#qRGL.Group#">#qRGL.Group# - #qRGL.Name#</option>
                    </cfloop>
                </select>

            </div>
           <div class="col-xs-2">
            <a class="tooltip-icon" href="##" data-toggle="tooltip" data-placement="top" title="Group!">?</a>
           </div>


            <div class="col-sm-10">

                <select name="Class">
                <option value="0" selected="selected">Select Class</option>
                <option value="0">All</option>
                    <cfloop query="qRC">
						<option value= "#qRC.Class#">#qRC.Class# - #qRC.Name#</option>
                    </cfloop>
                </select>

            </div>
           <div class="col-xs-2">
            <a class="tooltip-icon" href="##" data-toggle="tooltip" data-placement="top" title="Class!">?</a>
           </div>


            <div class="col-sm-10">

                <select name="Type">
                <option value="0" selected="selected">Select Type</option>
                <option value="0">All</option>
                    <cfloop query="qRT">
						<option value= "#qRT.Type#">#qRT.Type# - #qRT.Name#</option>
                    </cfloop>
                </select>

            </div>
      		<div class="col-xs-2">
            <a class="tooltip-icon" href="##" data-toggle="tooltip" data-placement="top" title="Type!">?</a>
           </div>

         <div class="col-sm-10 col-xs-12">
            <div class="hr"></div>
           </div>

            <!--- The DB2 database takes 2 digit year --->
            <div class="col-sm-12 required">

                <cfselect name="FY">
                	<option value="#DATEFORMAT(NOW(), 'yy')#" selected="selected">Fiscal Year</option>
                    <Cfloop index="i" list="#qFYList#">
                    	<option value="#RIGHT(i,2)#">#i#</option>
                    </Cfloop>
                </cfselect>

            </div>


           <!--- Group By --->
             <div class="col-sm-12">

                <cfselect name="FormGroup">
                	<option value="None" selected="selected">Group By</option>
                    <Cfloop query="#application.qRevenueGroupSources#">
                    	<option value="#application.qRevenueGroupSources.AbbrName#">#application.qRevenueGroupSources.Name#</option>
                    </Cfloop>
                </cfselect>

            </div>



            <div class="col-sm-12">

                <cfinput type="checkbox" name="ViewMonthlyAmounts" id="checkbox_1" value="1" />
                <label for="checkbox_1">View Monthly Amounts</label>

            </div>
        </fieldset>

            <div class="text-center top-pad col-xs-12 col-sm-11">

            	 <cfinput type="submit" name="GetQueryData" class="btn btn-success" onclick="return SwitchOn();" value="Search">
            </div>



</div>
</div>
</div>
</div>
</cfform>
<div class="col-sm-12">
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

<CFIF IsDefined ("form.GetQueryData")>
<CFIF ListLen(ColumnList) LTE 3>
	<CFSET SetFontSize = 14>
<cfelseif ListLen(ColumnList) GT 3 AND ListLen(ColumnList) LTE 6>
	<CFSET SetFontSize = 12>
<cfelse>
	<CFSET SetFontSize = 9>
</CFIF>
<div>
 <table class="table datatable no-footer table-striped" style="font-size:#SetFontSize#px">
<CFIF Results.recordcount GT 0>
  <tr>
  <Cfloop index="i" list="#ColumnList#">
    <th>#Replacenocase(i, "REV", "", "all")#</th>
   </cfloop>
  </tr>

<cfloop query="Results">
  <tr>
    <Cfloop index="i" list="#ColumnList#">
    <td>
	 <CFIF IsNumeric(results[i][Results.currentrow]) AND i IS NOT "Code">
     	#DollarFormat(results[i][Results.currentrow])#
     <cfelse>
     	#results[i][Results.currentrow]#
     </CFIF>
     </td>
    </cfloop>
  </tr>

  </tr>
 </cfloop>
<cfelse>
<tr>
	<td>No records found</td>
</tr>
</CFIF>
</table>
</div>

</CFIF>


		</div>
	</div>
</cfoutput>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
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