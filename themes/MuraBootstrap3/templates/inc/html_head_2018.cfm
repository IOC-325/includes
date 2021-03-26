<cfoutput>
<!DOCTYPE html>
<html lang="en"<cfif $.hasFETools()> class="mura-edit-mode"</cfif>>
<head>
	<meta name="msvalidate.01" content="2DB73436A1AC16BE5EE0B7192F861C49" />
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="#esapiEncode('html_attr', $.content('metaDesc'))#">
	<meta name="keywords" content="#esapiEncode('html_attr', $.content('metaKeywords'))#">
	<cfif len($.content('credits'))><meta name="author" content="#esapiEncode('html_attr', $.content('credits'))#"></cfif>
	<cfif YesNoFormat($.content('searchExclude'))><meta name="robots" content="noindex"></cfif>
	<meta name="generator" content="Mura CMS #$.globalConfig('version')#">
	<title>#esapiEncode('html', $.content('HTMLTitle'))# - #esapiEncode('html', $.siteConfig('site'))#</title>
	<!--- Mura CMS Base Styles--->
	<link rel="stylesheet" href="/comptroller/includes/themes/MuraBootstrap3/css/theme/mura/css/mura.7.0.min.css?v=#$.siteConfig('version')#">

	<!--- Bootstrap core CSS --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/bootstrap-slider.css">	

	<!--- Font Awesome --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/font-awesome/css/font-awesome.css">

	<!---
				THEME CSS
				This has been compiled using a pre-processor such as CodeKit or Prepros
	--->
	<!--- <link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/css/theme/theme.min.css"> --->

	<!--- custom css for comptroller site --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/css/theme/illinois.css">
   

	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/css/ledger/jquery.dataTables.min.css" type="text/css">
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/css/ledger/buttons.dataTables.min.css" type="text/css">
<!--- 	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/css/bootstrap-datepicker.css" rel="stylesheet" type="text/css"> --->


	<!--[if IE]>
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/css/ie/ie.min.css">
	<![endif]-->

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="#$.siteConfig('themeAssetPath')#/js/html5shiv/html5shiv.js"></script>
	<script src="#$.siteConfig('themeAssetPath')#/js/respond/respond.min.js"></script>
	<![endif]-->

	<!--- jQuery --->
	<script src="/comptroller/jquery/jquery.js"></script>
	<script src="/comptroller/jquery/jquery-ui.js"></script>	

	<script type="text/javascript">
	var cachebuster = Math.round(new Date().getTime() / 1000);
	document.write('<scr'+'ipt type="text/javascript" src="/comptroller/includes/themes/MuraBootstrap3/js/theme/comptroller.js?cb=' +cachebuster+'"></scr' + 'ipt>');
	</script>

	<!--- FAV AND TOUCH ICONS --->
        <link rel="shortcut icon" href="/RDA/assets/images/favicon.ico.png" type="image/x-icon">
	<!--- <link rel="apple-touch-icon-precomposed" sizes="144x144" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-144-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-114-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-72-precomposed.png">
	<link rel="apple-touch-icon-precomposed" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-57-precomposed.png"> --->

	<!--- MURA FEEDS --->
	<cfset rs=$.getBean('feedManager').getFeeds($.event('siteID'),'Local',true,true) />
	<cfset apiEndpoint=$.siteConfig().getApi('feed','v1').getEndpoint() />
	<cfloop query="rs"><link rel="alternate" type="application/rss+xml" title="#esapiEncode('html_attr', $.siteConfig('site'))# - #esapiEncode('html_attr', rs.name)#" href="#XMLFormat('#apiEndpoint#/?feedID=#rs.feedID#')#"></cfloop>

	<!--- CAPCHA --->
	<script src='https://www.google.com/recaptcha/api.js'></script>
	
</head>
</cfoutput>
