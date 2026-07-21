/* ============================================================
   File        : 08_Drop_Database.sql
   Purpose     : Clean teardown of the database (dev/test use)
   ============================================================ */

USE master;
GO

IF DB_ID('LogisticsFleetDB') IS NOT NULL
BEGIN
    ALTER DATABASE LogisticsFleetDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE LogisticsFleetDB;
END
GO
