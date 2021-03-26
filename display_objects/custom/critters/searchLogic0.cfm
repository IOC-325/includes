<!--- grab all shelters --->
<cfset shelterFeed = $.getBean('feed').loadBy(feedId = '85CFD658-5056-93B5-5EBD806A725E20B7') />
<cfset shelterIt = shelterFeed.getIterator() />

<cfset arrShelter = arrayNew(1) />

<!--- if form has been submitted, run the logic --->
<cfif StructKeyExists( FORM, "doSearch" )>

  <cfhttp url="http://#cgi.http_host#/comptroller/includes/display_objects/custom/critters/IllZips.csv" name="Illzips">

  <cfset sZip = $.event('zipCode') />
  <cfset radius = $.event('distance') />

  <cfquery name="theZip" dbtype="query">
    select 
      * 
    from 
      IllZips 
    where 
      zipCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sZip#" />
  </cfquery>

  <cfif theZip.recordcount eq 0>
    <cfset targetZipLat = '40.0000' />
    <cfset targetZipLong = '-89.0000' />
  <cfelse>
    <cfset targetZipLat = theZip.lat />
    <cfset targetZipLong = theZip.long />
  </cfif>

  <cfloop condition="#shelterIt.hasNext()#">
    <cfset shelter = shelterIt.next() />  

    <cfset distance = 
    ROUND((ACOS((SIN(targetZipLat/57.2958) * SIN(shelter.getlatitude()/57.2958)) + 
    (COS(targetZipLat/57.2958) * 
    COS(shelter.getlatitude()/57.2958) * 
    COS(shelter.getlongitude()/57.2958 - 
    targetZipLong/57.2958)))) * 
    3963) />

    <cfif 
      (shelter.getlatitude() gte targetZipLat - (radius/111)) AND 
      (shelter.getlatitude() lte targetZipLat + (radius/111)) AND 
      (shelter.getlongitude() gte targetZipLong - (radius/111)) AND 
      (shelter.getlongitude() lte targetZipLong + (radius/111))>
      
    <cfset temp = structNew() />
      <cfset temp.name = shelter.getTitle() />
      <cfset temp.address = shelter.getStreetAddress() />
      <cfset temp.city = shelter.getCity() />
      <cfset temp.state = shelter.getState() />
      <cfset temp.zip = shelter.getZipCode() />
      <cfset temp.phone = shelter.getPhone() />
      <cfset temp.website = shelter.getWebsite() />
      <cfset temp.petFinder = shelter.getPetFinder() />
      <cfset temp.latitude = shelter.getLatitude() />
      <cfset temp.longitude = shelter.getLongitude() />
    <cfset arrayAppend( arrShelter, temp ) />
      
    </cfif>

  </cfloop>

<cfelse>

  <cfloop condition="#shelterIt.hasNext()#">
    <cfset shelter = shelterIt.next() />
    <cfset temp = structNew() />
      <cfset temp.name = shelter.getTitle() />
      <cfset temp.address = shelter.getStreetAddress() />
      <cfset temp.city = shelter.getCity() />
      <cfset temp.state = shelter.getState() />
      <cfset temp.zip = shelter.getZipCode() />
      <cfset temp.phone = shelter.getPhone() />
      <cfset temp.website = shelter.getWebsite() />
      <cfset temp.petFinder = shelter.getPetFinder() />
      <cfset temp.latitude = shelter.getLatitude() />
      <cfset temp.longitude = shelter.getLongitude() />

    <cfset arrayAppend( arrShelter, temp ) />

  </cfloop>

</cfif>

<cffunction
    name="CSVToArray"
    access="public"
    returntype="array"
    output="false"
    hint="Takes a CSV file or CSV data value and converts it to an array of arrays based on the given field delimiter. Line delimiter is assumed to be new line / carriage return related.">
 
    <!--- Define arguments. --->
    <cfargument
        name="File"
        type="string"
        required="false"
        default=""
        hint="The optional file containing the CSV data."
        />
 
    <cfargument
        name="CSV"
        type="string"
        required="false"
        default=""
        hint="The CSV text data (if the file was not used)."
        />
 
    <cfargument
        name="Delimiter"
        type="string"
        required="false"
        default=","
        hint="The data field delimiter."
        />
 
    <cfargument
        name="Trim"
        type="boolean"
        required="false"
        default="true"
        hint="Flags whether or not to trim the END of the file for line breaks and carriage returns."
        />
 
 
    <!--- Define the local scope. --->
    <cfset var LOCAL = StructNew() />
 
 
    <!---
        Check to see if we are using a CSV File. If so,
        then all we want to do is move the file data into
        the CSV variable. That way, the rest of the algorithm
        can be uniform.
    --->
    <cfif Len( ARGUMENTS.File )>
 
        <!--- Read the file into Data. --->
        <cffile
            action="read"
            file="#ARGUMENTS.File#"
            variable="ARGUMENTS.CSV"
            />
 
    </cfif>
 
 
    <!---
        ASSERT: At this point, no matter how the data was
        passed in, we now have it in the CSV variable.
    --->
 
 
    <!---
        Check to see if we need to trim the data. Be default,
        we are going to pull off any new line and carraige
        returns that are at the end of the file (we do NOT want
        to strip spaces or tabs).
    --->
    <cfif ARGUMENTS.Trim>
 
        <!--- Remove trailing returns. --->
        <cfset ARGUMENTS.CSV = REReplace(
            ARGUMENTS.CSV,
            "[\r\n]+$",
            "",
            "ALL"
            ) />
 
    </cfif>
 
 
    <!--- Make sure the delimiter is just one character. --->
    <cfif (Len( ARGUMENTS.Delimiter ) NEQ 1)>
 
        <!--- Set the default delimiter value. --->
        <cfset ARGUMENTS.Delimiter = "," />
 
    </cfif>
 
 
    <!---
        Create a compiled Java regular expression pattern object
        for the experssion that will be needed to parse the
        CSV tokens including the field values as well as any
        delimiters along the way.
    --->
    <cfset LOCAL.Pattern = CreateObject(
        "java",
        "java.util.regex.Pattern"
        ).Compile(
            JavaCast(
                "string",

                <!--- Delimiter. --->
                "\G(\#ARGUMENTS.Delimiter#|\r?\n|\r|^)" &

                <!--- Quoted field value. --->
                "(?:""([^""]*+(?>""""[^""]*+)*)""|" &

                <!--- Standard field value --->
                "([^""\#ARGUMENTS.Delimiter#\r\n]*+))"
                )
            )
        />
 
    <!---
        Get the pattern matcher for our target text (the
        CSV data). This will allows us to iterate over all the
        tokens in the CSV data for individual evaluation.
    --->
    <cfset LOCAL.Matcher = LOCAL.Pattern.Matcher(
        JavaCast( "string", ARGUMENTS.CSV )
        ) />
 
 
    <!---
        Create an array to hold the CSV data. We are going
        to create an array of arrays in which each nested
        array represents a row in the CSV data file.
    --->
    <cfset LOCAL.Data = ArrayNew( 1 ) />
 
    <!--- Start off with a new array for the new data. --->
    <cfset ArrayAppend( LOCAL.Data, ArrayNew( 1 ) ) />
 
 
    <!---
        Here's where the magic is taking place; we are going
        to use the Java pattern matcher to iterate over each
        of the CSV data fields using the regular expression
        we defined above.

        Each match will have at least the field value and
        possibly an optional trailing delimiter.
    --->
    <cfloop condition="LOCAL.Matcher.Find()">
 
        <!---
            Get the delimiter. We know that the delimiter will
            always be matched, but in the case that it matched
            the START expression, it will not have a length.
        --->
        <cfset LOCAL.Delimiter = LOCAL.Matcher.Group(
            JavaCast( "int", 1 )
            ) />
 
 
        <!---
            Check for delimiter length and is not the field
            delimiter. This is the only time we ever need to
            perform an action (adding a new line array). We
            need to check the length because it might be the
            START STRING match which is empty.
        --->
        <cfif (
            Len( LOCAL.Delimiter ) AND
            (LOCAL.Delimiter NEQ ARGUMENTS.Delimiter)
            )>
 
            <!--- Start new row data array. --->
            <cfset ArrayAppend(
                LOCAL.Data,
                ArrayNew( 1 )
                ) />
 
        </cfif>
 
 
        <!---
            Get the field token value in group 2 (which may
            not exist if the field value was not qualified.
        --->
        <cfset LOCAL.Value = LOCAL.Matcher.Group(
            JavaCast( "int", 2 )
            ) />
 
        <!---
            Check to see if the value exists. If it doesn't
            exist, then we want the non-qualified field. If
            it does exist, then we want to replace any escaped
            embedded quotes.
        --->
        <cfif StructKeyExists( LOCAL, "Value" )>
 
            <!---
                Replace escpaed quotes with an unescaped double
                quote. No need to perform regex for this.
            --->
            <cfset LOCAL.Value = Replace(
                LOCAL.Value,
                """""",
                """",
                "all"
                ) />
 
        <cfelse>
 
            <!---
                No qualified field value was found, so use group
                3 - the non-qualified alternative.
            --->
            <cfset LOCAL.Value = LOCAL.Matcher.Group(
                JavaCast( "int", 3 )
                ) />
 
        </cfif>
 
 
        <!--- Add the field value to the row array. --->
        <cfset ArrayAppend(
            LOCAL.Data[ ArrayLen( LOCAL.Data ) ],
            LOCAL.Value
            ) />
 
    </cfloop>
 
 
    <!---
        At this point, our array should contain the parsed
        contents of the CSV value. Return the array.
    --->
    <cfreturn LOCAL.Data />
</cffunction>