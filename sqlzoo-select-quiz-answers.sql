-- SQLZoo SELECT Quiz Answers
-- Source: https://www.sqlzoo.net/wiki/SELECT_Quiz
-- Reference table: world (name, region, area, population, gdp)

-- ============================================================
-- Q1. Select the code which produces this table:
--     name        | population
--     Bahrain     | 1234571
--     Swaziland   | 1220000
--     Timor-Leste | 1066409
-- ============================================================
-- ANSWER:
SELECT name, population
FROM world
WHERE population BETWEEN 1000000 AND 1250000;

-- ============================================================
-- Q2. Pick the result you would obtain from this code:
--     SELECT name, population FROM world WHERE name LIKE "Al%"
-- ANSWER: Table-E => Albania 3200000 / Algeria 32900000
-- ============================================================
SELECT name, population
FROM world
WHERE name LIKE 'Al%';
-- Result: Albania 3200000, Algeria 32900000

-- ============================================================
-- Q3. Select the code which shows the countries that end in A or L
-- ============================================================
-- ANSWER:
SELECT name
FROM world
WHERE name LIKE '%a' OR name LIKE '%l';

-- ============================================================
-- Q4. Pick the result from the query:
--     SELECT name, length(name) FROM world
--     WHERE length(name)=5 and region='Europe'
-- ANSWER: Italy 5, Malta 5, Spain 5
-- ============================================================
SELECT name, length(name)
FROM world
WHERE length(name) = 5 AND region = 'Europe';
-- Result: Italy 5, Malta 5, Spain 5

-- ============================================================
-- Q5. Pick the result from: SELECT name, area*2 FROM world
--     WHERE population = 64000
-- ANSWER: Andorra 936  (area=468, 468*2=936)
-- ============================================================
SELECT name, area*2
FROM world
WHERE population = 64000;
-- Result: Andorra 936

-- ============================================================
-- Q6. Select the code that shows countries with area > 50000
--     and population < 10000000
-- ============================================================
-- ANSWER:
SELECT name, area, population
FROM world
WHERE area > 50000 AND population < 10000000;

-- ============================================================
-- Q7. Select the code that shows the population density of
--     China, Australia, Nigeria and France
--     (population density = population / area)
-- ============================================================
-- ANSWER:
SELECT name, population/area
FROM world
WHERE name IN ('China', 'Nigeria', 'France', 'Australia');
