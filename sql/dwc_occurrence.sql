/*
Created by Damiano Oldoni (INBO)
*/

SELECT
  o."location" || ':' || o."datum"       AS eventID,
-- RECORD-LEVEL
  'HumanObservation'                    AS basisOfRecord,
-- OCCURRENCE
  o."location" || ':' || o."datum" || ':' || o."species_name_hash" AS occurrenceID,
  CASE
    WHEN o."n" > 0  THEN o."n"
    ELSE NULL
  END                                   AS individualCount,
  CASE
    WHEN o."n" = 0  THEN "absent"
    ELSE "present"
  END                                   AS occurrenceStatus,
  o."opmerking"                         AS occurrenceRemarks,
-- TAXON
  o."species"                           AS scientificName,
  'Animalia'                            AS kingdom,
  'species'                             AS taxonRank
  FROM occurrences AS o
  WHERE  o."code" <= 1
