<cfsetting showdebugoutput="true">
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
	<meta name="google-site-verification" content="ShpzxpVpQlHE-kqsEC1va-RU5-qcW_GY3Y3wrwC_nhw" />
	<meta name="generator" content="Mura CMS #$.globalConfig('version')#">
	<CFIF CGI.ALL_HTTP Contains "news-portal">
		<meta property="og:image" content="http://illinoiscomptroller.gov/comptroller/cache/file/1BBE1449-5056-93B5-5E61FD531B7E1641.png"/>
	</CFIF>
	<title>#HTMLEditFormat($.content('HTMLTitle'))# - #HTMLEditFormat($.siteConfig('site'))#</title>

	<!--- Bootstrap core CSS --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/bootstrap/css/bootstrap.min.css">

	<!--- 	<!--- Bootstrap PRINT CSS - Andy Added 2015-08-20 --->
	<link rel="stylesheet" href="/comptroller/css/print.css"> --->

	<!--- Bootstrap theme compiled below --->
	<!--- Font Awesome --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/font-awesome/css/font-awesome.css">
	<!--- Mura CMS --->
	<link rel="stylesheet" href="#$.siteConfig('assetPath')#/css/mura.6.1.1.min.css">
	<!--- Get Weather Plugin --->
	<link href="#$.siteConfig('themeAssetPath')#/assets/get-weather/css/webfont/climacons-font.css" rel="stylesheet" type="text/css">

	<!--- CfStatic THEME CSS --->
	<cf_CacheOMatic key="globalheadercss">
		#$.static()
			.include('/css/theme/')
			.renderIncludes('css')#
	</cf_CacheOMatic>

	<!--- IOC XTRA CSS --->
	<link rel="stylesheet" href="#$.siteConfig('assetPath')#/css/IOC_xtras.css">
	<link href="#$.siteConfig('themeAssetPath')#/assets/ioc_css.css" rel="stylesheet" type="text/css">
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


	<!--- CAPCHA --->
	<script src='https://www.google.com/recaptcha/api.js'></script>
</head>
</cfoutput>
