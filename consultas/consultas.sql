-- Consulta 1: Mostrar todos los clientes registrados
SELECT *
FROM cliente;

-- Consulta 2: Mostrar el nombre y correo electrónico de todos los clientes
SELECT nombre, email
FROM cliente;

-- Consulta 3: Mostrar los pedidos que se encuentran en estado Pendiente
SELECT *
FROM pedido_online
WHERE estado = 'Pendiente';

-- Consulta 4: Mostrar todos los productos que están activos
SELECT *
FROM producto
WHERE activo = TRUE;

-- Consulta 5: Mostrar los productos cuyo nombre contiene la palabra Samsung
SELECT *
FROM producto
WHERE nombre LIKE '%Samsung%';

-- Consulta 6: Mostrar los pedidos realizados entre el 1 y el 4 de mayo de 2025
SELECT *
FROM pedido_online
WHERE fecha_pedido BETWEEN '2025-05-01' AND '2025-05-04';

-- Consulta 7: Mostrar todos los productos ordenados alfabéticamente por nombre
SELECT *
FROM producto
ORDER BY nombre ASC;

-- Consulta 8: Mostrar los registros del histórico de precios superiores a 500 €
SELECT *
FROM historico_precio
WHERE precio > 500;

-- Consulta 9: Mostrar el nombre y apellidos de cada cliente junto con la fecha de sus pedidos
SELECT c.nombre, c.apellidos, p.fecha_pedido
FROM cliente c
JOIN pedido_online p
ON c.id_cliente = p.id_cliente;

-- Consulta 10: Mostrar cada producto junto con la categoría a la que pertenece
SELECT p.nombre AS producto,
       c.nombre AS categoria
FROM producto p
JOIN subcategoria s
ON p.id_subcategoria = s.id_subcategoria
JOIN categoria c
ON s.id_categoria = c.id_categoria;

-- Consulta 11: Contar el número total de pedidos realizados por cada cliente
SELECT c.nombre,
       c.apellidos,
       COUNT(p.id_pedido) AS total_pedidos
FROM cliente c
LEFT JOIN pedido_online p
ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;

-- Consulta 12: Calcular el importe total gastado por cada cliente en pedidos online
SELECT c.nombre,
       c.apellidos,
       SUM(p.total) AS gasto_total
FROM cliente c
JOIN pedido_online p
ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;

-- Consulta 13: Mostrar la puntuación media obtenida por cada producto valorado
SELECT p.nombre,
       AVG(v.puntuacion) AS puntuacion_media
FROM producto p
JOIN valoracion v
ON p.id_producto = v.id_producto
GROUP BY p.id_producto;

-- Consulta 14: Mostrar los productos que tienen promociones asociadas junto al descuento aplicado
SELECT p.nombre AS producto,
       pr.nombre AS promocion,
       pr.porcentaje_descuento
FROM producto p
JOIN producto_promocion pp
ON p.id_producto = pp.id_producto
JOIN promocion pr
ON pp.id_promocion = pr.id_promocion;