# 📝 DML - Data Manipulation Language

## Descripción

Este directorio contiene los **scripts de manipulación de datos** para insertar, actualizar y eliminar información en la base de datos. Incluye datos de prueba para todas las tablas del sistema.

---

## 📁 Contenido

- `insertar_datos.sql` - Script con operaciones INSERT, UPDATE y DELETE

---

## 🎯 Propósito

Los scripts DML (Data Manipulation Language) permiten:

- ✅ Insertar datos iniciales (INSERT)
- ✅ Modificar registros existentes (UPDATE)
- ✅ Eliminar datos obsoletos (DELETE)
- ✅ Poblar la base de datos con información de prueba
- ✅ Simular operaciones reales del sistema

---

## 🚀 Cómo Ejecutar

### Opción 1: MySQL desde Terminal

```bash
# Asegúrate de haber ejecutado primero el script DDL
mysql -u root -p tienda_online < DML/insertar_datos.sql
```

### Opción 2: MySQL Workbench

1. Abrir MySQL Workbench
2. Conectarse a la base de datos `tienda_online_db`
3. **File → Open SQL Script**
4. Seleccionar `insertar_datos.sql`
5. Ejecutar con ⚡ (Ctrl+Shift+Enter)

### Opción 3: Desde MySQL CLI

```bash
mysql -u root -p

USE tienda_online_db;
SOURCE DML/insertar_datos.sql;
```

---

## 📊 Datos Insertados

### Resumen de Registros

| Tabla | Cantidad de Registros |
|-------|----------------------|
| categorias | 3 |
| clientes | 3 |
| productos | 5 |
| pedidos | 3 |
| detalle_pedidos | 5 |
| metodos_pago | 3 |

**Total:** 22 registros de ejemplo

---

## 🔧 Operaciones Implementadas

### 1️⃣ INSERT - Inserción de Datos

#### Categorías
```sql
INSERT INTO categorias (nombre, descripcion) VALUES
('Electrónica', 'Productos electrónicos y tecnología'),
('Ropa', 'Vestimenta y accesorios'),
('Hogar', 'Artículos para el hogar');
```

#### Clientes
```sql
INSERT INTO clientes (nombre, email, direccion, telefono) VALUES
('Juan Pérez', 'juan@email.com', 'Av. Principal 123', '555-0001'),
('María González', 'maria@email.com', 'Calle Secundaria 456', '555-0002'),
('Carlos López', 'carlos@email.com', 'Plaza Central 789', '555-0003');
```

#### Productos
```sql
INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES
('Laptop Dell', 'Laptop 16GB RAM, 512GB SSD', 799.99, 10, 1),
('Mouse Inalámbrico', 'Mouse ergonómico Bluetooth', 29.99, 50, 1),
('Camiseta Polo', 'Camiseta 100% algodón', 19.99, 100, 2),
('Pantalón Jeans', 'Pantalón mezclilla azul', 39.99, 75, 2),
('Lámpara LED', 'Lámpara de escritorio regulable', 45.00, 30, 3);
```

---

### 2️⃣ UPDATE - Actualización de Datos

#### Ejemplo 1: Actualizar dirección de cliente
```sql
UPDATE clientes 
SET direccion = 'Nueva Avenida 999' 
WHERE id_cliente = 1;
```

**Efecto:** Cambia la dirección del cliente Juan Pérez

#### Ejemplo 2: Actualizar precio de producto
```sql
UPDATE productos 
SET precio = 749.99 
WHERE id_producto = 1;
```

**Efecto:** Reduce el precio de la Laptop Dell

#### Ejemplo 3: Cambiar estado de pedido
```sql
UPDATE pedidos 
SET estado = 'Enviado' 
WHERE id_pedido = 2;
```

**Efecto:** Actualiza el estado del pedido #2

---

### 3️⃣ DELETE - Eliminación de Datos

#### Ejemplo 1: Eliminar pedidos cancelados
```sql
DELETE FROM pedidos 
WHERE estado = 'Cancelado';
```

**⚠️ Nota:** Este comando está comentado en el script para evitar eliminaciones accidentales.

#### Ejemplo 2: Eliminar productos sin stock
```sql
DELETE FROM productos 
WHERE stock = 0;
```

#### Ejemplo 3: Eliminar clientes inactivos
```sql
DELETE FROM clientes 
WHERE fecha_registro < '2023-01-01';
```

---

## 🔍 Verificar los Datos

Después de ejecutar el script, verificar los datos insertados:

```sql
-- Ver todos los clientes
SELECT * FROM clientes;

-- Ver todos los productos
SELECT * FROM productos;

-- Ver todos los pedidos
SELECT * FROM pedidos;

-- Contar registros por tabla
SELECT 'Clientes' AS tabla, COUNT(*) AS total FROM clientes
UNION ALL
SELECT 'Productos', COUNT(*) FROM productos
UNION ALL
SELECT 'Pedidos', COUNT(*) FROM pedidos;
```

**Resultado esperado:**
```
+-----------+-------+
| tabla     | total |
+-----------+-------+
| Clientes  |     3 |
| Productos |     5 |
| Pedidos   |     3 |
+-----------+-------+
```

---

## 📈 Datos de Prueba por Tabla

### CATEGORIAS
- Electrónica
- Ropa
- Hogar

### CLIENTES
- Juan Pérez (juan@email.com)
- María González (maria@email.com)
- Carlos López (carlos@email.com)

### PRODUCTOS
- Laptop Dell - $799.99
- Mouse Inalámbrico - $29.99
- Camiseta Polo - $19.99
- Pantalón Jeans - $39.99
- Lámpara LED - $45.00

### PEDIDOS
- Pedido #1: Juan Pérez - $829.98 (Completado)
- Pedido #2: María González - $59.98 (Pendiente)
- Pedido #3: Carlos López - $45.00 (Enviado)

---

## ⚠️ Consideraciones Importantes

### Orden de Inserción

Es crucial insertar datos respetando las **claves foráneas**:

1. ✅ Primero: `categorias` y `clientes` (sin dependencias)
2. ✅ Segundo: `productos` (depende de categorias)
3. ✅ Tercero: `pedidos` (depende de clientes)
4. ✅ Cuarto: `detalle_pedidos` (depende de pedidos y productos)
5. ✅ Quinto: `metodos_pago` (depende de pedidos)

### Restricciones a Considerar

- **Email único:** No se puede insertar dos clientes con el mismo email
- **Stock:** Debe ser mayor o igual a 0
- **Precio:** Debe ser mayor que 0
- **Claves foráneas:** Deben referenciar registros existentes

---

## 🛠️ Operaciones Adicionales

### Insertar Múltiples Registros
```sql
INSERT INTO clientes (nombre, email, direccion, telefono) VALUES
('Ana Silva', 'ana@email.com', 'Calle Luna 111', '555-0004'),
('Pedro Ruiz', 'pedro@email.com', 'Av. Sol 222', '555-0005'),
('Laura Díaz', 'laura@email.com', 'Plaza Mar 333', '555-0006');
```

### Actualizar Múltiples Registros
```sql
UPDATE productos 
SET precio = precio * 0.9  -- 10% de descuento
WHERE id_categoria = 2;     -- Solo en categoría Ropa
```

### Eliminar con Condiciones
```sql
DELETE FROM pedidos 
WHERE estado = 'Cancelado' 
AND fecha_pedido < '2024-01-01';
```

---

## 🔄 Transacciones 

Para operaciones críticas, usar transacciones:

```sql
START TRANSACTION;

INSERT INTO pedidos (id_cliente, total, estado) 
VALUES (1, 100.00, 'Pendiente');

INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad, precio_unitario)
VALUES (LAST_INSERT_ID(), 1, 1, 100.00);

COMMIT;  -- Confirmar cambios
-- ROLLBACK;  -- Revertir cambios si hay error
```

---

## 📊 Estadísticas de los Datos

```sql
-- Total de productos por categoría
SELECT c.nombre, COUNT(p.id_producto) AS total_productos
FROM categorias c
LEFT JOIN productos p ON c.id_categoria = p.id_categoria
GROUP BY c.id_categoria, c.nombre;

-- Total de pedidos por estado
SELECT estado, COUNT(*) AS cantidad
FROM pedidos
GROUP BY estado;

-- Cliente con más pedidos
SELECT c.nombre, COUNT(p.id_pedido) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre
ORDER BY total_pedidos DESC
LIMIT 1;
```

---

## ✅ Checklist de Verificación

- [ ] Datos insertados en todas las tablas
- [ ] No hay errores de clave foránea
- [ ] No hay violaciones de restricción UNIQUE
- [ ] Operaciones UPDATE funcionan correctamente
- [ ] Operaciones DELETE están comentadas (seguridad)
- [ ] Los totales de pedidos coinciden con los detalles
- [ ] Todos los productos tienen categoría válida

---

## 🐛 Solución de Problemas

### Error: "Duplicate entry for key 'email'"
**Solución:** Verificar que no se está insertando emails duplicados

### Error: "Cannot add or update a child row"
**Solución:** La clave foránea referencia un registro inexistente. Verificar que el ID exista.

### Error: "Data too long for column"
**Solución:** El texto excede el VARCHAR definido. Acortar el texto o aumentar el tamaño de la columna.

---

## 🔒 Mejores Prácticas

1. ✅ Siempre usar transacciones para operaciones múltiples
2. ✅ Comentar los DELETE en producción
3. ✅ Validar datos antes de INSERT
4. ✅ Usar WHERE específicos en UPDATE/DELETE
5. ✅ Hacer backups antes de operaciones masivas

---
