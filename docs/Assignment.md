# Assignment Brief

This document restates the original assignment scope for reference.

## Objective

Design and implement a Microsoft SQL Server database for a small logistics/fleet
operation, then write reporting queries, an index, and a transaction-safe
insertion procedure against it.

## Scope

- **Part 1** – Schema: `Vehicles`, `Trips`, `Expenses`, with PK/FK/CHECK
  constraints and sample data.
- **Part 2** – Five analytical queries (regional trips, failed payments,
  top expenses, monthly MIS, fuel-advance overrun audit).
- **Part 3** – A composite index on `Expenses(ExpenseCategory, PaymentStatus)`.
- **Part 4** – A transaction-safe stored procedure for inserting an expense,
  using `TRY/CATCH`, `BEGIN TRAN`, `COMMIT`, `ROLLBACK`, and `THROW`.

## Assumptions

- `VehicleNumber` is unique per vehicle (used as the natural business key
  in reports, even though `VehicleID` is the actual PK).
- A trip always belongs to exactly one vehicle, and an expense always
  belongs to exactly one trip (no shared/split expenses).
- "Successful expenses" for the fuel-advance audit means `PaymentStatus = 'Success'`
  only — failed payments don't count against the advance.
- Dates are stored as `DATE` (no time component needed for this data).
- Currency isn't modeled explicitly; all `Amount` / `FuelAdvanceAmount` values
  are assumed to be in the same currency.
