## Descripción

Este directorio contiene **consultas SQL avanzadas** para extraer información significativa de la base de datos. Incluye ejemplos de SELECT, JOIN, subconsultas, agregaciones y más.

---

## 📁 Contenido

- `consultas.sql` - Colección de 10+ consultas SQL de diferentes niveles de complejidad

---

## 🎯 Propósito

Las consultas demuestran:

- ✅ Uso de SELECT básico y avanzado
- ✅ Filtrado con WHERE
- ✅ Uniones de tablas con JOIN (INNER, LEFT)
- ✅ Funciones de agregación (COUNT, SUM, AVG)
- ✅ Agrupamiento con GROUP BY
- ✅ Filtrado de grupos con HAVING
- ✅ Subconsultas correlacionadas
- ✅ Ordenamiento con ORDER BY
- ✅ Alias de tablas y columnas

---

## 🚀 Cómo Ejecutar

### Opción 1: MySQL desde Terminal

```bash
mysql -u root -p tienda_online < Consultas/consultas.sql
```

### Opción 2: MySQL Workbench

1. Abrir MySQL Workbench
2. Conectarse a `tienda_online_db`
3. Abrir `consultas.sql`
4. Ejecutar consultas individuales o todas

### Opción 3: Ejecutar una por una

```sql
USE tienda_online_db;

-- Copia y ejecuta cada consulta del archivo
SELECT * FROM clientes;
```

---

## 📊 Catálogo de Consultas

### 1️⃣ Consulta Básica: Todos los Clientes

**Propósito:** Obtener la lista completa de clientes registrados

```sql
SELECT * FROM clientes;
```

**Resultado esperado:**
```
+------------+----------------+------------------+----------------------+----------+----------------+
| id_cliente | nombre         | email            | direccion            | telefono | fecha_registro |
+------------+----------------+------------------+----------------------+----------+----------------+
|          1 | Juan Pérez     | juan@email.com   | Nueva Avenida 999    | 555-0001 | 2025-11-30     |
|          2 | María González | maria@email.com  | Calle Secundaria 456 | 555-0002 | 2025-11-30     |
|          3 | Carlos López   | carlos@email.com | Plaza Central 789    | 555-0003 | 2025-11-30     |
+------------+----------------+------------------+----------------------+----------+----------------+
```

---

### 2️⃣ Consulta con WHERE: Pedidos de un Cliente

**Propósito:** Filtrar pedidos de un cliente específico

```sql
SELECT * FROM pedidos WHERE id_cliente = 1;
```

**Conceptos:**
- Filtrado con WHERE
- Comparación con operador =

---

### 3️⃣ INNER JOIN: Pedidos con Cliente

**Propósito:** Combinar información de pedidos con datos del cliente

```sql
SELECT 
    p.id_pedido,
    c.nombre,
    p.fecha_pedido,
    p.total,
    p.estado
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente;
```

**Conceptos:**
- INNER JOIN para combinar tablas
- Alias de tablas (p, c)
- Relación 1:N

**Resultado esperado:**
```
+-----------+----------------+---------------------+--------+------------+
| id_pedido | nombre         | fecha_pedido        | total  | estado     |
+-----------+----------------+---------------------+--------+------------+
|         1 | Juan Pérez     | 2025-11-30 10:30:00 | 829.98 | Completado |
|         2 | María González | 2025-11-30 11:15:00 |  59.98 | Pendiente  |
|         3 | Carlos López   | 2025-11-30 14:20:00 |  45.00 | Enviado    |
+-----------+----------------+---------------------+--------+------------+
```

---

### 4️⃣ JOIN Múltiple: Detalle Completo de Pedidos

**Propósito:** Ver qué productos compró cada cliente

```sql
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
```

**Conceptos:**
- JOIN de 4 tablas
- Alias de columnas con AS
- Cálculos en SELECT (cantidad * precio)

**Resultado esperado:**
```
+-----------+----------------+---------------------+----------+-----------------+----------+
| id_pedido | cliente        | producto            | cantidad | precio_unitario | subtotal |
+-----------+----------------+---------------------+----------+-----------------+----------+
|         1 | Juan Pérez     | Laptop Dell         |        1 |          799.99 |   799.99 |
|         1 | Juan Pérez     | Mouse Inalámbrico   |        1 |           29.99 |    29.99 |
|         2 | María González | Camiseta Polo       |        2 |           19.99 |    39.98 |
|         2 | María González | Pantalón Jeans      |        1 |           39.99 |    39.99 |
|         3 | Carlos López   | Lámpara LED         |        1 |           45.00 |    45.00 |
+-----------+----------------+---------------------+----------+-----------------+----------+
```

---

### 5️⃣ GROUP BY: Total de Ventas por Cliente

**Propósito:** Calcular cuánto ha gastado cada cliente

```sql
SELECT 
    c.nombre,
    COUNT(p.id_pedido) AS total_pedidos,
    SUM(p.total) AS monto_total
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre;
```

**Conceptos:**
- LEFT JOIN (incluye clientes sin pedidos)
- Funciones agregadas: COUNT(), SUM()
- GROUP BY para agrupar resultados

**Resultado esperado:**
```
+----------------+---------------+-------------+
| nombre         | total_pedidos | monto_total |
+----------------+---------------+-------------+
| Juan Pérez     |             1 |      829.98 |
| María González |             1 |       59.98 |
| Carlos López   |             1 |       45.00 |
+----------------+---------------+-------------+
```

---

### 6️⃣ GROUP BY con HAVING: Productos Más Vendidos

**Propósito:** Identificar qué productos tienen mayor demanda

```sql
SELECT 
    pr.nombre,
    SUM(dp.cantidad) AS unidades_vendidas
FROM detalle_pedidos dp
INNER JOIN productos pr ON dp.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
HAVING SUM(dp.cantidad) > 0
ORDER BY unidades_vendidas DESC;
```

**Conceptos:**
- GROUP BY para agrupar por producto
- HAVING para filtrar grupos
- ORDER BY DESC para ordenar descendente

**Resultado esperado:**
```
+---------------------+--------------------+
| nombre              | unidades_vendidas  |
+---------------------+--------------------+
| Camiseta Polo       |                  2 |
| Laptop Dell         |                  1 |
| Mouse Inalámbrico   |                  1 |
| Pantalón Jeans      |                  1 |
| Lámpara LED         |                  1 |
+---------------------+--------------------+
```

---

### 7️⃣ Subconsulta: Clientes con Compras Mayores al Promedio

**Propósito:** Encontrar clientes VIP (que gastan más que el promedio)

```sql
SELECT nombre, email
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente 
    FROM pedidos 
    WHERE total > (SELECT AVG(total) FROM pedidos)
);
```

**Conceptos:**
- Subconsulta anidada
- Función AVG() para promedio
- Operador IN para coincidencias múltiples

---

### 8️⃣ Productos por Categoría

**Propósito:** Ver el catálogo organizado por categorías

```sql
SELECT 
    cat.nombre AS categoria,
    pr.nombre AS producto,
    pr.precio,
    pr.stock
FROM productos pr
INNER JOIN categorias cat ON pr.id_categoria = cat.id_categoria
ORDER BY cat.nombre, pr.nombre;
```

**Conceptos:**
- JOIN entre productos y categorías
- ORDER BY múltiple (por categoría, luego por producto)

**Resultado esperado:**
```
+-------------+---------------------+--------+-------+
| categoria   | producto            | precio | stock |
+-------------+---------------------+--------+-------+
| Electrónica | Laptop Dell         | 799.99 |    10 |
| Electrónica | Mouse Inalámbrico   |  29.99 |    50 |
| Hogar       | Lámpara LED         |  45.00 |    30 |
| Ropa        | Camiseta Polo       |  19.99 |   100 |
| Ropa        | Pantalón Jeans      |  39.99 |    75 |
+-------------+---------------------+--------+-------+
```

---

### 9️⃣ Métodos de Pago Utilizados

**Propósito:** Análisis de preferencias de pago

```sql
SELECT 
    mp.tipo_pago,
    COUNT(*) AS veces_usado,
    SUM(mp.monto) AS total_procesado
FROM metodos_pago mp
GROUP BY mp.tipo_pago;
```

**Conceptos:**
- GROUP BY para agrupar por tipo de pago
- COUNT(*) para contar ocurrencias
- SUM() para totalizar montos

**Resultado esperado:**
```
+---------------------+-------------+------------------+
| tipo_pago           | veces_usado | total_procesado  |
+---------------------+-------------+------------------+
| Tarjeta de Crédito  |           1 |           829.98 |
| PayPal              |           1 |            59.98 |
| Transferencia       |           1 |            45.00 |
+---------------------+-------------+------------------+
```

---

### 🔟 LEFT JOIN: Todos los Clientes y sus Pedidos

**Propósito:** Ver TODOS los clientes, incluso los que no han comprado

```sql
SELECT 
    c.nombre,
    c.email,
    COALESCE(COUNT(p.id_pedido), 0) AS cantidad_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.email;
```

**Conceptos:**
- LEFT JOIN (muestra todos los clientes)
- COALESCE() para reemplazar NULL por 0
- Diferencia entre INNER JOIN y LEFT JOIN

---

## 📈 Consultas Avanzadas Adicionales

### Ranking de Productos Más Caros
```sql
SELECT nombre, precio
FROM productos
ORDER BY precio DESC
LIMIT 3;
```

### Productos con Poco Stock
```sql
SELECT nombre, stock
FROM productos
WHERE stock < 20
ORDER BY stock ASC;
```

### Ingresos Totales del Día
```sql
SELECT 
    DATE(fecha_pedido) AS fecha,
    SUM(total) AS ingresos_dia
FROM pedidos
WHERE DATE(fecha_pedido) = CURDATE()
GROUP BY DATE(fecha_pedido);
```

### Clientes Sin Pedidos
```sql
SELECT nombre, email
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM pedidos p 
    WHERE p.id_cliente = c.id_cliente
);
```

---

## 🎓 Conceptos SQL Cubiertos

### Cláusulas SELECT
- [x] SELECT básico
- [x] SELECT con múltiples columnas
- [x] SELECT con cálculos
- [x] SELECT DISTINCT

### Filtros y Condiciones
- [x] WHERE con operadores (=, <, >, <=, >=, <>)
- [x] AND, OR, NOT
- [x] IN, NOT IN
- [x] BETWEEN
- [x] LIKE para búsquedas de texto

### Joins
- [x] INNER JOIN (solo coincidencias)
- [x] LEFT JOIN (incluye no coincidentes)
- [x] JOIN de 3+ tablas
- [x] Self JOIN

### Agregaciones
- [x] COUNT() - Contar registros
- [x] SUM() - Sumar valores
- [x] AVG() - Promedio
- [x] MAX() - Valor máximo
- [x] MIN() - Valor mínimo
- [x] GROUP BY - Agrupar
- [x] HAVING - Filtrar grupos

### Subconsultas
- [x] Subconsulta en WHERE
- [x] Subconsulta en SELECT
- [x] Subconsulta en FROM
- [x] EXISTS, NOT EXISTS

### Ordenamiento y Limitación
- [x] ORDER BY ASC/DESC
- [x] LIMIT
- [x] OFFSET

---

## 🔧 Para Optimización

1. **Usar índices** en columnas frecuentemente filtradas
2. **Evitar SELECT *** en producción (especifica columnas)
3. **Limitar resultados** con LIMIT cuando sea posible
4. **Usar EXPLAIN** para analizar queries lentas
5. **Crear vistas** para queries complejas reutilizables

```sql
-- Crear una vista
CREATE VIEW vista_pedidos_completos AS
SELECT 
    p.id_pedido,
    c.nombre AS cliente,
    p.total,
    p.estado
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente;

-- Usar la vista
SELECT * FROM vista_pedidos_completos WHERE estado = 'Completado';
```

---