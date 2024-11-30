-- Query #1
drop table if exists disa;
create temporary table if not exists disa as
select a.idolimpicoa, a.nombre as nombrea, a.apellidopaterno as apellidoa, t.iddisciplina as disa
from atleta a
natural join trabajaratleta t;

drop table if exists dise;
create temporary table if not exists dise as
select e.idolimpicoe, e.nombre as nombree, e.apellidopaterno as apellidoe, t.iddisciplina as dise
from entrenador e
natural join trabajaratleta t;

drop table if exists res;
create temporary table if not exists res as
select * 
from disa da
join dise de on da.disa = de.dise and da.apellidoa = de.apellidoe;

select r.idolimpicoa as id, r.nombrea as nombre,r.apellidoa as paterno  
from res r
union 
select r.idolimpicoe as id, r.nombree as nombre, r.apellidoe as paterno
from res r
order by paterno;

-- Query #2
select * from evento where precioinic > '2500.00' order by precioinic 

-- Query #3
select a.idolimpicoa as atleta, a.nombre, a.apellidopaterno, count(*) as disciplinas 
from trabajaratleta p 
join atleta a on p.idolimpicoa = a.idolimpicoa
join disciplina e on p.iddisciplina = e.iddisciplina 
group by a.idolimpicoa
having count(*) > 1; 

--Query #4
drop table if exists eventoe;
create temporary table if not exists eventoe as
select e.idolimpicoe, e.triclave as paise, e.nombre as nombreE, e.apellidopaterno as apellidopaternoE , p.idevento as eventoe
from entrenador e
natural join participarentrenador p;

drop table if exists eventoj;
create temporary table if not exists eventoj as
select j.idolimpicoj, j.triclave as paisj, j.nombre as nombreJ, j.apellidopaterno as apellidopaternoJ, p.idevento as eventoj
from juez j
natural join participarjuez p;

drop table if exists diff;
create temporary table if not exists diff as
select * 
from eventoe e
join eventoj j on e.eventoe != j.eventoj and e.paise = j.paisj;

select d.idolimpicoe as id, d.nombree as nombre, d.paise as pais, d.eventoe as evento
from diff d
union
select  d.idolimpicoj as id, d.nombrej as nombre, d.paisj as pais, d.eventoj as evento
from diff d;

--Query #5
select patrocinador from patrocinador
group by patrocinador 
having count(*) < 2;

--Query #6
select count(*) as medallasOro 
from medalla m 
join atleta a on m.idolimpicoa = a.idolimpicoa
where a.triclave = 'MEX' and m.lugar = 1;

--Query #7
select count(*) as medallasPlata 
from medalla m 
join atleta a on m.idolimpicoa = a.idolimpicoa
where a.triclave = 'JPN' and m.lugar = 2 ;

--Query #8
select count(*) as medallasBronce 
from medalla m 
join atleta a on m.idolimpicoa = a.idolimpicoa
where a.triclave = 'ESP' and m.lugar = 3;

--Query #9 
select a.idolimpicoa as idatleta, a.idolimpicoe as identrenador,a.triclave as pais, 
a.nombre as nombre, a.apellidopaterno as apellido1, a.apellidomaterno as apellido2, 
a.fechanacimiento as cumple, a.genero as genero
from medalla m 
join disciplina d on m.iddisciplina = d.iddisciplina 
join atleta a  on m.idolimpicoa = a.idolimpicoa 
where d.nombre ='halterofilia';

--Query #10
DROP TABLE IF EXISTS Lugar1;
CREATE TEMPORARY TABLE IF NOT EXISTS Lugar1 AS
SELECT m.idolimpicoa, SUM(m.lugar) AS Oro
FROM Medalla m 
WHERE m.lugar = 1 
GROUP BY m.idolimpicoa;

DROP TABLE IF EXISTS Lugar2;
CREATE TEMPORARY TABLE IF NOT EXISTS Lugar2 AS
SELECT m.idolimpicoa, SUM(m.lugar) AS Plata
FROM Medalla m 
WHERE m.lugar = 2
GROUP BY m.idolimpicoa;

DROP TABLE IF EXISTS Lugar3;
CREATE TEMPORARY TABLE IF NOT EXISTS Lugar3 AS
SELECT m.idolimpicoa, SUM(m.lugar) AS Bronce
FROM Medalla m 
WHERE m.lugar = 3
GROUP BY m.idolimpicoa;

SELECT a.idolimpicoa, a.idolimpicoe, a.triclave, a.nombre, a.apellidopaterno, a.apellidomaterno, a.fechanacimiento, a.genero, COALESCE(l1.oro, 0) as oro, COALESCE(l2.plata, 0) as plata, COALESCE(l3.bronce, 0) as bronce FROM Atleta a 
LEFT JOIN Lugar1 l1 ON a.idolimpicoa = l1.idolimpicoa
LEFT JOIN Lugar2 l2 ON a.idolimpicoa = l2.idolimpicoa
LEFT JOIN Lugar3 l3 ON a.idolimpicoa = l3.idolimpicoa
where l1.oro != 0 or l2.plata != 0 or l3.bronce != 0
order by l1.oro desc nulls last,l2.plata desc nulls last,l3.bronce desc nulls last;

--Query #11: Obtener la cantidad de participantes de cada disciplina
drop table if exists mas_participantes;
create temporary table if not exists mas_participantes as
select p.idevento, COUNT(p.idolimpicoa) as num_participantes
from participaratleta p
group by p.idevento
order by count(p.idolimpicoa) desc

select d.nombre, d.categoria, m.num_participantes
from mas_participantes m 
join evento e on m.idevento = e.idevento 
join disciplina d on d.iddisciplina = e.iddisciplina
group by  m.num_participantes, d.nombre, d.categoria
order by m.num_participantes desc 

--Query #12: Las medallas que cada pais obtuvo
 -- Ocupamos las tablas temporales Lugar 1, Lugar 2 y Lugar 3 para esta query

select p.nombre, COALESCE(l1.oro, 0) as oro, COALESCE(l2.plata, 0) as plata, COALESCE(l3.bronce, 0) as bronce
from pais p join atleta a on p.triclave = a.triclave 
LEFT JOIN Lugar1 l1 ON a.idolimpicoa = l1.idolimpicoa
LEFT JOIN Lugar2 l2 ON a.idolimpicoa = l2.idolimpicoa
LEFT JOIN Lugar3 l3 ON a.idolimpicoa = l3.idolimpicoa
order by oro desc, plata desc, bronce desc;

--Query #13: Paises que ganaron la disciplina
select Pais.nombre, Disciplina.nombre 
from disciplina inner join medalla  
on Disciplina.iddisciplina = Medalla.iddisciplina 
inner join atleta 
on Atleta.idolimpicoa = Medalla.idolimpicoa
inner join pais 
on Atleta.triclave = Pais.triclave
