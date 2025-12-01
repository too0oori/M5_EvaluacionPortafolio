-- Inserción de datos de prueba
USE tienda_online_db;

-- Insertar Categorías
INSERT INTO categorias (nombre, descripcion) VALUES
('Electrónica', 'Productos electrónicos y tecnología'),
('Ropa', 'Vestimenta y accesorios'),
('Hogar', 'Artículos para el hogar');

-- Insertar Clientes
INSERT INTO clientes (nombre, email, direccion, telefono) VALUES
('Juan Pérez', 'juan@email.com', 'Av. Principal 123', '555-0001'),
('María González', 'maria@email.com', 'Calle Secundaria 456', '555-0002'),
('Carlos López', 'carlos@email.com', 'Plaza Central 789', '555-0003');

-- Insertar Productos
INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES
('Laptop Dell', 'Laptop 16GB RAM, 512GB SSD', 799.99, 10, 1),
('Mouse Inalámbrico', 'Mouse ergonómico Bluetooth', 29.99, 50, 1),
('Camiseta Polo', 'Camiseta 100% algodón', 19.99, 100, 2),
('Pantalón Jeans', 'Pantalón mezclilla azul', 39.99, 75, 2),
('Lámpara LED', 'Lámpara de escritorio regulable', 45.00, 30, 3);

-- Insertar Pedidos
INSERT INTO pedidos (id_cliente, total, estado) VALUES
(1, 829.98, 'Completado'),
(2, 59.98, 'Pendiente'),
(3, 45.00, 'Enviado');

-- Insertar Detalle de Pedidos
INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 799.99),
(1, 2, 1, 29.99),
(2, 3, 2, 19.99),
(2, 4, 1, 39.99),
(3, 5, 1, 45.00);

-- Insertar Métodos de Pago
INSERT INTO metodos_pago (id_pedido, tipo_pago, monto) VALUES
(1, 'Tarjeta de Crédito', 829.98),
(2, 'PayPal', 59.98),
(3, 'Transferencia', 45.00);

-- Actualización de datos
UPDATE clientes 
SET direccion = 'Nueva Avenida 999' 
WHERE id_cliente = 1;

-- Eliminación de datos
DELETE FROM pedidos WHERE estado = 'Cancelado';