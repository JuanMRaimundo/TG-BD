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
        

  
 SELECT * FROM vista_administradores_básicos; 
 SELECT * FROM vista_choferes_con_vehículo;
 SELECT * FROM vista_solicitudes_viajes_a_vencer; 
 SELECT * FROM vista_viajes_confirmados;        
 SELECT * FROM vista_solicitudes_viajes_cancelados;