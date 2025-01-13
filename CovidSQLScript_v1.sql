-- Looking at total cases vs total deaths in norway
SELECT 
    location, 
    date,
    COALESCE(total_cases, 0) AS total_cases, 
    COALESCE(total_deaths, 0) AS total_deaths, 
    CASE 
        WHEN COALESCE(total_cases, 0) > 0 THEN (COALESCE(total_deaths, 0)::NUMERIC / COALESCE(total_cases, 0)::NUMERIC) * 100
        ELSE 0
    END AS death_percentage
FROM coviddeaths
WHERE 
    location LIKE '%Norway%'
ORDER BY 
    location, 
    date;

-- TOTAL DEATHS COUNT BY COUNTRY
SELECT location, MAX(COALESCE(total_deaths, 0)) AS total_deaths_count
FROM coviddeaths
WHERE continent IS NOT null
GROUP BY location
ORDER BY total_deaths_count DESC

-- TOTAL DEATHS COUNT BY CONTINENT
CREATE VIEW DeathsByContinent AS
	SELECT location, MAX(COALESCE(total_deaths, 0)) AS total_deaths_count
	FROM coviddeaths
	WHERE continent IS null
	GROUP BY location
	ORDER BY total_deaths_count DESC;

-- CUMULATIVE GLOBAL TOTAL-/NEW CASES AND TOTAL_/NEW DEATHS PER DATE
SELECT date, SUM(new_cases) AS new_cases_this_date, SUM(total_cases) AS total_cases_cumulative, SUM(new_deaths) AS new_deaths_this_date, SUM(total_deaths) AS total_deaths_cumulative --total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_procentage
FROM coviddeaths
WHERE continent IS NOT null
GROUP BY date
ORDER BY date;

-- GLOBAL NUMBERS
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) as total_deaths,
SUM(new_deaths)/SUM(new_cases)*100 AS death_percantage
FROM coviddeaths
WHERE continent IS NOT null
ORDER BY 1,2;

-- LOOKING AT TOTAL POPULATION VS VACCINATION
SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vaccs.new_vaccinations,
SUM(new_vaccinations) OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.date) AS cumulative_people_vaccinated
FROM coviddeaths AS deaths
JOIN covidvaccs AS vaccs
	ON deaths.location = vaccs.location
	AND deaths.date = vaccs.date
WHERE deaths.continent IS NOT NULL
ORDER BY 2,3;

-- CTE
WITH popvsvacc (continent, location, date, population, new_vaccinations, cumulative_people_vaccinated)
AS (
	SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vaccs.new_vaccinations,
	SUM(new_vaccinations) OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.date) AS cumulative_people_vaccinated
	FROM coviddeaths AS deaths
	JOIN covidvaccs AS vaccs
		ON deaths.location = vaccs.location
		AND deaths.date = vaccs.date
	WHERE deaths.continent IS NOT NULL
	ORDER BY 2,3
)
SELECT *, (cumulative_people_vaccinated/population)*100
FROM popvsvacc;

-- CREATE VIEW TO STORE DATA FOR LATER VISUAISATION
CREATE VIEW PercentPopulationVaccinated as
	SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vaccs.new_vaccinations,
	SUM(new_vaccinations) OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.date) AS cumulative_people_vaccinated
	FROM coviddeaths AS deaths
	JOIN covidvaccs AS vaccs
		ON deaths.location = vaccs.location
		AND deaths.date = vaccs.date
	WHERE deaths.continent IS NOT NULL;
