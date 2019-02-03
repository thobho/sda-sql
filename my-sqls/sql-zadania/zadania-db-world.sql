SELECT * FROM country;
SELECT AVG(gnp) FROM country; --  dochód narofdowy

# Wyświetl:
#1. kontynety z ich populacją posortowaną malejąco
#2. Liczbę wszystkich krajów w Afryce
#3. Liczbę krajów w Afryce, w których średnia długość życia jest większa od 60.
#4. Reginy i ich zsumowane GNP.
#5. Średni produkt krajowy brutto w zależności od typu rządu sortowane malejąco, pod warunkiem, że śrenia nie jest równa 0.
#6. Liczbę osób na kilometr kwadratowy w każdym krau wraz z jego nazwą sortowane malejąco
#7  Śrenią z dochodu narodowego wszystkich krajów
#8. Średni oczekiwany wiek mieszkańców dla krajów, których GNP (dochód narodowy) jest większy niż średnia.
#9. Średni oczekiwany wiek mieszkańców dla krajów, których GNP (dochód narodowy) jest mniejszy niż średnia. (jaka jest różnica w porównaniud do #8?

# Dalsze ćwiczenia z wykorzystaniem joinów
#10 Pobierz liczbę miast w USA
#11. 10 największych miast w Polsce, wraz z ich populacjami
#12. Wybierz 25 miast z całego świata, którego nazwa zaczyna się na literę 'F' i państwo, gdzi się znajduje.
#13. Który z krajów zawiera najwięcej miast na literę H?
#14. Wyświetl ile ludzi mówi w każdym z języków świata. 
#15. Jakiem językiem mówi najwięcej ludzi na świecie, ilu ludzi? Wyświetl jeden rekord.
#16. W jakim kraju (poza Polską) mówi się w języku polskim?
#17. Jaki oficjalny język jest w najrzadziej urzywany w swoim kraju? Jakie to kraje?
#18. Wyświetl ilu ludzi w każdym kraju Europy mówi swoim urzędowym językiem (populacja x odsetek mówiących)

SELECT continent, sum(population) as populacja
FROM country
GROUP BY continent
ORDER BY populacja DESC;

SELECT count(*)
FROM country
WHERE continent = 'Africa';

SELECT count(*)
FROM country
WHERE lifeexpectancy > 60 AND continent = 'Africa';

SELECT region, sum(gnp) as pkb
FROM country
GROUP BY region
ORDER BY pkb DESC;

SELECT governmentform, AVG(gnp) as agvpkb
FROM country
GROUP BY governmentform
HAVING agvpkb <> 0
ORDER BY agvpkb DESC;

SELECT name, population / surfaceArea AS zaludnienie
FROM country
WHERE population > 0
ORDER BY zaludnienie DESC;

SELECT AVG(lifeExpectancy) 
FROM country
WHERE gnp > 120000;

SELECT co.name, ci.*
FROM country co JOIN city ci ON co.code = ci.countrycode
WHERE co.name = 'Poland';

SELECT co.name, ci.name
FROM country co JOIN city ci ON co.code = ci.countrycode
WHERE ci.name LIKE 'F%';

SELECT co.name, count(*)
FROM country co JOIN city ci ON co.code = ci.countrycode
WHERE ci.name LIKE 'H%'
GROUP BY co.name
ORDER BY count(*) DESC;

SELECT * FROM countrylanguage;

SELECT cl.language, SUM(co.population) AS s
FROM country co JOIN countrylanguage cl ON co.code = cl.countrycode
GROUP BY cl.language
ORDER BY s DESC
LIMIT 1;

SELECT * FROM countrylanguage
WHERE language = 'Polish' AND countrycode <> 'POL'
ORDER BY percentage DESC
LIMIT 1;

SELECT * FROM countrylanguage
WHERE isofficial = 'T' AND percentage <> 0
ORDER BY percentage;

SELECT co.name, co.population, cl.language, cl.percentage, cl.percentage * co.population / 100
FROM countrylanguage cl JOIN country co ON cl.countrycode = co.code
WHERE co.continent = 'Europe' AND cl.isofficial = 'T';




