--EMMA1
SELECT *
FROM Atleta
INNER JOIN Medalla
    ON Atleta.idOlimpicoA = Medalla.idOlimpicoA
WHERE Atleta.Genero = 'F'
ORDER BY Atleta.FechaNacimiento desc;

--EMMA2
SELECT
    Disciplina.nombre AS Disiciplina,
    COUNT(Atleta.idOlimpicoA) AS TotalAtletas,
    Pais.Nombre AS PaisMayorParticipacion
FROM Atleta
INNER JOIN Pais
    ON Pais.TRICLAVE = Atleta.TRICLAVE
INNER JOIN TrabajarAtleta
    ON Atleta.idOlimpicoA = TrabajarAtleta.idOlimpicoA
INNER JOIN Disciplina
    ON Disciplina.idDisciplina = TrabajarAtleta.idDisciplina
GROUP BY Disciplina.nombre, Pais.Nombre
ORDER BY TotalAtletas DESC;

--EMMA3
SELECT 
    Entrenador.Nombre, 
    Entrenador.ApellidoPaterno, 
    Entrenador.ApellidoMaterno, 
    COUNT(Medalla.Lugar) AS TotalMedallas
FROM Atleta
INNER JOIN Entrenador
    ON Entrenador.idOlimpicoE = Atleta.idOlimpicoE
INNER JOIN Medalla
    ON Medalla.idOlimpicoA= Atleta.idOlimpicoA
WHERE Medalla.Lugar = 1
GROUP BY Entrenador.idOlimpicoE
ORDER BY TotalMedallas DESC;

--ISAAC1
SELECT 
    Disciplina.Nombre AS Disciplina,
    Disciplina.IdDisciplina,
    Atleta1.IdOlimpicoA AS IdOlimpicoAtleta1,
    Atleta2.IdOlimpicoA AS IdOlimpicoAtleta2,
    Atleta1.TRICLAVE AS TRICLAVE        
FROM Disciplina
INNER JOIN TrabajarAtleta
    ON Disciplina.IdDisciplina = TrabajarAtleta.IdDisciplina
INNER JOIN Atleta AS Atleta1
    ON Atleta1.IdOlimpicoA = TrabajarAtleta.IdOlimpicoA
INNER JOIN Medalla AS Medalla1
    ON Atleta1.IdOlimpicoA = Medalla1.IdOlimpicoA
INNER JOIN Atleta AS Atleta2
    ON Atleta1.TRICLAVE = Atleta2.TRICLAVE AND Atleta1.IdOlimpicoA > Atleta2.IdOlimpicoA
INNER JOIN Medalla AS Medalla2
    ON Atleta2.IdOlimpicoA = Medalla2.IdOlimpicoA;
   
--ISAAC2
SELECT 
    TrabajarAtleta.IdDisciplina AS Disciplina,
    Atleta.IdOlimpicoA AS IdOlimpicoAE,
    Juez.TRICLAVE,
    Juez.IdOlimpicoJ,
    Juez.Nombre,
    Juez.ApellidoPaterno,
    Juez.ApellidoMaterno,
    Juez.Genero,
    Juez.FechaNacimiento
FROM Juez
INNER JOIN TrabajarJuez
    ON Juez.IdOlimpicoJ = TrabajarJuez.IdOlimpicoJ
INNER JOIN TrabajarAtleta
    ON TrabajarJuez.IdDisciplina = TrabajarAtleta.IdDisciplina
INNER JOIN Atleta
    ON TrabajarAtleta.IdOlimpicoA = Atleta.IdOlimpicoA
WHERE NOT Juez.TRICLAVE = Atleta.TRICLAVE AND Juez.FechaNacimiento > '1999-12-31'  

UNION

SELECT 
    TrabajarEntrenador.IdDisciplina AS Disciplina,
    Entrenador.IdOlimpicoE AS IdOlimpicoAE,
    Juez.TRICLAVE,
    Juez.IdOlimpicoJ,
    Juez.Nombre,
    Juez.ApellidoPaterno,
    Juez.ApellidoMaterno,
    Juez.Genero,
    Juez.FechaNacimiento
FROM Juez
INNER JOIN TrabajarJuez
    ON Juez.IdOlimpicoJ = TrabajarJuez.IdOlimpicoJ
INNER JOIN TrabajarEntrenador
    ON TrabajarJuez.IdDisciplina = TrabajarEntrenador.IdDisciplina
INNER JOIN Entrenador
    ON TrabajarEntrenador.IdOlimpicoE = Entrenador.IdOlimpicoE
WHERE NOT Juez.TRICLAVE = Entrenador.TRICLAVE AND Juez.FechaNacimiento > '1999-12-31'
ORDER BY IdOlimpicoJ ASC;

--ISAAC3
SELECT 
    TelefonoJuez.Telefono AS Contacto,
    Juez.IdOlimpicoJ AS IdJuez,
    Juez.TRICLAVE AS Pais,
    Juez.Nombre,
    Juez.ApellidoPaterno,
    Juez.ApellidoMaterno,
    Evento.IdDisciplina AS Disciplina
FROM Juez
INNER JOIN ParticiparJuez
    ON Juez.IdOlimpicoJ = ParticiparJuez.IdOlimpicoJ
INNER JOIN Evento
    ON Evento.IdEvento = ParticiparJuez.IdEvento
INNER JOIN TelefonoJuez
    ON Juez.IdOlimpicoJ = TelefonoJuez.IdOlimpicoJ
INNER JOIN EmailJuez
	ON Juez.IdOlimpicoJ = EmailJuez.IdOlimpicoJ
WHERE Juez.TRICLAVE in ('USA', 'EGY', 'JPN', 'FRA', 'SVK')

UNION

SELECT 
    EmailJuez.Email AS Contacto,
    Juez.IdOlimpicoJ AS IdJuez,
    Juez.TRICLAVE AS Pais,
    Juez.Nombre,
    Juez.ApellidoPaterno,
    Juez.ApellidoMaterno,
    Evento.IdDisciplina AS Disciplina
FROM Juez
INNER JOIN ParticiparJuez
    ON Juez.IdOlimpicoJ = ParticiparJuez.IdOlimpicoJ
INNER JOIN Evento
    ON Evento.IdEvento = ParticiparJuez.IdEvento
INNER JOIN EmailJuez
	ON Juez.IdOlimpicoJ = EmailJuez.IdOlimpicoJ
WHERE Juez.TRICLAVE in ('USA', 'EGY', 'JPN', 'FRA', 'SVK')
ORDER BY Pais ASC, IdJuez DESC;

select Entrenador.Nombre,Entrenador.ApellidoPaterno,Entrenador.ApellidoMaterno,count(Medalla.Lugar) as TotalMedallas
from atleta
inner join Entrenador
	on Entrenador.idOlimpicoE = Atleta.idOlimpicoE
inner join Medalla
	on Medalla.idOlimpicoA = Atleta.idOlimpicoA
where Medalla.Lugar = 1
group by Entrenador.idolimpicoe 
order by TotalMedallas desc;

--Query #4
--Todos los eventos (sus identificadores) que se lleven acabo en localidades en China, Estados Unidos o Indonesia

SELECT e.idevento , e.fecha , e.duracionmax, l.ciudad ,l.pais 
FROM evento e
inner join disciplina d 
	on e.iddisciplina = d.iddisciplina
inner join localidad l 
	on d.idlocalidad = l.idlocalidad
where l.pais = 'China' or l.pais = 'United States' or l.pais = 'Indonesia'
order by l.pais;

--Query #5
--Todos los atletas que tengan mas de 1 teléfono y 1 correo electrónico registrado

select a.idolimpicoa , a.nombre , a.apellidopaterno, a.apellidomaterno, count(distinct t.telefono) as telefonos, count(distinct e.email) as emails 
from atleta a  
inner join emailatleta e 
	on a.idolimpicoa = e.idolimpicoa 
inner join telefonoatleta t 
	on a.idolimpicoa = t.idolimpicoa
group by a.idolimpicoa, a.nombre, a.apellidopaterno, a.apellidomaterno
having count(distinct t.telefono) > 1 and count(distinct e.email) > 1
order by a.nombre, a.apellidopaterno, a.apellidomaterno;

--Query #6
--Todos los Usuarios que visitaron un evento que se llevo acabo en una localidad sin techo.

select distinct u.idusuario
from usuario u 
inner join visitar v 
	on u.idusuario = v.idusuario 
inner join evento e 
	on v.idevento = e.idevento 
inner join disciplina d 
	on e.iddisciplina = d.iddisciplina
inner join localidad l 
	on d.idlocalidad = l.idlocalidad 
where l.tipo = 'sin techo'
order by u.idusuario; 

-- Comas
--Query #7 
-- El nombre (completo) de todos los Atletas que recibieron medallas ordenados por país.

select distinct  a.nombre, a.apellidopaterno, a.apellidomaterno, p.nombre 
from atleta a 
inner join medalla m 
	on a.idolimpicoa = m.idolimpicoa 
inner join pais p 
	on a.triclave = p.triclave 
order by p.nombre 

--Query #8
/*
Identificador de los atletas que participaron en las disciplinas de tiro con arco o lanzamiento de bola y los jueces que estan en la misma disciplina
ordenados por el identificador del atleta de manera descendiente.
*/

select Atleta.idolimpicoa, Disciplina.nombre, Juez.idolimpicoj 
from atleta 
inner join trabajaratleta  on Atleta.idolimpicoa = trabajaratleta.idolimpicoa
inner join disciplina  on Trabajaratleta.iddisciplina = Disciplina.iddisciplina
inner join trabajarjuez on Trabajarjuez.iddisciplina = Disciplina.iddisciplina
inner join Juez on trabajarjuez.idolimpicoj = juez.idolimpicoj
where disciplina.nombre in ('tiro con arco','lanzamiento de bola') 
order by Atleta.idolimpicoa desc;

--Query #9
-- ¿Cual fue la disciplina en la que mas medallas se obtuvieron?
SELECT d.nombre AS disciplina, COUNT(m.idmedalla) AS total_medallas
FROM medalla m
JOIN disciplina d ON m.iddisciplina = d.iddisciplina
GROUP BY d.nombre
ORDER BY total_medallas DESC
LIMIT 1;

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
