<style>
    .bgimg-1, .bgimg-2, .bgimg-3, .bgimg-4 {
        position: relative;
        /*opacity: 0.65;*/
        background-attachment: fixed;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;

    }
    .bgimg-1 {
        background-image: url("/comptroller/assets/2018/parallax1.jpg");
        min-height: 500px;
    }

    .bgimg-2 {
        background-image: url("/comptroller/assets/2018/parallax4.jpg");
        min-height: 400px;
    }

    .bgimg-3 {
        background-image: url("/comptroller/assets/2018/parallax2.jpg");
        display: table;
        padding: 100px 0;
    }

    .bgimg-4 {
        background-image: url("/comptroller/assets/2018/parallax6.jpg");
        /*background-position: center 35%;*/
        display: table;
        padding: 140px 0;
    }

    .parallax-paragraph{
        padding: 30px 40px;
        text-align: justify;
    }

    .caption {
        position: absolute;
        left: auto;
        bottom: 60px;
        right: 40px;
        color: black;
    }

    .caption-left, .caption-right{
        display: table-cell;
        width: 50%;
    }

    .caption-left{
        float: left;
        margin: 0 0 0 20px;
    }

    .caption-right{
        float: right;
        margin: 0 20px 0 0;
    }

    .caption-inner{
        background: rgba(255, 255, 255, 0.8);
        padding: 30px 40px;
        color: black;
        text-align: justify;
    }

    .caption-inner > :last-child {
        margin: 0;
    }

    .caption span.border {
        background-color: black;
        color: white;
        padding: 18px;
        font-size: 25px;
        letter-spacing: 10px;
    }

    /* Turn off parallax scrolling for tablets and phones */
    @media only screen and (max-device-width: 1024px) {
        .bgimg-1, .bgimg-2, .bgimg-3, .bgimg-4 {
            background-attachment: scroll;
        }
    }
</style>


<cfoutput>
    <body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
    <div class="bgimg-2">
    <cfinclude template="inc/html_head_2018.cfm" />

    <cfinclude template="inc/navbar_2018.cfm" /></div>

    <div class="container-fluid">
        <section class="content">
            <!---
                The Content
                See the file located under '/display_objects/page_default/index.cfm' to override body styling
            --->
            <cfoutput>
            <!--- Primary Associated Image --->
            <cfif $.content().hasImage(usePlaceholder=false)>
                <cfscript>
                    img = $.content().getImageURL(
                        size = 'medium' // small, medium, large, custom, or any other pre-defined image size
                            ,complete = false // set to true to include the entire URL, not just the absolute path (default)
                            );
                </cfscript>

            </cfif>
            <!--- /Primary Associated Image --->
            <!---<cfif $.content( 'hidePageTitle' ) neq 'yes'>
                <cfif structKeyExists( variables, "img" )>
                        <h1 class="mura-page-title pageTitle">
                            <img src="#img#" style="margin-right: 14px; width:110px"><span>#m.renderEditableAttribute(attribute='title')#</span>
                        </h1>
                    <cfelse>
                        <h1 class="mura-page-title pageTitle">
                            <span>#m.renderEditableAttribute(attribute='title')#</span>
                        </h1>
                </cfif>
            </cfif>--->
            <div class="mura-body">
                #$.renderEditableAttribute(attribute="body",type="htmlEditor")#
                <div class="bgimg-1">
                    <div class="caption text-center">
                        <span class="border">SUSANA A. MENDOZA</span>
                    </div>
                </div>
                <div class="parallax-paragraph">
                    <p>Susana A. Mendoza was sworn in as Illinois Comptroller on December 5, 2016, after running for office on a platform of prioritizing the most vulnerable residents at a time when the State had gone without a budget for more than two years.</p>
                    <p>In her first year in office, Mendoza brought together members of both parties to pass the Debt Transparency Act, which, for the first time, provides residents and legislators with a monthly accounting of the debts owed by every state agency. Though the Governor vetoed the legislation, Republican and Democratic members of the House of Representatives unanimously overrode the veto. A second bipartisan vote in favor in the Illinois Senate was nearly unanimous. </p>
                    <p>During a time of historic fiscal crisis, Mendoza has been an advocate for stability, comprehensive budget solutions, and open and transparent financial reporting.</p>
                    <p>The Office of the Illinois Comptroller is charged with maintaining the State's central fiscal accounts and ordering payments into and out of the funds. The Comptroller's Office maintains a website that gives residents detailed information about the State's fiscal health, employee salaries, outstanding bills, and vendor contracts. Mendoza recently oversaw a revamp of the website to make it user-friendly and easier to navigate. </p>
                </div>

                <div class="bgimg-2">

                </div>

                <div class="parallax-paragraph">
                    <p>Mendoza is a trailblazer when it comes to women in politics. She was the first Hispanic independently elected to statewide office in Illinois after her historic win as the first woman elected City Clerk in Chicago in 2011.</p>
                    <p>Mendoza was elected during a special election to fill out the remaining two years of the term won by her friend, the late Comptroller Judy Baar Topinka.</p>
                    <p>Following Topinka's example of offering candid assessments of State finances regardless of whether or not they ruffled feathers in either party, Mendoza quickly began delivering on a promise to be a truth-telling fiscal watchdog.</p>
                    <p>Born in Chicago's Little Village neighborhood to Mexican immigrants Joaquin and Susana Mendoza, Mendoza moved to the southwest suburbs as a child, driven from her neighborhood by gang violence. Mendoza made a name for herself early on as a soccer superstar. Growing up playing as the only girl on all-boys traveling teams, she was often the best player. Mendoza was a standout athlete in high school, earning All-State and All-Midwest Honors and becoming the first woman to make the Bolingbrook High School Wall of Fame.</p>
                </div>

                <div class="bgimg-3">
                    <div class="caption-left">
                        <div class="caption-inner">
                            <p>Mendoza won a soccer and academic scholarship to Truman State University in Missouri, earning All-Midwest honors in soccer and graduating in 1994 with a B.A. in Business Administration. She moved back to Little Village and worked in advertising/public relations, the hospitality industry and the City of Chicago's Department of Planning and Development.</p>
                        </div>
                    </div>
                </div>

                <div class="parallax-paragraph">
                    <p>Mendoza was elected to the Illinois House of Representatives in 2000 as the youngest member of the Illinois General Assembly and served six terms, representing communities in Chicago's southwest side including the neighborhood in which she was born. In the General Assembly, Mendoza was recognized for her leadership and legislation on social services, education, law enforcement, job creation, and animal welfare. She was a leading sponsor of HR 1650 which created the panel to impeach former Governor Rod Blagojevich, and she served as an active alternate member of the impeachment committee.</p>
                    <p>In 2011, Mendoza was elected Chicago City Clerk, taking charge of an office responsible for more than $100 million in annual revenue. Working closely with animal rights groups, Mendoza took on the puppy mill industry and won, spearheading the Companion Animal and Consumer Protection Ordinance. This new law effectively banned Chicago pet stores from selling dogs, cats, or rabbits unless the animals are sourced from humane shelters or animal rescues.</p>
                    <p>She successfully transitioned 1.3 million Chicagoans away from an inefficient and archaic seasonal Chicago city vehicle sticker sales program to a streamlined year-round sales program. Her massive technology overhaul and forward-thinking policies led to reduced fraud, increased efficiency and new revenues for the City of Chicago at lower taxpayer cost.</p>
                    <p>Both then as Clerk, and now as Comptroller, Mendoza has worked to make government more open, accountable, and transparent.</p>
                </div>

                <div class="bgimg-4">
                    <div class="caption-right">
                        <div class="caption-inner">
                            <p>Comptroller Mendoza is championing a package of transparency legislation advancing through the State legislature. Among those items is Mendoza's Truth in Hiring bill, which requires governors to report all their employees on the Governor's payroll instead of concealing them in other state agency payrolls. Both houses of the legislature passed the bill to overwhelming bipartisan veto-proof majorities. The legislation awaits the Governor's signature.</p>
                            <p>Mendoza lives in Chicago's Portage Park neighborhood with her husband, David Szostak, their 5-year-old son David Quinten Szostak, and her 82-year-old mother.</p>
                        </div>
                    </div>
                </div>

            </div>
            <!--- /Body --->
            </cfoutput>
        </section>
    </div><!-- /.container -->

    <cfinclude template="inc/footer_2018.cfm" />
    <cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>