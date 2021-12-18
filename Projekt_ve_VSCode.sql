SELECT 
	cbd.date,
 	country,
    CASE WHEN WEEKDAY(cbd.date) IN (5, 6) THEN 1 ELSE 0 END AS weekend, 
-- tabulka seasons nemá všechny záznamy ohledně ročního období. Proto jsem si to vypsala ručně.
--	s.seasons,
    CASE WHEN (date BETWEEN '2019-12-21' AND '2020-03-19') OR (date BETWEEN '2020-12-21' AND '2021-03-19') OR (date BETWEEN '2021-12-21' AND '2022-03-19') THEN 0
    WHEN (date BETWEEN '2019-03-20' AND '2019-06-20') OR (date BETWEEN '2020-03-20' AND '2020-06-20') OR (date BETWEEN '2021-03-20' AND '2021-06-20')  OR (date BETWEEN '2022-03-20' AND '2022-06-20') THEN 1
    WHEN (date BETWEEN '2019-06-21' AND '2019-09-22') OR (date BETWEEN '2020-06-21' AND '2020-09-22') OR (date BETWEEN '2021-06-21' AND '2021-09-22') OR (date BETWEEN '2022-06-21' AND '2022-09-22') THEN 2
    WHEN (date BETWEEN '2019-09-23' AND '2019-12-20') OR (date BETWEEN '2020-09-23' AND '2020-12-20') OR (date BETWEEN '2021-09-23' AND '2021-12-20') OR (date BETWEEN '2022-09-23' AND '2022-12-20')THEN 3 END AS season,
    confirmed 
FROM covid19_basic_differences AS cbd 
-- JOIN seasons AS s
-- ON cbd.date = s.date
WHERE confirmed IS NOT NULL 
ORDER BY date;


