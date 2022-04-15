-- 
-- CREATE TABLE Film (
--   idFilm SMALLINT PRIMARY KEY,
--   titlu VARCHAR(50) NOT NULL,
--   regizor VARCHAR(50) NOT NULL,
--   anul SMALLINT NOT NULL
-- );
-- 
-- CREATE TABLE Actor (
-- 	idActor SMALLINT PRIMARY KEY,
--   	nume VARCHAR(50) NOT NULL
-- );
-- 
-- CREATE table Filmographie(
--     idActor SMALLINT NOT null,
--     idFilm SMALLINT NOT null,
--     rolu VARCHAR(50) NOT NULL,
--     salariu INT NOT null,
-- 	PRIMARY KEY(idActor, idFilm),
--     foreign key (idActor) references actor (idActor),
--     foreign key (idFilm) references film (idFilm)
-- );
-- 
-- 
-- INSERT INTO film VALUES (1, 'Les evades', 'Darabont', 1994);
-- INSERT INTO film VALUES (2, 'Rango', 'Verbinski', 2015);
-- INSERT INTO film VALUES (3, 'Le parrain', 'Coppola', 1972);
-- INSERT INTO film VALUES (4, 'Le parrain_2', 'Coppola', 1974);
-- INSERT INTO film VALUES (5, 'Chocolat', 'Hallstrom', 2013);
-- INSERT INTO film VALUES (6, 'Scarface', 'De palma', 1983);
-- INSERT INTO film VALUES (7, 'L''odyssee de Pi', 'Ang Lee', 2011);
-- 
-- INSERT INTO actor VALUES (1, 'Jonny Deep');
-- INSERT INTO actor VALUES (2, 'Al Pacino');
-- INSERT INTO actor VALUES (3, 'Suraj Sharma');
-- INSERT INTO actor VALUES (4, 'Brad Pitt');
-- INSERT INTO actor VALUES (5, 'Edward Norton');
-- 
-- INSERT INTO filmographie VALUES (1, 5, 'Roux', 5000);
-- INSERT INTO filmographie VALUES (1, 7, 'Rango', 10000);
-- INSERT INTO filmographie VALUES (2, 2, 'Michael Corleone', 10000);
-- INSERT INTO filmographie VALUES (2, 3, 'Michael Corleone', 20000);
-- INSERT INTO filmographie VALUES (2, 6, 'Tony Montana', 15000);
-- INSERT INTO filmographie VALUES (3, 4, 'Pi', 20000);

-- a
-- select film.titlu
-- FROM filmographie f
-- INNER JOIN actor a ON a.idActor = f.idActor
-- INNER JOIN film ON film.idFilm = f.idFilm
-- WHERE a.nume = "Suraj Sharma"
-- ORDER BY film.titlu
-- 
-- indexul
-- CREATE INDEX sharma ON film(titlu);
-- DROP INDEX sharma ON film;
-- explain
-- select film.titlu
-- FROM filmographie f
-- INNER JOIN actor a ON a.idActor = f.idActor
-- INNER JOIN film ON film.idFilm = f.idFilm
-- WHERE a.nume = "Suraj Sharma"
-- ORDER BY film.titlu
-- 


-- b
-- SELECT film.idFilm, film.titlu
-- FROM film
-- WHERE film.anul < 2000 AND film.regizor = "Coppola"
-- 
-- indexul 
-- CREATE INDEX filmul2000 ON film(titlu);
-- DROP INDEX filmul2000 ON film;
-- explain
-- SELECT film.idFilm, film.titlu
-- FROM film
-- WHERE film.anul < 2000 AND film.regizor = "Coppola"
-- SHOW INDEX FROM film

-- d
-- SELECT actor.nume, MAX(filmographie.salariu)
-- FROM filmographie
-- INNER JOIN actor ON filmographie.idActor = actor.idActor
-- indexul 
-- CREATE INDEX actpay ON filmographie(salariu);
-- DROP INDEX actpay ON filmographie;
-- explain
-- SELECT actor.nume, MAX(filmographie.salariu)
-- FROM filmographie
-- INNER JOIN actor ON filmographie.idActor = actor.idActor
-- SHOW INDEX FROM filmographie;
-- 
