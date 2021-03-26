<cfoutput>
	<script type="text/javascript" src="#$.siteConfig('themeAssetPath')#/js/bx-slider/jquery.bxslider.min.js"></script>
	<script>
		$(document).ready(function(){
		  $('.bx-slider').bxSlider({
		    slideWidth: 140,
		    minSlides: 2,
		    maxSlides: 5,
		    slideMargin: 0,
		    auto: true
		  });
		});
	</script>
</cfoutput>