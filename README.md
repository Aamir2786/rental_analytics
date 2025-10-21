# dbt Rental Data Analysis Project

This **dbt** (data build tool) project transforms raw data from a **Rental Property Management System** into a **Star Schema** optimized for analytical reporting and Business Intelligence (BI).

---

## Project Goal

The primary goal of this project is to model complex, semi-structured rental data (listings, amenities, calendar availability) into **clean, user-friendly Fact and Dimension tables**. This structure enables analysts to accurately calculate **key performance indicators (KPIs)** like consecutive stays, revenue by amenity, overall occupancy, and customer reviews.

---

## Core Star Schema

The project models the data into the following core tables:

### Dimension Tables

* `dim_listings`: Contains static, descriptive listing attributes (e.g., property type, number of bedrooms).
* `dim_hosts`: Contains descriptive attributes of the hosts (e.g., host verification status, host response time).

### Fact Tables

* `fct_daily_listing_snapshot`: Contains the daily, time-series events (price, availability), linked to `dim_listings` via a foreign key.
* `fct_review`: Contains the review details for the listings for a particular review date, linked to `dim_listings` via a foreign key.

---

## Run Commands

Use the following commands to interact with the dbt project:

| Command | Description |
| :--- | :--- |
| `dbt build` | **Execute all models AND run all tests.** This is the best single command for a complete production run. |
| `dbt run` | Compile and materialize all models. This builds the tables and views defined in your SQL files, but skips tests. |
| `dbt test` | Run all data quality tests defined in the YAML files (`unique`, `not_null`, `relationships`, etc.). |
| `dbt docs generate` | Generates the project documentation website. Creates the static files needed to view lineage, model descriptions, and column details. |
