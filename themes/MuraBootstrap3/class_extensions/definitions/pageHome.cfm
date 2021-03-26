<extension type="Page" subType="Home" hasSummary="0" hasBody="1" hasAssocFile="0" iconClass="icon-home">
	<!-- Banner Options -->
	<attributeset name="Banner Options" container="Basic">
			<attribute 
				name="heroType"
				label="Hero Type"
				hint="Selects whether to use a slider, static banner, or nothing"
				type="SelectBox"
				defaultValue="Static"
				required="false"
				validation=""
				regex=""
				message=""
				optionList="none^static^slider"
				optionLabelList="None^Static Banner^Slider" />
				
			<attribute 
				name="feedName"
				label="Feed Name"
				hint="If using a banner, enter the name of feed you want to use"
				type="TextBox"
				defaultValue="Slides"
				required="false"
				validation=""
				regex=""
				message=""
				optionList=""
				optionLabelList="" />
	</attributeset>
	<!-- // Banner Options // -->
</extension>