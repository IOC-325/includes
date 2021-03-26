<extension type="Component" subType="TeamList" hasBody="0">
	<attributeset name="Team Details" container="basic">
		<!--- Feed List --->
		<attribute 
			name="contentListFeed"
			label="Content Listing Content Collection/Local Index Feed Name"
			hint="Select the name of the Local Content Collection/Index to use"
			type="selectbox"
			defaultValue="[mura]ListFirst($.getLocalFeedNames(), '^')[/mura]"
			required="false"
			validation=""
			regex=""
			message=""
			optionList="[mura]$.getLocalFeedNames()[/mura]"
			optionLabelList="[mura]$.getLocalFeedNames()[/mura]" />
			
		<attribute 
			name="tlPhotos"
			label="Show Photos?"
			hint=""
			type="SelectBox"
			defaultValue="1"
			required="false"
			validation=""
			regex=""
			message=""
			optionList="1^0"
			optionLabelList="Yes^No" />
		<attribute 
			name="tlDesc"
			label="Show Descriptions?"
			hint=""
			type="SelectBox"
			defaultValue=""
			required="false"
			validation=""
			regex=""
			message=""
			optionList="1^0"
			optionLabelList="Yes^No" />
	</attributeset>
</extension>