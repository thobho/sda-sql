CREATE TABLE czytelnik(
	id INT AUTO_INCREMENT PRIMARY KEY,
	imie VARCHAR(50),
    nazwisko VARCHAR(50),
    CONSTRAINT uc_person_imie UNIQUE(imie)
);


DESCRIBE czytelnik;

DROP TABLE czytelnik;

SELECT * FROM czytelnik;

INSERT INTO czytelnik(imie, nazwisko)
SELECT imie, nazwisko
FROM osoba
WHERE data_urodzenia > '2000-01-01';

CREATE TABLE ksiazka(
	ksiazka_id INT AUTO_INCREMENT PRIMARY KEY,
    tytul VARCHAR(50),
    czytelnik_id INT,
    CONSTRAINT ksiazka_fk FOREIGN KEY (czytelnik_id) REFERENCES czytelnik(id)
);

ALTER TABLE ksiazka
DROP FOREIGN KEY ksiazka_fk;




