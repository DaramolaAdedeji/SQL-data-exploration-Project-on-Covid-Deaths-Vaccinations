📊 COVID-19 Data Exploration: Deaths & Vaccinations (SQL Project)
📌 Project Overview

This project focuses on exploratory data analysis (EDA) of global COVID-19 deaths and vaccination data using SQL.
The objective was to explore infection rates, mortality risk, population impact, and vaccination progress across countries and continents, while demonstrating strong SQL-based analytical thinking.

The analysis mirrors how analysts explore large public-health and economic datasets to extract actionable insights before visualization or modeling.

📂 Data Sources

Two relational datasets were used:

COVID Deaths Dataset

Total cases

New cases

Total deaths

Population

Date, location, continent

COVID Vaccinations Dataset

New vaccinations

Date

Location

Records with missing continent information were excluded to ensure geographically meaningful analysis.

🔍 Data Exploration Approach (SQL)

The exploration followed a structured, question-driven approach:

1. Initial Data Inspection

Verified data structure and ordering

Filtered out aggregate rows (where continent was NULL)

Selected only relevant analytical columns

This ensured clean, analysis-ready input before deeper exploration.

2. Total Cases vs Total Deaths

To understand mortality risk, the analysis calculated:

Death percentage = (total_deaths / total_cases) * 100

This revealed how fatality likelihood varied across countries and over time, rather than relying on absolute numbers alone.

📍 Country Focus: Nigeria

A country-level filter was applied to Nigeria to:

Track how death risk evolved over time

Provide localized insight rather than global averages

Highlight:

The calculated death percentage provides a clearer picture of COVID-19 severity beyond raw case counts, especially at a country level.

3. Infection Rate vs Population

To measure spread intensity, the analysis compared:

Total cases relative to population size

Metric used:

(total_cases / population) * 100

This revealed:

The proportion of each country’s population that had been infected

Why population-adjusted metrics are more meaningful than total case counts

4. Countries with Highest Infection Rates

Using aggregation and grouping:

Countries were ranked by maximum infection rate relative to population

Highlight:

Smaller countries with high population exposure often ranked higher than more populous nations, reinforcing the importance of normalization in data analysis.

5. Death Counts by Continent & Country

The analysis then shifted to macro-level impact:

Maximum total deaths by continent

Maximum total deaths by country

This provided:

A continental comparison of COVID-19 severity

Identification of countries most affected in absolute terms

6. Global COVID-19 Impact

To understand the pandemic at scale, global aggregates were calculated:

Total global cases

Total global deaths

Global death percentage

Both cumulative totals and daily trends were analyzed, allowing insight into:

Overall severity

How mortality risk changed over time

💉 Vaccination Analysis
7. Population vs Vaccination Progress

A join between deaths and vaccinations datasets enabled:

Alignment of vaccination data with population size

Time-based vaccination tracking by country

8. Rolling Vaccination Count

Using a window function, a rolling total of vaccinations was calculated:

SUM(new_vaccinations) OVER (PARTITION BY location ORDER BY date)

This allowed tracking of:

Vaccination progress over time

Adoption speed across countries

Highlight:

Rolling metrics provide far more insight into vaccination momentum than daily counts alone.

9. Vaccination Coverage Percentage

A temporary table was created to compute:

Percentage of population vaccinated
(rolling_vaccinations / population) * 100

This step demonstrates:

Advanced SQL workflow

Use of temporary tables for layered calculations

10. View Creation for Visualization

A SQL VIEW was created to store vaccination progress data for:

Reuse

Downstream visualization in BI tools

This reflects real-world analytics practices where SQL feeds dashboards and reports.

📈 Key Highlights & Insights

COVID-19 impact varies significantly when adjusted for population size

Mortality risk is better understood through death percentages, not raw counts

Some countries experienced high infection penetration despite smaller populations

Vaccination rollout patterns differ widely across regions

Rolling metrics uncover trends hidden in daily figures

🛠 Tools & Technologies

SQL (MySQL)

Relational Joins

Window Functions

Temporary Tables

SQL Views

🧠 Skills Demonstrated

Exploratory data analysis (EDA)

Analytical problem framing

Population-normalized metrics

Time-series analysis

SQL joins & window functions

Translating raw data into insights

📌 Project Type: Exploratory Data Analysis

📌 Domain: Public Health / Data Analytics

📌 Author: Daramola Adedeji

I’m open to collaboration and discussions. Feel free to reach out to me via [LinkedIn](https://www.linkedin.com/in/adedeji-daramola-729250247/).
