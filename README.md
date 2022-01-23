# Projekt

Jako první problém bylo dvojí označení pro Českou republiku. Tudíž jsem si jako první krok upravila data v tabulce covid19_basic_differences, kde jsem si přepsala Czechia na Czech republic, která byla ve využívaných tabulkách zastoupena nejvíce. To jsem si uložila jako pohled.

Vytvořila jsem si první tabulku, která obsahuje data, země, počty nakažených a tu jsem spojila s tabulkou covid19_tests, kde jsem si vzala sloupeček o testování. Problém byl v tom, že tato tabulka obsahuje málo dat, proto je po spojení ve sloupci o testech více hodnot NULL.

Pro druhou tabulku, jsem si vzala všechny parametry z té první a přidala k tomu z tabulky countries medián v roce 2018. Populace a hustota zalidnění v tabulce countries je z roku 2018, přitom máme novější data, ze kterých můžeme vycházet, tak to pak dopočítám z novějších dat. Rovněž jsem označila víkendy a sezonu. Sice existuje tabulka seasons, ale neobsahuje všechny záznamy ohledně ročního období, proto jsem to vypsala ručně. 

Vytvořila jsem si tabulky s HDP na hlavu, populace, GINI koeficient a úmrtnost od roku 2018 do roku 2020, podíl náboženství za rok 2020. a rozdíl dožití v létech 1965 a 2015.

Tabulka úkol 1 obsahuje spojení tabulek s požadavky po konec druhého kroku. Hodnoty jako populace, hustota zalidnění jsou spočítané ve view info 2020, aby data byla co nejaktuálnější. Dále je v tabulce vybrán ve sloupci GINI koeficientu a úmrtnost rok 2019, protože rok 2020 má pouze data NULL.

View průměrná hodnota obsahuje průměrnou teplotu od 9 hodin do 18 hodin. Chtěli jsme jen denní teplotu. View nenulové srážky pak spočítáme řádky, ve kterých jsou nenulové srážky. Tu hodnotu jsem v následující tabulce tabulka_pocasi vynásobila 3, protože jsou data uvedena v tříhodinovém intervalu a spočítané řádky nám neuvádí počet hodin, ale v konečné tabulce jsem nechala oba záznamy. Maximální síla větru je rovněž uvedena maximální hodnota během dne ne noci. V tabulce počasí jsou data od roku 2016, tak jsme si potřebovali vybrat jen od 1. ledna 2020 a výš, aby nám seděla s daty, kdy se začal šířit virus. A ne všechna města zaznamenávala své hodnoty, proto tabulka obsahuje hodně hodnot NULL.

V konečné tabulce jsem tedy vybrala ta nejnovější data. Pokud za nejnovější rok v tabulce byly pouze hodnoty NULL (tudíž z toho roku nebyla žádná data), vybrala jsem rok předním, kdy prázdných hodnot bylo méně a alespoň nějaká data se nasbírala. 