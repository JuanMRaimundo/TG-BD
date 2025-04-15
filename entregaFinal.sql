CREATE SCHEMA `transportes_g` ;
USE transportes_g;

CREATE TABLE Administradores (
	id_administrador int AUTO_INCREMENT PRIMARY KEY unique,
    Nombre varchar(50),
    Apellido varchar(50),
    Email VARCHAR(254) UNIQUE,
    Rol ENUM('BASIC', 'PREMIUM') NOT NULL DEFAULT 'BASIC'
);

CREATE TABLE Usuarios (
	id_usuario int AUTO_INCREMENT PRIMARY KEY unique,
    Nombre varchar(50),
    Email varchar(50),
    Rol ENUM ('CLIENTE', 'DESPACHANTE')  NOT NULL  default 'DESPACHANTE'
);

CREATE TABLE Vehiculos (
    Patente varchar(50) PRIMARY KEY unique,
    Tipo ENUM('CAMIONETA','SEMI','CHASIS')  NOT NULL  default 'SEMI'
);
	
CREATE TABLE Conductores (
	id_conductor int AUTO_INCREMENT PRIMARY KEY unique,
    Nombre varchar(50),
    Apellido varchar(50),
    Tipo ENUM ('CHOFER','FLETERO')  NOT NULL  default 'CHOFER',
    id_vehiculo varchar(50),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(Patente)
);
CREATE TABLE Solicitudes_viajes (
	id_solicitud_viaje int AUTO_INCREMENT PRIMARY KEY unique,
    Fecha_creacion datetime,
    Hora Time,
    Lugar_carga varchar(50),
    Lugar_destino varchar(50),
    Detalle varchar(100),
    Ref int unique,
    N°_contenedor varchar(50),
    Vencimiento Date,
    Estado ENUM ('CANCELADO','PENDIENTE','CONFIRMADO')  NOT NULL  default 'PENDIENTE',
    Observaciones varchar(200),
    id_usuario int,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);


CREATE TABLE Viajes_confirmados(
	id_viaje_confirmado int AUTO_INCREMENT PRIMARY KEY unique,
    id_solicitud_viaje int,
    Fecha_creacion datetime,
    id_conductor int,
    FOREIGN KEY (id_solicitud_viaje) REFERENCES Solicitudes_viajes(id_solicitud_viaje),
    FOREIGN KEY (id_conductor) REFERENCES Conductores(id_conductor)
);

CREATE TABLE Facturas (
	id_factura int AUTO_INCREMENT PRIMARY KEY unique,
    Fecha_creacion datetime,
    Monto FLOAT,
    id_viaje_confirmado int,
    id_administrador int,
    FOREIGN KEY (id_viaje_confirmado) REFERENCES Viajes_confirmados(id_viaje_confirmado),
    FOREIGN KEY (id_administrador) REFERENCES Administradores(id_administrador)
);

USE transportes_g;
SELECT * FROM administradores;
INSERT INTO administradores (Nombre,Apellido,Email,Rol)VALUES ('Gilda','Gómez','gilda@gmail.com','PREMIUM');
SELECT * FROM administradores;
INSERT INTO administradores (Nombre,Apellido,Email,Rol)
VALUES ('Hernán','Guzzo','hernang@gmail.com','PREMIUM'),
('Franco','Guzzo','francog@gmail.com','PREMIUM'),
('Santiago','Corso','santiagoc@gmail.com','PREMIUM'),
('Juan','Raimundo','juanr@gmail.com','PREMIUM'),
('Pedro','Giménez','pedrog@gmail.com','BASIC'),
('Belén','Fernández','belenf@gmail.com','BASIC'),
('Victoria','López','victorial@gmail.com','BASIC'),
('Daniel','Mentori','danielm@gmail.com','BASIC'),
('Hilario','Abdo','hilarioa@gmail.com','BASIC');
SELECT * FROM administradores;
INSERT INTO administradores (Nombre, Apellido, Email) VALUES ('Luis','Jándula','luisj@gmail.com');


SELECT * FROM usuarios;
INSERT INTO usuarios (Nombre,Email) VALUES
('CREAC.MAYO', 'creacm@gmail.com'),
('SA&CE','sayce@gmail.com'),
('PISCICELLI','piscicelli@gmail.com'),
('GUERRICO','guerrico-srl@gmail.com'),
('ELINTER','elintersa@gmail.com'),
('CUSTOMS','customs.g.g@gmail.com'),
('CATANZ','cataniza@gmail.com'),
('VACCARI','vaccarig@gmail.com');
INSERT INTO usuarios (Nombre,Email,Rol) VALUES
('PIRINEO','piri-neo@gmail.com','CLIENTE'),
('COTNYL','cotnyl.er@gmail.com','CLIENTE'),
('MATEO','mateo_gg@gmail.com','CLIENTE'),
('ASENSORES','ascensores.baybal@gmail.com','CLIENTE'),
('SIEGWERK','siegwerk.srl@gmail.com','CLIENTE');

SELECT * FROM vehiculos;

INSERT INTO vehiculos (Patente,Tipo) VALUES
('IKH652','SEMI'),
('SA254SD','SEMI'),
('JUA526','SEMI'),
('EG239AA','CAMIONETA'),
('LPF258','CHASIS'),
('GE951RD','CAMIONETA'),
('LPE874','CAMIONETA'),
('GE654GC','SEMI'),
('IUY987','SEMI'),
('GA654CV','CAMIONETA'),
('PLA328','SEMI'),
('CD398GR','CAMIONETA');

SELECT * FROM conductores;

INSERT INTO conductores (Nombre,Apellido,Tipo,id_vehiculo) VALUES
('Francisco','Arrechabala','CHOFER','IKH652'),
('Sebastián','Charril','CHOFER','SA254SD'),
('Jorge','Gómez','CHOFER','GE951RD'),
('Daniel','Telmun','CHOFER','LPE874'),
('Franco','Mazzucheli','CHOFER','PLA328'),
('Victor','Palos','CHOFER','LPF258'),
('Horacio','Frias','CHOFER','CD398GR'),
('Tomás','Hurguer','CHOFER','IUY987');

INSERT INTO conductores (Nombre,Apellido,Tipo) VALUES
('Pedro','Clemente','FLETERO'),
('Leandro','Parodi','FLETERO'),
('Rodrigo','DePaul','FLETERO');


select * from solicitudes_viajes;

INSERT INTO solicitudes_viajes (
    Fecha_creacion,
    Hora,
    Lugar_carga,
    Lugar_destino,
    Detalle,
    Ref,
    N°_contenedor,
    Vencimiento,
    Estado,
    Observaciones,
    id_usuario
)
VALUES
    ('2025-04-01 10:00:00', '12:30', 'Puerto', 'Balcarce', 'Carga de materiales de construcción', 123, 'CNT-001', '2025-04-15', 'CONFIRMADO', 'Ninguna', 5),
    ('2025-04-02 11:00:00', '13:00', 'Vicente López', 'Puerto', 'Retorno con contenedores vacíos', 456, 'CNT-002', '2025-04-16', 'CONFIRMADO', 'Revisar estado del contenedor', 8),
    ('2025-04-03 09:00:00', '09:30', 'Puerto', 'Olivos', 'Transporte de mercaderías', 789, 'CNT-003', '2025-04-17', 'PENDIENTE', 'Verificar peso del contenedor', 3),
    ('2025-04-04 12:00:00', '10:00', 'Barracas', 'Puerto', 'Carga de contenedores para exportación', 101, 'CNT-004', '2025-04-18', 'CONFIRMADO', 'Revisar documentación', 9),
    ('2025-04-05 10:00:00', '09:30', 'Puerto', 'Azul', 'Transporte de materiales peligrosos', 112, 'CNT-005', '2025-04-19', 'PENDIENTE', 'Necesita permisos especiales', 1),
    ('2025-04-06 11:00:00', '07:00', 'Longchamps', 'Puerto', 'Retorno con mercaderías', 131, 'CNT-006', '2025-05-20', 'CONFIRMADO', 'Revisar estado del camión', 6),
    ('2025-04-07 09:00:00', '07:30', 'Puerto', 'Ramos Mejía', 'Carga de alimentos', 141, 'CNT-007', '2025-05-21', 'CANCELADO', 'Verificar temperatura del contenedor', 4),
    ('2025-04-08 12:00:00', '08:30', 'Ramos Mejía', 'Puerto', 'Retorno con contenedores vacíos', 151, 'CNT-008', '2025-04-22', 'CONFIRMADO', 'Revisar estado del contenedor', 10),
    ('2025-04-09 10:00:00', '18:30', 'Puerto ', 'Olavarría', 'Transporte de maquinaria pesada', 161, 'CNT-009', '2025-04-23', 'PENDIENTE', 'Necesita permisos especiales', 2),
    ('2025-04-10 11:00:00', '16:30', 'Tigre', 'Puerto', 'Carga de contenedores para importación', 171, 'CNT-010', '2025-04-24', 'CONFIRMADO', 'Revisar documentación', 7),
    ('2025-04-11 09:00:00', '14:00', 'Puerto', 'Palermo', 'Transporte de mercaderías', 181, 'CNT-011', '2025-05-25', 'CANCELADO', 'Verificar peso del contenedor', 11),
    ('2025-04-12 12:00:00', '08:00', 'Palermo', 'Puerto', 'Retorno con mercaderías', 191, 'CNT-012', '2025-04-26', 'CONFIRMADO', 'Revisar estado del camión', 5),
    ('2025-04-13 10:00:00', '13:00', 'Puerto', 'Bulogne', 'Carga de materiales de construcción', 201, 'CNT-013', '2025-04-27', 'PENDIENTE', 'Ninguna', 8),
    ('2025-04-14 11:00:00', '14:00', 'Bulogne', 'Puerto', 'Retorno con contenedores vacíos', 211, 'CNT-014', '2025-04-28', 'CONFIRMADO', 'Revisar estado del contenedor', 3),
    ('2025-04-15 09:00:00', '10:00', 'Puerto', 'Zona Sur', 'Transporte de mercaderías', 221, 'CNT-015', '2025-04-29', 'PENDIENTE', 'Verificar peso del contenedor', 9),
    ('2025-04-16 12:00:00', '08:00', 'San Vicente', 'Puerto', 'Carga de contenedores para exportación', 231, 'CNT-016', '2025-04-30', 'CONFIRMADO', 'Revisar documentación', 1),
    ('2025-04-17 10:00:00', '13:30', 'Puerto', 'Quilmes', 'Transporte de materiales peligrosos', 241, 'CNT-017', '2025-04-30', 'PENDIENTE', 'Necesita permisos especiales', 6),
    ('2025-04-18 11:00:00', '18:00', 'Azul', 'Puerto', 'Retorno con mercaderías', 251, 'CNT-018', '2025-05-01', 'CONFIRMADO', 'Revisar estado del camión', 4);
    
select * from viajes_confirmados;
INSERT INTO viajes_confirmados (
    id_solicitud_viaje,
    Fecha_creacion,
    id_conductor
)
VALUES
	(1, '2024-03-02 11:00:00', 2),
    (2, '2024-03-02 11:00:00', 8),
    (4, '2024-03-04 12:00:00', 9),
    (6, '2024-03-06 11:00:00', 6),
    (8, '2024-03-08 12:00:00', 10),
    (10, '2024-03-10 11:00:00', 7),
    (12, '2024-03-12 12:00:00', 5),
    (14, '2024-03-14 11:00:00', 3),
    (16, '2024-03-16 12:00:00', 1),
    (18, '2024-03-18 11:00:00', 4);
    
    
INSERT INTO solicitudes_viajes (
    Fecha_creacion,
    Hora,
    Lugar_carga,
    Lugar_destino,
    Detalle,
    Ref,
    N°_contenedor,
    Vencimiento,
    Estado,
    Observaciones,
    id_usuario
)   
VALUES ('2025-03-28 11:00:00', '18:00', 'Azul', 'Puerto', 'Retorno con mercaderías', 252, 'CNT-018', '2025-04-15', 'CONFIRMADO', 'Revisar estado del camión', 4); 

INSERT INTO viajes_confirmados (
    id_solicitud_viaje,
    Fecha_creacion,
    id_conductor
)
VALUES 
(19, '2025-03-28 11:00:00', 4);

SELECT * FROM facturas;
select * FROM administradores;

INSERT INTO facturas(
    Fecha_creacion,
    Monto,
    id_viaje_confirmado,
    id_administrador
)
VALUES ('2025-03-29 20:00:00',450000,10,6);



INSERT INTO solicitudes_viajes (
    Fecha_creacion,
    Hora,
    Lugar_carga,
    Lugar_destino,
    Detalle,
    Ref,
    N°_contenedor,
    Vencimiento,
    Estado,
    Observaciones,
    id_usuario
)   
VALUES ('2025-03-29', '18:00', 'Chivilcoy', 'Puerto', 'Retorno con mercaderías', 253, 'CNT-014', '2025-04-15', 'PENDIENTE', 'Revisar estado del camión', 4); 


CREATE VIEW vista_administradores_básicos
	AS SELECT id_administrador, Nombre, Apellido, Email 
		FROM administradores WHERE Rol='BASIC';

CREATE VIEW vista_choferes_con_vehículo 
	AS SELECT c.id_conductor, CONCAT(c.Nombre,' ',c.Apellido) as Conductor, c.Tipo, v.Patente, v.Tipo AS Tipo_vehículo
		FROM conductores c JOIN vehiculos v ON c.id_vehiculo=v.Patente;

CREATE VIEW vista_solicitudes_viajes_a_vencer
	AS SELECT sv.Lugar_carga, sv.Lugar_destino, sv.Detalle, sv.N°_contenedor, sv.Vencimiento,u.id_usuario AS Usuario
		FROM solicitudes_viajes sv JOIN usuarios u ON sv.id_usuario=u.id_usuario 
        WHERE Vencimiento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 10 DAY);  


CREATE VIEW vista_viajes_confirmados 
			AS SELECT vc.id_solicitud_viaje, vc.Fecha_creacion, CONCAT(c.Nombre,' ',c.Apellido) AS Conductor, c.Tipo
            FROM viajes_confirmados vc JOIN  conductores c ON c.id_conductor=vc.id_conductor;
  
        
CREATE VIEW vista_solicitudes_viajes_cancelados
	AS SELECT sv.id_solicitud_viaje, sv.Lugar_carga, sv.Lugar_destino,sv.Detalle, u.id_usuario AS Usuario, sv.Estado
		FROM solicitudes_viajes sv JOIN usuarios u ON sv.id_usuario=u.id_usuario 
        WHERE sv.Estado='CANCELADO';
        
CREATE VIEW vista_completa_viajes_c AS
SELECT 
    vc.id_viaje_confirmado,
    sv.id_solicitud_viaje,
    sv.Fecha_creacion AS Fecha_solicitud,
    sv.Hora,
    sv.Lugar_carga,
    sv.Lugar_destino,
    sv.Detalle,
    sv.Ref,
    sv.N°_contenedor,
    sv.Vencimiento,
    sv.Estado AS Estado_solicitud,
    sv.Observaciones,
    sv.id_usuario,
    vc.Fecha_creacion AS Fecha_confirmacion,
    CONCAT(c.Nombre, ' ', c.Apellido) AS Conductor,
    c.Tipo AS Tipo_conductor,
    v.Patente,
    v.Tipo AS Tipo_vehiculo
FROM 
    viajes_confirmados vc
JOIN 
    solicitudes_viajes sv ON vc.id_solicitud_viaje = sv.id_solicitud_viaje
JOIN 
    conductores c ON vc.id_conductor = c.id_conductor
LEFT JOIN 
    vehiculos v ON c.id_vehiculo = v.Patente;
  
 SELECT * FROM vista_administradores_básicos; 
 SELECT * FROM vista_choferes_con_vehículo;
 SELECT * FROM vista_solicitudes_viajes_a_vencer; 
 SELECT * FROM vista_viajes_confirmados;        
 SELECT * FROM vista_solicitudes_viajes_cancelados;
 SELECT * FROM vista_completa_viajes_c;
 
 #Procedimiento para generar un ranking de conductores con cantidad de viajes realizados en un determinado período#
DELIMITER //
CREATE PROCEDURE RankingConductores (
	IN fecha_inicio DATE, IN fecha_fin DATE
)
BEGIN 
	SELECT 
		CONCAT(c.Nombre,' ',c.Apellido),
        COUNT(vc.id_viaje_confirmado) AS Total_viajes
     FROM viajes_confirmados vc
     JOIN conductores c ON vc.id_conductor=c.id_conductor
     WHERE
		(fecha_inicio IS NULL OR DATE(vc.Fecha_creacion) >= fecha_inicio)
        AND (fecha_fin IS NULL OR DATE(vc.fecha_creacion)<=  fecha_fin)
     GROUP BY c.id_conductor
     ORDER BY Total_viajes DESC;
END  //
DELIMITER ;
CALL RankingConductores(NULL,NULL);

#Procedimiento para ver los clientes vigentes#
DELIMITER $$
CREATE PROCEDURE Tipos_Usuarios(
    IN tipo VARCHAR(50)
    )
BEGIN
    SELECT * 
    FROM usuarios 
    WHERE Rol = tipo;
END $$
DELIMITER ;

CALL Tipos_Usuarios("CLIENTE");


#Función para saber el estado de la solicitud antes de asignar un chofer#
DELIMITER $$
CREATE FUNCTION EstadoSolicitud(id_solicitud INT) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE p_estado VARCHAR(20);
    SELECT Estado INTO p_estado FROM Solicitudes_viajes WHERE id_solicitud_viaje = id_solicitud;
    RETURN p_estado;
END $$
DELIMITER ;

SELECT * FROM solicitudes_viajes;
SELECT EstadoSolicitud(15) AS estado_solicitud;

#Función para saber a que vehículo se le ha asignado o no un chofer#
DELIMITER $$ 
CREATE FUNCTION VehículoAsignado (p_patente VARCHAR(50))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	RETURN EXISTS (
        SELECT 1 
        FROM conductores 
        WHERE id_vehiculo = p_patente
    );
END $$
DELIMITER ;

SELECT VehiculoAsignado('CD398GR') AS vehiculo_asignado;

#TRIGER PARA CAMBIAR EL ESTADO DE LA SOLICITUD DE VIAJE Y CONFIRMARLO#

DELIMITER $$
CREATE TRIGGER t_confirmar_solicitud
AFTER INSERT
ON viajes_confirmados
FOR EACH ROW
BEGIN
	UPDATE solicitudes_viajes 
    SET Estado="CONFIRMADO"
    WHERE id_solicitud_viaje = NEW.id_solicitud_viaje;
END $$
DELIMITER ;

INSERT INTO viajes_confirmados (id_solicitud_viaje, Fecha_creacion, id_conductor)
VALUES (20, NOW(), 5); 

SELECT * FROM viajes_confirmados;
select * FROM solicitudes_viajes;


#CREAR TRIGGER PARA CHEQUEAR QUE EL QUE GENERE LAS FACTURAS SEA UNA ADMINISTRADOR PREMIUM #
DELIMITER $$
CREATE  TRIGGER t_chequear_admin
BEFORE INSERT 
ON facturas
FOR EACH ROW
BEGIN
	DECLARE rol_admin VARCHAR(20);
    SELECT Rol INTO rol_admin
    FROM administradores
    WHERE id_administrador = NEW.id_administrador;
    
	IF rol_admin != "PREMIUM" THEN
    SIGNAL SQLSTATE   "45000"
     SET MESSAGE_TEXT = "Usted no tiene permisos para generar facturas";
    END IF; 
END $$
DELIMITER ;








