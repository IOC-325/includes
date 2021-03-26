<cfscript>
/**
 * Strips all characters from a string except the ones that you want to keep.
 * 
 * @param strSource 	 The string to strip. (Required)
 * @param strKeep 	 List of  characters to keep. (Required)
 * @param beCS 	 Boolean that determines if the match should be case sensitive. Default is true. (Optional)
 * @return Returns a string. 
 * @author Scott Jibben (scott@jibben.com) 
 * @version 1, July 2, 2002 
 */
function stripAllBut(str,strip) {
	var badList = "\";
	var okList = "\\";
	var bCS = true;

	if(arrayLen(arguments) gte 3) bCS = arguments[3];

	strip = replaceList(strip,badList,okList);
	
	if(bCS) return rereplace(str,"[^#strip#]","","all");
	else return rereplaceNoCase(str,"[^#strip#]","","all");
}
</cfscript>
