/* ============================================================
   File        : 07_Testing.sql
   Purpose     : Quick sanity checks after running the scripts
                 above -- row counts and a spot check on the
                 transaction procedure
   ============================================================ */

USE LogisticsFleetDB;
GO

SELECT 'Vehicles' AS TableName, COUNT(*) AS RowCount FROM Vehicles
UNION ALL
SELECT 'Trips', COUNT(*) FROM Trips
UNION ALL
SELECT 'Expenses', COUNT(*) FROM Expenses;
GO

-- confirm the composite index exists
SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('dbo.Expenses');
GO

-- confirm the stored proc rolls back on bad input
BEGIN TRY
    EXEC dbo.usp_InsertExpense
        @TripID = 999,
        @ExpenseCategory = 'Fuel',
        @Amount = 500.00,
        @PaymentStatus = 'Success';
END TRY
BEGIN CATCH
    PRINT 'Expected failure caught: ' + ERROR_MESSAGE();
END CATCH
GO

-- row count should be unchanged (26 + 1 from 06_Transactions.sql = 27)
SELECT COUNT(*) AS ExpenseCountAfterTest FROM Expenses;
GO
