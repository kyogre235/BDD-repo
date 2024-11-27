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