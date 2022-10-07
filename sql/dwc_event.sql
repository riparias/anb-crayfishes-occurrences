/*
Created by Damiano Oldoni (INBO)
*/

SELECT DISTINCT
-- RECORD-LEVEL
  'Event'                               AS type,
  'en'                                  AS language,
  'https://creativecommons.org/licenses/by-nc/4.0/legalcode' AS license,
  'ANB'                                 AS rightsHolder,
  'http://www.inbo.be/en/norms-for-data-use' AS accessRights,
  ''                                    AS datasetID,
  'ANB'                                 AS institutionCode,
  'Targeted monitoring of crustacea by ANB, Belgium' AS datasetName,
  'targeted monitoring'                 AS samplingProtocol,
-- EVENT
  o."locatie" || ':' || o."datum"       AS eventID,
  date(o."datum")                       AS eventDate,
-- LOCATION
  'Europe'                              AS continent,
  'BE'                                  AS countryCode,
  'Flanders'                            AS stateProvince,
  o."omschrijving"                      AS verbatimLocalityProperty,
  printf('%.5f', ROUND(o."Y", 5))       AS decimalLatitude,
  printf('%.5f', ROUND(o."X", 5))       AS decimalLongitude,
  'WGS84'                               AS geodeticDatum,
  '30'                                  AS coordinateUncertaintyInMeters,
  o."Y"                                 AS verbatimLatitude,
  o."X"                                 AS verbatimLongitude,
  'EPSG:31370'                          AS verbatimSRS
  FROM occurrences AS o
  WHERE
  -- Remove events where the trap could not be placed due to drought (2),
  -- the place was private and so not reachable (3)
  -- the trap was stolen (4)
  o."code" <= 1
