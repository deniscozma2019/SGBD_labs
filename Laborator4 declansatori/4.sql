/*
CREATE TABLE Persoane (
  idPersoana SMALLINT PRIMARY KEY,
  Numele VARCHAR(30) NOT NULL,
  Virsta SMALLINT NOT NULL
);

create table Amici(
    idpersoana1  SMALLINT NOT null,
    idpersoana2  SMALLINT NOT null,
	PRIMARY KEY(idpersoana1, idpersoana2),
    foreign key (idpersoana1) references persoane (idpersoana),
    foreign key (idpersoana2) references persoane (idpersoana)
);

create table Rude(
    idpersoana1  SMALLINT NOT null,
    idpersoana2  SMALLINT NOT null,
	PRIMARY KEY(idpersoana1, idpersoana2),
    foreign key (idpersoana1) references persoane (idpersoana),
    foreign key (idpersoana2) references persoane (idpersoana)
);

INSERT INTO Persoane(idPersoana, Numele, Virsta
)
VALUES(
	1,
	'Elvi',
	19
),
(
	2,
	'Farouk',
	19
),
(
	3,
	'Sam',
	19
),
(
	4,
	'Tiany',
	19
),
(
	5,
	'Nadia',
	14
),
(
	6,
	'Chris',
	12
),
(
	7,
	'Kris',
	10
),
(
	8,
	'Bethany',
	16
);

INSERT INTO Persoane(idPersoana, Numele, Virsta
)
VALUES(
	9,
	'Louis',
	17
),
(
	10,
	'Austin',
	22
),
(
	11,
	'Gabriel',
	21
),
(
	12,
	'Jessica',
	20
),
(
	13,
	'John',
	16
),
(
	14,
	'Alfred',
	19
),
(
	15,
	'Samantha',
	17
),
(
	16,
	'Craig',
	17
);

INSERT INTO amici (idpersoana1, idpersoana2)
VALUES(1,2);
INSERT INTO amici (idpersoana1, idpersoana2)
VALUES(1,3);
INSERT INTO amici (idpersoana1, idpersoana2)
VALUES(2,4);
INSERT INTO amici (idpersoana1, idpersoana2)
VALUES(2,6);
INSERT INTO amici (idpersoana1, idpersoana2)
VALUES(3,9);
INSERT INTO amici (idpersoana1, idpersoana2)
VALUES(4,9);
INSERT INTO amici (idpersoana1, idpersoana2)
VALUES(7,5);
INSERT INTO amici (idpersoana1, idpersoana2)
VALUES(5,8);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (6, 10);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (13, 6);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (7, 6);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (8, 7);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (9, 11);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (12, 9);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (10, 15);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (12, 11);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (12, 15);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (13, 16);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (15, 13);
INSERT INTO Amici (idpersoana1, idpersoana2)
VALUES (16, 14); 

INSERT INTO rude  (idpersoana1, idpersoana2) VALUES (4,6);
INSERT INTO rude  (idpersoana1, idpersoana2) VALUES (2,4);
INSERT INTO rude  (idpersoana1, idpersoana2) VALUES (9,7);
INSERT INTO rude  (idpersoana1, idpersoana2) VALUES (7,8);
INSERT INTO rude  (idpersoana1, idpersoana2) VALUES (11,9);
INSERT INTO rude  (idpersoana1, idpersoana2) VALUES (13,10);
INSERT INTO rude  (idpersoana1, idpersoana2) VALUES (14,5);
INSERT INTO rude  (idpersoana1, idpersoana2) VALUES (12,13);

*/
-- 1.	S?? se creeze un declan??ator care dup?? ad??ugarea unei persoane ??n tabelul persoane,
--  va ad??uga o leg??tur?? de prietenie dintre persoana dat?? ??i Elvia.
--  S?? se verifice lucrul declan??atorului prin ad??ugarea unei persoane ??n tabelul persoane.
--  Care este efectul declan??atorului?


-- delimiter $$
-- CREATE TRIGGER trig1
-- AFTER INSERT 
-- 	ON persoane
-- 	FOR EACH row
-- BEGIN
-- INSERT INTO amici(idpersoana1, idpersoana2)
-- 	VALUES (NEW.idPersoana, (SELECT persoane.idPersoana 
-- 									FROM persoane 
-- 									WHERE persoane.Numele = "Elvi"));
-- END $$
-- delimiter ;
-- 
-- INSERT INTO persoane VALUES (17, 'Denis', 21);

-- 
-- 2.	S?? se creeze un declan??ator care ??nainte de ad??ugare a unei persoane ??n tabelul Persoane,
--  verific?? dac?? aceast?? persoan?? exist?? deja ??n tabel.
--   Dac?? exist?? deja o persoan?? cu acela??i nume (ca ??i cel inserat) s?? se afi??eze un mesaj de eroare ???Aten??ie!
--    A??a persoan?? exist??!???.
-- 	 S?? se verifice lucrul declan??atorului prin ad??ugarea unei persoane ??n tabelul Persoane cu acela??i nume,
-- 	  cu un nume nou diferit.
-- 	   Care este efectul declan??atorului?
-- Obs. Se va folosi urm??toarea structur?? pentru afi??area mesajului:
-- signal sqlstate '45000' set message_text = 'MESAJ'
-- -- 
-- 

-- 
-- delimiter $$
-- CREATE TRIGGER trig3
-- BEFORE INSERT
-- 	ON persoane
-- 	FOR EACH ROW
-- BEGIN
-- 	if EXISTS(SELECT *
-- 				FROM persoane
-- 				WHERE persoane.Numele = NEW.Numele)
-- 	then 
-- 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Atentie! Asa persoana exista.';
-- 	END if;
-- END $$
-- delimiter ;
-- 
-- INSERT INTO persoane VALUES (18, 'Denis', 21);
-- INSERT INTO persoane VALUES (18, 'Den', 21);

-- 3.	S?? se creeze un declan??ator care dup?? inserarea a dou?? persoane ??n tabelul rude creeaz?? o leg??tur?? de prietenie dintre aceste dou?? persoane. 
-- Dac?? inser??m perechea (x, y) ??n tabelul rude,
--  ??n tabelul Amici se va insera aceea??i pereche de persoane (x, y).
--   Dac?? perechea introdus?? exist??, se va returna un mesaj de eroare. S?? se verifice lucrul declan??atorului.

-- DELIMITER $$
-- CREATE TRIGGER trig5
-- AFTER INSERT    -- schimbat before in after
-- 	ON rude 
-- 	FOR EACH ROW
-- BEGIN
-- 	IF EXISTS (SELECT * 
-- 				  FROM rude
-- 				  WHERE  (rude.idPersoana1 = NEW.idPersoana1 
-- 				  	   AND rude.idPersoana2 = NEW.idPersoana2)
-- 				  OR  (rude.idPersoana1 = NEW.idPersoana2 
-- 				   AND rude.idPersoana2 = NEW.idPersoana1))
-- 	THEN
-- 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Asa pereche exista.';
-- 	ELSEIF NOT EXISTS (SELECT * 
-- 				  FROM amici
-- 				  WHERE  (amici.idPersoana1 = NEW.idPersoana1 
-- 				  	   AND amici.idPersoana2 = NEW.idPersoana2)
-- 				  OR  (amici.idPersoana1 = NEW.idPersoana2 
-- 				   AND amici.idPersoana2 = NEW.idPersoana1))
-- 	THEN
-- 		INSERT INTO amici(idPersoana1, idPersoana2) VALUES (NEW.idPersoana1, NEW.idPersoana2);
-- 	END IF;
-- END $$
-- DELIMITER ;
-- 
-- INSERT INTO rude VALUES (1,2);
-- 

-- 4.	S?? se creeze un declan??ator care va elimina leg??tura de prietenie ??ntre dou?? persoane, dac?? leg??tura de rudenie ??ntre ele este eliminat??.
--  Dac?? perechea (x, y) nu mai este ??n tabelul Rude, atunci perechea dat?? este eliminat?? automat din tabelul Amici.
--   Demonstra??i lucrul declan??atorului.

-- delimiter $$
-- CREATE TRIGGER trig4
-- AFTER DELETE 
-- ON rude
-- FOR EACH ROW
-- BEGIN
-- 	DELETE FROM amici
-- 	WHERE (amici.idpersoana1 = OLD.idpersoana1 AND amici.idpersoana2 = OLD.idpersoana1)
-- 		OR (amici.idpersoana1 = OLD.idpersoana2 AND amici.idpersoana2 = OLD.idpersoana1);
-- END $$
-- delimiter ;
-- 
-- DELETE FROM rude WHERE idpersoana1 = 17 AND idpersoana2 = 18;
-- 

-- 5.	S?? se creeze un declan??ator care ar elimina 
--    toate referin??ele la o persoan?? din tabelele Rude ??i amici,
--  c??nd aceast?? persoan?? este eliminat?? din tabelul Persoane. 
--  Demonstra??i lucrul declan??atorului.
-- 

-- delimiter $$
-- CREATE TRIGGER trig6
-- BEFORE DELETE
-- ON persoane
-- FOR EACH ROW
-- BEGIN
-- 	DELETE FROM rude
-- 	WHERE OLD.idPersoana = rude.idpersoana1 OR OLD.idPersoana = rude.idpersoana2;
-- 	DELETE FROM amici
-- 	WHERE OLD.idPersoana = amici.idpersoana1 OR OLD.idPersoana = amici.idpersoana2;
-- END $$
-- delimiter ;
-- 
-- DELETE FROM persoane WHERE idPersoana = 18;

-- 6.	Pentru aceast?? sarcin?? elimina??i cheile str??ine din tabelul amici. 
-- S?? se creeze un declan??ator care va lucra ca cheile str??ine eliminate.
-- Dac?? ??n tabelul Amici se va ad??uga o pereche de persoane (x, y),
-- declan??atorul se va asigura c?? persoanele cu codul x ??i y exist?? ??n tabelul Persoane.
-- ??n caz de depistare a ??ncerc??rii de a introduce persoane care nu exist?? ??n tabelul persoane
-- se va afi??a un mesaj de eroare. S?? se demonstreze situa??iile ??n care ac??ioneaz?? declan??atorul dat.

-- delimiter $$
-- CREATE TRIGGER trig67
-- BEFORE INSERT 
-- ON amici
-- FOR EACH ROW
-- BEGIN 
-- 	if NOT EXISTS (SELECT * 
-- 						FROM persoane 
-- 						INNER JOIN persoane p
-- 						WHERE persoane.idPersoana = NEW.idPersoana1 AND p.idPersoana = NEW.idPersoana2)
-- 	then 
-- 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Asa persoana nu exista';
-- 	END if;
-- END $$
-- delimiter ;
-- 
-- INSERT INTO amici VALUES (18,17);




-- 7.	S?? se creeze un declan??ator care va implementa modificarea ??n cascad?? a datelor,
--  astfel la modificarea datelor din tabelul Persoane (idPersoana) aceste modific??ri
--   vor fi propagate ??n tabelul amici.
--  Demonstra??i lucrul declan??atorului.
 
-- delimiter $$
-- CREATE TRIGGER trig7
-- AFTER UPDATE 
-- ON persoane 
-- FOR EACH ROW
-- BEGIN
-- 	UPDATE amici 
-- 		SET amici.idpersoana1 = NEW.idPersoana 
-- 		WHERE amici.idpersoana1 = OLD.idPersoana;
-- 	UPDATE amici 
-- 		SET amici.idpersoana2 = NEW.idPersoana 
-- 		WHERE amici.idpersoana2 = OLD.idPersoana;
-- END $$
-- delimiter ;
-- 
-- UPDATE persoane
-- SET persoane.idPersoana = 20 WHERE persoane.idPersoana = 17;


-- 8.	S?? se creeze un declan??ator care va implementa eliminarea ??n cascad?? a datelor,
--  astfel la eliminarea unei peroane din tabelul Persoane (idPersoana)
--   va fi eliminat?? leg??turile persoanei date din tabelul amici.
--  Demonstra??i lucrul declan??atorului
-- 

-- delimiter $$
-- CREATE TRIGGER trig8
-- BEFORE DELETE 
-- ON persoane
-- FOR EACH ROW
-- BEGIN
-- 	DELETE 
-- 	FROM amici 
-- 	WHERE amici.idpersoana1 = OLD.idPersoana 
-- 		OR amici.idpersoana2 = OLD.idPersoana;
-- END $$
-- delimiter ;
-- 
-- DELETE FROM persoane WHERE persoane.idPersoana = 20;
-- 

