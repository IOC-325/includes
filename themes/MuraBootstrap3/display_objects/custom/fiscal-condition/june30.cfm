<cfinvoke component="/comptroller/includes/display_objects/custom/DailyTransactions/Component/DailyTransactions"
        method="GetBacklogs"
        LastUpdt="#DateFormat(06/30/2018, "mm/dd/yyyy")#"
        srce="LedgerDB2"
        returnVariable="GetBacklogj30">

<cfdump var="#GetBacklogj30#">