-- CREATE TABLE Aeroporturi (
-- cod SMALLINT PRIMARY KEY,
-- oras VARCHAR(40) NOT NULL
-- );

-- CREATE TABLE Zbor_cod (
-- cod SMALLINT PRIMARY KEY,
-- Denumire_aviacompanie VARCHAR(40) NOT NULL
-- );

-- CREATE TABLE Zboruri(
-- punctplecare SMALLINT NOT NULL,
-- punctdestinatie SMALLINT NOT NULL,
-- ora_plecare DATETIME,
-- ora_sosire DATETIME,
-- cod SMALLINT NOT NULL, PRIMARY KEY(punctplecare, punctdestinatie, ora_plecare, cod), FOREIGN KEY (punctplecare) REFERENCES Aeroporturi (cod), FOREIGN KEY (punctdestinatie) REFERENCES Aeroporturi (cod), FOREIGN KEY (cod) REFERENCES Zbor_cod (cod)
-- );

-- CREATE TABLE Zboruri_disponibile (
-- zbor SMALLINT NOT NULL,
-- data_zbor DATE NOT NULL,
-- numar_locuri_libere SMALLINT NOT NULL,
-- pret DOUBLE NOT NULL, PRIMARY KEY(zbor, data_zbor), FOREIGN KEY(zbor) REFERENCES Zbor_cod (cod)
-- );

-- CREATE TABLE Rezervari (
-- cod_rezervare SMALLINT PRIMARY KEY,
-- zbor_rezerv SMALLINT NOT NULL,
-- data_rezerv DATE,
-- nume_pasager VARCHAR(40) NOT NULL,
-- pret DOUBLE NOT NULL, FOREIGN KEY(zbor_rezerv,data_rezerv) REFERENCES Zboruri_disponibile (zbor,data_zbor)
-- );

-- 3
--  delimiter $$
--  CREATE PROCEDURE proc1(IN data_zbor DATE, IN punctdestinatie SMALLINT)
--  BEGIN
--  SELECT zbor, numar_locuri_libere
--  FROM zboruri_disponibile
-- INNER JOIN zboruri ON zboruri_disponibile.zbor = zboruri.cod
--  INNER JOIN zbor_cod ON zboruri_disponibile.zbor = zbor_cod.cod
--  WHERE data_zbor = data_zbor AND zbor = punctdestinatie;
--  END $$
-- delimiter ;
-- 
--  CALL proc1("2022-04-17", 1);

-- 4

-- — delimiter $$
-- — CREATE FUNCTION func22(oras1 VARCHAR(40), oras2 VARCHAR(40))
-- — RETURNS VARCHAR(5)
-- — deterministic
-- — BEGIN
-- — if EXISTS (SELECT punctplecare, punctdestinatie
-- — FROM zboruri
-- — WHERE punctplecare = oras1 AND punctdestinatie = oras2)
-- — then
-- — RETURN "TRUE";
-- — ELSE
-- — RETURN "FALSE";
-- — END if;
-- — END $$
-- — delimiter ;


