/*
Created by Damiano Oldoni (INBO)
*/

SELECT
  o."locatie" || ':' || o."datum"       AS eventID,
-- RECORD-LEVEL
  'HumanObservation'                    AS basisOfRecord,
-- OCCURRENCE
  o."locatie" || ':' || o."datum" || ':' || o."species_name_hash" AS occurrenceID,
  CASE
    WHEN o."opmerking" IN () THEN NULL
    ELSE o."opmerking"
  END                                   AS occurrenceRemarks,
  CASE
    WHEN o."n" > 0  THEN o."n"
    ELSE NULL
  END                                   AS individualCount,
  CASE
    WHEN o."n" = 0  THEN "absent"
    ELSE "present"
  END                                   AS occurrenceStatus
-- TAXON
  o."species"                           AS scientificName,
  'Animalia'                            AS kingdom,
  FROM occurrences AS o