--DROP SCHEMA IF EXISTS public CASCADE;
--CREATE SCHEMA public;


create table IF NOT exists Localidad (
	IdLocalidad integer,
	Nombre varchar(50),
	Tipo varchar(50),
	Calle varchar(50),
	Numero integer,
	Ciudad varchar(50),
	Pais varchar(50),
	Aforo integer
);

alter table Localidad alter column IdLocalidad set not null;
alter table Localidad add constraint Localidad_d1 unique (IdLocalidad);
alter table Localidad add constraint Localidad_pk primary key (IdLocalidad);
alter table Localidad add constraint Localidad_d2 check(Nombre <> '');
alter table Localidad add constraint Localidad_d3 check(Tipo <> '');
alter table Localidad add constraint Localidad_d4 check(Calle <> '');
alter table Localidad add constraint Localidad_d5 check(Numero > 0);
alter table Localidad add constraint Localidad_d6 check(Ciudad <> '');
alter table Localidad add constraint Localidad_d7 check(Pais <> '');
alter table Localidad add constraint Localidad_d8 check(Aforo > 0);

comment on table Localidad is 'Tabla que contiene las localidades en las que se hacen los eventos de los JJOO';
comment on column Localidad.idLocalidad is 'Identificador de la localidad';
comment on column Localidad.nombre is 'Nombre de la localidad';
comment on column Localidad.tipo is 'Tipo de localidad, playa, techado, estadio, etc';
comment on column LOcalidad.calle is 'Nombre de la calle';
comment on column Localidad.numero is 'Numero de la calle';
comment on column Localidad.ciudad is 'Ciudad de la localidad';
comment on column Localidad.pais  is 'Pais de la localidad';
comment on column Localidad.aforo is 'Cadidad de personas que pueden estar en la localidad';
comment on constraint Localidad_pk on Localidad is 'Llave primaria';
comment on constraint Localidad_d1 on Localidad is 'Restriccion de unique en idLocalidad';
comment on constraint Localidad_d2 on Localidad is 'Restriccion de no vacio en Nombre';
comment on constraint Localidad_d3 on Localidad is 'Restriccion de no vacio en tipo';
comment on constraint Localidad_d4 on Localidad is 'Restriccion de no vacio en calle';
comment on constraint Localidad_d5 on Localidad is 'Restriccion de no numeros negativos en Numero';
comment on constraint Localidad_d6 on Localidad is 'Restriccion de no vacio en Ciudad';
comment on constraint Localidad_d7 on Localidad is 'Restriccion de no vacio en Pais ';
comment on constraint Localidad_d8 on Localidad is 'Restriccion de no numeros negativos en aforo';


create table if not exists Usuario(
	IdUsuario varchar(45)
);

alter table Usuario alter column IdUsuario set not null;
alter table Usuario add constraint Usuario_d1 unique (IdUsuario);
alter table Usuario add constraint Usuario_pk primary key (IdUsuario);

comment on table Usuario is 'Tabla de Usuarios';
comment on column Usuario.IdUsuario is 'La llave primaria de los usuarios';
comment on constraint Usuario_pk on Usuario is 'Llave primaria de Usuario';
comment on constraint Usuario_d1 on Usuario is 'Restriccion unique en IdUsuario';


create table if not exists Disciplina (
	IdDisciplina integer,
	IdLocalidad integer,
	Categoria varchar(50),
	Nombre varchar(150)
);

alter table Disciplina alter column IdDisciplina set not null;
alter table Disciplina alter column IdLocalidad set not null;
alter table Disciplina add constraint Disciplina_d1 unique (IdDIsciplina);
alter table Disciplina add constraint Disciplina_pk primary key (IdDisciplina);
alter table Disciplina add constraint Disciplina_d2 check (Categoria <> '');
alter table Disciplina add constraint Disciplina_d3 check (Nombre <> '');
alter table Disciplina add constraint fk_localidad_disciplina foreign key (IdLocalidad) references Localidad(IdLocalidad) on delete restrict on update cascade;

comment on table Disciplina is 'Tabla que contiene las disciplinas de los JJOO';
comment on column Disciplina.IdDisciplina is 'La llave primaria de las disciplinas';
comment on column Disciplina.IdLocalidad is 'La llave foranea de las localidades';
comment on column Disciplina.Categoria is 'El tipo de categoria de la disciplina';
comment on column Disciplina.Nombre is 'El nombre de la categoria';
comment on constraint Disciplina_d1 on Disciplina is 'restriccion unique en Id Disciplina';
comment on constraint Disciplina_d2 on Disciplina is 'restriccion de no vacio de Categoria';
comment on constraint Disciplina_d3 on Disciplina is 'restriccion de no vacio de Nombre';
comment on constraint Disciplina_pk on Disciplina is 'llave primaria de Disciplina';
comment on constraint fk_localidad_disciplina on Disciplina is 'la llave foranea de Localidad';


create table if not exists Evento(
	IdEvento integer,
	IdDIsciplina integer,
	Fecha timestamp,
	PrecioInic money,
	DuracionMax time,
	LlaveEliminatoria integer
);

alter table Evento alter column IdEvento set not null;
alter table Evento alter column IdDisciplina set not null;
alter table Evento alter column Fecha set not null;
alter table Evento alter column DuracionMax set not null;
alter table Evento add constraint Evento_d1 unique (IdEvento);
alter table Evento add constraint Evento_pk primary key (IdEvento);
alter table Evento add constraint Evento_d2 check(PrecioInic > '0' :: money);
alter table Evento add constraint Evento_d3 check(LlaveEliminatoria > 0);
alter table Evento add constraint fk_disciplina_evento foreign key (IdDisciplina) references Disciplina(IdDisciplina) on delete restrict on update cascade;

comment on table Evento is 'Tabla que contiene los eventos de los JJOO';
comment on column Evento.IdEvento is 'La llave primaria de los eventos';
comment on column Evento.IdDisciplina is 'La llave foranea de las disciplina';
comment on column Evento.Fecha is 'La fecha en la que se va llevar acabo el evento';
comment on column Evento.PrecioInic is 'EL precio inicial de las entradas';
comment on column Evento.DuracionMax is 'La duracion maxima de los eventos';
comment on column Evento.LlaveEliminatoria is 'Las rondas del evento llevadas a cabo';
comment on constraint Evento_d1 on Evento is 'Restriccion unique de IdEvento';
comment on constraint Evento_d2 on Evento is 'Restriccion de no negativo en PrecioInic';
comment on constraint Evento_d3 on Evento is 'Restriccion de no negativo en LlaveEliminatoria';
comment on constraint Evento_pk on Evento is 'llave primaria de Eevnto';
comment on constraint fk_disciplina_evento on Evento is 'llave foranea de Disciplina';

create table if not exists Visitar(
	IdUsuario varchar(45),
	IdEvento integer
	
);

alter table Visitar alter column IdUsuario set not null;
alter table Visitar alter column IdEvento set not null;
alter table Visitar add constraint fk_usuario_visitar foreign key (IdUsuario) references Usuario(IdUsuario) on delete cascade on update cascade;
alter table Visitar add constraint fk_evento_visitar foreign key  (IdEvento) references Evento(IdEvento) on delete cascade on update cascade;

comment on table Visitar is 'Tabla que contiene a que eventos han asistido los usuarios';
comment on column Visitar.IdUsuario is 'La llave foraena del usuario';
comment on column Visitar.IdEvento is 'La llave foranea del evento';
comment on constraint fk_usuario_visitar on Visitar is 'llave foranea del usuario';
comment on constraint fk_evento_visitar on Visitar is 'llave foranea del evento';



create table if not exists Patrocinador(
	IdDisciplina integer,
	Patrocinador varchar(50)
);

alter table Patrocinador alter column IdDisciplina set not null;
alter table Patrocinador alter column Patrocinador set not null;
alter table Patrocinador add constraint fk_Disciplina_patrocinador foreign key (IdDisciplina) references Disciplina(IdDisciplina) on delete cascade on update cascade;
alter table Patrocinador add constraint Patrocinador_pk primary key (IdDisciplina,Patrocinador);

comment on table Patrocinador is 'Tabla que contiene los patrocinadores de cada disiplina';
comment on column Patrocinador.IdDisciplina is 'La llave foranea de las disciplinas ';
comment on column Patrocinador.Patrocinador is 'el patrocinador de las disciplinas';
comment on constraint Patrocinador_pk on Patrocinador is 'llave primaria de Patrocinador';
comment on constraint fk_Disciplina_Patrocinador on Patrocinador is 'llave foranea de Disciplina';

create table if not exists Pais(
	TRICLAVE char(3),
	Nombre varchar(50)
);

alter table Pais alter column TRICLAVE set not null;
alter table Pais add constraint Pais_d1 unique(TRICLAVE);
alter table Pais add constraint Pais_d2 check(char_length(TRICLAVE)=3);
alter table Pais add constraint Pais_pk primary key (TRICLAVE);
alter table Pais add constraint Pais_d3 check(Nombre<>'');

comment on table Pais is 'Tabla que guarda los paises participanete de los JJOO';
comment on column Pais.TRICLAVE is 'Llave primaria de los paises';
comment on column Pais.Nombre is 'Pais al que esta relacionado la TRICLAVE';
comment on constraint Pais_d1 on Pais is 'Restriccion unique de TRICLAVE';
comment on constraint Pais_d2 on Pais is 'Restriccion de tamaño de la TRICLAVE ';
comment on constraint Pais_d3 on Pais is 'Restriccion de no vacio de Nombre';
comment on constraint pais_pk on Pais is 'llave primaria de un pais';


create table if not exists Entrenador(
	IdOlimpicoE integer,
	Nombre varchar(50),
	ApellidoPaterno varchar(50),
	ApellidoMaterno varchar(50),
	FechaNacimiento date,
	Genero char(1)
);

alter table Entrenador alter column IdOlimpicoE set not null;
alter table Entrenador alter column FechaNacimiento set not null;
alter table ENtrenador add constraint Entrenador_d1 unique (IdOlimpicoE);
alter table ENtrenador add constraint Entrenador_pk primary key (IdOlimpicoE);
alter table Entrenador add constraint Entrenador_d2 check(Nombre<>'');
alter table Entrenador add constraint Entrenador_d3 check(ApellidoPaterno<>'');
alter table Entrenador add constraint Entrenador_d4 check(ApellidoMaterno<>'');
alter table Entrenador add constraint Entrenador_d5 check(char_length(Genero)=1);
alter table Entrenador add constraint Entrenador_d6 check(Genero in ('F','M'));


comment on table Entrenador is 'Tabla de entrenadores';
comment on column Entrenador.IdOlimpicoE is 'Llave primaria de los entrenadores';
comment on column Entrenador.nombre is 'Nombre del entrenador';
comment on column Entrenador.ApellidoPaterno is 'Apellido paterno del entrenador';
comment on column Entrenador.ApellidoMaterno is 'Apellido materno del entrenador';
comment on column ENtrenador.FechaNacimiento is 'Fecha de nacimiento del entrenador';
comment on column Entrenador.Genero is 'Genero del entrenador';
comment on constraint Entrenador_d1 on Entrenador is 'Restriccion unique en IdOlimpicoE';
comment on constraint Entrenador_d2 on Entrenador is 'Restriccion de no vacio de Nombre';
comment on constraint Entrenador_d3 on Entrenador is 'Restriccion de no vacio de ApellidoPaterno';
comment on constraint Entrenador_d4 on Entrenador is 'Restriccion de no vacio de ApellidoMaterno';
comment on constraint Entrenador_d5 on Entrenador is 'Restriccion de longitud de Genero';
comment on constraint Entrenador_d6 on Entrenador is 'Restriccion de genero en 2 opciones ';
comment on constraint Entrenador_pk on Entrenador is 'Llave Primaria de Entrenador'; 

create table if not exists TelefonoEntrenador(
	IdOlimpicoE integer,
	Telefono varchar(15)
);

alter table TelefonoEntrenador alter column IdOlimpicoE set not null;
alter table TelefonoEntrenador alter column Telefono set not null;
alter table TelefonoEntrenador add constraint TelefonoEntrenador_d1 check(Telefono ~ '^\+?\d{10,15}$');
alter table TelefonoENtrenador add constraint fk_Entrenador_Telefono foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE) on delete cascade on update cascade;
alter table TelefonoEntrenador add constraint TelefonoE_pk primary key (IdOlimpicoE,Telefono);

comment on table TelefonoEntrenador is 'Tabla de los telefonos de un entrenador';
comment on column TelefonoEntrenador.IdOlimpicoE is 'Llave foranea de los Entrenadores';
comment on column TelefonoEntrenador.Telefono is 'Telefonos de los entrenadores';
comment on constraint TelefonoEntrenador_d1 on TelefonoEntrenador is 'Restriccion de patron del telefono';
comment on constraint fk_Entrenador_Telefono on TelefonoEntrenador is 'llave foranea de los entrenadores';
comment on constraint TelefonoE_pk on TelefonoEntrenador is 'llave primaria de TelefonoEntrenador';


create table if not exists EmailEntrenador(
	IdOlimpicoE integer,
	Email varchar(30)
);

alter table EmailEntrenador alter column IdOlimpicoE set not null;
alter table EmailEntrenador alter column Email set not null;
alter table EmailEntrenador add constraint EmailEntrenador_d1 check (Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
alter table EmailEntrenador add constraint fk_Entrenador_Email foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE) on delete cascade on update cascade;
alter table EmailEntrenador add constraint EmailE_pk primary key (IdOlimpicoE,Email);

comment on table EmailEntrenador is 'Tabla de los Emails de un entrenador';
comment on column EmailEntrenador.IdOlimpicoE is 'Llave foranea de los Entrenadores';
comment on column EmailEntrenador.Email is 'Emails de los entrenadores';
comment on constraint EmailEntrenador_d1 on EmailEntrenador is 'Restriccion de patron del Email';
comment on constraint fk_Entrenador_Email on EmailEntrenador is 'llave foranea de los entrenadores';
comment on constraint EmailE_pk on EmailEntrenador is 'llave primaria de EmailEntrenador';


create table if not exists Atleta(
	IdOlimpicoA integer,
	IdOlimpicoE integer,
	TRICLAVE char(3),
	Nombre varchar(50),
	ApellidoPaterno varchar(50),
	ApellidoMaterno varchar(50),
	FechaNacimiento date,
	Genero char(1)	
);

alter table Atleta alter column IdOlimpicoA set not null;
alter table Atleta alter column IdOlimpicoE set not null;
alter table Atleta alter column FechaNacimiento set not null;
alter table Atleta add constraint Atleta_d1 unique (IdOlimpicoA);
alter table Atleta add constraint Atleta_pk primary key (IdOlimpicoA);
alter table Atleta add constraint Atleta_d2 check(Nombre<>'');
alter table Atleta add constraint Atleta_d3 check(ApellidoPaterno<>'');
alter table Atleta add constraint Atleta_d4 check(ApellidoMaterno<>'');
alter table Atleta add constraint Atleta_d5 check(char_length(Genero)=1);
alter table Atleta add constraint Atleta_d6 check(Genero in ('F','M'));
alter table Atleta add constraint Atleta_d7 check(char_length(TRICLAVE)=3);
alter table Atleta add constraint fk_Entrenador_Atleta foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE) on delete restrict on update cascade;
alter table Atleta add constraint fk_Pais_Atleta foreign key (TRICLAVE) references Pais(TRICLAVE) on delete restrict on update cascade;


comment on table Atleta is 'Tabla de Atletas';
comment on column Atleta.IdOlimpicoA is 'Llave primaria de los Atletas';
comment on column Atleta.IdOlimpicoE is 'Llave foranea del entrenador';
comment on column Atleta.TRICLAVE is 'llave foranea de pais';
comment on column Atleta.nombre is 'Nombre del Atleta';
comment on column Atleta.ApellidoPaterno is 'Apellido paterno del Atleta';
comment on column Atleta.ApellidoMaterno is 'Apellido materno del Atleta';
comment on column Atleta.FechaNacimiento is 'Fecha de nacimiento del Atleta';
comment on column Atleta.Genero is 'Genero del Atleta';
comment on constraint Atleta_d1 on Atleta is 'Restriccion unique en IdOlimpicoA';
comment on constraint Atleta_d2 on Atleta is 'Restriccion de no vacio de Nombre';
comment on constraint Atleta_d3 on Atleta is 'Restriccion de no vacio de ApellidoPaterno';
comment on constraint Atleta_d4 on Atleta is 'Restriccion de no vacio de ApellidoMaterno';
comment on constraint Atleta_d5 on Atleta is 'Restriccion de longitud de Genero';
comment on constraint Atleta_d6 on Atleta is 'Restriccion de genero en 2 opciones ';
comment on constraint Atleta_d7 on Atleta is 'Restriccion de longitud en TRICLAVE';
comment on constraint fk_Entrenador_Atleta on Atleta is 'llave foranea de entrenador';
comment on constraint fk_Pais_Atleta on Atleta is 'llave foranea de Pais';
comment on constraint Atleta_pk on Atleta is 'Llave Primaria de Atleta'; 

create table if not exists Medalla(
	IdMedalla integer,
	IdDisciplina integer,
	IdOlimpicoA integer,
	Lugar integer
); 

alter table Medalla alter column IdMedalla set not null;
alter table Medalla alter column IdDisciplina set not null;
alter table Medalla alter column IdOlimpicoA set not null;
alter table Medalla add constraint Medalla_d1 check(Lugar between 1 and 3);
alter table Medalla add constraint Medalla_pk primary key (IdMedalla,IdDisciplina);
alter table Medalla add constraint fk_Atleta_Medalla foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA) on delete restrict on update cascade;
alter table Medalla add constraint fk_Atleta_Disciplina foreign key (IdDisciplina) references Disciplina(IdDisciplina) on delete restrict on update cascade;

comment on table Medalla is 'Tabla que guarda las medallas';
comment on column Medalla.idMedalla is 'Llave primaria de las medallas';
comment on column Medalla.idDisciplina is 'Discplina en la que participo del Atleta';
comment on column Medalla.idolimpicoA is 'Atleta que gano la medalla';
comment on column Medalla.lugar is 'Lugar donde se gano la medalla';
comment on constraint Medalla_d1 on Medalla is 'Restriccion del tipo de medalla';
comment on constraint fk_Atleta_Medalla on Medalla is 'Llave foranea de Atleta';
comment on constraint fk_Atleta_Disciplina on Medalla is 'Llave foranea de Disciplina';
comment on constraint Medalla_pk on Medalla is 'Llave primaria de medalla';

create table if not exists TelefonoAtleta(
	IdOlimpicoA integer,
	Telefono varchar(15)
);

alter table TelefonoAtleta alter column IdOlimpicoA set not null;
alter table TelefonoAtleta alter column Telefono set not null;
alter table TelefonoAtleta add constraint TelefonoAtleta_d1 check(Telefono ~ '^\+?\d{10,15}$');
alter table TelefonoAtleta add constraint fk_Atleta_Telefono foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA) on delete cascade on update cascade;
alter table TelefonoAtleta add constraint TelefonoA_pk primary key (IdOlimpicoA,Telefono);

comment on table TelefonoAtleta is 'Tabla de los telefonos de un Atleta';
comment on column TelefonoAtleta.IdOlimpicoA is 'Llave foranea de los Atletas';
comment on column TelefonoAtleta.Telefono is 'Telefonos de los Atletas';
comment on constraint TelefonoAtleta_d1 on TelefonoAtleta is 'Restriccion de patron del telefono';
comment on constraint fk_Atleta_Telefono on TelefonoAtleta is 'llave foranea de los Atletas';
comment on constraint TelefonoA_pk on TelefonoAtleta is 'llave primaria de TelefonoAtleta';


create table if not exists EmailAtleta(
	IdOlimpicoA integer,
	Email varchar(30)
);

alter table EmailAtleta alter column IdOlimpicoA set not null;
alter table EmailAtleta alter column Email set not null;
alter table EmailAtleta add constraint EmailAtleta_d1 check (Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
alter table EmailAtleta add constraint fk_Atleta_Email foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA) on delete cascade on update cascade;
alter table EmailAtleta add constraint EmailA_pk primary key (IdOlimpicoA,Email);

comment on table EmailAtleta is 'Tabla de los Emails de un Atleta';
comment on column EmailAtleta.IdOlimpicoA is 'Llave foranea de los Atletas';
comment on column EmailAtleta.Email is 'Emails de los Atletas';
comment on constraint EmailAtleta_d1 on EmailAtleta is 'Restriccion de patron del Email';
comment on constraint fk_Atleta_Email on EmailAtleta is 'llave foranea de los Atletas';
comment on constraint EmailA_pk on EmailAtleta is 'llave primaria de EmailAtleta';


create table if not exists Juez(
	IdOlimpicoJ integer,
	Nombre varchar(50),
	ApellidoPaterno varchar(50),
	ApellidoMaterno varchar(50),
	FechaNacimiento date,
	Genero char(1)
);

alter table Juez alter column IdOlimpicoJ set not null;
alter table Juez alter column FechaNacimiento set not null;
alter table Juez add constraint Juez_d1 unique (IdOlimpicoJ);
alter table Juez add constraint Juez_pk primary key (IdOlimpicoJ);
alter table Juez add constraint Juez_d2 check(Nombre<>'');
alter table Juez add constraint Juez_d3 check(ApellidoPaterno<>'');
alter table Juez add constraint Juez_d4 check(ApellidoMaterno<>'');
alter table Juez add constraint Juez_d5 check(char_length(Genero)=1);
alter table Juez add constraint Juez_d6 check(Genero in ('F','M'));


comment on table Juez is 'Tabla de Jueces';
comment on column Juez.IdOlimpicoJ is 'Llave primaria de los Jueces';
comment on column Juez.nombre is 'Nombre del Juez';
comment on column Juez.ApellidoPaterno is 'Apellido paterno del Juez';
comment on column Juez.ApellidoMaterno is 'Apellido materno del Juez';
comment on column Juez.FechaNacimiento is 'Fecha de nacimiento del Juez';
comment on column Juez.Genero is 'Genero del Juez';
comment on constraint Juez_d1 on Juez is 'Restriccion unique en IdOlimpicoJ';
comment on constraint Juez_d2 on Juez is 'Restriccion de no vacio de Nombre';
comment on constraint Juez_d3 on Juez is 'Restriccion de no vacio de ApellidoPaterno';
comment on constraint Juez_d4 on Juez is 'Restriccion de no vacio de ApellidoMaterno';
comment on constraint Juez_d5 on Juez is 'Restriccion de longitud de Genero';
comment on constraint Juez_d6 on Juez is 'Restriccion de genero en 2 opciones ';
comment on constraint Juez_pk on Juez is 'Llave Primaria de Juez'; 

create table if not exists TelefonoJuez(
	IdOlimpicoJ integer,
	Telefono varchar(15)
);

alter table TelefonoJuez alter column IdOlimpicoJ set not null;
alter table TelefonoJuez alter column Telefono set not null;
alter table TelefonoJuez add constraint TelefonoJuez_d1 check(Telefono ~ '^\+?\d{10,15}$');
alter table TelefonoJuez add constraint fk_Juez_Telefono foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ) on delete cascade on update cascade;
alter table TelefonoJuez add constraint TelefonoJ_pk primary key (IdOlimpicoJ,Telefono);

comment on table TelefonoJuez is 'Tabla de los telefonos de un Juez';
comment on column TelefonoJuez.IdOlimpicoJ is 'Llave foranea de los Jueces';
comment on column TelefonoJuez.Telefono is 'Telefonos de los Jueces';
comment on constraint TelefonoJuez_d1 on TelefonoJuez is 'Restriccion de patron del telefono';
comment on constraint fk_Juez_Telefono on TelefonoJuez is 'llave foranea de los Jueces';
comment on constraint TelefonoJ_pk on TelefonoJuez is 'llave primaria de TelefonoJuez';


create table if not exists EmailJuez(
	IdOlimpicoJ integer not null,
	Email varchar(30) not null
);

alter table EmailJuez alter column IdOlimpicoJ set not null;
alter table EmailJuez alter column Email set not null;
alter table EmailJuez add constraint EmailJuez_d1 check (Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
alter table EmailJuez add constraint fk_Juez_Email foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ) on delete cascade on update cascade;
alter table EmailJuez add constraint EmailJ_pk primary key (IdOlimpicoJ,Email);

comment on table EmailJuez is 'Tabla de los Emails de un Juez';
comment on column EmailJuez.IdOlimpicoJ is 'Llave foranea de los Jueces';
comment on column EmailJuez.Email is 'Emails de los Jueces';
comment on constraint EmailJuez_d1 on EmailJuez is 'Restriccion de patron del Email';
comment on constraint fk_Juez_Email on EmailJuez is 'llave foranea de los Jueces';
comment on constraint EmailJ_pk on EmailJuez is 'llave primaria de EmailJuez';


create table if not exists TrabajarAtleta(
	IdOlimpicoA integer,
	IdDisciplina integer
);

alter table TrabajarAtleta add constraint fk_Atleta_trabajar foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA) on delete cascade on update cascade;
alter table TrabajarAtleta add constraint fk_disciplina_trabajar foreign key (IdDisciplina) references Disciplina(IdDisciplina) on delete cascade on update cascade;

comment on table TrabajarAtleta is 'Tabla que guarda en que trabaja el olimpico en cuestion';
comment on column TrabajarAtleta.idOlimpicoA is 'Atleta que esta trabajando';
comment on column TrabajarAtleta.idDisciplina is 'Disciplina en la que trabaja';
comment on constraint fk_Atleta_trabajar on TrabajarAtleta is 'llave foranea de los atletas';
comment on constraint fk_disciplina_trabajar on TrabajarAtleta is 'llave foranera de las disciplinas';


create table if not exists TrabajarEntrenador(
	IdOlimpicoE integer,
	IdDisciplina integer
);

alter table TrabajarEntrenador add constraint fk_Entrenador_trabajar foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE) on delete cascade on update cascade;
alter table TrabajarEntrenador add constraint fk_disciplina_trabajar foreign key (IdDisciplina) references Disciplina(IdDisciplina) on delete cascade on update cascade;

comment on table TrabajarEntrenador is 'Tabla que guarda en que trabaja el olimpico en cuestion';
comment on column TrabajarEntrenador.idOlimpicoE is 'Entrenador que esta trabajando';
comment on column TrabajarEntrenador.idDisciplina is 'Disciplina en la que trabaja';
comment on constraint fk_Entrenador_trabajar on TrabajarEntrenador is 'llave foranea de los Entrenadores';
comment on constraint fk_disciplina_trabajar on TrabajarEntrenador is 'llave foranera de las disciplinas';

create table if not exists TrabajarJuez(
	IdOlimpicoJ integer,
	IdDisciplina integer
);

alter table TrabajarJuez add constraint fk_Juez_trabajar foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ) on delete cascade on update cascade;
alter table TrabajarJuez add constraint fk_disciplina_trabajar foreign key (IdDisciplina) references Disciplina(IdDisciplina)on delete cascade on update cascade;

comment on table TrabajarJuez is 'Tabla que guarda en que trabaja el olimpico en cuestion';
comment on column TrabajarJuez.idOlimpicoJ is 'Juez que esta trabajando';
comment on column TrabajarJuez.idDisciplina is 'Disciplina en la que trabaja';
comment on constraint fk_Juez_trabajar on TrabajarJuez is 'llave foranea de los Jueces';
comment on constraint fk_disciplina_trabajar on TrabajarJuez is 'llave foranera de las disciplinas';

create table if not exists ParticiparAtleta(
	IdEvento integer,
	IdOlimpicoA integer
);

alter table ParticiparAtleta add constraint fk_Atleta_participa foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA) on delete cascade on update cascade;
alter table ParticiparAtleta add constraint fk_Evento_participa foreign key (IdEvento) references Evento(IdEvento) on delete cascade on update cascade;

comment on table ParticiparAtleta is 'Tabla que guarda en que participa cada olimpico';
comment on column ParticiparAtleta.IdOlimpicoA is 'Atleta que participa';
comment on column ParticiparAtleta.IdEvento is 'Evento en el que participa';
comment on constraint fk_Atleta_participa on ParticiparAtleta is 'llave foranea de Atleta';
comment on constraint fk_Evento_participa on ParticiparAtleta is 'llave foranea de Evento';

create table if not exists ParticiparEntrenador(
	IdEvento integer,
	IdOlimpicoE integer
);

alter table ParticiparEntrenador add constraint fk_Entrenador_participa foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE) on delete cascade on update cascade;
alter table ParticiparEntrenador add constraint fk_Evento_participa foreign key (IdEvento) references Evento(IdEvento) on delete cascade on update cascade;

comment on table ParticiparEntrenador is 'Tabla que guarda en que participa cada olimpico';
comment on column ParticiparEntrenador.IdOlimpicoE is 'Entrenador que participa';
comment on column ParticiparEntrenador.IdEvento is 'Evento en el que participa';
comment on constraint fk_Entrenador_participa on ParticiparEntrenador is 'llave foranea de Entrenador';
comment on constraint fk_Evento_participa on ParticiparEntrenador is 'llave foranea de Evento';


create table if not exists ParticiparJuez(
	IdEvento integer,
	IdOlimpicoJ integer
);

alter table ParticiparJuez add constraint fk_Juez_participa foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ) on delete cascade on update cascade;
alter table ParticiparJuez add constraint fk_Evento_participa foreign key (IdEvento) references Evento(IdEvento) on delete cascade on update cascade;

comment on table ParticiparJuez is 'Tabla que guarda en que participa cada olimpico';
comment on column ParticiparJuez.IdOlimpicoJ is 'Juez que participa';
comment on column ParticiparJuez.IdEvento is 'Evento en el que participa';
comment on constraint fk_Juez_participa on ParticiparJuez is 'llave foranea de Juez';
comment on constraint fk_Evento_participa on ParticiparJuez is 'llave foranea de Evento';
