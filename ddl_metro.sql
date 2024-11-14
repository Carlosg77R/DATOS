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
constraint pkEstación primary key (NúmeroEstación),
constraint validNúmeroEstación check (NúmeroEstación between 1 and 12)
);

CREATE table Acceso(
NúmeroAcceso int,
NúmeroEstación int not null,
HoraApertura time not null DEFAULT '5:00:00.000',
HorraCierre time not null DEFAULT '0:00:00.000',
constraint pkAcceso primary key(NúmeroAcceso),
constraint fkAcceso foreign key(NúmeroEstación) references Estación(NúmeroEstación)
on update cascade on delete cascade,
constraint validNúmeroAcceso check (NúmeroAcceso >0)
);

CREATE table Servicio(
IDServicio int,
Nombre varchar(100) not null,
Tipo varchar(100) not null,
constraint pkServicio primary key(IDServicio),
constraint validIDServicio check(IDServicio >0)
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
IDHangar int, 
NúmeroEstación int not null,
constraint pkHangar primary key (IDHangar),
constraint fkHangar foreign key(NúmeroEstación) references Estación(NúmeroEstación)
on update cascade on delete cascade,
constraint validIDHangar check (IDHangar >0)
);

CREATE table Conductor(
CURP char(18),
Nombre varchar(100) not null,
Paterno varchar(100) not null,
Materno VARCHAR(100) not null,
Sexo char(1) not null,
Salario numeric(10,2),
Nacimiento date not null,
Estado varchar(100) not null,
constraint pkConductor primary key (CURP),
constraint validSexo check (Sexo in ('M', 'F')),
constraint validNacimiento check (Nacimiento <= current_Date),
constraint validSalario check (Salario between 249 and 186093)
);

CREATE table Teléfono(
CURP char (18),
Teléfono char (10),
constraint pkTeléfono primary key (CURP, Teléfono),
constraint fkTeléfono foreign key (CURP) references Conductor(CURP)
on update cascade on delete cascade,
constraint validTeléfono check (Teléfono ~ '^[0-9]{10}$')
);

CREATE table Línea(
NúmeroLínea int,
Nombre varchar(100) not null,
constraint pkLínea primary key (NúmeroLínea),
constraint validNúmeroLínea check (NúmeroLínea between 1 and 14)
);

CREATE table Tren(
IDTren int,
NúmeroLínea int not null,
Marca varchar(100) not null,
Estatus boolean not null default TRUE, 
Vagones int not null check (Vagones > 0),
AñoFabrica INT not null check (AñoFabrica between 1700 AND extract(year from current_Date)),
constraint pkTren primary key (IDTren),
constraint fkTrenLínea foreign key (NúmeroLínea) REFERENCES Línea(NúmeroLínea)
on update cascade
on delete cascade
);

CREATE TABLE Conducir(
IDTren int not null,
CURP CHAR(18) not null,
HoraInicio Time not null,
HoraFin Time not null,
Fecha Date not null,
Turno CHAR(1) not null check (Turno in ('M', 'T', 'N')),  -- M: Mañana, T: Tarde, N: Noche
constraint pkConducir primary key (IDTren, CURP, Fecha),
constraint fkConducirTren foreign key (IDTren) references Tren(IDTren)
  on update cascade
  on delete cascade,
constraint fkConducirConductor foreign key (CURP) references Conductor(CURP)
  on update cascade
  on delete cascade,
constraint validHorarios check (HoraInicio < HoraFin)
);

CREATE table Pertenecer(
NúmeroLínea int not null,
NúmeroEstación int not null,
constraint fkPertenecerLínea  foreign key (NúmeroLínea) references Línea(NúmeroLínea)
  on update cascade
  on delete cascade,
constraint fkPertenecerEstación foreign key (NúmeroEstación) references Estación(NúmeroEstación)
  on update cascade
  on delete cascade
);

CREATE table Reservar(
IDTren int not null,
IDHangar int not null,
FechaInicio Date not null,
FechaFin Date not null, 
constraint fkReservarTren foreign key (IDTren) references Tren(IDTren)
  on update cascade
  on delete cascade,
constraint fkReservarHangar foreign key (IDHangar) references Hangar(IDHangar)
  on update cascade
  on delete cascade,
constraint validFechaReserva check (FechaInicio <= FechaFin)
);


