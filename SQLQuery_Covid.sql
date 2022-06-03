-- Select Data that we are going to use

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths


-- Looking at Total Cases vs Total Deaths
-- Likelihood of dying if you contract covid in Ghana

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathRate
FROM PortfolioProject..CovidDeaths
WHERE location = 'Ghana'

-- Looking at Total Cases vs Population. Showing what percentage of population got Covid

SELECT location, date, total_cases, population, (total_cases/population)*100 as CovidRate
FROM PortfolioProject..CovidDeaths
WHERE location = 'Ghana'
ORDER BY total_cases

--Looking at Countries with Highest Infection Rate

SELECT location, population, MAX(total_cases) as TotalInfectionCount, MAX((total_cases/population))*100 as PopulationInfectionRate
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY PopulationInfectionRate desc

--Showing countries with Highest Death count per population

SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount desc

--Show continents with Highest Death count
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount desc

-- Global numbers per day

Select date, SUM(new_cases) as totalnewCases, SUM(cast(new_deaths as int)) as totalnewDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathRate
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY DeathRate desc

--Joining both Covid death table and Covid vaccination table


Select *
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date


-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null AND vac.new_vaccinations is not null
