/* ============================================================
   File        : 01_Create_Database.sql
   Purpose     : Create the LogisticsFleetDB database
   Server      : Microsoft SQL Server (T-SQL)
   ============================================================ */

USE master;
GO

IF DB_ID('LogisticsFleetDB') IS NOT NULL
BEGIN
    ALTER DATABASE LogisticsFleetDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE LogisticsFleetDB;
END
GO

CREATE DATABASE LogisticsFleetDB;
GO

USE LogisticsFleetDB;
GO
