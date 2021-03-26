<cfdocument format="PDF" marginbottom="0.5" marginleft="0.4" margintop="0.4" marginright="0.4" orientation="portrait" pagetype="LETTER" fontembed="No" scale="60">
<cfdocumentitem type="footer">
  <cfoutput><div style="float: left;font-size: 12px;">Printed On: #DateFormat("# Now()#", "mm/dd/yyyy")#</div>
            <div style="float: right;font-size: 12px;">Page: #cfdocument.currentpagenumber# of #cfdocument.totalpagecount#</div></cfoutput>
</cfdocumentitem>
<style>
    .bs-example{
        margin: 20px;        
    }
    @media print {
      .screen {
        display: none;
      }
    }
    table tr td{
      padding: 10Px;
    }
    .bstyle{
       border-top: 1px solid #dddddd; 
       border-left: 1px solid #dddddd;
    }
    .lstyle{
      border-left: 1px solid #dddddd;
    }
    .tstyle{
      border-top: 1px solid #dddddd;
    }
     .bdstyle{
       border-top: 1px dashed #dddddd; 
       border-left: 1px solid #dddddd;
    }     
</style>
<cfoutput>#session.GTaxReportData#</cfoutput>
</cfdocument>