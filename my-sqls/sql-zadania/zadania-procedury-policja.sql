#Napisz procedurę która

#1 Tworzy nową tabelę "małe samochody" i kopiuje do niej dane o samochodach, których pojemność jest mniejsza niż 1000 cm
#2 Zwraca liczbę osób starzych niż data podana w parametrze.
#3 Kasuje nagrody wszystkich policjantów. (ustawia klucz obcy na null)
#4 Napisz funkcję, która określa kategorię samochodu na podstaiw jego pojemności -> "Mocny", "średni", "słaby"
#5 Napisz trigger, który po wstawieniu samochodu do tabeli zapisuje w osobnej tabeli jego kategorię.

#zadanie 1

CALL kopiuj_male_samochody();
DROP PROCEDURE kopiuj_male_samochody;
SELECT * FROM male_samochody;

DELIMITER $$

CREATE PROCEDURE `kopiuj_male_samochody` ()
BEGIN
CREATE TABLE IF NOT EXISTS male_samochody(
	id INT PRIMARY KEY,
    pojemnosc DECIMAL(6,2)
);

INSERT INTO male_samochody 
SELECT samochod_id, pojemnosc FROM samochod WHERE pojemnosc < 2000;

END$$

DELIMITER ;

#zadanie 2

DELIMITER $$

CREATE PROCEDURE starsi_niz (IN data_odciecia DATE, OUT liczba INT)
BEGIN

SELECT COUNT(*) INTO liczba
FROM osoba
WHERE data_urodzenia > data_odciecia;

END$$

DELIMITER ;

CALL starsi_niz('1900-01-01', @liczba);

SELECT @liczba;

#zadanie 3

DELIMITER $$

DROP PROCEDURE kasuj_nagrody$$ 
CREATE PROCEDURE kasuj_nagrody ()
BEGIN

UPDATE nagroda
SET policjant_id = NULL;

END$$

DELIMITER ;

CALL kasuj_nagrody();

#Funkcja


DROP FUNCTION moc_samochodu;
DELIMITER $$
 
CREATE FUNCTION moc_samochodu(pojemnosc DOUBLE) RETURNS VARCHAR(10)
    DETERMINISTIC
BEGIN
    DECLARE label varchar(10);
 
    IF pojemnosc > 2000 THEN
 SET label = 'PLATINUM';
    ELSEIF (pojemnosc <= 2000 AND pojemnosc >= 1000) THEN
        SET label = 'GOLD';
    ELSEIF pojemnosc < 1000 THEN
        SET label = 'SILVER';
    END IF;
 
 RETURN (label);
END$$
DELIMITER ;

SELECT moc_samochodu(pojemnosc)
FROM samochod;


-- 5

DROP TRIGGER delete_oldest_before_insert;

DELIMITER $$

CREATE TRIGGER dodaj_do_samochody_osob
	AFTER INSERT ON osoba
    FOR EACH ROW
BEGIN
	INSERT INTO samochody_osob(osoba_id) VALUES
    (NEW.osoba_id);
END$$    

DELIMITER ;


SELECT * FROM osoba ORDER BY data_urodzenia;

INSERT INTO osoba(osoba_id, data_urodzenia, nazwisko) VALUES
(100, '2010-01-01', "Nowiutki");

SELECT * FROM samochody_osob;



