---

# dbt Data Pipeline: PostgreSQL → Snowflake

## 1. Project Overview

This project demonstrates a modern data engineering workflow using **dbt** to transform data stored in **Snowflake**, while ingesting data from **PostgreSQL** as the operational source system.

**Architecture:**

```
PostgreSQL (Operational Database)
           ↓
     Snowflake (Data Warehouse)
           ↓
    dbt Transformations
           ↓
      Analytics Models
```

This setup ensures scalable, secure, and maintainable data transformations, separating operational workloads from analytics workloads.

---

## 2. Technologies Used

* **dbt (Data Build Tool)** – SQL-based transformation framework
* **Snowflake** – Cloud data warehouse for analytics and transformations
* **PostgreSQL** – Operational database serving as the raw data source
* **Python Virtual Environment (.venv)** – Dependency management
* **dotenv** – For loading environment variables securely

---

## 3. Project Structure

```
dbt_demo/
│
├── .venv/                     # Python virtual environment
│
└── dbt_project_demo/
    ├── README.md
    ├── dbt_project.yml       # Main dbt configuration
    ├── models/               # SQL transformation models
    ├── seeds/                # Static CSV datasets
    ├── snapshots/            # Slowly changing dimension tracking
    ├── tests/                # Data quality tests
    ├── macros/               # Reusable SQL functions
    └── analyses/             # Analytical queries
```

---

## 4. Environment Variables

All sensitive credentials are stored in a `.env` file and referenced in `profiles.yml`.

**Example `.env`:**

```env
# Snowflake Dev
SNOWFLAKE_ACCOUNT=<your_account>
SNOWFLAKE_USER=<your_dev_user>
SNOWFLAKE_PASSWORD=<your_dev_password>
SNOWFLAKE_ROLE=<your_dev_role>
SNOWFLAKE_WAREHOUSE=<your_dev_warehouse>
SNOWFLAKE_DATABASE=<your_dev_database>
SNOWFLAKE_SCHEMA=<your_dev_schema>

# Snowflake Test
DBT_TEST_USER=<your_test_user>
DBT_TEST_PASSWORD=<your_test_password>

# Snowflake Prod
DBT_PROD_USER=<your_prod_user>
DBT_PROD_PASSWORD=<your_prod_password>

# PostgreSQL Source
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_DB=source_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=secret
```

> **Tip:** Add `.env` to `.gitignore` to prevent committing sensitive information.

---

## 5. dbt Profiles Configuration

Located at `~/.dbt/profiles.yml`. Supports multiple environments:

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

    test:
      type: snowflake
      account: "{{ env_var('SNOWFLAKE_ACCOUNT') }}"
      user: "{{ env_var('DBT_TEST_USER') }}"
      password: "{{ env_var('DBT_TEST_PASSWORD') }}"
      role: "TRANSFORMER"
      warehouse: "TEST_WH"
      database: "TEST_DB"
      schema: "CI_TESTING"
      threads: 8

    prod:
      type: snowflake
      account: "{{ env_var('SNOWFLAKE_ACCOUNT') }}"
      user: "{{ env_var('DBT_PROD_USER') }}"
      password: "{{ env_var('DBT_PROD_PASSWORD') }}"
      role: "TRANSFORMER"
      warehouse: "PROD_WH"
      database: "PROD_DB"
      schema: "ANALYTICS"
      threads: 16

    reddit:
      type: snowflake
      account: "{{ env_var('SNOWFLAKE_ACCOUNT') }}"
      user: "{{ env_var('SNOWFLAKE_USER') }}"
      password: "{{ env_var('SNOWFLAKE_PASSWORD') }}"
      role: "{{ env_var('SNOWFLAKE_ROLE') }}"
      warehouse: "{{ env_var('SNOWFLAKE_WAREHOUSE') }}"
      database: "RAW_DATA"
      schema: "REDDIT_RAW"
      threads: 1
```

---

## 6. Running dbt

### 6.1 Load environment variables

```bash
export $(grep -v '^#' .env | xargs)
```

### 6.2 Debug connection

```bash
dbt debug
```

### 6.3 Run transformations

```bash
dbt run
```

### 6.4 Test data quality

```bash
dbt test
```

### 6.5 Switch environment

```bash
dbt run --target prod
```

---

## 7. Data Transformation Workflow

1. **Raw Layer** – Load PostgreSQL data into Snowflake
2. **Staging Layer** – Basic cleaning & standardization
3. **Intermediate Layer** – Apply business logic
4. **Mart Layer** – Analytics-ready tables for dashboards & reporting

---

## 8. Best Practices

* Use **staging models** for raw tables
* Store credentials in `.env`
* Apply **data tests** for quality assurance
* Version control your dbt project with Git
* Use descriptive, consistent model naming

---

## 9. Useful dbt Commands

| Command             | Purpose                               |
| ------------------- | ------------------------------------- |
| `dbt debug`         | Validate configuration and connection |
| `dbt run`           | Execute SQL models                    |
| `dbt test`          | Run data quality tests                |
| `dbt docs generate` | Generate documentation                |
| `dbt docs serve`    | View documentation locally            |

---

## 10. References

* [dbt Documentation](https://docs.getdbt.com/)
* [Snowflake Documentation](https://docs.snowflake.com/)
* [PostgreSQL Documentation](https://www.postgresql.org/docs/)

---

## 11. Author

Eric Maniraguha
Data Scientist & Data Engineer
Kigali, Rwanda

---

