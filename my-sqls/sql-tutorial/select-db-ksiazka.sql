--   USER: root  PASSWORD mysql

SELECT tytul  FROM ksiazka;

-- zwracamy dwie kolumny
SELECT autor_imie, autor_nazwisko FROM ksiazka;

-- zwracamy trzy kolumny, trzecia obliczana i o nadanej nazwie
SELECT autor_imie, autor_nazwisko, min_wiek*10 AS wiekX10 FROM ksiazka ;

-- wszystkie kolumny
SELECT * FROM ksiazka ;


-- ZADANIE
-- wyswietlić imie i nazwisko wszystkich klientow

SELECT imie, nazwisko FROM klient;

-- ==================== 1.2  SELECT OPERATORY ====================

SELECT * FROM ksiazka WHERE rodzaj='Bajki';

SELECT * FROM ksiazka WHERE rodzaj='Bajki' AND autor_nazwisko='Brzechwa';

SELECT * FROM klient WHERE nazwisko='Kowalski';
 
SELECT * FROM klient WHERE nazwisko<>'Kowalski';

-- uzycie LIKE
SELECT * FROM klient WHERE nazwisko LIKE 'Kow%';

-- uzycie OR/AND
SELECT * FROM klient WHERE nazwisko='Kowalski' OR nazwisko='Szymański';

SELECT * FROM klient WHERE nazwisko LIKE 'S%' AND rok_urodzenia>'1960-01-01';


-- ZADANIA
-- znaleźć wszystkie książki których autor miał na imie 'Władysław'

 SELECT * FROM ksiazka WHERE autor_imie='Władysław';

-- znaleźć książki gdzie imie autora zaczyna się od J

 SELECT * FROM ksiazka WHERE autor_imie LIKE 'J%';

-- wyświetlić wszystkie ksiazki gdzie typy inne niż 'Bajki'

 SELECT * FROM ksiazka WHERE rodzaj<>'Bajki';


-- =================== 1.3 SORTOWANIE ===================
SELECT * FROM klient ORDER BY  data_zalozenia ASC;
SELECT * FROM klient ORDER BY  data_zalozenia DESC;

SELECT * FROM klient ORDER BY  nazwisko,imie ASC;

-- posortowane rosnaca po nazwisku, imieniu a w drugiej kolejnosci po dacie urodzenia
SELECT * FROM klient ORDER BY  nazwisko DESC ,imie ,rok_urodzenia ASC;

-- ZADANIE
-- wyświetlić książki posortowane według min_wiek od największej do najmniejszej

SELECT * FROM ksiazka ORDER BY min_wiek DESC;

-- =============== 1.4 TABLE VARIABLES ==============
-- chcemy wyswietlic polecajacego i osobę która została zwerbowana 
SELECT * FROM klient AS polecajacy, klient AS nowy_klient
WHERE  polecajacy.klient_id=  nowy_klient.id_polecony_przez;

-- lepsza prezentacja
SELECT nowy_klient.imie AS nowy_imie, nowy_klient.nazwisko AS nowy_nazwisko, polecajacy.imie AS polecajacy_imie, polecajacy.nazwisko AS polecajacy_nazwisko
FROM klient AS polecajacy, klient AS nowy_klient
WHERE  polecajacy.klient_id=  nowy_klient.id_polecony_przez;


-- ========== 1.5 UNION INTERSECT EXPECT ====
-- UNION
SELECT klient_id, imie, nazwisko FROM klient
UNION  
SELECT klient_id, imie, nazwisko FROM klient_archiwalny;




-- Ćwiczenia
-- wyswietlić w jednej tabeli imiona uzytkownikow i imiona autorow ksiazek 

   SELECT autor_imie, autor_nazwisko FROM ksiazka
   UNION
   SELECT imie, nazwisko FROM klient;
   

-- ==================== 1.6 SELECT łączenie ====================

SELECT * FROM ksiazka, recenzja WHERE ksiazka.ksiazka_id=recenzja.ksiazka_id;

-- ZADANIE
-- wyswietlić informacje o kliencie a obok informacje ile ksiazek przeczytał

SELECT klient.*, liczba_przeczytanych_ksiazek FROM klient, statystyka_klienta WHERE klient.klient_id=statystyka_klienta.klient_id;

--  to samo co wyzej i wyświetlić tych co mają przeczytane 20 ksiazek i sa mężczyznami

SELECT klient.*, liczba_przeczytanych_ksiazek FROM klient, statystyka_klienta 
WHERE klient.klient_id=statystyka_klienta.klient_id AND plec='M' AND liczba_przeczytanych_ksiazek>20;


-- ============ 1.7 DICTINCT ===============
SELECT DISTINCT autor_imie FROM ksiazka;
SELECT * FROM ksiazka;

-- ćwiczenie
-- wyświetlć unikalne imiona klientow ktore mamy w  tablicy klient

SELECT DISTINCT imie FROM klient;

-- wyświetlć unikalne imiona+nazwiska klientow ktore mamy w  tablicy klient

SELECT DISTINCT imie,nazwisko FROM klient;

