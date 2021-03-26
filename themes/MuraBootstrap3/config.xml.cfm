<!--
	To add mobile-specific content fields to your Edit Content screen:
	1) Uncomment the extension type='base' node below with the 'Mobile Options' in it
	2) Reload Application
	3) That's it!
-->
<theme>

	<imagesizes>
		<imagesize name="carouselimage" width="1200" height="500" />
		<imagesize name="gridimage" width="370" height="250" />
	</imagesizes>

	<extensions>
		
		<extension type="Folder" subType="Collapse">
		</extension>
		
		<cfinclude template="class_extensions/definitions/pageHome.cfm" />
		<cfinclude template="class_extensions/definitions/pageTestimonial.cfm" />
		<cfinclude template="class_extensions/definitions/folderTestimonials.cfm" />
		<cfinclude template="class_extensions/definitions/folderTeam.cfm" />
		<cfinclude template="class_extensions/definitions/pageTeamMember.cfm" />
		<cfinclude template="class_extensions/definitions/site.cfm" />
		<cfinclude template="class_extensions/definitions/baseDefault.cfm" />
		<cfinclude template="class_extensions/definitions/folderCollapse.cfm" />
		<cfinclude template="class_extensions/definitions/componentTeamList.cfm" />
		
	</extensions>

</theme>