<cfoutput>
    <body id="#$.getTopID()#" class="#$.createCSSHook($.content('menuTitle'))#" data-spy="scroll" data-target=".subnav" data-offset="50">
        <div class="bgimg-1 aboutMe">
            <cfinclude template="inc/html_head_2018.cfm" />
            <cfinclude template="inc/navbar_2018.cfm" />

            <div class="caption text-center">
                <span class="border">SUSANA A. MENDOZA</span>
            </div>
        </div>

        <cfoutput>
            <div class="mura-body">
                #$.renderEditableAttribute(attribute="body",type="htmlEditor")#
            </div>
        </cfoutput>

        <div style="clear:both;"></div>
    <cfinclude template="inc/footer_2018.cfm" />
    <cfinclude template="inc/html_foot_2018.cfm" />
</cfoutput>