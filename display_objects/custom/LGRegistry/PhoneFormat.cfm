<cfscript>
/**
 * Allows you to specify the mask you want added to your phone number.
 * v2 - code optimized by Ray Camden
 * 
 * @param varInput 	 Phone number to be formatted. (Required)
 * @param varMask 	 Mask to use for formatting. x represents a digit. (Required)
 * @return Returns a string. 
 * @author Derrick Rapley (adrapley@rapleyzone.com) 
 * @version 1, November 14, 2002 
 */
function PhoneFormat (CEOPhone, xxxxxxxxxx) {
	var curPosition = "";
	var newFormat = "";
	var i = "";
	
	newFormat = " " & reReplace(CEOPhone,"[^[:digit:]]","","all");

	for (i=1; i lte len(trim(xxxxxxxxxx)); i=i+1) {
		curPosition = mid(xxxxxxxxxx,i,1);
		if(curPosition neq "x") newFormat = insert(curPosition,newFormat, i) & " ";
	}

	return trim(newFormat);
}
</cfscript>
