DROP FUNCTION samochod_moc;
DELIMITER $$
CREATE FUNCTION samochod_moc(pojemnosc DECIMAL) RETURNS VARCHAR(10)
    DETERMINISTIC
BEGIN
    DECLARE lvl varchar(10);
 
    IF pojemnosc > 3000 THEN
 SET lvl = 'MOCNY';
    ELSEIF (pojemnosc <= 2000 AND pojemnosc >= 1000) THEN
        SET lvl = 'ŚREDNI';
    ELSEIF pojemnosc < 1000 THEN
        SET lvl = 'SŁABY';
    END IF;
 
 RETURN (lvl);
END$$

DELIMITER ;

SELECT samochod_moc(pojemnosc)
FROM samochod;