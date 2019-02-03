CREATE OR REPLACE VIEW nagrody_policjantow AS
SELECT nazwisko, wartosc
FROM policjant p JOIN nagroda n ON p.policjant_id = n.policjant_id;

SELECT * FROM nagrody_policjantow;
DROP VIEW nagrody_policjantow;

CREATE VIEW milenialsi
AS SELECT * FROM osoba WHERE data_urodzenia > '2000-01-01';

INSERT INTO milenialsi VALUES
(10 , '2000-02-02', 'Jacek', 'Kaczmarski', NULL);

SELECT *
FROM milenialsi;

SELECT * 
FROM osoba
WHERE imie = 'Jacek';
SELECT *
FROM milenialsi;
