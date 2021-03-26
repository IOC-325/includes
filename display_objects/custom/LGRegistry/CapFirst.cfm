<cfscript>
/**
 * Capitalizes the first letter in each word.
 * Made udf use strlen, rkc 3/12/02
 * 
 * @param string 	 String to be modified. 
 * @return Returns a string. 
 * @author Raymond Camden (ray@camdenfamily.com) 
 * @version 1.1, March 12, 2002 
 */
function CapFirst(str) {
	var newstr = "";
	var word = "";
	var i = 1;
	var strlen = listlen(str," ");
	for(i=1;i lte strlen;i=i+1) {
		word = ListGetAt(str,i," ");
		newstr = newstr & UCase(Left(word,1));
		if(len(word) gt 1) newstr = newstr & Right(word,Len(word)-1);
		if(i lt strlen) newstr = newstr & " ";
	}
	return newstr;
}
</cfscript>
