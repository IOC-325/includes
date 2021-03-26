<html>
<head>
<title>Download Help</title>
<link rel="stylesheet" type="text/css" href="../site.css">

</head>
<body>
<h3>Download Help</h3>

<p>This process downloads the warrants you specify to an XML document with an Excel (xls) extension. The latest few versions of Excel will read the file, but you will receive a popup message that will tell you that the file is in a different format that is specified in the file extension. Simply click "Yes" to open the file, and it will open your data as an Excel spreadsheet.</p>

<h3>Potential Issues</h3>

<p>If the you receive a message stating that “The file you’re trying to open "data.xls" is in a different format then specified by the file extension.  Verify that the file is not corrupted and is from a trusted site before opening the file.  Do you want to open the file now?" dialog box, and no longer wish to receive it, here is the fix.</p>

<p>WARNING: THE SUGGESTION BELOW REQUIRES MODIFYING THE REGISTRY. THIS SHOULD ONLY BE PERFORMED BY AN I.T. PROFESSIONAL</P>

<P>In the situation above, we recommend the user just click “Yes” button to open the excel spreadsheet, but your I.T. staff professional can perform the following:</p>
<p>(1)	Close all Excel spreadsheets
<p>(2)	Click Windows Start Button, type RegEdit.exe  in Search and press Enter key
<p>(3)	Navigate to the subkey: HKEY_CURRENT_USER\Software\Microsoft\Office\[Office Version Number]\Excel\Security
Office Version Number<br>
a.	Office 2003 => 11.0<br>
b.	Office 2007 => 12.0<br>
c.	Office 2010 => 14.0<br>
d.	Office 2013 => 15.0</p>
<p>(5)	Right-click and create new DWORD value:<br>&nbsp;&nbsp;
a.	Value Name: ExtensionHardening<br>&nbsp;&nbsp;
b.	Value Type: REG_DWORD<br>&nbsp;&nbsp;
c.	Value Data: 0<br>&nbsp;&nbsp;&nbsp;&nbsp;
i.	0: Do not check the file name extension and the file type, and bypass the function of the warning message<br>&nbsp;&nbsp;&nbsp;&nbsp;
ii.	1: Check the file name extension and the file type.  If they do not match, display the warning message<br>&nbsp;&nbsp;&nbsp;&nbsp;
iii.	2: Check the file name extension and the file type.  If they do not match, do not open the file<br>nbsp;
(6)	Close RegEdit<br>
(7)	Click on Download to Excel button again
</p>

<!---<p><b>Advanced Options</b>
<br>By selecting the Download button from the List of Vendor Warrants, you get a file listing the columns you see in the vendor warrant listing page. If you select the Advanced Options hyperlink, however, you can also choose to get a description of what each warrant is for, as well as Accounting Line Details. Please note that downloading these additional fields will take extra time, particularly if you are downloading a lot of warrants.</p>
--->
</body>
</html>