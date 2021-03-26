<!--- [axof: 1020 wl: 30 hours] sr 17057 rk --->

 <cfquery name="countyList" datasource="#m.globalConfig('datasource')#"><!---#m.globalConfig('datasource')# --->
    SELECT Distinct County AS attributeValue From
    (
     SELECT
     Distinct tcontent.title AS Name,
     tcontent.Filename,
     ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County
     FROM  dbo.tcontent
     WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
     ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
    ) VT WHERE VT.County is not null


 </cfquery>

<!--- grab all shelters --->

<cfset arrShelter = arrayNew(1) />

<!--- if form has been submitted, run the logic --->
<cfif StructKeyExists( FORM, "ZipCode" )>


    <cfset sZip = $.event('zipCode') />
    <cfset shelterName = $.event('shelterName') />
    <cfset radius = $.event('distance') />
    <cfset county = $.event('county') />

    <cfif shelterName NEQ "" AND sZip NEQ "" AND county NEQ "" AND radius NEQ 0>
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                 SELECT
                  Distinct tcontent.title AS Name,
                  tcontent.Filename,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                 FROM  dbo.tcontent
                 WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                      AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                      AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                             ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                      AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                      AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />
                      AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 107 AND attributeValue LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#sZip#" /> )
                      AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                 UNION
                 SELECT
                  Distinct tcontent.title AS Name,
                  tcontent.Filename,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                 FROM  dbo.tcontent
                 WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                      AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                      AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                             ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                      AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                      AND dbo.Distance(tcontent.contentHistID, #sZip#) <= #radius#
                 ORDER BY title asc
              </cfquery>
    <cfelseif shelterName NEQ "" AND sZip NEQ "" AND county NEQ "" AND radius EQ 0>
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 107 AND attributeValue LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#sZip#" /> )
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                ORDER BY tcontent.title asc
              </cfquery>
    <cfelseif sZip NEQ "" AND county NEQ "" AND radius NEQ 0 AND shelterName EQ "">
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 107 AND attributeValue LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#sZip#" /> )
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                UNION
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND dbo.Distance(tcontent.contentHistID, #sZip#) <= #radius#
                ORDER BY title asc
              </cfquery>
    <cfelseif shelterName NEQ "" AND county NEQ "" AND radius NEQ 0 AND sZip EQ "">
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                  SELECT Distinct main.title AS Name, main.Filename,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 104) AS StreetAddress,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 105) AS City,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 106) AS State,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 107) AS Zipcode,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 108) AS Phone,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 112) AS lat,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 113) AS long,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 118) AS County,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 110) AS Website
                  FROM dbo.tcontent main
                  ,(
                   SELECT
                   tcontent_ID,tcontent.title AS Name, tcontent.Filename
                   ,(Select CASE WHEN CHARINDEX('-',attributeValue) > 0 Then LEFT(attributeValue, CHARINDEX('-',attributeValue)-1) else attributeValue END  From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID AND attributeId = 107) AS ZipCode
                   FROM dbo.tcontent
                   WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0' AND tcontent.active = 1
                   AND tcontent.Approved = 1 AND tcontent.isNav = 1 AND tcontent.moduleid = '00000000000000000000000000000000000'
                   AND tcontent.siteid = 'comptroller' AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate()
                   AND ( tcontent.DisplayStop >= Getdate() or tcontent.DisplayStop is null ))))
                   AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                   AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />
                   AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                  ) VT
                  WHERE main.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0' AND main.active = 1
                  AND main.Approved = 1 AND main.isNav = 1 AND main.moduleid = '00000000000000000000000000000000000'
                  AND main.siteid = 'comptroller' AND (main.Display = 1 OR ( main.Display = 2 AND ( main.DisplayStart < Getdate()
                  AND ( main.DisplayStop >= Getdate() or main.DisplayStop is null ))))
                  AND (main.mobileExclude is null OR main.mobileExclude in (0,1) )
                  AND dbo.Distance(main.contentHistID, Vt.ZipCode) <= #radius#
                  ORDER BY title asc
              </cfquery>
              <!---<cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                 SELECT
                  tcontent.title AS Name,
                  tcontent.Filename,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                 FROM  dbo.tcontent
                 WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                      AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                      AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                             ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                      AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                      AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />
                      AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                 UNION
                 SELECT
                  tcontent.title AS Name,
                  tcontent.Filename,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                 FROM  dbo.tcontent
                 WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                      AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                      AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                             ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                      AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                      AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />
                      AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                      AND dbo.DistanceByCounty(tcontent.contentHistID, #county#) <= #radius#
                 ORDER BY title asc
              </cfquery>--->
    <cfelseif shelterName NEQ "" AND sZip NEQ "" AND radius NEQ 0 AND county EQ ""  >
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 107 AND attributeValue LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#sZip#" /> )
                UNION
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND dbo.Distance(tcontent.contentHistID, #sZip#) <= #radius#
                ORDER BY title asc
              </cfquery>
    <cfelseif shelterName NEQ "" AND sZip NEQ "" AND radius EQ 0 AND county EQ ""  >
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 107 AND attributeValue LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#sZip#" /> )
                ORDER BY tcontent.title asc
              </cfquery>
    <cfelseif shelterName NEQ "" AND county NEQ "" AND radius EQ 0 AND sZip EQ ""  >
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                ORDER BY tcontent.title asc
              </cfquery>
    <cfelseif shelterName NEQ "" AND radius NEQ 0 AND county EQ "" AND sZip EQ "">
         <!--- This case is wrong please comment it in UAT --->
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                 SELECT Distinct main.title AS Name, main.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 108) AS Phone,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 112) AS lat,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 113) AS long,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 118) AS County,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 110) AS Website
                   FROM dbo.tcontent main
                   ,(
                   SELECT
                    tcontent_ID,tcontent.title AS Name, tcontent.Filename
                    ,(Select CASE WHEN CHARINDEX('-',attributeValue) > 0 Then LEFT(attributeValue, CHARINDEX('-',attributeValue)-1) else attributeValue END  From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID AND attributeId = 107) AS ZipCode
                   FROM dbo.tcontent
                   WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0' AND tcontent.active = 1
                   AND tcontent.Approved = 1 AND tcontent.isNav = 1 AND tcontent.moduleid = '00000000000000000000000000000000000'
                   AND tcontent.siteid = 'comptroller' AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate()
                   AND ( tcontent.DisplayStop >= Getdate() or tcontent.DisplayStop is null ))))
                   AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                   AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />
                   ) VT
                   WHERE main.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0' AND main.active = 1
                   AND main.Approved = 1 AND main.isNav = 1 AND main.moduleid = '00000000000000000000000000000000000'
                   AND main.siteid = 'comptroller' AND (main.Display = 1 OR ( main.Display = 2 AND ( main.DisplayStart < Getdate()
                   AND ( main.DisplayStop >= Getdate() or main.DisplayStop is null ))))
                   AND (main.mobileExclude is null OR main.mobileExclude in (0,1) )
                   AND dbo.Distance(main.contentHistID, Vt.ZipCode) <= #radius#
                 ORDER BY title asc
              </cfquery>
               <!---<cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                 SELECT
                     Name,Filename,StreetAddress,City,State,Zipcode,Phone,lat,long,County,Website
                     ,CASE WHEN CHARINDEX('-',Zipcode) > 0 Then LEFT(Zipcode, CHARINDEX('-',Zipcode)-1) else Zipcode END
                     ,dbo.Distance(contentHistID, CASE WHEN CHARINDEX('-',Zipcode) > 0 Then LEFT(Zipcode, CHARINDEX('-',Zipcode)-1) else Zipcode END) AS Miles
                 FROM
                  (
                   SELECT
                     tcontent.title AS Name,
                     tcontent.Filename,tcontent.contentHistID,
                     (Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                     ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                     ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                     ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                     ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                     ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                     ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                     ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                     ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website

                 FROM  dbo.tcontent
                 WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                      AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                      AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                             ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                      AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                      AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />

                      ) VT
                      WHERE dbo.Distance(contentHistID, CASE WHEN CHARINDEX('-',Zipcode) > 0 Then LEFT(Zipcode, CHARINDEX('-',Zipcode)-1) else Zipcode END)  <= #radius#
                     ORDER BY title asc
              </cfquery> --->
    <cfelseif sZip NEQ "" AND county NEQ ""  AND radius EQ 0 AND shelterName EQ "">
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 107 AND attributeValue LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#sZip#" /> )
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                ORDER BY tcontent.title asc
              </cfquery>
    <cfelseif sZip NEQ "" AND radius NEQ 0  AND county EQ "" AND shelterName EQ "">
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 107 AND attributeValue LIKE  <cfqueryparam cfsqltype="cf_sql_varchar" value="#sZip#" /> )
                UNION
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND dbo.Distance(tcontent.contentHistID, #sZip#) <= #radius#
                ORDER BY title asc
              </cfquery>
    <cfelseif county NEQ "" AND radius NEQ 0 AND sZip EQ "" AND shelterName EQ "">
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                  SELECT Distinct main.title AS Name, main.Filename,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 104) AS StreetAddress,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 105) AS City,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 106) AS State,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 107) AS Zipcode,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 108) AS Phone,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 112) AS lat,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 113) AS long,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 118) AS County,
                   ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = main.contentHistID AND attributeId = 110) AS Website
                  FROM dbo.tcontent main
                  ,(
                   SELECT
                   tcontent_ID,tcontent.title AS Name, tcontent.Filename
                   ,(Select CASE WHEN CHARINDEX('-',attributeValue) > 0 Then LEFT(attributeValue, CHARINDEX('-',attributeValue)-1) else attributeValue END  From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID AND attributeId = 107) AS ZipCode
                   FROM dbo.tcontent
                   WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0' AND tcontent.active = 1
                   AND tcontent.Approved = 1 AND tcontent.isNav = 1 AND tcontent.moduleid = '00000000000000000000000000000000000'
                   AND tcontent.siteid = 'comptroller' AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate()
                   AND ( tcontent.DisplayStop >= Getdate() or tcontent.DisplayStop is null ))))
                   AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                   AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                  ) VT
                  WHERE main.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0' AND main.active = 1
                  AND main.Approved = 1 AND main.isNav = 1 AND main.moduleid = '00000000000000000000000000000000000'
                  AND main.siteid = 'comptroller' AND (main.Display = 1 OR ( main.Display = 2 AND ( main.DisplayStart < Getdate()
                  AND ( main.DisplayStop >= Getdate() or main.DisplayStop is null ))))
                  AND (main.mobileExclude is null OR main.mobileExclude in (0,1) )
                  AND dbo.Distance(main.contentHistID, Vt.ZipCode) <= #radius#
                  ORDER BY title asc
              </cfquery>
              <!---<cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                 SELECT
                  tcontent.title AS Name,
                  tcontent.Filename,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                 FROM  dbo.tcontent
                 WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                      AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                      AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                             ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                      AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                      AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                 UNION
                 SELECT
                  tcontent.title AS Name,
                  tcontent.Filename,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                 FROM  dbo.tcontent
                 WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                      AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                      AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                             ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                      AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                      AND dbo.DistanceByCounty(tcontent.contentHistID, '#county#') <= #radius#
                 ORDER BY title asc
              </cfquery>--->
    <cfelseif shelterName NEQ "" AND county EQ "" AND radius EQ 0 AND sZip EQ "">
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#shelterName#%" />
                ORDER BY tcontent.title asc
              </cfquery>
    <cfelseif sZip NEQ "" AND county EQ "" AND radius EQ 0 AND shelterName EQ "">
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 107 AND attributeValue LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#sZip#" /> )
                ORDER BY tcontent.title asc
              </cfquery>
    <cfelseif county NEQ "" AND sZip EQ "" AND radius EQ 0 AND shelterName EQ "">
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                     AND tcontent.contentHistID IN  (Select BaseId From dbo.tclassextenddata where attributeId = 118 AND attributeValue =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#county#" /> )
                ORDER BY tcontent.title asc
              </cfquery>
    <cfelseif county NEQ "" AND sZip EQ "" AND radius EQ 0 AND shelterName EQ "" >
        <!--- This case is wrong it will never come 15 --->
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                ORDER BY tcontent.title asc
              </cfquery>
    <cfelse >
              <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                SELECT
                 Distinct tcontent.title AS Name,
                 tcontent.Filename,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                 ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                FROM  dbo.tcontent
                WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                     AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                     AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                            ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                     AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                ORDER BY tcontent.title asc
              </cfquery>
    </cfif>
    <!--- <cfdump var="#theZip#"> --->
      <cfloop query = "theZip">
            <cfset temp = structNew() />
            <cfset temp.name = theZip.Name />
            <cfset temp.address = theZip.StreetAddress />
            <cfset temp.city = theZip.City />
            <cfset temp.state = theZip.State />
            <cfset temp.zip = theZip.Zipcode />
            <cfset temp.phone = theZip.Name />
            <cfset temp.website = theZip.Website />
            <cfset temp.fileName = theZip.FileName />
            <cfset temp.petFinder = "" />
            <cfset temp.latitude = theZip.lat />
            <cfset temp.longitude = theZip.long />
            <cfset arrayAppend( arrShelter, temp ) />
      </cfloop>

<cfelse>

    <cfquery name="theZip" datasource="#m.globalConfig('datasource')#">
                 SELECT
                  tcontent.title AS Name,
                  tcontent.Filename,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 104) AS StreetAddress,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 105) AS City,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 106) AS State,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 107) AS Zipcode,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 108) AS Phone,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 112) AS lat,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 113) AS long,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 118) AS County,
                  ( Select attributeValue From dbo.tclassextenddata where tclassextenddata.BaseId = tcontent.contentHistID  AND attributeId = 110) AS Website
                 FROM  dbo.tcontent
                 WHERE tcontent.parentid = '510378F9-5056-93B5-5E6E323BD6A6ECB0'  AND tcontent.active = 1 AND tcontent.Approved = 1 AND tcontent.isNav = 1
                      AND tcontent.moduleid = '00000000000000000000000000000000000' AND tcontent.siteid = 'comptroller'
                      AND (tcontent.Display = 1 OR ( tcontent.Display = 2 AND ( tcontent.DisplayStart < Getdate() AND
                             ( tcontent.DisplayStop >=  Getdate() or tcontent.DisplayStop is null ))))
                      AND (tcontent.mobileExclude is null OR tcontent.mobileExclude in (0,1) )
                 ORDER BY tcontent.title asc
    </cfquery>
    <cfloop query = "theZip">
         <cfset temp = structNew() />
         <cfset temp.name = theZip.Name />
         <cfset temp.address = theZip.StreetAddress />
         <cfset temp.city = theZip.City />
         <cfset temp.state = theZip.State />
         <cfset temp.zip = theZip.Zipcode />
         <cfset temp.phone = theZip.Name />
         <cfset temp.website = theZip.Website />
         <cfset temp.fileName = theZip.FileName />
         <cfset temp.petFinder = "" />
         <cfset temp.latitude = theZip.lat />
         <cfset temp.longitude = theZip.long />
         <cfset arrayAppend( arrShelter, temp ) />
    </cfloop>

</cfif>