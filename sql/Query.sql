-- Query #1
--Saber cuantas mujeres ganaron medallas de oro donde están ordenadas de la más joven a la más vieja.

SELECT *
FROM Atleta
INNER JOIN Medalla
ON Atleta.idOlimpicoA = Medalla.idOlimpicoA
where Atleta.Genero='F' and Medalla.Lugar=1
ORDER BY Atleta.FechaNacimiento desc;

--Query #2
--¿Cuál es la disciplina con más atletas participando y de que pais proviene la mayoría de estos atletas?

SELECT 
    Disciplina.nombre AS Disciplina,
    COUNT(Atleta.idOlimpicoA) AS TotalAtletas,
    Pais.Nombre AS PaisMayorParticipacion
FROM 
    Atleta
INNER JOIN Pais
    ON Pais.TRICLAVE = Atleta.TRICLAVE
INNER JOIN TrabajarAtleta
    ON Atleta.idOlimpicoA = TrabajarAtleta.IdOlimpicoA
INNER JOIN Disciplina
    ON Disciplina.idDisciplina = TrabajarAtleta.IdDisciplina
GROUP BY 
    Disciplina.nombre, Pais.Nombre
ORDER BY 
    TotalAtletas DESC
LIMIT 1;

--Query #3
--nombre de los entrenadores entrenaron a los atletas con medallas olímpicas y cuantas medallas ganaron los atletas

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
-- Los Atletas que hayan ganado alguna medalla y cuyo país sea México, Birmania o Venezuela.

select distinct  a.nombre, a.apellidopaterno, a.apellidomaterno, p.nombre 
from atleta a 
inner join medalla m 
	on a.idolimpicoa = m.idolimpicoa 
inner join pais p 
	on a.triclave = p.triclave
where p.nombre = 'México' or p.nombre = 'Birmania' or p.nombre = 'Venezuela'

--Query #9
-- ¿Cual fue la disciplina en la que mas medallas se obtuvieron?
SELECT d.nombre AS disciplina, COUNT(m.idmedalla) AS total_medallas
FROM medalla m
JOIN disciplina d ON m.iddisciplina = d.iddisciplina
GROUP BY d.nombre
ORDER BY total_medallas DESC
LIMIT 1;
