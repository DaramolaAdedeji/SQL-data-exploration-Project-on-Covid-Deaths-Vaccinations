SELECT *
FROM covid_deaths.covid_death
WHERE continent is not NULL
ORDER BY 3,4;


-- SELECT *
-- FROM covid_vaccination.covid_vaccinations
-- ORDER BY 3,4;

-- Select data to be used 
 
SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM covid_deaths.covid_death
WHERE continent is not NULL
ORDER BY 1,5;

-- Looking at Total Cases VS Total Deaths 

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)* 100 AS deathpercentage
FROM covid_deaths.covid_death
WHERE continent is not NULL
ORDER BY 1,3;

-- Looking at Total Cases VS Total Deaths in Nigeria 

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)* 100 AS deathpercentage
FROM covid_deaths.covid_death
WHERE location like 'nigeria%'
AND continent is not NULL
ORDER BY 1,3;

-- The Percentage shows th likelihood of dying if you contact it in Nigeria


-- Looking at Total cases VS Population 

-- Shows What percentage of the population has gotten covid.

SELECT location, date, total_cases, population, (total_cases/population)* 100 AS percentpopulationinfected
FROM covid_deaths.covid_death
-- WHERE location like 'nigeria%'
ORDER BY 1,3;

-- Looking at countries with highest infection rate compared to population 

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))* 100 AS percentpopulationinfected 
FROM covid_deaths.covid_death
-- WHERE location like 'nigeria%
GROUP BY location, population
ORDER BY  percentpopulationinfected DESC;


-- Showing Continents With The Highest death count Per Population
-- SHOWING DATA BY CONINENT


SELECT continent, MAX(CAST(total_deaths AS signed)) as totaldeathcount
FROM covid_deaths.covid_death
-- WHERE location like 'nigeria%
WHERE continent is not NULL
GROUP BY continent 
ORDER BY totaldeathcount DESC;
 
-- Showing Countries Highest Death Count Per Population  

SELECT location, MAX(CAST(total_deaths AS signed)) as totaldeathcount
FROM covid_deaths.covid_death
-- WHERE location like 'nigeria%
WHERE continent is not NULL
GROUP BY location
ORDER BY totaldeathcount DESC;

-- GLOBAL NUMBERS 

-- Total Number of global Population who contacted the virus, the total deaths & death percentage  

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths as signed)) as total_deaths , SUM(CAST(new_deaths as signed))/ SUM(new_cases)*100 AS deathpercentage
FROM covid_deaths.covid_death
WHERE continent is not NULL
-- GROUP BY date
ORDER BY 2,1; 

-- STILL ON GLOBAL NUMBERS 

SELECT date, SUM(new_cases) AS total_cases, SUM(CAST(new_deaths as signed)) as total_deaths , SUM(CAST(new_deaths as signed))/ SUM(new_cases)*100 AS deathpercentage
FROM covid_deaths.covid_death
WHERE continent is not NULL
GROUP BY date
ORDER BY 2,1;


-- Now Tking A look at Covid Vccinations

-- LOOKING AT TOTAL POPULATION VS VACCINATION  

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM covid_deaths.covid_death dea
JOIN covid_vaccination.covid_vaccinations vac
   ON  dea.location = vac.location 
   AND dea.date = vac.date 
WHERE dea.continent is not NULL
ORDER BY 2,3;

-- NOW LET'S CREAE A ROLLING NUMBER OF PEOPLE VACCINATED IN EACH CONTINENT OR COUNTRY 

 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as signed)) OVER (PARTITION BY dea.location order by dea.location
, dea.date) AS Rollingpeoplevaccinated 
-- (Rollingpeoplevaccinated/population)*100
FROM covid_deaths.covid_death dea
JOIN covid_vaccination.covid_vaccinations vac
   ON  dea.location = vac.location 
   AND dea.date = vac.date 
WHERE dea.continent is not NULL
ORDER BY 2,3;

-- WE ARE NOW GOING TO USE A TEMP TABLE TO CALCULATE THIS '(Rollingpeoplevaccinated/population)*100'

-- USING A TEMP TABLE 

-- DROP TABLE If exists (PercentPopulationVaccinated)
-- The short querry above is for anytime you want to add something to the table, this is what you just use to 
-- add anything to the table.

Create Temporary Table PercentPopulationVaccinated
(
continent nvarchar(255), 
location nvarchar(255),
Date datetime,
Population numeric,
new_vaccination numeric,
Rollingpeoplevaccinated numeric
);

INSERT INTO PercentPopulationVaccinated
SELECT dea.continent, dea.location,str_to_date(dea.date, '%m/%d/%Y'), dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as signed)) OVER (PARTITION BY dea.location order by dea.location
, dea.date) AS Rollingpeoplevaccinated 
-- (Rollingpeoplevaccinated/population)*100
FROM covid_deaths.covid_death dea
JOIN covid_vaccination.covid_vaccinations vac
   ON  dea.location = vac.location 
   AND str_to_date(dea.date, '%m/%d/%Y') = str_to_date(vac.date, '%m/%d/%Y')
WHERE dea.continent is not NULL
ORDER BY 2,3;

SELECT *, (Rollingpeoplevaccinated/population)*100
FROM PercentPopulationVaccinated;

-- Creating a view to store data for later Visualizations

CREATE VIEW PercentPopulationVaccinated as 
SELECT dea.continent, dea.location,str_to_date(dea.date, '%m/%d/%Y'), dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as signed)) OVER (PARTITION BY dea.location order by dea.location
, dea.date) AS Rollingpeoplevaccinated 
-- (Rollingpeoplevaccinated/population)*100
FROM covid_deaths.covid_death dea
JOIN covid_vaccination.covid_vaccinations vac
   ON  dea.location = vac.location 
   AND str_to_date(dea.date, '%m/%d/%Y') = str_to_date(vac.date, '%m/%d/%Y')
WHERE dea.continent is not NULL
-- ORDER BY 2,3;

