# Swiggy Food Delivery Analytics — Snowflake Data Engineering

A multi-domain data engineering project modeling food-delivery operations in **Snowflake**, using staged CSV ingestion, incremental loads, change tracking with **Streams**, incremental **MERGE** operations, dimensional modeling, and business analytics views.

The repository contains the original SQL implementation, a subset of sample CSV data suitable for public sharing, and detailed project documentation. SQL and shared data are preserved byte-for-byte from the provided project archive.

## Architecture

```text
Source CSV files (initial + incremental loads)
                      |
                      v
             Snowflake STAGE_CH
           CSV staging / COPY INTO
                Stream changes
                      |
                      v
             Snowflake CLEAN_SCH
           Transform + incremental MERGE
                      |
                      v
          Snowflake CONSUMPTION_SCH
       Dimensions / order-item fact model
                      |
                      v
            KPI views and reporting
      Revenue trends and restaurant metrics
```

## Technologies and concepts

**Snowflake SQL** · **COPY INTO** · **Internal staging** · **Streams** · **MERGE** · **Data quality and deduplication** · **Dimensional modeling** · **Analytical views**

## Repository structure

```text
swiggy-snowflake/
├── README.md
├── sql/
│   ├── 01_setup/
│   ├── 02_dimensions/
│   │   ├── location/
│   │   ├── customer/
│   │   ├── restaurant/
│   │   ├── menu/
│   │   ├── delivery_agent/
│   │   └── date/
│   ├── 03_transactions/
│   ├── 04_facts/
│   └── 05_reporting/
├── data/
│   └── Swiggy_Order_Data/
│       ├── 01-location-csv/
│       ├── 06-menu/
│       ├── 07-order-csv/
│       ├── 08-order-item-csv/
│       └── 10-delivery-csv/
└── docs/
    └── Swiggy_Project_Documentation_Study_Detailed_BW.docx
```

## Subject areas

The source package models:

- **Location** — geographical entities and incremental changes
- **Restaurants** — restaurant dimension and attributes
- **Customers and addresses** — customer profiles and delivery destinations
- **Menu** — menu items and updates
- **Orders and order items** — transactional records and items
- **Delivery agents and deliveries** — fulfillment and delivery details
- **Date dimension** — calendar attributes for analysis
- **Order-item fact** — analytical fact table
- **Reporting** — KPI views for orders, revenue, and restaurant performance

## SQL organization

| Section | Purpose |
| --- | --- |
| [`01_setup/`](sql/01_setup/) | Database, schemas and core infrastructure |
| [`02_dimensions/`](sql/02_dimensions/) | Entity-specific staging, cleaning and dimension handling |
| [`03_transactions/`](sql/03_transactions/) | Orders, order items and delivery ingestion/transformation |
| [`04_facts/`](sql/04_facts/) | Order-item fact modeling |
| [`05_reporting/`](sql/05_reporting/) | KPI and business reporting views |

The SQL scripts include initial-load and change-processing examples. Consult their object dependencies and the [project documentation](docs/Swiggy_Project_Documentation_Study_Detailed_BW.docx) before running them in Snowflake. This GitHub presentation does not verify live execution.

## Example datasets

This public repository includes **18 smaller CSV files**, grouped by initial and daily delta loads, for location, menu, orders, order items, and delivery data.

**Public-sharing limitation:** The source archive also contains customer details (names, mobile numbers, emails, addresses), restaurant contact information, delivery-agent phone numbers, and login-audit records. These additional datasets have intentionally **not** been published here because their synthetic or consented status was not established. They remain in the original project ZIP.

The original archive also contains a large `order-item-initial-v2.csv` file (~43 MB) that is **not included** in this repository. This repository therefore does **not** provide the full source dataset needed to reproduce every loading scenario as-is.

No CSV content was modified in preparing the public subset.

## Project documentation

See [`docs/Swiggy_Project_Documentation_Study_Detailed_BW.docx`](docs/Swiggy_Project_Documentation_Study_Detailed_BW.docx) for the full study notes.

## Safety and execution notes

- These scripts may use environment-specific Snowflake objects, stage names and roles; adjust in a separate execution environment.
- Review any `CREATE OR REPLACE`, `TRUNCATE`, `DELETE`, and `MERGE` statements before executing.
- Data processing results, schedules, dashboards and production readiness have not been independently validated here.

## Author

**Neha Dudhane** — [GitHub](https://github.com/nehadudhane)
