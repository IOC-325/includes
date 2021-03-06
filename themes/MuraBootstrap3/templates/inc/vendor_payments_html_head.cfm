
<cfoutput>
<!DOCTYPE html>
<html lang="en"<cfif $.hasFETools()> class="mura-edit-mode"</cfif>>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="#HTMLEditFormat($.content('metaDesc'))#">
	<meta name="keywords" content="#HTMLEditFormat($.content('metaKeywords'))#">
	<cfif len($.content('credits'))><meta name="author" content="#HTMLEditFormat($.content('credits'))#"></cfif>
	<meta name="generator" content="Mura CMS #$.globalConfig('version')#">

	<title>#HTMLEditFormat($.content('HTMLTitle'))# - #HTMLEditFormat($.siteConfig('site'))#</title>

	<!--- Bootstrap core CSS --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/bootstrap.min.css">
	<!--- Bootstrap theme compiled below --->
	<!--- Font Awesome --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/font-awesome/css/font-awesome.css">
	<!--- Mura CMS --->
	<link rel="stylesheet" href="#$.siteConfig('assetPath')#/css/mura.6.1.min.css">
	<!--- Get Weather Plugin --->
	<link href="#$.siteConfig('themeAssetPath')#/assets/get-weather/css/webfont/climacons-font.css" rel="stylesheet" type="text/css">

	<!--- Gary's Custom CSS for Vendor Login Form, etc --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/CustomVendorLayoutFormatting.css">
	
	<!--- CfStatic THEME CSS --->
	<cf_CacheOMatic key="globalheadercss">
		#$.static()
			.include('/css/theme/')
			.renderIncludes('css')#
	</cf_CacheOMatic>

	<!--[if IE]>
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/css/ie/ie.css">
	<![endif]-->

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="#$.siteConfig('themeAssetPath')#/js/html5shiv/html5shiv.js"></script>
	<script src="#$.siteConfig('themeAssetPath')#/assets/bootstrap/js/respond.min.js"></script>
	<![endif]-->

	<!--- jQuery --->
	<script src="#$.siteConfig('assetPath')#/jquery/jquery.js"></script>
	
	<!--- Get Weather Plugin --->
	<script type="text/javascript" src="#$.siteConfig('themeAssetPath')#/assets/get-weather/js/mustache.js"></script>
	<script type="text/javascript" src="#$.siteConfig('themeAssetPath')#/assets/get-weather/js/whatweather-1.2.min.js"></script>

	<!--- FAV AND TOUCH ICONS --->
	<link rel="shortcut icon" href="#$.siteConfig('themeAssetPath')#/images/ico/favicon.ico">
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-144-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-114-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-72-precomposed.png">
	<link rel="apple-touch-icon-precomposed" href="#$.siteConfig('themeAssetPath')#/images/ico/ico/apple-touch-icon-57-precomposed.png">

	<!--- MURA FEEDS --->
	<cfset rs=$.getBean('feedManager').getFeeds($.event('siteID'),'Local',true,true) />
	<cfloop query="rs"><link rel="alternate" type="application/rss+xml" title="#HTMLEditFormat($.siteConfig('site'))# - #HTMLEditFormat(rs.name)#" href="#XMLFormat('http://#listFirst(cgi.http_host,":")##$.globalConfig('context')#/tasks/feed/?feedID=#rs.feedID#')#"></cfloop>
</head>
</cfoutput>