/* ====================================================
   File : 05_Indexes.sql
   Purpose : Performance index for expense lookups
   ==================================================== */

USE LogisticsFleetDB;
GO

-- Composite index on ExpenseCategory + PaymentStatus
CREATE NONCLUSTERED INDEX IX_Expenses_Category_PaymentStatus
    ON Expenses (ExpenseCategory, PaymentStatus)
    INCLUDE (Amount, TripID);
GO
