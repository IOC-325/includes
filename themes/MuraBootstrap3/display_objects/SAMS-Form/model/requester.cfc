component
    extends="mura.bean.beanORM"
    table="SAMS_revisionRequesters"
    entityname="requester"
    bundleable="true"
    displayname="requesterBean"
    public="true"
    orderby="lastName, firstName"
    {
        // Primary Key
        property name="requesterID" fieldtype="id";

        // Foreign Key
        property name="revision" fieldtype="one-to-one" cfc="revision" fkcolumn="revisionID";

        // Attributes
        property name="firstName"   datatype="varchar" length="150"    required=true  message="A first name is required.";
        property name="lastName"    datatype="varchar" length="150"    required=true  message="A last name is required.";
        property name="agencyID"    datatype="integer"                  required=true  message="An agency is required.";
        property name="email"       datatype="varchar" length="100"    required=true  message="An email address is required.";
        property name="street"      datatype="varchar" length="255"    required=true  message="A street is required.";
        property name="city"        datatype="varchar" length="100"    required=true  message="A city is required.";
        property name="stateID"     datatype="integer"                  required=true  message="A state is required.";
        property name="zipcode"     datatype="varchar" length="15"     required=true  message="A zipcode is required.";
        property name="telephone"   datatype="varchar" length="15"     required=true  message="A phone number is required.";
    }