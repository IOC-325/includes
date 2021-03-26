<cfoutput>
	<cfinclude template="inc/html_head.cfm" />
	<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">
		<cfinclude template="inc/navbar.cfm" />
<style>

    .vendor-container .panel-heading{
        padding:10px 15px;
    }
    .vendor-container .panel-body{
        padding:15px !important;
    }
    .vendor-container .padding-calss{
        padding-left:10px !important;
        padding-right:10px !important;
    }
    .panel-default>.panel-heading {
    color: white !important;
    background-color: ##283D58 !important;
   }
   .mt-10{
        margin-top: 10px;
    }
    .linking-font b{
        font-size: 12px;
    }
</style>

<div class="container vendor-container clearfix">
    <br>

    <div class="col-sm-offset-1 col-sm-5">
        <cfinclude template="/comptroller/includes/display_objects/custom/vendor/index.cfm">
    </div>

    <div class="col-sm-5">
      <cfinclude template="/comptroller/includes/display_objects/custom/vendorEnhanced/index.cfm">
    </div>

</div>
			<!--- Above Footer Objects --->
			<div id="aboveFooter">
				<div class="container">
					<cfif $.getParentId() eq '85D715F4-1CC1-DE6E-2F48C6B0E8FF59E0'>
						<h4 class="members-title">MEMBERS</h4>
						<div class="col-xs-12 col-sm-8 col-sm-offset-2 members-listing">
							#$.dspObjects(5)#
						</div>
					<cfelse>
						#$.dspObjects(5)#
					</cfif>
				</div>
			</div>

	<cfinclude template="inc/footer.cfm" />
	<cfinclude template="inc/html_foot.cfm" />
	<script src="#$.siteConfig('assetPath')#/jquery/CustomSearch.js"></script>
</cfoutput>