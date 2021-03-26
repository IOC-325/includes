<extension type="Base" subType="Default">
	<attributeset name="Page Title Settings" container="Basic">
		<attribute 
			name="pageBanner"
			label="Page Title Background Image"
			hint="Choose the background image for page title"
			type="File"
			defaultValue=""
			required="false"
			validation=""
			regex=""
			message=""
			optionList=""
			optionLabelList="" />
		<attribute 
			name="useSectionTitle"
			label="Use as Section Title"
			hint="Make this title the title that shows in subpages as well"
			type="RadioGroup"
			defaultValue="0"
			required="false"
			validation=""
			regex=""
			message=""
			optionList="1^0"
			optionLabelList="Yes^No" />
		<attribute 
			name="useSectionBanner"
			label="Use as Section Banner"
			hint="Make this banner image the banner that shows in subpages as well"
			type="RadioGroup"
			defaultValue="0"
			required="false"
			validation=""
			regex=""
			message=""
			optionList="1^0"
			optionLabelList="Yes^No" />
	</attributeset>
</extension>