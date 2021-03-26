<cfcontent type="text/csv">
<cfheader name="Content-Disposition" value="attachment;filename=UnitData.csv">
<cfscript> 
myfile = FileRead("https://ftp.illinoiscomptroller.gov/LocGov/UnitData.csv"); 
WriteOutput("#myfile#"); 
</cfscript>
<CFABORT>