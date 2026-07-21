/* ============================================================
   File        : 05_Indexes.sql
   Purpose     : Performance index for expense lookups
   ============================================================ */

USE LogisticsFleetDB;
GO

-- ------------------------------------------------------------
-- Composite index on ExpenseCategory + PaymentStatus
--
-- Most reporting queries filter on both columns together
-- (e.g. "Failed Fuel expenses", "Successful Toll expenses").
-- A single composite index lets SQL Server satisfy that filter
-- with one seek instead of doing a seek/scan on two separate
-- indexes and then intersecting the row sets, which is what
-- happens if ExpenseCategory and PaymentStatus are indexed on
-- their own. It also keeps write overhead lower, since the
-- engine only has to maintain one extra index structure instead
-- of two whenever a row is inserted or updated.
--
-- Column order matters: ExpenseCategory is listed first because
-- it is more selective and is also useful on its own (leftmost
-- prefix), while PaymentStatus by itself is low-cardinality
-- (only 'Success'/'Failed') and would make a poor lead column.
-- ------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Expenses_Category_PaymentStatus
    ON Expenses (ExpenseCategory, PaymentStatus)
    INCLUDE (Amount, TripID);
GO
