USE covid19
/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/
USE covid19
Select *
From covid_deaths
Where continent is not null 
order by 3,4


-- Select Data that we are going to be starting with
Select Location, date, total_cases, new_cases, total_deaths, population
From covid_deaths
Where continent is not null 
order by 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From covid_deaths
Where location like '%states%'
and continent is not null 
order by 1,2


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From covid_deaths
Where location like '%states%'
order by 1,2


-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid_deaths
Group by Location, Population
order by PercentPopulationInfected desc


-- Countries with Highest Death Count per Population

Select Location, MAX(total_deaths) as TotalDeathCount
From covid_deaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc



-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select continent, MAX(Total_deaths) as TotalDeathCount
From covid_deaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc



-- GLOBAL NUMBERS

Select date ,SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_Cases)*100 as DeathPercentage
From covid_deaths
where continent is not null 
Group By date
order by 1,2



-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths as dea
Join  covid19.`covid-vacc`as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3 


-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac 
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths as dea
Join  covid19.`covid-vacc`as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

-- maximum people vaccinated for each country 
Select  dea.location,  
 SUM(vac.new_vaccinations)  as TotalVacc_count
From covid_deaths as dea
Join  covid19.`covid-vacc`as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
group by 1
order by 2 desc 



-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists PercentPopulationVaccinated
Create Table PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From PercentPopulationVaccinated




-- Creating View to store data for later visualizations
-- 1)
Create View PercentPopulationVaccinated as
 With PopvsVac 
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths as dea
Join  covid19.`covid-vacc`as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

-- 2) 
Create View death_vs_UScase as 
Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From covid_deaths
Where location like '%states%'
and continent is not null 
order by 1,2

-- 3)
Create View case_vs_USpopulation as 
Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From covid_deaths
Where location like '%states%'
order by 1,2

-- 4) 
Create View Highestinfection_countries  as
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid_deaths
Group by Location, Population
order by PercentPopulationInfected desc

-- 5)
Create View Highestdeathscount_countries  as
Select Location, MAX(total_deaths) as TotalDeathCount
From covid_deaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc

-- 6)
Create View Highestdeathscount_continent  as
Select continent, MAX(Total_deaths) as TotalDeathCount
From covid_deaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc

-- 7)
Create View case_vs_deaths_global  as
Select date ,SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_Cases)*100 as DeathPercentage
From covid_deaths
where continent is not null 
Group By date
order by 1,2

-- 8)
Create View populations_vs_vaccinations  as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From covid_deaths as dea
Join  covid19.`covid-vacc`as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

-- 9) 
Create View TotalVacc_countries  as
Select  dea.location,  
 SUM(vac.new_vaccinations)  as TotalVacc_count
From covid_deaths as dea
Join  covid19.`covid-vacc`as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
group by 1
order by 2 desc 


