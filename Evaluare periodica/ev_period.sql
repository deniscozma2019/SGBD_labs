drop schema if exists ev_period_shem1;
create schema if not exists ev_period_shem1;

use ev_period_shem1;

create table if not exists ev_period_shem1.persons
(
    id   int unsigned auto_increment primary key,
    name varchar(100),
    age  smallint
);

create table if not exists ev_period_shem1.friends
(
    first_person_id  int unsigned,
    second_person_id int unsigned,

    foreign key (first_person_id) references persons (id),
    foreign key (second_person_id) references persons (id),
    primary key (first_person_id, second_person_id)
);

create table if not exists ev_period_shem1.rude
(
    first_person_id  int unsigned,
    second_person_id int unsigned,

    foreign key (first_person_id) references persons (id),
    foreign key (second_person_id) references persons (id),
    primary key (first_person_id, second_person_id)
);

#########

drop schema if exists ev_period_shem2;
create schema if not exists ev_period_shem2;

create table if not exists ev_period_shem2.persons
(
    id      int unsigned auto_increment primary key,
    name    varchar(100),
    surname varchar(100),
    mom     int unsigned,
    dad     int unsigned,

    foreign key (mom) references ev_period_shem2.persons (id),
    foreign key (dad) references ev_period_shem2.persons (id)
);

insert into ev_period_shem2.persons
values (1, 'Popa', 'Alla', null, null),
       (16, 'Popa', 'Viorel', null, null),
       (2, 'Mihalache', 'Maria', 1, 16),
       (3, 'Chistol', 'Ina', null, null),
       (4, 'Chistol', 'Sergiu', null, null),
       (13, 'Mihalache', 'Ion', null, null),
       (5, 'Chistol', 'Marius', 3, 4),
       (12, 'Babuta', 'Angela', null, null),
       (6, 'Dodu', 'Mircea', null, null),
       (7, 'Chistol', 'Emilia', 3, 4),
       (8, 'Mihalache', 'Mihai', 2, 13),
       (9, 'Dosoftei', 'Sorina', 2, 13),
       (10, 'Dodu', 'Iana', 9, 6),
       (17, 'Babuta', 'Sergiu', null, null),
       (11, 'Babuta', 'Dorina', 12, 17),
       (15, 'Dragan', 'Vasile', null, null),
       (19, 'Fisttc', 'Andrei', null, null),
       (20, 'Fistic', 'Vadim', 9, 19),
       (21, 'Babuta', 'Ana', 9, 17),
       (14, 'Babuta', 'Sofia', 9, 17),
       (18, 'Dragan', 'Laurentiu', 7, 15);


insert into ev_period_shem1.persons (id, name, age)
values (1, 'Elvi', 19),
       (2, 'Farouk', 19),
       (3, 'Sam', 19),
       (4, 'Tiany', 19),
       (5, 'Nadia', 14),
       (6, 'Chris', 12),
       (7, 'Kris', 10),
       (8, 'Bethany', 16),
       (9, 'Louis', 17),
       (10, 'Austin', 22),
       (11, 'Gabriel', 21),
       (12, 'Jessica', 20),
       (13, 'John', 16),
       (14, 'Alfred', 19),
       (15, 'Samantha', 17),
       (16, 'Craig', 17);

insert into ev_period_shem1.friends
values (1, 2),
       (1, 3),
       (2, 4),
       (2, 6),
       (3, 9),
       (4, 9),
       (7, 5),
       (5, 8),
       (6, 10),
       (13, 6),
       (7, 6),
       (8, 7),
       (9, 11),
       (12, 9),
       (10, 15),
       (12, 11),
       (12, 15),
       (13, 16),
       (15, 13),
       (16, 14);

insert into ev_period_shem1.rude
values (4, 6),
       (2, 4),
       (9, 7),
       (7, 8),
       (11, 9),
       (13, 10),
       (14, 5),
       (12, 13);

# 1. Să se formuleze o interogare care ar afișa toate perechile de două persoane și gradul lor de rudenie
#    (nu sunt rude – 0; rude de gradul de gradul I – 1; rude de gradul II (ruda rudei) – 2).
#    Perechile de rude nu trebuie să se repete (5 p.).

select *,
       (select id
        from ev_period_shem1.persons p
            inner join ev_period_shem1.rude r on r.first_person_id = p1.id or r.second_person_id = p1.id
        where p.id = p1.id
       )
from ev_period_shem1.persons p1
         inner join persons p2 on p2.id <> p1.id;

# 2. Să se formuleze o interogare care ar afișa persoana cu cele mai multe rude, împreună cu toate rudele.
#    Rezultatul trebuie să conțină două câmpuri: în primul câmp este numele persoanei cu cele mai multe rude,
#    în al doilea câmp vor fi numele rudelor pe linii. Pot fi câteva persoane cu număr maxim de rude (5 p.).

select persons.name, if(persons.id <> r.first_person_id, first_person_id, second_person_id) as rude
from persons
         inner join rude r on persons.id = r.first_person_id or persons.id = r.second_person_id
where id in (
    select id
    from persons
             left join rude r on persons.id = r.first_person_id or persons.id = r.second_person_id
    group by id
    having count(id) = (select count(*)
                        from persons
                                 left join rude r on persons.id = r.first_person_id or persons.id = r.second_person_id
                        group by id
                        order by count(*) desc
                        limit 1)
);

# 3. Să se afișeze lista tuturor persoanelor, împreună cu părinții: numele mamei și a tătălui.
#    Dacă numele părinților nu se cunoaște să se afișeze null (5 p.).

select p.id,
       concat(p.name, ' ', p.surname)   as person,
       concat(p2.name, ' ', p2.surname) as mom,
       concat(p3.name, ' ', p3.surname) as dad
from ev_period_shem2.persons p
         left join ev_period_shem2.persons p2 on p2.id = p.mom
         left join ev_period_shem2.persons p3 on p3.id = p.dad;

# 4. Să se definească o funcție care returnează true dacă două persoane au aceeași părinți.
#    Funcția preia id-urile a două persoane și returnează true sau false (5 p.).

delimiter $$
create or replace function isRude(person_one int unsigned, person_two int unsigned)
    returns bool
begin
    declare result bool;

    select count(*) > 0
    into result
    from ev_period_shem2.persons p
             inner join ev_period_shem2.persons p2 on (p.mom = p2.mom or p.dad = p2.dad) and p2.id = person_two
    where p.id = person_one;

    return result;
end $$

delimiter ;

select isRude(21, 20);

# 5. Să se definească o funcție care ar verifica dacă un părinte are copii de la diferite căsătorii.
#    Funcția preia id-ul persoanei și returnează numărul de copii de la fiecare căsătorie
#    (se va afișa soțul/soția și numărul de copii) (5 p.).

delimiter $$
create or replace procedure childrenFromDiffMarriages(person_id int unsigned) # функция не может вернуть несколько значений,
# тут либо процедура либо я не понял задачу
#     returns varchar(200)
begin
    #     declare marriage varchar(200);

    select concat(concat(concat(p.name, ' ', p.surname), '/', concat(p3.name, ' ', p3.surname)), ' = ', count(p2.id))
#     into marriage
    from ev_period_shem2.persons p
             inner join ev_period_shem2.persons p2 on p.id = p2.dad
             inner join ev_period_shem2.persons p3 on p2.mom = p3.id
    where p.id = person_id
    group by p3.name;

#     return marriage;
end $$

delimiter ;

# select childrenFromDiffMarriages(17);
call childrenFromDiffMarriages(17);

# 6. Să se elaboreze o procedură care ar afișa lista tuturor rudelor unei persoane. Procedura va primi ca parametru
#    de intrare idul persoanei și va afișa lista persoanelor înrudite cu această persoană (5 p.).

delimiter $$
create or replace procedure rudeList(in person_id int unsigned)
begin
    select *
    from ev_period_shem2.persons p
             inner join ev_period_shem2.persons p2 on p.mom = p2.id or p.dad = p2.id
    where p.id = person_id;

end $$
delimiter ;

call rudeList(2);

# 7. Să se elaboreze o procedură care verifică dacă o persoană este descendent/urmaș al altei persoane.
#    Procedura va returna 1 dacă prima persoană transmisă ca parametru este urmaș al celei de-a doua persoană dată
#    ca parametru. În caz contrar va returna 0. Parametrii de intrare sunt două id-uri (5 p.).

delimiter $$
create or replace procedure isDescendant(in descendant_id int unsigned, in person_id int unsigned)
begin
    select count(p.id) > 0
    from ev_period_shem2.persons p
             left join ev_period_shem2.persons p2 on p.mom = p2.id or p.dad = p2.id
             left join ev_period_shem2.persons p3 on p2.mom = p3.id or p2.dad = p3.id
    where p.id = descendant_id
      and (p.mom = person_id or p.dad = person_id or p2.mom = person_id or p2.dad = person_id or p3.mom = person_id or
           p3.dad = person_id);

end $$
delimiter ;

call isDescendant(21, 16);