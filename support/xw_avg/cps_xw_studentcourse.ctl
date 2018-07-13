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
BADFILE './OUCHNSYS.TMP_XW_STUDENTCOURSE.BAD'
DISCARDFILE './OUCHNSYS.TMP_XW_STUDENTCOURSE.DSC'
truncate INTO TABLE OUCHNSYS.TMP_XW_STUDENTCOURSE
Fields terminated by "," Optionally enclosed by '"'
(
  STUDENTCODE,
  SEGMENTCODE,
  COURSEID,
  SCORE NULLIF (SCORE="NULL"),
  SCORECODE,
  EXAMUNIT,
   end filler
)
BEGINDATA
