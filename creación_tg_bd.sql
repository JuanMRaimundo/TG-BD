CREATE SCHEMA `transportes_g` ;
USE transportes_g;

CREATE TABLE Administradores (
	id_administrador int AUTO_INCREMENT PRIMARY KEY unique,
    Nombre varchar(50),
    Apellido varchar(50),
    Email varchar(50),
    Rol ENUM ('basic','premuim')
);

CREATE TABLE Usuarios (
	id_usuario int AUTO_INCREMENT PRIMARY KEY unique,
    Nombre varchar(50),
    Email varchar(50),
    Rol ENUM ('cliente','despachante')
);

CREATE TABLE Vehiculos (
    Patente varchar(50) PRIMARY KEY unique,
    Tipo ENUM('Camioneta','Semi','Chasis')
);
	
CREATE TABLE Conductores (
	id_conductor int AUTO_INCREMENT PRIMARY KEY unique,
    Nombre varchar(50),
    Apellido varchar(50),
    Tipo ENUM ('Chofer','Fletero'),
    id_vehiculo varchar(50),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(Patente)
);
CREATE TABLE Solicitudes_viajes (
	id_solicitud_viaje int AUTO_INCREMENT PRIMARY KEY unique,
    Fecha_creación datetime,
    Hora Date,
    Lugar_carga varchar(50),
    Lugar_destino varchar(50),
    Detalle varchar(100),
    Ref int unique,
    N°_contenedor varchar(50),
    Vencimiento Date,
    Estado ENUM ('cancelado','pendiente','confirmado'),
    Observaciones varchar(200),
    id_usuario int,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);


CREATE TABLE Viajes_confirmados(
	id_viaje_confirmado int AUTO_INCREMENT PRIMARY KEY unique,
    id_solicitud_viaje int,
    Fecha_creación datetime,
    id_conductor int,
    FOREIGN KEY (id_solicitud_viaje) REFERENCES Solicitudes_viajes(id_solicitud_viaje),
    FOREIGN KEY (id_conductor) REFERENCES Conductores(id_conductor)
);

CREATE TABLE Facturas (
	id_factura int AUTO_INCREMENT PRIMARY KEY unique,
    Fecha_creación datetime,
    Monto FLOAT,
    id_viaje_confirmado int,
    id_administrador int,
    FOREIGN KEY (id_viaje_confirmado) REFERENCES Viajes_confirmados(id_viaje_confirmado),
    FOREIGN KEY (id_administrador) REFERENCES Administradores(id_administrador)
);




