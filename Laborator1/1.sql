

SELECT film.idFilm, film.titlu
FROM film INNER JOIN filmographie ON film.idFilm = filmographie.idFilm
INNER JOIN actor ON filmographie.idActor = actor.idActor
WHERE nume = 'Jonny Deep';


SELECT film.idFilm, film.titlu
FROM film INNER JOIN filmographie ON film.idFilm = filmographie.idFilm
INNER JOIN actor ON filmographie.idActor = actor.idActor
WHERE nume = 'Jonny Deep';


*/
/* c
SELECT f.titlu, f.regizor, f.anul 
FROM film
INNER JOIN film f ON film.regizor = f.regizor
WHERE film.titlu = 'Le parrain';

*/

/* d
SELECT film.titlu, film.regizor, film.anul 
FROM film 
WHERE titlu LIKE 'Le%' OR titlu LIKE '%de%';
*/

/* e
SELECT idFilm, titlu, anul
FROM film
ORDER BY anul DESC;
*/

/*f
SELECT COUNT(filmographie.idActor) AS 'Numar actori' 
FROM film INNER JOIN filmographie ON film.idFilm = filmographie.idFilm 
WHERE titlu = 'L''odyssee de Pi'
*/

/*g
SELECT DISTINCT actor.nume
FROM actor
INNER JOIN filmographie ON actor.idActor = filmographie.idActor;

*/

/*
SELECT actor.nume, filmographie.rolu, AVG(filmographie.salariu) AS Media
FROM filmographie
INNER JOIN actor ON filmographie.idActor = actor.idActor
GROUP BY actor.nume;

/
SELECT actor.idActor, actor.nume, AVG(salariu) as Media
FROM actor INNER JOIN filmographie ON actor.idActor=filmographie.idActor GROUP BY actor.idActor, actor.nume;



/* i
SELECT DISTINCT a1.nume AS Persoana1, a2.nume AS Persoana2, f1.salariu
FROM filmographie f1
INNER JOIN actor a1 ON f1.idActor = a1.idActor
INNER JOIN filmographie f2 ON f1.idActor <> f2.idActor
INNER JOIN actor a2 ON f2.idActor = a2.idActor
WHERE f1.idActor > f2.idActor  AND f1.salariu = f2.salariu;

*/
/*
SELECT salariu AS 'Salariu dolari', salariu*17.97 AS 'Salariu lei'
FROM filmographie

*/

/*
 SELECT actor.nume, sum(filmographie.salariu)persoane
 FROM filmographie INNER JOIN actor ON actor.idActor = filmographie.idActor
 GROUP BY filmographie.idActor;
 
 */
 
 