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
WHERE Juez.TRICLAVE = 'USA' OR Juez.TRICLAVE = 'EGY' OR Juez.TRICLAVE = 'JPN' OR Juez.TRICLAVE = 'FRA' OR Juez.TRICLAVE = 'SVK' 

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
WHERE Juez.TRICLAVE = 'USA' OR Juez.TRICLAVE = 'EGY' OR Juez.TRICLAVE = 'JPN' OR Juez.TRICLAVE = 'FRA' OR Juez.TRICLAVE = 'SVK' 
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
