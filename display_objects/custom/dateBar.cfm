<cfstoredproc procedure="getDateBar" datasource="General" result="rsltDateBar">
  <cfprocresult name="rlstDateBarRecordSetAfterUpdate"/>
</cfstoredproc>

<cfoutput>
Updated #rlstDateBarRecordSetAfterUpdate.strValue#
</cfoutput>