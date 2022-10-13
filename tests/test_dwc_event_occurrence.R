# load libraries
library(testthat)
library(readr)
library(dplyr)
library(here)

# read proposed new version of the DwC mapping
events_path <- here::here("data", "processed", "event.csv")
occs_path <- here::here("data", "processed", "occurrence.csv")
dwc_event <- readr::read_csv(events_path, guess_max = 10000)
dwc_occurrence <- readr::read_csv(occs_path, guess_max = 10000)

# test event core
testthat::test_that("Right columns in right order in event core", {
  columns_event <- c(
    "type",
    "language",
    "license",
    "rightsHolder",
    "accessRights",
    "datasetID",
    "institutionCode",
    "datasetName",
    "samplingProtocol",
    "eventID",
    "eventDate",
    "locationID",
    "continent",
    "countryCode",
    "stateProvince",
    "verbatimLocalityProperty",
    "decimalLatitude",
    "decimalLongitude",
    "geodeticDatum",
    "coordinateUncertaintyInMeters",
    "verbatimLatitude",
    "verbatimLongitude",
    "verbatimSRS"
  )
  testthat::expect_equal(names(dwc_event), columns_event)
})

testthat::test_that("eventID is always present and is unique in event core", {
  testthat::expect_true(all(!is.na(dwc_event$eventID)))
  testthat::expect_equal(length(unique(dwc_event$eventID)),
                         nrow(dwc_event))
})

testthat::test_that("eventDate is always filled in", {
  testthat::expect_true(all(!is.na(dwc_event$eventDate)))
})

testthat::test_that("locationID is always filled in", {
  testthat::expect_true(all(!is.na(dwc_event$locationID)))
})

testthat::test_that("decimalLatitude is always filled in", {
  testthat::expect_true(all(!is.na(dwc_event$decimalLatitude)))
})

testthat::test_that("decimalLatitude is within Flemish boundaries", {
  testthat::expect_true(all(dwc_event$decimalLatitude < 51.65))
  testthat::expect_true(all(dwc_event$decimalLatitude > 50.63))
})

testthat::test_that("decimalLongitude is always filled in", {
  testthat::expect_true(all(!is.na(dwc_event$decimalLongitude)))
})

testthat::test_that("decimalLongitude is within Flemish boundaries", {
  testthat::expect_true(all(dwc_event$decimalLongitude < 5.95))
  testthat::expect_true(all(dwc_event$decimalLongitude > 2.450))
})

# test occurrence extension

testthat::test_that("Right columns in right order in occurrence extension", {
  columns_occ <- c(
    "eventID",
    "basisOfRecord",
    "occurrenceID",
    "occurrenceRemarks",
    "individualCount",
    "occurrenceStatus",
    "scientificName",
    "kingdom"
  )
  testthat::expect_equal(names(dwc_occurrence), columns_occ)
})

testthat::test_that(
  "occurrenceID is always present and is unique in occurrence extension", {
    testthat::expect_true(all(!is.na(dwc_occurrence$occurrenceID)))
    testthat::expect_equal(length(unique(dwc_occurrence$occurrenceID)),
                           nrow(dwc_occurrence)
    )
})

testthat::test_that("eventID is always present in occurrence extension", {
  testthat::expect_true(all(!is.na(dwc_occurrence$eventID)))
})

testthat::test_that("All eventIDs are in event core ", {
  testthat::expect_true(all(dwc_occurrence$eventID %in% dwc_event$eventID))
})

testthat::test_that("individualCount is a number or NA", {
  testthat::expect_true(is.numeric(dwc_occurrence$individualCount)
  )
})

testthat::test_that(
  "occurrenceStatus is present or absent", {
    testthat::expect_equal(
      dwc_occurrence %>%
        dplyr::distinct(occurrenceStatus) %>%
        dplyr::arrange(occurrenceStatus) %>%
        dplyr::pull(occurrenceStatus),
      c("absent", "present")
    )
})

testthat::test_that("kingdom is always filled in and is always Animalia", {
  testthat::expect_true(all(!is.na(dwc_occurrence$kingdom)))
  testthat::expect_true(unique(dwc_occurrence$kingdom) == "Animalia")
})

testthat::test_that("scientificName is never NA and one of the list", {
  species <- c(
    "Pontastacus leptodactylus",
    "Pacifastacus leniusculus",
    "Faxonius limosus",
    "Faxonius rusticus",
    "Procambarus clarkii",
    "Procambarus acutus",
    "Procambarus fallax"
  )
  testthat::expect_true(all(!is.na(dwc_occurrence$scientificName)))
  testthat::expect_true(all(dwc_occurrence$scientificName %in% species))
})
