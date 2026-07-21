/* ============================================================
   File        : 04_Queries.sql
   Purpose     : Analytical / reporting queries for the
                 Logistics Fleet Operations database
   ============================================================ */

USE LogisticsFleetDB;
GO

-- ------------------------------------------------------------
-- 1. Regional Outbound Logistics Tracker
--    Trips to Delhi or Mumbai between Jan 2025 and Jun 2026
-- ------------------------------------------------------------
SELECT
    T.TripID,
    V.VehicleNumber,
    T.SourceCity,
    T.DestinationCity,
    T.TripDate,
    T.FuelAdvanceAmount
FROM Trips T
INNER JOIN Vehicles V
    ON T.VehicleID = V.VehicleID
WHERE T.DestinationCity IN ('Delhi', 'Mumbai')
  AND T.TripDate BETWEEN '2025-01-01' AND '2026-06-30'
ORDER BY T.TripDate;
GO

-- ------------------------------------------------------------
-- 2. Failed Payment Audit
--    All expenses where PaymentStatus = 'Failed'
-- ------------------------------------------------------------
SELECT
    E.ExpenseID,
    V.VehicleNumber,
    E.ExpenseCategory,
    E.Amount,
    T.TripDate
FROM Expenses E
INNER JOIN Trips T
    ON E.TripID = T.TripID
INNER JOIN Vehicles V
    ON T.VehicleID = V.VehicleID
WHERE E.PaymentStatus = 'Failed'
ORDER BY T.TripDate;
GO

-- ------------------------------------------------------------
-- 3. Top 3 highest successful expenses
-- ------------------------------------------------------------
SELECT TOP 3
    ExpenseID,
    TripID,
    ExpenseCategory,
    Amount
FROM Expenses
WHERE PaymentStatus = 'Success'
ORDER BY Amount DESC;
GO

-- ------------------------------------------------------------
-- 4. Monthly MIS
--    Grouped by VehicleType and Month (YYYY-MM)
--    Total trips and total successful expense amount
-- ------------------------------------------------------------
SELECT
    V.VehicleType,
    FORMAT(T.TripDate, 'yyyy-MM') AS TripMonth,
    COUNT(DISTINCT T.TripID)      AS TotalTrips,
    SUM(CASE WHEN E.PaymentStatus = 'Success' THEN E.Amount ELSE 0 END) AS TotalSuccessfulExpense
FROM Trips T
INNER JOIN Vehicles V
    ON T.VehicleID = V.VehicleID
LEFT JOIN Expenses E
    ON E.TripID = T.TripID
GROUP BY V.VehicleType, FORMAT(T.TripDate, 'yyyy-MM')
ORDER BY TripMonth, V.VehicleType;
GO

-- ------------------------------------------------------------
-- 5. Data Integrity Audit
--    Trips where sum of successful expenses exceeds the
--    fuel advance given for that trip
-- ------------------------------------------------------------
SELECT
    T.TripID,
    V.VehicleNumber,
    T.FuelAdvanceAmount,
    SUM(E.Amount) AS TotalSuccessfulExpense
FROM Trips T
INNER JOIN Vehicles V
    ON T.VehicleID = V.VehicleID
INNER JOIN Expenses E
    ON E.TripID = T.TripID
   AND E.PaymentStatus = 'Success'
GROUP BY T.TripID, V.VehicleNumber, T.FuelAdvanceAmount
HAVING SUM(E.Amount) > T.FuelAdvanceAmount
ORDER BY T.TripID;
GO
