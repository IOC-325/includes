<!---<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script> --->
<style>
/*------------------------------------------------*/
/*  Media Queries
/*------------------------------------------------*/

<!---
.tab-tvScrollY.tvimages {
    width:10px !important;
}
--->
<!---Tablet--->

@media (max-width: 800px) {
    #covid-img-updates{
        height: 100%;
        width: 100%;
    }

}

<!--- Phone --->
@media (max-width: 500px) {
    .tableauPlaceholder{
        height: 1700px;
    }
    .tableauViz{
        height: 1700px;
    }
    #all-in-illinois {
        width:75%;
    }
}
<!--- See https://help.tableau.com/current/pro/desktop/en-us/dashboards_dsd_create.htm for info on pixels --->
</style>
<!--- The line below includes the Mura Component that contains the Content for the text describing COVID-19 efforts --->
<cfoutput>#$.dspObject('component', '3F8006A5-974E-5C0E-F8C3B104A7038E55')#</cfoutput>



    
    <!--- <p align="center">Data is currently being refreshed. Please check back later.</p>  --->  
  <!--- TABLEAU --->

    <!---<div class="text-center">--->

 <!---
<script type='text/javascript' src='https://analytics.illinoiscomptroller.gov/javascripts/api/viz_v1.js'></script>
<div class='tableauPlaceholder' style='width: 1100px; height: 1727px;'>
<object class='tableauViz' width='1100' height='1727' style='display:none;'>
        <param name='host_url' value='https%3A%2F%2Fanalytics.illinoiscomptroller.gov%2F' /> 
        <param name='embed_code_version' value='3' /> 
        <param name='site_root' value='&##47;t&##47;Development' />
        <param name='name' value='P-Covid-19Expensesv1_5_15919077363050&##47;DBGraphs' />
        <param name='tabs' value='no' />
        <param name='toolbar' value='yes' />
        <param name='showAppBanner' value='false' />
        <param name='filter' value='iframeSizedToWindow=true' />
        <param name='showShareOptions' value='false' /> 
        <param name='dataDetails' value='no' />
        <param name='alerts' value='no'/>
        <param name='subscriptions' value='no'/>
</object>
</div>
--->

<!--- working code
<script type='text/javascript' src='https://analytics.illinoiscomptroller.gov/javascripts/api/viz_v1.js'></script>
<div class='tableauPlaceholder' style='width: 1100px; height: 1727px;'>
<object class='tableauViz' width='1100' height='1727' style='display:none;'>
        <param name='host_url' value='https%3A%2F%2Fanalytics.illinoiscomptroller.gov%2F' />
        <param name='embed_code_version' value='3' /> 
        <param name='site_root' value='&##47;t&##47;Development' />
        <param name='name' value='P-Covid-19Expensesv1_6&##47;DBGraphs' />
        <param name='tabs' value='no' />
        <param name='toolbar' value='yes' />
        <param name='showAppBanner' value='false' />
        <param name='filter' value='iframeSizedToWindow=true' />
        <param name='showShareOptions' value='false' /> 
        <param name='dataDetails' value='no' />
        <param name='alerts' value='no'/>
        <param name='subscriptions' value='no'/>
</object>
</div> 
--->

<!--- syed code --->
<script type='text/javascript' src='https://analytics.illinoiscomptroller.gov/javascripts/api/viz_v1.js'></script><div class='tableauPlaceholder' style='width: 1100px; height: 1727px;'><object class='tableauViz' width='1100' height='1727' style='display:none;'><param name='host_url' value='https%3A%2F%2Fanalytics.illinoiscomptroller.gov%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='&#47;t&#47;Development' /><param name='name' value='P-Covid-19Expensesv1_9&#47;DBGraphs' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='showAppBanner' value='false' /><param name='filter' value='iframeSizedToWindow=true' /></object></div>

<!--- <p><a href="/comptroller/assets/file/COVID-19/CovidData.txt">Download complete dataset</a>.</p> --->

<p><a href="https://illinoiscomptroller.gov/filebin/COVID-19/COVID19DATA.csv">Download complete dataset as a CSV</a>.</p>


<Cfoutput>
<div class="text-center">
  <!---     <img id="covid-img-updates"  style="margin-top:15px;" src="https://uat.illinoiscomptroller.gov/comptroller/assets/Image/COVID/webUpdate.png" height="50%" width="50%" alt="Most Recent COVID-19 Updates"> ---></cfoutput> 
</div>
    <h3 id="covid19-links" class="text-center margintop30"><strong>COVID-19 Helpful Links</strong></h3>
    <div class="row row-eq-height">
        <div class="col-xs-12 col-sm-6">
    <div class="home-panel panel panel-default">
        <div class="panel-heading">
            <h4>Help for Individuals and Families</h4>
        </div>
        <div class="panel-body">
            <ul>    
                <li><a href="https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/prevention.html?CDC_AA_refVal=https%3A%2F%2Fwww.cdc.gov%2Fcoronavirus%2F2019-ncov%2Fprepare%2Fprevention.html">Tips on staying safe via the Center for Disease Control</a></li>
                <li><a href="https://www2.illinois.gov/sites/OECD/Pages/For-Communities.aspx">Emergency Child Care Information during COVID-19</a></li>
                <li><a href="https://www.samhsa.gov/sites/default/files/virtual-recovery-resources.pdf">Virtual Mental Health and Substance Abuse Resources</a></li>
                <li><a href="https://www.isbe.net/Pages/covid19.aspx">Public K-12 Education-Information and Updates</a></li>
                <li><a href="https://www2.illinois.gov/sites/coronavirus/Resources/Pages/VolunteerOpportunities.aspx">Volunteer Opportunities</a></li>
                <li>Donate: <a href="https://www.ilcovidresponsefund.org/">IL COVID-19 Response Fund</a></li>
                <li><a href="https://www2.illinois.gov/idhhc/Pages/COVID-19-Resources.aspx">American Sign Language Videos of Key Guidance on COVID-19</a></li>
                <li><a href="/comptroller/assets/2018/COVID 19 small business scams ENG.pdf">Beware of Small Business Scams</a></li>
            </ul>
        </div>
    </div>
        </div>
        <div class="col-xs-12 col-sm-6">
        <div class="home-panel panel panel-default">
            <div class="panel-heading">
                <h4>Updated COVID-19 Resources</h4>
            </div>
            <div class="panel-body">
                <ul>
                    <li><a href="https://www2.illinois.gov/sites/gov/newsroom/Pages/default.aspx">Illinois Governor JB Pritzker???s daily press conference</a>
                        <ul>
                            <li><a href="http://www.dph.illinois.gov/covid19/governor-pritzkers-executive-orders-and-rules">Executive Orders and Rules</a></li>
                            <li><a href="https://coronavirus.illinois.gov/">coronavirus.illinois.gov</a></li>         
                        </ul>
                    </li>
                    <li><a href="https://www.dph.illinois.gov/covid19">State of Illinois Department of Public Health</a>
                        <ul>
                            <li><a href="http://dph.illinois.gov/contact-us/idph-regional-health-departments">Local Departments of Public Health</a></li>
                            <li><a href="http://www.dph.illinois.gov/covid19/covid19-statistics">Illinois COVID-19 Statistics</a></li>
                        </ul>
                    </li>
                    <li><a href="https://www2.illinois.gov/iema/">IL Emergency Management Agency</a></li>
                    <li><a href="https://www2.illinois.gov/ides/Pages/COVID-19-and-Unemployment-Benefits.aspx">IL Department of Employment Security Unemployment FAQ's</a></li>                                        
                    <li><a href="https://www2.illinois.gov/idol/Pages/default.aspx">IL Department of Labor COVID-19 FAQ's for Employees</a></li>                                        
                    <li><a href="https://www.cdc.gov/coronavirus/2019-ncov/community/organizations/businesses-employers.html">CDC Guidance for Businesses and Employers</a></li>
                </ul>
            </div>
        </div>
            </div>
    </div>
    <div class="panel panel-default margintop10">
        <div class="panel-heading">
            <h4>Financial Assistance</h4>
        </div>
        <div class="panel-body">
            <ul>
                <li><a href="https://www.irs.gov/coronavirus/non-filers-enter-payment-info-here">Federal Stimulus Check Status</a></li>
                <li><a href="https://www2.illinois.gov/ides/Pages/default.aspx">Filing an Unemployment Claim - IL Dept of Employment Security (IDES)</a></li>
                <li><a href="https://www2.illinois.gov/ides/News%20%20Announcements%20Doc%20Library/Federal-Stimulus-UI-FAQ-March2020.pdf">Updates on Stimulus Package Unemployment Benefits (PDF)</a></li>
                <li>Information for the Business Community:
                    <ul>
                        <li><a href="https://covid19relief.sba.gov/#/">Small Businesses Seeking Relief - Federal CARES Act</a></li>
                        <li><a href="https://www.sba.gov/partners/lenders/7a-loan-program/pilot-loan-programs">Applications for Loans and Other Benefits - Federal CARES Act</a></li>
                        <li><a href="https://www2.illinois.gov/dceo/SmallBizAssistance/Pages/EmergencySBAIntiatives.aspx?fbclid=IwAR0VEqhhtfFGvazeMuLoAzcEDg5VPEyrsVfmkV6YzubXoFnb7o9KryTCp6Y">IL Department of Commerce & Economic Opportunity - Emergency Business Grants</a></li>
                        <li><a href="https://www.cookcountyil.gov/content/covid-19-response-information-business-community">Cook County Community Recovery Initiative</a></li>
                        <li><a href="https://www.chicago.gov/city/en/depts/bacp/supp_info/covid19resources.html">City of Chicago Small Business Relief (BACP)</a></li>
                        <li><a href="https://www2.illinois.gov/dceo/SmallBizAssistance/Pages/EmergencySBAIntiatives.aspx">Downstate Small Business Stabilization Program</a></li>
                    </ul>
                </li>
                <li><a href="https://abe.illinois.gov/abe/access/">Apply online for healthcare, food, or cash assistance benefits</a></li>
                <li><a href="/comptroller/assets/2018/COVID 19 scams_FINAL.pdf">Beware of Potential COVID-19 Fraud-Related Scams</a></li>
            </ul>
        </div>
    </div>
    <div class="text-center">
       <img id="all-in-illinois" style="background-color:#3C40DA;" src="https://uat.illinoiscomptroller.gov/comptroller/assets/Image/COVID/allinillinois-1.png" width="25%" alt="#allinillinois"> 
    </div> 