-- CREATE TABLE articole
-- (
--  idarticol INT,
--  denarticol VARCHAR(50)
-- );

-- INSERT INTO articole (idarticol,denarticol) VALUES
--  (1, 'Articol1'),
--  (2, 'Articol2'),
--  (3, 'Articol3'),
--  (4, 'Articol4'),
--  (5, 'Articol5');
-- 

-- CREATE TABLE autori (
--  IdCercetator INT(11) NOT NULL,
--  IdArticol INT(11) NOT NULL, PRIMARY KEY (IdCercetator, IdArticol) 
-- );
-- 
-- INSERT INTO autori
--  (IdCercetator, IdArticol) VALUES 
--  (1, 1),
--  (2, 2),
--  (3, 3),
--  (4, 4);


-- INSERT INTO autori
--  (IdCercetator, IdArticol) VALUES 
--  (1, 1),
--  (2, 2),
--  (3, 3),
--  (4, 4);


-- CREATE TABLE universitate (
--  iduniversitate INT(11) NOT NULL,
--  denuniversitate TINYTEXT NOT NULL, PRIMARY KEY (iduniversitate) 
-- );


-- INSERT INTO universitate (iduniversitate, denuniversitate) VALUES 
-- (1, 'USARB'),
-- (2, 'USM'),
-- (3, 'ASEM');

-- CREATE TABLE cercetatori (
--  idcercetator INT(11) NOT NULL,
--  numecercetător TINYTEXT NOT NULL,
--  iduniversitate INT(11) NOT NULL, PRIMARY KEY (idcercetator) 
-- );

-- INSERT INTO cercetatori (idcercetator, numecercetător, iduniversitate) VALUES 
--  (1, 'Dodu Petru', 1),
--  (2, 'Lungu Vasile', 2),
--  (3, 'Vrabie Maria', 1),
--  (4, 'Ombun Bogdan', 3);

-- a. Creați o copie a tabelului Cercetatori. Ștergeți înregistrările pentru care codul universității este 1.
--  Afișați pe ecran numărul de înregistrări eliminate.
-- 
-- creez o copie a tabelului cercetatori

-- CREATE TABLE laborator3.cercetatori_copie LIKE laborator3.cercetatori;

-- copii datele din tabelul cercetatori in cercetatori_copie

-- INSERT INTO lab_3.cercetatori_copie SELECT * FROM lab_3.cercetatori;

-- Fac o procedura in care voi face un cursor. Fara el cursoru nu va lucra

-- /* variabila hadler - a*/
-- Declare done integer default 0;
-- 


/*declararea cursorului*/
Declare BankCursor Cursor for select * from cercetatori_copie where iduniversitate = 1;
/*HANDLER programare, pe care o vom explica mai jos*/
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;
Set counter = 0;
/* deschiderea cursorului */
Open BankCursor;
/*scoaterea datelor */

WHILE done = 0 DO
  FETCH BankCursor INTO id_cercet,cercet_name,cercet_univ,cercet_calif;
   delete from cercetatori_copie where idcercetator = id_cercet;
   Set counter = counter +1;
-- select id_cercet;
END WHILE;
select counter as 'înregistrările eliminate';
/*inchiderea cursorului */
Close BankCursor;
END;
END

-- b. Pentru tabelul Cercetatori,
--  folosind un cursor să se afișeze numele cercetătorului și
--   denumirea universității care au cel puțin două articole. Cu ajutorului unui alt cursor 
--   să se afișeze lista cercetătorilor care au un articol. Să se definească pentru fiecare listă un antet.
--    Între rezultatele cursoarelor să se tragă o linie.
-- 
-- DELIMITER $$
-- 
-- CREATE PROCEDURE proc_cursors2
-- BEGIN
--    Begin
--       /* variabila unde noi scoatem datele */
--       Declare id_cercet int;
--       Declare cercet_name VARCHAR(30);
--       Declare cercet_univ VARCHAR(30);
--       Declare cercet_art int;
-- 
-- 
--       /* var hadler - a*/
--       DECLARE more_rows BOOLEAN DEFAULT TRUE;
-- 
--       /*Initializare cursorului 1*/
--       Declare BankCursor Cursor for 
--       select count(autori.IdArticol) as Number, cercetatori_copie.numecercetător, universitate.denuniversitate
--       from cercetatori_copie
--       inner join autori on autori.IdCercetator = cercetatori_copie.idcercetator
--       inner join universitate on universitate.iduniversitate = cercetatori_copie.iduniversitate
--       group by autori.IdCercetator
--       having count(autori.IdArticol) >=2;
-- 
--       /*declararea cursorului 2*/
--       Declare BankCursor2 Cursor for 
--       select count(autori.IdArticol) as Number, cercetatori_copie.numecercetător, universitate.denuniversitate
--       from cercetatori_copie
--       inner join autori on autori.IdCercetator = cercetatori_copie.idcercetator
--       inner join universitate on universitate.iduniversitate = cercetatori_copie.iduniversitate
--       group by autori.IdCercetator
--       having count(autori.IdArticol) = 1;
-- 
-- 
--       /*HANDLER 1*/
--       DECLARE CONTINUE HANDLER FOR NOT FOUND SET more_rows = FALSE;
-- 
--       Set counter = 0;
--       /* deschiderea cursorului 1*/
--       Open BankCursor;

     --  /*scoatem datele */
--       DROP TABLE IF EXISTS date_cercetator;
--       CREATE TEMPORARY TABLE date_cercetator(
--          cercet_art int,
--          cercet_name VARCHAR(30),
--          cercet_univ VARCHAR(30)
--       );
--       insert into date_cercetator (cercet_art,cercet_name ,cercet_univ) values (null, 'Cercetatorile', 'cu cel putin 2 articole');
-- 
--       while more_rows do
--         FETCH BankCursor INTO cercet_art,cercet_name,cercet_univ;
--          IF more_rows THEN
--             insert into date_cercetator (cercet_art,cercet_name ,cercet_univ) values (cercet_art, cercet_name, cercet_univ);
--          END IF;
--       End while;
--       /*inchiderea cursorul 1*/
--       Close BankCursor;
-- 
--       -- ---------------------------
--       begin
-- 
--       Declare more_rows2 BOOLEAN DEFAULT TRUE;
--       /*HANDLER 1*/
--       DECLARE CONTINUE HANDLER FOR NOT FOUND SET more_rows2 = FALSE;
-- 
--       /* deschiderea cursor 2*/
--       Open BankCursor2;
-- 
--       insert into date_cercetator (cercet_art,cercet_name ,cercet_univ) values (null, '--------', '--------'), (null, 'Cercetatorile', 'cu un articol');
--       while more_rows2 do
--         FETCH BankCursor2 INTO cercet_art,cercet_name,cercet_univ;
--          IF more_rows2 THEN
--             insert into date_cercetator (cercet_art,cercet_name ,cercet_univ) values (cercet_art, cercet_name, cercet_univ);
--          END IF;
--       End while;
--       select *  from date_cercetator;
--       DROP TABLE IF EXISTS date_cercetator;
--       /*inchiderea cursor2 */
--       Close BankCursor2;
--       end;
-- 
--    END;
-- 
-- END;


-- c. Folosind un cursor care va afișa în trei variabile diferite pentru a afișa un mesaj 
-- (primul nume =, al doilea nume =, al treilea nume = ) 
-- însoțit de numele primelor 3 cercetători ordonați în ordine alfabetică a numelui.
-- 
-- DELIMITER $$
-- CREATE PROCEDURE proc_cursors3 BEGIN BEGIN
-- /* variabila unde scoatem datele */ DECLARE cercet_name1 VARCHAR(30); DECLARE cercet_name2 VARCHAR(30); DECLARE cercet_name3 VARCHAR(30); DECLARE counter INT; DECLARE MESSAGE_TEXT VARCHAR(200);
-- 
-- /* variabila hadler - a*/ DECLARE more_rows BOOLEAN DEFAULT TRUE;
-- 
-- /*declarrea cursor 1*/ DECLARE BankCursor CURSOR FOR
-- SELECT cercetatori_copie.numecercetător
-- FROM cercetatori_copie
-- ORDER BY cercetatori_copie.numecercetător
-- LIMIT 3;
-- 
-- /*HANDLER */ DECLARE CONTINUE HANDLER FOR NOT FOUND SET more_rows = FALSE;
-- 
-- /* deschidem cursor*/ OPEN BankCursor;
-- /*scoatem datele */ SET counter = 0; WHILE more_rows DO
--  IF COUNTER = 0 THEN FETCH BankCursor INTO cercet_name1; END IF;
--  IF COUNTER = 0 THEN FETCH BankCursor INTO cercet_name2; END IF;
--  IF COUNTER = 0 THEN FETCH BankCursor INTO cercet_name3; END IF;
--  
--  -- IF more_rows THEN
--  
--  -- END IF;
-- END WHILE;
 
-- SELECT CONCAT('primul nume =',cercet_name1, ', al doilea nume =', cercet_name2, ', al treilea nume =', cercet_name3) AS message;
-- 
-- -- Acest mesaj va aparea ca eroare
-- SELECT CONCAT('primul nume =',cercet_name1, ', al doilea nume =', cercet_name2, ', al treilea nume =', cercet_name3) INTO MESSAGE_TEXT; SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =MESSAGE_TEXT;
-- /*inchiderea cursor */ CLOSE BankCursor; END; END;


-- d. Folosind un CURSOR să se afișeze pentru fiecare cercetător numărul de articole scrise în formatul:
-- Nume – Dodu, prenume – Petru, articole - 1
-- 
-- DELIMITER $$
-- CREATE PROCEDURE proc_cursors4 BEGIN BEGIN
-- /* variabila unde scoatem datele */ DECLARE cercet_name VARCHAR(30); DECLARE cercet_surnname VARCHAR(30); DECLARE counter_art INT; DECLARE MESSAGE_TEXT VARCHAR(200);
-- 
-- /* variabila hadler - a*/ DECLARE more_rows BOOLEAN DEFAULT TRUE;
-- 
-- /*DEclararea cursorului 1*/ DECLARE BankCursor CURSOR FOR
-- SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(cercetatori_copie.numecercetător, ' ', 1), ' ', -1) AS first_name, SUBSTRING_INDEX(SUBSTRING_INDEX(cercetatori_copie.numecercetător, ' ', 2), ' ', -1) AS last_name, COUNT(autori.IdCercetator) AS articole
-- FROM cercetatori_copie
-- INNER JOIN autori ON autori.IdCercetator = cercetatori_copie.idcercetator
-- GROUP BY cercetatori_copie.idcercetator;
-- 
-- /*HANDLER */ DECLARE CONTINUE HANDLER FOR NOT FOUND SET more_rows = FALSE;
-- DROP TABLE IF EXISTS date_cercetator;
-- CREATE TEMPORARY TABLE date_cercetator(
--  cercet_name VARCHAR(30),
--  cercet_surnname VARCHAR(30),
--  counter_art VARCHAR(30)
-- );
-- /* deschiderea cursorului*/ OPEN BankCursor;
-- /*citirea datelor */ SET MESSAGE_TEXT = ''; WHILE more_rows DO 
--  IF more_rows THEN FETCH BankCursor INTO cercet_name, cercet_surnname, counter_art;
-- INSERT INTO date_cercetator(cercet_name,cercet_surnname,counter_art) VALUES (CONCAT('Nume – ', cercet_surnname), CONCAT('prenume – ', cercet_name), CONCAT('articole – ', counter_art)); SET MESSAGE_TEXT = CONCAT(MESSAGE_TEXT, '| Nume – ', cercet_surnname, ', prenume – ', cercet_name, ', articole – ', counter_art); END IF; END WHILE;
-- SELECT *
-- FROM date_cercetator;
-- DROP TABLE IF EXISTS date_cercetator;
-- 
-- /*inchiderea cursor */ CLOSE BankCursor; SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =MESSAGE_TEXT; END; END;


-- e. Folosind un CURSOR să se afișeze pentru fiecare articol autorii acestui în formatul:
-- Denumirea articolului – Articol1, autori - Dodu Petru.

-- DELIMITER $$
-- CREATE PROCEDURE proc_cursors5 BEGIN BEGIN
-- /* variabila unde scoatem datele */ DECLARE result VARCHAR(150); DECLARE MESSAGE_TEXT VARCHAR(200);
-- 
-- /* variabila  hadler - a*/ DECLARE more_rows BOOLEAN DEFAULT TRUE;
-- 
-- /*declararea cursor 1*/ DECLARE BankCursor CURSOR FOR
-- SELECT CONCAT ('Denumirea articolului – ', cercetatori_copie.numecercetător, ', autori - ',
--  articole.denarticol) AS result
-- FROM cercetatori_copie
-- INNER JOIN autori ON autori.IdCercetator = cercetatori_copie.idcercetator
-- INNER JOIN articole ON articole.idarticol = autori.IdArticol;



-- /*HANDLER */
-- DECLARE CONTINUE HANDLER FOR NOT FOUND SET more_rows = FALSE;
-- 
-- /* deschiderea cursor*/
-- Open BankCursor;
-- /*citirea datelor*/
-- set MESSAGE_TEXT = '';
-- while more_rows do  
--    FETCH BankCursor INTO result;
--    IF more_rows THEN    
--       select result;
--       set MESSAGE_TEXT = Concat(MESSAGE_TEXT, result, ' | ');
--    END IF;
-- End while;
--  
-- 
-- /*inchiderea cursor */
-- Close BankCursor;
-- SIGNAL SQLSTATE '45000' set MESSAGE_TEXT =MESSAGE_TEXT;
-- END;
-- 
-- END;



