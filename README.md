# Projekt

Pro projítí tabulek k projektu jsem zjistila, že v konkrétním případě tam je dvojí označení pro Českou republiku. Tudíž jsem si jako první krok upravila data v tabulce covid19_basic_differences, kde jsem si přepsala Czechia na Czech republic, která byla ve využívaných tabulkách zastoupena nejvíce. To jsem si uložila jako pohled.

Vytvořila jsem si první tabulku, která obsahuje data, země, počty nakažených a tu jsem spojila s tabulkou covid19_tests, kde jsem si vzala sloupeček o testování. Problém byl v tom, že tato tabulka obsahuje málo dat, proto je po spojení ve sloupci o testech více hodnot NULL.

Pro druhou tabulku, jsem si vzala všechny parametry z té první a přidala k tomu z tabulky countries medián v roce 2018, co byl požadován. Populace a hustota zalidnění v tabulce countries je z roku 2018, přitom máme novější data, ze kterých můžeme vycházet, tak to pak dopočítám z novějších dat. Rovněž jsem označila víkendy a sezonu. Sice existuje tabulka seasons, ale neobsahuje všechny záznamy ohledně ročního období, proto jsem to vypsala ručně.

Vytvoření tabulky HDP na hlavu, populace, GINI koeficient a dětské úmrtnosti od roku 2018 do roku 2020.

Vypočítaný podíl náboženství za rok 2020. A tabulka s rozložením hodnot do sloupců dle náboženství.

Vypočítaný rozdíl dožití v létech 1965 a 2015.

Tabulka úkol 1 obsahuje spojení tabulek z požadavků po konec druhého kroku. Hodnoty jako populace, hustota zalidnění jsou spočítané ve view info 2020, aby data byla co nejaktuálnější. Dále je v tabulce vybrán ve sloupci GINI koeficientu a dětské úmrtnosti vybrán rok 2019, protože rok 2020 má pouze data NULL.