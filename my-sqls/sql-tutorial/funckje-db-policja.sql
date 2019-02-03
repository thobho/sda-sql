
-- długość stringa
SELECT CHAR_LENGTH(opis)
FROM zdarzenie;

-- kod ascii znaku
SELECT ASCII('a');

-- konkatenacja
SELECT CONCAT(imie, ' ' ,nazwisko) AS 'imie i naziwsko'
FROM osoba;

-- konkatenacja z separatorem
SELECT CONCAT_WS(',', imie,nazwisko) AS 'imie i naziwsko'
FROM osoba;

-- formatuje liczbę do postaci "#,###,###.##" 
SELECT FORMAT(pojemnosc, 5) as pojemnosc
FROM samochod;

-- podmienia znaki w stringu
SELECT INSERT(imie, 1, 3, "***")
FROM osoba;

-- do małych/dużych liter
SELECT UCASE(imie), LCASE(nazwisko)
FROM osoba;

-- do małych/dużych liter
SELECT REVERSE(imie), REVERSE(nazwisko)
FROM osoba;

-- funkcje numeryczne
SELECT CEILING(pojemnosc)
FROM samochod;

SELECT ROUND(pojemnosc)
FROM samochod;



