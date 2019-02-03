-- FUNKCJE
#1. Napisz zapytanie SQL, które dla każedej osoby zwróci email osoby. Np. Dla Jan Kowalski - jan.kowalski@gmail.com. (Wszystkie litery z małych liter)
#2. Napsz zapytanie, które zwróci inicjały osób.
#3. Napisz zapytanie, wyświetli opisy zdarzeń. W tych opisach jednak, słowo 'samochód' powinno być zastąpione słowem 'pojazd'.
#4. Dodaj do tabeli osoba, kogoś, kto ma na imię Anna. Wybierz z tabeli osoba wszystkie te, których imie jest palindromem.
#5. Dla każdego samochodu wyświetl ile cm3 pojemności silnika przypada na jedną zarejestrowaną osobę.
#6. Wyświetl tylko te samochody, których pojemność zaokrągla się w górę i nie zawiera znaczących cyfr po przecinku. Np. 100,6 - będzie wyświetlone, 100,4 - nie będzie, 100,00 - nie będzie
#7. Wyświetl pojemność samochodu w zaokrągleniu do jednego miejsca po przecinku.
#8. Dla każdej osoby wyświetl jej imie i nazwisko, oraz numer dnia w którym była urodzona.
#9. Dla każdej osoby wyświetl ile dni upłynęło od chwili jej narodzin.
#10. Za tabeli samochód wyświetl 3 kolumny, markę, model i w trzeciej napis 'Duży', jeżli samochod jest zarejestrowany na więcej niż 4 osob lub napis 'Mały' w przeciwnym wypadku.
#11. Wyświetl wszystkie marki i modele samochodów i ich opisy wg. reguł:
#	-> Jeżeli pojemość silnika jest większa od 2000: "Silny"
#	-> Jeśeli pojemność silnika pomiędzy 1000 a 2000: "Średni"
#	-> Jeżeli liczba osób jest mniesza niż 1000 to "Słaby"
#12. Wyświetl informacje o zalogowanym użytkowniku, połączeniu, bazie danych i wersji serwera MySQL.
#11. Jaki procent samochodóœ jest zarejestrowany na więcej niż 3 osoby? (count z wherem)


-- ROZWIĄZANIA =============================================

-- 1
SELECT CONCAT(LOWER(imie), '.', LOWER(nazwisko), '@gmail.com')
FROM osoba;

SELECT LOWER(CONCAT(imie, '.',nazwisko, '@gmail.com'))
FROM osoba;

-- 2
SELECT CONCAT(LEFT(imie,1),'.' ,LEFT(nazwisko,1))
FROM osoba;

-- 3
SELECT REPLACE(opis, 'Stłuczka', 'Wypaaadek')
FROM zdarzenie;

-- 4
SELECT * 
FROM osoba
WHERE imie = REVERSE(imie);

SELECT liczba_osob + 1 
FROM samochod;

-- 5
SELECT pojemnosc / liczba_osob
FROM samochod;

SELECT *
FROM samochod
WHERE ROUND(pojemnosc) = CEILING(pojemnosc) AND pojemnosc - ROUND(pojemnosc) <> 0;

-- 6
SELECT FORMAT(pojemnosc,1)
FROM samochod;

-- 7 
SELECT imie, nazwisko, DAYNAME(data_urodzenia)
FROM osoba;


-- 9
SELECT ABS(DATEDIFF(data_urodzenia, NOW()))
FROM osoba;

-- 10 
SELECT model, marka, IF(liczba_osob > 4, 'DUZY', 'MAŁY')
FROM samochod;

-- 11 

SELECT marka, model, pojemnosc,
	CASE
		WHEN pojemnosc <1000 THEN "SŁABY"
        WHEN pojemnosc BETWEEN 1000 AND 2000 THEN "ŚREDNI"
        WHEN pojemnosc >2000 THEN "MOCNY"
    END   AS opis 
FROM samochod;

SELECT USER(), VERSION(), CONNECTION_ID(), DATABASE();



-- JOINS



-- 1
CREATE VIEW stopnie_policjantow AS
SELECT policjant.nazwisko, stopien.stopien
FROM policjant JOIN stopien ON policjant.stopien_id = stopien.stopien_id;

SELECT * FROM stopnie_policjantow;


-- 2
SELECT policjant.nazwisko, IFNULL(stopien.stopien, "pracownik cywilny")
FROM policjant LEFT JOIN stopien ON policjant.stopien_id = stopien.stopien_id;


-- 3
SELECT p.nazwisko, n.wartosc
FROM policjant p JOIN nagroda n ON p.policjant_id = n.policjant_id;


SELECT marka, AVG(pojemnosc)
FROM samochod
GROUP BY marka;


-- 4
SELECT policjant_id, count(*) AS suma
FROM nagroda
GROUP BY policjant_id
HAVING suma > 1;

SELECT *
FROM policjant;

SELECT COUNT(*)
FROM policjant;


-- 5
SELECT p.nazwisko, count(*)
FROM nagroda n JOIN policjant p ON n.policjant_id = p.policjant_id
GROUP BY p.nazwisko
HAVING count(*) > 1;

SELECT p.nazwisko, COUNT(*) AS suma
FROM nagroda n JOIN policjant p ON n.policjant_id = p.policjant_id
GROUP BY p.nazwisko
HAVING suma > 1;



SELECT *
FROM policjant p LEFT JOIN zdarzenie z ON p.policjant_id = z.policjant_id
WHERE z.data_zdarzenia > '2018-01-01';


-- 6
SELECT p.nazwisko, z.data_zdarzenia
FROM policjant p LEFT JOIN zdarzenie z ON p.policjant_id = z.policjant_id
WHERE p.nazwisko = 'Mikołajuk';


-- 7
SELECT z.data_zdarzenia, o.imie, o.nazwisko
FROM 
	(policjant p LEFT JOIN zdarzenie z ON p.policjant_id = z.policjant_id) 
				JOIN osoba o ON z.osoba_id = o.osoba_id
WHERE p.nazwisko = 'Mikołajuk';


-- 7
SELECT p.nazwisko, o.nazwisko
FROM 
	(policjant p LEFT JOIN zdarzenie z ON p.policjant_id = z.policjant_id) 
				JOIN osoba o ON z.osoba_id = o.osoba_id
WHERE p.nazwisko = "Mikołajuk";



-- 8 
EXPLAIN
SELECT o.imie, o.nazwisko, s.marka, s.model
FROM samochody_osob so JOIN osoba o ON so.osoba_id = o.osoba_id JOIN samochod s ON so.samochod_id = s.samochod_id;

-- 9
SELECT s.samochod_id, COUNT(*)
FROM samochody_osob so JOIN samochod s ON so.samochod_id = s.samochod_id
GROUP BY so.samochod_id;




CREATE INDEX osoba_index ON osoba(nazwisko);

EXPLAIN
SELECT * 
FROM osoba;

CREATE TABLE poszkodowany(
		id INT PRIMARY KEY,
        nazwisko VARCHAR(50)
);

INSERT INTO poszkodowany(nazwisko, id)
SELECT nazwisko, osoba_id
FROM osoba;

TRUNCATE poszkodowany;





















