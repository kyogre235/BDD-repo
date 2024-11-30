--Query1
/*
Obtener la información de las atletas mujeres que ganaron medallas de oro ordenadas por su edad, de la más joven a la
más vieja.
*/
SELECT *
FROM Atleta
INNER JOIN Medalla
    ON Atleta.idOlimpicoA = Medalla.idOlimpicoA
WHERE Atleta.Genero = 'F'
ORDER BY Atleta.FechaNacimiento DESC;

--Query2
/*
Ordena las disciplinas, de acuerdo a la que tiene más atletas participando hasta la que tenga el menor número de
atletas, mostrando este número y de que país proviene la mayoría de estos atletas.
*/
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

--Query3
/*
Nombre de los entrenadores que trabajaron con los atletas que ganaron medallas olímpicas y cuantas medallas ganaron
esos atletas.
*/
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

--Query4
/*
Obtener solo el identificador y nombre de la disciplina donde dos o más Atletas han ganado medallas y compartan
nacionalidad, mostrando solo el identificador de los atletas y la TRICLAVE del País al que representan.
*/
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

--Query5
/*
Toda la información de los jueces (sin teléfono, ni email) que hayan nacido después de 1999, y compartan disciplina
(mostrando su identificador), pero no nacionalidad con algún Atleta o Entrenador, mostrando solo el identificador de
los atletas o entrenadores, ordenados por el identificador del Juez.
*/
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

--Query6
/*
Las formas de contacto (email o teléfono) de jueces que representan a los países de Estados Unidos ('USA') o
Egipto ('EGY') o Japón ('JPN') o Eslovaquia ('SVK'), y mostrar el nombre, apellido paterno y materno, nacionalidad y
disciplina en la que trabaja. Ordenado primero por la TRICLAVE y después por el identificador del juez.
*/
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
WHERE Juez.TRICLAVE IN ('USA', 'EGY', 'JPN', 'FRA', 'SVK')

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
WHERE Juez.TRICLAVE IN ('USA', 'EGY', 'JPN', 'FRA', 'SVK')
ORDER BY Pais ASC, IdJuez DESC;

--Query7
/*
Todos los eventos (sus identificadores, fechas, duracion) que se lleven acabo en localidades en China, Estados Unidos
o Indonesia
*/
SELECT 
    e.IdEvento,
    e.Fecha,
    e.DuracionMax,
    l.Ciudad,
    l.Pais 
FROM Evento e
INNER JOIN Disciplina d 
	ON e.IdDisciplina = d.IdDisciplina
INNER JOIN Localidad l 
	ON d.IdLocalidad = l.IdLocalidad
WHERE l.Pais IN ('China', 'United States', 'Indonesia')
ORDER BY l.Pais;

--Query8
/*
Todos los atletas que tengan mas de 1 teléfono y 1 correo electrónico registrado, ordenados por su nombre completo.
*/
SELECT
    a.IdOlimpicoA,
    a.nombre,
    a.ApellidoPaterno,
    a.ApellidoMaterno,
    COUNT(DISTINCT t.Telefono) AS telefonos,
    COUNT(DISTINCT e.Email) AS emails 
FROM Atleta a  
INNER JOIN Emailatleta e 
	ON a.IdOlimpicoA = e.IdOlimpicoA 
INNER JOIN Telefonoatleta t 
	ON a.IdOlimpicoA = t.IdOlimpicoA
GROUP BY a.IdOlimpicoA, a.Nombre, a.ApellidoPaterno, a.ApellidoMaterno
HAVING COUNT(DISTINCT t.Telefono) > 1 AND COUNT(DISTINCT e.Email) > 1
ORDER BY a.Nombre, a.ApellidoPaterno, a.ApellidoMaterno;

--Query9
/*
Todos los Usuarios que visitaron al menos un evento que se llevo acabo en una localidad sin techo.
*/
SELECT DISTINCT 
    u.IdUsuario
FROM Usuario u 
INNER JOIN Visitar v 
	ON u.IdUsuario = v.IdUsuario 
INNER JOIN Evento e 
	ON v.IdEvento = e.IdEvento 
INNER JOIN Disciplina d 
	ON e.IdDisciplina = d.IdDisciplina
INNER JOIN Localidad l 
	ON d.IdLocalidad = l.IdLocalidad 
WHERE l.Tipo = 'sin techo'
ORDER BY u.IdUsuario;

--Query10
/*
El nombre de todos los Atletas que recibieron medallas ordenados por país.
*/
SELECT DISTINCT 
    a.Nombre,
    a.ApellidoPaterno,
    a.ApellidoMaterno,
    p.Nombre 
FROM Atleta a 
INNER JOIN Medalla m 
	ON a.IdOlimpicoA = m.IdOlimpicoA 
INNER JOIN Pais p 
	ON a.TRICLAVE = p.TRICLAVE 
ORDER BY p.Nombre 

--Query11
/*
Identificador de los atletas que participaron en las disciplinas de tiro con arco o lanzamiento de bola y los jueces
que están en la misma disciplina, ordenados por el identificador del atleta de manera descendiente.
*/
SELECT 
    Atleta.IdOlimpicoA,
    Disciplina.nombre,
    Juez.IdOlimpicoJ 
FROM Atleta 
INNER JOIN TrabajarAtleta
    ON Atleta.IdOlimpicoA = TrabajarAtleta.IdOlimpicoA
INNER JOIN Disciplina
    ON TrabajarAtleta.IdDisciplina = Disciplina.IdDisciplina
INNER JOIN TrabajarJuez 
    ON TrabajarJuez.IdDisciplina = Disciplina.IdDisciplina
INNER JOIN Juez
    ON TrabajarJuez.IdOlimpicoJ = Juez.IdOlimpicoJ
WHERE Disciplina.Nombre IN ('tiro con arco','lanzamiento de bola') 
ORDER BY Atleta.IdOlimpicoA DESC;

--Query12 (tupla única)
/*
¿Cual fue la disciplina en la que mas medallas se obtuvieron?
*/
SELECT
    d.Nombre AS disciplina,
    COUNT(m.IdMedalla) AS total_medallas
FROM Medalla m
JOIN Disciplina d
    ON m.IdDisciplina = d.IdDisciplina
GROUP BY d.Nombre
ORDER BY total_medallas DESC
LIMIT 1;

--Query13
/*
Obtiene la cantidad de participantes de cada disciplina.
*/
SELECT
    Pais.Nombre,
    Disciplina.Nombre 
FROM Disciplina 
INNER JOIN Medalla  
    ON Disciplina.IdDisciplina = Medalla.IdDisciplina
INNER JOIN Atleta 
    ON Atleta.IdOlimpicoA = Medalla.IdOlimpicoA
INNER JOIN Pais 
    ON Atleta.TRICLAVE = Pais.TRICLAVE

--Query14
/*
Paises que ganaron la disciplina con oro
*/
DROP TABLE IF EXISTS mas_participantes;
CREATE temporary TABLE IF NOT EXISTS mas_participantes AS
SELECT
    p.IdEvento,
    COUNT(p.IdOlimpicoA) AS num_participantes
FROM ParticiparAtleta p
GROUP BY p.IdEvento
ORDER BY COUNT(p.IdOlimpicoA) DESC;

SELECT
    d.Nombre,
    d.Categoria,
    m.num_participantes
FROM mas_participantes m 
JOIN Evento e
    ON m.IdEvento = e.IdEvento 
JOIN Disciplina d
    ON d.IdDisciplina = e.IdDisciplina
GROUP BY m.num_participantes, d.Nombre, d.Categoria
ORDER BY m.num_participantes DESC;

--Query15
/*
Cantidad de atletas de género masculino y femenino, por país.
*/
DROP TABLE IF EXISTS atleta_masculino;
CREATE TEMPORARY TABLE IF NOT EXISTS atleta_masculino AS
SELECT 
	p.Nombre, 
	p.TRICLAVE, 
	COUNT(a.Genero) AS masculino
FROM Pais p 
JOIN Atleta a
	ON p.TRICLAVE = a.TRICLAVE 
WHERE a.Genero = 'M'
GROUP BY p.Nombre, p.TRICLAVE;

DROP TABLE IF EXISTS atleta_femenino;
CREATE TEMPORARY TABLE IF NOT EXISTS atleta_femenino AS
SELECT 
	p.Nombre, 
	p.TRICLAVE, 
	COUNT(a.Genero) AS masculino
FROM Pais p 
JOIN Atleta a
	ON p.TRICLAVE = a.TRICLAVE 
WHERE a.Genero = 'F'
GROUP BY p.Nombre, p.TRICLAVE;

SELECT 
	p.nombre AS Pais, 
	COALESCE(f.femenino, 0) AS Femeninos, 
	COALESCE(m.masculino, 0) AS Masculino
FROM Pais p
LEFT JOIN atleta_masculino m
	ON p.TRICLAVE = m.TRICLAVE
LEFT JOIN atleta_femenino f
	ON p.TRICLAVE = f.TRICLAVE
ORDER BY Femeninos DESC, Masculino DESC;
