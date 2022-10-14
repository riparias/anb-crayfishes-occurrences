/*
Created by Damiano Oldoni (INBO)
*/

SELECT DISTINCT
-- RECORD-LEVEL
  'Event'                               AS type,
  'en'                                  AS language,
  'http://creativecommons.org/publicdomain/zero/1.0/' AS license,
  'ANB'                                 AS rightsHolder,
  ''                                    AS datasetID,
  'ANB'                                 AS institutionCode,
  'Monitoring of invasive alien crayfishes in the Flemish part of the LIFE RIPARIAS areas' AS datasetName,
  'targeted monitoring'                 AS samplingProtocol,
-- EVENT
  o."location" || ':' || o."datum"      AS eventID,
  date(o."datum")                       AS eventDate,
-- LOCATION
  'BE'                                  AS countryCode,
  'Flanders'                            AS stateProvince,
  o."omschrijving"                      AS locality,
  printf('%.5f', ROUND(o."Y", 5))       AS decimalLatitude,
  printf('%.5f', ROUND(o."X", 5))       AS decimalLongitude,
  'WGS84'                               AS geodeticDatum,
  '30'                                  AS coordinateUncertaintyInMeters,
  CAST(o."y_lambert" AS INT)            AS verbatimLatitude,
  CAST(o."x_lambert" AS INT)            AS verbatimLongitude,
  'Lambert coordinates'                 AS verbatimCoordinateSystem,
  'EPSG:31370'                          AS verbatimSRS
  FROM occurrences AS o
  WHERE
  -- Remove events where the trap could not be placed due to drought (2),
  -- the place was private and so not reachable (3)
  -- the trap was stolen (4)
  o."code" <= 1
