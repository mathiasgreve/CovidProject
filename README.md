# COVID-19 Data Analysis and Visualization

This repository contains SQL scripts for analyzing and visualizing COVID-19 data. The scripts focus on various aspects of the pandemic, such as cases, deaths, vaccinations, and population impacts.

## Contents

## SQL Queries

The repository includes the following SQL queries:

1. Total Cases vs Total Deaths in Norway
- Calculates the death percentage relative to total cases for Norway.
- Handles null values using COALESCE to ensure robust calculations.
2. Total Deaths Count by Country
- Aggregates the total number of deaths for each country.
- Filters out rows where the continent is NULL.
3. Total Deaths Count by Continent
- Creates a view (DeathsByContinent) for the total deaths count, grouped by continent.
- Focuses on locations where the continent information is missing (likely global totals).
4. Cumulative Global Cases and Deaths by Date
- Calculates the global cumulative totals for new and total cases and deaths, grouped by date.
- Provides a timeline view of the pandemic's progression.
5. Global Totals and Death Percentage
- Computes the global totals for cases and deaths, and the overall death percentage.
- Excludes entries with NULL continents.
6. Total Population vs Vaccination
- Joins coviddeaths and covidvaccs tables to analyze the relationship between population and vaccination rates.
- Uses window functions (SUM with OVER) to calculate cumulative vaccinations per country.
7. Common Table Expression (CTE)
- Defines a reusable CTE (popvsvacc) for population and vaccination analysis.
- Includes cumulative vaccination percentage as part of the output.
8. View Creation for Visualization
- Creates a view (PercentPopulationVaccinated) to store data for visualization.
- Focuses on cumulative vaccination data grouped by country and date.

## Features

- Data Cleansing: Uses COALESCE to handle null values effectively.
- Aggregations: Calculates sums, maximums, and percentages.
- Window Functions: Leverages OVER for cumulative calculations.
- Joins: Combines data from multiple tables (coviddeaths and covidvaccs).
- Views: Prepares data for visualization by creating reusable views.

## Future Enhancements

The repository will be expanded to include:

Visualizations using Python libraries like Matplotlib, Seaborn, or Plotly.

Integration with tools like Tableau or Power BI for interactive dashboards.

More detailed analysis, such as correlations between vaccination rates and GDP per capita.

## How to Use

1. Prerequisites:
- A PostgreSQL database with the coviddeaths and covidvaccs tables populated.
- Data for COVID-19 cases, deaths, and vaccinations in CSV format.
2. Setup:
- Import the provided SQL script into your database using a tool like pgAdmin or the psql command-line tool.
3. Run Queries:
- Execute the queries to generate insights and prepare views for visualization.
4. Visualize:
- Use the views created (DeathsByContinent, PercentPopulationVaccinated) as data sources for your preferred visualization tool.

## Contributing
- Contributions are welcome! If you have ideas for improving the analysis or extending the visualizations, feel free to open a pull request or submit an issue.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments

Data Source: Please specify the source of your COVID-19 data (e.g., Our World in Data).

Tools: PostgreSQL, pgAdmin, and any future visualization tools.
