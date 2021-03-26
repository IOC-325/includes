<cfoutput>
		<!--- Bootstrap JavaScript --->
		<script src="#$.siteConfig('themeAssetPath')#/assets/bootstrap/js/bootstrap.min.js"></script>

		<!--- CfStatic JS --->
		<cf_CacheOMatic key="globalfooterjs">
			#$.static().include('/js/theme/').renderIncludes('js')#
		</cf_CacheOMatic>
		
		<script src="/comptroller/includes/themes/MuraBootstrap3/js/ledger/ledger.js"></script>
		
		<script type="text/javascript">
			jQuery(function($) {
				$('.desc').responsiveEqualHeightGrid();
			});
		</script>
				
	</body>
</html>
</cfoutput>