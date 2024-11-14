CREATE table Estación(
NúmeroEstación int,
JefeEstación varchar(150) not null,
NombreEstación varchar(100) not null,
HoraApertura Time not null,
HoraCierre Time not null,
Teléfono char(10) not null,
constraint pkEstación primary key(NúmeroEstación)
);

CREATE table Acceso(
NúmeroAcceso int not null,
NúmeroEstación int not null,
HoraApertura time not null,
HorraCierre time not null,
constraint pkAcceso primary key(NúmeroAcceso)
constraint fkAcceso foreign key(NúmeroEstación) references Estación(NúmeroEstación)
);

CREATE table Servicio(
IDServicio int not null,
Nombre varchar(100) not null,
Tipo varchar(100) not null
constraint pkServicio primary key(IDServicio)
);

CREATE table Conectar(
NúmeroEstación int,
IDServicio int,
constraint fk1Conectar foreign key(NúmeroEstación) references Estación(NúmeroEstación)
constraint fk2Conectar foreign key(IDServicio) references Servicio(IDServicio)
);

CREATE table Hangar(
IDHangar int,
NúmeroEstación int,
constraint pkHangar primary key (IDHangar),
constraint fkHangar foreign key(NúmeroEstación) references Estación(NúmeroEstación)
);
