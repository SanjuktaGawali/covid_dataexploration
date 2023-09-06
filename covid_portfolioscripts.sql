USE portfolio;
select * from covid_deathdata;
SELECT * FROM covid_vaccinationdata;

SELECT location, date, total_cases, total_deaths, new_cases, population
FROM covid_deathdata
ORDER BY 3,4;

-- Looking at total cases vs total deaths
SELECT location, date, total_cases, total_deaths, new_cases, (total_deaths/total_cases)*100 as deathpercentage
FROM covid_deathdata
ORDER BY 3,4;

-- Looking at total cases vs total deaths (in Austria)
SELECT location, date, total_cases, total_deaths, new_cases, (total_deaths/total_cases)*100 as deathpercentage
FROM covid_deathdata
WHERE location like "%Austria"
ORDER BY 3,4;

-- show what persantage of population got covid
SELECT location, date, total_cases, population, (total_cases/population)*100 as covid_population
FROM covid_deathdata
WHERE location like "%Austria"
ORDER BY 3,4;

-- Looking for country with highest rate of infection
SELECT location, MAX(total_cases) as highestinfcetion, population, MAX((total_cases/population))*100 as infected
FROM covid_deathdata
GROUP BY location,population
ORDER BY infected DESC;

-- Showing countries with highest death count per 
SELECT location, MAX(total_deaths) as highestdeaths
FROM covid_deathdata
GROUP BY location
ORDER BY highestdeaths DESC;

-- Showing continents with highest death count 
SELECT continent, MAX(total_deaths) as highestdeaths
FROM covid_deathdata
GROUP BY continent
ORDER BY highestdeaths DESC;

-- Global Numbers
SELECT date, SUM(new_deaths) AS totaldeath, SUM(new_cases) AS totacases, (SUM(new_deaths)/SUM(new_cases))*100 as deathpercentage
FROM covid_deathdata
GROUP BY date
ORDER BY date DESC;

SELECT SUM(new_deaths) AS totaldeath, SUM(new_cases) AS totacases, (SUM(new_deaths)/SUM(new_cases))*100 as deathpercentage
FROM covid_deathdata;

-- Join tables
SELECT *
FROM covid_deathdata dea
JOIN covid_vaccinationdata vac
ON dea.location = vac.location
AND dea.date = vac.date;

-- looking population vs vaccinated 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM covid_deathdata dea
JOIN covid_vaccinationdata vac
ON dea.location = vac.location
AND dea.date = vac.date
ORDER BY date DESC;

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM covid_deathdata dea
JOIN covid_vaccinationdata vac
ON dea.location = vac.location
AND dea.date = vac.date
ORDER BY date DESC;

CREATE VIEW totalglobalnumber as
SELECT SUM(new_deaths) AS totaldeath, SUM(new_cases) AS totacases, (SUM(new_deaths)/SUM(new_cases))*100 as deathpercentage
FROM covid_deathdata;

select * from totalglobalnumber;