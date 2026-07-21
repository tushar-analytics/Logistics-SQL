/* ============================================================
   File        : 02_Create_Tables.sql
   Purpose     : Create Vehicles, Trips and Expenses tables
                 with all keys and constraints
   ============================================================ */

USE LogisticsFleetDB;
GO

-- ------------------------------------------------------------
-- Table: Vehicles
-- ------------------------------------------------------------
CREATE TABLE Vehicles
(
    VehicleID        INT IDENTITY(1,1)   NOT NULL,
    VehicleNumber    VARCHAR(20)         NOT NULL,
    VehicleType      VARCHAR(30)         NOT NULL,
    RegistrationDate DATE                NULL,
    Status           VARCHAR(15)         NOT NULL DEFAULT ('Active'),

    CONSTRAINT PK_Vehicles PRIMARY KEY CLUSTERED (VehicleID),
    CONSTRAINT UQ_Vehicles_VehicleNumber UNIQUE (VehicleNumber),
    CONSTRAINT CK_Vehicles_Status CHECK (Status IN ('Active', 'Maintenance'))
);
GO

-- ------------------------------------------------------------
-- Table: Trips
-- ------------------------------------------------------------
CREATE TABLE Trips
(
    TripID             INT IDENTITY(1,1)  NOT NULL,
    VehicleID          INT                NOT NULL,
    SourceCity         VARCHAR(50)        NOT NULL,
    DestinationCity    VARCHAR(50)        NOT NULL,
    TripDate           DATE               NOT NULL,
    FuelAdvanceAmount  DECIMAL(18,2)      NOT NULL DEFAULT (0),

    CONSTRAINT PK_Trips PRIMARY KEY CLUSTERED (TripID),
    CONSTRAINT FK_Trips_Vehicles FOREIGN KEY (VehicleID)
        REFERENCES Vehicles(VehicleID),
    CONSTRAINT CK_Trips_FuelAdvanceAmount CHECK (FuelAdvanceAmount >= 0)
);
GO

-- ------------------------------------------------------------
-- Table: Expenses
-- ------------------------------------------------------------
CREATE TABLE Expenses
(
    ExpenseID       INT IDENTITY(1,1)   NOT NULL,
    TripID          INT                 NOT NULL,
    ExpenseCategory VARCHAR(50)         NOT NULL,
    Amount          DECIMAL(18,2)       NOT NULL,
    PaymentStatus   VARCHAR(15)         NOT NULL,

    CONSTRAINT PK_Expenses PRIMARY KEY CLUSTERED (ExpenseID),
    CONSTRAINT FK_Expenses_Trips FOREIGN KEY (TripID)
        REFERENCES Trips(TripID),
    CONSTRAINT CK_Expenses_PaymentStatus CHECK (PaymentStatus IN ('Success', 'Failed')),
    CONSTRAINT CK_Expenses_Amount CHECK (Amount >= 0)
);
GO
