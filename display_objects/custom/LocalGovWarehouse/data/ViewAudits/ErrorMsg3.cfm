<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Error</title>
</head>

<body>

<cfoutput>
<center>
<table border="0" cellpadding="1" cellspacing="1">
<tr><td><A HREF="http://www.ioc.state.il.us/"><img src="#LeftMenuImage#" alt="#NameOfComptroller#" width="#LeftMenuImgWidth#" height="#LeftMenuImgHeight#" border="0" align="top"></a></td>
<td>&nbsp;</td>
<td><center><font face="Candara" size="+2" color="Navy">#HeadingLine1#</font><br>
	<font face="Candara" size="+2" color="burlywood"><b>#HeadingLine2#</b></font><br>
	<font face="Candara" size="+1" color="Black">#HeadingLine3#</font><br>
	<font face="Candara" size="+1" color="Black">#HeadingLine4#</font><br>
	<hr size="1" width="100%" color="##D3BB78">
	<font face="Candara" size="+2" color="Black"><b>#HeadingLine5#</b></font><br>
	</center></td>
</tr>
</table>
</cfoutput>
<br>
<center><b><h2>An Error has Occurred!</b></h2></center><br><br>
<cfoutput>Error Reason: <b><font color="red">#Url.ErrorMsg#</font></b><br><br>
If you received this error message then the process was not completed.  Please try it again.<br><br>
<a href="#url.UrlReturn#">Click here to return</a></cfoutput>
</body>
</html>
