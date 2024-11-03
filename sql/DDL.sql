--DROP SCHEMA IF EXISTS public CASCADE;
--CREATE SCHEMA public;

create table IF NOT exists Localidad (
	IdLocalidad bigint,
	Nombre varchar(50),
	Tipo varchar(50),
	Calle varchar(50),
	Numero integer,
	Ciudad varchar(50),
	Pais varchar(50),
	Aforo integer
);

alter table Localidad add constraint Localidad_pk primary key (IdLocalidad);
alter table Localidad add constraint Localidad_d1 check(Nombre<>'');
alter table Localidad add constraint Localidad_d2 check(Tipo<>'');
alter table Localidad add constraint Localidad_d3 check(Calle<>'');
alter table Localidad add constraint Localidad_d4 check(Numero>0);
alter table Localidad add constraint Localidad_d5 check(Ciudad<>'');
alter table Localidad add constraint Localidad_d6 check(Pais<>'');
alter table Localidad add constraint Localidad_d7 check(Aforo>0);

comment on table Localidad is 'Tabla que contiene las Localidades en las que se llevarán a cabo los eventos de los JJOO';
comment on column Localidad.idLocalidad is 'Identificador de la Localidad';
comment on column Localidad.Nombre is 'Nombre de la Localidad';
comment on column Localidad.Tipo is 'Tipo de Localidad: Playa, Techado, Estadio, etc';
comment on column LOcalidad.Calle is 'Nombre de la Calle';
comment on column Localidad.Numero is 'Numero de la Calle';
comment on column Localidad.Ciudad is 'Ciudad de la Localidad';
comment on column Localidad.Pais  is 'Pais de la Localidad';
comment on column Localidad.Aforo is 'Cantidad de personas que puede alojar la localidad';
comment on constraint Localidad_pk on Localidad is 'Llave primaria de Localidad';
comment on constraint Localidad_d1 on Localidad is 'Restriccion de no vacio en Nombre';
comment on constraint Localidad_d2 on Localidad is 'Restriccion de no vacio en Tipo';
comment on constraint Localidad_d3 on Localidad is 'Restriccion de no vacio en Calle';
comment on constraint Localidad_d4 on Localidad is 'Restriccion de no numeros negativos en Numero';
comment on constraint Localidad_d5 on Localidad is 'Restriccion de no vacio en Ciudad';
comment on constraint Localidad_d6 on Localidad is 'Restriccion de no vacio en Pais ';
comment on constraint Localidad_d7 on Localidad is 'Restriccion de no numeros negativos en Aforo';


create table if not exists Usuario(
	IdUsuario varchar(45)
);

alter table Usuario add constraint Usuario_pk primary key (IdUsuario);

comment on table Usuario is 'Tabla de Usuarios';
comment on column Usuario.IdUsuario is 'Identificador del Usuario';
comment on constraint Usuario_pk on Usuario is 'Llave primaria de Usuario';


create table if not exists Disciplina (
	IdDisciplina bigint,
	IdLocalidad bigint,
	Categoria varchar(50),
	Nombre varchar(150)
);

alter table Disciplina add constraint Disciplina_pk primary key (IdDisciplina);
alter table Disciplina add constraint Disciplina_d1 check (Categoria<>'');
alter table Disciplina add constraint Disciplina_d2 check (Nombre<>'');
alter table Disciplina add constraint fk_localidad_disciplina foreign key (IdLocalidad) references Localidad(IdLocalidad) on delete restrict on update cascade;

comment on table Disciplina is 'Tabla que contiene las Disciplinas de los JJOO';
comment on column Disciplina.IdDisciplina is 'Identificador de la Disciplina';
comment on column Disciplina.IdLocalidad is 'Llave de la Localidad en la que se llevara acabo la Disciplina';
comment on column Disciplina.Categoria is 'Tipo de categoria de la Disciplina';
comment on column Disciplina.Nombre is 'El Nombre de la categoria';
comment on constraint Disciplina_pk on Disciplina is 'Llave primaria de Disciplina';
comment on constraint Disciplina_d1 on Disciplina is 'Restriccion de no vacio de Categoria';
comment on constraint Disciplina_d2 on Disciplina is 'Restriccion de no vacio de Nombre';
comment on constraint fk_localidad_disciplina on Disciplina is 'Llave foranea por parte de la Localidad (D:Restrict/U:Cascade)';


create table if not exists Evento(
	IdEvento bigint,
	IdDIsciplina bigint,
	Fecha timestamp,
	PrecioInic money,
	DuracionMax time,
	LlaveEliminatoria integer
);

alter table Evento alter column IdDisciplina set not null;
alter table Evento alter column Fecha set not null;
alter table Evento alter column DuracionMax set not null;
alter table Evento add constraint Evento_pk primary key (IdEvento);
alter table Evento add constraint Evento_d1 check(PrecioInic > '0' :: money);
alter table Evento add constraint Evento_d2 check(LlaveEliminatoria > 0);
alter table Evento add constraint fk_disciplina_evento foreign key (IdDisciplina) references Disciplina(IdDisciplina) on delete restrict on update cascade;

comment on table Evento is 'Tabla que contiene los Eventos de los JJOO';
comment on column Evento.IdEvento is 'Identificador del Evento';
comment on column Evento.IdDisciplina is 'Llave de la Disciplina de la cual es el Evento';
comment on column Evento.Fecha is 'La fecha en la que se va llevar acabo el Evento';
comment on column Evento.PrecioInic is 'EL precio inicial de las entradas';
comment on column Evento.DuracionMax is 'La duracion maxima de los eventos';
comment on column Evento.LlaveEliminatoria is 'Las rondas eliminatorias del Evento llevadas a cabo';
comment on constraint Evento_pk on Evento is 'Llave primaria de Evento';
comment on constraint Evento_d1 on Evento is 'Restriccion de no negativo en PrecioInic';
comment on constraint Evento_d2 on Evento is 'Restriccion de no negativo en LlaveEliminatoria';
comment on constraint fk_disciplina_evento on Evento is 'Llave foranea por parte de la Disciplina (D:Restrict/U:Cascade)';


create table if not exists Visitar(
	IdUsuario varchar(45),
	IdEvento bigint
	
);

alter table Visitar alter column IdUsuario set not null;
alter table Visitar alter column IdEvento set not null;
alter table Visitar add constraint fk_usuario_visitar foreign key (IdUsuario) references Usuario(IdUsuario) on delete cascade on update cascade;
alter table Visitar add constraint fk_evento_visitar foreign key  (IdEvento) references Evento(IdEvento) on delete cascade on update cascade;

comment on table Visitar is 'Tabla que contiene a que eventos han asistido los Usuarios';
comment on column Visitar.IdUsuario is 'Llave del Usuario que asistio al evento';
comment on column Visitar.IdEvento is 'Llave del Evento al que asistio el Usuario';
comment on constraint fk_usuario_visitar on Visitar is 'Llave foranea por parte del Usuario (D:Cascade/U:Cascade)';
comment on constraint fk_evento_visitar on Visitar is 'Llave foranea por parte del Evento (D:Cascade/U:Cascade)';


create table if not exists Patrocinador(
	IdDisciplina bigint,
	Patrocinador varchar(50)
);

alter table Patrocinador add constraint fk_Disciplina_patrocinador foreign key (IdDisciplina) references Disciplina(IdDisciplina) on delete cascade on update cascade;
alter table Patrocinador add constraint Patrocinador_pk primary key (IdDisciplina,Patrocinador);

comment on table Patrocinador is 'Tabla que contiene los Patrocinadores de cada Disiplina';
comment on column Patrocinador.IdDisciplina is 'Llave de la Disciplina que es patrocinada';
comment on column Patrocinador.Patrocinador is 'Patrocinador de las Disciplinas';
comment on constraint Patrocinador_pk on Patrocinador is 'Llave primaria de Patrocinador';
comment on constraint fk_Disciplina_Patrocinador on Patrocinador is 'Llave foranea por parte de la Disciplina (D:Cascade/U:Cascade)';

create table if not exists Pais(
	TRICLAVE char(3),
	Nombre varchar(50)
);

alter table Pais add constraint Pais_pk primary key (TRICLAVE);
alter table Pais add constraint Pais_d1 check(char_length(TRICLAVE)=3);
alter table Pais add constraint Pais_d2 check(Nombre<>'');

comment on table Pais is 'Tabla que contiene los paises participanetes de los JJOO';
comment on column Pais.TRICLAVE is 'TRICLAVE del Pais';
comment on column Pais.Nombre is 'Nombre del Pais al que esta relacionado la TRICLAVE';
comment on constraint Pais_pk on Pais is 'Llave primaria de un pais';
comment on constraint Pais_d1 on Pais is 'Restriccion de tamaño de la TRICLAVE ';
comment on constraint Pais_d2 on Pais is 'Restriccion de no vacio de Nombre';


create table if not exists Entrenador(
	IdOlimpicoE bigint,
	Nombre varchar(50),
	ApellidoPaterno varchar(50),
	ApellidoMaterno varchar(50),
	FechaNacimiento date,
	Genero char(1)
);

alter table Entrenador alter column FechaNacimiento set not null;
alter table Entrenador add constraint Entrenador_pk primary key (IdOlimpicoE);
alter table Entrenador add constraint Entrenador_d1 check(Nombre<>'');
alter table Entrenador add constraint Entrenador_d2 check(ApellidoPaterno<>'');
alter table Entrenador add constraint Entrenador_d3 check(ApellidoMaterno<>'');
alter table Entrenador add constraint Entrenador_d4 check(char_length(Genero)=1);
alter table Entrenador add constraint Entrenador_d5 check(Genero in ('F','M'));


comment on table Entrenador is 'Tabla que contiene los de Entrenadores participantes de los JJOO';
comment on column Entrenador.IdOlimpicoE is 'Identificador de Entrenador';
comment on column Entrenador.Nombre is 'Nombre del entrenador';
comment on column Entrenador.ApellidoPaterno is 'Apellido paterno del entrenador';
comment on column Entrenador.ApellidoMaterno is 'Apellido materno del entrenador';
comment on column Entrenador.FechaNacimiento is 'Fecha de nacimiento del entrenador';
comment on column Entrenador.Genero is 'Genero del entrenador';
comment on constraint Entrenador_pk on Entrenador is 'Llave Primaria de Entrenador'; 
comment on constraint Entrenador_d1 on Entrenador is 'Restriccion de no vacio de Nombre';
comment on constraint Entrenador_d2 on Entrenador is 'Restriccion de no vacio de ApellidoPaterno';
comment on constraint Entrenador_d3 on Entrenador is 'Restriccion de no vacio de ApellidoMaterno';
comment on constraint Entrenador_d4 on Entrenador is 'Restriccion de longitud de Genero';
comment on constraint Entrenador_d5 on Entrenador is 'Restriccion de Genero en 2 opciones ';

create table if not exists TelefonoEntrenador(
	IdOlimpicoE bigint,
	Telefono varchar(15)
);

alter table TelefonoEntrenador add constraint TelefonoEntrenador_d1 check(Telefono ~ '^\+?\d{10,15}$');
alter table TelefonoEntrenador add constraint fk_Entrenador_Telefono foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE) on delete cascade on update cascade;
alter table TelefonoEntrenador add constraint TelefonoE_pk primary key (IdOlimpicoE,Telefono);

comment on table TelefonoEntrenador is 'Tabla que contiene los Telefonos de los Entrenadores';
comment on column TelefonoEntrenador.IdOlimpicoE is 'Llave del Entrenador al que pertenece el Telefono';
comment on column TelefonoEntrenador.Telefono is 'Telefonos del Entrenador';
comment on constraint TelefonoE_pk on TelefonoEntrenador is 'Llave primaria de TelefonoEntrenador';
comment on constraint TelefonoEntrenador_d1 on TelefonoEntrenador is 'Restriccion de patron del Telefono';
comment on constraint fk_Entrenador_Telefono on TelefonoEntrenador is 'Llave foranea por parte de Entrenador (D:Cascade/U:Cascade)';


create table if not exists EmailEntrenador(
	IdOlimpicoE bigint,
	Email varchar(30)
);

alter table EmailEntrenador add constraint EmailEntrenador_d1 check (Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
alter table EmailEntrenador add constraint fk_Entrenador_Email foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE) on delete cascade on update cascade;
alter table EmailEntrenador add constraint EmailE_pk primary key (IdOlimpicoE,Email);

comment on table EmailEntrenador is 'Tabla que contiene los Emails de los Entrenadores';
comment on column EmailEntrenador.IdOlimpicoE is 'Llave del Entrenador al que pertenece el Email';
comment on column EmailEntrenador.Email is 'Emails del entrenador';
comment on constraint EmailE_pk on EmailEntrenador is 'Llave primaria de EmailEntrenador';
comment on constraint EmailEntrenador_d1 on EmailEntrenador is 'Restriccion de patron del Email';
comment on constraint fk_Entrenador_Email on EmailEntrenador is 'Llave foranea por parte del Entrenador (D:Cascade/U:Cascade)';


create table if not exists Atleta(
	IdOlimpicoA bigint,
	IdOlimpicoE bigint,
	TRICLAVE char(3),
	Nombre varchar(50),
	ApellidoPaterno varchar(50),
	ApellidoMaterno varchar(50),
	FechaNacimiento date,
	Genero char(1)	
);

alter table Atleta alter column IdOlimpicoE set not null;
alter table Atleta alter column FechaNacimiento set not null;
alter table Atleta add constraint Atleta_pk primary key (IdOlimpicoA);
alter table Atleta add constraint Atleta_d1 check(Nombre<>'');
alter table Atleta add constraint Atleta_d2 check(ApellidoPaterno<>'');
alter table Atleta add constraint Atleta_d3 check(ApellidoMaterno<>'');
alter table Atleta add constraint Atleta_d4 check(char_length(Genero)=1);
alter table Atleta add constraint Atleta_d5 check(Genero in ('F','M'));
alter table Atleta add constraint Atleta_d6 check(char_length(TRICLAVE)=3);
alter table Atleta add constraint fk_Entrenador_Atleta foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE) on delete restrict on update cascade;
alter table Atleta add constraint fk_Pais_Atleta foreign key (TRICLAVE) references Pais(TRICLAVE) on delete restrict on update cascade;


comment on table Atleta is 'Tabla que contiene los Atletas participantes de los JJOO';
comment on column Atleta.IdOlimpicoA is 'Identificador del Atleta';
comment on column Atleta.IdOlimpicoE is 'Llave del Entrenador que entrena al Atleta';
comment on column Atleta.TRICLAVE is 'Llave de pais del Atleta';
comment on column Atleta.Nombre is 'Nombre del Atleta';
comment on column Atleta.ApellidoPaterno is 'Apellido paterno del Atleta';
comment on column Atleta.ApellidoMaterno is 'Apellido materno del Atleta';
comment on column Atleta.FechaNacimiento is 'Fecha de nacimiento del Atleta';
comment on column Atleta.Genero is 'Genero del Atleta';
comment on constraint Atleta_pk on Atleta is 'Llave Primaria de Atleta'; 
comment on constraint Atleta_d1 on Atleta is 'Restriccion de no vacio de Nombre';
comment on constraint Atleta_d2 on Atleta is 'Restriccion de no vacio de ApellidoPaterno';
comment on constraint Atleta_d3 on Atleta is 'Restriccion de no vacio de ApellidoMaterno';
comment on constraint Atleta_d4 on Atleta is 'Restriccion de longitud de Genero';
comment on constraint Atleta_d5 on Atleta is 'Restriccion de Genero en 2 opciones';
comment on constraint Atleta_d6 on Atleta is 'Restriccion de longitud en TRICLAVE';
comment on constraint fk_Entrenador_Atleta on Atleta is 'Llave foranea por parte de Entrenador (D:Restrict/U:Cascade)';
comment on constraint fk_Pais_Atleta on Atleta is 'Llave foranea por parte de Pais (D:Restrict/U:Cascade)';

create table if not exists Medalla(
	IdMedalla bigint,
	IdDisciplina bigint,
	IdOlimpicoA bigint,
	Lugar integer
); 

alter table Medalla alter column IdOlimpicoA set not null;
alter table Medalla add constraint Medalla_d1 check(Lugar between 1 and 3);
alter table Medalla add constraint fk_Atleta_Medalla foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA) on delete restrict on update cascade;
alter table Medalla add constraint fk_Atleta_Disciplina foreign key (IdDisciplina) references Disciplina(IdDisciplina) on delete restrict on update cascade;
alter table Medalla add constraint Medalla_pk primary key (IdMedalla,IdDisciplina);

comment on table Medalla is 'Tabla que contiene las Medallas por cada Disciplina';
comment on column Medalla.IdMedalla is 'Identificador de la Medalla';
comment on column Medalla.IdDisciplina is 'Discplina en la que participa el Atleta';
comment on column Medalla.IdOlimpicoA is 'Atleta que gano la medalla';
comment on column Medalla.Lugar is 'Lugar en la categoria de la medalla en la que quedo el Atleta';
comment on constraint Medalla_pk on Medalla is 'Llave primaria de Medalla';
comment on constraint Medalla_d1 on Medalla is 'Restriccion del tipo de medalla';
comment on constraint fk_Atleta_Medalla on Medalla is 'Llave foranea por parte del Atleta (D:Restrict/U:Cascade)';
comment on constraint fk_Atleta_Disciplina on Medalla is 'Llave foranea por parte de la Disciplina (D:Restrict/U:Cascade)';

create table if not exists TelefonoAtleta(
	IdOlimpicoA bigint,
	Telefono varchar(15)
);

alter table TelefonoAtleta add constraint TelefonoAtleta_d1 check(Telefono ~ '^\+?\d{10,15}$');
alter table TelefonoAtleta add constraint fk_Atleta_Telefono foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA) on delete cascade on update cascade;
alter table TelefonoAtleta add constraint TelefonoA_pk primary key (IdOlimpicoA,Telefono);

comment on table TelefonoAtleta is 'Tabla que contiene los Telefonos de los Atletas';
comment on column TelefonoAtleta.IdOlimpicoA is 'Llave del Atleta al que pertenece el Telefono';
comment on column TelefonoAtleta.Telefono is 'Telefonos del Atleta';
comment on constraint TelefonoA_pk on TelefonoAtleta is 'Llave primaria de TelefonoAtleta';
comment on constraint TelefonoAtleta_d1 on TelefonoAtleta is 'Restriccion de patron del telefono';
comment on constraint fk_Atleta_Telefono on TelefonoAtleta is 'Llave foranea por parte del Atleta (D:Cascade/U:Cascade)';


create table if not exists EmailAtleta(
	IdOlimpicoA bigint,
	Email varchar(30)
);

alter table EmailAtleta add constraint EmailAtleta_d1 check (Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
alter table EmailAtleta add constraint fk_Atleta_Email foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA) on delete cascade on update cascade;
alter table EmailAtleta add constraint EmailA_pk primary key (IdOlimpicoA,Email);

comment on table EmailAtleta is 'Tabla que contiene los Emails de los Atletas';
comment on column EmailAtleta.IdOlimpicoA is 'Llave del Atleta al que pertenece el Email';
comment on column EmailAtleta.Email is 'Emails del Atleta';
comment on constraint EmailA_pk on EmailAtleta is 'Llave primaria de EmailAtleta';
comment on constraint EmailAtleta_d1 on EmailAtleta is 'Restriccion de patron del Email';
comment on constraint fk_Atleta_Email on EmailAtleta is 'Llave foranea por parte del Atleta (D:Cascade/U:Cascade)';


create table if not exists Juez(
	IdOlimpicoJ bigint,
	Nombre varchar(50),
	ApellidoPaterno varchar(50),
	ApellidoMaterno varchar(50),
	FechaNacimiento date,
	Genero char(1)
);

alter table Juez alter column FechaNacimiento set not null;
alter table Juez add constraint Juez_pk primary key (IdOlimpicoJ);
alter table Juez add constraint Juez_d1 check(Nombre<>'');
alter table Juez add constraint Juez_d2 check(ApellidoPaterno<>'');
alter table Juez add constraint Juez_d3 check(ApellidoMaterno<>'');
alter table Juez add constraint Juez_d4 check(char_length(Genero)=1);
alter table Juez add constraint Juez_d5 check(Genero in ('F','M'));


comment on table Juez is 'Tabla que contiene a los Jueces participantes de los JJOO';
comment on column Juez.IdOlimpicoJ is 'Llave primaria de los Jueces';
comment on column Juez.Nombre is 'Nombre del Juez';
comment on column Juez.ApellidoPaterno is 'Apellido paterno del Juez';
comment on column Juez.ApellidoMaterno is 'Apellido materno del Juez';
comment on column Juez.FechaNacimiento is 'Fecha de nacimiento del Juez';
comment on column Juez.Genero is 'Genero del Juez';
comment on constraint Juez_pk on Juez is 'Llave Primaria de Juez'; 
comment on constraint Juez_d1 on Juez is 'Restriccion de no vacio de Nombre';
comment on constraint Juez_d2 on Juez is 'Restriccion de no vacio de ApellidoPaterno';
comment on constraint Juez_d3 on Juez is 'Restriccion de no vacio de ApellidoMaterno';
comment on constraint Juez_d4 on Juez is 'Restriccion de longitud de Genero';
comment on constraint Juez_d5 on Juez is 'Restriccion de Genero en 2 opciones ';

create table if not exists TelefonoJuez(
	IdOlimpicoJ bigint,
	Telefono varchar(15)
);

alter table TelefonoJuez add constraint TelefonoJuez_d1 check(Telefono ~ '^\+?\d{10,15}$');
alter table TelefonoJuez add constraint fk_Juez_Telefono foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ) on delete cascade on update cascade;
alter table TelefonoJuez add constraint TelefonoJ_pk primary key (IdOlimpicoJ,Telefono);

comment on table TelefonoJuez is 'Tabla que contiene los Telefonos de los Jueces';
comment on column TelefonoJuez.IdOlimpicoJ is 'Llave del Juez al que pertenece el Telefono';
comment on column TelefonoJuez.Telefono is 'Telefonos del Juez';
comment on constraint TelefonoJ_pk on TelefonoJuez is 'Llave primaria de TelefonoJuez';
comment on constraint TelefonoJuez_d1 on TelefonoJuez is 'Restriccion de patron del Telefono';
comment on constraint fk_Juez_Telefono on TelefonoJuez is 'Llave foranea por parte del Juez (D:Cascade/U:Cascade)';


create table if not exists EmailJuez(
	IdOlimpicoJ bigint,
	Email varchar(30)
);

alter table EmailJuez add constraint EmailJuez_d1 check (Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
alter table EmailJuez add constraint fk_Juez_Email foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ) on delete cascade on update cascade;
alter table EmailJuez add constraint EmailJ_pk primary key (IdOlimpicoJ,Email);

comment on table EmailJuez is 'Tabla que contiene los Emails de los Jueces';
comment on column EmailJuez.IdOlimpicoJ is 'Llave del Juez al que pertenece el Email';
comment on column EmailJuez.Email is 'Emails del Juez';
comment on constraint EmailJ_pk on EmailJuez is 'Llave primaria de EmailJuez';
comment on constraint EmailJuez_d1 on EmailJuez is 'Restriccion de patron del Email';
comment on constraint fk_Juez_Email on EmailJuez is 'Llave foranea por parte del Juez (D:Cascade/U:Cascade)';


create table if not exists TrabajarAtleta(
	IdOlimpicoA bigint,
	IdDisciplina bigint
);

alter table TrabajarAtleta alter column IdOlimpicoA set not null;
alter table TrabajarAtleta alter column IdDisciplina set not null;
alter table TrabajarAtleta add constraint fk_Atleta_trabajar foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA) on delete cascade on update cascade;
alter table TrabajarAtleta add constraint fk_disciplina_trabajar foreign key (IdDisciplina) references Disciplina(IdDisciplina) on delete cascade on update cascade;

comment on table TrabajarAtleta is 'Tabla que guarda en que Disciplina trabajan los Atletas';
comment on column TrabajarAtleta.IdOlimpicoA is 'Atleta que esta trabajando';
comment on column TrabajarAtleta.IdDisciplina is 'Disciplina en la que trabaja';
comment on constraint fk_Atleta_trabajar on TrabajarAtleta is 'Llave foranea por parte del Atleta (D:Cascade/U:Cascade)';
comment on constraint fk_disciplina_trabajar on TrabajarAtleta is 'Llave foranea por parte de la Disciplina (D:Cascade/U:Cascade)';


create table if not exists TrabajarEntrenador(
	IdOlimpicoE bigint,
	IdDisciplina bigint
);

alter table TrabajarEntrenador alter column IdOlimpicoE set not null;
alter table TrabajarEntrenador alter column IdDisciplina set not null;
alter table TrabajarEntrenador add constraint fk_Entrenador_trabajar foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE) on delete cascade on update cascade;
alter table TrabajarEntrenador add constraint fk_disciplina_trabajar foreign key (IdDisciplina) references Disciplina(IdDisciplina) on delete cascade on update cascade;

comment on table TrabajarEntrenador is 'Tabla que guarda en que Disciplina trabajan los Entrenadores';
comment on column TrabajarEntrenador.IdOlimpicoE is 'Entrenador que esta trabajando';
comment on column TrabajarEntrenador.IdDisciplina is 'Disciplina en la que trabaja';
comment on constraint fk_Entrenador_trabajar on TrabajarEntrenador is 'Llave foranea por parte del Entrenador (D:Cascade/U:Cascade)';
comment on constraint fk_disciplina_trabajar on TrabajarEntrenador is 'Llave foranea por parte de la Disciplina (D:Cascade/U:Cascade)';

create table if not exists TrabajarJuez(
	IdOlimpicoJ bigint,
	IdDisciplina bigint
);

alter table TrabajarJuez alter column IdOlimpicoJ set not null;
alter table TrabajarJuez alter column IdDisciplina set not null;
alter table TrabajarJuez add constraint fk_Juez_trabajar foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ) on delete cascade on update cascade;
alter table TrabajarJuez add constraint fk_disciplina_trabajar foreign key (IdDisciplina) references Disciplina(IdDisciplina)on delete cascade on update cascade;

comment on table TrabajarJuez is 'Tabla que guarda en que Disciplina trabajan los Jueces';
comment on column TrabajarJuez.IdOlimpicoJ is 'Juez que esta trabajando';
comment on column TrabajarJuez.IdDisciplina is 'Disciplina en la que trabaja';
comment on constraint fk_Juez_trabajar on TrabajarJuez is 'Llave foranea por parte del Juez (D:Cascade/U:Cascade)';
comment on constraint fk_disciplina_trabajar on TrabajarJuez is 'Llave foranea por parte de la Disciplina (D:Cascade/U:Cascade)';

create table if not exists ParticiparAtleta(
	IdEvento bigint,
	IdOlimpicoA bigint
);

alter table ParticiparAtleta alter column IdOlimpicoA set not null;
alter table ParticiparAtleta alter column IdEvento set not null;
alter table ParticiparAtleta add constraint fk_Atleta_participa foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA) on delete cascade on update cascade;
alter table ParticiparAtleta add constraint fk_Evento_participa foreign key (IdEvento) references Evento(IdEvento) on delete cascade on update cascade;

comment on table ParticiparAtleta is 'Tabla que guarda en que Eventos participan los Atletas';
comment on column ParticiparAtleta.IdOlimpicoA is 'Atleta que participa';
comment on column ParticiparAtleta.IdEvento is 'Evento en el que participa';
comment on constraint fk_Atleta_participa on ParticiparAtleta is 'Llave foranea por parte del Atleta (D:Cascade/U:Cascade)';
comment on constraint fk_Evento_participa on ParticiparAtleta is 'Llave foranea por parte del Evento (D:Cascade/U:Cascade)';

create table if not exists ParticiparEntrenador(
	IdEvento bigint,
	IdOlimpicoE bigint
);

alter table ParticiparEntrenador alter column IdOlimpicoE set not null;
alter table ParticiparEntrenador alter column IdEvento set not null;
alter table ParticiparEntrenador add constraint fk_Entrenador_participa foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE) on delete cascade on update cascade;
alter table ParticiparEntrenador add constraint fk_Evento_participa foreign key (IdEvento) references Evento(IdEvento) on delete cascade on update cascade;

comment on table ParticiparEntrenador is 'Tabla que guarda en que Eventos participan los Entrenadores';
comment on column ParticiparEntrenador.IdOlimpicoE is 'Entrenador que participa';
comment on column ParticiparEntrenador.IdEvento is 'Evento en el que participa';
comment on constraint fk_Entrenador_participa on ParticiparEntrenador is 'Llave foranea por parte del Entrenador (D:Cascade/U:Cascade)';
comment on constraint fk_Evento_participa on ParticiparEntrenador is 'Llave foranea por parte del Evento (D:Cascade/U:Cascade)';


create table if not exists ParticiparJuez(
	IdEvento bigint,
	IdOlimpicoJ bigint
);

alter table ParticiparJuez alter column IdOlimpicoJ set not null;
alter table ParticiparJuez alter column IdEvento set not null;
alter table ParticiparJuez add constraint fk_Juez_participa foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ) on delete cascade on update cascade;
alter table ParticiparJuez add constraint fk_Evento_participa foreign key (IdEvento) references Evento(IdEvento) on delete cascade on update cascade;

comment on table ParticiparJuez is 'Tabla que guarda en que Eventos participan los Atletas';
comment on column ParticiparJuez.IdOlimpicoJ is 'Juez que participa';
comment on column ParticiparJuez.IdEvento is 'Evento en el que participa';
comment on constraint fk_Juez_participa on ParticiparJuez is 'Llave foranea por parte del Juez (D:Cascade/U:Cascade)';
comment on constraint fk_Evento_participa on ParticiparJuez is 'Llave foranea por parte del Evento (D:Cascade/U:Cascade)';
