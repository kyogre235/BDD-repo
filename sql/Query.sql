

select * from atleta
where nombre ~ '^R'

select * from entrenador
where extract (month from fechanacimiento) < 6;

select * from evento
where fecha >= '2024-01-01' AND fecha <= '2024-04-14';

select * from localidad
where aforo > 400;

select distinct patrocinador from patrocinador
