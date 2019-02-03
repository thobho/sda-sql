-- obecna data
SELECT CURDATE();

-- dodatnie do daty jednego dnia
SELECT data_urodzenia, ADDDATE(data_urodzenia, 1)
FROM osoba;

-- string na date
SELECT DATE("2000-01-02")
FROM osoba;

-- string na date
SELECT imie, DATEDIFF(data_urodzenia, CURDATE())
FROM osoba;

-- wyciągnięcie z daty dnia miesiąca, roku itd
SELECT DAYNAME(data_urodzenia), DAYOFYEAR(data_urodzenia)
FROM osoba;

-- dodaje do roku dni i zwraca datę
SELECT MAKEDATE(1999, 100);

-- możliwoś dowlonego zakładania warunku na kolumnę
SELECT nazwisko,
	CASE
		WHEN nazwisko LIKE '%n' THEN 'konczy się na n'
        WHEN nazwisko LIKE '%j' THEN 'konczy się na j'
		ELSE 'koczny się na inną literę'
    END    
FROM osoba;

SELECT IFNULL(model, "model nieznany")
FROM samochod;

SELECT model, marka, IF(pojemnosc>1500, "MOCNY", "SŁABY")
FROM samochod;

SELECT VERSION(), USER(), DATABASE(), CONNECTION_ID();
