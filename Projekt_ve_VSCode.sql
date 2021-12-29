-- Vytvořím si novou tabulku, abych si mohla přejmenovat nestejnorodé země. V tomto případě Českou republiku.
CREATE VIEW covid19_basic_differences_czech_republic AS 
SELECT * FROM covid19_basic_differences;

-- Sjednotím si název Česká republika.
UPDATE covid19_basic_differences_czech_republic SET country = 'Czech Republic' WHERE country = 'Czechia';

-- vytvoření tabulky s hodnody data, země, nakažených a testovaných.
CREATE TABLE tabulka_prvni_cast AS
SELECT
	cbdcz.date,
	cbdcz.country,
 	cbdcz.confirmed,
 	ct.tests_performed
FROM covid19_basic_differences_czech_republic AS cbdcz
LEFT JOIN covid19_tests ct ON cbdcz.country = ct.country AND cbdcz.date = ct.date
WHERE confirmed IS NOT NULL
ORDER BY date, country;

-- Vytvoření navazující tabulky s populací, víkendem, sezónou, hustotou zalidnění, průměrným věkem v roce 2018.
CREATE TABLE tabulka_druha_cast AS
SELECT 
	tpc.*,
	c.population,
	CASE WHEN WEEKDAY(tpc.date) IN (5, 6) THEN 1 ELSE 0 END AS weekend,
-- tabulka seasons nemá všechny záznamy ohledně ročního období.
-- s.seasons,
	CASE WHEN (date BETWEEN '2019-12-21' AND '2020-03-19') OR (date BETWEEN '2020-12-21' AND '2021-03-19') OR (date BETWEEN '2021-12-21' AND '2022-03-19') THEN 0
    WHEN (date BETWEEN '2019-03-20' AND '2019-06-20') OR (date BETWEEN '2020-03-20' AND '2020-06-20') OR (date BETWEEN '2021-03-20' AND '2021-06-20')  OR (date BETWEEN '2022-03-20' AND '2022-06-20') THEN 1
    WHEN (date BETWEEN '2019-06-21' AND '2019-09-22') OR (date BETWEEN '2020-06-21' AND '2020-09-22') OR (date BETWEEN '2021-06-21' AND '2021-09-22') OR (date BETWEEN '2022-06-21' AND '2022-09-22') THEN 2
    WHEN (date BETWEEN '2019-09-23' AND '2019-12-20') OR (date BETWEEN '2020-09-23' AND '2020-12-20') OR (date BETWEEN '2021-09-23' AND '2021-12-20') OR (date BETWEEN '2022-09-23' AND '2022-12-20')THEN 3 END AS season,
    c.population_density,
    c.median_age_2018 
FROM tabulka_prvni_cast AS tpc
LEFT JOIN countries AS c
ON tpc.country = c.country
ORDER BY date, country;

SELECT * FROM tabulka_druha_cast;

