/* ==============================================================================
   File: 06_Transactions.sql
   Purpose : Safe expense insertion using TRY/CATCH and an explicit transaction
   ===================================================================== */

USE LogisticsFleetDB;
GO

CREATE OR ALTER PROCEDURE dbo.usp_InsertExpense
    @TripID          INT,
    @ExpenseCategory VARCHAR(50),
    @Amount          DECIMAL(18,2),
    @PaymentStatus   VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        -- basic validation before we touch the table
        IF NOT EXISTS (SELECT 1 FROM Trips WHERE TripID = @TripID)
        BEGIN
            THROW 51000, 'Cannot insert expense: TripID does not exist.', 1;
        END

        IF @Amount < 0
        BEGIN
            THROW 51001, 'Cannot insert expense: Amount cannot be negative.', 1;
        END

        INSERT INTO Expenses (TripID, ExpenseCategory, Amount, PaymentStatus)
        VALUES (@TripID, @ExpenseCategory, @Amount, @PaymentStatus);

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END
GO

       
-- Example usage
EXEC dbo.usp_InsertExpense
    @TripID = 1,
    @ExpenseCategory = 'Fuel',
    @Amount = 1200.00,
    @PaymentStatus = 'Success';
GO

-- Example that should fail and roll back
-- EXEC dbo.usp_InsertExpense @TripID = 999, @ExpenseCategory = 'Fuel', @Amount = 500.00, @PaymentStatus = 'Success';
