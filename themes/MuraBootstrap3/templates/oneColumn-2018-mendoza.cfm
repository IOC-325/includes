<cfoutput>
  <cfinclude template="inc/html_head_2018.cfm" />
  <body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
  <cfinclude template="inc/navbar_2018.cfm" />

    <section class="content">
        <!--- 
        The Content
        See the file located under '/display_objects/page_default/index.cfm' to override body styling
        --->
        <cfoutput>
          <div class="container">
            <div class="image">
              <img src="/comptroller/assets/2018/comptroller-mendoza.jpg" width="300" />
            </div>
            <div class="text">
              <h1 class="mura-page-title pageTitle">
                <span>#m.renderEditableAttribute(attribute='title')#</span>
              </h1>
              <span class="mura-body">
                #$.getBody()#
              </span>
            </div>
          </div>
        </cfoutput>
    </section>
    
  <cfinclude template="inc/footer_2018.cfm" />
  <cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>