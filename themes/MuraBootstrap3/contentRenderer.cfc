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
<cfcomponent extends="mura.cfobject">


	<!---
			This is the THEME contentRenderer.cfc

			* Add theme-specific methods here
			* Any methods here will be accessible with the following notation:
				$.yourFunctionName()
	--->

	<cfscript>
	
		
		// GENERAL 
		this.jsLib = "jquery";
		this.jsLibLoaded = true;
		this.suppressWhitespace = true;
		this.generalWrapperClass = "well";
		
		// headings
		this.headline = "h1";
		this.subHead1 = "h2";
		this.subHead2 = "h3";
		this.subHead3 = "h4";
		this.subHead4 = "h5";

		// nav and list item vars
		this.navWrapperClass = this.generalWrapperClass;
		this.liHasKidsClass = "";
		this.liHasKidsCustomString = "";
		this.liCurrentClass = "active";
		this.liCurrentCustomString = "";
		this.aHasKidsClass = "";
		this.aHasKidsCustomString = "";
		this.aCurrentClass = "active";
		this.aCurrentCustomString = "";
		this.ulTopClass = "nav nav-list";
		this.ulNestedClass = "nav nav-list";
		this.ulNestedCustomString = "";
		this.liNestedClass = "";

		// pagination vars
		this.ulPaginationClass = "pagination";
		this.ulPaginationWrapperClass = "";

		// form vars
		this.formWrapperClass = "well";
		this.formFieldWrapperClass = "form-group";
		this.formFieldLabelClass = "control-label";
		this.formInputWrapperClass = "input-group";
		this.formInputClass ="form-control";
		this.formCheckboxClass = "";
		this.formButtonWrapperClass = "btn-group";
		this.formButtonInnerClass="input-group-btn";
		this.formButtonClass = "btn btn-primary";
		this.formRequiredWrapperClass="";
		
		// images
		this.imageClass="img-thumbnail";
		
		// tables
		this.tableClass = "table table-bordered table-striped";
		this.tableHeadClass = "";
		this.tableHeaderClass = "";
		this.tableBodyClass = "";
		this.tableRowClass = "";
		this.tableCellClass = "";
		this.tableFooterClass = "";
		
		// alerts
		this.alertSuccessClass = "alert alert-success";
		this.alertInfoClass = "alert alert-info";
		this.alertWarningClass = "alert alert-warning";
		this.alertDangerClass = "alert alert-danger";
		
		// SPECIFIC (Display Objects)
		// Use these variables to pass-in specific classes without having to create custom versions of the include
		
		// calendar/dsp_showMonth.cfm
		this.calendarWrapperClass="";
		this.calendarTableClass=this.tableClass;
		//this.calendarTableHeaderClass="";
		
		// calendar/dspList.cfm
		this.calendarListWrapperClass="";
		
		// comments/index.cfm
		 this.commentsWrapperClass="";
		 this.commentSortContainerClass="row";
		 this.commentSortWrapperClass="col-xs-5";
		 this.commentSortSelectClass=this.formInputClass;
		 this.commentFormWrapperClass="";
		 this.commentFormClass="";
		 this.commentNewClass=this.formButtonClass;
		 this.commentFieldWrapperClass=this.formFieldWrapperClass;
		 this.commentFieldLabelClass=this.formFieldLabelClass;
		 this.commentInputWrapperClass="";
		 this.commentInputClass=this.formInputClass;
		 this.commentCheckboxClass="";
		 this.commentPrefsInputWrapperClass="";
		 this.commentSubmitButtonWrapperClass="";
		 this.commentSubmitButtonClass="btn btn-primary";
		 this.commentMoreCommentsUpClass="btn btn-default icon-arrow-up";
		 this.commentMoreCommentsDownClass="btn btn-default icon-arrow-down";
		 this.commentMoreCommentsContainer="";
		 this.commentRequiredWrapperClass="";
		 this.commentThumbClass="img-thumbnail";
		 this.commentSpamClass="";
		 this.commentSpamLinkClass="";
		 this.commentClass="";
		 this.commentDateTimeClass="";
		 this.commentReplyClass="";
		 this.commentAwaitingApproval="";
		 this.commentAdminButtonWrapperClass="btn-group pull-right";
		 this.commentUserEmailClass="btn btn-default btn-sm";
		 this.commentDeleteButtonClass="btn btn-default btn-sm";
		 this.commentEditButtonClass="btn btn-default btn-sm";
		 this.commentApproveButtonClass="btn btn-default btn-sm";	
		 	
		// comments/dsp_comment.cfm
	 	this.emailLinkClass=this.formButtonClass;
		this.commentsLinkClass=this.formButtonClass;
		this.approveCommentLinkClass=this.formButtonClass;
		this.deleteCommentLinkClass=this.formButtonClass;
		
		// dataresponses/dsp_detail.cfm
		this.dataResponseListClass="dl-horizontal";
		
		// dataresponses/dsp_list.cfm
		this.dataResponseTableClass="table table-hover";
		this.dataResponsePaginationClass=this.ulPaginationClass;
		
		// draggablefeeds/index.cfm
		this.draggableBoxWrapperClass="row";
		this.draggableBoxHeaderClass="col-lg-12";
		this.draggableBoxRSSWrapperClass="";
		this.draggableBoxHeaderButtonClass=this.formButtonClass;
		//this.draggableBoxRSSeditFormClass="";
		this.draggableBoxAddFeedWrapperClass="well clearfix";
		this.draggableBoxNewFeedFormClass="form-horizontal";
		this.draggableBoxSelectFeedWrapperClass="col-lg-6";
		this.draggableBoxSelectFeedRowClass="row";
		this.draggableBoxSelectFeedMenuClass=this.formFieldWrapperClass;
		this.draggableBoxSelectFeedMenuDivClass="col-lg-10";
		this.draggableFeedMenuSelectFieldClass=this.formInputClass;
		this.addFeedButtonWrapperDivClass=this.formFieldWrapperClass;
		this.addFeedButtonWrapperDivInnerClass="col-lg-2";
		this.addFeedButtonClass=this.formButtonClass;
		
		// dsp_categories_nest.cfm
		this.categoriesNestCheckboxClass="checkbox";
		
		// dsp_content_list.cfm
		this.contentListImageStyles=false;
		this.contentListImagePadding=20;  //must be pixels
		this.contentListPropertyMap={
			containerEl={tag="div"},
			itemEl={tag="dl",class="clearfix"},
			labelEl={tag="span"},
			title={tag="dt"},
			date={tag="dt"},
			credits={tag="dd",showLabel=false,rbkey="list.by"},
			tags={tag="dd",showLabel=true,labelDelim=":",rbkey="tagcloud.tags"},
			rating={tag="dd",showLabel=true,labelDelim=":",rbkey="list.rating"},
			"default"={tag="dd"}
		};
		this.contentListWrapperDivClass="";
		this.contentListItemImageLinkClass="";
		
		// dsp_folder.cfm
		this.folderWrapperClass="";
		
		// dsp_edit_profile.cfm
		this.editProfileWrapperClass="";
		this.editProfileFormClass="form-horizontal";
		this.editProfileFormGroupWrapperClass=this.formFieldWrapperClass;
		this.editProfileFieldLabelClass="control-label col-lg-3";
		this.editProfileFormFieldsWrapperClass="col-lg-9";
		this.editProfileFormFieldsClass=this.formInputClass;
		this.editProfileExtAttributeDownloadClass="col-lg-3";
		this.editProfileHelpBlockClass="help-block";
		this.editProfileExtAttributeFileWrapperClass="col-lg-offset-3 col-lg-6";
		this.editProfileExtAttributeDownloadClass="col-lg-3";
		this.editProfileExtAttributeDownloadButtonClass=this.formButtonClass;
		this.editProfileSubmitButtonWrapperClass="col-lg-offset-3 col-lg-9";
		this.editProfileSubmitButtonClass="btn btn-primary";
		this.editProfileSuccessMessageClass=this.alertSuccessClass;
		
		// dsp_email_dropdown.cfm
		this.emailDropdownSelectClass="dropdown";
		
		// dsp_event_reminder_form.cfm
		this.eventReminderFormWrapperClass="";
		this.eventReminderFormClass=this.generalWrapperClass;
		this.eventReminderFieldWrapperClass="";
		this.eventReminderFormLabelsClass=this.formFieldLabelClass;
		this.eventReminderSubmitClass=this.formButtonClass;
		
		// dsp_features.cfm
		this.featuresWrapperClass="clearfix";
		
		// dsp_feed.cfm
		this.localIndexWrapperClass="clearfix";
		this.remoteFeedWrapperClass="clearfix";
		
		// dsp_login.cfm
		this.loginWrapperClass="";
		this.loginWrapperInnerClass="row";
		this.loginFormClass="form-horizontal form-signin";
		this.forgotPasswordFormClass="form-horizontal form-sendlogin";
		this.loginFormGroupWrapperClass=this.formFieldWrapperClass;
		this.loginFormFieldLabelClass="control-label col-lg-3";
		this.loginFormFieldWrapperClass="col-lg-9";
		this.loginFormFieldClass=this.formInputClass;
		this.loginFormPrefsClass="col-lg-offset-3 col-lg-10";
		this.loginFormCheckboxClass="checkbox";
		this.loginFormSubmitWrapperClass="col-lg-offset-3 col-lg-10";
		this.loginFormSubmitClass="btn btn-primary";
		this.notRegisteredLinkClass="btn btn-primary";
		
		// dsp_mailing_list_master.cfm
		this.mailingListWrapperClass=this.generalWrapperClass;
		this.mailingListFormClass="form-horizontal";
		this.mailingListFormGroupWrapperClass="";
		this.mailingListFormLabelClass="";
		this.mailingListFormFieldWrapperClass="";
		this.mailingListFormInputClass=this.formInputClass;
		this.mailingListCheckboxWrapperClass="";
		this.mailingListCheckboxClass="checkbox";
		this.mailingListSubmitWrapperClass="";
		this.mailingListSubmitClass=this.formButtonClass;
		
		// dsp_nextN.cfm
		this.nextNWrapperClass="";
		this.nextNInnerClass="row";
		
		// dsp_search_form.cfm
		this.searchFormClass="navbar-form";
		this.searchFormInputWrapperClass=this.formInputWrapperClass;
		this.searchFormInputClass=this.formInputClass;
		this.searchFormSubmitWrapperClass=this.formButtonInnerClass;
		this.searchFormSubmitClass="btn btn-default fa fa-search";
		
		// dsp_search_results.cfm
		this.searchResultWrapperClass="";
		this.searchResultInnerClass="row";
		this.searchResultsRowClass="row";
		this.searchResultsMoreResultsRowClass="row";
		this.searchResultsListClass="";
		this.searchResultsPagerClass="pager";
		this.searchAgainRowClass="row";
		this.searchAgainInnerClass="col-md-8";
		this.searchAgainFormClass="navbar-form";
		this.searchAgainInputWrapperClass=this.formInputWrapperClass;
		this.searchAgainFormInputClass=this.formInputClass;
		this.searchAgainButtonWrapperClass=this.formButtonInnerClass;
		this.searchAgainSubmitClass=this.formButtonClass;
		
		// dsp_user_tools.cfm
		this.userToolsLoginWrapperClass="well clearfix";
		this.userToolsLoginFormClass="form-horizontal";
		this.userToolsFormGroupWrapperClass=this.formFieldWrapperClass;
		this.userToolsLoginFormLabelClass="control-label col-lg-2";
		this.userToolsLoginFormInputWrapperClass="col-lg-10";
		this.userToolsLoginFormInputClass=this.formInputClass;
		this.userToolsLoginFormFieldInnerClass="col-lg-offset-2 col-lg-10";
		this.userToolsLoginFormCheckboxClass="checkbox";
		this.userToolsLoginFormSubmitClass="btn btn-primary";
		this.userToolsNotRegisteredLinkClass="btn btn-primary";
		this.userToolsWrapperClass="clearfix";
		this.userToolsEditProfileLinkClass="btn btn-primary fa fa-user";
		this.userToolsLogoutLinkClass="btn btn-primary fa fa-sign-out";
		
		// formbuilder/dsp_form.cfm
		this.formBuilderFieldWrapperClass=this.formFieldWrapperClass;
		this.formBuilderButtonWrapperClass="form-submit-button";
		this.formBuilderSubmitClass="btn btn-primary";
		
		// formbuilder/fields/dsp_checkbox.cfm
		// formbuilder/fields/dsp_dropdown.cfm 
		// formbuilder/fields/dsp_file.cfm
		// formbuilder/fields/dsp_radio.cfm
		// formbuilder/fields/dsp_textfield.cfm
		
		this.formBuilderFormFieldsClass=this.formInputClass;
		
		// formbuilder/fields/field_dropdown.cfm
		this.formBuilderTabHeaderClass="dropdown";
		this.formBuilderDisabledInputClass="disabled";
		this.formBuilderCheckboxClass="checkbox";
		
		// gallery/index.cfm
		this.galleryWrapperClass="";
		this.galleryULClass="clearfix";
		this.galleryThumbnailClass="thumbnail";
		
		// nav/calendarNav/index.cfm
		this.navCalendarWrapperClass="";
		
		// nav/calendarNav/navTools.cfc
		this.navCalendarTableClass="table table-bordered";
		
		// nav/dsp_sequential.cfm
		this.navSequentialWrapperClass="";
		this.navSequentialInnerClass="row";
		
		// nav/dsp_tag_cloud.cfm
		this.tagCloudWrapperClass="";
		
		// navArchive
		//this.navArchiveWrapperClass="";
		//this.navArchiveListClass="";
		
		
		// rater/index.cfm
		this.raterObjectWrapperClass="row clearfix";
		this.raterWrapperClass="col-lg-12";
		this.avgRatingWrapperClass="col-lg-12";
		
		// Generic form vars
		this.formWrapperClass = "";
	
		// used to populate selectbox class extensions with a list of feeds
			public any function getLocalFeeds() {
				return variables.$.getBean('feedManager').getFeeds(siteid=variables.$.event('siteid'), type='local');
			}

			public any function getLocalFeedNames() {
				var rs = getLocalFeeds();
				return rs.getRecordcount() 
					? ValueList(rs.name, '^') 
					: 'No Content Collections Exist!';
			}

	// Helpers
		public any function dspComponent(string componentid) {
			var bean = IsValid('uuid', arguments.componentid)
				? variables.$.getBean('content').loadBy(contentid=arguments.componentid)
				: variables.$.getBean('content').loadBy(title=arguments.componentid, type='Component');

			return !bean.getIsNew() 
				? variables.$.dspObject(object='component', objectid=bean.getContentID())
				: '';
		}
	</cfscript>
	<cffunction name="getSubNav">
		<cfif listfind( variables.$.getPath(), variables.$.getContentId() ) eq 2>
			<cfset topLevelKids = variables.$.getKidsIterator() />
		<cfelse>
			<cfset topLevelId = listgetAt( variables.$.getPath(), 2 ) />
			<cfset topLevel = variables.$.getBean('content').loadby( contentId = topLevelId )>
			<cfset topLevelKids = topLevel.getKidsIterator() />
		</cfif>
		
		<cfoutput>
			<cfsavecontent variable="ret">
				<cfloop condition="topLevelKids.hasNext()">
					<cfset item = topLevelKids.next() />
					<cfif item.getIsNav() eq 1>
						<li <cfif item.getContentId() eq variables.$.getContentId()>class='active'</cfif>>
      <!--- RK Commented this as part of the SR #1015 --->
							<!--- <cfif listfind( variables.$.getPath(), '90C85DE5-EE21-C59A-6BFCCAF029E310FE' )>
								<cfset ahref = "##" & item.getURLTitle() />
							<cfelse> --->
								<cfset ahref = item.getURL() />
							<!--- </cfif> --->
							<a href="#ahref#" >#item.getTitle()#</a>

						</li>
					</cfif>
				</cfloop>
			</cfsavecontent>
		</cfoutput>
		
		<cfreturn ret />
	</cffunction>

	<cffunction name="getFiscalFocusArticles">

		<cfif !isNumeric( variables.$.event('acount') )>
			<cfset variables.$.event('acount', 5 ) />
		</cfif>

		<cfif !isNumeric( variables.$.event('startRow') ) or variables.$.event('startRow') lte 0>
			<cfset variables.$.event('startRow', 1 ) />
		</cfif>

		<cfset article = variables.$.getBean('feed')>
		  <cfset article.setMaxItems( 9999 )>
		  <cfset article.setNextN( variables.$.event('acount') )>
		  <cfset article.addParam( field="parentId", criteria="90D8114D-D2FF-C407-B3BC3708F7CE8BC0")>
		  <cfset article.addParam( field="type", criteria="Page")>
		  <cfset article.setShowNavOnly(0)>
		  <cfset article.setSortBy('orderNo')>
		  <cfset article.setSortDirection('asc')>
		  <cfset itArticle = article.getIterator() />
		  <cfset itArticle.setStartRow( variables.$.event('startRow') ) />
		<cfreturn itArticle />

	</cffunction>

	<cffunction name="getFiscalFocusArchiveArticles">

<!--- 		<cfif !isNumeric( variables.$.event('acount') )>
			<cfset variables.$.event('acount', 5 ) />
		</cfif>

		<cfif !isNumeric( variables.$.event('startRow') ) or variables.$.event('startRow') lte 0>
			<cfset variables.$.event('startRow', 1 ) />
		</cfif> --->

		<cfset article = variables.$.getBean('feed')>
		  <cfset article.setMaxItems( 9999 )>
		  <cfset article.setNextN( 9999 )>
		  <!--- <cfset article.setNextN( variables.$.event('acount') )> --->
		  <cfset article.addParam( field="parentId", criteria="90F569BB-FDAE-502C-6FB5C537B18D53D6")>
		  <cfset article.addParam( field="type", criteria="Page")>
		  <cfset article.setShowNavOnly(0)>
		  <cfset article.setSortBy('releaseDate')>
		  <cfset article.setSortDirection('desc')>
		  <cfset itArticle = article.getIterator() />
		  <!--- <cfset itArticle.setStartRow( variables.$.event('startRow') ) /> --->
		<cfreturn itArticle />

	</cffunction>
	<cffunction name="dspCarouselByFeedName" output="false">
		<cfargument name="feedName" type="string" default="Slideshow" />
		<cfargument name="showCaption" type="boolean" default="true" />
		<cfargument name="cssID" type="string" default="myCarousel" />
		<cfargument name="size" type="string" default="custom" hint="If you want to use a custom height/width, then use 'custom' ... otherwise, you can use 'small, medium, large' OR any other predefined custom image size 'name' you created via the back-end administrator." />
		<cfargument name="width" type="numeric" default="1280" hint="width in pixels" />
		<cfargument name="height" type="numeric" default="500" hint="height in pixels" />
		<cfargument name="interval" type="any" default="5000" hint="Use either milliseconds OR use 'false' to NOT auto-advance to next slide." />
		<cfargument name="autoStart" type="boolean" default="true" />
		<cfargument name="showIndicators" type="boolean" default="true" />
		<cfscript>
			var local = {};
			local.imageArgs = {};

			if ( not ListFindNoCase('small,medium,large,custom', arguments.size) and variables.$.getBean('imageSize').loadBy(name=arguments.size,siteID=variables.$.event('siteID')).getIsNew() ) {
				arguments.size = 'custom';
			};

			if ( not Len(Trim(arguments.size)) or LCase(arguments.size) eq 'custom' ) {
				local.imageArgs.width = Val(arguments.width);
				local.imageArgs.height = Val(arguments.height);
			} else {
				local.imageArgs.size = arguments.size;
			};
		</cfscript>
		<cfsavecontent variable="local.str"><cfoutput>
			<!--- BEGIN: Bootstrap Carousel --->
			<!--- IMPORTANT: This will only output items that have associated images --->
			<cfset local.feed = variables.$.getBean('feed').loadBy(name=arguments.feedName)>
			<cfset local.iterator = local.feed.getIterator()>
			<cfif local.feed.getIsNew()>
				<div class="container">
					<div class="alert alert-info alert-block">
						<button type="button" class="close" data-dismiss="alert"><i class="fa fa-remove"></i></button>
						<h4>Ooops!</h4>
						The <strong>#HTMLEditFormat(arguments.feedName)#</strong> Content Collection/Local Index does not exist.
					</div>
				</div>
			<cfelseif local.iterator.hasNext()>
				<div id="#arguments.cssID#" class="carousel slide" data-interval="#arguments.interval#">

					<!--- Indicators --->
					<cfif arguments.showIndicators>
						<ol class="carousel-indicators">
							<cfset local.iterator.reset()>
							<cfset local.idx = 0>
							<cfloop condition="local.iterator.hasNext()">
								<cfset local.item=iterator.next()>
								<cfif ListFindNoCase('jpg,jpeg,gif,png', ListLast(local.item.getImageURL(), '.'))>
									<li data-target="###arguments.cssID#" data-slide-to="#idx#" class="<cfif local.idx eq 0>active</cfif>"></li>
									<cfset local.idx++>
								</cfif>
							</cfloop>
						</ol>
					</cfif>

					<!--- Wrapper for slides --->
					<div class="row carousel-inner">
						<cfset local.iterator.reset()>
						<cfset local.idx = 0>
						<cfloop condition="local.iterator.hasNext()">
							<cfset local.item=iterator.next()>
							<cfif ListFindNoCase('jpg,jpeg,gif,png', ListLast(local.item.getImageURL(), '.'))>
								<div class="row item<cfif local.idx eq 0> active</cfif>">
									<img src="#local.item.getImageURL(argumentCollection=local.imageArgs)#" alt="#HTMLEditFormat(local.item.getTitle())#">
									<cfif arguments.showCaption>
										<div class="container">
											<div class="carousel-caption">
												<h3><a href="#local.item.getURL()#">#HTMLEditFormat(local.item.getTitle())#</a></h3>
												#local.item.getSummary()#
												<p><a class="btn btn-larg btn-primary" href="#local.item.getURL()#">Read More</a></p>
											</div>
										</div>
									</cfif>
								</div>
								<cfset local.idx++>
							</cfif>
						</cfloop>
					</div>

					<cfif local.idx>
						<!--- Controls --->
						<cfif local.idx gt 1>
							<a class="left carousel-control" href="###arguments.cssID#" data-slide="prev"><span class="fa fa-angle-left"></span></a>
							<a class="right carousel-control" href="###arguments.cssID#" data-slide="next"><span class="fa fa-angle-right"></span></a>
							<!--- AutoStart --->
							<cfif arguments.autoStart>
								<script>jQuery(document).ready(function($){$('###arguments.cssID#').carousel({interval:#arguments.interval#});});</script>
							</cfif>
						</cfif>
					<cfelse>
						<div class="alert alert-info alert-block">
							<button type="button" class="close" data-dismiss="alert"><i class="fa fa-remove"></i></button>
							<h4>Oh snap!</h4>
							Your feed has no items <em>with images</em>.
						</div>
					</cfif>
				</div>
			<cfelse>
				<div class="alert alert-info alert-block">
					<button type="button" class="close" data-dismiss="alert"><i class="fa fa-remove"></i></button>
					<h4>Heads up!</h4>
					Your feed has no items.
				</div>
			</cfif>
			<!--- // END: Bootstrap Carousel --->
		</cfoutput></cfsavecontent>
		<cfreturn local.str />
	</cffunction>
	
	<cffunction name="dspBxSlider">
		<cfargument name="feed" required="true">
		<cfset feed=$.getBean("feed").loadBy(name="#arguments.feed#",siteID=$.event("siteid"))>
		<cfset iterator=feed.getIterator()>
			<cfif iterator.hasNext()>
				<cfoutput>
				<cfset $.addToHTMLHeadQueue("#$.siteConfig('themeAssetPath')#/templates/inc/bx-slider-head.cfm")>	
				<cfset $.addToHTMLFootQueue("#$.siteConfig('themeAssetPath')#/templates/inc/bx-slider-foot.cfm")>
				<div class="bx-slider">
					<cfloop condition="iterator.hasNext()">
					<cfset item=iterator.next()>
						<div class="slide">
							<div class="profile-image" style="background-image:url(#item.getImageURL(width=100,height=100)#);"></div>
							<div class="item-summary">#ucase(item.getTitle())#</div>
							<div class="item-author">
								<span><a href="#item.getValue('URL')#">read more</a></span><br>
								<!--- #item.getValue('ShelterName')# --->
							</div> 
						</div>
					</cfloop>
				</div>
				</cfoutput>
			</cfif>
	</cffunction>

	
	<cffunction name="getFullURL" output="false" returntype="string">
		<cfif cgi.https eq 'ON'>
			<cfset variables.str = 'https://' />
		<cfelse>
			<cfset variables.str = 'http://' />
		</cfif>
		
		<cfset variables.str = variables.str & #m.siteConfig('domain')# & '/' & #m.content().getFileName()# />
		
		<cfreturn variables.str />
	</cffunction>
	
	<cffunction name="dspCritterBody"  output="false" returntype="string">
	<cfargument name="body" type="string" default="">
	<cfargument name="pagetitle" type="string" default="">
	<cfargument name="crumblist" type="boolean" default="1">
	<cfargument name="crumbseparator" type="string" default="&raquo;&nbsp;">
	<cfargument name="showMetaImage" type="boolean" default="1">
	<cfargument name="includeMetaHREF" type="boolean" default="true" />
	<cfargument name="bodyAttribute">
	<cfargument name="titleAttribute">
	<cfargument name="metaImageSizeArgs" default="#this.bodyMetaImageSizeArgs#">
	<cfargument name="metaImageClass" default="#this.bodymetaImageClass#">
	<cfargument name="renderKids" default="true">
	
	<cfset var theIncludePath = variables.event.getSite().getIncludePath() />
	<cfset var str = "" />
	<cfset var fileDelim="/" />
	<cfset var eventOutput="" />
	<cfset var rsPages="">
	<cfset var cacheStub="#variables.event.getValue('contentBean').getcontentID()##variables.event.getValue('pageNum')##variables.event.getValue('startrow')##variables.event.getValue('year')##variables.event.getValue('month')##variables.event.getValue('day')##variables.event.getValue('filterby')##variables.event.getValue('categoryID')##variables.event.getValue('relatedID')#">
	<cfset var safesubtype=REReplace(variables.event.getValue('contentBean').getSubType(), "[^a-zA-Z0-9_]", "", "ALL")>
	<cfset variables.event.setValue("BodyRenderArgs",arguments)>
	
	<cfsavecontent variable="str">
		<cfif (variables.event.getValue('isOnDisplay') and (not variables.event.getValue('r').restrict or (variables.event.getValue('r').restrict and variables.event.getValue('r').allow)))
			or (getSite().getextranetpublicreg() and variables.event.getValue('display') eq 'editprofile' and not session.mura.isLoggedIn) 
			or (variables.event.getValue('display') eq 'editprofile' and session.mura.isLoggedIn)>
			<cfif variables.event.getValue('display') neq ''>
				<cfswitch expression="#variables.event.getValue('display')#">
					<cfcase value="editprofile">
						<cfset variables.event.setValue('noCache',1)>
						<cfset variables.event.setValue('forceSSL',getSite().getExtranetSSL())/>
						<cfset eventOutput=application.pluginManager.renderEvent("onSiteEditProfileRender",variables.event)>
						<cfif len(eventOutput)>
						<cfoutput>#eventOutput#</cfoutput>
						<cfelse>
						<cfoutput>#dspObject_Include(thefile='dsp_edit_profile.cfm')#</cfoutput>
						</cfif>
					</cfcase>
					<cfcase value="search">
						<cfset variables.event.setValue('noCache',1)>
						<cfset eventOutput=application.pluginManager.renderEvent("onSiteSearchRender",variables.event)>
						<cfif len(eventOutput)>
						<cfoutput>#eventOutput#</cfoutput>
						<cfelse>
						<cfoutput>#dspObject_Include(thefile='dsp_search_results.cfm')#</cfoutput>
						</cfif>
					</cfcase> 
					<cfcase value="login">
						<cfset variables.event.setValue('noCache',1)>
						<cfset eventOutput=application.pluginManager.renderEvent("onSiteLoginPromptRender",variables.event)>
						<cfif len(eventOutput)>
						<cfoutput>#eventOutput#</cfoutput>
						<cfelse>
						<cfoutput>#dspObject_Include(thefile='dsp_login.cfm')#</cfoutput>
						</cfif>
					</cfcase>
					<cfdefaultcase>
						<cfset variables.event.setValue('noCache',1)>
						<cfset eventOutput=application.pluginManager.renderEvent("onDisplayRender",variables.event)>
						<cfif len(eventOutput)>
							<cfoutput>#eventOutput#</cfoutput>
						<cfelse>
							<cfoutput><p>The display action that you have requested is not valid.</p></cfoutput>
						</cfif>
					</cfdefaultcase>
				</cfswitch>
			<cfelse>

				 <cfoutput>
				 	<cfif structKeyExists(arguments,'titleAttribute')>
				 		<#getHeaderTag('headline')# class="pageTitle" style="margin-top:20px;">#renderEditableAttribute(attribute=arguments.titleAttribute,required=true)#</#getHeaderTag('headline')#>
					<cfelseif arguments.pageTitle neq ''>
						<#getHeaderTag('headline')# class="pageTitle" style="margin-top:20px;"><cfif arguments.pageTitle eq $.content('title')>#renderEditableAttribute(attribute='title',required=true)#<cfelse>#arguments.pageTitle#</cfif></#getHeaderTag('headline')#>
					</cfif>
					<cfif arguments.crumblist>
						#dspCrumbListLinks("crumblist",arguments.crumbseparator)#
					</cfif>			
				</cfoutput>

				<!--- For backwards compatibility --->
				<cfif variables.event.getContentBean().getType() eq 'Folder'>
					<cfset eventOutput=application.pluginManager.renderEvent("onPortalBodyRender",variables.event)>
					<cfif not len(eventOutput)>
						<cfset eventOutput=application.pluginManager.renderEvent("onPortal#variables.event.getContentBean().getSubType()#BodyRender",variables.event)>
					</cfif>
				</cfif>
				<!--- --->
				
				<cfif not len(eventOutput)>
					<cfset eventOutput=application.pluginManager.renderEvent("on#variables.event.getContentBean().getType()##variables.event.getContentBean().getSubType()#BodyRender",variables.event)>
				</cfif>
				<cfif not len(eventOutput)>
					<cfset eventOutput=application.pluginManager.renderEvent("on#variables.event.getContentBean().getType()#BodyRender",variables.event)>
				</cfif>

				<cfif len(eventOutput)>
					<cfoutput>#eventOutput#</cfoutput>
				<cfelseif $.content('type') eq 'Folder' and fileExists(expandPath(theIncludePath)  & fileDelim & "includes" & fileDelim & "themes" & fileDelim & variables.$.siteConfig("theme") & fileDelim & "display_objects" & fileDelim & "custom" & fileDelim & "extensions" & fileDelim & "dsp_Portal_" & safesubtype & ".cfm")>
					 <cfinclude template="#theIncludePath#/includes/themes/#variables.$.siteConfig('theme')#/display_objects/custom/extensions/dsp_#variables.event.getValue('contentBean').getType()#_#safesubtype#.cfm">
				<cfelseif $.content('type') eq 'Folder' and fileExists(expandPath(theIncludePath)  & fileDelim & "includes" & fileDelim & "themes" & fileDelim & variables.$.siteConfig("theme") & fileDelim & "display_objects" & fileDelim & "extensions" & fileDelim & "dsp_Portal_" & safesubtype & ".cfm")>
					 <cfinclude template="#theIncludePath#/includes/themes/#variables.$.siteConfig('theme')#/display_objects/custom/extensions/dsp_#variables.event.getValue('contentBean').getType()#_#safesubtype#.cfm">
				<cfelseif $.content('type') eq 'Folder' and fileExists(expandPath(theIncludePath)  & fileDelim & "includes" & fileDelim & "display_objects" & fileDelim & "custom" & fileDelim & "extensions" & fileDelim & "dsp_Portal_" & safesubtype & ".cfm")>
					 <cfinclude template="#theIncludePath#/includes/display_objects/custom/extensions/dsp_#variables.event.getValue('contentBean').getType()#_#safesubtype#.cfm">
				<cfelseif fileExists(expandPath(theIncludePath)  & fileDelim & "includes" & fileDelim & "themes" & fileDelim & variables.$.siteConfig("theme") & fileDelim & "display_objects" & fileDelim & "custom" & fileDelim & "extensions" & fileDelim & "dsp_" & variables.event.getValue('contentBean').getType() & "_" & safesubtype & ".cfm")>
					 <cfinclude template="#theIncludePath#/includes/themes/#variables.$.siteConfig('theme')#/display_objects/custom/extensions/dsp_#variables.event.getValue('contentBean').getType()#_#safesubtype#.cfm">
				<cfelseif fileExists(expandPath(theIncludePath)  & fileDelim & "includes" & fileDelim & "themes" & fileDelim & variables.$.siteConfig("theme") & fileDelim & "display_objects" & fileDelim & "extensions" & fileDelim & "dsp_" & variables.event.getValue('contentBean').getType() & "_" & safesubtype & ".cfm")>
					 <cfinclude template="#theIncludePath#/includes/themes/#variables.$.siteConfig('theme')#/display_objects/custom/extensions/dsp_#variables.event.getValue('contentBean').getType()#_#safesubtype#.cfm">
				<cfelseif fileExists(expandPath(theIncludePath)  & fileDelim & "includes" & fileDelim & "display_objects" & fileDelim & "custom" & fileDelim & "extensions" & fileDelim & "dsp_" & variables.event.getValue('contentBean').getType() & "_" & safesubtype & ".cfm")>
					 <cfinclude template="#theIncludePath#/includes/display_objects/custom/extensions/dsp_#variables.event.getValue('contentBean').getType()#_#safesubtype#.cfm">
				<cfelse>
					<cfswitch expression="#variables.event.getValue('contentBean').getType()#">
					<cfcase value="File">
						<cfif variables.event.getValue('contentBean').getContentType() eq "Image" 
							and listFind("jpg,jpeg,gif,png",lcase(variables.event.getValue('contentBean').getFileExt()))>
								<cfset loadShadowBoxJS() />
								<cfoutput>
								<div id="svAssetDetail" class="mura-asset-detail image">
								<a href="#variables.$.content().getImageURL(size='large')#" title="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" #this.shadowboxattribute#="shadowbox[body]" id="svAsset" class="mura-asset"><img src="#variables.$.content().getImageURL(argumentCollection=arguments.metaImageSizeArgs)#" class="imgMed #arguments.metaImageClass#" alt="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" /></a>
								#renderEditableAttribute(attribute="summary",type="htmlEditor")#
								</div>
								</cfoutput>
						<cfelse>
								<cfoutput>
								<div id="svAssetDetail" class="mura-asset-detail file">
								#renderEditableAttribute(attribute="summary",type="htmlEditor")#
								<a href="#$.content().getURL('showMeta=2&ext=.#$.content().getFileExt()#')#" title="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" id="svAsset" class="mura-asset #lcase(variables.event.getValue('contentBean').getFileExt())#">Download File</a>							
								</div>
								</cfoutput>
						</cfif>				
					</cfcase>
					<cfcase value="Link">
						<cfoutput>
						<div id="svAssetDetail" class="mura-asset-detail link">
							#renderEditableAttribute(attribute="summary",type="htmlEditor")#	
							<a href="#$.content().getURL('showMeta=2&ext=.#$.content().getFileExt()#')#" title="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" id="svAsset" class="mura-asset url">View Link</a>							
						</div>
						</cfoutput>
					</cfcase>
					<cfdefaultcase>
						<cfif arguments.showMetaImage
							and len(variables.event.getValue('contentBean').getFileID()) 
							and variables.event.getValue('contentBean').getContentType() eq "Image" 
							and listFind("jpg,jpeg,gif,png",lcase(variables.event.getValue('contentBean').getFileExt()))>
								<cfset loadShadowBoxJS() />
								<cfoutput>
								<cfif arguments.includeMetaHREF>
									<a href="#variables.$.content().getImageURL(size='large')#" title="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" #this.shadowboxattribute#="shadowbox[body]" id="svAsset" class="mura-asset"><img src="#variables.$.content().getImageURL(argumentCollection=arguments.metaImageSizeArgs)#" class="imgMed #arguments.metaImageClass#" alt="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" /></a>
									<cfelse>
									<div id="svAsset" class="mura-asset">
									<img src="#variables.$.content().getImageURL(size='medium')#" class="imgMed #arguments.metaImageClass#" alt="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" />
									</div>
								</cfif>
								</cfoutput>	
						</cfif>		
						<cfoutput>
							<cfif structKeyExists(arguments,'bodyAttribute')>
								#renderEditableAttribute(attribute=arguments.bodyAttribute,type="htmlEditor")#
							<cfelseif $.content('body') eq arguments.body>
								#renderEditableAttribute(attribute="body",type="htmlEditor")#
							<cfelse>
								#setDynamicContent(arguments.body)#
							</cfif>		
						</cfoutput>
					</cfdefaultcase>
					</cfswitch>
					<cfif arguments.renderKids>
						<cfswitch expression="#variables.event.getValue('contentBean').gettype()#">
						<cfcase value="Folder">
							<cf_CacheOMatic key="FolderBody#cacheStub##getListFormat()#" nocache="#variables.event.getValue('r').restrict#">
							 <cfoutput>#dspObject_Include(thefile='dsp_portal.cfm')#</cfoutput>
							</cf_CacheOMatic>
						</cfcase> 
						<cfcase value="Calendar">
							 <cf_CacheOMatic key="calendarBody#cacheStub##getListFormat()#" nocache="#variables.event.getValue('r').restrict#">
							 <cfoutput>#dspObject_Include(thefile='calendar/index.cfm')#</cfoutput>
							 </cf_CacheOMatic>
						</cfcase> 
						<cfcase value="Gallery">
							<cfset loadShadowBoxJS() />
							<cfset addToHTMLHeadQueue("gallery/htmlhead/gallery.cfm")>
							<cfif not variables.event.valueExists('galleryItemID')><cfset variables.event.setValue('galleryItemID','')></cfif>
							<cf_CacheOMatic key="galleryBody#cacheStub##variables.event.getValue('galleryItemID')##getListFormat()#" nocache="#variables.event.getValue('r').restrict#">
							<cfoutput>#dspObject_Include(thefile='gallery/index.cfm')#</cfoutput>
							</cf_CacheOMatic>
						</cfcase> 
						</cfswitch>
					</cfif>
				</cfif>		
			</cfif> 
		<cfelseif variables.event.getValue('isOnDisplay') and variables.event.getValue('r').restrict and variables.event.getValue('r').loggedIn and not variables.event.getValue('r').allow >
			<cfset eventOutput=application.pluginManager.renderEvent("onContentDenialRender",variables.event)>
			<cfif len(eventOutput)>
			<cfoutput>#eventOutput#</cfoutput>
			<cfelse>
			<cfoutput>#dspObject_Include(thefile='dsp_deny.cfm')#</cfoutput>
			</cfif>
		<cfelseif variables.event.getValue('isOnDisplay') and variables.event.getValue('r').restrict and not variables.event.getValue('r').loggedIn>
			<cfset variables.event.setValue('noCache',1)>
			<cfset eventOutput=application.pluginManager.renderEvent("onSiteLoginPromptRender",variables.event)>
			<cfif len(eventOutput)>
			<cfoutput>#eventOutput#</cfoutput>
			<cfelse>
			<cfoutput>#dspObject_Include(thefile='dsp_login.cfm')#</cfoutput>
			</cfif>
		<cfelse>
			<cfset eventOutput=application.pluginManager.renderEvent("onContentOfflineRender",variables.event)>
			<cfif len(eventOutput)>
			<cfoutput>#eventOutput#</cfoutput>
			<cfelse>
			<cfoutput>#dspObject_Include(thefile='dsp_offline.cfm')#</cfoutput>
			</cfif>
		</cfif>
	</cfsavecontent>
	
	<cfreturn str />
</cffunction>

</cfcomponent>
