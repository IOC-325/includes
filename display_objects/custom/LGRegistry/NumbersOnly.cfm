<cfscript>
/**
 * Strips all non-numeric characters from a string.
 * Modified by RCamden to use one line of code.
 * 
 * @param str 	 String to format. (Required)
 * @return Returns a string. 
 * @author Mindframe, Inc. (info@mindframe.com) 
 * @version 1, September 6, 2002 
 */
function NumbersOnly(CEOPhone) {
	return reReplace(CEOPhone,"[^[:digit:]]","","all");
}
</cfscript>
