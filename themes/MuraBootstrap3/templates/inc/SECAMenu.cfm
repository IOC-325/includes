<cfset varAboutSECA = "">
<cfif FindNoCase("/about-seca/", $.content().getURL()) NEQ 0>
    <cfset varAboutSECA = " active">
</cfif>

<cfset varCharity = "">
<cfif FindNoCase("/about-seca/becoming-a-seca-charity/", $.content().getURL()) NEQ 0>
    <cfset varCharity = "active">
</cfif>

<cfset varBenefits = "">
<cfif FindNoCase("/about-seca/benefits-of-payroll-deduction/", $.content().getURL()) NEQ 0>
    <cfset varBenefits = "active">
</cfif>

<cfset varContributionHelps = "">
<cfif FindNoCase("/about-seca/how-your-seca-contribution-helps/", $.content().getURL()) NEQ 0>
    <cfset varContributionHelps = "active">
</cfif>

<cfset varGuidelines = "">
<cfif FindNoCase("/about-seca/suggested-giving-guidelines/", $.content().getURL()) NEQ 0>
    <cfset varGuidelines = "active">
</cfif>

<cfset varMyths = "">
<cfif FindNoCase("/about-seca/sece-myths/", $.content().getURL()) NEQ 0>
    <cfset varMyths = "active">
</cfif>


<cfoutput>
<nav class="navbar subnavbar" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##bs-example-navbar-collapse-2">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/about/seca/">SECA</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
        <ul class="nav navbar-nav">
            <li class="hide-first"><a href="/about/seca/">SECA Home</a></li>
            <li class="dropdown#varAboutSECA#">
                <a href="/about/seca/about-seca/" class="dropdown">About SECA</a>
                <ul class="dropdown-menu">
                    <li class="#varCharity#"><a href="/about/seca/about-seca/becoming-a-seca-charity">Becoming a SECA Charity</a></li>
                    <li class="#varBenefits#"><a href="/about/seca/about-seca/benefits-of-payroll-deduction/">Benefits of Payroll deduction</a></li>
                    <li class="#varContributionHelps#"><a href="/about/seca/about-seca/how-your-seca-contribution-helps/">How Your SECA Contribution Helps</a></li>
                    <li class="#varGuidelines#"><a href="/about/seca/about-seca/suggested-giving-guidelines/">Suggested Giving Guidelines</a></li>
                    <li class="#varMyths#"><a href="/about/seca/about-seca/sece-myths/">SECA myths</a></li>
                </ul>
            </li>
            <li><a href="/about/seca/charity-search/">Charity Search</a></li>
            <li><a href="/comptroller/assets/File/SECA/2019 SECA Booklet FINAL revised, 10-4-19.pdf" target="_blank">SECA Booklet</a></li>
            <li><a href="/about/seca/forms/">Forms</a></li>
            <li><a href="/about/seca/seca-agency-ambassadors/">Contact Agency Ambassador</a></li>
            <li><a href="/about/seca/state-retirees-seca-information/">State Retirees SECA information</a></li>
        </ul>
    </div><!-- /.navbar-collapse -->
</nav>
</cfoutput>

<script>
    // Add hover effect to menus

    var $nav = $('.navbar-collapse > ul > li');
    $nav.hover(
            function() {
                $('a',this).first().css({"background-color":"yellow"});
            },
            function() {
                $('a',this).first().css({"background-color":"transparent"});
            }
    );

</script>