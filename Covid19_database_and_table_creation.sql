USE covid19 
-- create and load covid_deaths table :
CREATE TABLE covid_deaths (
    iso_code VARCHAR(3),
    continent VARCHAR(20),
    location VARCHAR(50),
    date DATE,
    total_cases INT,
    new_cases INT,
    new_cases_smoothed FLOAT,
    total_deaths INT,
    new_deaths INT,
    new_deaths_smoothed FLOAT,
    total_cases_per_million FLOAT,
    new_cases_per_million FLOAT,
    new_cases_smoothed_per_million FLOAT,
    total_deaths_per_million FLOAT,
    new_deaths_per_million FLOAT,
    new_deaths_smoothed_per_million FLOAT,
    reproduction_rate FLOAT,
    icu_patients INT,
    icu_patients_per_million FLOAT,
    hosp_patients INT,
    hosp_patients_per_million FLOAT,
    weekly_icu_admissions INT,
    weekly_icu_admissions_per_million FLOAT,
    weekly_hosp_admissions INT,
    weekly_hosp_admissions_per_million FLOAT,
    new_tests INT,
    total_tests INT,
    total_tests_per_thousand FLOAT,
    new_tests_per_thousand FLOAT,
    new_tests_smoothed FLOAT,
    new_tests_smoothed_per_thousand FLOAT,
    positive_rate FLOAT,
    tests_per_case FLOAT,
    tests_units VARCHAR(20),
    total_vaccinations INT,
    people_vaccinated INT,
    people_fully_vaccinated INT,
    new_vaccinations INT,
    new_vaccinations_smoothed FLOAT,
    total_vaccinations_per_hundred FLOAT,
    people_vaccinated_per_hundred FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    new_vaccinations_smoothed_per_million FLOAT,
    stringency_index FLOAT,
    population INT,
    population_density FLOAT,
    median_age FLOAT,
    aged_65_older FLOAT,
    aged_70_older FLOAT,
    gdp_per_capita FLOAT,
    extreme_poverty FLOAT,
    cardiovasc_death_rate FLOAT,
    diabetes_prevalence FLOAT,
    female_smokers FLOAT,
    male_smokers FLOAT,
    handwashing_facilities FLOAT,
    hospital_beds_per_thousand FLOAT,
    life_expectancy FLOAT,
    human_development_index FLOAT
);

load data local infile 'C:/Users/Nassim/Desktop/Data_ Analytics_Certificate/Excel_SQL_for_Data_Analytics/SQL_project/SQL_Youtube_project/COVID19_project/CovidDeaths.csv'
into table  covid_deaths
fields terminated by ',' 
ignore 1 rows ; 

-- create and load covid_vaccinations table :
CREATE TABLE covid_vaccinations (
  iso_code VARCHAR(3),
  continent VARCHAR(20),
  location VARCHAR(30),
  date DATE,
  new_tests INT,
  total_tests INT,
  total_tests_per_thousand FLOAT,
  new_tests_per_thousand FLOAT,
  new_tests_smoothed FLOAT,
  new_tests_smoothed_per_thousand FLOAT,
  positive_rate FLOAT,
  tests_per_case FLOAT,
  tests_units VARCHAR(20),
  total_vaccinations INT,
  people_vaccinated INT,
  people_fully_vaccinated INT,
  new_vaccinations INT,
  new_vaccinations_smoothed FLOAT,
  total_vaccinations_per_hundred FLOAT,
  people_vaccinated_per_hundred FLOAT,
  people_fully_vaccinated_per_hundred FLOAT,
  new_vaccinations_smoothed_per_million FLOAT,
  stringency_index FLOAT,
  population_density FLOAT,
  median_age FLOAT,
  aged_65_older FLOAT,
  aged_70_older FLOAT,
  gdp_per_capita FLOAT,
  extreme_poverty FLOAT,
  cardiovasc_death_rate FLOAT,
  diabetes_prevalence FLOAT,
  female_smokers FLOAT,
  male_smokers FLOAT,
  handwashing_facilities FLOAT,
  hospital_beds_per_thousand FLOAT,
  life_expectancy FLOAT,
  human_development_index FLOAT
);
load data local infile 'C:/Users/Nassim/Desktop/Data_ Analytics_Certificate/Excel_SQL_for_Data_Analytics/SQL_project/SQL_Youtube_project/COVID19_project/CovidVaccinations.csv'
into table  covid_vaccinations
fields terminated by ',' 
ignore 1 rows ; 


