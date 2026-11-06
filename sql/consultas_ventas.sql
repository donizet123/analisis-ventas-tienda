create database analisis_ventas;
use analisis_ventas;
select * from ventas;

SELECT COUNT(*) AS total_registros
FROM ventas;

DESCRIBE ventas;

SELECT * FROM ventas
LIMIT 10;

SELECT COUNT(*) AS total_ventas
FROM ventas;

DESCRIBE ventas;

SELECT
    COUNT(*) AS operaciones,
    SUM(cantidad) AS unidades_vendidas,
    SUM(importe_venta) AS ingresos_totales,
    AVG(importe_venta) AS ticket_promedio
FROM ventas;



SELECT
    producto,
    SUM(importe_venta) AS ingresos
FROM ventas
GROUP BY producto
ORDER BY ingresos DESC
LIMIT 10;

SELECT
    categoria,
    SUM(importe_venta) AS ingresos
FROM ventas
GROUP BY categoria
ORDER BY ingresos DESC;

SELECT
    vendedor,
    COUNT(*) AS operaciones,
    SUM(importe_venta) AS ingresos
FROM ventas
GROUP BY vendedor
ORDER BY ingresos DESC;


SELECT
    distrito,
    COUNT(*) AS operaciones,
    SUM(importe_venta) AS ingresos
FROM ventas
GROUP BY distrito
ORDER BY ingresos DESC;

SELECT *
FROM ventas
WHERE distrito = 'Ate';

SELECT *
FROM ventas
WHERE importe_venta > 500;

SELECT *
FROM ventas
WHERE distrito = 'Ate'
AND importe_venta > 100;

SELECT
    categoria,
    SUM(importe_venta) AS ingresos
FROM ventas
GROUP BY categoria
HAVING SUM(importe_venta) > 1000
ORDER BY ingresos DESC;

SELECT
    DATE_FORMAT(fecha, '%Y-%m') AS mes,
    SUM(importe_venta) AS ingresos
FROM ventas
GROUP BY DATE_FORMAT(fecha, '%Y-%m')
ORDER BY mes;

SELECT
    metodo_pago,
    COUNT(*) AS operaciones,
    SUM(importe_venta) AS ingresos
FROM ventas
GROUP BY metodo_pago
ORDER BY operaciones DESC;

SELECT
    vendedor,
    COUNT(*) AS operaciones,
    ROUND(AVG(importe_venta), 2) AS ticket_promedio,
    SUM(importe_venta) AS ingresos_totales
FROM ventas
GROUP BY vendedor
ORDER BY ingresos_totales DESC;

SELECT
    id_venta,
    importe_venta,
    CASE
        WHEN importe_venta >= 500 THEN 'Venta alta'
        WHEN importe_venta >= 200 THEN 'Venta media'
        ELSE 'Venta baja'
    END AS tipo_venta
FROM ventas;

CREATE TABLE productos AS
SELECT DISTINCT
    producto,
    categoria,
    precio_unitario
FROM ventas;

ALTER TABLE productos
ADD COLUMN id_producto INT AUTO_INCREMENT PRIMARY KEY FIRST;

SELECT * FROM productos;
SELECT
    v.id_venta,
    p.producto,
    p.categoria,
    v.cantidad,
    v.importe_venta
FROM ventas v
INNER JOIN productos p
    ON v.producto = p.producto;
    
SELECT
    p.producto,
    p.categoria,
    COUNT(v.id_venta) AS operaciones
FROM productos p
LEFT JOIN ventas v
    ON p.producto = v.producto
GROUP BY
    p.producto,
    p.categoria;

SELECT
    id_venta,
    producto,
    importe_venta
FROM ventas
WHERE importe_venta > (
    SELECT AVG(importe_venta)
    FROM ventas
);

SELECT
    vendedor,
    SUM(importe_venta) AS ingresos,
    RANK() OVER (
        ORDER BY SUM(importe_venta) DESC
    ) AS ranking
FROM ventas
GROUP BY vendedor;

WITH ranking_productos AS (
    SELECT
        categoria,
        producto,
        SUM(importe_venta) AS ingresos,
        RANK() OVER (
            PARTITION BY categoria
            ORDER BY SUM(importe_venta) DESC
        ) AS puesto
    FROM ventas
    GROUP BY categoria, producto
)
SELECT *
FROM ranking_productos;














