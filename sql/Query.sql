-- Query #1
-- Query #2
select * from evento where precioinic > '2500.00' order by precioinic 
-- Query #3
select a.idolimpicoa as atleta, a.nombre, a.apellidopaterno
from participaratleta p 
join atleta a on p.idolimpicoa = a.idolimpicoa
join evento e on p.idevento = e.idevento 
group by a.idolimpicoa
having count(*) > 1; 
--Query #4
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
where d.nombre ='halterofilia'
--Query #10


select  *
