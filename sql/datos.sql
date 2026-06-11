INSERT INTO cliente
(nombre, apellidos, email, password, fecha_nacimiento, fecha_registro)
VALUES
('Juan', 'García López', 'juan.garcia@gmail.com', '1234', '1995-03-15', '2024-01-10'),
('María', 'Sánchez Ruiz', 'maria.sanchez@gmail.com', '1234', '1998-07-22', '2024-02-18'),
('Carlos', 'Martín Pérez', 'carlos.martin@gmail.com', '1234', '1992-11-05', '2024-03-02');

INSERT INTO sede
(nombre, tipo, ciudad, direccion)
VALUES
('Sede Central Valencia', 'sede central', 'Valencia', 'Av. de Aragón 125'),
('Tienda Madrid', 'tienda', 'Madrid', 'Gran Vía 45'),
('Tienda Barcelona', 'tienda', 'Barcelona', 'Passeig de Gràcia 80');

INSERT INTO empleado
(id_sede, nombre, apellidos, dni, email_corporativo, fecha_incorporacion, puesto)
VALUES
(1, 'Ana', 'Ferrer', '11111111A', 'a.ferrer@nexshop.es', '2018-01-15', 'Directora Operaciones'),
(1, 'David', 'Cano', '22222222B', 'd.cano@nexshop.es', '2019-03-20', 'Logística'),
(1, 'Laura', 'Pons', '33333333C', 'l.pons@nexshop.es', '2020-06-10', 'Atención Cliente'),
(2, 'Miguel', 'Torres', '44444444D', 'm.torres@nexshop.es', '2021-02-14', 'Encargado'),
(3, 'Sara', 'López', '55555555E', 's.lopez@nexshop.es', '2021-09-01', 'Encargada');

INSERT INTO direccion
(id_cliente, tipo_direccion, calle, numero, piso, codigo_postal, ciudad, pais)
VALUES
(1, 'domicilio', 'Calle Mayor', '12', '2A', '28001', 'Madrid', 'España'),
(1, 'trabajo', 'Avenida Europa', '35', '3B', '28020', 'Madrid', 'España'),
(2, 'domicilio', 'Calle Colón', '8', '1C', '46004', 'Valencia', 'España'),
(3, 'domicilio', 'Gran Via', '120', '4D', '08008', 'Barcelona', 'España');

INSERT INTO categoria (nombre, descripcion)
VALUES
('Informática', 'Productos relacionados con ordenadores y tecnología'),
('Telefonía', 'Smartphones y accesorios'),
('Gaming', 'Productos para videojuegos');

INSERT INTO subcategoria (id_categoria, nombre, descripcion)
VALUES
(1, 'Portátiles', 'Ordenadores portátiles'),
(1, 'Monitores', 'Pantallas y monitores'),
(2, 'Smartphones', 'Teléfonos móviles'),
(3, 'Consolas', 'Consolas de videojuegos');

INSERT INTO producto (id_subcategoria, nombre, descripcion, referencia, activo)
VALUES
(1, 'ASUS ROG Strix G16', 'Portátil gaming', 'PORT001', TRUE),
(1, 'Lenovo ThinkPad E14', 'Portátil oficina', 'PORT002', TRUE),
(2, 'LG UltraGear 27', 'Monitor gaming 27 pulgadas', 'MON001', TRUE),
(2, 'Samsung Odyssey G5', 'Monitor curvo', 'MON002', TRUE),
(3, 'iPhone 17 Pro', 'Smartphone Apple', 'MOV001', TRUE),
(3, 'Samsung Galaxy S26', 'Smartphone Samsung', 'MOV002', TRUE),
(4, 'PlayStation 5', 'Consola Sony', 'CON001', TRUE),
(4, 'Xbox Series X', 'Consola Microsoft', 'CON002', TRUE);

INSERT INTO historico_precio (id_producto, precio, fecha_inicio, fecha_fin)
VALUES
(1, 1499.99, '2025-01-01', NULL),
(2, 899.99, '2025-01-01', NULL),
(3, 299.99, '2025-01-01', NULL),
(4, 349.99, '2025-01-01', NULL),
(5, 1299.99, '2025-01-01', NULL),
(6, 1099.99, '2025-01-01', NULL),
(7, 549.99, '2025-01-01', NULL),
(8, 549.99, '2025-01-01', NULL);

INSERT INTO promocion
(nombre, descripcion, porcentaje_descuento, fecha_inicio, fecha_fin)
VALUES
('Black Friday', 'Descuentos especiales', 20, '2025-11-20', '2025-11-30'),
('Vuelta al Cole', 'Promoción informática', 15, '2025-09-01', '2025-09-15');

INSERT INTO producto_promocion
(id_producto, id_promocion)
VALUES
(1,1),
(3,1),
(5,1),
(2,2),
(4,2);

INSERT INTO proveedor
(id_representante, nombre, cif, email, telefono, direccion)
VALUES
(2, 'TechDistribuciones S.L.', 'B12345678', 'contacto@techdist.es', '961111111', 'Valencia'),
(2, 'Global Electronics', 'B87654321', 'ventas@globalelec.es', '962222222', 'Madrid');

INSERT INTO condicion_suministro
(id_producto, id_proveedor, precio_coste, plazo_entrega_dias, fecha_inicio, fecha_fin)
VALUES
(1,1,1200.00,5,'2025-01-01',NULL),
(2,1,700.00,5,'2025-01-01',NULL),
(3,2,220.00,7,'2025-01-01',NULL),
(5,2,1000.00,10,'2025-01-01',NULL);

INSERT INTO stock
(id_producto, id_sede, cantidad)
VALUES
(1,1,15),
(2,1,20),
(3,2,12),
(4,2,8),
(5,3,10),
(6,3,14),
(7,1,6),
(8,2,5);

INSERT INTO transferencia_stock
(id_producto, id_sede_origen, id_sede_destino, id_empleado_autoriza, fecha, cantidad, estado)
VALUES
(3,1,2,2,'2025-05-10',5,'Completada'),
(5,3,1,2,'2025-05-15',2,'Completada');

INSERT INTO pedido_online
(id_cliente, id_direccion_envio, fecha_pedido, estado, total)
VALUES
(1, 1, '2025-05-01', 'Entregado', 1799.98),
(2, 3, '2025-05-03', 'Enviado', 1299.99),
(3, 4, '2025-05-05', 'Pendiente', 549.99);

INSERT INTO linea_pedido
(id_pedido, id_producto, cantidad, precio_unitario, descuento_aplicado)
VALUES
(1, 1, 1, 1499.99, 0),
(1, 3, 1, 299.99, 0),
(2, 5, 1, 1299.99, 0),
(3, 7, 1, 549.99, 0);

INSERT INTO envio
(id_pedido, id_sede_origen, numero_seguimiento, transportista,
 fecha_envio, fecha_estimada_entrega, estado)
VALUES
(1, 1, 'SEUR123456', 'SEUR', '2025-05-02', '2025-05-04', 'Entregado'),
(2, 1, 'MRW987654', 'MRW', '2025-05-04', '2025-05-06', 'En reparto'),
(3, 2, 'CORREOS555', 'Correos Express', NULL, '2025-05-08', 'Preparando');

INSERT INTO venta_presencial
(id_cliente, id_empleado, id_sede, fecha_venta, total)
VALUES
(NULL, 4, 2, '2025-05-07', 299.99),
(1, 4, 2, '2025-05-08', 549.99);

INSERT INTO linea_venta
(id_venta, id_producto, cantidad, precio_unitario, descuento_aplicado)
VALUES
(1, 3, 1, 299.99, 0),
(2, 7, 1, 549.99, 0);

INSERT INTO devolucion
(id_venta, fecha_devolucion, motivo, estado)
VALUES
(1, '2025-05-10', 'Producto defectuoso', 'Aceptada');

INSERT INTO ticket_incidencia
(id_cliente, id_pedido, id_empleado_agente, asunto, descripcion,
 fecha_apertura, fecha_cierre, estado, resolucion)
VALUES
(1, 1, 3, 'Retraso en entrega',
 'El pedido llegó con retraso',
 '2025-05-05',
 '2025-05-06',
 'Resuelto',
 'Compensación aplicada'),

(2, NULL, 3, 'Consulta general',
 'Pregunta sobre promociones',
 '2025-05-08',
 NULL,
 'Abierto',
 NULL);

INSERT INTO valoracion
(id_cliente, id_producto, puntuacion, comentario,
 fecha_valoracion, verificada)
VALUES
(1, 1, 5, 'Excelente portátil', '2025-05-10', TRUE),
(2, 5, 4, 'Muy buen móvil', '2025-05-11', TRUE),
(3, 7, 5, 'Gran consola', '2025-05-12', FALSE);

INSERT INTO movimiento_puntos
(id_cliente, id_pedido, fecha_movimiento,
 tipo_movimiento, puntos, descripcion)
VALUES
(1, 1, '2025-05-01', 'Ganado', 17999, 'Compra pedido 1'),
(1, 1, '2025-05-02', 'Canjeado', 1000, 'Descuento aplicado'),
(2, 2, '2025-05-03', 'Ganado', 12999, 'Compra pedido 2'),
(3, 3, '2025-05-05', 'Ganado', 5499, 'Compra pedido 3');