-- TRIGGER EXAMPLE

DELIMITER $$
CREATE TRIGGER before_insert_osoba
	BEFORE INSERT ON osoba
    FOR EACH ROW
BEGIN
	INSERT INTO osoba_action(action_date, osoba_naziwsko) VALUES
    (NOW(), NEW.nazwisko);
END$$  
DELIMITER ;

DROP TRIGGER before_insert_osoba;

DROP TABLE osoba_action;

CREATE TABLE osoba_action(
	id INT AUTO_INCREMENT PRIMARY KEY,
    action_date DATETIME,
    osoba_naziwsko VARCHAR(50)
);

SELECT * FROM osoba_action;

SELECT * FROM osoba;

INSERT INTO osoba
VALUES
(12, '1998-01-01', 'Janusz','Einstein', NULL),
(13, '1999-01-01', 'Maciej','Tusk', NULL),
(14, '2000-01-01', 'Michał','Kaczyński', NULL);