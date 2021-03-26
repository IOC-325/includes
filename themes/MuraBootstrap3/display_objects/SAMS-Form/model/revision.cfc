component
    extends="mura.bean.beanORM"
    table="SAMS_revisions"
    entityname="revision"
    bundleable="true"
    displayname="revisionBean"
    public="true"
    orderby="revisionID"
    {
        // primary key
            property name="revisionID" fieldtype="id";
     
        // revision attributes
            property name="revisionType"    datatype="varchar"  length="20"    required=true  message="Type is required."; 
            property name="procedureNumber" datatype="varchar"  length="30"    nullable=true;
            property name="section"         datatype="varchar"  length="10"    nullable=true;  
            property name="reason"          datatype="varchar"  length="500"   required=true  message="A reason for the revision is required.";
            property name="description"     datatype="varchar"  length="1000"  required=true  message="The description of the change is required.";
            property name="comments"        datatype="varchar"  length="1000"  nullable=true;
            
            property name="dateRequested" datatype="datetime" nullable=true;

            property
                name="requester"
                cfc="requester"
                fieldtype="one-to-one"
                loadkey="revisionID"
                cascade="delete"
                orderby="lastName, firstName";


        public any function validate()
        {
            var obj = super.validate();
            var errors = obj.getErrors();

            if( !len(obj.get('dateRequested')) )
            {
                obj.set('dateRequested', now());
            }
        }
    }