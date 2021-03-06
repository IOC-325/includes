<!---
	This file is part of Mura CMS.

	Mura CMS is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, Version 2 of the License.

	Mura CMS is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

	Linking Mura CMS statically or dynamically with other modules constitutes 
	the preparation of a derivative work based on Mura CMS. Thus, the terms 
	and conditions of the GNU General Public License version 2 ("GPL") cover 
	the entire combined work.

	However, as a special exception, the copyright holders of Mura CMS grant 
	you permission to combine Mura CMS with programs or libraries that are 
	released under the GNU Lesser General Public License version 2.1.

	In addition, as a special exception, the copyright holders of Mura CMS 
	grant you permission to combine Mura CMS with independent software modules 
	(plugins, themes and bundles), and to distribute these plugins, themes and 
	bundles without Mura CMS under the license of your choice, provided that 
	you follow these specific guidelines: 

	Your custom code 

	• Must not alter any default objects in the Mura CMS database and
	• May not alter the default display of the Mura CMS logo within Mura CMS and
	• Must not alter any files in the following directories:

		/admin/
		/tasks/
		/config/
		/requirements/mura/
		/Application.cfc
		/index.cfm
		/MuraProxy.cfc

	You may copy and distribute Mura CMS with a plug-in, theme or bundle that 
	meets the above guidelines as a combined work under the terms of GPL for 
	Mura CMS, provided that you include the source code of that other code when 
	and as the GNU GPL requires distribution of source code.

	For clarity, if you create a modified version of Mura CMS, you are not 
	obligated to grant this special exception for your modified version; it is 
	your choice whether to do so, or to make such modified version available 
	under the GNU General Public License version 2 without this exception.  You 
	may, if you choose, apply this exception to your own modified versions of 
	Mura CMS.
--->
<cfcomponent extends="mura.cfobject" output="false">

	<!---
			This is the THEME eventHandler.cfc 

			* Add theme-specific eventHandlers here
			* This file is much like a controller in a MVC application 
			* Reload the application when additions/changes are made to THIS file!
	--->

	<cffunction name="onApplicationLoad" access="public" output="false">
		<cfscript>
			// make sure 'Home' page set to 'Page/Home'
			var homeBean = arguments.$.getBean('content').loadBy(filename='');
			if ( homeBean.getValue('subType') != 'Home' ) {
				homeBean
					.setValue('subType', 'Home')
					.setValue('template', 'home.cfm')
					.save();
			}
		</cfscript>
	</cffunction>
	<cffunction name="onSiteRequestStart" access="public" output="false" returntype="any">
		<cfargument name="$" hint="mura scope" />
		<cfscript>
			// http://dominicwatson.github.io/cfstatic/full-guide.html (See Configuration section)
			// if in production, set checkForUpdates=false
			arguments.$.static(
				outputDirectory = 'compiled'
				, checkForUpdates = !arguments.$.siteConfig('cache')
				, lessGlobals = ExpandPath($.siteConfig('themeAssetPath') & '/css/less-globals/globals.less')
			);
		</cfscript>
	</cffunction>


	<cffunction name="onRenderStart" access="public" output="true" returntype="any">
		<cfargument name="$" hint="mura scope" />
		
		<cfscript>
		
			// force Home layout template if subtype is 'Home'
			if ( arguments.$.content('subtype') == 'Home' ) {
				arguments.$.content('template', 'home.cfm');
			}


			// force Summary page view for Link and File content types
			if ( arguments.$.event('showMeta') != 2 ) {
				arguments.$.event('showMeta', 1);
			}
	
			// for code syntax highlighting
			try {
				arguments.$.loadPrettify();
			} catch(any e) {
				// Mura CMS version is probably older than 6.1
			}
		
			// for code syntax highlighting
			try {
				arguments.$.loadPrettify();
			} catch(any e) {
				// Mura CMS version is probably older than 6.1
			}
		</cfscript>
	</cffunction>
	
	<cfscript>
		public any function onComponentTeamListBodyRender($) {
			var str = '';
			savecontent variable='str' {
				WriteOutput(arguments.$.dspThemeInclude('class_extensions/display/componentTeamList.cfm'));
			}
			return str;
		}
	</cfscript>

</cfcomponent>