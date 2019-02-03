
#Zapytania (z podzapytaniem)
#1. Wybranie wszystkich samochodów, których pojemność jest mniejsza od średniej pojemności wszystkich samochodów
#2. Wyświetla jaki procent z wszystkich samochodów ma model ustaiony na null

-- podzapytanie w where
SELECT *
FROM samochod
WHERE pojemnosc < (SELECT AVG(pojemnosc) FROM samochod);

-- Procent samochodów z zapisaną nazwą modelu

SELECT CAST(COUNT(model) AS DECIMAL) / (SELECT COUNT(*) FROM samochod) AS 'Procent niezarejetrowanych'
FROM samochod;


use kartoteka_policyjna;

SELECT *
FROM policjant p 
WHERE 2000 > (SELECT SUM(wartosc) FROM nagroda n WHERE n.policjant_id = p.policjant_id);

SELECT COUNT(*)
FROM policjant;











