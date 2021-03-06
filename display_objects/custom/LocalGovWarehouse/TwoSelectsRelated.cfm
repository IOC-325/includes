<!--- REMOVE THIS AND FIRST LINE IF NOT USING CF3.1 OR LATER --->
<CFSETTING ENABLECFOUTPUTONLY="YES">

<!--- TAG PARAMETERS --->
<CFPARAM NAME="Attributes.Query">  
<CFPARAM NAME="Attributes.Display1">
<CFPARAM NAME="Attributes.Display2">
<CFPARAM NAME="Attributes.Value1" DEFAULT="#Attributes.Display1#">
<CFPARAM NAME="Attributes.Value2" DEFAULT="#Attributes.Display2#">
<CFPARAM NAME="Attributes.Name1" DEFAULT="TwoSelectsRelated1">
<CFPARAM NAME="Attributes.Name2" DEFAULT="TwoSelectsRelated2">
<CFPARAM NAME="Attributes.Size1" DEFAULT="1">
<CFPARAM NAME="Attributes.Size2" DEFAULT="1">
<CFPARAM NAME="Attributes.Width1" DEFAULT="">
<CFPARAM NAME="Attributes.Width2" DEFAULT="">
<CFPARAM NAME="Attributes.ForceWidth1" DEFAULT="">
<CFPARAM NAME="Attributes.ForceWidth2" DEFAULT="">
<CFPARAM NAME="Attributes.ForceWidthChar" DEFAULT="&nbsp;">
<CFPARAM NAME="Attributes.EmptyText1" DEFAULT="">
<CFPARAM NAME="Attributes.EmptyText2" DEFAULT="">
<CFPARAM NAME="Attributes.Message1" DEFAULT="You must choose an option for #Attributes.Name1#.">
<CFPARAM NAME="Attributes.Message2" DEFAULT="You must choose an option for #Attributes.Name2#.">
<CFPARAM NAME="Attributes.FormName" DEFAULT="forms[0]">
<CFPARAM NAME="Attributes.HTMLBetween" DEFAULT="">
<CFPARAM NAME="Attributes.OnChange" DEFAULT="">
<CFPARAM NAME="Attributes.AutoSelectFirst" DEFAULT="Yes">


<CFSET FunctionName = ReplaceList(Attributes.FormName, "[,]", ",") & "ChangeMenu()">


<!--- "MAGIC" SHORTCUTS FOR THE ONCHANGE HANDLER --->
<CFIF Attributes.OnChange is "Jump!">
  <CFSET Attributes.OnChange = "document.location = this.options[selectedIndex].value;">
<CFELSEIF Attributes.OnChange is "Submit!">
  <CFSET Attributes.OnChange = "this.form.submit();">
</CFIF>

<!--- USE PASSED QUERY WITHIN THIS CODE AS "MyQuery" --->
<!--- <CFSET MyQuery = Evaluate("Caller.#Attributes.Query#")> --->
<CFSET MyQuery = Evaluate("#Attributes.Query#")>


<!--- BEGIN JAVASCRIPTING --->
<CFOUTPUT>
	<SCRIPT LANGUAGE="JavaScript1.1">
	  // javascript code generated by the CF_TwoSelectsRelated Cold Fusion tag (Nate Weiss, 4/98)
		// portions adapted from Nick Heinle's code at http://webreference.com/javascript/960902/select_boxes.html
	  var maxlength = 10;
	  OneA = new Array;

		var trueLength = OneA.length;  
		var lst = OneA.length;              

    function require_#Attributes.Name1#() {
		  with (document.#Attributes.FormName#.#Attributes.Name1#) {
			  RetVal = true;
			  if (options[selectedIndex] == null) RetVal = false;
				  else RetVal = !(options[selectedIndex].value == '');
			  if (!RetVal) alert('#Attributes.Message1#');
				return RetVal
			}
		}

    function require_#Attributes.Name2#() {
		  with (document.#Attributes.FormName#.#Attributes.Name2#) {
			  RetVal = true;
			  if (options[selectedIndex] == null) RetVal = false;
				  else RetVal = !(options[selectedIndex].value == '');
			  if (!RetVal) alert('#Attributes.Message2#');
				return RetVal
			}
		}
		
		function require_#Attributes.Name1#And#Attributes.Name2#() {
		  return ((require_#Attributes.Name1#()) && (require_#Attributes.Name2#()));
		}
		
				
		function #FunctionName# {
		   
		  
		   OneA.length = 0;
		   menuNum = document.#Attributes.FormName#.#Attributes.Name1#.selectedIndex;
		   if (menuNum == null) return;  
       <!--- this function gets continued in the next CFOUTPUT section --->
</CFOUTPUT>


<!--- COUNTER VARIABLE WILL HOLD NUMBER OF GROUPS (OPTIONS IN FIRST SELECT) --->
<CFSET Counter = IIF(Attributes.EmptyText1 is not "", 1, 0)>

<!--- CREATE AN "IF" STATEMENT THAT COVERS EACH ITEM IN THE FIRST SELECT BOX --->
<!--- WITHIN THE "IF" STATMENT, PRE-POPULATE ARRAY WITH CORRESPONDING ITEMS FOR SECOND SELECT  --->
<CFOUTPUT QUERY="MyQuery" GROUP="#Attributes.Display1#">
	if (menuNum == #Counter#) {
	  NewOpt = new Array;
		NewVal = new Array;
    <CFSET Counter2 = IIF(Attributes.EmptyText2 is not "", 1, 0)>
    <CFIF Attributes.EmptyText2 is not ""><CFOUTPUT>NewOpt[0] = new Option("#Attributes.EmptyText2#");	NewOpt[0].value = '';	</CFOUTPUT></CFIF>
		<CFOUTPUT>NewOpt[#Counter2#] = new Option("#Evaluate(Attributes.Display2)#");	NewOpt[#Counter2#].value = '#Evaluate(Attributes.Value2)#'; <CFSET Counter2 = Counter2 + 1></CFOUTPUT>
	} <CFSET Counter = Counter + 1>
</CFOUTPUT>


<!--- finish up the ChangeMenu() function --->
<CFOUTPUT>
  tot = NewOpt.length;
	lst = document.#Attributes.FormName#.#Attributes.Name2#.options.length;
	
	for (i = lst; i > 0; i--) {
	  document.#Attributes.FormName#.#Attributes.Name2#.options[i] = null;
	}
  for (i = 0; i < tot; i++) { 
	  document.#Attributes.FormName#.#Attributes.Name2#.options[i] = NewOpt[i];
	}
  <CFIF Attributes.AutoSelectFirst is "Yes">
	  document.#Attributes.FormName#.#Attributes.Name2#.options[0].selected = true;
	</CFIF>
}
</SCRIPT>
</CFOUTPUT>
<!--- DONE WITH JAVASCRIPTING.  NOW WE JUST HAVE TO DISPLAY THE FORM ELEMENTS --->


<!--- ALLOW FOR AUTO-SIZING "SHORTCUT" OF SELECT BOXES --->
<CFIF Attributes.Size1 is "Auto">
  <!--- MAKE THE FIRST SELECT BE BIG ENOUGH FOR ALL OF ITS OPTIONS --->
  <CFSET Attributes.Size1 = Counter>
</CFIF>
<CFIF Attributes.Size2 is "Auto">
  <!--- MAKE THE SECOND SELECT BE THE SAME SIZE AS THE FIRST --->
  <CFSET Attributes.Size2 = Attributes.Size1>
</CFIF>


<!--- OUTPUT FIRST SELECT BOX --->
<div class="col-sm-7">
<CFOUTPUT><SELECT NAME="#Attributes.Name1#" class="select2" onChange="#FunctionName#" SIZE="#Attributes.Size1#" <CFIF Attributes.Width1 is not "">STYLE="width:#Attributes.Width1#"</CFIF>></CFOUTPUT>
	<!--- SPECIAL FIRST ITEM, IF REQUESTED --->
	<CFIF Attributes.EmptyText1 is not ""><CFOUTPUT><OPTION VALUE="">#Attributes.EmptyText1#</CFOUTPUT></CFIF>
	<!--- GENERATE REMAINING ITEMS FROM QUERY --->
	<CFOUTPUT QUERY="MyQuery" GROUP="#Attributes.Display1#"><OPTION VALUE="#Evaluate(Attributes.Value1)#">#Evaluate(Attributes.Display1)#</CFOUTPUT>
	
  <!--- "FORCE WIDTH" OPTION AT BOTTOM, IF REQUESTED --->
	<CFIF Attributes.ForceWidth1 is not ""><CFOUTPUT><OPTION VALUE="">#RepeatString(Attributes.ForceWidthChar, Attributes.ForceWidth1)#</CFOUTPUT></CFIF>
<CFOUTPUT></SELECT></CFOUTPUT>
</div>
</div>

<div class="form-group">

<!--- INSERT ANY REQUESTED HTML BETWEEN THE TWO SELECT BOXES --->
<CFOUTPUT><label class="col-sm-5 control-label">#Attributes.HTMLBetween#</label></CFOUTPUT>

<div class="col-sm-7">
<!--- OUTPUT SECOND SELECT BOX --->
<CFOUTPUT><SELECT class="select2"  NAME="#Attributes.Name2#" SIZE="#Attributes.Size2#" <CFIF Attributes.onChange is not "">onChange="#Attributes.OnChange#"</CFIF> <CFIF Attributes.Width2 is not "">STYLE="width:#Attributes.Width2#"</CFIF>></CFOUTPUT>
	<!--- SPECIAL FIRST ITEM, IF REQUESTED --->
	<CFIF Attributes.EmptyText2 is not ""><CFOUTPUT><OPTION VALUE="">#Attributes.EmptyText2#</CFOUTPUT></CFIF>
	
	<!--- GENERATE REMAINING ITEMS FROM QUERY --->
	<!--- WE ONLY NEED TO OUTPUT THE CHOICES FOR THE FIRST GROUP --->
	<CFSET FirstGroup = Evaluate("MyQuery.#Attributes.Display1#")>
	<CFIF Attributes.EmptyText1 is "">
		<CFLOOP QUERY="MyQuery">
		  <CFIF Evaluate(Attributes.Display1) is FirstGroup>
			  <CFOUTPUT><OPTION VALUE="#Evaluate(Attributes.Value2)#">#Evaluate(Attributes.Display2)#</CFOUTPUT>
			<CFELSE>
			  <CFBREAK>
			</CFIF>
		</CFLOOP>
	</CFIF>	

  <!--- "FORCE WIDTH" OPTION AT BOTTOM, IF REQUESTED --->
	<CFIF Attributes.ForceWidth2 is not ""><CFOUTPUT><OPTION VALUE="">#RepeatString(Attributes.ForceWidthChar, Attributes.ForceWidth2)#</CFOUTPUT></CFIF>
<CFOUTPUT></SELECT></CFOUTPUT>
</div>
</div>

<!--- REMOVE THIS AND FIRST LINE IF NOT USING CF3.1 OR LATER --->
<CFSETTING ENABLECFOUTPUTONLY="NO">
	
<script src="/comptroller/includes/themes/MuraBootstrap3/js/ledger/jquery.base64.js"></script>
<script src="/comptroller/includes/themes/MuraBootstrap3/js/ledger/select2.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
  $(".select2").select2();
});
</script>  