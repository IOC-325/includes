<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!--><html lang="en" class="no-js"> <!--<![endif]-->
<!---<head>--->
	<!---<title>Vendor Payments</title>--->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="Vendor Payments">
	<meta name="author" content="Gary Ashbaugh">
    
    <link rel="stylesheet" href="<cfoutput>#$.siteConfig('themeAssetPath')#</cfoutput>/assets/bootstrap/css/CustomEVRLayoutFormatting.css">
    
<h1>How does this verification work?</h1>

Automated programs can't "read" the images you see in the boxes: only humans can. When you select the image, it ensures us that the content is coming from a real person. This also helps to reduce system loads which improves website performance.<br><br>

If you don't see an image, make sure your browser is set to display images and try again. If you're not sure what image is being requested refer to the list below. If you're incorrect, you'll get another chance to select an image.<br><br>


<cfset ListSorted = "">

<cfStoredProc datasource="VendorPayment" Procedure="Get_ListofGlyphicons">
    <cfprocparam type="Out" cfsqltype="cf_sql_integer" dbvarname="@RetVal" variable="CheckNoVendorCoordinatorRetVal">
    <cfprocparam type="Out" cfsqltype="cf_sql_varchar" dbvarname="@RetMsg" variable="CheckNoVendorCoordinatorRetMsg">
    <cfprocresult name="GetListOfGlyphicons">
</cfstoredproc>
<p class="bold">Below is the list of possible images</p>
<div class="row">
	<div class="col-xs-3 col-sm-1"><b><u>Image</u></b></div>
    <div class="col-xs-4 col-sm-2 nomargin"><b><u>Description</u></b></div>
</div>
<cfoutput query="GetListOfGlyphicons">
<div class="row margintop10">
	<div class="col-xs-3 col-sm-1"><i class="#GLYPHICONSNAME#"></i></div>
	<div class="col-xs-4 col-sm-2 nomargin">#GLYPHICONSDescription#</div>
</div>
</cfoutput>

<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="/comptroller/jquery/jquery.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/jquery.masked-input.min.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/bootstrap.js"></script>
    <script src="/comptroller/includes/themes/MuraBootstrap3/assets/bootstrap/js/tooltip.js"></script>
    