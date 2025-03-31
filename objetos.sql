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





