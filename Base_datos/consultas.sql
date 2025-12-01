USE tienda_online_db;

-- 1. Consulta básica para obtener todos los clientes
SELECT * FROM clientes;

-- 2. Consulta con WHERE para obtener pedidos de un cliente específico
SELECT * FROM pedidos WHERE id_cliente = 1;

-- 3. JOIN para obtener pedidos con información del cliente
SELECT p.id_pedido, c.nombre, p.fecha_pedido, p.total, p.estado
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente;

-- 4. JOIN múltiple para obtener detalle completo de pedidos
SELECT 
    p.id_pedido,
    c.nombre AS cliente,
    pr.nombre AS producto,
    dp.cantidad,
    dp.precio_unitario,
    (dp.cantidad * dp.precio_unitario) AS subtotal
FROM detalle_pedidos dp
INNER JOIN pedidos p ON dp.id_pedido = p.id_pedido
INNER JOIN clientes c ON p.id_cliente = c.id_cliente
INNER JOIN productos pr ON dp.id_producto = pr.id_producto;

-- 5. GROUP BY para obtener el total de ventas por cliente
SELECT 
    c.nombre,
    COUNT(p.id_pedido) AS total_pedidos,
    SUM(p.total) AS monto_total
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre;

-- 6. GROUP BY con HAVING para obtener los productos más vendidos
SELECT 
    pr.nombre,
    SUM(dp.cantidad) AS unidades_vendidas
FROM detalle_pedidos dp
INNER JOIN productos pr ON dp.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
HAVING SUM(dp.cantidad) > 0
ORDER BY unidades_vendidas DESC;

-- 7. Subconsulta para obtener clientes con pedidos mayores al promedio
SELECT nombre, email
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente 
    FROM pedidos 
    WHERE total > (SELECT AVG(total) FROM pedidos)
);

-- 8. Productos por categoría
SELECT 
    cat.nombre AS categoria,
    pr.nombre AS producto,
    pr.precio,
    pr.stock
FROM productos pr
INNER JOIN categorias cat ON pr.id_categoria = cat.id_categoria
ORDER BY cat.nombre, pr.nombre;

-- 9. Métodos de pago utilizados
SELECT 
    mp.tipo_pago,
    COUNT(*) AS veces_usado,
    SUM(mp.monto) AS total_procesado
FROM metodos_pago mp
GROUP BY mp.tipo_pago;

-- 10. LEFT JOIN para obtener los clientes y sus pedidos (incluye clientes sin pedidos)
SELECT 
    c.nombre,
    c.email,
    -- COALESCE se utiliza para reemplazar NULL con 0
    COALESCE(COUNT(p.id_pedido), 0) AS cantidad_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.email;