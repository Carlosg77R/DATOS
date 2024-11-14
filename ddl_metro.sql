--Creación de tablas
/*Dudas:
La tabla estación tiene int en numeroestacion
La tabla teléfono tiene dos pk

*/

CREATE table Estación(
NúmeroEstación int,
JefeEstación varchar(150) not null,
NombreEstación varchar(100) not null,
HoraApertura Time not null,
HoraCierre Time not null,
Teléfono char(10) not null,
constraint pkEstación primary key(NúmeroEstación)
constraint check(NúmeroEstación between 1 and 12)
);

CREATE table Acceso(
NúmeroAcceso int not null,
NúmeroEstación int not null,
HoraApertura time not null DEFAULT 5:00:00.000,
HorraCierre time not null DEFAULT 0:00:00.000,
constraint pkAcceso primary key(NúmeroAcceso),
constraint fkAcceso foreign key(NúmeroEstación) references Estación(NúmeroEstación)
on update cascade on delete cascade
constraint check(NúmeroAcceso >0)

);

CREATE table Servicio(
IDServicio int not null,
Nombre varchar(100) not null,
Tipo varchar(100) not null,
constraint pkServicio primary key(IDServicio)
constraint check(IDServicio >0)
);

CREATE table Conectar(
NúmeroEstación int not null,
IDServicio int not null,
constraint fk1Conectar foreign key(NúmeroEstación) references Estación(NúmeroEstación)
on update cascade on delete cascade,
constraint fk2Conectar foreign key(IDServicio) references Servicio(IDServicio)
on update cascade on delete cascade
);

CREATE table Hangar(
IDHangar int not null,
NúmeroEstación int not null,
constraint pkHangar primary key (IDHangar),
constraint fkHangar foreign key(NúmeroEstación) references Estación(NúmeroEstación)
on update cascade on delete cascade
constraint check(IDHangar >0)
);

