
--DROP SCHEMA IF EXISTS public CASCADE;
--CREATE SCHEMA public;


create table IF NOT exists Localidad (
	IdLocalidad integer not null primary key,
	Nombre varchar(50),
	Tipo varchar(50),
	Calle varchar(50),
	Numero integer,
	Ciudad varchar(50),
	Pais varchar(50),
	Aforo integer
	constraint Localidad_d1 check(Nombre <> ''),
	constraint Localidad_d2 check(Tipo <> ''),
	constraint Localidad_d3 check(Calle <> ''),
	constraint Localidad_d4 check(Numero > 0),
	constraint Localidad_d5 check(Ciudad <> ''),
	constraint Localidad_d6 check(Pais <> ''),
	constraint Localidad_d7 check(Aforo > 0)
	
);

create table if not exists Usuario(
	IdUsuario varchar(45) not null primary key
);

create table if not exists Disciplina (
	IdDisciplina integer not null primary key,
	IdLocalidad integer not null,
	Categoria varchar(50),
	Nombre varchar(150),
	constraint Disciplina_d1 check(Categoria<>''),
	constraint Disciplina_d2 check(Nombre<>''),
	constraint fk_localidad_disciplina foreign key (IdLocalidad) references Localidad(IdLocalidad)
);

create table if not exists Evento(
	IdEvento integer not null primary key,
	IdDIsciplina integer not null,
	Fecha timestamp not null,
	PrecioInic money,
	DuarcionMax time not null,
	LlaveEliminatoria integer,
	constraint Evento_d1 check(PrecioInic > '0'::money),
	constraint Evento_d2 check(LlaveEliminatoria > 0),
	constraint fk_disciplina_evento foreign key (IdDIsciplina) references Disciplina(IdDIsciplina)
);

create table if not exists Visitar(
	IdUsuario varchar(45) not null,
	IdEvento integer not null,
	constraint fk_usuario_visitar foreign key(IdUsuario) references Usuario(IdUsuario),
	constraint fk_evento_visitar foreign key(IdEvento) references Evento(IdEvento)
);

create table if not exists Patrocinador(
	IdDisciplina integer not null,
	Patrocinador varchar(50) not null,
	constraint fk_Disciplina_patrocinador foreign key (IdDIsciplina) references Disciplina(IdDisciplina)
);

alter table Patrocinador add constraint Patrocinador_pk
primary key (IdDisciplina,Patrocinador);

create table if not exists Pais(
	TRICLAVE char(3) not null primary key,
	Nombre varchar(50),
	constraint Pais_d1 check(Nombre<>'')
);

create table if not exists Entrenador(
	IdOlimpicoE integer not null primary key,
	Nombre varchar(50),
	ApellidoPaterno varchar(50),
	ApellidoMaterno varchar(50),
	FechaNacimiento date not null,
	Genero char(1),
	constraint Entrenador_d1 check(Nombre<>''),
	constraint Entrenador_d2 check(ApellidoPaterno<>''),
	constraint Entrenador_d3 check(ApellidoMaterno<>''),
	constraint Entrenador_d4 check(char_length(Genero)=1),
	constraint Entrenador_d5 check(Genero in ('F','M'))
);

create table if not exists TelefonoEntrenador(
	IdOlimpicoE integer not null,
	Telefono varchar(15) not null,
	constraint TelefonoEntrenador_d1 check(Telefono ~ '^\+?\d{10,15}$'),
	constraint pk_Entrenador_Telefono foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE)
);

alter table TelefonoEntrenador add constraint TelefonoE_pk
primary key (IdOlimpicoE,Telefono);

create table if not exists EmailEntrenador(
	IdOlimpicoE integer not null,
	Email varchar(30) not null,
	constraint EmailEntrenador_d1 check (Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
	constraint pk_Entrenador_Email foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE)
);

alter table EmailEntrenador add constraint EmailE_pk
primary key (IdOlimpicoE,Email);

create table if not exists Atleta(
	IdOlimpicoA integer not null primary key,
	IdOlimpicoE integer not null,
	TRICLAVE char(3),
	Nombre varchar(50),
	ApellidoPaterno varchar(50),
	ApellidoMaterno varchar(50),
	FechaNacimiento date not null,
	Genero char(1)
	constraint Atleta_d1 check(char_length(TRICLAVE)=3),
	constraint Atleta_d2 check(Nombre<>''),
	constraint Atleta_d3 check(ApellidoPaterno<>''),
	constraint Atleta_d4 check(ApellidoMaterno<>''),
	constraint Atleta_d5 check(char_length(Genero)=1),
	constraint Atleta_d6 check(Genero in ('F','M')),
	constraint fk_Entrenador_Atleta foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE),
	constraint fk_Pais_Atleta foreign key (TRICLAVE) references Pais(TRICLAVE)
	
);

create table if not exists Medalla(
	IdMedalla integer not null,
	IdDisciplina integer not null,
	IdOlimpicoA integer not null,
	Lugar integer
	constraint Medalla_d1 check(Lugar between 1 and 3),
	constraint fk_Atleta_Medalla foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA),
	constraint fk_Atleta_Disciplina foreign key (IdDisciplina) references Disciplina(IdDisciplina)
); 

alter table Medalla add constraint Medalla_pk
primary key (IdMedalla,IdDisciplina);

create table if not exists TelefonoAtleta(
	IdOlimpicoA integer not null,
	Telefono varchar(15) not null,
	constraint TelefonoAtleta_d1 check(Telefono ~ '^\+?\d{10,15}$'),
	constraint pk_Atleta_Telefono foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA)
);

alter table TelefonoAtleta add constraint TelefonoA_pk
primary key (IdOlimpicoA,Telefono);

create table if not exists EmailAtleta(
	IdOlimpicoA integer not null,
	Email varchar(30) not null,
	constraint EmailAtleta_d1 check (Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
	constraint pk_Atleta_Email foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA)

);

alter table EmailAtleta add constraint EmailA_pk
primary key (IdOlimpicoA,Email);


create table if not exists Juez(
	IdOlimpicoJ integer not null primary key,
	Nombre varchar(50),
	ApellidoPaterno varchar(50),
	ApellidoMaterno varchar(50),
	FechaNacimiento date not null,
	Genero char(1),
	constraint Juez_d2 check(Nombre<>''),
	constraint Juez_d3 check(ApellidoPaterno<>''),
	constraint Juez_d4 check(ApellidoMaterno<>''),
	constraint Juez_d5 check(char_length(Genero)=1),
	constraint Juez_d6 check(Genero in ('F','M'))
);

create table if not exists TelefonoJuez(
	IdOlimpicoJ integer not null,
	Telefono varchar(15) not null,
	constraint TelefonoJuez_d1 check(Telefono ~ '^\+?\d{10,15}$'),
	constraint pk_Juez_Telefono foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ)
);

alter table TelefonoJuez add constraint telefonoJ_pk
primary key (IdOlimpicoJ,Telefono);


create table if not exists EmailJuez(
	IdOlimpicoJ integer not null,
	Email varchar(30) not null,
	constraint EmailJuez_d1 check (Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
	constraint pk_Juez_Email foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ)
);
 
alter table EmailJuez add constraint EmailJ_pk
primary key (IdOlimpicoJ,Email);

create table if not exists TrabajarAtleta(
	IdOlimpicoA integer,
	IdDisciplina integer,
	constraint fk_atleta_trabajar foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA),
	constraint fk_disciplina_trabajar foreign key (IdDisciplina) references Disciplina(IdDisciplina)
);

create table if not exists TrabajarEntrenador(
	IdOlimpicoE integer,
	IdDisciplina integer,
	constraint fk_entrenador_trabajar foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE),
	constraint fk_disciplina_trabajar foreign key (IdDisciplina) references Disciplina(IdDisciplina)
);
create table if not exists TrabajarJuez(
	IdOlimpicoJ integer,
	IdDisciplina integer,
	constraint fk_juez_trabajar foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ),
	constraint fk_disciplina_trabajar foreign key (IdDisciplina) references Disciplina(IdDisciplina)
);

create table if not exists ParticiparAtleta(
	IdEvento integer,
	IdOlimpicoA integer,
	constraint fk_atleta_participa foreign key (IdOlimpicoA) references Atleta(IdOlimpicoA),
	constraint fk_evento_participa foreign key (IdEvento) references Evento(IdEvento)
);

create table if not exists ParticiparEntrenador(
	IdEvento integer,
	IdOlimpicoE integer,
	constraint fk_entrenador_participa foreign key (IdOlimpicoE) references Entrenador(IdOlimpicoE),
	constraint fk_evento_participa foreign key (IdEvento) references Evento(IdEvento)
);

create table if not exists ParticiparJuez(
	IdEvento integer,
	IdOlimpicoJ integer,
	constraint fk_juez_participa foreign key (IdOlimpicoJ) references Juez(IdOlimpicoJ),
	constraint fk_evento_participa foreign key (IdEvento) references Evento(IdEvento)
);