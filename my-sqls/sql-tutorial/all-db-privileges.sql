CREATE USER 'janusz'@'localhost' IDENTIFIED BY 'janusz';
GRANT SELECT,SELECT,INSERT ON kartoteka_policyjna.osoba TO 'janusz'@'localhost';
REVOKE SELECT ON kartoteka_policyjna.osoba FROM 'janusz'@'localhost';
FLUSH PRIVILEGES;