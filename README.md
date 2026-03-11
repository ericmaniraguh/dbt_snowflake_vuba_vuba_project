

# Vuba Vuba Analytics Data Pipeline (dbt + Snowflake)

## 1. Project Overview

This project implements a **modern analytics engineering pipeline** using **dbt (Data Build Tool)** to transform raw operational data from the **Vuba Vuba delivery platform** into analytics-ready datasets in **Snowflake**.

The pipeline organizes raw delivery data (customers, orders, shops, and order items) into a structured **analytics warehouse** for reporting, dashboards, and business insights.

### Architecture

```
Operational Data (PostgreSQL / Source Systems)
                ↓
        Snowflake Raw Tables
                ↓
           dbt Staging
                ↓
        dbt Intermediate Models
                ↓
          dbt Mart Models
                ↓
        Analytics & Dashboards
```

This layered architecture ensures:

* Clean and reusable transformations
* Reliable analytics datasets
* Clear data lineage
* Scalable data pipelines

---

# 2. Technologies Used

| Technology                             | Purpose                            |
| -------------------------------------- | ---------------------------------- |
| **dbt (Data Build Tool)**              | SQL-based transformation framework |
| **Snowflake**                          | Cloud data warehouse               |
| **PostgreSQL**                         | Operational source database        |
| **Python Virtual Environment (.venv)** | Dependency isolation               |
| **dotenv (.env)**                      | Secure credential management       |
| **Git**                                | Version control                    |

---

# 3. Project Structure

Your project follows the **recommended dbt modeling structure**.

```
dbt_core_project
│
├── models
│   │
│   ├── staging/vuba
│   │   ├── stg_vuba__customers.sql
│   │   ├── stg_vuba__orders.sql
│   │   ├── stg_vuba__order_items.sql
│   │   └── stg_vuba__shops.sql
│   │
│   ├── intermediate
│   │   ├── int_vuba__order_totals.sql
│   │   └── int_vuba__orders_with_customer_shop.sql
│   │
│   ├── marts
│   │   ├── dim_customers.sql
│   │   ├── fct_orders.sql
│   │   └── fct_shop_revenue.sql
│   │
│   └── _vuba_sources.yml
│
├── macros
├── seeds
├── snapshots
├── target
├── logs
└── dbt_project.yml
```

### Layer Responsibilities

#### Staging Layer

Cleans and standardizes raw data.

Examples:

* `stg_vuba__customers`
* `stg_vuba__orders`
* `stg_vuba__shops`

Typical transformations:

* rename columns
* enforce consistent formats
* remove duplicates

---

#### Intermediate Layer

Applies business logic and combines staging models.

Examples:

* `int_vuba__order_totals`
* `int_vuba__orders_with_customer_shop`

This layer creates reusable transformations for downstream models.

---

#### Mart Layer

Creates **analytics-ready tables** used by dashboards.

Examples:

* `dim_customers`
* `fct_orders`
* `fct_shop_revenue`

These tables follow a **dimensional modeling approach**:

* **Fact tables** → events (orders, revenue)
* **Dimension tables** → descriptive attributes (customers)

---

# 4. Source Data Definition

Raw tables are defined in `_vuba_sources.yml`.

Example:

```yaml
version: 2

sources:
  - name: vuba_system
    description: "Source system for Vuba delivery platform"
    database: VUBA_VUBA_DB
    schema: VUBA_SCHEMA

    tables:
      - name: customers
        identifier: CUSTOMERS

      - name: orders
        identifier: ORDERS

      - name: shops
        identifier: SHOPS

      - name: order_items
        identifier: ORDER_ITEMS
```

These sources correspond to Snowflake tables:

```
VUBA_VUBA_DB.VUBA_SCHEMA.CUSTOMERS
VUBA_VUBA_DB.VUBA_SCHEMA.ORDERS
VUBA_VUBA_DB.VUBA_SCHEMA.SHOPS
VUBA_VUBA_DB.VUBA_SCHEMA.ORDER_ITEMS
```

---

# 5. Environment Configuration

Sensitive credentials are stored in **environment variables** and loaded via `.env`.

Example:

```
SNOWFLAKE_ACCOUNT=xxxx
SNOWFLAKE_USER=xxxx
SNOWFLAKE_PASSWORD=xxxx
SNOWFLAKE_ROLE=TRANSFORMER
SNOWFLAKE_WAREHOUSE=COMPUTE_WH
SNOWFLAKE_DATABASE=VUBA_VUBA_DB
SNOWFLAKE_SCHEMA=VUBA_SCHEMA
```

These variables are referenced in `~/.dbt/profiles.yml`.

---

# 6. dbt Profiles

The project supports **multiple environments**:

| Environment | Purpose                |
| ----------- | ---------------------- |
| dev         | Local development      |
| test        | CI / validation        |
| prod        | Production             |
| reddit      | Experimental pipelines |

Example configuration:

```yaml
dbt_core_project:
  target: dev
  outputs:

    dev:
      type: snowflake
      account: "{{ env_var('SNOWFLAKE_ACCOUNT') }}"
      user: "{{ env_var('SNOWFLAKE_USER') }}"
      password: "{{ env_var('SNOWFLAKE_PASSWORD') }}"
      role: "{{ env_var('SNOWFLAKE_ROLE') }}"
      warehouse: "{{ env_var('SNOWFLAKE_WAREHOUSE') }}"
      database: "{{ env_var('SNOWFLAKE_DATABASE') }}"
      schema: "{{ env_var('SNOWFLAKE_SCHEMA') }}"
      threads: 4
```

---

# 7. Running the Project

### Activate the environment

```bash
source .venv/bin/activate
```

### Load environment variables

```bash
export $(grep -v '^#' .env | xargs)
```

### Verify configuration

```bash
dbt debug
```

### Run models

```bash
dbt run
```

### Run data tests

```bash
dbt test
```

### Generate documentation

```bash
dbt docs generate
dbt docs serve
```

---

# 8. Data Quality

dbt tests ensure data reliability.

Examples:

* **unique** → primary keys
* **not_null** → required fields
* **relationships** → foreign keys

Example:

```yaml
columns:
  - name: customer_id
    tests:
      - unique
      - not_null
```

---

# 9. Analytics Use Cases

This pipeline enables analytics such as:

* Revenue per shop
* Customer ordering patterns
* Order volume trends
* Delivery performance analysis
* Customer lifetime value

---

# 10. Useful dbt Commands

| Command             | Description         |
| ------------------- | ------------------- |
| `dbt debug`         | Check configuration |
| `dbt run`           | Execute models      |
| `dbt test`          | Run data tests      |
| `dbt build`         | Run models + tests  |
| `dbt docs generate` | Generate docs       |
| `dbt docs serve`    | View docs           |

---

# 11. Author

**Eric Maniraguha**
Data Scientist • Data Engineer
Kigali, Rwanda

---
