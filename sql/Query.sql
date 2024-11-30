--Query : Obtener la cantidad de participantes de cada disciplina
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

--Query : Las medallas que cada pais obtuvo
 -- Ocupamos las tablas temporales Lugar 1, Lugar 2 y Lugar 3 para esta query

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

select p.nombre, COALESCE(l1.oro, 0) as oro, COALESCE(l2.plata, 0) as plata, COALESCE(l3.bronce, 0) as bronce
from pais p join atleta a on p.triclave = a.triclave 
LEFT JOIN Lugar1 l1 ON a.idolimpicoa = l1.idolimpicoa
LEFT JOIN Lugar2 l2 ON a.idolimpicoa = l2.idolimpicoa
LEFT JOIN Lugar3 l3 ON a.idolimpicoa = l3.idolimpicoa
order by oro desc, plata desc, bronce desc;

--Query : Paises que ganaron la disciplina
select Pais.nombre, Disciplina.nombre 
from disciplina inner join medalla  
on Disciplina.iddisciplina = Medalla.iddisciplina 
inner join atleta 
on Atleta.idolimpicoa = Medalla.idolimpicoa
inner join pais 
on Atleta.triclave = Pais.triclave
