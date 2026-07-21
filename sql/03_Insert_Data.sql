/* ============================================
   File        : 03_Insert_Data.sql
   Purpose     : Populate Vehicles, Trips and Expenses with
                 sample data that exercises every query in
                 04_Queries.sql
   =========================================== */

USE LogisticsFleetDB;
GO

-- Vehicles (8 rows)

INSERT INTO Vehicles (VehicleNumber, VehicleType, RegistrationDate, Status) VALUES
('MH12AB1234', 'Truck', '2022-01-15', 'Active'),
('DL01CD5678', 'Truck', '2021-06-10', 'Active'),
('MH14EF9012', 'Van',   '2023-03-22', 'Active'),
('UP16GH3456', 'Truck', '2020-11-05', 'Maintenance'),
('DL08IJ7890', 'Van',   '2022-09-18', 'Active'),
('MH04KL2345', 'Truck', '2023-07-01', 'Active'),
('UP32MN6789', 'Van',   '2021-12-12', 'Maintenance'),
('DL05OP0123', 'Truck', '2024-02-28', 'Active');
GO

-- Trips (14 rows) -- VehicleID references identity values 1-8

INSERT INTO Trips (VehicleID, SourceCity, DestinationCity, TripDate, FuelAdvanceAmount) VALUES
(1, 'Pune',    'Delhi',      '2025-01-10', 5000.00),
(2, 'Chennai', 'Mumbai',     '2025-02-14', 6000.00),
(3, 'Nagpur',  'Bangalore',  '2025-03-05', 3000.00),
(1, 'Delhi',   'Jaipur',     '2025-04-20', 4000.00),
(4, 'Kanpur',  'Delhi',      '2025-05-11', 5500.00),
(5, 'Mumbai',  'Pune',       '2025-06-01', 2000.00),
(2, 'Surat',   'Mumbai',     '2025-07-19', 4500.00),
(6, 'Indore',  'Delhi',      '2025-08-23', 5200.00),
(3, 'Pune',    'Hyderabad',  '2025-09-14', 3200.00),
(7, 'Agra',    'Mumbai',     '2025-11-02', 6100.00),
(8, 'Lucknow', 'Delhi',      '2026-01-15', 4800.00),
(1, 'Bhopal',  'Mumbai',     '2026-03-10', 5300.00),
(2, 'Ranchi',  'Delhi',      '2026-06-28', 4700.00),
(5, 'Delhi',   'Chandigarh', '2026-07-05', 3000.00);
GO

-- Expenses (26 rows) -- TripID references identity values 1-14

INSERT INTO Expenses (TripID, ExpenseCategory, Amount, PaymentStatus) VALUES
(1,  'Fuel',             3000.00, 'Success'),
(1,  'Toll',             1500.00, 'Success'),
(1,  'Food',              800.00, 'Success'),
(2,  'Fuel',             2000.00, 'Success'),
(2,  'Toll',              500.00, 'Failed'),
(2,  'Maintenance',      1000.00, 'Success'),
(3,  'Fuel',             1800.00, 'Success'),
(3,  'Driver Allowance', 1200.00, 'Failed'),
(4,  'Fuel',             2200.00, 'Success'),
(4,  'Toll',              600.00, 'Success'),
(5,  'Fuel',             4000.00, 'Success'),
(5,  'Driver Allowance', 2000.00, 'Success'),
(6,  'Fuel',             1500.00, 'Success'),
(6,  'Parking',           300.00, 'Failed'),
(7,  'Fuel',             2800.00, 'Success'),
(7,  'Toll',              900.00, 'Success'),
(8,  'Fuel',             3500.00, 'Success'),
(8,  'Maintenance',      2000.00, 'Failed'),
(9,  'Fuel',             2100.00, 'Success'),
(9,  'Food',              500.00, 'Success'),
(10, 'Fuel',             4200.00, 'Success'),
(10, 'Toll',             1100.00, 'Failed'),
(11, 'Fuel',             3000.00, 'Success'),
(12, 'Fuel',             3800.00, 'Success'),
(12, 'Driver Allowance', 1500.00, 'Success'),
(13, 'Fuel',             3200.00, 'Success');
GO
