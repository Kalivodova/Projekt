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
	CASE WHEN WEEKDAY(tpc.date) IN (5, 6) THEN 1 ELSE 0 END AS weekend,
	CASE WHEN (date BETWEEN '2019-12-21' AND '2020-03-19') OR (date BETWEEN '2020-12-21' AND '2021-03-19') OR (date BETWEEN '2021-12-21' AND '2022-03-19') THEN 0
    WHEN (date BETWEEN '2019-03-20' AND '2019-06-20') OR (date BETWEEN '2020-03-20' AND '2020-06-20') OR (date BETWEEN '2021-03-20' AND '2021-06-20')  OR (date BETWEEN '2022-03-20' AND '2022-06-20') THEN 1
    WHEN (date BETWEEN '2019-06-21' AND '2019-09-22') OR (date BETWEEN '2020-06-21' AND '2020-09-22') OR (date BETWEEN '2021-06-21' AND '2021-09-22') OR (date BETWEEN '2022-06-21' AND '2022-09-22') THEN 2
    WHEN (date BETWEEN '2019-09-23' AND '2019-12-20') OR (date BETWEEN '2020-09-23' AND '2020-12-20') OR (date BETWEEN '2021-09-23' AND '2021-12-20') OR (date BETWEEN '2022-09-23' AND '2022-12-20')THEN 3 END AS season,
    c.median_age_2018 
FROM tabulka_prvni_cast AS tpc
LEFT JOIN countries AS c
ON tpc.country = c.country
ORDER BY date, country;

-- HDP na hlavu a populace 2018, 2019 a 2020, gini a dětská úmrtnost 2018 a 2019 (roky 2020 nejsou uvedena žádná data).
CREATE TABLE tabulka_HDP_popu_gini_morta AS 
SELECT 
	country,
	(SELECT round(GDP / population, 2) FROM economies e2 WHERE year = '2018' AND e.country = e2.country) AS HDP_na_hlavu_2018,
	round(GDP / population, 2) AS HDP_na_hlavu_2019,
	(SELECT round(GDP / population, 2) FROM economies e2 WHERE year = '2020' AND e.country = e2.country) AS HDP_na_hlavu_2020,
	(SELECT population FROM economies e2 WHERE year = '2018' AND e.country = e2.country) AS population_2018,
	population AS population_2019,
	(SELECT population FROM economies e2 WHERE year = '2020' AND e.country = e2.country) AS population_2020,
	(SELECT gini FROM economies e2 WHERE year = '2018' AND e.country = e2.country) AS gini_2018,
	gini AS gini_2019,
	(SELECT gini FROM economies e2 WHERE year = '2020' AND e.country = e2.country) AS gini_2020,
	(SELECT round(mortaliy_under5, 3) FROM economies e2 WHERE year = '2018' AND e.country = e2.country) AS children_mortality_2018,
	mortaliy_under5 AS children_mortality_2019,
	(SELECT mortaliy_under5 FROM economies e2 WHERE year = '2020' AND e.country = e2.country) AS children_mortality_2020
FROM economies e
WHERE year = '2019';

-- podíl náboženství
CREATE TABLE tabulka_podil_nabozenstvi AS
SELECT
	r.year,
	r.country,
	r.religion,
 	-- (select sum(re.population) FROM religions re WHERE re.year = '2020' and r.country = re.country group by re.country) AS pocet,
 	round(r.population / (SELECT sum(re.population) FROM religions re WHERE re.year = '2020' AND r.country = re.country GROUP BY re.country) * 100, 2) AS procenta
FROM religions AS r
WHERE r.year = '2020';

CREATE TABLE tabulka_nabozenstvi AS
SELECT
	pn.country,
	(SELECT procenta FROM tabulka_podil_nabozenstvi AS pn2 WHERE religion = 'Christianity' AND pn.country = pn2.country) AS Christianity,
	(SELECT procenta FROM tabulka_podil_nabozenstvi AS pn2 WHERE religion = 'Islam' AND pn.country = pn2.country) AS Islam,
	(SELECT procenta FROM tabulka_podil_nabozenstvi AS pn2 WHERE religion = 'Unaffiliated Religions' AND pn.country = pn2.country) AS Unaffiliated_Religions,
	(SELECT procenta FROM tabulka_podil_nabozenstvi AS pn2 WHERE religion = 'Hinduism' AND pn.country = pn2.country) AS Hinduism,
	(SELECT procenta FROM tabulka_podil_nabozenstvi AS pn2 WHERE religion = 'Buddhism' AND pn.country = pn2.country) AS Buddhism,
	(SELECT procenta FROM tabulka_podil_nabozenstvi AS pn2 WHERE religion = 'Folk Religions' AND pn.country = pn2.country) AS Folk_Religions,
	(SELECT procenta FROM tabulka_podil_nabozenstvi AS pn2 WHERE religion = 'Other Religions' AND pn.country = pn2.country) AS Other_Religions,
	(SELECT procenta FROM tabulka_podil_nabozenstvi AS pn2 WHERE religion = 'Judaism' AND pn.country = pn2.country) AS Judaism
FROM tabulka_podil_nabozenstvi AS pn
GROUP BY country;

-- rozdíl doby dožití
CREATE TABLE tabulka_le_rozdil AS 
SELECT a.country, a.life_exp_1965 , b.life_exp_2015,
    round( b.life_exp_2015 - a.life_exp_1965, 2 ) AS life_exp_diff
FROM (
    SELECT le.country , le.life_expectancy AS life_exp_1965
    FROM life_expectancy le 
    WHERE year = 1965
    ) a JOIN (
    SELECT le.country , le.life_expectancy AS life_exp_2015
    FROM life_expectancy le 
    WHERE year = 2015
    ) b
    ON a.country = b.country;

CREATE VIEW info_2020 AS
SELECT 
	hpgm.country,	
	hpgm.population_2020,
	c.surface_area,
	round(hpgm.population_2020/c.surface_area, 3) AS population_density_2020
FROM tabulka_hdp_popu_gini_morta AS hpgm
LEFT JOIN countries AS c
ON hpgm.country = c.country;

CREATE TABLE tabulka_ukol_1 AS
SELECT 
	tdc.date,
	tdc.country,
	tdc.confirmed,
	tdc.tests_performed,
	hpgm.population_2020,
	tdc.weekend,
	tdc.season,
	i.population_density_2020,
	hpgm.HDP_na_hlavu_2020,
	hpgm.gini_2019,
	hpgm.children_mortality_2019,
	tdc.median_age_2018,
	tn.Christianity,
	tn.Islam,
	tn.Unaffiliated_Religions,
	tn.Hinduism,
	tn.Buddhism,
	tn.Folk_Religions,
	tn.Other_Religions,
	tn.Judaism,
	tlr.life_exp_diff AS life_exp_diff_2015_and_1965
FROM tabulka_druha_cast AS tdc
LEFT JOIN tabulka_hdp_popu_gini_morta AS hpgm
ON tdc.country = hpgm.country
LEFT JOIN info_2020 AS i
ON tdc.country = i.country
LEFT JOIN tabulka_nabozenstvi AS tn
ON tdc.country = tn.country
LEFT JOIN tabulka_le_rozdil AS tlr
ON tdc.country = tlr.country
ORDER BY date, country;

