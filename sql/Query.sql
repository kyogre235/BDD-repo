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

