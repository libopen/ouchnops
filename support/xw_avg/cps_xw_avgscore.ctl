-- SQL Loader Control and Data File created by TOAD
-- Variable length, terminated enclosed data formatting
-- 
-- The format for executing this file with SQL Loader is:
-- SQLLDR control=<filename> Be sure to substitute your
-- version of SQL LOADER and the filename for this file.
--
-- Note: Nested table datatypes are not supported here and
--       will be exported as nulls.
LOAD DATA
INFILE *
BADFILE './OUCHNSYS.TMP_XW_AVGSCORE.BAD'
DISCARDFILE './OUCHNSYS.TMP_XW_AVGSCORE.DSC'
truncate INTO TABLE OUCHNSYS.TMP_XW_AVGSCORE
Fields terminated by "," Optionally enclosed by '"'
(
  STUDENTCODE,
  AVGSCORE NULLIF (AVGSCORE="NULL"),
  end filler
)
BEGINDATA
