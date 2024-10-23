-- Querys Practica07

-- Selecciona todos los renglones de atleta que cumplan que su nombre empiece con R o r.
select * from atleta
where nombre ~ '^R'

-- Selecciona todos los renglones de entrenador cuyo mes de su fecha de nacimiento sea el 6 (E,F,M,A,M,Junio).
select * from entrenador
where extract (month from fechanacimiento) = 6;

-- Selecciona todos los renglones de evento tal que sean mayores o iguales al 1-enero-2024 pero menores o iguales al 14-abril-2024.
select * from evento
where fecha >= '2024-01-01' AND fecha <= '2024-04-14';

-- Selecciona todos los renglones de localidad tal que su aforo es mayor a 400.
select * from localidad
where aforo > 400;

-- Selecciona todos los diferentes patrocinadores registrados en patrocinador y muestra solo el nombre.
select distinct patrocinador from patrocinador
