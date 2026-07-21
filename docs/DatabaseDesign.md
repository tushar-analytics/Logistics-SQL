# Database Design

## Overview

Three tables, one straightforward parent → child → grandchild chain:

```
Vehicles (1) ---- (many) Trips (1) ---- (many) Expenses
```

A vehicle can make many trips. A trip can generate many expense line items
(fuel, toll, food, maintenance, etc).

## Table: Vehicles

| Column           | Type          | Constraint                              |
|------------------|---------------|------------------------------------------|
| VehicleID        | INT IDENTITY  | PRIMARY KEY                              |
| VehicleNumber    | VARCHAR(20)   | NOT NULL, UNIQUE                         |
| VehicleType      | VARCHAR(30)   | NOT NULL                                 |
| RegistrationDate | DATE          | NULL                                     |
| Status           | VARCHAR(15)   | NOT NULL, CHECK IN ('Active','Maintenance') |

## Table: Trips

| Column             | Type           | Constraint                     |
|--------------------|----------------|----------------------------------|
| TripID             | INT IDENTITY   | PRIMARY KEY                      |
| VehicleID          | INT            | NOT NULL, FK → Vehicles(VehicleID) |
| SourceCity         | VARCHAR(50)    | NOT NULL                         |
| DestinationCity    | VARCHAR(50)    | NOT NULL                         |
| TripDate           | DATE           | NOT NULL                         |
| FuelAdvanceAmount  | DECIMAL(18,2)  | NOT NULL, CHECK >= 0             |

## Table: Expenses

| Column          | Type           | Constraint                          |
|-----------------|----------------|----------------------------------------|
| ExpenseID       | INT IDENTITY   | PRIMARY KEY                            |
| TripID          | INT            | NOT NULL, FK → Trips(TripID)           |
| ExpenseCategory | VARCHAR(50)    | NOT NULL                               |
| Amount          | DECIMAL(18,2)  | NOT NULL, CHECK >= 0                   |
| PaymentStatus   | VARCHAR(15)    | NOT NULL, CHECK IN ('Success','Failed')|

## Naming Convention

- `PK_<Table>` for primary keys
- `FK_<Table>_<ReferencedTable>` for foreign keys
- `UQ_<Table>_<Column>` for unique constraints
- `CK_<Table>_<Column>` for check constraints

## Normalization

The schema is in 3NF — no repeating groups, every non-key column depends
only on its table's primary key, and there's no transitive dependency
(e.g. vehicle info isn't duplicated on the Trips table).
