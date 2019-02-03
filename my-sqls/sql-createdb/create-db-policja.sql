DROP DATABASE kartoteka_policyjna;
CREATE DATABASE kartoteka_policyjna;
USE kartoteka_policyjna;

DROP TABLE osoba;
DROP TABLE nagroda;
DROP TABLE policjant;
DROP TABLE samochod;
DROP TABLE sampchody_osob;
DROP TABLE stopien;
DROP TABLE zdarzenie;

CREATE TABLE osoba(
	osoba_id INT,
    data_urodzenia DATE NOT NULL,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50),
    opiekun_id INT,
    PRIMARY KEY(osoba_id),
    FOREIGN KEY (opiekun_id) REFERENCES osoba(osoba_id)
);

INSERT INTO osoba
VALUES
(1, '1998-01-01', 'Michał','Einstein', NULL),
(2, '1999-01-01', 'Andrzej','Oppenheimer', NULL),
(3, '2000-01-01', 'Michał','Mann', NULL),
(4, '2001-01-01', 'Kondrad','Dostojewski', 1),
(5, '2002-01-01', 'Jacek','Tołstoj', NULL),
(6, '2005-01-01', 'Mirek','Słowacki', NULL),
(7, '2010-01-01', 'Damian','Mickiewicz', NULL),
(8, '2011-01-01', 'Bogdan','Sienkiewcz', 1);

CREATE TABLE samochod(
	samochod_id INT PRIMARY KEY,
    marka VARCHAR(50) NOT NULL,
    model VARCHAR(50),
    data_produkcji DATE NOT NULL,
    liczba_osob INT,
    pojemnosc DECIMAL (6,2)
);

INSERT INTO samochod
VALUES
(1, 'Skoda', 'Felicja', '1999-01-01', 4, 600),
(2, 'BMW', null, '2010-01-01', 4, 1000.33),
(3, 'Mazda', '3', '2016-01-01', 5, 1500.55),
(4, 'Skoda', 'Octavie', '1999-01-01', 2, 600),
(5, 'BMW', '1', '2010-01-01', 2, 2000.33),
(6, 'Mazda', '3', '2014-01-01', 4, 3000.55),
(7, 'Skoda', 'Felicja', '2010-01-01', 4, 600),
(8, 'Opel', null, '2008-01-01', 4, 1000.33),
(9, 'Ford', 'Focus', '2007-01-01', 5, 1500.55),
(10, 'Fiat', '500', '2009-01-01', 2, 600),
(11, 'BMW', '2', '2010-01-01', 2, 1200.33),
(12, 'Mazda', '6', '2016-01-01', 4, 1500.55);


SELECT * FROM samochod;

CREATE TABLE samochody_osob(
	id INT AUTO_INCREMENT PRIMARY KEY,
    osoba_id INT,
    samochod_id INT,
    data_rejestracji DATE NOT NULL,
    FOREIGN KEY (osoba_id) REFERENCES osoba(osoba_id),
    FOREIGN KEY (samochod_id) REFERENCES samochod(samochod_id)
);

INSERT INTO samochody_osob(osoba_id, samochod_id, data_rejestracji)
VALUES
(1, 1, '1999-01-01'),
(1, 2, '2010-01-01'),
(2, 3, '2016-01-01'),
(2, 4, '1999-01-01'),
(3, 4, '2010-01-01'),
(5, 6, '2016-01-01'),
(6, 7, '1999-01-01'),
(7, 8, '2010-01-01'),
(7, 10, '2016-01-01');


CREATE TABLE stopien(
	stopien_id INT AUTO_INCREMENT PRIMARY KEY,
    stopien VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO stopien(stopien) VALUES
('inspektor'),
('podinspektor'), 
('nadkomisarz'), 
('komisarz'), 
('aspirant'), 
('sierżant'),
('starszy posternukowy'),
('postreunkowy');

CREATE TABLE policjant(
	policjant_id INT PRIMARY KEY,
    nazwisko VARCHAR(50),
    pensja DECIMAL(7,2),
    stopien_id INT,
    FOREIGN KEY (stopien_id) REFERENCES stopien(stopien_id )
);

INSERT INTO policjant VALUES
(1, "Kowaliski", 3000, 8),
(2, "Malinowski", 3000, 8),
(3, "Lisowki", 3000, 7),
(4, "Brzozowski", 4000, 7),
(5, "Mikołajuk", 4000, 8),
(6, "Boczek", 6000, 4),
(7, "Testowy", 7000, 3),
(8, "Klawiszowy", 8000, 1),
(9, "Młody", 500, NULL);


CREATE TABLE nagroda(
	nagroda_id INT AUTO_INCREMENT PRIMARY KEY,
    opis VARCHAR(50),
    wartosc DECIMAL(7,2),
    policjant_id INT,
    FOREIGN KEY (policjant_id) REFERENCES policjant(policjant_id)
);

TRUNCATE nagroda;
INSERT INTO nagroda(opis, wartosc, policjant_id) VALUES
("Za marzec", 1000, 1),
("Za łapanie złodzieji", 2000, 2),
("Za odmówienie łapówki", 1000, 3),
("Za dużo mandatów", 3000, 2),
("Za mało mandatów", 2000, 1),
("Za nic", 1000, 6);

INSERT INTO nagroda(opis, wartosc, policjant_id) VALUES
("Nie przyznana", 2000, NULL),
("Nie przyznana", 10000, NULL),
("Nie przyznana", 1000, NULL),
("Nie przyznana", 3000, NULL);



CREATE TABLE zdarzenie(
	zdarzenie_id INT PRIMARY KEY,
    data_zdarzenia DATE NOT NULL,
    opis VARCHAR(255),
    osoba_id INT,
    samochod_id INT,
    policjant_id INT,
    FOREIGN KEY (osoba_id) REFERENCES osoba(osoba_id),
    FOREIGN KEY (samochod_id) REFERENCES samochod(samochod_id),
    FOREIGN KEY (policjant_id) REFERENCES policjant(policjant_id)
);

INSERT INTO zdarzenie VALUES
(1, '2017-02-12', 'Kradzież', 1,1,NULL),
(2, '2017-02-11', 'Napad', 1,1,2),
(3, '2016-04-21', 'Wypadek', 2,1,1),
(4, '2017-05-31', 'Stłuczka', 3,NULL,5),
(5, '2018-07-11', NULL, 4,4,5),
(6, '2019-01-21', NULL, 5,4,6),
(7, '2018-02-31', 'Kradzież', 1,3,5),
(8, '2017-05-04', NULL, NULL,1,6),
(9, '2016-06-04', 'Wypadek', null,4,7),
(10, '2016-07-05', 'Kradzież', 2,5,7),
(11, '2016-11-11', 'Wypadek', 3,NULL,7);


