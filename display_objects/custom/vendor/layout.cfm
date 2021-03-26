<cfif thistag.executionMode eq "Start">
<CFINCLUDE TEMPLATE="../udfs.cfm">
<cfscript>
	variables.subMenu="WARRANT";
	variables.header="WARRANT STATUS INQUIRY";
	variables.subheader="Check your warrant status here.";
	// variables.title="About the Office of the Comptroller - Daniel W. Hynes";
	//include("/application.cfm");
	cfparam("request.bodytopic","About the Office...");
	cfparam("request.title","Warrant Inquiry - Illinois Comptroller's Office - Daniel W. Hynes");
	variables.menuHeader="WARRANTS";
</cfscript>

<cfoutput>
<html>
<head>
<title>#request.title#</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" type="text/css" href="../site.css">
</head>
<CFINCLUDE TEMPLATE="../menu.cfm">
</cfoutput>
<body bgcolor="#e8e9f2" TOPMARGIN="0" LEFTMARGIN="0">
<table border="0" cellpadding="0" cellspacing="0" width="700">
  <tr>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="8" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="7" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="98" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="37" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="5" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="10" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="219" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="109" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="6" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="74" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="42" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="69" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="13" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
  </tr>

  <tr>
   <td rowspan="15" colspan="2" BACKGROUND="" VALIGN="TOP"><img name="index_r1_c1" src="images/index_r1_c1.jpg" width="9" height="614" border="0" alt=""></td>
   <td colspan="14"><img name="index_r1_c3" src="images/index_r1_c3.jpg" width="691" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
  </tr>
  <tr>
   <td rowspan="5" colspan="2"><a href="../office/bio.cfm" TITLE="Comptroller's Biography"><img TITLE="Comptroller's Bio" name="DWH_img" src="images/DWH_img.jpg" width="105" height="94" border="0" alt=""></a></td>
   <td colspan="12"><img name="index_r2_c5" src="images/index_r2_c5.jpg" width="586" height="12" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="12" border="0" alt=""></td>
  </tr>
  <tr>
   <td colspan="5"><img name="index_r3_c5" src="images/index_r3_c5.jpg" width="272" height="8" border="0" alt=""></td>
   <td rowspan="2" colspan="4"><img name="thissiteupdated" src="images/thissiteupdated.jpg" width="231" height="20" border="0" alt=""></td>
   <td rowspan="4" colspan="3"><img name="index_r3_c14" src="images/index_r3_c14.jpg" width="83" height="82" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="8" border="0" alt=""></td>
  </tr>
  <tr>
   <td rowspan="3" colspan="5"><img name="index_r4_c5" src="images/index_r4_c5.jpg" width="272" height="74" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="12" border="0" alt=""></td>
  </tr>
  <tr>
   <td colspan="4"><img name="index_r5_c10" src="images/index_r5_c10.jpg" width="231" height="37" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="37" border="0" alt=""></td>
  </tr>
  <tr>
   <td colspan="3"><img name="DWH_pic" src="images/DWH_pic.jpg" width="189" height="25" border="0" alt=""></td>
   <td><img name="index_r6_c13" src="images/index_r6_c13.jpg" width="42" height="25" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="25" border="0" alt=""></td>
  </tr>
  <tr>
   <td colspan="13"><img name="TopLinks" src="images/TopLinks.jpg" width="690" height="46" border="0" alt=""></td>
   <td rowspan="7"><img name="index_r7_c16" src="images/index_r7_c16.jpg" width="1" height="119" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="46" border="0" alt=""></td>
  </tr>
  <tr>
   <td rowspan="2"><img name="dkafls" src="images/dkafls.jpg" width="7" height="25" border="0" alt=""></td>
   <td rowspan="2" colspan="2" BACKGROUND="images/LeftColHeader.jpg" ALIGN="CENTER"><span STYLE="color:navy; font-size:14px; "><B><CFOUTPUT>#UCASE(variables.menuHeader)#</CFOUTPUT></B></span></td>
   <td colspan="10"><img name="index_r8_c6" src="images/index_r8_c6.jpg" width="548" height="10" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="10" border="0" alt=""></td>
  </tr>
  <tr>
   <td rowspan="2" colspan="3"><img name="index_r9_c6" src="images/index_r9_c6.jpg" width="16" height="33" border="0" alt=""></td>
   <td rowspan="2" colspan="6" BACKGROUND="images/index_r9_c9.jpg" ALIGN="CENTER"><span class="heading" STYLE="font-size:24px; "><cfoutput>#variables.header#</cfoutput></span></td>
   <td rowspan="5"><img name="index_r9_c15" src="images/index_r9_c15.jpg" width="13" height="63" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="15" border="0" alt=""></td>
  </tr>
  <tr>
   <td rowspan="3" colspan="3"><img name="index_r10_c3" src="images/index_r10_c3.jpg" width="142" height="21" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="18" border="0" alt=""></td>
  </tr>
  <tr>
   <td rowspan="2" colspan="2"><img name="index_r11_c6" src="images/index_r11_c6.jpg" width="6" height="3" border="0" alt=""></td>
   <td rowspan="3" colspan="7" BACKGROUND="images/index_r11_c8.jpg" VALIGN="top" ALIGN="CENTER"><span class="subheading"><cfoutput>#variables.subheader#</cfoutput></span></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="2" border="0" alt=""></td>
  </tr>
  <tr>
   <td rowspan="2" BACKGROUND="images/leftofLeftcol.jpg"><img name="leftOfLeftCol" src="images/leftOfLeftCol.jpg" width="7" height="418" border="0" alt=""></td>
   <td rowspan="2" colspan="2"><img name="BigLeftColumn" src="images/BigLeftColumn.jpg" width="135" height="418" border="0" alt=""></td>
   <td><img name="index_r13_c6" src="images/index_r13_c6.jpg" width="5" height="27" border="0" alt=""></td>
   <td><img name="index_r13_c7" src="images/index_r13_c7.jpg" width="1" height="27" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="27" border="0" alt=""></td>
  </tr>
  <tr>
   <td BACKGROUND="images/leftOfMain.jpg"><img name="leftOfMain" src="images/leftOfMain.jpg" width="5" height="391" border="0" alt=""></td>
   <td colspan="8" BACKGROUND="images/main.jpg" VALIGN="TOP" ALIGN="CENTER">
   <table border="0" cellpadding="0" cellspacing="0" width="100%">
<!-- fwtable fwsrc="topicbox.png" fwbase="TopicBox.gif" fwstyle="Dreamweaver" fwdocid = "193053006" fwnested="0" -->
  <tr>
   <td width="21"><img src="../images/spacer.gif" width="21" height="1" border="0" alt=""></td>
   <td><img src="../images/spacer.gif" width="291" height="1" border="0" alt=""></td>
   <td width="21"><img src="../images/spacer.gif" width="21" height="1" border="0" alt=""></td>
   <td width="1"><img src="../images/spacer.gif" width="1" height="1" border="0" alt=""></td>
  </tr>

  <tr>
   <td><img name="TopicBox_r1_c1" src="../images/TopicBox_r1_c1.gif" width="21" height="6" border="0" alt=""></td>
   <td background="../images/TopicBox_r1_c2.gif"><img name="TopicBox_r1_c2" src="../images/TopicBox_r1_c2.gif" width="291" height="6" border="0" alt=""></td>
   <td><img name="TopicBox_r1_c3" src="../images/TopicBox_r1_c3.gif" width="21" height="6" border="0" alt=""></td>
   <td><img src="../images/spacer.gif" width="1" height="6" border="0" alt=""></td>
  </tr>
  <tr>
   <td><img name="TopicBox_r2_c1" src="../images/TopicBox_r2_c1.gif" width="21" height="18" border="0" alt=""></td>
   <td BACKGROUND="../images/tbHead.gif" ALIGN="CENTER"><font COLOR="white" face="verdana"><cfoutput><b>#ucase(request.bodyTopic)#</b></cfoutput></font></td>
   <td><img name="TopicBox_r2_c3" src="../images/TopicBox_r2_c3.gif" width="21" height="18" border="0" alt=""></td>
   <td><img src="../images/spacer.gif" width="1" height="18" border="0" alt=""></td>
  </tr>
  <tr>
   <td><img name="TopicBox_r3_c1" src="../images/TopicBox_r3_c1.gif" width="21" height="7" border="0" alt=""></td>
   <td BACKGROUND="../images/TopicBox_r3_c2.gif"><img name="TopicBox_r3_c2" src="../images/TopicBox_r3_c2.gif" width="291" height="7" border="0" alt=""></td>
   <td><img name="TopicBox_r3_c3" src="../images/TopicBox_r3_c3.gif" width="21" height="7" border="0" alt=""></td>
   <td><img src="../images/spacer.gif" width="1" height="7" border="0" alt=""></td>
  </tr>
  <tr>
   <td BACKGROUND="../images/tsrLeft.gif"><img name="tsrLeft" src="../images/tsrLeft.gif" width="21" height="98" border="0" alt=""></td>
   <td BGCOLOR="FFFFFF" VALIGN="TOP">
   
   
   
   <cfelse>
    </td>
   <td BACKGROUND="../images/tsrRight.gif"><img name="tsrRight" src="../images/tsrRight.gif" width="21" height="98" border="0" alt=""></td>
   <td><img src="../images/spacer.gif" width="1" height="98" border="0" alt=""></td>
  </tr>
  <tr>
   <td rowspan="2"><img name="TopicBox_r5_c1" src="../images/TopicBox_r5_c1.gif" width="21" height="21" border="0" alt=""></td>
   <td BACKGROUND="../images/tsrBottom.gif"><img name="tsrBottom" src="../images/tsrBottom.gif" width="291" height="11" border="0" alt=""></td>
   <td rowspan="2"><img name="TopicBox_r5_c3" src="../images/TopicBox_r5_c3.gif" width="21" height="21" border="0" alt=""></td>
   <td><img src="../images/spacer.gif" width="1" height="11" border="0" alt=""></td>
  </tr>
  <tr>
   <td BACKGROUND="../images/TopicBox_r6_c2.gif"><img name="TopicBox_r6_c2" src="../images/TopicBox_r6_c2.gif" width="291" height="10" border="0" alt=""></td>
   <td><img src="../images/spacer.gif" width="1" height="10" border="0" alt=""></td>
  </tr>
</table>
   </td>
   <td BACKGROUND="images/rightofrightcol.jpg" colspan="2"><img name="RightOfRightCol" src="images/RightOfRightCol.jpg" width="14" height="391" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="391" border="0" alt=""></td>
  </tr>
  <tr>
   <td colspan="3"><img name="index_r15_c3" src="images/index_r15_c3.jpg" width="142" height="9" border="0" alt=""></td>
   <td><img name="index_r15_c6" src="images/index_r15_c6.jpg" width="5" height="9" border="0" alt=""></td>
   <td colspan="4"><img name="index_r15_c7" src="images/index_r15_c7.jpg" width="339" height="9" border="0" alt=""></td>
   <td><img name="index_r15_c11" src="images/index_r15_c11.jpg" width="6" height="9" border="0" alt=""></td>
   <td colspan="3"><img name="index_r15_c12" src="images/index_r15_c12.jpg" width="185" height="9" border="0" alt=""></td>
   <td colspan="2"><img name="index_r15_c15" src="images/index_r15_c15.jpg" width="14" height="9" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="9" border="0" alt=""></td>
  </tr>
  <tr>
   <td colspan="2"><img name="index_r16_c1" src="images/index_r16_c1.jpg" width="9" height="6" border="0" alt=""></td>
   <td colspan="12"><img name="index_r16_c3" src="images/index_r16_c3.jpg" width="677" height="6" border="0" alt=""></td>
   <td colspan="2"><img name="index_r16_c15" src="images/index_r16_c15.jpg" width="14" height="6" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="6" border="0" alt=""></td>
  </tr>
</table>
</body>
</html>
</cfif>